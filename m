Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA34A8A22
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374326; cv=none; b=GdOGTml1Mz17c+aaW8xFP97sX1rBJA45Nn9qhKEiYBwSCRcB42+HgQFOl2A03kTyFNvh8HWhjBPlTXezHkx613IL52031pXYZXjr55LKiC+t/eCLdGjkMY65v22p6tvDsi1uD64ZyBhze7Y9kozop31Ez0cAzWK/iPrUTBfSWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374326; c=relaxed/simple;
	bh=Iy4BOdF0RJkkCDp88NdRHHPT/9//uMR8f2onBAkZwq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jr+cZs6C+hT7yJqtjvgFo080bcRVmapg2YoDcaDzaSq+v8ms2cPLIanQKHFybh3Ky1JOi4v/DgD7nLyo1y6hd1jG8IIJjm7DqVe0iLCFH8EHjurJEb9Uj0I5/bx7Rap05Ty9vbDP+e8Fuj/VhAULFe7OIX1inSlNDE/jAH0QmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6XG8kb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6XG8kb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9756B1F000E9;
	Wed,  2 Sep 2026 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788374320;
	bh=rCTKOt9Y4tvyFxfMRJKlyAvEyw3MRdAh/8aP3sQHcFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6XG8kb/Cs2buxJp4Drk5nSrXnXEBImhdpPdjzG8jsmhqjBC/qYydF6FAVheGzIQ/
	 E+Rcc8jKEVEwCSohhYNeqfExavVCBLz+EWk/m0wOcPn075SMwTh917n5hGyuJjs3kX
	 Boul9jNCVIQGY7DIx2NYLIsdsew5x1FeYKbcVTHrtvDPoZYbegUUuxoLlXXff1JnYs
	 ohJX20nXY9Jd/4zdXVKkW2nW64YqIHj3wD3TfD8F0tsHDWOz8nTluhTKbfR2msDwlk
	 qRUtDC+fxB+/1TGTfcJz6RVGytJnvbwfC2FFWUYjEKZYdZTChwAgE7P48fL7vqoy+t
	 vhNoag9kS2FqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] bpf: Fix reference leak in bpf_sk_assign()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902-sockmap-lookup-tcp-leak-v3-2-b998b3d49d07@rbox.co>
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <20260902-sockmap-lookup-tcp-leak-v3-2-b998b3d49d07@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:38:40 +0000
Message-Id: <20260902183840.9756B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_sk_assign_tcp_reqsk() stores an unreferenced pointer to a =
TCP_LISTEN socket inside a request socket. If the packet is queued via NF_Q=
UEUE, the listener socket can be freed, causing a Use-After-Free when the p=
acket is reinjected and stolen by tcp_v4_rcv().
--

commit 8e6dd77792c2f082ee2b1a593a577a3112cbcf19
Author: Michal Luczaj <mhal@rbox.co>

bpf: Fix reference leak in bpf_sk_assign()

This patch aims to fix a reference leak in bpf_sk_assign() by freezing the
decision on whether a socket is refcounted at assign time. It introduces a
new destructor sock_pfree_refcounted() and modifies __nf_queue() to bump
references for prefetched sockets without references.

> diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
> index 73363ceedebe3..e2e9739c00ac5 100644
> --- a/net/netfilter/nf_queue.c
> +++ b/net/netfilter/nf_queue.c
> @@ -195,16 +195,16 @@ static int __nf_queue(struct sk_buff *skb, const st=
ruct nf_hook_state *state,
>  		break;
>  	}
> =20
> -	if (skb_sk_is_prefetched(skb)) {
> -		struct sock *sk =3D skb->sk;
> -
> -		if (!sk_is_refcounted(sk)) {
> -			if (!refcount_inc_not_zero(&sk->sk_refcnt))
> -				return -ENOTCONN;
> +	/*
> +	 * If the skb was prefetched without taking sock's ref, bump it.
> +	 * Skip sock_pfree-dtor'ed skbs coming from bpf_sk_assign_tcp_reqsk().
> +	 */
> +	if (skb_sk_is_prefetched_noref(skb) && sk_fullsock(skb->sk)) {
[Severity: Critical]
This isn't a bug introduced by this patch, but does maintaining this behavi=
or
for request sockets leave an unreferenced listener socket exposed to a
use-after-free?

In bpf_sk_assign_tcp_reqsk(), a request socket is allocated without taking a
reference on the listener socket (attach_listener =3D false), and the
unreferenced listener is stored in req->rsk_listener.

Because sk_fullsock() evaluates to false for request sockets, this check
bypasses bumping the reference count for the SKB when it is handed to
netfilter queue. While the SKB is held in userspace, it escapes the RCU
read-side critical section. If the listener socket is closed and freed
during this time, what happens when the packet is reinjected?

It appears that when tcp_v4_rcv() processes the reinjected packet, it calls
skb_steal_sock() which extracts the freed req->rsk_listener, clears the
destructor (bypassing sock_pfree), and returns the freed socket for use,
triggering a use-after-free.

Could this be triggered by a user with privileges to set up a TC BPF rule
and netfilter queue?

> +		if (!refcount_inc_not_zero(&skb->sk->sk_refcnt))
> +			return -ENOTCONN;
> =20
> -			/* drop refcount on skb_orphan */
> -			skb->destructor =3D sock_edemux;
> -		}
> +		/* drop refcount on skb_orphan */
> +		skb->destructor =3D sock_edemux;
>  	}
> =20
>  	entry =3D kmalloc(sizeof(*entry) + route_key_size, GFP_ATOMIC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-sockmap-lo=
okup-tcp-leak-v3-0-b998b3d49d07@rbox.co?part=3D2
