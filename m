Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C6DC10F03
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667E221929
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="cBlQEOiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCWA2Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:28:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33071 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCWA2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:28:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so2598505pfd.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/WtJKMXp3t5XNtfhYOhHOZET1u1oKHk4lKw82gfH8bg=;
        b=cBlQEOiOKgEwzKOlMqXekVae0FjdTx/fHfolVTxJX4H+1M2wYdw2xHmwbdvnwCWgGB
         /T8HW3S3nzzZaIQNBph7BQnp2ZAZcueXYJKBCZp/DmjjTqoDX31v7zGHqqgCadz7rMiw
         6hhu0epB9YYYXt9fGsBVraL6aiiy1dbF9H7MDGhYFdKxt2r2uDNzRiOqSNnpcSH4BOZr
         WN+EpbIKIHONrBFcQjlnoiH5oVC7jb9kzz/sBjU5RxvLsyZK90wpTH6S+rZi/V+Tt6K8
         RfO30wzWy0t2SMeQam3SLOw05rjG3MPovW+6hNoLJTL0uoARb/h4IdUn8j2d/wf3oYzx
         Bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/WtJKMXp3t5XNtfhYOhHOZET1u1oKHk4lKw82gfH8bg=;
        b=ENHD5yzDNRiBQN+QcCnzJR4r25kseyB9vPTKPIzK1fmLX8cHziYrx8e/uPYdrc1bIf
         5Gp5T3k9pC94q6wI9wgs0nF9sK9Tvh+y9MKkQkSGA1rXMX4OaRVLjkxQa7rSI9IDHi4L
         epFX2qVkVFVjSdPlvBHIRnzDvBQGtrc2MQELQzlTww16JMnIn0kj6w+VN1mEuvtUSW5J
         FT/Ym1v2S/CGgTVTqI6QlFCAeu/26ZvCFz7DOo8zPxYRcf3mR9tqbnmLZ/h0kdfrdyBe
         V8hr6iO17k/chaHokS6UPvDKkknqcXXVOcbN2E0i7CPiT0rTymcG2rhBo5FCHxsKN1ZL
         ehhw==
X-Gm-Message-State: APjAAAVZqwjJgBDCAlqKEUfL679fe4Fls/lFJdwWm72jqwBtiWw4xWks
        m+P5BDc183116fnY38F6wZ0Jdw==
X-Google-Smtp-Source: APXvYqzrZzRYiugN3rzcIpdbcTABr3mKWnisxsqkRrRWSkg1FQ9JViKsxRGlQeVVXNzGwdV/lv2Gtg==
X-Received: by 2002:a62:1d0e:: with SMTP id d14mr11738322pfd.73.1553300894601;
        Fri, 22 Mar 2019 17:28:14 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q86sm24647987pfi.171.2019.03.22.17.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:28:13 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:28:12 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, sdf@google.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, libbpf: fix version info and add it to
 shared object
Message-ID: <20190323002812.GW7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322234755.29306-1-daniel@iogearbox.net>
 <20190322234755.29306-2-daniel@iogearbox.net>
 <20190323000938.GV7431@mini-arch.hsd1.ca.comcast.net>
 <d3d082da-e542-036e-c545-6cde254cda3f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d082da-e542-036e-c545-6cde254cda3f@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Daniel Borkmann wrote:
> On 03/23/2019 01:09 AM, Stanislav Fomichev wrote:
> > On 03/23, Daniel Borkmann wrote:
> [...]
> >> +$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
> >> +	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_VERSION) \
> > Shouldn't it be -soname,libbpf.so.$(VERSION) ?
> 
> The above is generating libbpf.so.0.0.2, and with the below two we generate
> symlinks to it. libbpf.so.$(VERSION) would result in libbpf.so.0 otherwise
> which we want to be a symlink instead. The workflow I've been following is
> similar to fe316723a810 ("tools lib traceevent: Add version for traceevent
> shared object").
Sorry, I was not clear enough, I was talking about -Wl,-soname linker option.
Shouldn't it contain "major" version?

$ readelf -d libtraceevent.so.1.1.0 | grep SONAME
 0x000000000000000e (SONAME)             Library soname: [libtraceevent.so.1]

With your patch applied:
$ readelf -d libbpf.so.0.0.2 | grep SONAME
 0x000000000000000e (SONAME)             Library soname: [libbpf.so.0.0.2]

                                                          ^^^^^^^^^^^^^
							  libbpf.so.0 ?

> 
> >> +				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
> >> +	@ln -sf $(@F) $(OUTPUT)libbpf.so
> >> +	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
> >>  
> >>  $(OUTPUT)libbpf.a: $(BPF_IN)
> >>  	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
> >> @@ -192,6 +199,12 @@ check_abi: $(OUTPUT)libbpf.so
> >>  		exit 1;							 \
> >>  	fi
> >>  
> >> +define do_install_mkdir
> >> +	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
> >> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
> >> +	fi
> >> +endef
> >> +
> >>  define do_install
> >>  	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
> >>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
> >> @@ -200,8 +213,9 @@ define do_install
> >>  endef
> >>  
> >>  install_lib: all_cmd
> >> -	$(call QUIET_INSTALL, $(LIB_FILE)) \
> >> -		$(call do_install,$(LIB_FILE),$(libdir_SQ))
> >> +	$(call QUIET_INSTALL, $(LIB_TARGET)) \
> >> +		$(call do_install_mkdir,$(libdir_SQ)); \
> >> +		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
> >>  
> >>  install_headers:
> >>  	$(call QUIET_INSTALL, headers) \
> >> @@ -219,7 +233,7 @@ config-clean:
> >>  
> >>  clean:
> >>  	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
> >> -		*.o *~ *.a *.so .*.d .*.cmd LIBBPF-CFLAGS
> >> +		*.o *~ *.a *.so *.so.$(VERSION) .*.d .*.cmd LIBBPF-CFLAGS
> > What about libbpf.so.$(LIBBPF_VERSION) ?
> 
> That is already cleaned via $(TARGETS), so this is taken care of.
> 
> >>  	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
> >>  
> >>  
> >> -- 
> >> 2.9.5
> >>
> 
