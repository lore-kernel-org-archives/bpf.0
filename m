Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085D33D4E8
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922513; cv=none; b=Od9hmz8jXb7idMFk2a6NQ4i3kcJFjKp4zhy8laadWd6Ib5L6vNRJbFZlDc++yGJFfyr6ULAt5c59VioFzpMmOsXd/vFaN2fEnHhILcvaqd4Ik/SIkTB5pgYaBoE9ReFfyWF4OXybZeEoN39fm3lhxq/inV1pGx8DzqglXg7Pg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922513; c=relaxed/simple;
	bh=gzRI6lX47ILN7H1LfyArbtZJq0WpbKjs3J6e55A4STE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZ/JPI5iaj5/clpB67MudUuQiLB5pImyNPMH83BCLeREaKgtomYb5PdlGKLtQGz1TR2JoSDL3pgBd4G+TDdgtgAq//1wuhtaMhvhOQxStXZgJngXksvMU3YPHNqazTp7KupfXnpnIbP+Rp6qnPrMruN2nsS1m9GPqzWhrDcXBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ7Yjh+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ7Yjh+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A301F00A3D;
	Wed,  9 Sep 2026 02:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922508;
	bh=0EI5yEhgy/52AleysaCYkIZmtkrjW0oHgWqmRmYkMvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQ7Yjh+7Wfl6VANDhDiaJv0XbV6a2x/hbmrv7t4FbK4mwnMeDmJ/Ws76YHqAQX62D
	 PXf3NtXu6la71Q2pKCQwXYP5fJHehsWd8KGmBWTwzpJNWo2bnDzFYC6Ax8ob0Pso+s
	 vv3YoYefrIwwKK0v0GmeXG134+91cn/sUnJgUHSoy+qXWovop65vXNzkxUjZ2Zi+8q
	 ML2pPDiA6Y7Ozt35vFfLofAfXN1xmLJgC7Z1Zu4grrOIHuvTK4lWbz4UQb52zyDxMN
	 5SQySI8whrIHGoXz4QTT9AGUyJDtVPF9GyYBU6pv6wuOpAgH39gcMR7TaxTxshHLHW
	 PO3079Fx5EvGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
Reply-To: sashiko-reviews@lists.linux.dev
To: Nikhil <nikhilljatt@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909024011.1252694-1-nikhilljatt@gmail.com>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:55:08 +0000
Message-Id: <20260909025508.61A301F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A softirq deadlock can occur because `bpf_fib_dmac_snapshot` uses =
`read_seqbegin(&neigh->ha_lock)` in softirq context (XDP/TC), while `neigh-=
>ha_lock` is updated in process context without disabling softirqs.
- [Low] The multi-line comment introduced in `net/core/filter.c` violates t=
he BPF subsystem comment style.
--

commit 08a77b636ca52caaeee611a7902f55a43c9d7350
Author: Nikhil <nikhilljatt@gmail.com>

bpf: fix reading neigh ha in bpf_fib_lookup()

This commit fixes a lockless data tear issue when reading the neighbor hard=
ware
address in bpf_fib_lookup(). It introduces bpf_fib_dmac_snapshot() to safely
read the MAC address using a seqlock retry loop, avoiding neigh_ha_snapshot=
()
which would overflow params->dmac on some device types.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..a7c7bbfd90e31 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6297,6 +6297,20 @@ static const struct bpf_func_proto bpf_skb_get_xfr=
m_state_proto =3D {
>  #endif
> =20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> +/* Take a stable snapshot of the neighbour's link layer address.
> + * neigh_ha_snapshot() can not be used here because it copies dev->addr_=
len
> + * bytes while params->dmac is only ETH_ALEN long.
> + */

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem comment style?
The guidelines require the opening /* to be on its own line.

> +static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neig=
h)
> +{
> +	unsigned int seq;
> +
> +	do {
> +		seq =3D read_seqbegin(&neigh->ha_lock);

[Severity: High]
Can this cause a softirq deadlock?

Since bpf_ipv4_fib_lookup() is called from XDP/TC programs in softirq conte=
xt,
bpf_fib_dmac_snapshot() will spin on read_seqbegin() here.

If a process context function calls __neigh_update() on the same CPU, it
acquires neigh->ha_lock using write_seqlock() which only disables preemptio=
n,
not softirqs.

If a network interrupt arrives and triggers softirq processing on that exact
same CPU while the writer holds the lock, read_seqbegin() will loop
indefinitely waiting for the sequence count to become even, leading to a CPU
lockup.

> +		memcpy(dmac, neigh->ha, ETH_ALEN);
> +	} while (read_seqretry(&neigh->ha_lock, seq));
> +}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909024011.1252=
694-1-nikhilljatt@gmail.com?part=3D1
