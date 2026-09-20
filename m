Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23A3A9018
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915177; cv=none; b=Ja5363hJbWcP79RJqnQkecxVnNoP4g8N466MVJ5SQiyxAxi7h6TgcuojFP0p9Np7RR3nDbtYH/b0BH/AvTEzh5IP++s9aaRr1kjACdTrEK7xPsoUrlewGpVH+P7LwXlFVO/OnO7mys6qBm8U1xWcv6EFtvlaycaJeUnjbtpOCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915177; c=relaxed/simple;
	bh=wTzd58hwp1SXe3jTcRDun+6ck+5T6NYwmmiIxWfAINU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cs1jdb47xJ+Aa8JMKt/HiDrpQXdcx0zrKRQeIO0nFvSw5jP+tUAjaDVaRb2CcPxigBHsCFaTrT32r4wEylLAsh0FZpi1DOS6j900wITUslRAClh7YTFwgRIHOl6TMAiEDkAQeVzoGlOsxAzFhgoNectGwcDrpbZ+20jc6blkwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4nXPcNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4nXPcNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75D71F000FF;
	Sun, 20 Sep 2026 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915171;
	bh=O2Q6olASqRnD60yK1oZpX3ZWZlCCga1dZ673JHtYqTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4nXPcNcvPochGiB447EEDchDWENCg+8LrIDv+kUNB4wVR2BBe1Q71jpm/UC1klH7
	 UcCzgZv16rQkmAsqk7iWwWR4lt0/9J6iH4WkslX6OziP0nSdd7K6H1KkkKii9xhInC
	 0DJa1RLrbQxH+ZZWeZeApJMP+RZlVDMrNL/Nw2TdJmWz9ydvYEWsNFDB0WQB2clXcu
	 /pYFtfiW2c1LNfw2eeENNZUjUp0N8lCPSrtY4ZItX30dHwJt4EE9q3cOPPwcUBQIxf
	 9C9hM65FvFxqRGMWrgwzXZmCrsFuGdH20F/cXm4duE5cxgzBWphbm8XsbEz+Mip9lV
	 BbV30e4dJ/2JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 4/9] net: reuse skb_shared_hwtstamps for
 BPF Timestamping v2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-5-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:30 +0000
Message-Id: <20260920143930.D75D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: BPF start_time breaks SOF_TIMESTAMPING_RAW_HARDWARE and names=
pace isolation
- [Medium] net: hardware TX timestamps overwrite start_time breaking BPF la=
tency tracking
--

commit a3500c380740df14fa2b49c448a409fd50a64d25
Author: Jason Xing <kerneljasonxing@gmail.com>

net: reuse skb_shared_hwtstamps for BPF Timestamping v2

This commit reuses the hwtstamp field in skb_shared_hwtstamps to store a
software start time for BPF Timestamping V2. A start_time union member is
added that shares storage with hwtstamp.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 0f4a4f4bafb2a..275c797f6a4b5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
[ ... ]
> @@ -462,6 +468,7 @@ static inline bool skb_frag_must_loop(struct page *p)
>  struct skb_shared_hwtstamps {
>  	union {
>  		ktime_t	hwtstamp;
> +		ktime_t	start_time;

[Severity: High]
Could unioning start_time and hwtstamp impact SOF_TIMESTAMPING_RAW_HARDWARE
and namespace isolation?

When BPF Timestamping v2 is enabled via bpfts_v2_needed_key,
net_timestamp_check() populates start_time for received packets lacking a
hardware timestamp. Because they share memory, __sock_recv_timestamp() sees
this as a non-zero hwtstamp.

Applications requesting SOF_TIMESTAMPING_RAW_HARDWARE (such as PTP daemons)
will erroneously receive the software-generated start_time as a real hardwa=
re
timestamp in tss.ts[2], which could corrupt clock servos.

Furthermore, skb_scrub_packet() clears skb->tstamp to prevent timing leaks
across namespaces, but it does not clear skb_hwtstamps(). Smuggling a
software timestamp in the hardware timestamp union appears to bypass
namespace isolation.

[Severity: Medium]
Will hardware TX timestamps overwrite start_time and affect BPF latency
tracking?

BPF Timestamping V2 intends to measure latency by stamping start_time upon
packet enqueue. When a hardware TX timestamp is received, __skb_tstamp_tx()
calls skb_tstamp_tx_report_bpf_timestamping(), which assigns:

    *skb_hwtstamps(skb) =3D *hwtstamps;

before invoking the BPF program via bpf_skops_tx_timestamping().

Because start_time shares the same union as hwtstamp, this assignment
overwrites the enqueue start_time with the TX completion time before the BPF
program runs on the BPF_SOCK_OPS_TSTAMP_SND_HW_CB hook.

Could this cause the BPF program to read the hardware timestamp instead of
the original start_time, preventing correct latency calculations?

>  		void *netdev_data;
>  	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D4
