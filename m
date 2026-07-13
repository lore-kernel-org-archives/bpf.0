Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C072749DF
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907242; cv=none; b=BAa0mVTZ5EdKA9S4n8oDnT2kUHOzVtiQrJOBlJdO65Oi8ittMgV/Bbh2Oiw7ZojYr2weiSJDHUwLVwtyE66g+Ml3EFH3dSGgTaLChLdWdadTmqFky6Mh0s8/CB6fMpW1eB2hOZgIpj7kI5FihnWuEM61XMITP66ckKppcGjpFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907242; c=relaxed/simple;
	bh=E6RjiGLy9uh9pRgt7QNrYDB2h+2LjC+BqJ/8WlOyOfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBGZmFwOfvIyzW1mKB85FsoudgHo0B4+5ybc5ZNuUAL8ySt3hsCslwMIle7wt/SaWkwqbxQpypAeJpnFSw6IVwZ1a3L04qepdiE3VTCeo6PU3EGMYdtavu3DKR/HNTnLaaQmwZyFApuq7y2LDyAuJXIjtEes/ZyMkk8mMnT2BeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8LVQ0S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8LVQ0S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF51F000E9;
	Mon, 13 Jul 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783907240;
	bh=SOX0VrsUi8EqTsY4GLiLJgdQvljbp5gk+uDwPpYqGe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8LVQ0S+4xeSnlxNgx1JTLHzAjwBO2OPTS/fqmaVVwusF4Ljh69x9+pb8TbqYC/X0
	 xHshQkwOOreTqqAXvEryfJKjPQkg131N2dDsF6j4K0TwIzp/6WW7gYqcYJrcXKFYc0
	 4j+D1SSekdTbBLjH0r+WcJzW+Kl3e1VFjqRTsQxMoCb96omImCTGwP3FcqKXEqeKRx
	 tAbBgjdzfi8exhJv4g1vP3G+E+oxNqJDfxRvQvUd4rx3G3VKJVXhYDIpo25/G0zMhk
	 XCTY0SVwXAX585031pIEkfk+2v/Tz1SQgLIrNtszU4PF3a9Ma8G5cz0OhdDVWCKX1x
	 E5C4y7ve+DAKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs: bpf: document BPF_RB_OVERWRITE_POS in
 bpf_ringbuf_query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_38F9B572430A53ED62FA69944E7448970A05@qq.com>
References: <tencent_38F9B572430A53ED62FA69944E7448970A05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 01:47:20 +0000
Message-Id: <20260713014720.9DFF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch updates the UAPI documentation in `include/uapi/linux/bpf=
.h` but fails to synchronize the changes with its mirror at `tools/include/=
uapi/linux/bpf.h`.
--

--- Patch [1]: [PATCH] docs: bpf: document BPF_RB_OVERWRITE_POS in bpf_ring=
buf_query ---
commit 9f79b54782767de257ac85a74f7e4fd0e2c3a774
Author: Jianlin Shi <shijianlin11@foxmail.com>

docs: bpf: document BPF_RB_OVERWRITE_POS in bpf_ringbuf_query

This commit updates the bpf_ringbuf_query() helper documentation in
include/uapi/linux/bpf.h by adding the missing BPF_RB_OVERWRITE_POS flag.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2f1d24fef8573..f1b650b3addbd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4694,6 +4694,7 @@ union bpf_attr {
>   *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
>   *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
>   *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
> + *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).

[Severity: Low]
Is this change missing the corresponding update to the mirrored header at
tools/include/uapi/linux/bpf.h?

Since the tools copy isn't updated in this patch, building in tools/lib/bpf/
will emit a warning about the kernel ABI header differing from the tools
version.=20

Additionally, scripts/bpf_doc.py parses the tools copy of this header, so t=
he
newly added documentation for BPF_RB_OVERWRITE_POS won't be included in the
generated bpf_helper_defs.h used by userspace BPF applications.

>   *
>   *		Data returned is just a momentary snapshot of actual values
>   *		and could be inaccurate, so this facility should be used to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_38F9B572430=
A53ED62FA69944E7448970A05@qq.com?part=3D1
