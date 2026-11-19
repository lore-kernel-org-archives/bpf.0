Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117005;
	b=U0iyx/79/uud2kXubQiws6316fpNTGQoLuuChLMe5VUn49iykREZQVghwsHDM02x3SO5
	 qcCx3u8Y2PbNmfFcgp/tQ/3WuZhtPpFZ+XY/BjfF2dTbf0k/f6DGh/gl5P27lZSaOAP+o
	 ZPNc69ItUu4ODTdrOY5uqwDcbm4kcnDBayY5D5wcNM+8oKGHqr9mQ7lrfsI+SjcVwM76K
	 acOqCtcGTyfQUIDW9UpvayQBIkBjBdE9nw2qhQ73vJ/fLI+gm8ol/KeDd7T3ofNXx7XR7
	 DltfIIW8sIll07al8bpEPw6CVApDHtJ1pbw7ICMK+6J/ThEdu1Dz8JpL3rpSZ5S/IcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
	b=4ksRVDcyB/n4SmSQarp5ZFtgt7HrZTpExw0g2tAvSZlI8UjJFZ1o4CtSpeB/bhsSc7FF
	 5Q1FJ8vkd0yi+VFobzUCd/w5kM7gitFCMseUw3uhop7XGENe/qcT4jALYBAn0ntxbw70k
	 PZAkYxlu6uwLa3pERRzu7YhPlh1E9c13U4ykmr7NvAnSZj2JALAl0CMoYtPKl4A43Mvri
	 1PeFrmBmRY4A/tsdcYpaA2e+npUkcLGksq8e/wdoWuKzJzDlYsGuUgAfIq0wSrtVkaP56
	 tCvIRDZyW05pZAmZBZ6SVkzV/uZ/uGSq0ZwgH6I/BjoTNDcTGX2EQ2yxBv+us6vm1Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUKTHXmP;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8332606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 19:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8332606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUKTHXmP
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-716d052dc23so57381eaf.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795117004; x=1795721804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
        b=WUKTHXmPDsd8bmISSW+LqyZEPEQsRE4kJ67FPXvLSxtN1Gmsu2ddKXNZgsXZUWUwlX
         hTP0Lu5Przzo9ho8j1uFMOKolRcvpszRuWOMtitvNE/J1tAcwKrhu0FSRXVHewX0bpZZ
         MiI5q131r/I2/UIgTUYGB9lP3lSqudnWHs3z44w403i5AG6QNxSi9KLbJluult3ciAPo
         EyC+BJGtrDCIm4Ic2a4gLUJfDPHa0JxqcSU+gbl9CWU9kLRa+YzsMc1xfQeqrH9Ug+XP
         Flg/hRH7BCgRObF84+fpRBD3MaLKpk8+hIE/dzkyEXUIeDrdOhUEKV+ZkaCdvAeJkX9H
         xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117004; x=1795721804;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/2L9IovMD4zBIgZcsGeAkwPGqc72zduF1TmecAsP2U=;
        b=q3IIMD7wQAKDDSJcZiQtql4urHnCCy+92EAF9GCSsgONiuT5bAmEBhbDYiI4xoMrqB
         +TQEXmiOO5Te5h4PF4nKqBBd70vXGKiaGVP+tNPwosl9ccdcjyLgiR/n8z/F7rw/+doc
         WMEC/fyWxDGf/z07J1YsOL5qrqTm5W51Sx2o9g2ME9QpMHqijds970gYL2hmvQB7U8LT
         W800pCr07dHweGU1KBNqQeyol9P/Bw1hltPB8FWqrWUpZUQ8PxKX0iQ/QIlVj3Bz1avo
         bq6Ynp1yy7bLNe4xqHozDCNV2KFFigPoRfo+K9qm5yIZq9NPab9pTuK9gFmTUYXOJISr
         Bx0w==
X-Forwarded-Encrypted: i=1; AL+hErFhOraTEg2IDFszqEbTqTdjtnucdicY58y7/HlFFpoZMXcndzZGnoNjHz+nnUkC0LJcT4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vjPO4prv6JY+ZkuAUZ9EeboWEsbPemAU0zle17BS3+csDG6MH
	eq7GVm+IJn6/zl9w/F0oWf2tU/5ZqaFOooQQl3k7+tywqzKStk7G2xQU
X-Gm-Gg: AYBFou1r8Fv5lQ6rrm/oGgbxF3/ZSIEdwOPVbTRJ8+qXi1G009E5xmixOEnCxZ8k45m
	28Kj4HIkQAr/H93UhVBsC82AMUPT4twAHZpqFu0sqZdiMcG0tozyR9/9Gseh+YJBuMVoe/26PjU
	6FyuN8tEFmCICXXg/0e6h8eKKha9Os+W4bPE3xgbHFKq8QW9vNblICjsJM6ESE1JiIvJ1M0LPx3
	GxXUYfWaXtq0qC0D6Z9aLaZyIRoCuId5RE42kuVPYdzcUqOpf1ZdK+5zKTk6Qj23eVoJhBbBAAY
	1kLfno8oVhps/uKIKr+8qX/NUv2ZcIAp6zjUr4qGSEQ2JO49mmAo2f4Iq5Ml+0T25QkAwe/lDtZ
	5tDxRQWBmQ42ZlYe56tsG/cl/3Zl4Vjy+hs55a89KMhD2eAQzh6XvQlcvoTEP7YgNFoKonSWpY6
	M+7cy49RB4x2tr2dwiZvXjjKqtSFqUzUnOjPF8iknThwLXd9i3SfIyGd6gzcu3h8jvnyt39vWQ2
	jUQXwgy+RGdbGogL6TOf2Ock/sKvpBozh4Etwit02iATsh2MXeAbNTuMIYboO5GIAPHnfD6DNCz
	nrl43Jk1P59jnRO7w+WUwZAC+p1bq7Gnm9CG5BiPkU5XXa4Ik0gncmxU1MXJPAECZeVAsmNEZhR
	2OcKSrZ/B/Z4BfgCZ3M6EASGPqDl3tuE5J/xwUsc9UlIn8Ud1V0+SIoOT0x5bPtcG/XuAXoXfnl
	QU7XnITBiUIg==
X-Received: by 2002:a05:6820:1c98:b0:6b1:bb82:f7a3 with SMTP id 006d021491bc7-71b39209557mr740286eaf.5.1795117003758;
        Thu, 19 Nov 2026 11:36:43 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm435223a34.12.2026.11.19.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:36:43 -0800 (PST)
Date: Thu, 19 Nov 2026 14:36:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24840892273e@gmail.com>
In-Reply-To: <20261119153056.353156-1-antonio@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI or
> ksoftirqd) and is slower than the writer, the queue grows until the
> system runs out of memory. An unprivileged user can do this from its own
> user and network namespaces, and the queued skbs are not charged to its
> memcg: in a test VM, a uid 1000 process limited to 128 MB caused a
> global OOM in ~6 seconds. The socket send buffer does not help: tun sets
> it to INT_MAX by default, the build_skb() path is only used while it is
> INT_MAX, and the XDP batch path never checks it.
> 
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped; the write still
> reports success, as for a full backlog. The check sits where packets are
> queued for NAPI, in tun_get_user() and in tun_xdp_one() for the batches
> vhost-net passes, so packets consumed by XDP or delivered through
> IFF_NAPI_FRAGS are not affected. A dropped zerocopy skb completes its
> buffer when freed. The check is lockless, so concurrent writers can each
> still add one packet.
> 
> The NAPI poll moved the whole queue out, processed up to its budget and
> put the rest back: while it ran, the queue looked empty to writers, so
> with the poll on another CPU the backlog could still grow without limit.
> Take at most budget packets instead: the rest stays on the queue writers
> check.
> 
> Dropping also schedules NAPI. vhost-net sends with MSG_MORE while it has
> more packets, and tun_get_user() schedules NAPI only for a packet
> without it or once more than NAPI_POLL_WEIGHT are queued. With a
> netdev_max_backlog below that, the queue fills first and the packet
> without MSG_MORE is dropped too: nothing would schedule NAPI, and the
> queued packets, with zerocopy also their buffers, would wait forever.
> 
> Reproducer, as an unprivileged user in a new user and network
> namespace, without kernel modifications or fault injection:
>   ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
>   ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
>   ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
>   install ~500 iptables FORWARD rules, to slow down the poll, and a
>   MASQUERADE rule on d0
>   open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
>   echo 1 > /sys/class/net/t0/threaded
>   write() 1400-byte IPv4 packets for 10.20.0.2 in a loop
> 
> Found by code inspection while analysing the performance of the tun
> write path. Tested in an x86-64 VM on net, with 1 and 2 vCPUs: the
> reproducer causes a global OOM without the patch, while with it memory
> use stays flat and the forwarding rate is unchanged; the tun kselftest
> passes; a local vhost-net test of the batch, copy and zerocopy paths
> with netdev_max_backlog set to 8 passes, and fails without the patch;
> an XDP program on the device sees every packet while the excess is
> dropped.
> 
> Still open: neither the packet size nor the queued memory is bounded,
> and the skbs are not charged to the writer's memcg. A single write can
> create an skb of several hundred KB, so even one queue can hold a lot,
> and IFF_MULTI_QUEUE (allowed in a user namespace) and more devices
> multiply it. This bounds the queue as enqueue_to_backlog() bounds the
> per-CPU backlog; charging the skbs to the writer is left to a follow-up.
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
