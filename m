Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369918;
	b=YzNBoXMdOjrlH16XCibe2UIpPMmWx2vW5raEL1MrzNqvEixUm6nm7TlRcXUKXhfHJv31
	 YspA3p3Xl6CjCnXhlEMHggPRo5RIeAWQSWFGtN9nbmNCAIelDN90C1xTaDC0EiYZlYxs+
	 uOoBWJ3+H/P4E9TIxpcDF/xGtPEoMU1SsJ/mbut6+tb+u0UUXYCgohmCAgQ8AnEQAc7h3
	 KvHtakkYloQsfcAaWyMElKZ/JZWXOnaZvtWJ3Ezx6iMLKcuTrHvI0f07KnhaqtHEbdWaz
	 YiMVFQ1+Klzb2ND0KCpxn2fJMqmoOsZezV9pZ9KRKySD0LF0bs3WffNzFcXhSJTXiww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369918;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
	b=xIvOUbATFNSjZidvh0k9c4t4Pd5pGBCPiLsgyANcfbLljPoCcsypsE43BugvVTuBuEaB
	 +Pj9ADNMcg0h1mXZCFRaUKSYpJTjoJdpeeAscYSayAs5zdIgzikM6kdsjcxrpT4Pu4fcU
	 FUsH0dKZA/oNMmkFB4iBw68bS9mwR4Kqv5ODm7G3GIbCK204Cw5LEirWQgTxPJWTF44Dn
	 hTMB4GEj1PLOPJgo8tD6XerRW4jCWZI36415vZbAi48vv3cGPY8CLJMtfQ1ceOcvgggPJ
	 F+Z2eir+vp1EkwB49ClYsPq00pIoukPhaHLQgYjX3AxE570ZVqO21f1m3SmnKwVzlnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWhfWLrS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jSIR7xJx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2E606A31E
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F2E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWhfWLrS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jSIR7xJx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793369917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
	b=BWhfWLrSeJLZmxGw3mNnjEjbRhwxgkW27jDPH9uMILAHUWC080Jx4oxPJmbsYo7ple7XNr
	YTMQCJWvnfW2m3ZO+4I6DJxX/uv2oD8IZDF7ruu8L0sGlkq5IbEMVkA5ejkEm1j9IPnTIc
	ALRmPkfg1RGfnWSaollXArhjEOEP5yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JPmE6kIjM1uQIF2zGZWjFQ-1; Fri, 30 Oct 2026 10:18:35 -0400
X-MC-Unique: JPmE6kIjM1uQIF2zGZWjFQ-1
X-Mimecast-MFC-AGG-ID: JPmE6kIjM1uQIF2zGZWjFQ_1793369915
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02d63407so637393f8f.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793369914; x=1793974714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
        b=jSIR7xJxZioxCjZ/aBGv3XMOWRSeqLm93tOxK4uNmGv9N+J13uqsTj4HUjsP1ZLtbP
         qfUo/fmAxcShDCjIIDgt6YeY2qMitp7DsMbPEJRg1aC8Z0edFAML5lkQzBHZKngUIrRO
         iRs/DaEqiaZwasu+da8IMrN1smwlRxXtMkMfTB/OPOfNm4V5w6p5hB9ajmMBZpBPyiW2
         bUZpVyn/qjUcGQkZS92QQtjtlAYk9DKm9Y9DYJnSjpklai+XnWhymo9cMgIj9tSyRtIB
         WjG5C1gtPOFmAC3jy6WwuFrkSy8LIV+zD07QRAB2i9XJGXeJu+3Hr0bC6d2bQeCAyuWU
         8eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369914; x=1793974714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
        b=QetPGLB3FXhmkx3fH259+DiJp9JK5Zc7W1IWt7jyJEgQSTEuWD1uM+hdIGEew+aLHD
         4EHU74tndDZX0VqL3Jzb1YUSA76HqLFcSUKkAwrwYp2vQ2VU7fkMw7Dp5jF29zyZuKdD
         673hokuSKHSCTHbMv4/kTNgDaVsDyo9rrkEBmON/cj8PTMkA9U1GZkY85CdgemLdBqVM
         uxvGiHU82dn7rR6n9Sf47Sb+Qkp4GgEJHQxQ6fUjjMocLyMGfYWuExxhJZHWWFk8fVEU
         kMd/7jQYWXCan3dPrpWBmweKWKQm2aEQp5SHcfLSNusBpmbFR+TiiHaY/gBYgHtSHYe0
         6Qrg==
X-Forwarded-Encrypted: i=1; AKwUvByZoNNljr1igBGgemhTIKw90f66sf63Wb+litD7bda6jGPyeLynnIdpLUrQzpQOKrYmsAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ9TzFIZE9II05jleVNQzfXveY34TnBzqgPhRuY4imoGmlFCNT
	ezrhRqSG7TjqRwas/Dj/7a1ln3XYqdW+X1B4wQk413W3n8aqzqBxVpQXj8ijAxUWn09OJ8KN0QP
	MG7kovbSp/SZdyxWfbVVOXaW5BZncNNuYoh0QQtSXkYnk5aJfXZhAXQ==
X-Gm-Gg: AYBFou2AbZwJCHSYdC8E7DUZkeSwgAJ9MK5nHbVn/jjerOJZUkI/b43aDlMlF5QWUKw
	SXtqbukCIG1oN2xjRnrrC8+u5uscDJXf1z8nlYlsw0dxH5HZQHc/63M0ODsakTmJ6B2f93mPrMi
	PXkkTUEX/KCisiFO0yHcV2Qy2dfEDaCTQonRMQA0ajyw5QMl9MppoJEDT2VyoY7QwzmVxNmRzfD
	gBZYRci++njxuudeqxy/g+8zSnDKt2B3JBz7dq3qsWKHSZAkIXuGyS/ga3SEDEb9BF8qTrQSF17
	+cmtVC/cM6ThRAAylq9zKKKlXK9ajk/fm347yGVU4qiDqnbkb4ZJhUv9vP9dKWgIBxGMAQmplgc
	Wqj53q7yuXSowjozn4T+trZh+iCdfoNcH9gU8UnLcsTU6S4DnAZfOOKgAzZUam4SnC0aDRcEWGB
	bfB0OxlOzRlHMfBpo=
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr6819363f8f.34.1793369914408;
        Fri, 30 Oct 2026 07:18:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr6819274f8f.34.1793369913924;
        Fri, 30 Oct 2026 07:18:33 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm3565782f8f.49.2026.10.30.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:18:33 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:18:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Message-ID: <auSkQOU6qmj0NPEt@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
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
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>

On Wed, Oct 28, 2026 at 06:55:40PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
>loop, including vsock_msg_wait_data(), which sleeps in wait_woken()
>without dropping the lock. When data arrives, the transport's delivery
>context (the vsock-loopback worker, or the virtio/vhost rx path) calls
>virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocks.
>That context is the only one that would queue the skb and wake the
>reader, so neither side makes progress: a blocking recv() hangs until a
>signal arrives or SO_RCVTIMEO expires, and meanwhile the shared delivery
>worker is stalled, so all vsock rx on that transport stops. The
>hung-task watchdog reports the worker:
>
>  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
>  Call Trace:
>   __schedule
>   schedule
>   __lock_sock
>   lock_sock_nested
>   virtio_transport_recv_pkt
>   vsock_loopback_work
>
>vsock_bpf.c is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
>drops u->iolock around wait_woken(); tcp_bpf and the native
>vsock_connectible_wait_data() also drop the lock across the wait.
>
>Releasing the lock alone is not enough. With the lock dropped, the
>reader is also woken by events that bring no data, for example a credit
>update via sk_write_space(); vsock_msg_wait_data() did not loop, so a
>blocking recv() then returned -EAGAIN early. It also checked only for a
>local RCV_SHUTDOWN, so a peer shutdown or a reset was not noticed. A
>looping wait must stop on everything the native receive path stops on:
>without the shutdown checks a peer shutdown, and without the state
>check a reset whose error was already read with SO_ERROR, would sleep
>until the timeout.
>
>Make vsock_msg_wait_data() loop and release the socket lock around each
>wait. It returns 1 when data is ready, -sk_err on a socket error, 0 on
>RCV_SHUTDOWN or a peer SEND_SHUTDOWN (as vsock_connectible_wait_data()
>does), -EAGAIN on timeout and sock_intr_errno() on a pending signal. It
>also stops once the socket is no longer TCP_ESTABLISHED, with 0 if
>SOCK_DONE is set and -ENOTCONN otherwise, mirroring the state check in
>__vsock_connectible_recvmsg(): a transport reset
>(virtio_vsock_reset_sock()) sets only TCP_CLOSE and sk_err, and
>getsockopt(SO_ERROR) clears sk_err, so without the state check the loop
>would wait out the whole timeout on a dead connection. Data already in
>the psock ingress queue is still returned first. vsock_bpf_recvmsg()
>returns a negative result as the error and 0 as end of file.
>
>Two userspace-visible results are worth noting: a pending signal now
>returns sock_intr_errno() where the old code returned -EAGAIN, and after
>a virtio transport reset recv() returns -ECONNRESET until
>getsockopt(SO_ERROR) has read the error, where the native path returns
>-ENOTCONN.
>
>The deadlock was found with the help of an LLM coding assistant
>(Anthropic's Claude); Sashiko AI reviews of two earlier sockmap patches
>had already noted it as a pre-existing issue. The early -EAGAIN on a
>dataless wakeup, the missed peer shutdown and the wait on a reset
>connection were reported by the netdev Sashiko AI review of earlier
>versions of this patch. Each reproducer is a C program run as root in
>the guest: it adds one end of a vsock stream connection to a BPF sockmap
>(CAP_BPF and CAP_NET_ADMIN) and drives a blocking recv(); the reset case
>connects to a peer on the host and unbinds the guest's virtio-vsock
>device, the others use vsock-loopback. No kernel change or error
>injection is needed. The reproducers are available on request.
>
>Testing: built a KASAN + lockdep kernel on net and ran reproducers on a
>private VM, before and after this patch. Before: a blocking recv() on a
>sockmap socket deadlocks the vsock-loopback worker (hung-task). After:
>it returns the data; a dataless credit-update wakeup does not end the
>wait; a peer SEND_SHUTDOWN returns 0; and after a reset of a virtio
>connection (unbinding the guest's virtio-vsock device) and
>getsockopt(SO_ERROR), recv() returns -ENOTCONN at once like a socket
>outside the sockmap, where before this patch it waited for SO_RCVTIMEO.
>No KASAN, lockdep or hung-task report. With both patches of this series
>applied, the three single-VM tests of
>tools/testing/selftests/vsock/vmtest.sh (vm_server_host_client,
>vm_client_host_server, vm_loopback; 44 vsock_test cases each) pass, as
>on net; on both kernels the host-side runs skip the SO_INQ cases (SO_INQ
>not supported by the host kernel). The ns_* tests of vmtest.sh were not
>run (they need root on the host). The BPF test_progs sockmap_basic,
>sockmap_listen and sockmap_redir tests pass (767 of 767 subtests, among
>them the three vsock subtests of sockmap_basic and the 240 AF_VSOCK
>cases of sockmap_redir).

Ditto about commit message, please put more effort on writing something 
readable by a human.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 62 ++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 48 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..5120911b8143 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -34,24 +34,55 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
> 	return vsock_sk_has_data(sk, psock);
> }
>
>-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>+/* Returns 1 if data is ready, 0 on EOF/shutdown, or a negative error. */
>+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
> {
>-	bool ret;
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	int ret;
>
> 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
>-	if (sk->sk_shutdown & RCV_SHUTDOWN)
>-		return true;
>-
>-	if (!timeo)
>-		return false;
>-
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>-	ret = vsock_has_data(sk, psock);
>-	if (!ret) {
>-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>-		ret = vsock_has_data(sk, psock);
>+	while (1) {
>+		if (vsock_has_data(sk, psock)) {
>+			ret = 1;
>+			break;
>+		}
>+
>+		if (sk->sk_err) {
>+			ret = -sk->sk_err;

Why?

>+			break;
>+		}
>+
>+		if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
>+		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+			ret = 0;
>+			break;
>+		}
>+
>+		/* virtio_vsock_reset_sock() sets no shutdown bits, and
>+		 * SO_ERROR clears sk_err: check the state the way
>+		 * __vsock_connectible_recvmsg() does.
>+		 */
>+		if (sk->sk_state != TCP_ESTABLISHED) {
>+			ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
>+			break;
>+		}

I'm thinking if we should split this in multiple patches.

>+
>+		if (!timeo) {
>+			ret = -EAGAIN;
>+			break;
>+		}

Is the move of this check changing some user visible error?

I mean before this patch it was one of the first checks, is this okay?

>+
>+		release_sock(sk);
>+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
>+
>+		if (signal_pending(current)) {
>+			ret = sock_intr_errno(timeo);
>+			break;
>+		}

Why? Should be a separate patch?

> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	remove_wait_queue(sk_sleep(sk), &wait);
>@@ -101,11 +132,14 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> 	while (copied == 0) {
> 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+		int data = vsock_msg_wait_data(sk, psock, timeo);
>
>-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
>-			copied = -EAGAIN;
>+		if (data < 0) {

Why not data <= 0  and void the other if?

Thanks,
Stefano

>+			copied = data;
> 			break;
> 		}
>+		if (!data)
>+			break;
>
> 		if (sk_psock_queue_empty(psock)) {
> 			release_sock(sk);
>
>-- 
>2.56.0
>
>

