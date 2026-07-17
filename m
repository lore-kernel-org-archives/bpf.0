Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D531D381
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256774; cv=none; b=u1vKFHk00O6S0RgbsEYbHwI8LDd5zp6pdt3PWJnYyN7Rk/+cjla8rvYPHEFj+zryACZ1UJ8HAHnzo2noQXXPl4EeGCYxaFb8BJB2SM3Xx6LGXOB0IijBcWdvypVzQrK6b3RspRMxlVYI5oJDpTaoMTKKiaah8Q4z+8XqiG/aqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256774; c=relaxed/simple;
	bh=uatSludlOAXuY3aDExaDqB8gPuymhXC1CXQdudAfQVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fXnq1K6MX/wgUT6aaFvuVLwbpvetRjP3FlRDCpttDyDvUiyYPND8EbtDouj8id+/XcMiHq6a/QMrQWsX/LAYFH+4B1/6Ny7/1eM9xtzyGgI5o/0FGHE25fQDMGS31H8hZqNBtP+h2TPJpQ3pHOsd2dGzmeLxoRamLvtcvdNpopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEmV+hqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEmV+hqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EEB1F000E9;
	Fri, 17 Jul 2026 02:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784256773;
	bh=lC5zRwFW/+m2cqZWiw20OPNoPHi6Hjk2jPdle7gf1mY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEmV+hqLLGoqPIO4G1TNf3KjCgLpxKIUlS8mDcvL5qObKJON70oCVGQUz9dECNI4s
	 3yJdDJUIONzZ6nz6fOuHQb5vtQpWclce49ClrbycC8oAmw0NSPGyyMIwkxdlikiutv
	 /kGqnUjnwnZaL7VOZiY24YfaWsBKT+dlckbXHJT9CWfU8AgEvVoGT15QRzDSGDh1P+
	 X5ThCp9GAVlXwig+iuvJVsCJRZE1+RDpD4BSBosTl2VroScDjc21JXl0UHDwaWSEEH
	 KTHHQxvc7778EKK2RXcRReoy5Yv3QAA4K3bKf6NZs4WmwI8xRfbGXGwqtGKvoRWFPm
	 Wat7YARvTZszw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
References: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:52:52 +0000
Message-Id: <20260717025253.23EEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a multi-line comment that violates the BPF sub=
system comment style guidelines.

Pre-existing issues:
- [High] Double-put and wild pointer dereference of batch sockets on the fi=
rst bpf_iter_tcp_realloc_batch failure path.
--

--- Patch [1]: [PATCH bpf v2] bpf: tcp: Fix use-after-free in bpf_iter_tcp_=
established_batch() ---
commit c52d637a13758169d9dce0d7c05be97965d399d3
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

This commit fixes a use-after-free issue in the TCP iterator caused by
request sockets being published to the ehash chain with a refcount of 0
before being updated. The fix uses refcount_inc_not_zero() to safely handle
these sockets during batch iteration. It also refactors the batch completion
logic to rely on whether any sockets were left behind during the walk.

Link: https://lore.kernel.org/bpf/20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e=
69495@linux.dev

> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3073,24 +3073,24 @@ static unsigned int bpf_iter_tcp_established_batc=
h(struct seq_file *seq,

[ ... ]

>  	sk_nulls_for_each_from(sk, node) {
> -		if (seq_sk_match(seq, sk)) {
> -			if (iter->end_sk < iter->max_sk) {
> -				sock_hold(sk);
> -				iter->batch[iter->end_sk++].sk =3D sk;
> -			} else if (!*start_sk) {
> -				/* Remember where we left off. */
> -				*start_sk =3D sk;
> -			}
> -			expected++;
> +		if (!seq_sk_match(seq, sk))
> +			continue;
> +		expected++;
> +		if (iter->end_sk < iter->max_sk) {
> +			/* reqsk_queue_hash_req() inserts with sk_refcnt =3D=3D 0
> +			 * and refcount_set()s it after the bucket lock drops.
> +			 */

[Severity: Low]
Does this multi-line comment follow the BPF subsystem comment style?
The BPF subsystem guide expects the opening block to be on its own line:

/*
 * reqsk_queue_hash_req() inserts with sk_refcnt =3D=3D 0
 ...

> +			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +				continue;

[ ... ]

> @@ -3128,12 +3128,14 @@ static struct sock *bpf_iter_tcp_batch(struct seq=
_file *seq)
>  	struct sock *sk;
>  	int err;
> =20
> +again:
>  	sk =3D bpf_iter_tcp_resume(seq);
>  	if (!sk)
>  		return NULL; /* Done */
> =20
>  	expected =3D bpf_iter_fill_batch(seq, &sk);
> -	if (likely(iter->end_sk =3D=3D expected))
> +	/* sk carries the first socket that did not fit in the batch. */
> +	if (likely(!sk))
>  		goto done;

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the reallocation
failure path that occurs just after this block in bpf_iter_tcp_batch().

If bpf_iter_tcp_realloc_batch() fails, the function calls
bpf_iter_tcp_put_batch() and returns an error without clearing iter->end_sk.

When this happens, bpf_iter_tcp_put_batch() overwrites item->sk with a
cookie:

net/ipv4/tcp_ipv4.c:bpf_iter_tcp_put_batch() {
    ...
    while (cur_sk < iter->end_sk) {
        ...
        sock_gen_put(item->sk);
        item->cookie =3D cookie;
    }
}

Because the seq framework subsequently calls bpf_iter_tcp_seq_stop(), it se=
es
iter->cur_sk < iter->end_sk and calls bpf_iter_tcp_put_batch() a second tim=
e.

Could this lead to a wild pointer dereference when sock_gen_put() tries
to use the cookie as a socket pointer during the second pass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-bpf-iter-t=
cp-refcnt-v2-1-8e81f0ac6f3e@linux.dev?part=3D1
