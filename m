Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E1385D9B;
	Fri, 17 Jul 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293004; cv=none; b=bVAzPzV+GGmQ8F5wZc0m3TyZbRxss1oc2Du1wZKiFem1tsoyzgE9BkpHd7SXoeanxJ//2PQ8SDidKn0r6M6HxBnIXQixQld6SzUaysYztMsc+ISni0SKFxVpHzlsMsn/lWMZkUORYL/4DYMqrqj9f3PoiV8fs3C7YFnr0T5xU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293004; c=relaxed/simple;
	bh=brIhlY1cbIss4kQg0f32ia/AQYs16hsUdElR2BvxkpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI5qxm/6uCVpzMQqJGx8krx+e0cIstOOSPmNDCctT2+ys4y1Hz6xox3vPqARBkbekOVBdFXjtN7eyIrrMTD0ObFSjxlHUrspwKigJn9AAVIkZxLnGpml5TCBLUkfg7rpP0lM4ukQLs1QDvkd5QonCURMezNIEkX9hZQ5WN/aC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wkhs1-00000000q3K-25zz;
	Fri, 17 Jul 2026 14:40:49 +0200
Date: Fri, 17 Jul 2026 14:40:47 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Florian Schmaus via B4 Relay <devnull+flo.geekplace.eu@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Florian Schmaus <flo@geekplace.eu>
Subject: Re: [PATCH] selftests: do not preserve ownership when installing
 files with rsync
Message-ID: <aloiz8LyEDprnVeL@nb282.user.codasip.com>
References: <20260715-kselftest-rsync-right-v1-1-8df6c7734389@geekplace.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-kselftest-rsync-right-v1-1-8df6c7734389@geekplace.eu>

Thus wrote Florian Schmaus via B4 Relay (devnull+flo.geekplace.eu@kernel.org):

> From: Florian Schmaus <flo@geekplace.eu>

> When kselftests are built and installed using "make install" or
> integrated into other build systems (such as Yocto's "devtool
> modify"), the source tree might be owned by a non-root developer user.

> Because the installation scripts use "rsync -a", which implies -o and
> -g, the installed test binaries and scripts are explicitly assigned
> the UID/GID of the source tree owner instead of the user running the
> install command. This results in UID leaks into the root filesystem.

> Fix this by explicitly adding --no-owner --no-group to all rsync
> invocations across the selftests Makefiles so that the installed files
> are owned by the installing user (typically root).

> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  tools/testing/selftests/bpf/Makefile     | 6 +++---
>  tools/testing/selftests/futex/Makefile   | 2 +-
>  tools/testing/selftests/lib.mk           | 8 ++++----
>  tools/testing/selftests/sparc64/Makefile | 2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b642ee489ea6..1ff923eab76b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -781,7 +781,7 @@ $(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
>  $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
>  ifneq ($2:$(OUTPUT),:$(shell pwd))
>  	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
> -	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $$^ $(TRUNNER_OUTPUT)/
> +	$(Q)rsync -aq --no-owner --no-group $(if $(PERMISSIVE),--ignore-missing-args) $$^ $(TRUNNER_OUTPUT)/
>  endif

>  # some X.test.o files have runtime dependencies on Y.bpf.o files
> @@ -1048,7 +1048,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
>  ifneq ($(PERMISSIVE),)
>  override define INSTALL_SINGLE_RULE
>  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
> -	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
> +	$(if $(INSTALL_LIST),rsync -a --no-owner --no-group --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
>  endef
>  endif

> @@ -1057,7 +1057,7 @@ override define INSTALL_RULE
>  	$(DEFAULT_INSTALL_RULE)
>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
> -		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
> +		rsync -a --no-owner --no-group $(if $(PERMISSIVE),--ignore-missing-args)	  \
>  			$(OUTPUT)/$$DIR/*.bpf.o				  \
>  			$(INSTALL_PATH)/$$DIR;				  \
>  	done
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index 78ab2cd111f6..c59f40b837e8 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -11,7 +11,7 @@ all:
>  		mkdir $$BUILD_TARGET  -p;	\
>  		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
>  		if [ -e $$DIR/$(TEST_PROGS) ]; then \
> -			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
> +			rsync -a --no-owner --no-group $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
>  		fi \
>  	done

> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index f02cc8a2e4ae..aedcee1c04c6 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -122,14 +122,14 @@ define INSTALL_INCLUDES
>  			fi; \
>  			relative_files="$$relative_files $$relative_dir/$$entry_name"; \
>  		done; \
> -		cd $(SRC_PATH) && rsync -aR $$relative_files $(OBJ_PATH)/ \
> +		cd $(SRC_PATH) && rsync -aR --no-owner --no-group $$relative_files $(OBJ_PATH)/ \
>  	)
>  endef

>  run_tests: all
>  ifdef building_out_of_srctree
>  	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS_DIR)" != "X" ]; then \
> -		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
> +		rsync -aq --no-owner --no-group --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
>  	fi
>  	@$(INSTALL_INCLUDES)
>  	@if [ "X$(TEST_PROGS)" != "X" ]; then \
> @@ -150,12 +150,12 @@ clean_mods_dir:

>  define INSTALL_SINGLE_RULE
>  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
> -	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
> +	$(if $(INSTALL_LIST),rsync -a --no-owner --no-group --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
>  endef

>  define INSTALL_MODS_RULE
>  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH)/$(INSTALL_LIST))
> -	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST)/*.ko $(INSTALL_PATH)/$(INSTALL_LIST))
> +	$(if $(INSTALL_LIST),rsync -a --no-owner --no-group --copy-unsafe-links $(INSTALL_LIST)/*.ko $(INSTALL_PATH)/$(INSTALL_LIST))
>  endef

>  define INSTALL_RULE
> diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
> index 88f7be76f962..001b68e6354b 100644
> --- a/tools/testing/selftests/sparc64/Makefile
> +++ b/tools/testing/selftests/sparc64/Makefile
> @@ -25,7 +25,7 @@ all:
>  		#SUBDIR test prog name should be in the form: SUBDIR_test.sh \
>  		TEST=$$DIR"_test.sh"; \
>  		if [ -e $$DIR/$$TEST ]; then \
> -			rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
> +			rsync -a --no-owner --no-group $$DIR/$$TEST $$BUILD_TARGET/; \
>  		fi \
>  	done


> ---
> base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
> change-id: 20260715-kselftest-rsync-right-a57bf0e85190

> Best regards,
> --  
> Florian Schmaus <flo@geekplace.eu>

Looks good to me.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
