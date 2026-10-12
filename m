Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DD3B4EBC;
	Mon, 12 Oct 2026 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831284; cv=none; b=adDE8/dF1sJk39LbGRveaPKH6bDWzK5ZA5L9kkY/Huf96MI92SOfOC7M0cH2ejSvbWwPlplYua49eOSvpkRAfy/98cvqFEangBVZ1nnjaR5OjqPqbaxjm5qQVeZ/lIO8C5iAqHInX++WpSF8p0JjhXq/lgMAO/SyzrE7d5jC6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831284; c=relaxed/simple;
	bh=TLsxwGwM6FnVAKOlsDlbJvUVmwhFdRUxClWJ/P/3PjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djs1d/SstmVFE7Hd8/3Z7gsP266El2Ps1xW/cMMcD8tuDgdFLf2Ba5Z/YbG6mxQxEkA8i4RUK6OlAMdh749OwJA9Yt419TMNP8nMad82O3jUbKNZGuSvUBZnfF8EJN8yeW3UFiKSABJNo31Kck2AGIWLogi63f/uO2Pr68W8haU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhR25Ocv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhR25Ocv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A711F008A4;
	Mon, 12 Oct 2026 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831278;
	bh=F4wELoNZuzs4g50QK4pKI1aECTGqvoT1NLsTtpEfcdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FhR25Ocv8VI37nqlh57TY3u1isGDxtpxrlh4acDPHGbUlZ/waYCqJHlwQ7zVnrIlg
	 ZEkGIhLD9818ygYXNIKp2T4Sy2Gtij6ADgkjAwMbmCE1ULOYxvXLuFtW02T42FPMj2
	 0u8ypzNogIiMzRDDb4WAAiiAzldwkuV8RlOpAHSCbkfUYthqYGi8BYXIfJyAo/2WV3
	 mgYttO7RheKrMut74pb77/2RZlNjsXyOr/PCRK3Kv5KSVSMSDU7PEsRMCeDJOcfNl7
	 I4heCbqh2DuwKDmgPuMwhYDRE6xONx821m0rnFfVmJ61B8KzbTQjJv+JsDEFjF4myQ
	 q+uMfuw5tkYqw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
In-Reply-To: <20261003190237.E1B451F0089B@smtp.kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-4-bjorn@kernel.org>
 <20261003190237.E1B451F0089B@smtp.kernel.org>
Date: Mon, 12 Oct 2026 20:54:35 +0200
Message-ID: <874ieqbvh0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: Use-After-Free in NAPI poll due to erroneous kick after fai=
led queue rollback
> --
>
> commit 6916b55bc2fd7fcbee42e2cf1fc4f277ee96ed12
> Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
>     net: Add memory provider capabilities
>=20=20=20=20=20
>     The current memory providers, devmem and io_uring zero-copy RX, give
>     memory that the CPU cannot read. The core allows them only on queues
>     with header-data split on, a zero header-split threshold, and no XDP
>     program. AF_XDP needs a provider that the CPU can read and that
>     works with XDP.
>
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> index 00a7011eb4d57..610e31d1a7173 100644
>> --- a/net/core/netdev_rx_queue.c
>> +++ b/net/core/netdev_rx_queue.c
> [ ... ]
>> @@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_devi=
ce *dev,
>>=20=20
>>  err_free_new_queue_mem:
>>  	qops->ndo_queue_mem_free(dev, new_mem);
>> +	/* Freeing the replacement can hand provider memory back to the old
>> +	 * queue, which still runs unless the rollback failed.
>> +	 */
>> +	if (err !=3D -ENETDOWN && netif_running(dev))
>> +		netdev_rx_queue_kick(rxq);
>>=20=20
>>  err_free_old_mem:
>>  	kvfree(old_mem);
>
> [Severity: High]
> Does this code risk a use-after-free if the queue rollback fails?
>
> If ndo_queue_start() fails during the rollback, the old memory is freed, =
but
> err is not updated to reflect the failure:
>
> net/core/netdev_rx_queue.c:netdev_rx_queue_reconfig() {
> err_start_queue:
> 	if (qops->ndo_queue_start(dev, qcfg_old, old_mem, rxq_idx)) {
> 		WARN(1, ...);
> 		qops->ndo_queue_mem_free(dev, old_mem);
> 	}
>
> err_free_new_queue_mem:
> 	qops->ndo_queue_mem_free(dev, new_mem);
> 	/* err still holds its previous value (e.g., -ENOMEM) */
> 	if (err !=3D -ENETDOWN && netif_running(dev))
> 		netdev_rx_queue_kick(rxq);
>
> Because err isn't updated to -ENETDOWN when the rollback fails, the kick =
will
> proceed and schedule a NAPI poll on a stopped queue whose memory was just
> freed.

The error check doesn't track rollback success. I'll fix that.
