Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B603793CE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242009; cv=none; b=l8npsC9h1sLDlyAU4+EtGOFJxGEHE0po4smmv/wRME6SOLbmfXaFwC1VqkbGbAIxk9uaAcxuoq/BXYAJjwO227ffwXNWPkoyWJhx1ZiwimfoWAP9LDB7BsF5K6QKyMVlJ6DqzsDUtc2AgyVWWD7bIviXSJHAbwaNeJw6AQBWGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242009; c=relaxed/simple;
	bh=RRCxNPVOONVNQZ7NW7UrA921J5NGVCFgKbaet/ZHfxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJ4uTHPkmI+zT3sSPR/KtpAEeW+6Q+NjZ++G5/4rPsDhlRBAOa2JdR4zWxg0lLdWDSWj8+O62ri+pOY33/NP7DKz2buw5v5TPX6sS7X1vJZ3AWB4HFfY3WVYf5ItP24tSVkUe7I8koHJYDwKSw5RqMbzviCo9tRmQZCVd/d1oN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnOH8HZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnOH8HZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE451F000E9;
	Thu, 20 Aug 2026 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787242008;
	bh=Ufi9r1jEt0fxp8DkLvLEAw/hdUt41++5Dq8QbeuQYOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnOH8HZLrUpLIcV7KQb2Z4AdIuFLbKi3f2rcS3NcvcQJykaC2mSkJtHST+ptE4+7j
	 Us8f27w8Q1nxeILV6eF6PZuq7GHZjsJgSIeLSzYQIhq94H958WYf0PHg3fuFk9jG8K
	 G+KxVyPpwIAq4WwwnpB9UG6C0QfG7fly+hPoBeJpvthe7tdgxXrhSdpOSUDlY+08n/
	 1QnZ7VxoD8E7dYwXX0kwcYSuHTKkI0Gaz5wrJhUZ/xxYE9nUC4iYR718BHEn5DrXPb
	 i5qLLbHh6jAlvIQZv27r42CEqCiQx7AB8dAylafJz+eh2kqEvpjw0f4TRRk0v6/Rcm
	 uHWtNY2BCtJ8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819160535.1472459-4-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:06:47 +0000
Message-Id: <20260820160648.6AE451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver uses a bit flag and a polling loop to simulate a lock i=
nstead of using standard synchronization primitives.
--

--- Patch [3]: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP fr=
ame handling ---
commit 71d40d9a1bd119643235e87e55c9834a8a5c6c83
Author: Stanislav Fomichev <sdf.kernel@gmail.com>

net: stmmac: document oversized AF_XDP frame handling

This commit updates the driver to document its intentional ring imbalance
when dropping AF_XDP zero-copy frames that exceed taprio's queueMaxSDU. It
adds comments explaining that completing a rejected descriptor is unsafe
due to ordered completions, and instead wedges the ring to expose the error.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 62de03e65a90c..6a532747c0394 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv =
*priv, u32 queue, u32 budget)
>  		if (priv->est && priv->est->enable &&
>  		    priv->est->max_sdu[queue] &&
>  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> +			/* Completions are ordered, so this descriptor cannot
> +			 * be completed safely. Wedge the ring to expose the
> +			 * application error instead.
> +			 */
>  			priv->xstats.max_sdu_txq_drop[queue]++;
>  			continue;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but I noticed an ad-hoc locking
pattern using a bit flag in stmmac_reset_subtask() in this file:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_reset_subtask() {
    ...
	rtnl_lock();
	netif_trans_update(priv->dev);
	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
		usleep_range(1000, 2000);

	set_bit(STMMAC_DOWN, &priv->state);
	dev_close(priv->dev);
	dev_open(priv->dev, NULL);
    ...
}

Are there any standard locking primitives that could be used here instead?

Simulating a lock with a bit flag and a sleep loop avoids lockdep tracking,
deadlock detection, and standard kernel memory ordering guarantees.

Could this pattern lead to subtle concurrency issues or hidden deadlocks
during the driver's reset task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819160535.1472=
459-1-sdf@fomichev.me?part=3D3
