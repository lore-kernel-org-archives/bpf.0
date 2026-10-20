Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532089;
	b=TDCB+o6wD/2DH2iHfY4k8Jy6VkjmnGKZfzDtmg1eM3brJi7isIWMOfeyYLN6df8xB+Ae
	 qUlzKBb2lhXZKp8PyyfchKrx6bY7ntlijHU4wpVNJrixGriROZtjXLLEVmeGtEQw2W8Uh
	 g/yuOH8bIqHWTr79WghEb2O+O6xj1naSAP1jlYdxtACvDvJhRLIY+SFbqQH4AD6bjNis7
	 y9vaBvwrzx5V3i48gZi1g+QI8t+ESGjWJXPxYodVsj1ubu6d8cNN7vdp0inY8M/hvXh3O
	 Z5XCSCtPYBHo59zAsTPP1M3c77ahscW4vY9BZgLJ3tPXhqgLVMJqkYBDhzXxGtwZi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=bE6vWRivvrBn43khOiGweyP2UtaaaQ6ix75d+gSulIQ=;
	b=eMFpnIKgDy7+8fJIoK243aLoTOQYNKs11oqrU2zJEeFIB2HsCyACzZGnOEJJd8B+vbTC
	 WgAvIhH/lSEV6OOw26dmeVkfOyok9W4Jia/NeRuujrWPC/YE1h2p6yesoOHRYq2ivgakj
	 OZ0JmTG80voorYijAZVNYUAEQIycw7ME0syWJDKVtlDimnPyDu6YCj+El+Nop4+Gco0hz
	 jeKoQbmob9fZRXcDDzNTIHwNIAJCkqh9vY0nQcvMLvQQu8GHYz4M6FO9voW2OyQO/HsLg
	 XKZs542iJsry78PZEPeQQzHS59zfRaPlrlFx/NCADfKA0Xqyphp+LRVAVsMkhX6CTdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=alDxpolL;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8A606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=alDxpolL
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5361e313e63so1172491cf.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792532088; x=1793136888; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bE6vWRivvrBn43khOiGweyP2UtaaaQ6ix75d+gSulIQ=;
        b=alDxpolLRjyv8Gr5yFq8NLTMChM+lVDcXVYQzJwHg7JO3hJSHkKSVlGJeJbHDYvUL1
         U2I/CPb+UKPAANcywpFGexKhTjoCIQ2eq8vigx/02ZdOSuyUj3UzN1JozvoXad6Wjehr
         qlgfMATjoJSLqPLerfpv0kVF6NQuC/79gHZhAnrSOCHudzY6fC17JAByfhaj/3QS6IUF
         KfZAz3d3efzOVVeW4XWNb9xjo+qMltJ2jNXyKoAd82we9+LMaUvEq34w365i1n2qEWpW
         10/nENnNfvGb5ulq9w/uxOUfkpqgKxo6x4rYSLbs/x3gFp/CxfyRQOnw2XTtghzNLDPv
         PP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532088; x=1793136888;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bE6vWRivvrBn43khOiGweyP2UtaaaQ6ix75d+gSulIQ=;
        b=FmyPTpnNPPOVhuLBp+qKitbxoB6UbOybsrRqG2CmfVIXqmovAzMCWujFcxnk82p8Tc
         5gN/M32JQD5caMYMFaIYngw1STFhjgDgGwJeHyRSK4OzmaLnJbV/9APvXoaq+q7JiDJN
         MpKzDML/JMZbm0b5cw5CeguhbGrl4sLs/O01Sz6eJ2LjPz00aahG51+2QZMXoQGL6wc7
         gYrN116Bg8wqF00RVrqZT5zjJQw/UJ7h6ypLbgrGtKZVX3Qr5NKRbZFno42TGbB0U4gQ
         ANX8tNjiubOjxwrEuHLI8KsQLXVLIoQOAaBFTa1o/Vay+VO1slcIrPDHG3K4lKjZ/n56
         G1fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZkUGHYI5VeFHKKHhAg6B+QRdbBe7VuA3rYBeaGApuPvChQi183ZM3v/CCQYZE2941zz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl5c8UPxwFPhh76Mk0DnpW9rle2x670tzPqmoGvv/aJB6MACmU
	F+t2+sTCquGkWULRrCdBV5SHp9VPzxqywLPLTSaTq4D/IqFNaBlWPeqZ
X-Gm-Gg: AYBFou3sl1ncB84qc522vGPpBUbBvPkHDgAk/KdNVsrrl02c9UPwRK1IkbafaSYguSU
	fI97WFwRsxvzyYotvD1CUH75fwAL5elNqEO4xpdbepNbEyNiOb0PeAKXfF31N7arfverYSSMYzQ
	VvD7EEXD9tLyjyGt16iD53n+PYl98NydBjl9oqBw1JjdgcLH8x7vwq54vxAuciem4vHLP+xVX5v
	wKO3nbuCNtJTFGldZDlXrt1h0FCuoInmEya1cPbxN7jPFRdEWiWKy1fLBbih0AdugJG3Kp5Akmb
	d22cq6w3E71r92LptHRSYPo5lkHJ3+W2Njn423m60bZL3twx4INckKyFQ3MRJXDwUP5zychbabR
	NnOGrh9V6s4//6D0sSPn/pg8SFkjiRbBwn6aXLql+aAngm9WctFjLSJg6534VVnf2Ko1atZY7u7
	Dt2XYc8lu9paZNKoo7OOJr+ThYJtXDdQ0ev+RvmcBG9K23ox2LdqDwVSLHUsqPp9OBWQnATRppL
	wk=
X-Received: by 2002:ac8:5d46:0:b0:536:6378:c80d with SMTP id d75a77b69052e-5369b7cb970mr1892961cf.32.1792532088120;
        Tue, 20 Oct 2026 14:34:48 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698bb3d39sm5326391cf.23.2026.10.20.14.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 14:34:46 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 17:34:45 -0400
Message-Id: <DM9ZLBSOWNZ5.282M34TDNA4IT@gmail.com>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Alexander Duyck"
 <alexanderduyck@fb.com>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Eric Dumazet" <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Jakub Kicinski"
 <kuba@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
In-Reply-To: <20261020212155.47v0ot4g@linutronix.de>

On Tue Oct 20, 2026 at 5:21 PM EDT, Sebastian Andrzej Siewior wrote:
> On 2026-10-19 19:05:43 [-0700], Jakub Kicinski wrote:
>> On Mon, 19 Oct 2026 23:54:05 +0200 Sebastian Andrzej Siewior wrote:
>> > On 2026-10-19 09:04:38 [-0400], Daniel Zahka wrote:
>> > > > Why do you have the two mpnic_base_stats and fold the stats into i=
nto
>> > > > it? My guess would be that on stop the counters are reset and you =
want
>> > > > to preserve the stats.
>> > > > =20
>> > >=20
>> > > Not sure I understand. I think you are asking about two things:
>> > >=20
>> > > 1. Why have two mpnic_base_stats?
>> > >=20
>> > > To avoid a separate heap allocation that can fail. Handling an
>> > > allocation failure in the ndo_stop path when doing the aggregation i=
nto
>> > > the base stats is tricky. =20
>> >=20
>> > Right. But looking at hinic3_get_stats64() for instance (I just grabbe=
d
>> > a random one) it simply does query the stats for each queue, add up,
>> > return. It probably does not drop the queues on down, just reallocates
>> > them while changing the number of queues (and maybe MTU).
>>=20
>> I don't think pre-allocating stats for chips which supports thousands
>> of queues is reasonable.
>
> I don't mean to pre-allocate stats. If device-down removes queues then
> the stats gone, so what. The queues could remain.
>

hinic3 preallocates stats state for the max supported queues at
registration time. That's why it doesn't keep aggregated base stats. It
also doesn't implement the netdev_stat_ops API, and if it did, it would
need a bit of a redesign to be able to report historical device level
counters separately from live per-queue counters.

>> > > 2. Why split stats into base stats and per queue stats, and why rese=
t
>> > > the per queue counts when the device transitions down?
>> > >=20
>> > > This is the way the stats in netdev.yaml are exposed depending on th=
e
>> > > 'scope' request attribute. My reading of the relevant kernel docs is
>> > > that the per queue counters are counting events for the current live
>> > > queue, so it makes sense to reset them and fold those counts into th=
e
>> > > base stats when the interface is transitioned down. =20
>> >=20
>> > Is there any other driver doing this?
>> > There is ::get_sset_count() and so on for the per-queue stats.
>>=20
>> You may be mixing up queue stats (netlink) with the old ethtool -S
>> kitchen sink / garbage dump.
>
> The statistics is folded on device-down into a global counter. So on
> device-up the statistics is still available. At least that is my
> understanding. This means the per-queue stats are lost and global stats
> don't match the per queue stats anymore.
>

The per queue stats are kept in per-napi state that is freed after
folding in the down path and then zero allocated on the subsequent up.
