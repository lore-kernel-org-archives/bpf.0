Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF39224B04
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189716; cv=none; b=dpQVCLdNjszwcrhGlCFnMSvKVlhjze+0QvsQqmC5F6ZPR+2apyOoI9Wr6cu+zGOWq8ffZ4++3xHpJzpD3WbO3emBl72ujgP3Yvf2sojjXX9PplIU64lmJYhIKNcBejf2fLGcm8WfFx0HM73qXCen6WoRAohdg5Bm0QpdfRpt1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189716; c=relaxed/simple;
	bh=6GpCEY6YapVZ/MtIaDTtmPRPX7Cx+DNTdTy5i8sGOw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8wJ6di15zEdrtBrtx/0j4wriY+D6xeZ2RgTB3IdlDS4AKWxpLbrr9/pjKZAT95PJ23a4x3jju3XqctjzDsOm2JfVxLOrFx8VuAJUlDO7/78sBlsoCFmU8hKtcm4v/gTtz0kNciCNrvqzpM41uDNPJtq1ZW9nEZgUqP3bfUtXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzQpK7Sh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzQpK7Sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D31F00893;
	Thu, 11 Jun 2026 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781189715;
	bh=bhtRuPbAhVBV7sjw2AxnX4g4JhaBq0ehmBxhi2OKAgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzQpK7Sh75fRJpbH8OglYz+im1SoVqwNXhS7TictnjHAodwYtaVSGYKcl0Pb/tBWl
	 s+7dNUxlveEJLO1bLXLFxzx6enHYNrIXVMYm+Ke3EGrDBJZY5l7DIu0MaCzIxXapZl
	 z4TPoiVzHj+BYterQbpfTj6vdQ0loOvfIzOr2pYy71juB2p4CT1hjCk5XwH2yqFhP9
	 1lvJF9tQ1zFoh3MICT7q9DOClEX3khB8tVIxSav2L7iIgy6ut5UTE/l6On0zdKAzJL
	 inaIhZvwac6hM0ktxBZrPcB9siRczC//3WjejDKJh1WngO28WOBb9fVa521TppgCb5
	 WhD0c0Eha7CjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611123538.156005-4-jiayuan.chen@linux.dev>
References: <20260611123538.156005-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:55:14 +0000
Message-Id: <20260611145514.D21D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized Variable Read / Scatterlist Corruption
--

commit e06d02e025ff8d66244e941a327109ac3cb65c1b
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

bpf_msg_push_data() allocates pages via alloc_pages() without
__GFP_ZERO. In the non-copy path, the entire page of uninitialized
heap content is added directly to the sk_msg scatterlist, which is
then transmitted over TCP to userspace via tcp_bpf_push(). In the
copy path, a gap of len bytes between the front and back memcpy
regions is similarly left uninitialized.

This leads to a kernel heap information leak: stale page content
including kernel pointers from the direct-map and vmemmap regions
is transmitted to userspace, which can be used to defeat KASLR.

Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
page is always zeroed before it enters the scatterlist.

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
>  	if (unlikely(!page))
>  		return -ENOMEM;

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch, but does
this allocation use a garbage length when appending data?

Looking at bpf_msg_push_data(), if start =3D=3D total_length, the loop iter=
ating
through the scatterlist finishes with i =3D=3D msg->sg.end:

net/core/filter.c:bpf_msg_push_data() {
    ...
	do {
		offset +=3D l;
		l =3D sk_msg_elem(msg, i)->length;

		if (start < offset + l)
			break;
		sk_msg_iter_var_next(i);
	} while (i !=3D msg->sg.end);
    ...
	if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;

Since i =3D=3D msg->sg.end, does the assignment to copy read from an unused=
 or
stale scatterlist element, leaving it set to either 0 or garbage data?

If so, this garbage copy value is then used in the alloc_pages() call above
to calculate the allocation size.

When copy is 0, the non-copy path is taken, which can increment msg->sg.end,
wrap it around to msg->sg.start, and corrupt the ring buffer state by making
it appear empty.

When copy is a non-zero garbage value, it can corrupt the scatterlist length
later when we do:

net/core/filter.c:bpf_msg_push_data() {
    ...
		sg_set_page(&msg->sg.data[new], page, len + copy, 0);
    ...
}

Will this cause a mismatch with msg->sg.size and lead to out-of-bounds memo=
ry
accesses during transmission?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123538.1560=
05-1-jiayuan.chen@linux.dev?part=3D3
