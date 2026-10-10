Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A13ED3CF
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632135; cv=none; b=Ia737uozeMAhbBU3UKLqbW7lPpXkLoOrvJgvdGTiHoYbWIy+w4qcx8TUMiWRUXrwo0EV0PiCztrf028l1ehLEj9jb4Yh/Zk14sIVcl1pLU19hKL9QLrd/HObdVn0z+zzaX3d6fiXXkXq8eqVMSIXtZzGkjPOtie4tYlZS/WVlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632135; c=relaxed/simple;
	bh=6DD7bMWPRM+qPmnMPKrsOtABTCTTTl275HsH59XBW5I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HICrqqxy63HPsS1nX8aa7oY/BF8huiPtszFq2qj6P7xzNA97rJr7f+xLWGgbRaSQkKztuDlvedNXjOvo70RW122EsmOgp0HBA3Y1mqL2zYoTzqe83zdd5xM2mda65WIsQrkT9DXKdMwB1eN5vQRT51ntFhtEoZIC5rzen0rxHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGBKabCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGBKabCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FBC1F00893;
	Sat, 10 Oct 2026 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791632134;
	bh=1ft3hQhyqeBk9SZrjkgJOrPzFniWjWpxxvRzcWLk3Yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bGBKabCZY7VwLYPCAX6E9HaJ/v5S8vsntXU5isazG3YYreiAP7eLtRKRy6bSj0yNq
	 CsRXxO6114E4LYLGbZkdQrGqISWO+LRvrr67pR9dDt3x+quMlk72q9weybxHH7RmHk
	 o5B6c3Wyraz14Zrfp/ff4xrwXspnoGOQqJ28HPhcb/0/FBLZmBzhFzcWjpCq6y1rKW
	 g9rfy4644BmxouydO3AFKuXAjKTNZKk2JEG4IOuie3QxSYLJ0gl2CsTELAkEvaF9Xw
	 mIWvwL44RIXQvuVGR56ks2DqERUZNwQAJtVBgx6fIGWMyCUKZNtPNnLu8J1bEAcu25
	 5ZalCQ70NiiNA==
Message-ID: <sashiko-outbox-166468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-mpnic-counters3-v1-1-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
 <20261009-mpnic-counters3-v1-1-7dc7644cc500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 11:35:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] locking: u64_stats_sync deadlock in mpnic_clean_twq0() due to soft=
irq reader
--

commit b438863957f763895e3efd300c4e2cd81b9bb11b
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: count packets, bytes, and drops per ring

Keep packet, byte and drop counters on each Tx work, Tx completion, and
Rx completion queue. Report them to the core via the rtnl_link_stats64
interface using an RCU approach.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
[ ... ]
> @@ -288,8 +295,19 @@ static void mpnic_clean_twq0(struct mpnic_napi_vecto=
r *nv, int napi_budget,
> =20
>  	ring->head =3D head;
> =20
> -	if (discard)
> +	if (discard) {
> +		preempt_disable();
> +		u64_stats_update_begin(&ring->stats.syncp);
> +		u64_stats_add(&ring->stats.twq.dropped, total_packets);
> +		u64_stats_update_end(&ring->stats.syncp);
> +		preempt_enable();
>  		return;
> +	}

[Severity: High]
Can this cause a deadlock on 32-bit systems if a softirq preempts the write=
r?

Writers to u64_stats_sync must be serialized against readers. On 32-bit
systems, readers spin in a retry loop while the sequence counter is odd
(mid-update). The preempt_disable() call disables process preemption but
leaves softirqs enabled.=20

If a reader like dev_get_stats is invoked from network receive or BPF softi=
rq
contexts on the same CPU, it might interrupt this writer while the sequence
counter is odd. The reader would then spin infinitely waiting for the count
to become even, resulting in a deadlock.

Should this use local_bh_disable() to protect against BH-context readers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-mpnic-coun=
ters3-v1-0-7dc7644cc500@gmail.com?part=3D1
