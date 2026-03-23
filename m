Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB37649D
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306258; cv=none; b=eh7hd352ZO2Jt9rqJNaZnSolaJmLNBR2KTJsCLsTuiyaz9lPI3icQt4/LsQjmcdTFgJzyY/8Zbjocj12PQb9JxwUeicb1+7/L9ioKjw73wnw1pqNOgkvtl24JbZBwRNAC878JXunX/X6zLin5F4FzqR6pjsae3L0wyo/xA0EnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306258; c=relaxed/simple;
	bh=u5HO0Gr5cs32w+Pck799DzAmoCUrRAsgtsG42XKv5RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCj2dw10NxopG7uxCQ59k5oc0O6JixAk9p+HGP3FFLIhvPSM58XcD6/7fHCBGfjf7xK20JBT0s1zVy4e5IIXoQ8bpkbIs8HUpR2apNagRtb4cFGbiqJ3liRwib4RVzYhU06J1cybAp4jjS4rvOC3KDvlI6+5DWuqmCqwbtXdoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EdMHs6hj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EdMHs6hj"
Message-ID: <11402a16-d675-4957-83fb-703082b070e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774306245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TgKBPmRhcJgMaORlFuSIbnAMIo0QRaXhfhdWogPNSs=;
	b=EdMHs6hjlFmHZ2M0HfbjMKvI3NfLLJPfmjIgNrUVwYuKaKcCq2PJ7tzJu/6VwpJkFrcXUA
	v2WUi9Z2xCbyEIUcq9yDPOipdhL3wG2OQsIgsuDrTXQCCpZbiQ+dBkxQJQOnp0KGcnHYEB
	aHYHWGDO0we2050Y+VSv34otK1UBGdQ=
Date: Mon, 23 Mar 2026 15:50:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] libbpf: Initialize CFLAGS before including
 Makefile.include
To: Leo Yan <leo.yan@arm.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
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
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
 <20260323-tools_build_fix_zero_init_bpf_only-v1-3-d1cfad2f4cd1@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260323-tools_build_fix_zero_init_bpf_only-v1-3-d1cfad2f4cd1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/23/26 8:40 AM, Leo Yan wrote:
> tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
> change.  This could alter the initialization of CFLAGS, as the default
> options "-g -O2" would never be set once EXTRA_CFLAGS is expanded.
> 
> Prepare for this by moving the CFLAGS initialization before including
> tools/scripts/Makefile.include, so it is not affected by the extended
> EXTRA_CFLAGS.
> 
> Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
> place it last so that the extra flags propagate properly and can
> override the default options.
> 
> tools/scripts/Makefile.include already appends $(CLANG_CROSS_FLAGS) to
> CFLAGS, the Makefile appends $(CLANG_CROSS_FLAGS) again, remove the
> redundant append.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/lib/bpf/Makefile | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e6461bd06db40e23d21a3fb8847ccbf4..eca584fb061e16013e76827e4203f6be0477a73e 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -49,6 +49,14 @@ man_dir_SQ = '$(subst ','\'',$(man_dir))'
>  export man_dir man_dir_SQ INSTALL
>  export DESTDIR DESTDIR_SQ
>  
> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
> +ifdef EXTRA_CFLAGS
> +  CFLAGS :=
> +else
> +  CFLAGS := -g -O2
> +endif
> +
>  include $(srctree)/tools/scripts/Makefile.include
>  
>  # copy a bit from Linux kbuild
> @@ -70,13 +78,6 @@ LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
>  LIB_FILE	= libbpf.a libbpf.so*
>  PC_FILE		= libbpf.pc
>  
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS := $(EXTRA_CFLAGS)
> -else
> -  CFLAGS := -g -O2
> -endif
> -
>  # Append required CFLAGS
>  override CFLAGS += -std=gnu89
>  override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
> @@ -84,7 +85,7 @@ override CFLAGS += -Werror -Wall
>  override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
> -override CFLAGS += $(CLANG_CROSS_FLAGS)
> +override CFLAGS += $(EXTRA_CFLAGS)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  
>  # flags specific for shared library
>  SHLIB_FLAGS := -DSHARED -fPIC
> 

