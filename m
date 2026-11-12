Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503067;
	b=Sqf5H0oWsfCyyIPg3KEvmFRkfC3CpfCfrnRRUbGdhYzFR79txQe05Ob9uuohCdmcwCvq
	 sm50k6iGB+xEg6Xjtb1Evs4jMlAoUiGB9AU1vxqNioqbzGImd7tWgb/Dll3165qcuzpqt
	 87k80Um9XDmGnMzdOGElucbk9C96+O8umocEnwih/pA5ZmpqO1ROprMYs3TbRBHpVQftQ
	 84itH5w7ZraAYmZLrOxLo8HesoUC3gWg6QjzJL7cti6a39KHUGVd+vaShE83sCQr/26yf
	 IEO3IpO6POLlve2DX39pYRzMGWRGik+7vdkPmGQ7kUrcYlcmKQOGqY/5Yv09tdH5bXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503067;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=AHroQeti182Hke1ZRzechwagv7/VIBouqqKRFlqtwhQuKwoSCxHK8tbvGz1vob959pox
	 s5qN3YRfFYrKclWOdenI0A6y4viSVC4nh0CGt/BYxhKiGiZtFtVhR9Ued8vXLJpsRW6zT
	 7/BZ0mlGc8y63SXeEVexJnX4kPmslgoL/Vp/PmxLKUlN5CvfXT/gbreDBjJ/GxsF52VOT
	 /c40tCDThIts/V+aeUmFmsoaENgzTE2a1UqlPi5wa9d+LtaY8oQEPzEA+Xf5VnXV/7KIH
	 1gPUBiUWLf94r21mOv0u3rRCma9H3Gfak4TNZ2kBehtfu+LHv2mI0XU+2S77I9DIyjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e5txvaix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E3606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e5txvaix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794503066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=RSM4jfOySxzjJPJjdouIzY7aahn6xYwmwQ426+YBqQwkDoWHGLgeqj8QRmvU57NPACXmsh
	zlikkXlCu202+ypjIEik6t9BI6oNtWjvXMqD6ktYDAPqn115ugNa+3Ye+Ves2Fl+fDHFmo
	IiZSu2po3bI721tRDFzdUrROBgpMv/E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-hC9bm8N1PEm2BFMqytp1vQ-1; Thu, 12 Nov 2026 12:04:25 -0500
X-MC-Unique: hC9bm8N1PEm2BFMqytp1vQ-1
X-Mimecast-MFC-AGG-ID: hC9bm8N1PEm2BFMqytp1vQ_1794503064
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f0f4c70cdso305906d6.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 09:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503064; cv=none;
        d=google.com; s=arc-20260327;
        b=CPQUYWA0jhREmBAIkRdyAKkNSJAtycuSwC2GV2b1Y7Cn6jrdGt/AD1BUnR9X6rBYhz
         04hP6PqQCJTUhFvErxsIniEsQNWwdYvagZ70awB0DoIpWnwbUZ8NFDv4YsbtJh66tF5/
         AR3NXdcum4vpZRsgmJnIINlyIszXdLPCnTSxZyRWHoEW0TPXVETr6a1Z+JgPCMIOXRV7
         EjZTvSJekm88bGQq6eW26NCuCVfQCi/sjEbFzylth0IKVXej9C//Vm6vhysszmCnTmVy
         CiFX//p9CmCxMKglpib7UEnngva1CzqNhCc5K8AOyNv3shC/LmLTAb2hL59tBXHt05oa
         t4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        fh=oYAYrHAcAJVASVPGauSsOEhSeHtrA3upxiY0FXxjHUI=;
        b=QmLaqPmCuJ0JU8WYFViMIxL+UUR7kx7HPD9T9BPcAyMtVdWvT30j2FTpO8Nq5xy1F/
         yA/ER6hWRdo40Z39fBHP2giC0cR12tjJdT266ftQ78tK3yp8HLdFatafROv4FL3no73h
         VW3z3MqqNVOWh28mum5bpKgiITroh/eSA9iitLjmxTuLXzmXWzvgT93pMMjQMU037oUS
         KdQHd4qFTuV22KCkfVAu/Am5Yt4T9y9yjUUxMX3UpqTd82eVjmdgzBKhnSe0anQ94VrK
         EGJXdu8PxepVkGM0tiAEBuL4P3LSUiLGI1lsQPJii+5FCQd4ILLJAHUxSTz4Hio7IKga
         cJmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794503064; x=1795107864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=e5txvaixuvNHqul+AWOdRXYydV2CRIOdF+h3W7bH/p7/mu/wQV+rRR0AggOfVeMj4b
         SYjy34d8t6Gk73gu2hks5YczKaU441O1G0I6qOpMQ+pKV6jRstxCEKCKICdZnTCkpgAL
         UYcH8Upb6118IKl5V62rqD5IHgK4RD4M/mthR0jOmsytXYOR//aQJ6A+IU30mlHHNeyC
         IhcNpD4JUQfFcvabxt9cYStBIpHAr7tTXKsN2dScD3Jg2z7IhCQ46YOOAM6jbDzz+RFx
         76MiizwYlDCNbPRCUT2uApQDm1x9dbQ/0zTEweG/KVhO72XTi+fpp0LfHQCWdcDZ1gQL
         Qpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503064; x=1795107864;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=pEFZpDAvceA+l3btJhi7qW/6i5o7wphkNYH/WgLdkRX9/LwGAsnwJOgtbjZ1jFPJ2t
         VfiSph81EEzZ3JTLIp7+mRBYT9WhmrAWCOl4OhFlQgtzvKWu25GNBJuu4RognccFgxR9
         3FQiPLGrbuxtf6ZZUxdGvaWEfU/PeadPiVyTc8s+86DV3jJeiQ52xmVtKJyqNPXfpl80
         9ylruzi4wiYhpX8MQc1eEfeJ5LsyfRlboa+LUnQPiYA6p3+0eQb+dcj1opKJOSw/8Z6F
         DTobtltuCXI4okaVl+Wc5ynlNS3OJiuqE8ZCzQGaOye+I9Ab50ecNzL4sXvS+CIGx2tC
         oT7A==
X-Forwarded-Encrypted: i=1; AL+hErFkGsNdZyBH7V2rZzN2wI8kMsSzsnjNpvO/Abpe5Al7wkFeUpr4t97e0Wmbd6+5F6pRlms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dMQcE/bz5kdj5rhzlrfP63Hk2OY8ZSulZBdiUL4obYDne/6/1
	s4sGWbccADW+YI+pN8+RzamY+9gm1NM68YLIbg8nolU8tnvBKUg7DINRY17GZdY1lQRUnqW8XQN
	kA/YjKbRGpTatNwy+I/SRCOt/CVHg7KEub+eoDmkxCAfjyr66P1Pppcctbe6ZVsjJi/lSN0D+vh
	CUEnk0BJLt2pMIzG1/UKNhm0syrB5u
X-Gm-Gg: AYBFou3b/tzKp+V9UdK++DT0SqJAAt3GV5h4twfvQYs0tf8yYWdYvO+qFkhR4wyWHNU
	I/A4dSyxz9gpLOaw20FoKFlmDQnTVJ59qsLPtYhAe19c/Q81Jn+7lcbXzEM+8oqPMnOrcOsYoFw
	tMYhxmyG/wXV3HqJl9IQubOFA35E0Zca7gA9JnLuOXRhJaTef3hhLehnU=
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91f040c0da4mr105357756d6.28.1794503064238;
        Thu, 12 Nov 2026 09:04:24 -0800 (PST)
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id
 6a1803df08f44-91f040c0da4mr105356616d6.28.1794503063345; Thu, 12 Nov 2026
 09:04:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:04:22 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org> <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:04:22 -0600
X-Gm-Features: AclHuK8-kXlDfbY9EpdjADOfLMjXVcZNZptS66ye_0dxL9--qQit5gRpAYjKWyc
Message-ID: <CAAiTLFVrvmrLoFxAdJ+ObY5trjgKvNJW5im7XaRQ+K1PG-_M-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
>> This series implements SOCK_DGRAM support for virtio-vsock and
>> vhost-vsock, allowing applications to exchange connectionless messages
>> through the existing AF_VSOCK datagram API.
>
> The cover doesn't say who needs it.
>
> Bobby and Amery took the same feature to v6:
> https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
> Stefano said there that it can work well and that the virtio spec change
> is the next step. The last mails of the thread have Amery's v7 WIP and a
> short list of what is left.
> The cover doesn't mention it. The spec change is still missing.
>
> Why not finish v7 instead ?

The previous series is more that two years old, and vsock has changed
significantly since then. I thought this deserved a complete refresh.

I should have linked the old series in the cover, though. I'll do that
in v2.

As for the spec, I asked Stefano and we agreed it'd be better to have a
series that's pretty close to be merged before sending the spec change,
and I agree that's a good idea. In fact, adopting SEQPACKET's strategy
for splitting up packets in the vq would have an impact on the spec.

> This RFC goes the other way in these places:
>
>   what               v6                        this RFC
>   -----------------  ------------------------  ----------------------------
>   (cid, port) space  own bind table for dgram  shared with stream. The 2nd
>                                                bind() gets EADDRINUSE
>   vsk->transport     empty until connect(),    g2h or h2g, picked in
>                      lookup per packet         socket(). -ENODEV with
>                                                vsock_loopback only
>   routing            one helper for stream     2nd copy of the chain in
>                      and dgram                 vsock_assign_transport()
>   recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
>                      no dgram_dequeue()        dgram_payload_len() is new
>   VMCI               fallback                  first. No virtio dgram when
>                                                its module is loaded
>   dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
>                      the error queue
>
>> Datagrams use destination-based routing across guest-to-host,
>> host-to-guest and loopback transports while retaining the socket's
>> transport state. VMCI keeps priority as the dedicated datagram
>
> A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
> bytes_unsent. They serve SIOCOUTQ only.
> virtio_transport_alloc_skb() does skb_set_owner_w() already.
> udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.
>
> Without them a dgram socket has no transport state, like in v6.
> Then no need for the owner transport, dgram_transport_match(),
> fallback_transport, tx_accounted, the skb destructor, etc.
>
>> transport.  Guest RX buffers accommodate complete messages when
>> datagrams are negotiated, preserving message boundaries.
>
> That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
> It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
> that each SKB fits in a 4K page").
>
> pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
> charges more than 64K to sk_rmem_alloc of the guest socket.
> The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
> queue is dropped.

Thanks for the review, I'm putting together a v2 addressing these
concerns.

Cheers,
Sergio.

