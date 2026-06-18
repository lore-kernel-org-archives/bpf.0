Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3D386429
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785901; cv=none; b=fEGKMDNov2Um77RXD7qiZf8VOau8UZEc8deFsNTmIGluESPEzV+MIEILqp8FPxzrYsRVetdpAgvM8dTpuhpuYFy2YvTl8bYql0G8CGMOlUH0qaCjv8ilcNYKyg7KMz2N3qTaeKd42inDlFcoe1NpTFLhg//O//XNCxMPtull96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785901; c=relaxed/simple;
	bh=HUmGOYE/C8TU/uUS16RtcpM+syCs0OHKlLWtF5Qgk+w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh5istz/gyJaOKJHT9N6wWI8bezKLg/TlRPDuDui4o9xqPOGr9dDK0t/N5cYxpqh6vl8ycyhuk2Ywu+ZGFgfSFWjZp/1mrWAK6BzcIxgyPM1zW8wi6EtdvoT9UWBLS2EUSJ062Ue2rlV411ejgRSVCUvuSmjIEKBMHEThPsUmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoNpDUB0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoNpDUB0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso8906985e9.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781785899; x=1782390699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSGbxDjo+2rjoOObMeaDBZSVpoYq1jILY+Z8HnHA6Oc=;
        b=JoNpDUB0z9Y6f8YJHfMfDAwpI3A7vZCYWwhLtOaf7NjgmEj0TIuGCYkpOEvvL2U64i
         718YaYxWrKZQ1ilnQd2frDHit2F6sq+WIrI9UHaQGBu5/ZKWHyAkeeQEeULg3h7x/+gj
         LvVGH6sB9GgQVpBSO+R5jeK3PPaxPd80iPmBeTN91/atqvYfQOqk7TdhXsFjYMZbqb9M
         7dcnHaaKDVGCgHcfz6FY+1odsJpMCNzBKQ4VcExYN0vji09wbp7RpAqPMgLSE/hGvZkE
         BbZuhElCSEvI/NnsB9CxIIwY7sot7g3Q1m1OPHJet81IUnZNrZYFlYqsSBHzmMGQZAKt
         bV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785899; x=1782390699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSGbxDjo+2rjoOObMeaDBZSVpoYq1jILY+Z8HnHA6Oc=;
        b=ln/bHwzjsVdcZ7/iUSLhW7a+4jBuUMgGj+EC8cxSIb7VyCLpGwAmsK/Xbr3OW8Uqsq
         u8O1cJHY1m6zf8GJR9b3PLdGLLGF64pGKVpeIEC6okPPchAMLfismAiZ94OBVkLa3K8D
         Paw9752sYHCLJ1b2dhP2jKIT1nqTXvhTbKqoto12gchP80s35fd5cnTtwnHto+0rJwGS
         SfUwgT5pn95rcOerugGLudM8cEGDPx32EMceYK/bwu8Xw0fXwTv4ahOe+qw4A6dBOqJI
         NAt912dUCoBbG2lxCbOG3RgT3Fg019kj0gOCO5mILxUUic9xH2gHPL8Y1wtmaWdXes0L
         f3xQ==
X-Forwarded-Encrypted: i=1; AFNElJ8a6XzukzhDnhCM1viBdR2nzmFQevJ7njGhUv2M68b54itdSWbH2sPO338Gu/V0OVTH9Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/3u2l4W+W+xgOtQBgZXu+dV2WiOk379gXDJ+btp7TPZkV+1T
	Ucy5XWM11HSTXyhXRdpzbOYMqGKe4HT12g48ofS5VkxVyDhIOukml3Xn
X-Gm-Gg: AfdE7cmJzj0IAcxhEKHQx2CBc9vWanesejB4G+dQW/9eF4Y+3q5d4cbtCt4b9jalA82
	RISMz5AmR10NWS2NTofEbmJmutIOz3ZGhVT10f+3tOqpeBAWt+9cqpfuQhPh35oiA8GZzH3kTq4
	UNrIYuSyU0NKW6vs+E2tNw66sbYmtJQzBu3J+QDRhVuVh8CuRi9R6XeHqm+fceEkZwq8KW0+a/1
	6rOkmBFZvL5n5Y2LSV0caUvVy7aUeUxps+eAhokJxopguTk1ONxMozbp7VFoQR9WvR2PfaDO2T+
	15ll9oOy2LihopGvDMJb/b0xWQXU2SwGHI/mnWWIb+CLbxr42Ub2cnLW7lxHpOxAqacFPiCiw0o
	Ny0f7sQJm0pcMEuv6Q36wohCDXY2I6llZ56j0HTQ1Scmxj9s4H7r90gkw76LBeHwpYcyXX9MN1G
	sb
X-Received: by 2002:a05:600c:e547:10b0:491:9969:739d with SMTP id 5b1f17b1804b1-4923822eed4mr39446355e9.29.1781785898507;
        Thu, 18 Jun 2026 05:31:38 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm267646685e9.1.2026.06.18.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:31:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 Jun 2026 14:31:35 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add kfunc set test to
 resolve_btfids
Message-ID: <ajPlJ81PL_YaHsBo@krava>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
 <20260617210619.1562858-5-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617210619.1562858-5-ihor.solodrai@linux.dev>

On Wed, Jun 17, 2026 at 02:06:19PM -0700, Ihor Solodrai wrote:
> Extend the resolve_btfids selftest to cover kfunc sets defined with
> BTF_KFUNCS_START/BTF_KFUNCS_END.
> 
> The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
> resolves function IDs, and checks the kfunc set is sorted.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 63 ++++++++++++++++---
>  tools/testing/selftests/bpf/progs/btf_data.c  | 10 +++
>  2 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 6bcadee50bb8..65ede3ac5845 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -12,6 +12,10 @@
>  
>  #define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
>  
> +#ifndef KF_FASTCALL
> +#define KF_FASTCALL (1 << 12)
> +#endif
> +
>  struct symbol {
>  	const char	*name;
>  	int		 type;
> @@ -28,6 +32,17 @@ struct symbol test_symbols[] = {
>  	{ "func",    BTF_KIND_FUNC,    -1 },
>  };
>  
> +struct kfunc_symbol {
> +	const char	*name;
> +	s32		 id;
> +	u32		 flags;
> +};
> +
> +static struct kfunc_symbol kfunc_symbols[] = {
> +	{ "kfunc_a", -1, 0 },
> +	{ "kfunc_b", -1, KF_FASTCALL },
> +};
> +
>  /* Align the .BTF_ids section to 4 bytes */
>  asm (
>  ".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
> @@ -35,9 +50,9 @@ asm (
>  ".popsection;                             \n");
>  
>  /*
> - * test_list_local and test_set are .local symbols placed in .BTF_ids by
> - * inline asm, and are read here directly by C name. To the compiler they
> - * are plain, default-visibility extern objects.
> + * test_list_local, test_set and test_kfunc_set are .local symbols placed
> + * in .BTF_ids by inline asm, and are read here directly by C name. To the
> + * compiler they are plain, default-visibility extern objects.
>   *
>   * When test_progs is linked as a position-independent executable (PIE),
>   * taking the address of such an extern is routed through the GOT. The
> @@ -69,6 +84,11 @@ BTF_ID(struct,  S)
>  BTF_ID(union,   U)
>  BTF_ID(func,    func)
>  BTF_SET_END(test_set)
> +
> +BTF_KFUNCS_START(test_kfunc_set)
> +BTF_ID_FLAGS(func, kfunc_a)
> +BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
> +BTF_KFUNCS_END(test_kfunc_set)
>  #pragma GCC visibility pop
>  
>  extern __u32 test_list_global[];
> @@ -92,6 +112,8 @@ __resolve_symbol(struct btf *btf, int type_id)
>  	if (!ASSERT_OK_PTR(type, "btf__type_by_id"))
>  		return -1;
>  
> +	str = btf__name_by_offset(btf, type->name_off);

should we assert str != NULL like below?

jirka

> +
>  	for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
>  		if (test_symbols[i].id >= 0)
>  			continue;
> @@ -99,14 +121,20 @@ __resolve_symbol(struct btf *btf, int type_id)
>  		if (BTF_INFO_KIND(type->info) != test_symbols[i].type)
>  			continue;
>  
> -		str = btf__name_by_offset(btf, type->name_off);
> -		if (!ASSERT_OK_PTR(str, "btf__name_by_offset"))
> -			return -1;
> -
>  		if (!strcmp(str, test_symbols[i].name))
>  			test_symbols[i].id = type_id;
>  	}
>  

SNIP
