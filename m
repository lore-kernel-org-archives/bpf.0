Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891237F8CB
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535820; cv=none; b=LNSCmKQuQtIBFYkgU0DnFRhhnjkgzmn48csFJQDfHX5JFfvl6pxYQCEly7EfWjVngUnBhcKrjtt52Xx+pWGyEzxb6Q72nGRK7vjCQg9XynxYTPcZKvPP1Ff3dhKN47QgVcWXmy66H6o3sGcRbrJOr8NCtmCVSg+bkBAkxq8AC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535820; c=relaxed/simple;
	bh=UsN/eVOdXI7VlHjygMTaZTWg1sE03xInaBLSjgw2m7c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jNqgurcOYBIy4T0z4bbnH4QgbZE7pgNZX2SolGVmw8XuXCZOZQSiQArh3+I2nXUgn/GuvGPib1mWRMt6EVI3aIxQTW2dpioXxHomCepQb5iRlO+X/PR0u7QfGyMrRiYydVJH8JTmx8y8v8/wK2vqI/hxsU421m5SkzqyG8oHzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKZQahX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKZQahX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D11F00AC4;
	Fri, 31 Jul 2026 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535818;
	bh=A28dBDHsFrkTUaYdU2w8WsJVg32teOnAEU1pU903gAE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BKZQahX68lWqBSEmCfrFx3MAM6fzZi6Rr+Lgg+8+AspfAhVLAuA/p6p7i11nrBD8g
	 4aqxLbHCyBWAIL9qljau2jS16ck7fIZbixHJQnRdwU17rOVq2vgYIYlXzETn2UjHWq
	 26/ZQ4jOCQq57H5qoWxMAL67YLM+FBR4kD6FG3APMUDZS6aseV1hPv2aym2+iP4Xvd
	 Ch26owOa0O61E9zUfKKRGahQzoegTwCsFdYBcfLh69mSBu1JoQxY/uyL5Z1rp/a0y5
	 o2oFCG5TIq7d5jiCSHoQgV+65u0ahJYkZfkFDNS4n4CermG3wWRr0h6zdyvxyHRm23
	 DdT+Kl7C8kQUA==
Content-Type: multipart/mixed; boundary="===============8567490657197014613=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4326cfb5a7bacd867b09b252cb9af1d1bc16ab9c3f5c3cfda7c4efd456f0c53@mail.kernel.org>
In-Reply-To: <20260730102129.15209-4-vldsampaio@pm.me>
References: <20260730102129.15209-4-vldsampaio@pm.me>
Subject: Re: [PATCH bpf-next v4 3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
From: bot+bpf-ci@kernel.org
To: vldsampaio@pm.me,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,vldsampaio@pm.me,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:10:17 +0000 (UTC)

--===============8567490657197014613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> index 09535edbbafc..30685e43de04 100644
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h

[ ... ]

> @@ -67,19 +80,18 @@ static inline bool FN(srange_overflow)(struct cnum_t cnum)
>   * cnum{T}_smin / cnum{T}_smax query a signed range represented by this cnum.
>   * If cnum represents a range crossing the ST_MAX/ST_MIN boundary, the unbound range
>   * [ST_MIN..ST_MAX] is returned.
> + *
> + * The caller should ensure !is_empty(cnum) holds when calling
> + * cnum{T}_smin / cnum{T}_smax.
>   */
>  st FN(smin)(struct cnum_t cnum)
>  {
> -	return FN(srange_overflow)(cnum)
> -	       ? ST_MIN
> -	       : min((st)cnum.base, (st)(cnum.base + cnum.size));
> +	return FN(srange_overflow)(cnum) ? ST_MIN : (st)cnum.base;
>  }
>
>  st FN(smax)(struct cnum_t cnum)
>  {
> -	return FN(srange_overflow)(cnum)
> -	       ? ST_MAX
> -	       : max((st)cnum.base, (st)(cnum.base + cnum.size));
> +	return FN(srange_overflow)(cnum) ? ST_MAX : (st)(cnum.base + cnum.size);
>  }

Does the new precondition match how these functions are actually called?

The patch adds comments stating callers should ensure !is_empty(cnum)
holds, but the in-tree callers in include/linux/bpf_verifier.h
reg_smin() / reg_smax() / reg_s32_min() / reg_s32_max() forward reg->r64
and reg->r32 directly into these functions with no is_empty() test.

Those accessors are used at around 69 sites in kernel/bpf/verifier.c,
including bounds arithmetic that feeds memory-access checking (like
min_off/max_off and scalar_min_max_mul).

The change alters observable behaviour for the EMPTY sentinel
{base=UT_MAX, size=UT_MAX}. For this value srange_overflow() returns
false because FN(contains) short-circuits false on empty cnums, so the
non-overflow branch executes.

With the old code:

    smin = min((st)UT_MAX, (st)(UT_MAX + UT_MAX)) = min(-1, -2) = -2
    smax = max((st)UT_MAX, (st)(UT_MAX + UT_MAX)) = max(-1, -2) = -1

which gives smin <= smax (ordered).

With the new code:

    smin = (st)UT_MAX                          = -1
    smax = (st)(UT_MAX + UT_MAX)               = -2

which gives smin > smax (inverted).

So where the old implementation accidentally returned a well-ordered
pair for the one input the new comments admit is out of contract, the
new implementation returns an inverted pair. This narrows the safety
margin: the defensive ordering that held for every possible input no
longer holds when an unchecked EMPTY reaches these functions.

range_bounds_violation() gates every path that commits a register into
regs[], and reg_bounds_sync() early-returns on an empty range, which is
conservative. I could not construct a soundness escape. But the
precondition is documented without being enforced or asserted, and the
callers are not audited for that contract.

Should the precondition be enforced at the call sites, or should
smin()/smax() keep returning an ordered pair for EMPTY?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30534991827
--===============8567490657197014613==--
