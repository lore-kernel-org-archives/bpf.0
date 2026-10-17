Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D52931F4
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207908; cv=none; b=VAqqmS2MPKwBYMSiiZm/LNTbOZbgWQZgnW5E9H7V77Ya7QTfXT9mvKePtbqc5c1KmSXRZzq89p9/cXqFksqexsAZPAB9HA1/WRPU+pyBjerX+KWVYcLTwVLanPMPNCkqlj1F1cJkMw8NrScN++ZKvwTWsqe9TSHPuqSJIWvDD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207908; c=relaxed/simple;
	bh=PRE/xkcCTtTFO1VhinD26Lu6hDoA+VpQ3avmjn7KfUY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=svqMqHAyNXbOaZh9KcH40k46zRbLHBPLXZPb2JD/528bEH5T6/K6V09ycnJlCjLyIFgmN9mGt0wmTLTwPrK6LZGl84hiF6HqnLKp2ws691f+ugymdFwT074AOY/232UHYJYeteJs0L+AaQt7D2JY7WfM4tYCL9BgzlDuH2R15Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR7ASMh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR7ASMh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96271F000C4;
	Sat, 17 Oct 2026 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792207907;
	bh=hD23KHEubOVcHA3jW6x59rOSLJLHGiLbH5EF/Y76Un8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LR7ASMh9YUkU4fjK5RYiHK4GJ8ByzYYjBTSLxlRtUuj98isDyWzc4Mtr7J20UznU7
	 X6r2SK3nWJVv0iK2+2KIttR8JUgMyOmjbGIHyvQ5KRMgeXox3hohlni66LhPJCgRLl
	 fYd/TAjkdX/pF4nTiOu7WSU6yexRSKTpXSGrs6uAaH0buCnLA7dxhpQCkjmgRlKXxg
	 vhLl4l6iAGQs/TRmyQQsfTLV6/JeYJRDGPaAjRzHZJ18gAvXXkuXfZTCJyREuF4696
	 1wqunzqfJx+p4Z0Jp+8globQU6WPzbKFSHhYPf+sMveWR0FI86YuSAYid6p0uRuQgi
	 xiz/2Eb+Bq3lg==
Message-ID: <sashiko-outbox-175251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/2] tls: annotate lockless access to
 sk->sk_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quanye Yang" <quanyeyang@proton.me>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me>
References: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
 <20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 03:31:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tls: SG chain corruption via lockless sk_err consumption race
--

commit af572fb8fe2e730f2c3767f401e262816bb05b1d
Author: Quanye Yang <quanyeyang@proton.me>

tls: annotate lockless access to sk->sk_err

This commit annotates lockless reads of sk->sk_err using READ_ONCE()
across various TLS data paths to prevent compiler optimizations. It folds
multiple unannotated reads into single variables for consistency within
a function execution block.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@r=
edhat.com/

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f293..4221b2ad3c1d3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
[ ... ]
> @@ -488,13 +489,15 @@ static void tls_encrypt_done(void *data, int err)
>  	sge->offset -=3D prot->prepend_size;
>  	sge->length +=3D prot->prepend_size;
> =20
> +	skerr =3D READ_ONCE(sk->sk_err);
> +
>  	/* Check if error is previously set on socket */
> -	if (err || sk->sk_err) {
> +	if (err || skerr) {

[Severity: High]
Can a concurrent lockless call to getsockopt(SO_ERROR) clear the error state
here?

If getsockopt() consumes and clears the socket error via xchg(), skerr
could read as 0. Does this allow the code to bypass the error check and
transmit data on a connection that has already been aborted?

[ ... ]
> @@ -701,13 +704,17 @@ static int tls_push_record(struct sock *sk, int fla=
gs,
>  static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  			       u8 record_type, ssize_t *copied, int flags)
>  {
> +	int skerr;
>  	int err;
> =20
>  	err =3D tls_push_record(sk, flags, record_type);
> -	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
> -		*copied -=3D sk_msg_free(sk, msg);
> -		tls_free_open_rec(sk);
> -		err =3D -sk->sk_err;
> +	if (err && err !=3D -EINPROGRESS) {
> +		skerr =3D READ_ONCE(sk->sk_err);
> +		if (skerr =3D=3D EBADMSG) {

[Severity: High]
Is it safe to rely on reading the transient socket error to clean up a
fatally broken record?

When tls_push_record() prepares the scatterlist for encryption, it modifies
the list irreversibly (for example, by appending the content type via
sg_chain). If encryption fails synchronously, tls_err_abort() sets the
socket error to EBADMSG.

If a concurrent lockless call to getsockopt(SO_ERROR) consumes and clears
the error, the READ_ONCE() here might return 0 instead of EBADMSG.

Does this cause the cleanup to be bypassed, leaking the corrupted record in
the open record context? If so, on the next sendmsg() call from userspace,
reusing this corrupted record and appending new data might overwrite the
scatterlist chain link with a page pointer, potentially leading to memory
corruption or a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-tls-fix-sk=
-kcsan-err-v4-0-391d788327f3@proton.me?part=3D1
