Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563612;
	b=EoTUYyWEFBIPOCvAlxG9rTqDLBzzPJB219TnHH1WGvke0qbmtdXMbh0H6yWrTUdSnlut
	 uxkTqQXthxIres4GkCuuwfZuoDL/WkZwWkn808g2v6cXRXXp0HApBhT0TxaZrGBhm5CeC
	 TKFQdILaEvTwjYtuMf1dP30f3DkXCOB44fa8h+5Mfq1fLdqLzTNT8/bjkQsM6kDC3jkeX
	 xSfTKkr2zWczz1mwhOofx6oZcoTeblQ+SgndmZ1/khpzt+Kqdyi+qpDrs5A6msRAF3SDg
	 Q3De8mdwHdWCrc3tAbhfPkXat4PzButY6X3t9lkakw3YgNWVZemRt++KkujfyJKE/Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563612;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=M5AjMBp8Et9Om8XVmuHlp5tveDYJ5EjVD8LBr/ee/68=;
	b=Ys4JX4PMPQkvEqkgOuaI9hsvHsswUqzPFwM7zMb76d3Mrbk82U0w24tvfpm9PmioTppm
	 N7nIBL2Oyag4250JKnK1SiWAZgI2PyeACGmRC6Kf9cKQaMIfwyFld8yQ4LzOcIzXLDty8
	 063ljpKjmdyYr8Mof31AL5cGXscldhC7Q82bJ7U8aA3OdMZ+FRTGnE3EJ027+J+/I60sz
	 Hdhf5fhALgK1KGrlLt/hzjwVh7SWqnw/cP3kuqyL/Nea0MsRG2HECBPy1GCRKuM9AuYgs
	 jGlIGqLSuNXf6/SJpWr4PjSgyvcdPfCX5PPyr7yt7EMZ+8iWpmc7JD7p8rfqgXhM8fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCJIi3b5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC706606A335;
	Tue, 24 Nov 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCJIi3b5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534491F000F0;
	Tue, 24 Nov 2026 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563612;
	bh=M5AjMBp8Et9Om8XVmuHlp5tveDYJ5EjVD8LBr/ee/68=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dCJIi3b52xLtfH5Bh34r1Z5L47yEarPFasAtrlhWiRUvsZ1czbg49wE2UuA3tSlMh
	 OJ0Ns5sE/wEiUeuEM2Yk6VJXX9nEjpZnKmKB5eVwrBFzFlVbIXmVei7T6IvaWMffEd
	 jz0dMWkF1XfAfBlQnu2A97N0JjdPGKLaf1Onog3VmhRI2WrnuiifvRQgd+SEiyEvmL
	 LTEQQkECQEu1RKi7REwxAtDX6NEebwfhm/4nDutkjeviSm/gGZio6eyMfJriqBVjfg
	 Kj/Eldh3libVH9w31YMjx8iBKd4h6dlNu0XJWOP8TFqjICiEkp6QIL6ASv9OlasSlG
	 7xp3lsnfhUoLA==
Content-Type: multipart/mixed; boundary="===============1984060565459389942=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bdaa5b918a0e59230fcce839fea102b598efeb3a65de54f668c15f29573370df@mail.kernel.org>
In-Reply-To: <20261124224811.16134-4-ihor.solodrai@linux.dev>
References: <20261124224811.16134-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 3/6] libbpf: Resolve kfunc variants by prototype
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,emil@etsalapatis.com,jolsa@kernel.org,song@kernel.org,tj@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 23:40:10 +0000 (UTC)

--===============1984060565459389942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Resolve kfunc variants by prototype

TL;DR: The stricter struct-name check in libbpf kfunc resolution may make
programs using UAPI aliases (e.g. struct __sk_buff in bpf_dynptr_from_skb)
fail to load with -EINVAL on v6.3-v6.10 kernels.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> +static int kfunc_type_match(const struct btf *a, __u32 a_id,
> +			    const struct btf *b, __u32 b_id, int depth)
> +{

[ ... ]

> +	switch (kind) {
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		const char *an = btf__name_by_offset(a, at->name_off);
> +		const char *bn = btf__name_by_offset(b, bt->name_off);
> +		size_t name_len = bpf_core_essential_name_len(an);
> +
> +		return name_len == bpf_core_essential_name_len(bn) &&
> +		       strncmp(an, bn, name_len) == 0;
> +	}

Can this break loading of existing programs on older kernels?  Before this
patch, bpf_object__resolve_ksym_func_btf_id() used
bpf_core_types_are_compat(), which treats any two structs as compatible
without comparing names.

Until commit cce4c40b9606 ("bpf: treewide: Align kfunc signatures to
prog point-of-view"), several kfuncs were defined with kernel-facing
types, while BPF programs declared them with UAPI types:

  -__bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
  -__bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
  -__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
  -__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,

and tools/testing/selftests/bpf/bpf_kfuncs.h still has:

  extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
                                 struct bpf_dynptr *ptr__uninit) __ksym;

The commit message of cce4c40b9606 says "It wasn't an issue before, as the
verifier allows aliased types."  A vmlinux.h generated on v6.11 or later
declares them the same way.

On a v6.3 to v6.10 kernel, this now goes:

  bpf_object__resolve_ksym_func_btf_id()
    -> find_kfunc_btf_id(): one candidate, bpf_dynptr_from_skb
    -> btf_kfunc_proto_match() -> kfunc_type_match(FUNC_PROTO)
       -> param 0: PTR -> STRUCT "__sk_buff" vs STRUCT "sk_buff"
          essential name lengths 9 != 7 -> return 0
    -> nr_cands == 1, kfunc_id == 0 -> return -EINVAL

so bpf_object__load() fails with -EINVAL, where the old code resolved the
same declaration on the same kernel.  For a __weak declaration the kfunc
now stays unresolved silently, so bpf_ksym_exists() is false on kernels
that do provide the kfunc.

The commit message says "a declaration with an outdated struct name no
longer resolves" and uses bpf_cpumask_populate() as the example.  There the
kernel changed which type it accepts.  Here the declaration is not
outdated: it uses the UAPI alias that the verifier accepts on those kernels.

Nothing later in the series (ea0b8db17e5e, 7848a838c614, 88fb7cd2ca9c)
seems to handle these aliases.  Will existing binaries that load today on
still-supported LTS kernels start failing after a libbpf upgrade?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45506767613
--===============1984060565459389942==--
