Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D08C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560B21902
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="1O6ucJSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCWAJm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:09:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCWAJm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:09:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so2574865pgq.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+JyymScM13znHTHWeH6N1Q3QEl8vX+qYLEcqNPrhAM=;
        b=1O6ucJSkA5TmWZ99A5O9cwG/U1l0hVgE+XxTontvTz6topHbjli+eCxZe9VR+AAz9j
         TdKL5bcd89USSIf9gi1/NvfspfCUXQjX5kscI6Vh5yH72ZVOPhyzXK70FqEDAKwV16dy
         8nZaXvNejRXVy5YnCGa0jB37/qNuBGxZsWHi6O7jP2zMIEhCSZwrgTgcBYQabisAPrmI
         XU9/ErCugdEt9sVI7MLpjqrf3OaO6dmQ3POI+xTyFM/ToxCePV+K86JRQChn5oOYTcpG
         JDoT+uo+ZlNAtyZKXitBmnjM45F9/rSc+6ka64427zOx3rm/OgJCVDPyXzaW3cVXPL1G
         7Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+JyymScM13znHTHWeH6N1Q3QEl8vX+qYLEcqNPrhAM=;
        b=qnPjYXCfA/3VRIhXRUFpcTL3C2U+Vr7uMGphurlrto6n4C2/RJuS61xUDYEF3JwmPD
         HidKqD4Fgkk/wB1cvKFj5RwevwY5f9eZvQ63+jmRNDdcHcgHpiPknQ4aV/7131bF+UaT
         owW6fIS3mKG8+1Q+AuXSZyooxCiyltujL6JFgMRrlTf9bSkKT/LynrlK12J6R0fj+GtR
         utEs8p+Hh3l/22bThosHtB0HIpoEEOkR3fvDfbXqBTAz1HUjL6hl1UYpScXFTNXVL2dH
         MP5tIkHP0AylkcvA37w6YD+b9YDtKx1ACiatb19NWFXfmoSXucnIF/jiW8ZJL7mhZEZ1
         e8Sg==
X-Gm-Message-State: APjAAAUGt2BWt3cmYJ22SkvyRY79BkaNbPihY7q3566qK8YWOhchRbTO
        s/l5RxSRyppqR30Eqbr0vcIDVw==
X-Google-Smtp-Source: APXvYqzrRjhNtS6JaoxEE6ik1nUKb1HS/EYmEeU8zFACWVcn3vp1iLtJvIymcEj2AUTH1u3GYSRJFw==
X-Received: by 2002:a63:5405:: with SMTP id i5mr7726027pgb.212.1553299780848;
        Fri, 22 Mar 2019 17:09:40 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d25sm5525913pfn.152.2019.03.22.17.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:09:39 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:09:38 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, sdf@google.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, libbpf: fix version info and add it to
 shared object
Message-ID: <20190323000938.GV7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322234755.29306-1-daniel@iogearbox.net>
 <20190322234755.29306-2-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322234755.29306-2-daniel@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Daniel Borkmann wrote:
> Even though libbpf's versioning script for the linker (libbpf.map)
> is pointing to 0.0.2, the BPF_EXTRAVERSION in the Makefile has
> not been updated along with it and is therefore still on 0.0.1.
> 
> While fixing up, I also noticed that the generated shared object
> versioning information is missing, typical convention is to have
> a linker name (libbpf.so), soname (libbpf.so.0) and real name
> (libbpf.so.0.0.2) for library management. This is based upon the
> LIBBPF_VERSION as well.
> 
> The build will then produce the following bpf libraries:
Thank you for taking care of this! Couple of nits/questions below.

> 
>   # ll libbpf*
>   libbpf.a
>   libbpf.so -> libbpf.so.0.0.2
>   libbpf.so.0 -> libbpf.so.0.0.2
>   libbpf.so.0.0.2
> 
> And the they are also properly installed:
> 
>   # rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld install
> 
>   Auto-detecting system features:
>   ...                        libelf: [ on  ]
>   ...                           bpf: [ on  ]
> 
>     CC       /tmp/bld/libbpf.o
>     CC       /tmp/bld/bpf.o
>     CC       /tmp/bld/nlattr.o
>     CC       /tmp/bld/btf.o
>     CC       /tmp/bld/libbpf_errno.o
>     CC       /tmp/bld/str_error.o
>     CC       /tmp/bld/netlink.o
>     CC       /tmp/bld/bpf_prog_linfo.o
>     CC       /tmp/bld/libbpf_probes.o
>     CC       /tmp/bld/xsk.o
>     LD       /tmp/bld/libbpf-in.o
>     LINK     /tmp/bld/libbpf.a
>     LINK     /tmp/bld/libbpf.so.0.0.2
>     LINK     /tmp/bld/test_libbpf
>     INSTALL  /tmp/bld/libbpf.a
>     INSTALL  /tmp/bld/libbpf.so.0.0.2
> 
>   # ll /usr/local/lib64/libbpf.*
>   /usr/local/lib64/libbpf.a
>   /usr/local/lib64/libbpf.so -> libbpf.so.0.0.2
>   /usr/local/lib64/libbpf.so.0 -> libbpf.so.0.0.2
>   /usr/local/lib64/libbpf.so.0.0.2
> 
> Fixes: 1bf4b05810fe ("tools: bpftool: add probes for eBPF program types")
> Fixes: 1b76c13e4b36 ("bpf tools: Introduce 'bpf' library and add bpf feature check")
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/Makefile | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 61aaacf..ada2e90a9 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -3,7 +3,7 @@
>  
>  BPF_VERSION = 0
>  BPF_PATCHLEVEL = 0
> -BPF_EXTRAVERSION = 1
> +BPF_EXTRAVERSION = 2
>  
>  MAKEFLAGS += --no-print-directory
>  
> @@ -79,8 +79,6 @@ export prefix libdir src obj
>  libdir_SQ = $(subst ','\'',$(libdir))
>  libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>  
> -LIB_FILE = libbpf.a libbpf.so
> -
>  VERSION		= $(BPF_VERSION)
>  PATCHLEVEL	= $(BPF_PATCHLEVEL)
>  EXTRAVERSION	= $(BPF_EXTRAVERSION)
> @@ -88,7 +86,10 @@ EXTRAVERSION	= $(BPF_EXTRAVERSION)
>  OBJ		= $@
>  N		=
>  
> -LIBBPF_VERSION = $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
> +LIBBPF_VERSION	= $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
> +
> +LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
> +LIB_FILE	= libbpf.a libbpf.so*
>  
>  # Set compile option CFLAGS
>  ifdef EXTRA_CFLAGS
> @@ -128,16 +129,18 @@ all:
>  export srctree OUTPUT CC LD CFLAGS V
>  include $(srctree)/tools/build/Makefile.include
>  
> -BPF_IN    := $(OUTPUT)libbpf-in.o
> -LIB_FILE := $(addprefix $(OUTPUT),$(LIB_FILE))
> -VERSION_SCRIPT := libbpf.map
> +BPF_IN		:= $(OUTPUT)libbpf-in.o
> +VERSION_SCRIPT	:= libbpf.map
> +
> +LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
> +LIB_FILE	:= $(addprefix $(OUTPUT),$(LIB_FILE))
>  
>  GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
>  			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {s++} END{print s}')
>  VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
>  			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>  
> -CMD_TARGETS = $(LIB_FILE)
> +CMD_TARGETS = $(LIB_TARGET)
>  
>  CXX_TEST_TARGET = $(OUTPUT)test_libbpf
>  
> @@ -170,9 +173,13 @@ $(BPF_IN): force elfdep bpfdep
>  	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
>  	$(Q)$(MAKE) $(build)=libbpf
>  
> -$(OUTPUT)libbpf.so: $(BPF_IN)
> -	$(QUIET_LINK)$(CC) --shared -Wl,--version-script=$(VERSION_SCRIPT) \
> -		$^ -o $@
> +$(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
> +
> +$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
> +	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_VERSION) \
Shouldn't it be -soname,libbpf.so.$(VERSION) ?

> +				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
> +	@ln -sf $(@F) $(OUTPUT)libbpf.so
> +	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
>  
>  $(OUTPUT)libbpf.a: $(BPF_IN)
>  	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
> @@ -192,6 +199,12 @@ check_abi: $(OUTPUT)libbpf.so
>  		exit 1;							 \
>  	fi
>  
> +define do_install_mkdir
> +	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
> +	fi
> +endef
> +
>  define do_install
>  	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
> @@ -200,8 +213,9 @@ define do_install
>  endef
>  
>  install_lib: all_cmd
> -	$(call QUIET_INSTALL, $(LIB_FILE)) \
> -		$(call do_install,$(LIB_FILE),$(libdir_SQ))
> +	$(call QUIET_INSTALL, $(LIB_TARGET)) \
> +		$(call do_install_mkdir,$(libdir_SQ)); \
> +		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
>  
>  install_headers:
>  	$(call QUIET_INSTALL, headers) \
> @@ -219,7 +233,7 @@ config-clean:
>  
>  clean:
>  	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
> -		*.o *~ *.a *.so .*.d .*.cmd LIBBPF-CFLAGS
> +		*.o *~ *.a *.so *.so.$(VERSION) .*.d .*.cmd LIBBPF-CFLAGS
What about libbpf.so.$(LIBBPF_VERSION) ?

>  	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
>  
>  
> -- 
> 2.9.5
> 
