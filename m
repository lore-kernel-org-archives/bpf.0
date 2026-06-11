Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F0237180
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142566; cv=none; b=k045LTRsw7gtwlOnGUSGJC0mLbvwn4eIRMp94RKPuSwPrKqmdE5RPvO6NcX4q9YpTEYegRQl7lpuXlDWiW4L0/qMs6tMBQD2IoJgUAqna6d+N85JhJieVRhEaG+9gRliXtOAmHHfo8CaK4dX2I3lLrmKsIMomv35dO3f1S/mSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142566; c=relaxed/simple;
	bh=5/P127lCG11uJUWOOqV+AjljB6aoiwFXCKmZqOJbpnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9+VXnShLO5Qi01LTv8Hbwl+3lfaG3OIFa+bS5L0gPwAxsszSadh/yz05jp3bnHt0s5AqkPRfi/eCe/zRvT7cOH08l5vcHHsECQAoN2jJG13UDHS1KZD9JFtEI34CdH+glGYyYICd+2CCel2m3cYYoTA6dnX9C+bS+qwX7p0dEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/tk6oKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/tk6oKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4BC1F00893;
	Thu, 11 Jun 2026 01:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781142565;
	bh=N97l2rt6LTgWfJm4yHQkDvnZpy3GTvcolqo31esCzSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/tk6oKXTnqymt96pIEl0neF4m16HZvUnqjkDn7NI/vWnC7buE4TiJqxH9IWcXpJ8
	 UKgwROuoPImms4e24dsBm91g/GESuM2G/gkOYwvZtOIiDqYaDyj/TGfU2w0aLeH3QR
	 zCLoH3mlv1KrkQpHIJ3wbfKZdtzdCmr6MBDPNL7BesLT9Wt2/FKomymGYxC7xzgWZU
	 tS+4ycQkM/GJgDyUPpdS0PG3vPqlkJAXmx7MGws8QV2+UHCaprTfX4xeVUKLV7EO2d
	 TuDUQttdKxffyJm3THLrkdENwpb2VG4Z+WlgP4bAofzeRT/AhX69p3U3aOWWDybEAP
	 P2EN/MZ0vNwAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/4] bpf, sockmap: reject overflowing copy + len in
 bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611013547.247039-2-jiayuan.chen@linux.dev>
References: <20260611013547.247039-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 01:49:25 +0000
Message-Id: <20260611014925.9D4BC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds memory access and scatterlist corruption when ap=
pending to a full or nearly full ring buffer.
--

commit 98c76ef1269e7a7079e13de8f22677af2c26b2dd
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()

This commit adds an overflow check to bpf_msg_push_data() when calculating
the page allocation size. It prevents an integer overflow where a crafted
length could wrap the copy + len sum, leading to an undersized allocation
and a subsequent out-of-bounds memory access.

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
This is a pre-existing issue, but can this read the length of the wrong
scatterlist element in bpf_msg_push_data()?

When appending data to a socket message (start =3D=3D msg->sg.size), the lo=
op
terminates with i pointing to msg->sg.end. If the scatterlist ring is full
(!space), msg->sg.end wraps around and equals msg->sg.start. This evaluates:

    copy =3D msg->sg.data[i].length;

which incorrectly reads the length of the first element in the ring buffer
instead of the last.

This allocates a page based on the wrong length, but the coalescing step
steps i back and copies bytes from the actual last element:

    memcpy(raw, from, front);

If the last element is significantly larger than the first, does this cause
an out-of-bounds memcpy that can corrupt adjacent kernel heap memory? Also,=
 if
there is exactly one free slot (space =3D=3D 1), does copy read the uniniti=
alized
length of that free slot?

> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));
>  	if (unlikely(!page))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611013547.2470=
39-1-jiayuan.chen@linux.dev?part=3D1
