Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862C43FD26
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076581; cv=none; b=k81X2dP7tCpY5+fhTxpTIv2RIjti0X4zPc2015Tu0YoSE11wxKlMOCO+GYgCoTaKEfp6qST4Jet3YVzRxxXUXZWjDzzNtDbzc55x8djoWIpTVeFwWbLRc1IpJcUc7uhqTI3D4Gily+n5pV6HSarkCnbvOex9JSIsIpKX8lZ6WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076581; c=relaxed/simple;
	bh=fePiLZS/g3Bx8H0TLNR7mUgRZEZ8yYZVNkO8Y+/pq6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGkSZovRVBkAOkOdj6jW7WF/sQRgvKHqy4ax35+uQnIHZ4do/PRuTODFHCct7JULTg6w6lHzmeXwK+TuQ6H/GSDGkGPlpx4ISAk9T8bJfLvHkdNHpIG5OFkUqUSDlnkMjNFSfrE0tTF65RFIRh1J1hDrDG1jbl+9NWdT23qo8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJRB3tIj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL/MF7uh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJRB3tIj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL/MF7uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787076579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
	b=NJRB3tIjOv3arqAR/rEPeYsYcEWHnGslaoXDqyqdtIZcSYu6y5eb3BfYl6vQAoK7qSRbjz
	PkBRlqenBKmJw6ZMg64JqwIJIvefVBHdMJAMWep7ck/eh6z1MH1CDB2avT+F5H9AKLxJjw
	4t+Sx5zT6ciUESdUJvjA+wNhe1XdO0A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-rR3sqQTXP8CBmq3qq6TpXg-1; Tue, 18 Aug 2026 14:09:37 -0400
X-MC-Unique: rR3sqQTXP8CBmq3qq6TpXg-1
X-Mimecast-MFC-AGG-ID: rR3sqQTXP8CBmq3qq6TpXg_1787076576
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4601af62so37819f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787076576; x=1787681376; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
        b=VL/MF7uhJohrENXEmMvutZCA3fLN0Z81WDGMZ6qbL0+WT7FPZGzNsKY7QqBSpJU4RR
         HHmRmoucnN7lO2GfaXrH548ve9bV30gpRQfc68x8PGyqJn/zQcZGiMPbEKQPZENf4Clt
         NvG9rDYuXINQqjS1JN1TVIMTg4ka/QDnrGbGavh/qViubilKgxOp7LA4R1bdeL/ZRbbS
         A8eElxf4JcOIP+QGn+2F10q/PQOvv38jkoqYkkXzY6GhyQl2ZQH2w9yRH9s6iUQvGBy6
         jBfdnsUGYZKtyPjj1nxU6I098slCW5Md0+Gr+WPFTZ5qTAHCTNNGN1FKTyzb1FJ36eTo
         DSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076576; x=1787681376;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbMG91XJkSDOVCgcf8S4eiNN3mjMzoFKvd3Nk1kKRdI=;
        b=ItCV60RLIWa3UXtAeXuOoKo/zKBdue8+vR7v1WGvkD+UqUhwWzHofX3W57uQyIn0nb
         uviHkXsmHx8wEPzInGEJrlLr0O2xZiszes/cXvFi9KiTTTueEVZYY7sXpf9EhaYOZjsU
         ORzsf3ZICiXIQj/SrIyhlgZhsXu2T5EoU26Fl19B6vJ/fcMCjPtzBW84i2UXuSpDUkhu
         Xq36Xdg4AWjWCVxq4dchymN1mDvpeQLfTDQr/kSUEbkrxkw9rRpdYilP1LsaSH6BlTIi
         JBNLwEqFJEvp/5xm6EZP+VqxZ2FpCnZNNx+/GwA+YEV54NDYhUM1eYhoPzGiJ8a6Ztyj
         59gw==
X-Forwarded-Encrypted: i=1; AHgh+RrhziPc9CV0zZWBi88FfEE74AZH/xYd+SFYEGomt959Dz3aEslu3xIqIp3zldhweys/jfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGBuiSAARZ5QUNLzHrgExWW/aKFMt2KiZ/1dLwD8h+KPIsSk4
	6sGnYpOhZ3GnW72XU/b/7dGR+MvLwpQO1KTv97kDV3KPI100JOBCKHEsUuvHf/q9InMJWUVyoZO
	rCDR7hjQBgZjbSN1A8s+Z1TrEdhfv6qgrZXzASVnDndy9pYl2ekXsyQ==
X-Gm-Gg: AR+sD11r5VC8/rTbIvbExF2vBf1nw/ct4u7XKcGqlic52dIoEjGaWyLgdvYgJ2GSN9i
	hnRd7xgkdpk+7P+Rsl+U8AwWw4dxXEWJFaRY7gNz57MdJ776YrG+bpr8x/JO9ExeX8rlbSkW9hQ
	Add7tjxol0cf0qAz5rz2MFjrDDFk57fuB4094njdv+uEEbUmynKjXRyewPx8OTouFq7u5d0jBgA
	4rw6COdJKUHqlJjtSiaTOcE062ZlupAcCTUNgudZroN/1inFwVQTWW8/MI7vlVsngTGQY571rBD
	RVB4jFCWWUbZnhPDQoszr4yXiOObU9cF4/V5UBjv0pXCteHrIq/FKtU/1V7cIFFu6G5qg9CTYhW
	AseykBGJ3Wg0tApiUpc2SKLu6
X-Received: by 2002:a05:6000:29cc:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48160738c19mr44990089f8f.16.1787076576467;
        Tue, 18 Aug 2026 11:09:36 -0700 (PDT)
X-Received: by 2002:a05:6000:29cc:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48160738c19mr44990028f8f.16.1787076576088;
        Tue, 18 Aug 2026 11:09:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c603sm14758633f8f.21.2026.08.18.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:09:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 57C3591AE2A; Tue, 18 Aug 2026 20:09:34 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Kenneth Lee <kennethbwlee@snu.ac.kr>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Martin Willi <martin@strongswan.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: xdp: don't assume an Ethernet header in
 generic XDP
In-Reply-To: <d9c3234b-99ac-430c-ab62-9b1412af3461@intel.com>
References: <20260813113229.381136-1-jiayuan.chen@linux.dev>
 <d9c3234b-99ac-430c-ab62-9b1412af3461@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Aug 2026 20:09:34 +0200
Message-ID: <875x179u75.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Thu, 13 Aug 2026 19:32:24 +0800
>
>> Kenneth Lee reported a bug [1]:
>> 
>>   skb_vlan_push got skb with skb->data not at mac header (offset 14)
>>   WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0
>>    ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
>>    bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
>>    bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
>>    tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
>>    tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
>>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>>    tc_run+0x31c/0x5d0 net/core/dev.c:4411
>>    sch_handle_ingress net/core/dev.c:4486 [inline]
>>    __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054
>> 
>> bpf_prog_run_generic_xdp() just assumes xdp->data is an Ethernet header:
> Most XDP programs expect Ethernet header at the beginning of a frame.
> Unless you write a custom one which doesn't.
> But then you may face that XDP_TX, XDP_REDIRECT won't work properly --
> cpumap Rx, each .ndo_xdp_xmit() implementation -- all expect Ethernet
> header at the beginning.

Yeah, I don't think we should start messing with the "XDP is Ethernet
only" assumption at this point...

-Toke

