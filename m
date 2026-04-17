Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE31362153
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445633; cv=none; b=QnHxCU772/a3+YddNs9fhr6CI03lc032MNPPvyeKlICjSYZ7bzu0AYGy73Wb4LebG9qFp88v+ZNHyg7GSORjRf0V8y+efPLNLOstjPrkF09ze8iHpC8oqDRacVxA1dQ8/LMpALCyoDTHTBP6wTIwlrq6tpPhCQmocUgQluq3g64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445633; c=relaxed/simple;
	bh=yDwaeEPxXXqVKMQNfymm8E+9GLgothxZyyK9splMJjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JO6vEew2Iv+TnhqVmd6X85+4/bv/U7YTx47W95kkIpQqWoFHiCFXJ7z8R2ZXF4gllvPK98x+uPdQ6YZh4k5F2fvLHY2Egu79oDkvGRPBKQH8RiW6/l9S4PGJ1m96RnoSrY+bvpisibBPWB9hZ7ofxdNn1ZyFvdW5B6MgcqAW/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkM+1tta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkM+1tta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E77C19425;
	Fri, 17 Apr 2026 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776445632;
	bh=yDwaeEPxXXqVKMQNfymm8E+9GLgothxZyyK9splMJjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VkM+1ttaUS82pWOip0QhBxxgqS4bYMl1eNZivGoi59e8YSToOcpgJSV6jW7jh/9HY
	 aGp/Mq4xiQQyEky4EFIqssufgWa2bTtHExA5EO5znWS0ym7fwcT+7FC6XvKDYfYZVG
	 eiGMfoFpsnyTyoYztFL2SD6o51m0ZhKpdT4SPuzf3M800mkvbPTEqtFEhxCZBV/vSM
	 pRIq5FEqYH6pcZFsvT6VO9sGY5PriksskZ1cIeAWb/uAefvXAMRgtJnupynBa0ONhw
	 1KKzyCnP9VUIQauMEBeRwhjLX0S8L+hG5Xc2x/seAgmCN2DfVDjIt+VOmrRVdh1WRZ
	 qnALze8OCYiKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417143023.1551481-3-alan.maguire@oracle.com>
References: <20260417143023.1551481-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 17:07:11 +0000
Message-Id: <20260417170712.74E77C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] On 32-bit systems, `btf_parse_type_sec()` is vulnerable to pointer=
 arithmetic wrap-around due to missing strict bounds checking, allowing an =
attacker-crafted BTF layout to bypass safety checks and cause out-of-bounds=
 memory access.
--

commit 0d6d9306686384cb94334ae8845f954db44a9f74
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Adjust btf_vlen() to return a __u32

Now that vlen is 24 bits, btf_vlen() must return a __u32.
Adjust use cases in libbpf accordingly.  Also add error
handling to avoid vlen overflow in btf_type_inc_vlen().

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a8782..267904939098c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -421,7 +421,7 @@ static int btf_type_size_unknown(const struct btf *bt=
f, const struct btf_type *t
>  {
>  	__u32 l_cnt =3D btf->hdr.layout_len / sizeof(struct btf_layout);
>  	struct btf_layout *l =3D btf->layout;
> -	__u16 vlen =3D btf_vlen(t);
> +	__u32 vlen =3D btf_vlen(t);
>  	__u32 kind =3D btf_kind(t);

Can this lead to a pointer arithmetic wrap-around regression on 32-bit
systems?

The size is calculated later in this function using unsigned 32-bit
arithmetic and returned as a signed int:

    return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_=
sz;

An attacker could provide a custom layout with an artificially large elem_sz
(e.g., 2,000,000,000). For a type with vlen =3D 1, the calculated size fits
within a positive signed 32-bit int and is returned as a valid positive
type_size.

When btf_parse_type_sec() checks if next_type + type_size > end_type, it
evaluates this using 32-bit pointer arithmetic. If next_type is located high
in the address space, adding 2,000,000,000 wraps around the 32-bit boundary
to a numerically smaller low address, incorrectly passing the bounds check.

This causes next_type to advance to the wrapped address, allowing subsequent
loop iterations to read arbitrary memory and potentially cause out-of-bounds
accesses or crashes.

While this parser logic issue predates this patch, should we address it here
by safely checking the offset instead? For example:

    if ((size_t)type_size > (size_t)((char *)end_type - (char *)next_type))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417143023.1551=
481-1-alan.maguire@oracle.com?part=3D2
