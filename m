Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C931ED8B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270900; cv=none; b=Jmk6o+qhaQ0Y39ACT0OYrP+akGhlJFT8NmkcY44r6+RjsaVFtaLlCtMwvJkZwU2vSC+NLbPbw3o1pTCBwANrSIH6eUydRv3eFBxrrZAWku2BFqtO9Bw+aOZIYl0Cp5TXUdfI4qaJTgPBnVxVhcBzLl/BvpopVZXBvx2Wi6+h5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270900; c=relaxed/simple;
	bh=69sefwt2Xl6jyGoi9QO5p/gpDjNxKU4Ne44ONGydOlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uxWuHXmpAoOV0fAsYzCFKOZQfpWo8vFc6/Jv71FMBhfKtx3eBVi2QHw2Xfh1/sUiayc1vXMAUdBPYewLOHgtv3GFB+TQVrYhkXQoRqKKEIZImBpTprQNPoAcxc/ZqBXQ3eM31NOD6jx3rJ82JgngGMOvYRxrL3f0mpK+15jdwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdA14sj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdA14sj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D41F000E9;
	Fri, 12 Jun 2026 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270899;
	bh=3XjY6zi52j+f1t5gbxKXcB97aNjjWlULyR5jiE7MUNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SdA14sj+MXcIQ8ciOnJAHs4WCnJ+RMvDlFxprziLmnQhV+8YldRrEjNSnLMS8ZwoX
	 MNykagjARvHvP+k2WVRMJLIYOcQ4Ee9QCYIhVV7lPKzh+JWeBmonHopUk8OWoYDoSP
	 fpE4A/B+5Yk9otlXPMOs/GyNgmd087YsXa71Vt5uGFf2jvMv6QnkIbxdcWvz9hcc9n
	 Hv8Lbtim+PFw/0i+I+RsstJVW54e3RCGsO++cCyigxyFVW6kIIpdRFwHXVBZ+Ft35Y
	 991o+vif75FQerTE1bOS0P/5gdhDuXuyONhmfELA306anvM8W46Y9Qam8amnuTn62Y
	 edLGt45De8yCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: reject overflowing copy +
 len in bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612130919.299124-2-jiayuan.chen@linux.dev>
References: <20260612130919.299124-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:28:18 +0000
Message-Id: <20260612132819.1D9D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow and scatterlist corruption in `bpf_msg_pu=
sh_data` due to reading a stale length when appending to a full scatterlist=
 ring.
--

commit 03e879f94c0eac25b2f497170c4a5ac1a5564d33
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()

This commit adds an overflow check for the copy + len calculation in the
fallback path of bpf_msg_push_data() to prevent undersized allocations
and subsequent out-of-bounds memcpy operations.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..3c8f1cedb217f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;

[Severity: Critical]
This is a pre-existing issue, but does this copy assignment read a stale
length when appending to a full scatterlist ring?

When appending data to a message where start =3D=3D msg->sg.size, the
scatterlist traversal loop terminates with i =3D=3D msg->sg.end. If the rin=
g is
full (space =3D=3D 0) or has one slot left (space =3D=3D 1), copy is comput=
ed using
msg->sg.data[i].length.

Because i =3D=3D msg->sg.end, this reads the length of an unrelated element
(either the first element if full, or an unused stale slot) instead of the
actual element being split or coalesced.

Later in bpf_msg_push_data(), a memcpy occurs:

	memcpy(raw, from, front);

Can this cause a heap buffer overflow?

The memcpy uses front (which equals the true length of the last element)
to write into the newly allocated page, which is bounded by the unrelated
copy length.

If the stale length read into copy is very small, but the last element is
large, it appears this would write out-of-bounds into the allocation.

> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));
>  	if (unlikely(!page))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612130919.2991=
24-1-jiayuan.chen@linux.dev?part=3D1
