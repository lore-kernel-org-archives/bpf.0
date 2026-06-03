Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A8385535;
	Wed,  3 Jun 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478526; cv=none; b=tyhP4/6T+KRMKp00GAV++i4P6t0VUb5IihizpDUxDLqB1RgrTgittgEyj8Cl0L6WonKkQA5ZXBFHyLQS3sPxymebNOf836Y2DhnPuvp+y67kXfi8LdPQUuKE4Sx/FA2wec4ILuHhHqAfVZzPACn1wUEQBVME0s5vv3tnxKIPX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478526; c=relaxed/simple;
	bh=LdQejOz1IAnEcJAOumKNKrxcqY2PK3y43OQ3sjX7IAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiOhKLvKTwlCkhLPT6Pp9twzNAUEMW+KS/FwtxGgiEhXXaCG9ne+ucM9EzuP6edk4HReta2fbXyLZIle0UekA2JcaKcM0VrgVGPYbzXVjtXMyJXd4wUtHazp2TW/5udk6PIlpFqrDWyOzFkWDgSR4n+Itc/XVmm6aphHn4cXSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS7eDG/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS7eDG/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260E1F00893;
	Wed,  3 Jun 2026 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478523;
	bh=9KPpHmif7uT13SYzZOScP8ZXHj+daUOWD5CJb4ZWcmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MS7eDG/GouIHIPQmW7/3M1HBKF/aNNJDtbfrd9i4qhasluoLq2Dp+W9bfux3IkQIl
	 y+myZ+HGUtT391bfB0nWl/7ZzmDY6sd05KY7T6v3jZ3Me1W3/fTkUstxiIXqSNRI7j
	 lxYUkNQJ1hWHKqbVPkBbHel3ogjxnu0zzq1XITJItbCI5RpCrtKrc2FL/Zg7LCWRaa
	 JLDfxNFtfslLUD+WRb9eYrgTCmQJxYXtTPM8G7AE2/YIQOmFWygczVhjALYqggjusn
	 v80J9YaCM7zAajSejmfLDRyqj8JCg1ZLOYBybe0mmvPYnCXA6VkfvtPiBM0V9DVkhR
	 B0lCZivckwzQg==
Message-ID: <2b72da46-bf83-406f-bf5b-022f8e0ac04f@kernel.org>
Date: Wed, 3 Jun 2026 10:21:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/8] bpftool: Pass host flags to bootstrap
 libbpf
To: Leo Yan <leo.yan@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
 <20260602-tools_build_fix_zero_init_bpf_only-v2-1-c76e5250ea1c@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-1-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-02 15:47 UTC+0100 ~ Leo Yan <leo.yan@arm.com>
> bpftool builds a bootstrap libbpf with HOSTCC, but the libbpf submake can
> still inherit target build flags through CFLAGS. This can break cross
> builds when host objects are compiled with target-only options.
> 
> Since HOST_CFLAGS contains warning options that are not suitable for
> building libbpf, use LIBBPF_BOOTSTRAP_CFLAGS with the warning options
> removed to build the bootstrap libbpf. Clear EXTRA_CFLAGS so target
> extra flags are not mixed into the host bootstrap libbpf build.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 0febf60e1b64656035dfe93cd15cba090015587a..1f033e578f90a2d6b93168ab41399de758bdf659 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -47,7 +47,8 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
>  $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
>  	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
>  		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR:/=) prefix= \
> -		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" $@ install_headers
> +		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> +		CFLAGS="$(LIBBPF_BOOTSTRAP_CFLAGS)" EXTRA_CFLAGS= $@ install_headers
>  
>  $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
>  	$(call QUIET_INSTALL, $@)
> @@ -92,6 +93,9 @@ HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
>  		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>  HOST_LDFLAGS := $(LDFLAGS)
>  
> +# Remove warnings for libbpf bootstrap build

Nitpick: We could expand this comment to briefly explain why. Not sure
it's worth a respin, though.

> +LIBBPF_BOOTSTRAP_CFLAGS := $(filter-out -W -Wall -Wextra -Wformat -Wformat-signedness,$(HOST_CFLAGS))

Do we need to remove all warnings, or would it be sufficient to take out
-Wformat and -Wformat-signedness? I don't mind removing them all if
necessary, just asking.

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!
