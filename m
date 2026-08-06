Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87047F788
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048420; cv=none; b=peMFQDsGeLi6BWnl3A2nyKizUFISST/XCaeZ93ISYjrLnp7vFqxPp/VHLD4lTTJ+m/35iwFehFLZjzydAdFmec8t6YPv/PFdC7PC4/hddbkn7tcXIL7j+ajyxv0sXGqTd6bHc13F/Dc7VEO4SOJhKV32E4ynlojDt/HIXdB9wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048420; c=relaxed/simple;
	bh=dw+GY6/HPrn7SdKFhf5hhYtXZMuWgnFA9FB9qbGGED8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNBYcHE06+PYj7hjflrSuLdU6BUy1rj7oki/fwhA5Q2otlCWRJ8xIRfuQXEc1nX+/5Z8ZKXqoawAYCOBtovrVvRrWr3e82d/JcTDAJIYazic8GtrFRQVzZd/utEVuoD8kkxmy41OISp6wya97OwXIikUtL0jl4ghCPGj1GfLUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BsCPcDjE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BsCPcDjE"
Message-ID: <7cb9e702-9fe0-4672-a6de-7619562cde21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786048405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0olaPV6sfveLTm+8kCKxJgkQ6YSt65IwoLcmZ7nQvJ4=;
	b=BsCPcDjEhw/Cp9uH5uJGZA3aCYnU7jKn/99lAt+VibZntcTcPIK4dC+W8j6vkXsofXpFKr
	gjehqWoTqcscLLqf6wS/htkVm29H8tw8Ynpld5upT8FNGdTXdrfaa1bElBUbn7wGobNQTl
	BtZgKseKrV5Q5pbghYg8rmkghKTJmnY=
Date: Thu, 6 Aug 2026 13:33:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] selftests/bpf: Route libarena build artifacts to
 OUTPUT
To: =?UTF-8?B?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <20260728-selftests-bpf_oot-v1-2-05feb15d94db@marliere.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260728-selftests-bpf_oot-v1-2-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/28/26 5:06 PM, Ricardo B. MarliÃ¨re (SUSE) wrote:
> libarena's BPF objects, linked objects, and skeleton headers are always
> written into the source tree regardless of whether an out-of-tree build
> directory was specified via O=.
> 
> Add OUTPUT support to libarena/Makefile: default OUTPUT to '.' for
> standalone builds, prefix all generated file targets with $(OUTPUT)/, and
> use addprefix to propagate the directory into the per-object lists. Create
> $(OUTPUT) at Makefile-load time with a $(shell mkdir -p) so all rules have
> a valid destination.
> 
> In the parent bpf/Makefile, pass OUTPUT="$(OUTPUT)/libarena" in
> LIBARENA_MAKE_ARGS and update LIBARENA_SKEL/LIBARENA_ASAN_SKEL to reflect
> the new location. Pass the absolute target path as the make goal so the
> sub-make goal matches the $(OUTPUT)/... rule in libarena/Makefile
> regardless of the invocation directory.
> 
> Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
> ---
>  tools/testing/selftests/bpf/Makefile          | 11 ++++++-----
>  tools/testing/selftests/bpf/libarena/Makefile | 24 ++++++++++++++----------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b289183475d4..7d42632f9d42 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -826,7 +826,8 @@ LIBARENA_MAKE_ARGS = \
>  		CLANG="$(CLANG)" \
>  		BPF_CFLAGS="$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
>  		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
> -		Q="$(Q)"
> +		Q="$(Q)" \
> +		OUTPUT="$(OUTPUT)/libarena"
>  
>  LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
>  				 libarena/include/*		\
> @@ -835,17 +836,17 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
>  				 libarena/selftests/*		\
>  				 libarena/*.bpf.o)
>  
> -LIBARENA_SKEL := libarena/libarena.skel.h
> +LIBARENA_SKEL := $(OUTPUT)/libarena/libarena.skel.h
>  
>  $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
> -	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> +	+$(MAKE) -C libarena $(LIBARENA_SKEL) $(LIBARENA_MAKE_ARGS)
>  
>  ifneq ($(CLANG_HAS_ARENA_ASAN),)
> -LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
> +LIBARENA_ASAN_SKEL := $(OUTPUT)/libarena/libarena_asan.skel.h
>  CFLAGS += -DHAS_BPF_ARENA_ASAN
>  
>  $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
> -	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
> +	+$(MAKE) -C libarena $(LIBARENA_ASAN_SKEL) $(LIBARENA_MAKE_ARGS)
>  endif
>  
>  # Define test_progs test runner.
> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
> index 5e2ab514805e..195d5f833186 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -27,10 +27,14 @@ BPFDIR=$(abspath $(LIBARENA)/..)
>  INCLUDE_DIR ?= $(BPFDIR)/tools/include
>  LIBBPF_INCLUDE ?= $(INCLUDE_DIR)
>  
> +# Build output directory; defaults to in-tree for standalone builds.
> +OUTPUT ?= .
> +$(shell mkdir -p $(OUTPUT))

This runs while make parses the file, including under make -n, and
discards mkdir's status. Let's create $(OUTPUT) via order-only
directory prereq instead.

> +
>  # Scan src/ and selftests/ to generate the final binaries
>  LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
> -LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
> -LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o))
> +LIBARENA_OBJECTS = $(addprefix $(OUTPUT)/,$(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o)))
> +LIBARENA_OBJECTS_ASAN = $(addprefix $(OUTPUT)/,$(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o)))
>  
>  INCLUDES = -I$(LIBARENA)/include -I$(BPFDIR)
>  ifneq ($(INCLUDE_DIR),)
> @@ -61,32 +65,32 @@ CFLAGS += $(INCLUDES)
>  vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
>  vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
>  
> -skeletons: libarena.skel.h libarena_asan.skel.h
> +skeletons: $(OUTPUT)/libarena.skel.h $(OUTPUT)/libarena_asan.skel.h
>  .PHONY: skeletons
>  
> -libarena_asan.skel.h: libarena_asan.bpf.o
> +$(OUTPUT)/libarena_asan.skel.h: $(OUTPUT)/libarena_asan.bpf.o
>  	$(call msg,GEN-SKEL,libarena,$@)
>  	$(Q)$(BPFTOOL) gen skeleton $< name "libarena_asan" > $@
>  
> -libarena.skel.h: libarena.bpf.o
> +$(OUTPUT)/libarena.skel.h: $(OUTPUT)/libarena.bpf.o
>  	$(call msg,GEN-SKEL,libarena,$@)
>  	$(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
>  
> -libarena_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
> +$(OUTPUT)/libarena_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
>  	$(call msg,GEN-OBJ,libarena,$@)
>  	$(Q)$(BPFTOOL) gen object $@ $^
>  
> -libarena.bpf.o: $(LIBARENA_OBJECTS)
> +$(OUTPUT)/libarena.bpf.o: $(LIBARENA_OBJECTS)
>  	$(call msg,GEN-OBJ,libarena,$@)
>  	$(Q)$(BPFTOOL) gen object $@ $^
>  
> -%_asan.bpf.o: %.bpf.c
> +$(OUTPUT)/%_asan.bpf.o: %.bpf.c
>  	$(call msg,CLNG-BPF,libarena,$@)
>  	$(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_TARGET_ENDIAN) -c $< -o $@
>  
> -%.bpf.o: %.bpf.c
> +$(OUTPUT)/%.bpf.o: %.bpf.c
>  	$(call msg,CLNG-BPF,libarena,$@)
>  	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
>  
>  clean:
> -	$(Q)rm -f *.skel.h *.bpf.o *.linked*.o
> +	$(Q)rm -f $(OUTPUT)/*.skel.h $(OUTPUT)/*.bpf.o $(OUTPUT)/*.linked*.o
> 

