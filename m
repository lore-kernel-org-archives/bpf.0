Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9D426EBC;
	Fri,  1 May 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664430; cv=none; b=m91D6GbCxANFP9tUzZnkaLkiNxAvte3S9iQAvb7s88lypa4eWodEM2KOwVr3wJP8WRH4zm2r+qD+85xuGd56rJ6dLXzMZz6UxJ3Y/yqSElW1d6n95RjNXvJIqW7yWcWUzJK45B2NJK/cBqdruviBspI5xHuehO2jtKYGxQ7cTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664430; c=relaxed/simple;
	bh=ksDTsQ1m8PAUrnYyy4nKUYbR4yGlv6yhCUVEu115Ai8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcjofuDvCqfourPtDUMG09MlZeZJ7oiIwSUvGFCRRk8icHf4aqI4YyAJDA2x9ODCPMleMe26aQhRItVhxfShjozZN7hlK2rHU+pro104QMP6LwdaN6fEUHFWAk8g8ZX1gHO7UGEdWvHt+9ZMWNSTjOvRVuO4uTINq5lJ9haeUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saEnMuzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saEnMuzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A10C2BCC4;
	Fri,  1 May 2026 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664430;
	bh=ksDTsQ1m8PAUrnYyy4nKUYbR4yGlv6yhCUVEu115Ai8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=saEnMuzhEYE9f3q8i7jbAGh+DCzkX5TA/XY64ZY9TIdVfKqU1W5sKPmjnXSZeGVii
	 53gvW3YDJ+OEsyVbCUtqLXanvHF3Y6SpxcCM2kwoYRiSsh6jTgkj/3vQsKkCkK0fdn
	 546wDxYf00FmMELCwBNhEx1nfhpEb2wMeIbzWebA7M18c8Hqo2LBg/EerIOc85YvWr
	 hM4s5wJzT0wnYYtS6FFj0+U3ZuU9t7CBLQR6SJX6Y/DJfWKMbeSyZ28EAsaVoOlP9x
	 3vLLanmN7KXGwH9EdgaYzAJDTULechOUp8J4HByGXcUK0gsxP7wqc1M48gMpD6VvM6
	 oxdHqgKeMymUg==
Message-ID: <5a0eb1e1-7175-49b2-ac1a-ee706c06dc3d@kernel.org>
Date: Fri, 1 May 2026 20:40:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Resolve libcrypto link flags via
 pkg-config
To: hadrien Patte <hadrien.patte@protonmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org
References: <20260501175829.9833-1-hadrien.patte@protonmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260501175829.9833-1-hadrien.patte@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-05-01 17:58 UTC+0000 ~ hadrien Patte <hadrien.patte@protonmail.com>
> From: Hadrien Patte <hadrien.patte@protonmail.com>
> 
> When building bpftool with EXTRA_LDFLAGS=-static on Ubuntu 26.04
> (OpenSSL 3.5.5), the link fails because libcrypto.a references
> libjitterentropy symbols, which are not on the link line:
> 
>   LINK     bpftool
>   /usr/bin/ld: libcrypto.a(libdefault-lib-seed_src_jitter.o):
>     in function `ossl_prov_acquire_entropy_from_jitter':
>     (.text+0x11c): undefined reference to `jent_entropy_collector_alloc'
>     (.text+0x130): undefined reference to `jent_read_entropy'
>     (.text+0x13c): undefined reference to `jent_entropy_collector_free'
>   /usr/bin/ld: libcrypto.a(libdefault-lib-seed_src_jitter.o):
>     in function `jitter_instantiate':
>     (.text+0x61c): undefined reference to `jent_entropy_init_ex'
>   collect2: error: ld returned 1 exit status
> 
> The set of transitive dependencies pulled in by libcrypto.a varies
> across distributions and OpenSSL builds (cf. commit 08a749184322
> ("bpftool: Fix dependencies for static build"), which addressed a
> similar libz ordering issue), so hard-coding them in the Makefile is
> fragile.
> 
> Resolve libcrypto's link flags via pkg-config, which knows about
> these transitive deps. Pass --static when the user requested a static
> build via EXTRA_LDFLAGS=-static so pkg-config emits the static link
> line (e.g. "-lcrypto -l:libjitterentropy.a -lz -lzstd -ldl -pthread"
> on Ubuntu 26.04). Fall back to -lcrypto if pkg-config or
> libcrypto.pc is unavailable, preserving the previous behavior on
> minimal build environments.
> 
> Signed-off-by: Hadrien Patte <hadrien.patte@protonmail.com>
> ---
>  tools/bpf/bpftool/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 0febf60e1b64..d9ab860a6cce 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -103,7 +103,17 @@ SKIP_LLVM ?=
>  SKIP_LIBBFD ?=
>  SKIP_CRYPTO ?=
>  ifneq ($(SKIP_CRYPTO),1)
> -  CRYPTO_LIBS := -lcrypto
> +  # Resolve libcrypto link flags via pkg-config so transitive dependencies
> +  # (e.g. libjitterentropy on distros where libcrypto.a references it) are
> +  # included for static builds. Pass --static when the user requested a
> +  # static build via EXTRA_LDFLAGS=-static. Fall back to -lcrypto if
> +  # pkg-config or libcrypto.pc is unavailable.
> +  ifneq ($(findstring -static,$(EXTRA_LDFLAGS)),)
> +    CRYPTO_LIBS := $(shell pkg-config --libs --static libcrypto 2>/dev/null)
> +  else
> +    CRYPTO_LIBS := $(shell pkg-config --libs libcrypto 2>/dev/null)
> +  endif
> +  CRYPTO_LIBS := $(if $(CRYPTO_LIBS),$(CRYPTO_LIBS),-lcrypto)
>  endif
>  
>  FEATURE_TESTS := clang-bpf-co-re


Thanks Hadrien,

The Makefile for bpftool is also used in the version mirrored on GitHub;
and so far it hasn't relied on pkg-config. So if we introduce pkg-config
in bpftool's Makefile, could we please make it optional, like the GitHub
version for libbpf's Makefile does?

See https://github.com/libbpf/libbpf/blob/master/src/Makefile#L46

Thanks,
Quentin
