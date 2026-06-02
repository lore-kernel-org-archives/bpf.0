Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4D3630B3;
	Tue,  2 Jun 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414380; cv=none; b=fBY02Z39uVofQ4bl2hSPg1L05e76MWCf/TL/7dfE+jX66J5oEdZ8tC94vTaz2qsNwfrSH83svXFvHW3VjLQr+aUOmgKAyLT8MSQQ/svxaVwjIdQEtTFM/WIBG9jbPVgAIav24URDnV9WBOUc2bObCadG9tQvTFqY9vtWC8OCvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414380; c=relaxed/simple;
	bh=qWZj9wDod35JKWdK64O6iEeh3krtCED0C0atC1Zavp8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e1ML79/Nj30Ug6tGZKuxUOtIn54Flwbhls5zSiOvATnJCXyqW/+mpxrfM5+MRPe9d2JC9sPhNwbOXnDgHNX3dgeVwdLT/0SdocrMcLK8efMC0NIBA2Aha++lKCLZjTZlO0VK4XCEuivn87rkPb7AlzaGl31zdoLXruJLbk1rYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjCpNF/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjCpNF/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94D1F00893;
	Tue,  2 Jun 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414379;
	bh=M5lcGCjJXwd0FTgXhci5B8olrI0Uwv3Etr/S4xwUmpE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EjCpNF/t5SRuTSrsh6d7hC9UVIcLEgPkdc/Nsws7y1AORV+nFm1tkhtfWm/l8kqyK
	 vTVNpxgSTEwDRJfytFe7G1qWK3wUlf202BwPdEujwIqJYA5qLXvPmgyIKdX8tFjPwl
	 8zI6U92Zw+v+aHSpO2Go3IIcu8Rh639vZAwVLPbT5GhcMxL4fb2mX2WlQLeluq17sY
	 /qorrBwFRL1MfvEjkWD/XoHkumrHu3AfXQbq2TGKRHjGbNa4RcDINpeqXSXHjtVoao
	 uYbl+nVwpqlrKgjz83upkffAduyaIEOH8nSVuFxbWBMG4iSeJmZ5tiAZ4GugAS9tby
	 AmEM+4tk+QZpQ==
Content-Type: multipart/mixed; boundary="===============0092966957812357112=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa5043a681332c349ab2e76637ecf70d6317e2cfb30b29bc3c59cb2ab9785177@mail.kernel.org>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
Subject: Re: [PATCH bpf-next v2 7/8] selftests/bpf: Use common CFLAGS for urandom_read
From: bot+bpf-ci@kernel.org
To: leo.yan@arm.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,lmb@isovalent.com,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: acme@kernel.org,namhyung@kernel.org,irogers@google.com,james.clark@linaro.org,kees@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,leo.yan@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 15:32:58 +0000 (UTC)

--===============0092966957812357112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bc049620c774..1e47e29ba421 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -51,7 +51,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
> -CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
> +COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
>  	  -Wall -Werror -fno-omit-frame-pointer				\
>  	  -Wno-unused-but-set-variable					\
>  	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
> @@ -64,7 +64,7 @@ LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>  PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
>  PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
>  LDLIBS += $(PCAP_LIBS)
> -CFLAGS += $(PCAP_CFLAGS)
> +CFLAGS += $(COMMON_CFLAGS) $(PCAP_CFLAGS)

Ian Rogers raised a concern in v4 that COMMON_CFLAGS is being assigned
before 'include ../lib.mk' (which happens later around line 165).

The ../lib.mk include appends important flags to CFLAGS, such as
-D_GNU_SOURCE=. Since COMMON_CFLAGS uses recursive assignment (=), these
flags added by lib.mk should be available when COMMON_CFLAGS expands.
However, COMMON_CFLAGS references $(GENFLAGS), $(SAN_CFLAGS), and
$(LIBELF_CFLAGS) which are defined before lib.mk, but lib.mk may also
modify CFLAGS directly with additional flags.

Will urandom_read miss any flags that lib.mk adds to CFLAGS but that
aren't captured in the variables referenced by COMMON_CFLAGS? Ian
suggested moving these assignments below the include to ensure all
lib.mk-added flags are captured.

Reference:
https://lore.kernel.org/all/CAP-5=fXjd15e5YpCM9KMjEhpjLxvxc6qUk0g7BprCfkzcRZ5_g@mail.gmail.com/

>
>  # Some utility functions use LLVM libraries
>  jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)

[ ... ]

> @@ -261,7 +261,7 @@ endif
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
>  	$(call msg,LIB,,$@)
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \
>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>  		     -Wno-unused-command-line-argument \
>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \

[ ... ]

> @@ -271,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>  		     -Wno-unused-command-line-argument \
>  		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26828477669
--===============0092966957812357112==--
