Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C751D798E
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080084; cv=none; b=KeSurXKLP13YhYsMnhRusriz8IfR4nirtwl+TWTQ2FWTu9jmM8LMGoOLZdNdlR472d6dh7REYeQUJS4y1AyuCeiveIKotYhYBa8iKXJuL1xNrEOmUP/TtOIHtCzpCq6RagMOHs4PgY9V+3qKWqcFhgvgr2aiE7u48ecvcTLPebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080084; c=relaxed/simple;
	bh=w/Rd+6VQiikd90AGS/vN3KTaFTulxK2ltXgqBvUR96g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8AvodMzLV+PaJZnaSsvZgHBffQ9INSg1psmGZTPwpkoD1O+iU5vNgHCs6B1mjb2emmd9w7RO4JoGqDOAUPUm7T6KE0gviJwtF4U4czpLMPvnv5vxUhTUJ0VNUoxPPYLDUG86MBmbs9Sdg/7H5vZ1sqaMeccMU1BKZXP0FG7Qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ7OOep+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ7OOep+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409F81F00893;
	Wed, 10 Jun 2026 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781080083;
	bh=mWDtX93xujJ9ROI07lrGj295khzWCzNXRWYrXx2hBxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJ7OOep+CKlUEeVE+lS2fioNVR7Km9HnCD0dFCcBjokFu+CijvRoYlD3ACjCwKNSQ
	 VXDfF3Mut/KyrWY889OUCAJ1pfT0Cu1ng6BC0x9p7uA7jPCVUf7VVWmRjJv9x1Awm8
	 2CadydzaScB26Jvo36zfr3j8jxO2LFIwaJd6cv0wniSQWD37d4MfwPGKmCQX1OdHjL
	 Zax2PovWCsIoSyJJr6OnPjYLR1whSl47yt0+4ba74h/rIQR3IKl619EairBvTds/CP
	 wVfbuobIZa4ciyP2R++1gyaktohb7/+M0tpdYoWjsuf2u1+K5ibF8ds7bNYgDnAqhb
	 S6uukitEE1bbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610081218.506709-2-rhkrqnwk98@gmail.com>
References: <20260610081218.506709-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 08:28:02 +0000
Message-Id: <20260610082803.409F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in bpf_msg_push_data leading to out-of-bounds=
 kernel memory write.
- [High] NULL pointer dereference when bpf_msg_pop_data completely empties =
the message.
- [High] sk_msg_shift_left and sk_msg_shift_right fail to shift the msg->sg=
.copy bitmap.
- [High] Information leak due to uninitialized memory allocation in bpf_msg=
_push_data.
--

commit 291c1f747004c017b1fe863b58e41dd47655f42e
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check

start and len are u32, so u64 last =3D start + len evaluates start + len in
32-bit and wraps before storing it in last. The bounds check can then be
passed with an out-of-range start/len. Widen the addition with a (u64) cast
so the bound is evaluated in 64-bit and a len near U32_MAX no longer wraps.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..8dac0f4d9fcaf 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2974,8 +2974,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> -	int pop;
> +	u64 last =3D (u64)start + len;
> +	u32 pop;
> =20
>  	if (unlikely(flags))
>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but I have a question about the end of this
function. If a BPF program pops the entire message payload (i.e. start =3D=
=3D 0
and len =3D=3D msg->sg.size), the bounds check passes and the pop loop shif=
ts
out all elements, leaving an empty scatterlist.

At the end of bpf_msg_pop_data(), we unconditionally call:

    sk_msg_compute_data_pointers(msg);

Which does:

    struct scatterlist *sge =3D sk_msg_elem(msg, msg->sg.start);
    ...
    msg->data =3D sg_virt(sge);

Since the element is now empty, does this cause a NULL pointer dereference
when sg_virt() attempts to dereference the page struct?

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential integer overflow in
the related bpf_msg_push_data() function.

In net/core/filter.c:bpf_msg_push_data():

    page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));
    ...
            to =3D raw + front + len;
            memcpy(to, from, back);

Since len is an unchecked u32 passed from the BPF program, if a very large
len is provided, could copy + len wrap around in 32-bit math and result in
a small memory allocation?

If so, the pointer arithmetic for the destination variable would calculate
an address far beyond the allocated page, potentially causing the memcpy()
to write controlled payload data out of bounds.

[Severity: High]
This isn't a bug introduced by this patch, but looking at the same
allocation in bpf_msg_push_data():

    page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));

It appears to omit the __GFP_ZERO flag. Since only the original front and
back regions are explicitly initialized, does this leave the newly inserted
len bytes uninitialized?

If the BPF program does not manually overwrite these bytes, could
uninitialized kernel memory become part of the packet payload and be
transmitted over the network?

[Severity: High]
This is a pre-existing issue, but while reviewing the scatterlist shifts, I
noticed sk_msg_shift_left() in net/core/filter.c updates the data array:

    do {
        prev =3D i;
        sk_msg_iter_var_next(i);
        msg->sg.data[prev] =3D msg->sg.data[i];
    } while (i !=3D msg->sg.end);

However, it doesn't appear to shift the corresponding bits in the
msg->sg.copy bitmap.

Could this desynchronization cause read-only or cloned elements to lose
their copy flag, allowing them to be incorrectly mapped as writable by
sk_msg_compute_data_pointers()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610081218.5067=
09-1-rhkrqnwk98@gmail.com?part=3D1
