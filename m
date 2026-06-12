Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7A30B502
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271247; cv=none; b=GlYx/jzyiRK+EEpP/vY/gzOYLoNpa+s03YhLOsRTVUjPfrN2HhZOkyvv16sKiwhOAhNWjjfKjy/umRHAOjqerSiil7Wivwb3+7l+XXBxgqKbK/hZ7gcS7m9gYHmWUfnYtld/Ukab7/geWFlZzQLDITt2d+z2Vm7roLOeS/OPVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271247; c=relaxed/simple;
	bh=aCpDm+dzK/voRT1XcbIr2Ps3QhCMN2yXWMUVnsz9Abs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L+zP/9kHuUFrI5hcrtN8/hM3OqE1oQKoGHCLuybdvbX4L0aMWPq7duTE9KTgFG+ZJneFmRuqpaEu+dxt9oEEaMzAMt1i0rw8b2XcGHIq0I8k0Bd9dYsU4v+bZHc+aeZ1FMBPAI6IYECScAzePz+KPavLvNuNVK3KuoTuKb05w1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjB0Urr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjB0Urr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D341F00A3A;
	Fri, 12 Jun 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271245;
	bh=3hA/IabuhdDuQokGJF779DZgqXh/xrow9fMbF9ABr68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IjB0Urr4VlYanq1eoulyK1t5YGoFzOGPa7fxoZz28NFBUE1TdkRRqpeJLyebtn8oP
	 8Pdk/hBj21VHnKEGEQ403s/ZX+A7M4jodxFmgh6rJZYSeYBJB0dfjwvlV6tCjy0VZi
	 217mINso4BmN5htWpy+xsllnN24PDvXL+zooO6USdHWqz1bz9Cy+5qxM/peo9p9htt
	 khao7zL7Vhh6oHcruYmD7HevJmGrBM2IgCWMIYXXims0s4ty9KLwQzAy7oiHKCJ4gz
	 SAdpmvkHkKPkVH79Gx3+qeuugGpPpyyTnnDKhenP3Wo5SMckfyz/ZFVk4EhqEspIA+
	 Kz3Iq5+4fsyKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612130919.299124-4-jiayuan.chen@linux.dev>
References: <20260612130919.299124-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:34:05 +0000
Message-Id: <20260612133405.C1D341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_msg_push_data() reads from an unused scatterlist element when =
appending data to a full ring buffer, leading to ring buffer collapse and m=
emory leak.
--

commit e3a134650540250c479e1e8112bfc1b9991ae703
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

This patch ensures that pages allocated in bpf_msg_push_data() are zeroed
by adding the __GFP_ZERO flag to the alloc_pages() call. This prevents
stale heap content, including kernel pointers, from being transmitted to
userspace.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e555f276ba80..6e345ca65ca14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (unlikely(copy + len < copy))
>  		return -EINVAL;
> =20
> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZER=
O,
>  			   get_order(copy + len));

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
bpf_msg_push_data() in net/core/filter.c to read from an unused scatterlist
element when appending data to a full ring buffer?

When appending data to the end of the message (start =3D=3D total_length), =
the
scatterlist iteration loop exits with i =3D=3D msg->sg.end.

If the ring buffer is full (space =3D=3D 0), the code attempts to coalesce =
the new
data with an existing fragment to free up a slot:

	if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;

Since i =3D=3D msg->sg.end, this points to the unused, zero-initialized sep=
arator
slot.

As a result, copy evaluates to 0, the coalescing path is skipped, and the n=
ew
fragment is unconditionally appended to the full ring buffer.

Does this unconditionally advance msg->sg.end and cause it to equal
msg->sg.start (since MAX_MSG_FRAGS + 1 wraps around)?

If so, sk_msg_elem_used() would return 0, making the message appear empty,
collapsing the entire ring buffer, and leaking all previously allocated
scatterlist pages.

>  	if (unlikely(!page))
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612130919.2991=
24-1-jiayuan.chen@linux.dev?part=3D3
