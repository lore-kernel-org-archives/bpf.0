Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79C22AE48
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785581121; cv=none; b=ul3mIxtOXW0g5zC3nw4XaOMlIrgjeF1bH83n8SFS761VDZvQ94bk3+CgFXIhKbOOtmcJYnKEP0IGb39Mm9ay4dXNtWwU+itj+6sF8xqJ2RIoVnNrfZQygfHaL9CByKi+lV2Cv5kf/TaRl2yZMyj4gGWZRqdCsOskMztWppTywgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785581121; c=relaxed/simple;
	bh=+e6gfGPJZ4I038enQDVb/xx0tt7/cujtOzZWHccG7HQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M1J8BH8CDFPdqZGsdu3fGn4jMzcDg6m4Ksyp9JxfVDY6xvnpDkwHZmTq2pgfRLi3TC+jCVcDJRbSyJpGitLDeejzwOzCCm+zzBBwJ9uysxg+gPtLmVsXHAkvtAOqLukcGtDZAkUup0Pu47X/M+9L+hgCjJJW/VABbh6r5kD6ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF5p5Me7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF5p5Me7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBAA1F00AC4;
	Sat,  1 Aug 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785581119;
	bh=r3QuwlEylta1QDcKmHsID4RxxaV5wx33LgrHOwN6kOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eF5p5Me7Ry/5IZEtVrgXT6qkZFebOkh013otKkLo3myGQWYuTrBahJCPvAwNHbO2w
	 XdLoZSYcm8Bs8ZtI3M9eN/7bHNVgPuvmEfp+cEs5Wb+pcoiVhHJJzY7+U26i2F4sGZ
	 TuxfN1wkqfZEr3IQQ2TkqTJxebGUfYOmI7TUgne581RYwTDAPB6IAcWCH/e+EXAnxb
	 +VbJk/LIU9Mo7Rv5BwtDXHLdT7/tU+AdaVGKUI4K1J9pBAUPxhvFYRojLfYtcEau/h
	 ITQyBsvyFI4p025baJOM98YP7lDiJrQYbdHnGCjcrRNN/UNiW214gXWQPh3epAyIpf
	 uBMAmkUCZnHfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: settle sk_forward_alloc for
 strparser SK_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junseo Lim" <zirajs7@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801102633.1872012-2-zirajs7@gmail.com>
References: <20260801102633.1872012-1-zirajs7@gmail.com>
 <20260801102633.1872012-2-zirajs7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 10:45:18 +0000
Message-Id: <20260801104518.EBBAA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The sk_forward_alloc deficit fix is bypassed on the backlog retry =
path for strparser clones, leaving the memcg page_counter underflow bug unf=
ixed and introducing a truesize double-charge.

Pre-existing issues:
- [High] The exact same page_counter underflow vulnerability exists for non=
-strparser SKBs that already have an owner, but the patch restricts the fix=
 only to strparser SKBs.
- [High] Modification of socket memory accounting (sk_forward_alloc) withou=
t holding the socket lock in the psock backlog workqueue.
--

--- Patch [1]: [PATCH bpf v2 1/2] bpf, sockmap: settle sk_forward_alloc for=
 strparser SK_PASS ---
commit 1a3d6fb5186f9d9fdd026f8cf86dcfc1debee455
Author: Junseo Lim <zirajs7@gmail.com>

bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS

This patch attempts to fix a memcg page_counter underflow in the strparser
SK_PASS path. It adds a zero-sized sk_rmem_schedule() top-up before
reassigning receive ownership to direct strparser clones.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..ce5ad81602828 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
[ ... ]
> @@ -595,12 +596,9 @@ static int sk_psock_skb_ingress(struct sk_psock *pso=
ck, struct sk_buff *skb,
>  	struct sk_msg *msg;
>  	int err;
> =20
> -	/* If we are receiving on the same sock skb->sk is already assigned,
> -	 * skip memory accounting and owner transition seeing it already set
> -	 * correctly.
> -	 */
>  	if (unlikely(skb->sk =3D=3D sk))
> -		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
> +		return sk_psock_skb_ingress_self(psock, skb, off, len, true,
> +						 skb_bpf_strparser(skb));

[Severity: High]
Does the backlog retry path bypass this fix for strparser clones?

If a strparser clone fails in the fast path and is queued to the backlog,
the workqueue retries it. However, before the retry occurs:

    sk_psock_backlog() {
        ...
        ingress =3D skb_bpf_ingress(skb);
        skb_bpf_redirect_clear(skb);
        ...
    }

The call to skb_bpf_redirect_clear() unconditionally erases the
BPF_F_STRPARSER flag. When the retry reaches sk_psock_skb_ingress(),
skb_bpf_strparser(skb) will evaluate to false, passing settle_fwd_alloc =3D=
 false
and bypassing the fix.

>  	msg =3D sk_psock_create_ingress_msg(sk, skb);
>  	if (!msg)
>  		return -EAGAIN;
[ ... ]
> @@ -618,12 +616,14 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
>  	return err;
>  }
> =20
> -/* Puts an skb on the ingress queue of the socket already assigned to the
> - * skb. In this case we do not need to check memory limits or skb_set_ow=
ner_r
> - * because the skb is already accounted for here.
> +/* Puts an skb on the ingress queue for psock->sk.
> + *
> + * Before assigning receive ownership to a direct strparser SK_PASS clon=
e,
> + * settle any existing sk_forward_alloc deficit from earlier clone charg=
es.
>   */
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,
> -				     u32 off, u32 len, bool take_ref)
> +				     u32 off, u32 len, bool take_ref,
> +				     bool settle_fwd_alloc)
>  {
>  	struct sk_msg *msg =3D alloc_sk_msg(GFP_ATOMIC);
>  	struct sock *sk =3D psock->sk;
> @@ -631,6 +631,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock=
 *psock, struct sk_buff *skb
> =20
>  	if (unlikely(!msg))
>  		return -EAGAIN;
> +
> +	if (settle_fwd_alloc &&
> +	    !sk_rmem_schedule(sk, skb, 0)) {
> +		kfree(msg);
> +		return -EAGAIN;
> +	}
> +

[Severity: High]
If the fast path fails here at sk_rmem_schedule(), does the early return
bypass skb_set_owner_r() and set up a double-charge?

By returning -EAGAIN, skb->sk remains NULL. When the skb is retried from
the backlog, sk_psock_skb_ingress() will see skb->sk !=3D sk. This bypasses
sk_psock_skb_ingress_self() entirely, falling back to charging the full
skb->truesize again instead of 0.

Also, this is a pre-existing issue, but does modifying socket memory
accounting here in the backlog workqueue cause a data race?

The variable sk->sk_forward_alloc is updated non-atomically via functions
like sk_mem_schedule(), which require lock_sock(sk) or bh_lock_sock(sk)
to prevent lost updates. When called from the backlog workqueue
(sk_psock_backlog()), deferred ingress packets are processed with only
psock->work_mutex held:

    sk_psock_backlog() {
        mutex_lock(&psock->work_mutex);
        while ((skb =3D skb_peek(&psock->ingress_skb))) {
            ...
            ret =3D sk_psock_handle_skb(psock, skb, off, len, ingress);
            ...
    }

Concurrent TCP softirq RX or process-context TX operations could race
with sk_rmem_schedule() here, potentially corrupting sk_forward_alloc.

>  	skb_set_owner_r(skb, sk);

[Severity: High]
This isn't a bug introduced by this patch, but does the same page_counter
underflow vulnerability exist for normal TCP SKBs that already have an owne=
r?

The patch restricts the fix (settle_fwd_alloc =3D true) only to SKBs with t=
he
BPF_F_STRPARSER flag. Normal TCP SKBs passed via sk_psock_verdict_recv()
bypass the sk_rmem_schedule() top-up.=20

Because they already have skb->sk =3D=3D sk and skb->destructor =3D=3D sock=
_rfree,
they undergo the exact same uncharge-recharge cycle when skb_set_owner_r()
is unconditionally called here. Could they trigger the exact same underflow?

> =20
>  	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801102633.1872=
012-1-zirajs7@gmail.com?part=3D1
