Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99E3E314C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031179; cv=none; b=X9aqiKBk3y+6zwJ7QK95sWBT0Q2+t2c4BG18GmWGx/xgIVAzgnc0YRM/BfJBBR7j8wwlBZKdiLd5o3+AcqoXvAx3Q6OK0ZKzDYmHM4jfqnBXx5rINWfOGXe3N+1mo5XCvYt57m6crdew/yY69R3o2pm0lx7IdVUEUaLOo2PHmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031179; c=relaxed/simple;
	bh=TLqXQpH0GrCodlLr/XLoKgZQIs7QBgJk4tzNq9k1Wzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRXrkET++y3GfwymWMlM3WfYOeholrIcja8wLci1dvQ/cfrNds9B/kZFW0g3aacZoapWZ4C4EkZmzKO5M/w0TjVWLF/q5qxxykr1d1kbAadF+wL+fnfVcYHog2MBz39IJY0tT/tn/6nL+zF0mfmOYzcCeLC2uTrf9P58PpKHjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/gbX5ZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/gbX5ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09111F00893;
	Tue,  9 Jun 2026 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031177;
	bh=VbVj1+5LOE7ysrBmrXthSgba00HMoHk2Wt3N/eDcbO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/gbX5ZXzDbcA72jZRCjOqJWP8qRbPGeshNw1OjF6ohU4jd8b6F1ctU+h0pKFM5bl
	 XwV3BGlAv6oCr39wpg1oMKS5F9WsStpLhfggN/yZrG7VVtggCQhiTf5PejNEZuymCS
	 1/fIlz5jMu8ORV07ZtlHTs3aa46AzbqsivGjURX9Z8VdRgGWCWEqVX7gi2xouJmvMh
	 O7C7Js4SeY5fbfy1lTroUb4ZjhwsAjrsQ2Bes9jJU4agQl+2AWiVQ4GhKcer31scc0
	 XM9AWR7PbU1p+eXfxGniDYP18aY8DHWcqWsSrJDU1A/IBVoOEZiWOsQrtN/vWz5DA6
	 ZjpI7cnIUQXig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
References: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:52:57 +0000
Message-Id: <20260609185257.A09111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded `len` parameter in `bpf_msg_push_data` causes a 32-bit i=
nteger overflow when calculating the page allocation size (`copy + len`), r=
esulting in an out-of-bounds heap write.
- [High] Incorrect scatterlist element offset calculation when splitting an=
 element in `bpf_msg_push_data` inflates the page offset, leading to out-of=
-bounds memory accesses.
--

commit 619f5b1d1aebdbd6457c3ac6e3a92bc45be7278c
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check

start and len are u32, so start + len evaluates in 32-bit and wraps before
storing it in last. The bounds check can then be passed with an out-of-range
start/len.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..31467c0b4279e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2974,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> +	u64 last =3D (u64)start + len;

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the integer
overflow in bpf_msg_pop_data(), could a similar overflow occur in
bpf_msg_push_data()?

Looking at net/core/filter.c:bpf_msg_push_data(), both copy and len are u32:

	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));

If a large len is provided, copy + len could wrap around to a small value,
resulting in a much smaller allocation than required.

Later in the same function:

			to =3D raw + front + len;

			memcpy(to, from, back);

Since len is zero-extended to a 64-bit pointer offset, to evaluates to an
address far outside the allocated page. Could this result in an out-of-boun=
ds
write if a BPF program provides a maliciously large len?

[Severity: High]
This is another pre-existing issue in bpf_msg_push_data(), but does the
scatterlist element split calculate the offset correctly?

When splitting an element into psge and rsge:

		psge->length =3D start - offset;
		rsge.length -=3D psge->length;
		rsge.offset +=3D start;

Is start the absolute byte offset from the beginning of the entire message?
If the split element is not the first one in the message, wouldn't rsge.off=
set
be inflated by the cumulative length of all previous elements instead of the
relative offset (start - offset)?

When the network stack eventually reads or writes to this element via sg_vi=
rt(),
could this cause an out-of-bounds access past the end of the physical page?

>  	int pop;
> =20
>  	if (unlikely(flags))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609183927.4021=
802-1-rhkrqnwk98@gmail.com?part=3D1
