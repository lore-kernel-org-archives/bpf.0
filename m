Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBD40D579
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829691; cv=none; b=Bels4E3Yhk6c+F1wlINiS+K4+KyTcO3/YRXoLL+80MeNdbtxV9giI8EXnAqpWDaQ+Xa+KN5HnYxF60TZMoEnnfledn5uy6l5HSqLMXwWqo0hzz967ZlKXZ7CpsdeuGGGBfjoDYgZSg0BJCYqe6BNIOTJgLQ422urAqxhma/A4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829691; c=relaxed/simple;
	bh=F0ETjK9arEGuk69OUso0SfT6PCEwR7WsPC+GxMbSLRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lZuo2tljbgpTesCBXfzI9tkI55xdbW+0oPhDy+xPrKmhN8Obj/3zT0dYTBaLUJYIPzA0Ll8NTDew7ntvgoxm3JF/xos2geuXUkemBusZot3LjgcpItzzhAmSClhe+qVId19d6xlJoQ1YbYeVSe+z73CcgseDB0IPzHEAMeS9i88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El9VeCdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El9VeCdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E331F000E9;
	Fri, 19 Jun 2026 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829690;
	bh=qTqm6qTUUSWnc1uLPkUy4f+S0quKeOQ24WhbPLtVa6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=El9VeCdJLgv24TZLiOJq6wqF2lUBJKpnyY47wNSxHP2atxwtZyb6bdnFMtLu/4B03
	 VBg6pBao7ZWt8gIhfyMlRqEAvRpqMoR947MuKdNkfuUa7wXWATgbquDQyite5CKLbp
	 gO9I2iUVctrq45/Xz8z691sMym+3zShp57KNaxEXdAnv6fHTbp+sWDwYspMaRpOP28
	 KH5t1ZJyFm5fx+j8qFV3isUZVUituL7mkRtpkkUoqrQ8LTAAcPVUiWwnvo1QBuKJJK
	 aJfpNe24Wcg01L4njDw5pW9P8ZlFKyvtBscLX8PHegrBUkIlbkhsPaNoFLWCPHr7JP
	 o8xivP6bhrlog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 4/8] libbpf: ringbuf: Handle position counter
 wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-4-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
 <20260618-bpf-ringbuf-fixes-v2-4-33fde039ddf3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:41:29 +0000
Message-Id: <20260619004130.23E331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF ring buffer permanently fails for 32-bit user space applic=
ations running on 64-bit kernels after 4GB of data transfer.
--

commit f2aeeb4a1cf7d41d48bd7bbff2ebee0477b1c33c
Author: Tamir Duberstein <tamird@kernel.org>

libbpf: ringbuf: Handle position counter wrap

This commit addresses an issue in ringbuf_process_ring() on 32-bit systems
where the counters can wrap. It changes the loop condition to compare the
consumer and producer positions for equality instead of magnitude.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 5737e02c16703..1c5bce2b5e12d 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -274,7 +274,8 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	do {
>  		got_new_data =3D false;
>  		prod_pos =3D smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +		/* Positions wrap; the consumer cannot logically pass the producer. */
> +		while (cons_pos !=3D prod_pos) {

[Severity: High]
This isn't a bug introduced by this patch, but since we are handling 32-bit
counter wrap logic here, does this also expose the compat mismatch between
32-bit userspace and 64-bit kernels?

In tools/lib/bpf/ringbuf.c, struct ring defines consumer_pos as an
unsigned long pointer. On a 32-bit userspace, this maps and writes 4 bytes.
However, on a 64-bit kernel, struct bpf_ringbuf in kernel/bpf/ringbuf.c
defines consumer_pos as an 8-byte unsigned long.

Because of little-endian mapping, a 32-bit userspace app only overwrites
the lower 4 bytes of the kernel's 64-bit consumer_pos. When the userspace
counter wraps around 4GB, it writes a small value back to the lower 4 bytes
while the upper 4 bytes remain zero.

Meanwhile, the kernel's 64-bit producer_pos continues to increment past 4GB.
When bpf_ringbuf_has_space() evaluates new_prod_pos - cons_pos, the
difference evaluates to larger than 4GB, exceeding the ring buffer's
capacity mask.

Could this permanently fail all further kernel ring buffer reservations,
effectively deadlocking compat tasks once 4GB of data is transferred?

>  			len_ptr =3D r->data + (cons_pos & r->mask);
>  			len =3D smp_load_acquire(len_ptr);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-bpf-ringbu=
f-fixes-v2-0-33fde039ddf3@kernel.org?part=3D4
