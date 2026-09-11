Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F253C1412
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148821; cv=none; b=ce/zFvkp3L19lnAaAb7xsSPRA+YSXpew7bgTqiKc4v+pbQDdcMwO9+RrkHLGxSwVkyPVbvyoKqM/L2UJDq+/D3gnXU4C5xOB56SGV8nXbpBAFM+Cgc2MJsvpXDtznRL2OCd4fCAvgVibnHYeGEn6JA4+fw2dZhuP9aoMJecH6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148821; c=relaxed/simple;
	bh=ekto+5UonJK6k531IWjct1lPTnEGdWzuXv0dno0EhZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AnsnPTARx7L6nR8qxcdWnDYvHziGwNMtHkiFYkqSsDVRXJ97WvCsme/QRODIrAOZiMRiSjFddgduu/KhUsFnrb/RRCcjs142kGmyTXy42Hr9Rm/OjM4J8Ufl8hFAAcNl44xpQyIELqx9jsfqdtQypRB0GYaSA7QjaSjNs1NdOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJfvM10J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJfvM10J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824371F000FF;
	Fri, 11 Sep 2026 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148819;
	bh=Q6Y8/7Ed311/AZLwFUXMQbkccg6rXrrSYgF6BnaAyP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJfvM10JedEZmasqDBfGbiVBBVXU3P5C6qSuD1t7Nj05iccAcfMFvxKsFtNaSWhWN
	 bOprhnmEEeLKbWrQj+mbJxPPRWJBofrG/Iy4Ufe7gM6cKCYlPkpWiQxZBRaSrp0QOC
	 YFsHcNN5MdCgUjKv1OUKQNSPMTBAaCZhc5Toum3j76pglL5Acslq+0Y8PTBq4xwsmd
	 BToRgAgEl2fLh2biK3OL60XCAy+kUvQ0dFTtH92BPLMQ+HadKQq7FLrptmBv8eDX3l
	 D5SwNVjr6mT3X3Y8WUtUeKD21kyyjRXDTVeDEAs7c3IQ4JwCymwsB8xw+MQqwjAttN
	 FXocIj7KF+ywg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: revalidate assigned sockets after
 protocol change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911172313.64009-2-shlomojune6@gmail.com>
References: <20260911172313.64009-1-shlomojune6@gmail.com>
 <20260911172313.64009-2-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 17:46:59 +0000
Message-Id: <20260911174659.824371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf_skb_change_proto can synchronously free a socket via skb_o=
rphan(), leading to a Use-After-Free if the BPF program holds a PTR_TO_SOCK=
_COMMON pointer to it.
--

commit ecfe32dc3cf3e047fa0e8a7841baab762512d237
Author: Shihuang Liu <shlomojune6@gmail.com>

bpf: revalidate assigned sockets after protocol change

This commit adds a check in bpf_skb_change_proto() to revalidate any
prefetched socket after a protocol change. If the socket's address family
is no longer compatible, it releases the assignment by calling skb_orphan().

Link: https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gma=
il.com/

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b5452113f974a..9907e9d44c11f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3547,6 +3547,11 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *,=
 skb, __be16, proto,
>  	if (ret)
>  		return ret;
> =20
> +	/* Protocol translation can invalidate an earlier socket assignment. */
> +	if (skb_sk_is_prefetched(skb) &&
> +	    !bpf_sk_assign_family_ok(skb, skb->sk))
> +		skb_orphan(skb);

[Severity: Critical]
Does this code introduce a use-after-free if the BPF program currently holds
a pointer to the socket?

If a BPF program, such as a TC hook, loads skb->sk and verifies it, the
verifier grants a valid PTR_TO_SOCK_COMMON register. When the program
subsequently calls bpf_skb_change_proto(), this newly added code calls
skb_orphan().

The skb_orphan() function synchronously drops the SKB's reference to the
socket via sock_pfree() and sock_gen_put(). If this was the last reference
to an established TCP socket (which do not use SOCK_RCU_FREE), the socket
is freed immediately.

While the verifier's clear_all_pkt_pointers() clears packet data pointers
after protocol changes, it does not invalidate PTR_TO_SOCK_COMMON registers.
Can the BPF program then access the freed socket structure via its dangling
pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911172313.6400=
9-1-shlomojune6@gmail.com?part=3D2
