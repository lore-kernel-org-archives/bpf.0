Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648611;
	b=Z8MgwXOx6Cwmi+qc80Y/V6ZD4ysLhhlbdGEKWV4yq8tdeGymXlkSxpNpXR1wnsfUqaLF
	 C9CWM/Dr4/GVT1Mds8siXJDA5UjO+1nuPW/SV1QOfUcBl3cgTT2IQx3eFUKq/7Y9O76Fv
	 cCNk5rxmd8jr0HuHaR7rGD29A5mwlySTqAhqtx2Aa7hwtnK9zUF6QZAlbUlrb5YuxmpVD
	 YKqmBciIZ3KL84CsblJHVRIzjbSDkqdhJUjFkLbKZrI9D5eofmv2dbMvK+8+s/XB084Bs
	 Dvrm1r9ynWzgyYZsx+UEOmuIrvNL1tRJNc/DZ6/KKwGsnLaIKES22k5GsZyLNmRyzzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648611;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=PdfuVFZQBi+gz3CMjRmb5bBdnqM+6OAsgMlYJGzQPIg=;
	b=IVPy/CbHNBKZyQ2xZfv3CBTn7IjK4sw5iSSJIymIr5ZysGhoaPd/6GskZpzKEI3SQWNi
	 mQgOSJgQB0QJtcKuR8dAB2r7POQbOMvT/GTQRBLq+mrQJrarbcl6DAkBVNvu/m8CM//R+
	 Z3ik9trKZfgP04+Mo0X35D0uMmyTsBlboC0MrqYMLEUSSGHYXe0tsOIylOnCzlgGT5Ric
	 iZxkUTx5/5CLlCwFTq/sIpvlJwGvNAazM6mDsJNTvdpDhNWfGxR855NFCrhFCd9dKRirL
	 naWCzCHziq//dEleCd+JZ2q1pTejSBpZEPMZH2PxnaFwQmeRvxF7nQ40nzUOZlgnV2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe3xRbq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385B606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe3xRbq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC51F00A16;
	Mon,  2 Nov 2026 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648610;
	bh=PdfuVFZQBi+gz3CMjRmb5bBdnqM+6OAsgMlYJGzQPIg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qe3xRbq6IGFtm5qhp2dDsQZB9fECSO0h0UiyCduVjleJULPd+41ZC9zq8YG3DYmib
	 JKP7lih9mk+qWCYYUN3F3kjoLLShT/1cYnqw+MbKc1e6VswxLikxA4dak5B6xTwGTI
	 KB6knsdBFw5hYrmmLxnVM/oar+qRrPjsnXBq/+awDtdX4II7f6aUtunVrbR5onsCjE
	 UedJR3IN0jM/3lTlz1GlpZe7nGe+TNYWhE4TiQ5MrIJMKeZrmOY4ypMGDP/KwnbmfU
	 wBmaC/ehKgwkGEoBSsZuXVP10P6FI/XKD0gevPHPgCTscfHLFeyQb70hj54rjHFvf4
	 R32nCxXsS+iBA==
Content-Type: multipart/mixed; boundary="===============4737113313488353722=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c496611f0e1f8a3b57ebe5e47a2e160238055853528f72930533721d9a8ffa81@mail.kernel.org>
In-Reply-To: <20261102185839.1190122-1-almagui@kernel.org>
References: <20261102185839.1190122-1-almagui@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix use-after-free in btf__add_type
From: bot+bpf-ci@kernel.org
To: almagui@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,nathan@kernel.org,almagui@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 19:43:30 +0000 (UTC)

--===============4737113313488353722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Fix use-after-free in btf__add_type

TL;DR: The fix in btf_rewrite_str() may still leave a dangling string pointer
(use-after-free) in btf__add_str() for mid-string offsets in a shared base
BTF; likely not hit by in-tree BTF, so a gap in the fix.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d2ff6f5d6d5b..95c31803e722 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -2234,6 +2235,19 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
>  		return 0;
>  	}
>
> +	/*
> +	 * btf__add_str() first looks the string up in the base BTFs of dst,
> +	 * which makes each of them modifiable and frees its raw data. If src
> +	 * shares a base with dst and the string lives in that base, the
> +	 * pointer taken below would be left dangling. So make the bases
> +	 * modifiable before the pointer is taken.
> +	 */
> +	for (base = p->dst->base_btf; base; base = base->base_btf) {
> +		err = btf_ensure_modifiable(base);
> +		if (err)
> +			return err;
> +	}
> +
>  	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));

Can the pointer passed to btf__add_str() here still end up dangling when
*str_off points into the middle of a string in the shared base (a suffix
such as "bar" in "foobar")?

A base that was not modifiable before the loop gets its strset built by
strset__new(), which sets strs_data_cap equal to strs_data_len.  The first
lookup in that set therefore reallocs the buffer:

  btf__add_str(dst, s)
    btf__find_str(base, s)
      strset__find_str(base->strs_set, s)
        strset_str_append()
          strset_add_str_mem() -> libbpf_add_mem() -> realloc(strs_data)

strset_str_append() fixes up its own local copy of s, but the s held by
btf__add_str() is not updated.

Only string starts are hashed in the base, so a suffix offset can miss.  In
that case btf__find_str() returns -ENOENT and btf__add_str() carries on with
the original, now stale, pointer:

  if (btf->base_btf) {
          off = btf__find_str(btf->base_btf, s);
          if (off != -ENOENT)
                  return off;
  }
  ...
  off = strset__add_str(btf->strs_set, s);

strset__add_str() -> strset_str_append() then does strlen(s) and memcpy()
from the freed buffer.  The relocation check in strset_str_append() does not
help there, since s is not inside dst's buffer.

btf_validate_str() only checks that btf__str_by_offset() is non-NULL, so such
offsets are accepted.  This needs src and dst to share a base (or src to be a
base of dst), a base that was not modifiable yet, a first lookup on it with
a mid-string offset, and a realloc that moves the block.

BTF from pahole, LLVM and btf__dedup() does not use suffix offsets, so the
in-tree resolve_btfids flow is probably not affected, and the code before
this patch crashed on the same input.  This looks like a gap left by the fix
rather than new breakage.

Would it be more robust to leave *str_off unchanged for offsets that fall
inside a base shared by src and dst, the way btf__add_btf() does with its
"*str_off < src_btf->start_str_off" check ("don't remap strings from shared
base BTF")?  The offset is already valid in dst, and no pointer into the base
would be taken at all.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41508558529
--===============4737113313488353722==--
