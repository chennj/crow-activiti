package net.crow.activiti.track.plugin.redisson.config;

import org.redisson.config.Config;

@FunctionalInterface
public interface RedissonAutoConfigurationCustomizer {

    /**
     * Customize the RedissonClient configuration.
     * @param configuration the {@link Config} to customize
     */
    void customize(final Config configuration);
}