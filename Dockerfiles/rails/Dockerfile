FROM pochi-infra

# ruby
USER root
RUN yum -y -q update
RUN yum -y -q install gcc zlib-devel openssl-devel sqlite sqlite-devel mysql-devel readline-devel libffi-devel

ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.4

RUN mkdir -p /usr/src/ruby \
  && curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
    | tar -xjC /usr/src/ruby --strip-components=1 \
  && cd /usr/src/ruby \
  && ./configure --disable-install-doc \
  && make \
  && make install \
  && rm -rf /usr/src/ruby

RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN gem install bundler \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin"

ENV BUNDLE_APP_CONFIG $GEM_HOME

CMD [ "irb" ]

USER ${USER}

# app
# COPY ../../Gemfile ${HOME}
# COPY ../../Gemfile.lock ${HOME}
# RUN bundle install -j4
# 
# COPY ../../ ${HOME}

EXPOSE 3000
#CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
