Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370341;
	b=LemCf7N7bMw35MpqVedOzSx64h42tuJDm6jpq3c11bILcnaABsJHTEHmN9dv9bYp7/T5
	 RAmrXye5RS3oOy5/KdJhAdgbkJCt6g8LIfrp4h0+aURjlJ7JeoAP8LmGRIXpb8Zr77D05
	 ootcpWWuIV4tK6/paEkc/OetGFYuBETZJ9EDc+/TESfSGi1ogMMuOqO4LGyLKTuRe2ieg
	 JqRTbnpONxLY33fhfSPQ4AbKlULA/1c8vYxpu26vxPf12gWyRbBNH7nUN07k1xC2aSNbE
	 v5by9nFIp5wZFljwEZYZPqBtRl3aimBgQbc2wxZJ6DEWk7IgsTx8uQ1utUvkfTluDdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370341;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
	b=xv0VCSJVRo07cG/Kk8c2XNAefa/CgrYwmBbr0LVV0uSX1j14t2Q+ExXo5SH8a5tYpszD
	 FApMz3CRkzmtMCgnnuin+0f1gLj+kKiGqchqPt6fCKzQpSgvEOPrQXDW44k2BOpN8vvUH
	 /XuBiz1bsn7eSqLP6XPthXq9CoOyB9JMRan519AALDo9RNrUy4yYHR4hkiZmOFBXU8YQG
	 8utxI64c59evfqkEU5Y5g2debTRIyEF560HbdId/0uysSEXArqQ8maY435nczZX14/bNQ
	 Wtm0lbRFIsF77Mvbgr6pqblhhJ9hl/umnfnCyLR9jwPVOwmlM8UhA/SgbhY3XRFuQig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=emiRICrv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NEns6uPc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35A606A326
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB35A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=emiRICrv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NEns6uPc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793370339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
	b=emiRICrvOUTAAUs29PuqOY+ViGTesGQxuG22Ov3Yct408ArgbpYqkQSVTTEyz04ADzq8tg
	DeJ4SP5bAYzs9xYWtY7sD2z6jpQVeLweFXhTnMONYfEASWx83kVsy5/60EP7XyuCQD22Ru
	ICvUCOtEfokPJHJPeUtA8q0eOwxOC+s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-39lxL1TmNg64HHDufxbMrg-1; Fri, 30 Oct 2026 10:25:36 -0400
X-MC-Unique: 39lxL1TmNg64HHDufxbMrg-1
X-Mimecast-MFC-AGG-ID: 39lxL1TmNg64HHDufxbMrg_1793370335
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c430f0f01so653649f8f.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793370335; x=1793975135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
        b=NEns6uPcO+4nHjZNwYtz5RcKFQaj9EIcjw1iOSYafkmlUP85BWoR42KiPmQuNcYYAM
         9DdKZ/somvAYLtHoEvIqQ2yVAxqNVN7UNQzUK0HDgQ4jjbxu8w+ndvGvPXhl8t9to0Rk
         xoXpZWrG27B4B0Sz9n2BhfDhV8tmyI47PAwVX6UN6H5pJ9tsNTDGhl76wcVhDpG8aPjZ
         JOISxMSQl6rTy1GRQPXBDODJTgCUd4QzWwsTjKVOJswS1NZRk25v9v1OVkAQ8pfTOERW
         qdbYmW2dkripMv88KWtcJux6oHEQH0G8xiPzIUVOCOAZLhcHEjxkVJPZ72pZQT/FywuI
         ByaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370335; x=1793975135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
        b=QIadPUVaYscpLLWPrEWDbMhA2SSRp/w3RFvxkhgtTFnPK3Y4d00Ag48f2uplqtNPxR
         GV5N6EiJGVPMpcheSN+vA3oCIyEwEkx3sF/SuQHYaTIeZ/clY0C2zZjnZVh3OIy81u9m
         OznL0aW9PBi+ts1Lr/9qCqeLNOuhQtmqHLOu7q87RKcTFS05YKPz5GPParAnr8MoZcVO
         QRJkHJnZDzJKvlc9Swj74DoJrKC93Up6peSy/KD6TXqewmMf6moKTWzSL2Sn2Z8MOsSJ
         cMExR/n7y65Wldrnew17xkJkZNZrGxt+iY8DUwq1D3AXu7xvDsv5YuvLGds1MNRsyg3X
         +BzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9I4ux1iJrQZRAVbiW91IN0PaCbVG34D4j+ahpFhPIP2tirZGE7nadN+C6pkM2zkxmJpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRY4w252+8VPwO5YrmUxyWlTG15R4EkykpgSosXVdpte0XjZf1
	eQZXS4uLLyiH6ZgTdLojvWWkVm2wkJt5fUO1UKzHX3ftJxxG7IwJIDsxX7tkoPkcvRkggmgr3Is
	iiZvDCWmoAjwuVqPgB1k4rLtpyUQ7CpNDG4sx+izofmkfaakEwAyQ/w==
X-Gm-Gg: AYBFou0qoH/MCDiBktjvjM1VdhkYP/6QqHsmWCGE3PkGCpK8ye6t2lRyw10w2uygLj+
	Fa/oqrBbgUVgDeeklyK31A5L2z7dBwl9H06Ypo2T4CyZIotYZBnXJaZHXu+ex6XuNsYCAxEotTX
	NARCPX6FsRPjmUON17W0/vErP2D0iLf+qXkxz8PBZhfs+E2j1PZrBlua83d6aMZr+J4z9GCy5bI
	rdmN7b276J2K00dxiUMnMwbEEQy097kdPlCIScGU9WIIAvXUjV7+Twht4KHBg9S7B/kd+YIxJSj
	xFqxOH6YzFGuxbHaonrHpMIJiFL7e72Fqemjkih5W9taSqGssh85cEZzNqMBKWEEnLiVvPdLLs6
	6knhsYtOFCg8Z+uSX5aawiCsXH0KW99VNAuLsFDN1rSu0sDG0eZcziFdVyLlGkN82iAwpJfpEjJ
	qxRREqZAAGe9HX7iY=
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr56533775e9.19.1793370334638;
        Fri, 30 Oct 2026 07:25:34 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr56533065e9.19.1793370334072;
        Fri, 30 Oct 2026 07:25:34 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm67431295e9.6.2026.10.30.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:25:32 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:25:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads in recvmsg
Message-ID: <auSngVsWiGI475J4@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>

On Wed, Oct 28, 2026 at 06:55:41PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() sends every read that cannot be served from the
>transport's own queue through sk_msg_recvmsg() and its wait loop. Three
>kinds of read do not fit that path:
>
> - len == 0: with data queued in the psock ingress queue (for example
>   after an SK_PASS verdict), sk_msg_recvmsg() copies nothing and
>   returns 0, and the wait reports data ready at once, so the loop spins
>   with lock_sock() held. The vsock delivery worker then blocks on the
>   same lock and all rx on the transport stops (hung-task).
>   tcp_bpf, udp_bpf and unix_bpf return 0 early, and
>   __vsock_connectible_recvmsg() handles len == 0 too.
>
> - MSG_ERRQUEUE: the read only reaches sock_recv_errqueue() when the
>   native fallback happens to be taken. With empty queues a blocking
>   recvmsg(MSG_ERRQUEUE) waits for stream data instead of returning
>   -EAGAIN for an empty error queue. Route it to the native path first,
>   as tcp_bpf does, so it is also not caught by the len == 0 check.
>
> - MSG_OOB: vsock has no out-of-band data and the native path returns
>   -EOPNOTSUPP, but sk_msg_recvmsg() ignores the flag and consumes
>   ordinary stream bytes; with empty queues the read waits for data.
>   Reject it right after the MSG_ERRQUEUE route and, as
>   unix_bpf_recvmsg() does, before the len == 0 check.
>
>The len == 0 and MSG_OOB cases were reported by the netdev Sashiko AI
>review of earlier, single-patch versions of this fix; the MSG_ERRQUEUE
>case was found with the help of an LLM coding assistant (Anthropic's
>Claude). Each reproducer is a C program run as root in the guest: it
>adds one end of a vsock-loopback stream connection to a BPF sockmap
>(CAP_BPF and CAP_NET_ADMIN), for the queued-byte cases with an SK_PASS
>stream-verdict program, and issues the reads below. No kernel change or
>error injection is needed. The reproducers are available on request.
>
>Testing: on a private VM with a KASAN + lockdep kernel on net, with
>reproducers over vsock-loopback. Before this patch: recv(fd, buf, 0, 0)
>with a byte in the psock ingress queue spins and the delivery worker
>hangs (hung-task); a zero-length recvmsg(MSG_ERRQUEUE) blocks; and
>recv() with MSG_OOB waits for data or returns a queued ordinary byte,
>which a following plain recv() then misses. After: a zero-length recv()
>returns 0 and the next recv() returns the byte; MSG_ERRQUEUE returns
>-EAGAIN from the empty error queue; MSG_OOB returns -EOPNOTSUPP at once
>and consumes nothing. With both patches of this series applied, the
>three single-VM tests of tools/testing/selftests/vsock/vmtest.sh
>(vm_server_host_client, vm_client_host_server, vm_loopback; 44
>vsock_test cases each) pass, as on net; on both kernels the host-side
>runs skip the SO_INQ cases (SO_INQ not supported by the host kernel).
>The ns_* tests of vmtest.sh were not run (they need root on the host).
>The BPF test_progs sockmap_basic, sockmap_listen and sockmap_redir tests
>pass (767 of 767 subtests, among them the three vsock subtests of
>sockmap_basic and the 240 AF_VSOCK cases of sockmap_redir).

Ditto.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 5120911b8143..3edc01268c42 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -111,6 +111,15 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return __vsock_recvmsg(sk, msg, len, flags);

If the psock ingress queue is not empty, wouldn't recvmsg(MSG_ERRQUEUE) 
(e.g. a MSG_ZEROCOPY user reading completions) also consume stream bytes 
through sk_msg_recvmsg(), since it only looks at MSG_PEEK? If so, maybe 
worth mentioning in the commit message.

>+
>+	if (flags & MSG_OOB)
>+		return -EOPNOTSUPP;
>+
>+	if (!len)
>+		return 0;
>+

Is the order of the checks important? We should mention it in the commit 
description (if it's important or not and why).

Thanks,
Stefano

> 	psock = sk_psock_get(sk);
> 	if (unlikely(!psock))
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
>-- 
>2.56.0
>
>

