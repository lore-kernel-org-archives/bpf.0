Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C0405F7
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490768; cv=none; b=PBRzjx2wb3t1xBZelqqLHp3nNhPCBZUBuvJZIrVTZ3RvE89JZxlwxiq0tm87P+kRLuXB5kYiShh0o34q0vBftm3Eed0BOy/3MBoJDb3cD6OHMAC6iGjI5jhNqxyGG1Oq0ijF4zlfcgcvXnEnt0dUAOqROZCE9vTgNw9SNax/8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490768; c=relaxed/simple;
	bh=ATBka2ySohlcSnp4EWe9iJGGS4bl5NcIluKZDi6q/xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwaJ5qZsXg+XAdGonVL0W/y2wNfL+jRGJPbWQueRr8Dom9DM7VXjfxD/IigKh0+uojxm2I35/IkzcouGyGXGpQOvl4BTQLmSb2kJAHJhoAj62eYdx6kZTRUfZKHE+JY1Sar+pJ1o+mIJR9Rp4I+LbxB61V4NZ9jqyK0bLapUO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAjkN3G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAjkN3G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD61F000E9;
	Mon, 15 Jun 2026 02:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781490767;
	bh=APYz5oH8atIf3QVciolsRS3bm/aD4Ze5MHS/tgSdZq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAjkN3G0FB+tgHpX1WF4QtTJ+7t4n0xbPgxtTS66L2b9L/i/aoc5qcZCme92rqSFz
	 C2H5FgB1/wlNjMt+yBywHdN6Pe0tGy7vuBHJsTDikJyNrTopdm0of5ghBlW5+YHH2z
	 Ks9PHkLxEfqC8bu8U8Ml1wrnu8blkl5YFx7TIteLgguGMr6fGeOA4iKDM0UVDn2gTK
	 9ks9hhZnx+K2LjdHRKlqCvQBQVS0UbVmes0aG/jVL4HdWZounX2yt1K3bmqrdzyrKE
	 nx+ol4f83kbitqZna76AjhhztYgRwDJV51at/LQC+EctQ4irH252TSEWkoY/4MbuSD
	 2Y2HGCFDtViYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] bpf, sockmap: reject overflowing copy +
 len in bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615021959.140010-2-jiayuan.chen@linux.dev>
References: <20260615021959.140010-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 02:32:46 +0000
Message-Id: <20260615023246.E1CD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Appending to the end of a full or nearly full message scatterl=
ist reads an out-of-bounds or unrelated `length`, causing a heap buffer ove=
rflow or massive information leak.
- [High] Allocating a new page without `__GFP_ZERO` in `bpf_msg_push_data()=
` leaks uninitialized kernel heap memory.
--

commit d474d4a6051d7bd721dc6d3aa5d5f0dff7f6ec9d
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()

When the scatterlist ring is full or nearly full, bpf_msg_push_data()
enters a copy fallback path and computes copy + len for the page
allocation size. Since len comes from BPF with arg3_type =3D ARG_ANYTHING
and both are u32, a crafted len can wrap the sum to a small value,
causing an undersized allocation followed by an out-of-bounds memcpy.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 57b00c6cc8cc1..4b159045881dd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;

[Severity: Critical]
This is a pre-existing issue, but does bpf_msg_push_data() read an
out-of-bounds or unrelated length when appending to the end of a full or
nearly full message scatterlist?

If appending exactly at the end of the message (start =3D=3D offset + l), t=
he loop
terminates with i =3D=3D msg->sg.end. If there is exactly one available slot
(space =3D=3D 1), the condition space =3D=3D 1 && start !=3D offset evaluat=
es to true,
causing this line to execute.

Since i =3D=3D msg->sg.end, this reads the length of an unused, empty slot =
(stale
data). This stale value dictates the allocation size and is added to the new
scatterlist element's length (msg->sg.data[new].length =3D len + copy). This
causes the scatterlist element to advertise a length much larger than the
actually initialized data, triggering massive out-of-bounds reads during
transmission and leaking thousands of bytes of kernel memory.

Additionally, if the scatterlist ring is entirely full (space =3D=3D 0),
msg->sg.end equals msg->sg.start. Thus, copy incorrectly reads the length of
the first element in the ring, while the subsequent code consolidates the l=
ast
element. This results in allocating a page sized for the first element but
memcpy-ing the last element's data into it. If the last element is larger t=
han
the first, this causes a deterministic heap buffer overflow.

> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));

[Severity: High]
This isn't a bug introduced by this patch, but does alloc_pages() here in
bpf_msg_push_data() leak uninitialized kernel heap memory?

This allocates a new page but intentionally skips initializing the newly
inserted len bytes region, copying only the front and back portions of the =
old
scatterlist element. Because the allocation does not include the __GFP_ZERO
flag, the inserted space contains whatever data previously occupied that ke=
rnel
heap page.

If the BPF program does not subsequently overwrite this region before the
message is transmitted, the uninitialized kernel memory is sent over the
network or exposed to user space.

>  	if (unlikely(!page))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615021959.1400=
10-1-jiayuan.chen@linux.dev?part=3D1
