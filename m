Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633E3CD8D7
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576028; cv=none; b=taCGeoLzjHV2DTpGUfCYIeaCfU1bGrufugwO46CnsgDIuUSRamj571rS5PGB2XfzzcDrMh2urHLnJfN7h06OaAGj7cJxNk1Ff+MYQc1PYVpekkNfESfEDo7ubxWyzzoggsRAA6ovYJiIXOzbbrLNpJ3gnKbsWOCDpPWPlIbSMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576028; c=relaxed/simple;
	bh=RLF51gjJuYJsmmbkpvprDKPl5tsobv86JF9U6bHPFN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iRLRddYj4IpgmUG2ENX0Im5oU1ejnxtgyR8vxUowwPnxaeqhF/S1sc0ZTaocgi/dTbjUnvaZKvuopoqd/1wS7H9c1H9R5v4xTH2OmFTRcLr/CzJd9rfFHU4STU2l6VEvkVF4w4C9pTT7cg3x0JiS7KRKz/WHZn0X5tqAzv8n4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1BpiC1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1BpiC1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882921F00893;
	Thu,  4 Jun 2026 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576027;
	bh=EPy2kZidxQ518o6BLqExLUWq9HKhJSuM9s5ym7E/nZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1BpiC1sFKrXZyF/9PKDp7l9Snqt0DnQZpIjWeJtLJZGjpjkY2JtLx+SYTAltegh3
	 PQYO03AWN7Ov3dJWmzSNW3n+6o6ffx9BoR3ow2C3ZRAeRiWNYUZhBhSbmRoC26XNMk
	 f6p6CCCn0f6kdPxKRGNf2GngqFfTY63pGrqF4nvnCl68c7kDprqUQsj+8Q5tOgrPOK
	 PXz+Kq1NLZT27vMmejCTfLjmXkXvBNd1OREhCp145Rn/kt4bmwzYIkx9DJUcLFwewr
	 Je0+kXsDstBXM54ZsQEq5L/wqruh/6+2gjMmoKELdMYh+mZeeJ8XdOF5hBQrgMT7/6
	 /3dUt1kD8f+FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] udp: clear skb->dev before running a sockmap
 verdict
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
References: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 12:27:07 +0000
Message-Id: <20260604122707.882921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unhandled failure of skb_set_owner_sk_safe() leads to a NULL point=
er dereference. If skb_set_owner_sk_safe() returns false (e.g., due to sk_r=
efcnt being 0 during concurrent socket destruction under RCU), execution co=
ntinues without aborting. The patch explicitly sets skb->dev to NULL right =
after. Subsequently, if the BPF verdict program invokes a socket lookup hel=
per like bpf_skc_lookup(), the helper observes skb->dev as NULL and falls b=
ack to evaluating sock_net(skb->sk). Because skb_set_owner_sk_safe() failed=
, skb->sk was never initialized and remains NULL (as is typical for incomin=
g packets), leading directly to a NULL pointer dereference.
--

commit 7d38a119d5768d0ec63d1cfccd1fe2e8d8ea7398
Author: Sechang Lim <rhkrqnwk98@gmail.com>

udp: clear skb->dev before running a sockmap verdict

This commit clears skb->dev on the UDP receive path before running a
sockmap verdict program. It prevents socket-lookup helpers from
dereferencing the UDP dev_scratch value as a network device pointer,
falling back to the socket's network namespace instead.

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2011,6 +2011,11 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t=
 recv_actor)
>  	}
> =20
>  	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +	/* skb->dev still aliases the UDP rx dev_scratch (its charge was freed
> +	 * on dequeue above); a sockmap verdict program may deref it via
> +	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
> +	 */
> +	skb->dev =3D NULL;

[Severity: High]
If skb_set_owner_sk_safe() fails (for example, if the socket refcount drops
to zero concurrently), it returns false and leaves skb->sk uninitialized.
Because WARN_ON_ONCE() logs the warning but allows execution to continue,
skb->dev is then explicitly cleared to NULL.

If a BPF verdict program subsequently invokes a socket lookup helper, could
this cause a NULL pointer dereference?

Looking at bpf_skc_lookup() in net/core/filter.c:

    if (skb->dev)
        caller_net =3D dev_net(skb->dev);
    else
        caller_net =3D sock_net(skb->sk);

Since skb->dev is NULL, it falls back to sock_net(skb->sk). Because
skb_set_owner_sk_safe() failed earlier, skb->sk is also NULL, which seems
like it will panic during the dereference.

Should we abort and drop the skb if establishing safe socket ownership
fails, rather than continuing with both skb->dev and skb->sk as NULL?

>  	return recv_actor(sk, skb);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603122639.6159=
94-1-rhkrqnwk98@gmail.com?part=3D1
