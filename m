Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A23AC00
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143857; cv=none; b=e96c650m988fWp5AjqICXoZhDirQq1zcvvsM3O97+9D/+FfyVEYby2TxJRjlzfPzztBkDg8Jz+N4P1qpNsocpCYI6x+E9vZC/axLKuGtvw68LbLvYi3ldOIDJOgZVDr9t9oL5nFEAWUcNk7yyc9zg5qEkRI7VzXCT2THwKRwCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143857; c=relaxed/simple;
	bh=LMbhFpboMTeGxaldq7o4VW8ah/2rdaECF2ByDDXcFWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/9bq7OwePGsimjKWnOmVkYWnAJE9+oqPwDbqYrErxif5s8wfJp5CVSLFv/fXoPqaT8DOf2Bgez6UgOZ2e7wDcR2h+7TfZVHhGF5yhBKigbmwzMH5gxok6bRfYyXk2qQ8Y5RLrTkhO99zyS5OYiM1N7zKUN7AWBgeJaYWcMkN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1D9neZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1D9neZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7379C2BCB0;
	Sat, 25 Apr 2026 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777143857;
	bh=LMbhFpboMTeGxaldq7o4VW8ah/2rdaECF2ByDDXcFWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E1D9neZJTMU6DKbVYpp16cjuiAWQF/DsxcROyZ4/cQBtiOWlvQdcLiHOfJNv0OEPn
	 dH+RAa91pbLoTJdHLU732xXwOS/k8H7NbrsRTswCD+eWVqxZEJVnGy94ByOawO3fRz
	 3UoJvS6+XkoVoaPzefdjTcP+uLXttBJUcZU5eJCXPLa1Sg1BUeQUi2rzcwC9AlayQb
	 /cvW1ME35ni+0bfMoxe8Q0B2don1lJ1GqoNa2w34kdP/tDAFfsye23Q8b7hxx5ymHE
	 +uNZBJ4pJzGiS4baiwdxAdsJgNb05YS2N9g/i2IGG2WYPu4npQvNS7N+ZZDyGH/pbv
	 LAE8SOb50y6fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424190310.1520555-2-bestswngs@gmail.com>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 19:04:16 +0000
Message-Id: <20260425190416.E7379C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [Critical] Unbounded `len` causes `copy + len` integer overflow, leading =
to an exploitable out-of-bounds kernel write.
- [Critical] Appending to a full `sk_msg` wraps the ring buffer index, corr=
upting the last element and causing an out-of-bounds read/write.
- [Critical] Scatterlist element shifting desynchronizes `msg->sg.copy` bit=
map, allowing unauthorized direct writes to shared pages.
- [High] Incorrect scatterlist offset calculation when splitting elements c=
auses out-of-bounds memory read.
- [High] Appending to an `sk_msg` with 1 free slot reads garbage length, in=
flating payload size and leaking uninitialized memory.
- [Medium] Unnecessary zeroing of compound pages in atomic context causes l=
atency spikes.
--

commit b1bf1a9196d24b0457d32d17aa1980fac2aeeebd
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

The commit attempts to fix a kernel heap information leak in
bpf_msg_push_data() by adding __GFP_ZERO to the alloc_pages() call. This
zeroes out the allocated pages before they are added to the scatterlist,
preventing uninitialized memory from being sent to userspace.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772b2..3422cbf09c7da2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;

This isn't a bug introduced by this patch, but when appending data (start =
=3D=3D
msg->sg.size) and exactly 1 free slot remains (space =3D=3D 1), the search =
loop
exits with i =3D=3D msg->sg.end. Does this fallback path read from an unuse=
d ring
buffer slot containing uninitialized garbage, since
msg->sg.data[msg->sg.end].length is used here?

Later, this garbage value is added to len to set the new element's length,
inflating it far beyond the copied data.

Also, when appending data to the exact end of a message with no free slots
(space =3D=3D 0), the search loop terminates with i =3D=3D msg->sg.end and
msg->sg.end wraps to msg->sg.start. Does this code mistakenly copy the
length of the first element in the ring?

Then when calculating back:

	if (i =3D=3D msg->sg.end)
		sk_msg_iter_var_prev(i);
	psge =3D sk_msg_elem(msg, i);
	front =3D start - offset;
	back =3D psge->length - front;

If the first element is shorter than the last, couldn't back become negative
and pass a large unsigned size to memcpy(), leading to an out-of-bounds
write?

> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZER=
O,
>  			   get_order(copy + len));

Does copy + len overflow here if a BPF program passes a very large len
(e.g., 0xFFFFF000)?

Since both are 32-bit integers, couldn't this wrap around to a small positi=
ve
value, causing get_order() to allocate a much smaller buffer than required,
and later lead to an out-of-bounds memcpy() when to =3D raw + front + len?

Additionally, if a BPF program passes a valid len that requires a high-order
compound page (e.g., 32KB or 64KB), will synchronously zeroing the entire
memory block under GFP_ATOMIC with preemption disabled introduce latency sp=
ikes
into the network fast-path?

Would it be better to allocate normally and use memset() to zero only the
exact gap of uninitialized len bytes?

>  	if (unlikely(!page))
>  		return -ENOMEM;

This isn't a bug introduced by this patch, but later in the same function w=
hen
inserting data into the middle of a scatterlist element:

	if (start - offset) {
		if (i =3D=3D msg->sg.end)
			sk_msg_iter_var_prev(i);
		psge =3D sk_msg_elem(msg, i);
		rsge =3D sk_msg_elem_cpy(msg, i);

		psge->length =3D start - offset;
		rsge.length -=3D psge->length;
		rsge.offset +=3D start;

Is rsge.offset incorrectly advanced by the absolute logical byte offset
start?

Shouldn't rsge.offset instead be advanced by the relative number of bytes
consumed by the first half (which is start - offset)? Does this absolute
offset addition cause an out-of-bounds memory read when transmitting the
scatterlist element?

Lastly, further down in the function when shifting entries:

	while (i !=3D msg->sg.end) {
		msg->sg.data[i] =3D sge;
		sge =3D nsge;
		sk_msg_iter_var_next(i);
		if (rsge.length) {
			nsge =3D nnsge;
			nnsge =3D sk_msg_elem_cpy(msg, i);
		} else {

When bpf_msg_push_data() shifts existing scatterlist entries to the right to
make room for new elements, it appears to miss shifting the corresponding b=
its
in the msg->sg.copy bitmap.

Does this desynchronize the copy-on-write tracking?

If a shared page is shifted to an index with a cleared bitmap bit, could a
subsequent bpf_msg_pull_data() directly overwrite memory belonging to other
sockets or the page cache?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424190310.1520=
555-2-bestswngs@gmail.com?part=3D1
