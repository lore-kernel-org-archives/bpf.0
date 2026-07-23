Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74872370AF1
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824808; cv=none; b=mqLz7oIdj2UxWQ+nRqMpGVo6w6QKbkZYJ8UJLbHi0Y8m9SVz2P4exk55zfcAiM9iAOaM2PknN/Z+4ssjcoT47XYkOVPU+cjrpUdDlue/HK8KijFUaVw9oQnxEW9pKsqyJeF3GISKQv8xT4vL2xY4r8hzaRP0t4WSto0YGgCZi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824808; c=relaxed/simple;
	bh=3VdRypReSFgZUVPIe2s3Fws3zndJ6jyqz2f8n8JwF9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MzFKNcaeiMPza2K7MmbmUWNhreBLXD+2OM/lF5u6faWJ31Dd38chOVSBEGauLBUY8WbaCvxuF9RouZzY3DvR1aSApDfcyJo2RvIJ10F7Q5Ogn0Peq+DtcoRYhZwvMG+F+yPHSuQzIAwFlqs+S9vqVlJ1GtPmIQ0i9WOQa36JqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II78pOR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II78pOR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7781F00A3A;
	Thu, 23 Jul 2026 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824805;
	bh=Ba90h8ClPs5nosYKeCvNtSNYhSzjQVSPbXzWcgDui2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=II78pOR5w4bg4n6B/UlM60g7bE0mTUmHFOysDdruAaVdDzDAjGUnqrHeWE7fsgq7D
	 LOZriKZ5Fdi2Uu0csXV7wVCZJLqLOJkugUrw2qn7+A7LuUODkzHvkPfcTnChTOYjOb
	 7B3hUoEuxwkoPZqYlS1sZl2B7oETgvYOnUeqVJmdbG4u657W12PQJ1zwvSBHY9YPHr
	 xi3lLZ68A69241uleNn5kQJDKLI0VkXVTl38S+pv8i+rKjwjGyj6Dr1GuKIVc4hQ3u
	 fhSr3mxflBdDZGzGSeKcdd/QzHp8HAwdcL4W2qY6sBYGOHy7YE8Ewgio2ohTBl1Dt1
	 gu8QdLe8YKUTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in
 tcp_bpf_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:39:45 +0000
Message-Id: <20260723164004.EA7781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] ABA problem in pointer comparison causes `msg_copied` to retain st=
ale values, leading to incorrect rollback of `copied`.

Pre-existing issues:
- [High] Incomplete fix leads to integer underflow in `copied` for `__SK_PA=
SS` and `__SK_DROP` verdicts when a persistent cork fails.
- [High] Premature cork completion due to subtracting loop-invariant `size`=
 instead of the copied amount `ret`.
--

--- Patch [1]: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendm=
sg() ---
commit bd0bfd2d01fcc018a6a3e62db13f0096892e960b
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which drops
and reacquires the socket lock. Its error path used the current value of
psock->cork to decide whether msg_tx named the stack-local temporary
message.

Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev@g=
mail.com/

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..fcf535b7a7546 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -428,12 +430,18 @@ static int tcp_bpf_send_verdict(struct sock *sk, st=
ruct sk_psock *psock,
>  			psock->cork =3D kzalloc_obj(*psock->cork,
>  						  GFP_ATOMIC | __GFP_NOWARN);
>  			if (!psock->cork) {
> -				sk_msg_free(sk, msg);
> -				*copied =3D 0;
> +				int free;
> +
> +				psock->cork_bytes =3D 0;
> +				free =3D sk_msg_free(sk, msg);
> +				*copied -=3D min_t(u32, msg_copied, free);
>  				return -ENOMEM;
>  			}

[Severity: High]
This is a pre-existing issue, but does the __SK_PASS path need this same
msg_copied bounds check?

When the verdict evaluates to __SK_PASS but tcp_bpf_push() fails,
the error path unconditionally subtracts the full freed amount from copied:

tcp_bpf_send_verdict() {
...
        case __SK_PASS:
                ret =3D tcp_bpf_push(sk, msg, tosend, flags, true);
                if (unlikely(ret)) {
                        *copied -=3D sk_msg_free(sk, msg);
                        break;
                }
...
}

Similarly, does the __SK_DROP path have the same issue?

tcp_bpf_send_verdict() {
...
        case __SK_DROP:
        default:
                sk_msg_free(sk, msg);
                sk_msg_apply_bytes(psock, tosend);
                *copied -=3D (tosend + delta);
                return -EACCES;
}

If data accumulates in a persistent cork across multiple syscalls,
subtracting the full size here causes copied to underflow. Could this be
returned to userspace as a bogus error code or a massive positive return
value?

[ ... ]

> @@ -545,9 +555,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t size)
>  		if (!sk_stream_memory_free(sk))
>  			goto wait_for_sndbuf;
>  		if (psock->cork) {
> +			if (msg_tx !=3D psock->cork)
> +				msg_copied =3D 0;
>  			msg_tx =3D psock->cork;
>  		} else {

[Severity: High]
Is this pointer comparison vulnerable to an ABA problem?

If sk_stream_wait_memory() is called later in this loop, it drops the
socket lock. While asleep, a concurrent thread could acquire the lock,
complete and free the existing psock->cork.

Another thread could then allocate a new psock->cork, and the slab allocator
might return the exact same memory address.

When this thread wakes up and reacquires the lock, the check
(msg_tx !=3D psock->cork) would evaluate to false because the pointers matc=
h,
and msg_copied wouldn't be reset. On a subsequent error, could this cause
an artificially inflated msg_copied to be subtracted from the total copied
amount?

[ ... ]

> @@ -564,10 +577,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t size)
>  					       copy);
>  		if (ret < 0) {
>  			sk_msg_trim(sk, msg_tx, osize);
> +			err =3D ret;
>  			goto out_err;
>  		}
> =20
>  		copied +=3D ret;
> +		msg_copied +=3D ret;
>  		if (psock->cork_bytes) {
>  			if (size > psock->cork_bytes)
>  				psock->cork_bytes =3D 0;

[Severity: High]
This is a pre-existing issue, but does the cork_bytes accounting use the
wrong size variable here?

tcp_bpf_sendmsg() {
...
                copied +=3D ret;
                msg_copied +=3D ret;
                if (psock->cork_bytes) {
                        if (size > psock->cork_bytes)
                                psock->cork_bytes =3D 0;
                        else
                                psock->cork_bytes -=3D size;
...
}

Here, size is the total loop-invariant syscall size, while ret is the
dynamically copied amount for this iteration. If ret < size (e.g., due to
scatterlist limits or memory exhaustion), subtracting size will deplete
cork_bytes faster than data is actually copied.

Could this cause premature cork completion and truncated messages being sent
to the BPF program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723162602.3275=
661-1-nicoyip.dev@gmail.com?part=3D1
