FROM gitpod/workspace-full

# Install Redis.
RUN sudo apt-get update \
 && sudo apt-get install -y \
  redis-server libvips \
 && sudo rm -rf /var/lib/apt/lists/*

# Install Ruby 3.2.0
RUN _ruby_version=ruby-3.2.0 \
    && printf "rvm_gems_path=/home/gitpod/.rvm\n" > ~/.rvmrc \
    && bash -lc "rvm reinstall ruby-${_ruby_version} && rvm use ruby-${_ruby_version} --default && gem install rails" \
    && printf "rvm_gems_path=/workspace/.rvm" > ~/.rvmrc \
    && printf '{ rvm use $(rvm current); } >/dev/null 2>&1\n' >> "$HOME/.bashrc.d/70-ruby"
