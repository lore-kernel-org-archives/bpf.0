Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083423A4521
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915177; cv=none; b=WbYXpQ6QZh2lRaGJW6HVyBtL2qpsAHnqFMhuRb4z4PVrU5z835FWTOHL5DNWps6dgx+dvTmEf7PNOqsZA5CHzBrpYkQBw3stRJLXxVriQ0EnNP9HPgZ/qHya2AQlEISCIGBuqsxOFx2jg6Pft5WWCl1oxNAj0aNVcfSDU2DpJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915177; c=relaxed/simple;
	bh=xvySHzWpQAmm6bXYpOBBvNb7hERajzkEZYJWYuTH0XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oBasJG283dTSVLpIzch7VqbWJ+ggsxbDwmE5QpRSf1u9JzXgoMbGjvA4Poh8dWgR2iN33z1CtihOzJk4vAj8rnDD3k7xM4iFIxOplXq+VcN9CUvfPqtB8pYyeod7ld2/6g5Ap7/maUg3/LHtbCTM4cBvSRJaR8eSyrHiT3etlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpW5h0ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpW5h0ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCB61F00893;
	Sun, 20 Sep 2026 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915171;
	bh=WuMLTS/rrG3rgkPIpjXMxOJF8mdtG0deh5wWVq+KUvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpW5h0iank743N5vaedaTUscXSfUjjkqMOgF3EqvdjCVNEiCa9jXcfqKsieWgefhJ
	 KiyjDjOZMLJpDIu5HMx4cOVtwPITZxAYSE5zB/3kzG5cnfQ8USxZVr4AFrYunJi0Gc
	 68OYID3kZnDnlVmXZ/1WFfh99sfDK5yyGtnUtlCoQTJmiE6VR12GqdJ1C/o6zS+xW/
	 1iuX3T3i/leJ6FWN+mYBzEAR4ls2SwxIiPs2n3Y1dkWHjOpCIa+LD1YfjdbcGswZgJ
	 XgOD1EKOUzHigOwf3eI9+1cduWI7v64mm+jTl6V1m7iryvhDbxpiJ5xQl4v8VwM/nk
	 CiR2wKYWzvg1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 8/9] net: generate the start time for every
 skb in the rx path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-9-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:31 +0000
Message-Id: <20260920143931.8BCB61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] net: start_time and hwtstamp union aliasing causes UAPI breaka=
ge
- [High] net: modifying shared skb_shinfo in net_timestamp_check corrupts c=
loned skbs
--

commit f67f60b2a43b1183b5caab4725cd26a0b5760176
Author: Jason Xing <kerneljasonxing@gmail.com>

net: generate the start time for every skb in the rx path

This commit extends net_timestamp_check() to record an in-kernel start time
in the skb's shared hwtstamps. It enables computing how long an skb has
spent in the stack during the RX path.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1da3250f25d2c..e358d28ae6c3f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2501,11 +2501,17 @@ static inline void net_timestamp_set(struct sk_bu=
ff *skb)
>  		skb->tstamp =3D ktime_get_real();
>  }
> =20
> -#define net_timestamp_check(COND, SKB)				\
> -	if (static_branch_unlikely(&netstamp_needed_key)) {	\
> -		if ((COND) && !(SKB)->tstamp)			\
> -			(SKB)->tstamp =3D ktime_get_real();	\
> -	}							\
> +#define net_timestamp_check(COND, SKB)					\
> +	if (static_branch_unlikely(&netstamp_needed_key) ||		\
> +	    static_branch_unlikely(&bpfts_v2_needed_key)) {		\
> +		if (static_branch_unlikely(&netstamp_needed_key) &&	\
> +		    (COND) && !(SKB)->tstamp)				\
> +			(SKB)->tstamp =3D ktime_get_real();		\
> +		if (static_branch_unlikely(&bpfts_v2_needed_key) &&	\
> +		    !skb_hwtstamps(SKB)->hwtstamp)			\
> +			skb_hwtstamps(SKB)->start_time =3D		\

[Severity: High]
Does this code modify shared skb_shinfo without verifying SKB exclusivity?

The skb_hwtstamps(SKB) macro resolves to &skb_shinfo(skb)->hwtstamps, which
is explicitly shared across all clones of an SKB.

In the RX path, such as in netif_rx_internal() where net_timestamp_check()
is called, packets may be clones. For example, TCP transmits a clone while
retaining the original SKB in its retransmit queue, and if sent over a
loopback interface, this clone is directly passed to netif_rx().

Writing directly to shared SKB metadata without calling skb_unshare() or
verifying exclusivity via skb_cloned() can cause data races and silent
corruption across all concurrent users of the cloned SKB.

[Severity: Critical]
Does this code also inadvertently overwrite hardware timestamps delivered to
userspace?

In include/linux/skbuff.h, start_time and hwtstamp are aliases in the same
union:

struct skb_shared_hwtstamps {
	union {
		ktime_t hwtstamp;
		ktime_t start_time;
		void *netdev_data;
	};
};

When a packet without a hardware timestamp comes through, this assignment
writes a software timestamp into start_time, silently overwriting the empty
hwtstamp field with a non-zero value.

Later, when the packet propagates up the stack to a socket with
SOF_TIMESTAMPING_RAW_HARDWARE enabled, __sock_recv_timestamp() checks the
timestamp:

net/socket.c:__sock_recv_timestamp() {
    ...
    if (shhwtstamps->hwtstamp) {
        tss.ts[2] =3D shhwtstamps->hwtstamp;
    ...
}

Will this cause applications like PTP daemons to falsely receive a software
timestamp as a hardware timestamp, breaking the SO_TIMESTAMPING UAPI?

> +				(SKB)->tstamp ?: ktime_get_real();	\
> +	}								\
> =20
>  bool is_skb_forwardable(const struct net_device *dev, const struct sk_bu=
ff *skb)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D8
