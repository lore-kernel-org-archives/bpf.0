Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904089;
	b=2qWQs4C1BTu+lMoi5Uej0OSl3s6z7aE5jI62e0j13wntWmMq6V1enoHFFyxD9nAu6UoI
	 h27QMkF3DKBIy0LOJHuvvWO2NyyDKUGXr5S5CuApSulGvIXe6fTiLYQWb2COY58Rp//tP
	 z2WDpZw9HerA0YQy9ZlakOzM//69fpZw6vFEyxvaf1NApXc70Kq5j1J5gf/QzLn9y0GAV
	 Z/lWul5n+6Ed6wUcWSC6xdQv9WvCLbph1+2QF6LaRHusHFK2mDToWTym79uRyqWpE/IJw
	 joAEDuQ7JKc16SM8LLNoo+2DVqkTerkfYz4BKFnMn3L03UGFP4neOkk64SiSCN2lpqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904089;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2iOZN3vVbG3Zld80aIYXrMBPjNOQaHbRiPmkPckJZZI=;
	b=EmDOBtV03fgPu4AQE/kRy8cCI+5wwghk2Vj4Ys+Ejq1ZdGwujwDlPBDhRaU/7fK/kbAE
	 p5fNMZ0ww6rDff/G6Zg4rOyNPWp8CWeOjd3foPI/TJpo3zoEYSAQrUclsfv7Pp7ObM49L
	 HSeupoBujy7uN5c8jX3Jrt08Jn3rHqmHH2MFWKOTYFGHUnhw30F65zNTvaNrqGbvPT6BT
	 h031sF+r17hSZFwJVlJgWbPgld7X14P9WARITmb4zyNQxxoWD+cvrNZ7p9zXVWzchIbYs
	 64orwoH/UolIq+IbNwpHHAjm985H1YHDJQGpnZ12/NJvy1EoDKGSrerAmSjJUFPZc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TETHPbTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEF606A32C
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TETHPbTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6DB1F00A02;
	Thu,  5 Nov 2026 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904088;
	bh=2iOZN3vVbG3Zld80aIYXrMBPjNOQaHbRiPmkPckJZZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TETHPbTVdbyy7bvR2OfJtu2D9g2xg1ngamBF9g56rqAH+jujNEUqa71sjF83+dUdA
	 GZ+2DCUyLGvuLwYHM/8QvBA5W+tcFefcwZpuoKygtMQBmxGYkEX212bUkhCBv6FTV5
	 Xdqp64ZH8RWqlHUmejMPCi0YCbh8G34p1cUz1EooLo1GN+IcQDDaYIwlmInMVhEytU
	 9HR7/SeNafpotlE8G+bGSaIXyn9Sb2iE5ep+IVmCm3MqokD6y84ItDj1ezFtKkynwq
	 wFoLrzylGCKFatY1HdRr7fL/pdXnllEI3VoUdqltw4yh+o3XvaSqs1PrLj0jsNmkc+
	 R4Zky3APffADw==
Content-Type: multipart/mixed; boundary="===============3717782323944586867=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e0df4fa9e17514c79de41ee9fd2eb610d43a95741fb994db160b35fd488f054a@mail.kernel.org>
In-Reply-To: <20261105175845.30357-3-ihor.solodrai@linux.dev>
References: <20261105175845.30357-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 02/17] libbpf: Look up BTF strings without making BTF modifiable
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oss.qualcomm.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 18:41:28 +0000 (UTC)

--===============3717782323944586867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Look up BTF strings without making BTF modifiable

TL;DR: The base-BTF modifiable loop and stale comment in btf_rewrite_str() may
now be obsolete; btf__add_btf() into split BTF may still fail with -EOPNOTSUPP
on vmlinux BTF with extra header fields, so drop the loop or note it.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -2131,8 +2141,7 @@ int btf__find_str(struct btf *btf, const char *s)
>  			return off;
>  	}
>  
> -	/* BTF needs to be in a modifiable state to build string lookup index */
> -	err = btf_ensure_modifiable(btf);
> +	err = btf_ensure_strs_set(btf);
>  	if (err)
>  		return libbpf_err(err);

After this change btf__add_str() no longer makes the base BTFs modifiable
or frees their raw data.  Is the workaround in btf_rewrite_str() now
obsolete?

tools/lib/bpf/btf.c:btf_rewrite_str() {
	/*
	 * btf__add_str() first looks the string up in the base BTFs of dst,
	 * which makes each of them modifiable and frees its raw data. If src
	 * shares a base with dst and the string lives in that base, the
	 * pointer taken below would be left dangling. So make the bases
	 * modifiable before the pointer is taken.
	 */
	for (base = p->dst->base_btf; base; base = base->base_btf) {
		err = btf_ensure_modifiable(base);
		if (err)
			return err;
	}
	...
}

The comment is no longer accurate, since btf__find_str() on a base now only
calls btf_ensure_strs_set() and never calls btf_invalidate_raw_data().  A
pointer from btf__str_by_offset() into a read-only shared base stays valid.

The loop still runs, so btf__add_type() and btf__add_btf() into split BTF
still make every base modifiable.  That still fails with -EOPNOTSUPP when
a base has unknown header bytes:

	if (btf->has_hdr_extra)
		return -EOPNOTSUPP;

btf__add_btf() only calls btf_rewrite_str() for
*str_off >= src_btf->start_str_off, so it never touches strings of a shared
base, yet the loop forces the base modifiable anyway.  For example, bpftool
merge_btf_files() does:

	combined = btf__new_empty_split(vmlinux_base);
	btf__add_btf(combined, mod);

which reaches btf_rewrite_str() -> btf_ensure_modifiable(vmlinux_base), and
that fails for vmlinux BTF with new header fields, which is the case the
commit message says it wants to avoid.

Could the loop and its comment be dropped as part of this change, or should
the commit message note that btf__add_type() and btf__add_btf() still
require a modifiable base?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42081937070
--===============3717782323944586867==--
