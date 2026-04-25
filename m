Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2F155C82
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777144789; cv=none; b=HwspZhUnVXVkIA/qxTSF+kGZzgko5Ixmlv07eD6Vuq63PVF1vNPMuiL5MCqaQR2S5Tc7F1BqUS8Hv4ngYM72qNUOLcjudr93NYjJNFCyBtroTFn3jk3RHOZJHm5d3b4TV89NdOyvgNnN6iB62giT6NUTztVpA0YyDienaOZuhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777144789; c=relaxed/simple;
	bh=qSvPt0fvO3MCclrDqqwXmKbzM3YWaZ5Sqx8aAtx9WlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PdD9udJVEV4zYEAUGkPAzDob0vJE/joOZ4MhLoZZneU9WbVGt5JwtKoRwvURGK6G/q/R5nXOdwrk0d1OiNeiRlEx71nzRSMeYAi44etY97u4c2bvGSNs33OBQYIz096Us7THYM1iLcgMqL3UQokWt8GgX2aNMtlpG6RnmZk8QsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRvqV9XG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRvqV9XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924FCC2BCB0;
	Sat, 25 Apr 2026 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777144789;
	bh=qSvPt0fvO3MCclrDqqwXmKbzM3YWaZ5Sqx8aAtx9WlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LRvqV9XGEtWdlmp1ZoPkIR66tq54fcj6rQMHHQNkrXmpnqwCfqpc9/FyDm4jFQH7h
	 dkcIal2JoyFjI3bz22zPs365yUka8JSyerVVIUumpCK2qo4kF5q3wF0VjI38YsZFDd
	 91f7Xu731js1TAG5rvwjrTO9y3yy4q2Tu1ezVjyVWpT1TWhxRAi1nzO/kzir6WEwKy
	 pb2XXL8horxnHklt8A1Qokdj9NgQCogusmlM2gfUyzn5ghfqHja5Nn5QOXYN6zzlYM
	 RWBsHpDkmtgZKl9uffSs3k3I7zls9MphwSVieYRbteIUHxJd6HIH12Yj8gYJJC5C7E
	 w2HF6kSO/v3GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: reject overflowing copy + len in
 bpf_msg_push_data()
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424191602.1522411-3-bestswngs@gmail.com>
References: <20260424191602.1522411-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 19:19:49 +0000
Message-Id: <20260425191949.924FCC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Heap buffer overflow when appending to a full ring buffer
- [High] Out-of-bounds physical memory read due to incorrect rsge.offset ca=
lculation
- [High] Information leak due to uninitialized kernel memory in pushed data
- [High] State corruption because msg->sg.copy bitmap is not shifted
- [Medium] Memory limit bypass via unaccounted sk_mem_charge
--

commit f82297413325a738aacdfa77689e82663d5e3cc8
Author: Weiming Shi <bestswngs@gmail.com>

    bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()

    When the scatterlist ring is full or nearly full, bpf_msg_push_data()
    enters a copy fallback path and computes copy + len for the page
    allocation size. Since len comes from BPF with arg3_type =3D ARG_ANYTHI=
NG
    and both are u32, a crafted len can wrap the sum to a small value,
    causing an undersized allocation followed by an out-of-bounds memcpy.

    Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kerne=
l.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772b2..76965cc7ea2f22 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2820,6 +2820,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;

When appending data to the very end of a full ring buffer (space =3D=3D 0 a=
nd
start =3D=3D offset + l), the search loop terminates with i =3D=3D msg->sg.=
end.
Does this assignment read a garbage length from the empty slot at
msg->sg.end? Since sk_msg_shift_left() does not clear slots when shifting
elements, this slot could contain the length of a previously used element.

> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));

Since this page allocation does not use __GFP_ZERO, can this leak
uninitialized kernel memory? If copy =3D=3D 0, the entire allocated len byt=
es
are added to the scatterlist payload without initialization. If copy > 0,
the existing data is copied to the front and back of the new page, but
the len bytes in the middle are left untouched.

Also, if copy read a garbage value from the empty slot above, can this
lead to a heap buffer overflow? Later in this function, i is correctly
stepped back to msg->sg.end - 1, and front is calculated as start - offset.
If the true length of the last element (front) exceeds the garbage length
read into copy, would the memcpy(raw, from, front) overflow the allocated
page?

[ ... ]

Can this result in an out-of-bounds physical memory read? When inserting
data into the middle of a scatterlist element, the back half (rsge) is
advanced by start:

	if (start - offset) {
		if (i =3D=3D msg->sg.end)
			sk_msg_iter_var_prev(i);
		psge =3D sk_msg_elem(msg, i);
		rsge =3D sk_msg_elem_cpy(msg, i);

		psge->length =3D start - offset;
		rsge.length -=3D psge->length;
		rsge.offset +=3D start;

Since start is the absolute byte offset from the beginning of the entire
message, should this instead add the relative offset within the element
(start - offset or psge->length)? By adding start, rsge.offset skips an
additional offset bytes, which might point past valid physical page
boundaries when the packet is transmitted.


When inserting a new element, the existing scatterlist elements are
shifted to the right:

	while (i !=3D msg->sg.end) {
		msg->sg.data[i] =3D sge;
		sge =3D nsge;
		sk_msg_iter_var_next(i);
		...

Does this shifting loop need to correspondingly shift the msg->sg.copy
bitmap?

Without updating the bitmap, shifted elements will inherit the copy state
of the previous elements at those indices. If a read-only or zero-copy
element is shifted into a position where the copy bit is cleared, could
a BPF program be erroneously granted direct write access to it via
msg->data?


Is it possible to bypass memory limits here?

place_new:
	/* Place newly allocated data buffer */
	sk_mem_charge(msg->sk, len);
	msg->sg.size +=3D len;

Since sk_mem_charge() only subtracts the memory size from
sk->sk_forward_alloc without validating limits, does this need a prior
call to sk_wmem_schedule() to verify and allocate memory against the
socket limits? Without it, could a BPF program repeatedly push data and
drive sk->sk_forward_alloc deeply negative?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424191602.1522=
411-3-bestswngs@gmail.com?part=3D1
