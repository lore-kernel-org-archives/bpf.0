Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712928;
	b=Sg7D5eMqhuzgvL0p5db48hPjGv2tdiyCEdZ64xVcXZgSwuKrC3VryvaMkkxg45ArDqdD
	 +GcHDb3wzFUry/DGGUNv3dlSpo7mYO4VODSUVq+q+aShG2hLrmdtqNgb8D1EAoPUTco4j
	 j092BxETpnbRTrfIw4N1Eh/PceH5s44TgC5jpADGOBgm58CuR6js7J9XJsdT6oeNzaZun
	 LmMkTXMLpifDLGuSMq0PKjXbWPvkho7nN5XhSA1QUNzCeDQAhwuRemnW4egAuV+eF8k9E
	 KACHLsBE+4gyU8ozDaZ1YCXqSnw4a5ceLhGYqhIVxBtywwM/SGHrLFWMB5jef40Fb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712928;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UtLU+Vh4EDesMjJE1JoJTCuUxgHCL2D+tpkF5ZBWsp0=;
	b=eO5tZ7ZbiOhHQmPaoa2zNj+mwyeHR9q/nx4+CmBrEVUWHiu26CJtGAKy17EN7cr+CRZj
	 9dw2OmagZol2zQLBamtcaNGtkk9NyLdoV0eLC9wM9icUP4smq4iZkiDyuBl1C4ISKyyw2
	 Q6G4Zl+kTyuzn+PSQwUszQDVqyhom7cw6ecY9PMC8Z7SY+TAry4wu23jtQS1dsdaig+Xr
	 32W0Unbo3QDH0O10D8onW7UnJxDt57u4REDzth7xrHKQ1EXFmrHyrNVoPQAM8OzCbrYYq
	 rN0s3s4BaufXmPZpzNszBtaRm3nW6sgtrNNhlfKEO16RUcnTNyayqCYLZ4tbHnqxYUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="MW/6CiGy";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="bKX/ANmW";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFF606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MW/6CiGy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bKX/ANmW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795712925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtLU+Vh4EDesMjJE1JoJTCuUxgHCL2D+tpkF5ZBWsp0=;
	b=MW/6CiGyvu+SHDKPGn8TWhtsKHC8aWoOWQBZon8IP8Y1D5lzVrr4V5GF9ENep5U5/Hu71w
	CtRvp4Mspm6wNYG/p19tBeDvecUad0g5iICiFXMThAsn+1LzZRIWWyWy9p6MVNGo9OajVP
	9KqeU/2pnbuIwPKKvUxEX+6pMP/fqSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--qXiOXt9N42pMIW2ivcuXQ-1; Thu, 26 Nov 2026 17:08:43 +0000
X-MC-Unique: -qXiOXt9N42pMIW2ivcuXQ-1
X-Mimecast-MFC-AGG-ID: -qXiOXt9N42pMIW2ivcuXQ_1795712922
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so44391915e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795712922; x=1796317722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UtLU+Vh4EDesMjJE1JoJTCuUxgHCL2D+tpkF5ZBWsp0=;
        b=bKX/ANmWQAHhPQG+3YQaI8YRtL6qPoxzn40CxVnISzL+Ur53vZamVILZpmLj1UN6gg
         mMo2UTFyuDRxq17+6TpGSHlSbTpdZtZPn4GtFSQAlsRNWLyaUWGGGRynqfXVYBfYFtID
         FsTu0RQ9F2jgHfct5MZDNMwKgIsK/cAcz9eILbjictcOSdNzFADWiwCtQsBGihH/UspL
         kJIHvbRmRRxMe/YgJP4aAZtFVn7NKDL4zAkT8n7HJiclsA0tQcwpiSX4HDYhi7u77bLX
         WVYIQpWNz6eDhXWtCARQmek/OfOUsWOKl7V9jBb589YQWoFNvsbcgPMj2MzKJLZJ2qol
         yChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712922; x=1796317722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtLU+Vh4EDesMjJE1JoJTCuUxgHCL2D+tpkF5ZBWsp0=;
        b=N6UzgyeVlyjXJ5eyCHVeo9ksWgpYYx6tCAOCMrQqk9jJUsd672QOg/TqgRNd3TSSka
         6t7RlJeBIZOtfIo2TsyEmcfq2SGeWbgBNDR8bR46WGTIt8iMLPHbU8nSVwuvgXEJCrm4
         jRRwyyfO76DzIoSiF2VANRIY9sZLQ5OVVatAAyNFqonP9xoCGZI/b5+ZgEg9TTLH7Ya3
         U3/5lbHMmpAAwAWVhB3JGZtRy2A0z3zWIQmgxSGEPiK18NWVrM31i3qvAXH/xQ857gG0
         wM2z+OohKpZR+V27JLqP7U5sud6E7IipC/ZZyfmdlSBU2GkhwjpETWuyE4hk+P9Gc8+P
         fQqA==
X-Forwarded-Encrypted: i=1; AL+hErEplYI7sN9/TBbGsSYjjIpZRpkAvI8mClpLZPr3sUy/226lrWhpAUt9BeAInXZRK7xjaP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CmKv3Wyk6GbQuOJJoHyX3P71XZE2BHjwfUAGFJn3xo1Wtwxs8
	KrbWyULP2o2CI1QPofXZr3GM31sbJnNshRhwJILOQKirMkNAHBVC6p8FmfHCk8EgeHPUjo0dK6/
	mHxSdAckkjMQ34PzQkTMzfORxbPa1LZ3zg5jqtBfMeWl7w8VNaZ2XVQ==
X-Gm-Gg: AZFdTZftRcxbClCpNfNjFtLmYSygBd39A7QFKRiGyiVDIBMHSWNXdjHR8vsbgdaryqT
	7Na2XhVpUrRp0Qy2ayv/PrF58FXvBdvhC9duxwvefcrTa+wzKcBISX22g0UPt4oy2E9qNRBzh+C
	LonKD9umX8A9hWqHNFWTiObJuvV7e3aIfwx2SrnZ2GvfMTYtSEiu+Rnm1PyACBz+qceUTxX9MFe
	nfYQig4nsvzcpTYbF3scKuu1gnL/MUleMEhOX+uSw59NWZuM4dNRpDYSmFIzZu9VcMo2e186Uun
	9qkOASy7Z0L4Yq+L5pX1iA3AxjjscayFdMf99R72FOG5mk0dSNHtWOKJJuygwsp8y8CrSCbmZi1
	Yy+G7zDkrQ4Whj32Gzs/4c86j0vriD+C1TBN6adGVAc1GTOJtx0WA7w==
X-Received: by 2002:a05:600c:a115:b0:4bb:a5e1:7257 with SMTP id 5b1f17b1804b1-4bba5e19362mr91351825e9.33.1795712922268;
        Thu, 26 Nov 2026 09:08:42 -0800 (PST)
X-Received: by 2002:a05:600c:a115:b0:4bb:a5e1:7257 with SMTP id 5b1f17b1804b1-4bba5e19362mr91351065e9.33.1795712921705;
        Thu, 26 Nov 2026 09:08:41 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm965894045e9.14.2026.11.26.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:08:40 -0800 (PST)
Date: Thu, 26 Nov 2026 18:08:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v4 3/8] vsock/virtio: implement the datagram data path
Message-ID: <awg7ZLAk468aeEo6@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
 <20261124-vsock-dgram-support-v4-3-3607484e85e8@redhat.com>
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
In-Reply-To: <20261124-vsock-dgram-support-v4-3-3607484e85e8@redhat.com>

On Tue, Nov 24, 2026 at 01:20:21PM +0100, Sergio Lopez wrote:
>Add the datagram feature bit and packet type, and implement the common
>virtio transport operations needed to bind, send, and receive
>datagrams.
>
>Send each message as an OP_RW packet with a maximum 64 KiB payload,
>including support for empty messages. Bound pending sends by the
>socket send buffer instead of connection-oriented peer credits. Use
>the socket's skb memory charge for datagram SIOCOUTQ, including empty
>messages, and release it through the normal skb ownership lifetime on
>completion, rejection, or queued drops.
>
>Deliver incoming datagrams through the datagram bound-socket lookup
>without entering the connection state machine. Connection-oriented
>receive lookup excludes datagram sockets, so each class can use the
>same destination CID and port. Validate the transport and connected
>peer under the socket lock, including after shutdown, and silently
>discard undeliverable messages. Use the socket datagram queue for
>recvmsg(), including source addresses, peeking, and truncation
>reporting based on the payload length after socket filtering. Reject
>MSG_OOB and MSG_ERRQUEUE before accessing the receive queue. Reject
>datagram sockmap admission until its receive callbacks support it.
>
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
> include/uapi/linux/virtio_vsock.h       |   2 +
> net/vmw_vsock/af_vsock.c                |  31 +++++---
> net/vmw_vsock/virtio_transport_common.c | 132 ++++++++++++++++++++++++++++----
> net/vmw_vsock/vsock_bpf.c               |   3 +-
> 4 files changed, 140 insertions(+), 28 deletions(-)
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..27b4b2b8bf13 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>@@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
> enum virtio_vsock_type {
> 	VIRTIO_VSOCK_TYPE_STREAM = 1,
> 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
>+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
> };
>
> enum virtio_vsock_op {
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 8a271eb66860..aef5389eeca2 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1659,20 +1659,27 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-		if (!vsk->transport || !vsk->transport->unsent_bytes) {
>-			ret = -EOPNOTSUPP;
>-			break;
>-		}
>+		if (sk->sk_type == SOCK_DGRAM) {
>+			/* Match UDP: report charged send memory, including skb
>+			 * overhead and empty datagrams.
>+			 */
>+			n_bytes = sk_wmem_alloc_get(sk);
>+		} else {
>+			if (!vsk->transport || !vsk->transport->unsent_bytes) {
>+				ret = -EOPNOTSUPP;
>+				break;
>+			}
>
>-		if (sock_type_connectible(sk->sk_type) && sk->sk_state == TCP_LISTEN) {
>-			ret = -EINVAL;
>-			break;
>-		}
>+			if (sk->sk_state == TCP_LISTEN) {
>+				ret = -EINVAL;
>+				break;
>+			}
>
>-		n_bytes = vsk->transport->unsent_bytes(vsk);
>-		if (n_bytes < 0) {
>-			ret = n_bytes;
>-			break;
>+			n_bytes = vsk->transport->unsent_bytes(vsk);
>+			if (n_bytes < 0) {
>+				ret = n_bytes;
>+				break;
>+			}
> 		}

Why this can't be in a preliminary commit?

>
> 		ret = put_user(n_bytes, arg);
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1e762a480df4..08baa1181ba6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -204,6 +204,8 @@ static u16 virtio_transport_get_type(struct sock *sk)
> {
> 	if (sk->sk_type == SOCK_STREAM)
> 		return VIRTIO_VSOCK_TYPE_STREAM;
>+	else if (sk->sk_type == SOCK_DGRAM)
>+		return VIRTIO_VSOCK_TYPE_DGRAM;
> 	else
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> }
>@@ -303,6 +305,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	u32 src_cid, src_port, dst_cid, dst_port;
> 	const struct virtio_transport *t_ops;
> 	struct iov_iter_state msg_iter_state;
>+	struct sock *sk = sk_vsock(vsk);
> 	struct virtio_vsock_sock *vvs;
> 	struct ubuf_info *uarg = NULL;
> 	u32 pkt_len = info->pkt_len;
>@@ -327,14 +330,27 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 		dst_port = info->remote_port;
> 	}
>
>-	vvs = vsk->trans;
>+	/* Datagram sends use socket memory accounting instead of peer credits. */

This comment should be moved on top of the next if, no?

>+	vvs = info->type == VIRTIO_VSOCK_TYPE_DGRAM ? NULL : vsk->trans;
>
>-	/* virtio_transport_get_credit might return less than pkt_len credit */
>-	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
>+	if (info->type == VIRTIO_VSOCK_TYPE_DGRAM) {
>+		if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+			return -EMSGSIZE;
>
>-	/* Do not send zero length OP_RW pkt */
>-	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>-		return pkt_len;
>+		/* Datagram sends are serialized by the socket lock. */
>+		if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
>+			sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>+			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>+			return -EAGAIN;
>+		}
>+	} else {
>+		/* virtio_transport_get_credit might return less than pkt_len credit */
>+		pkt_len = virtio_transport_get_credit(vvs, pkt_len);
>+
>+		/* Do not send zero length OP_RW pkt */
>+		if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>+			return pkt_len;
>+	}
>
> 	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> 		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>@@ -348,7 +364,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> 						    NULL, false);
> 			if (!uarg) {
>-				virtio_transport_put_credit(vvs, pkt_len);
>+				if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
>+					virtio_transport_put_credit(vvs, pkt_len);
> 				return -ENOMEM;
> 			}
>
>@@ -393,7 +410,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 			break;
> 		}
>
>-		virtio_transport_inc_tx_pkt(vvs, skb);
>+		if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
>+			virtio_transport_inc_tx_pkt(vvs, skb);
>
> 		ret = t_ops->send_pkt(skb, info->net);
> 		if (ret < 0)
>@@ -416,7 +434,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (info->msg && ret < 0)
> 		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
>
>-	virtio_transport_put_credit(vvs, rest_len);
>+	if (info->type != VIRTIO_VSOCK_TYPE_DGRAM)
>+		virtio_transport_put_credit(vvs, rest_len);
>
> 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> 	 * skb_zcopy_set() increases it for each skb, so we can drop that
>@@ -620,7 +639,7 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> {
> 	struct sock *s = skb->sk;
>
>-	if (s && skb->len) {
>+	if (s && skb->len && s->sk_type != SOCK_DGRAM) {
> 		struct vsock_sock *vs = vsock_sk(s);
> 		struct virtio_vsock_sock *vvs;
>
>@@ -999,7 +1018,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags)
> {
>-	return -EOPNOTSUPP;
>+	struct sock *sk = sk_vsock(vsk);
>+	struct virtio_vsock_hdr *hdr;
>+	struct sk_buff *skb;
>+	size_t payload_len;
>+	int err;
>+
>+	if (flags & (MSG_OOB | MSG_ERRQUEUE))
>+		return -EOPNOTSUPP;
>+
>+	skb = skb_recv_datagram(sk, flags, &err);
>+	if (!skb)
>+		return err;
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	payload_len = skb->len;
>+
>+	if (payload_len > len) {
>+		payload_len = len;
>+		msg->msg_flags |= MSG_TRUNC;
>+	}
>+
>+	err = skb_copy_datagram_iter(skb, 0, &msg->msg_iter, payload_len);
>+	if (err)
>+		goto out;
>+
>+	if (msg->msg_name) {
>+		DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
>+
>+		vsock_addr_init(vm_addr, le64_to_cpu(hdr->src_cid),
>+				le32_to_cpu(hdr->src_port));
>+		msg->msg_namelen = sizeof(*vm_addr);
>+	}
>+
>+	if (flags & MSG_TRUNC)
>+		err = skb->len;
>+	else
>+		err = payload_len;
>+
>+out:
>+	skb_free_datagram(sk, skb);
>+	return err;
> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_dequeue);
>
>@@ -1202,13 +1261,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_stream_is_active);
> int virtio_transport_dgram_bind(struct vsock_sock *vsk,
> 				struct sockaddr_vm *addr)
> {
>-	return -EOPNOTSUPP;
>+	return vsock_bind_common(vsk, addr);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
>
> bool virtio_transport_dgram_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> {
>-	return false;
>+	return true;

Should this check if the feature is negotiated?

> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
>
>@@ -1246,7 +1305,17 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t dgram_len)
> {
>-	return -EOPNOTSUPP;
>+	struct virtio_vsock_pkt_info info = {
>+		.op = VIRTIO_VSOCK_OP_RW,
>+		.msg = msg,
>+		.pkt_len = dgram_len,
>+		.vsk = vsk,
>+		.remote_cid = remote_addr->svm_cid,
>+		.remote_port = remote_addr->svm_port,
>+		.net = sock_net(sk_vsock(vsk)),
>+	};
>+
>+	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
>
>@@ -1771,7 +1840,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> static bool virtio_transport_valid_type(u16 type)
> {
> 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
>+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
> }
>
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>@@ -1805,6 +1875,38 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>+	/* Dgram packets are delivered directly to bound sockets without
>+	 * going through the connection state machine. Undeliverable
>+	 * datagrams are silently dropped (no RST).
>+	 */
>+	if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
>+		if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW)
>+			goto free_pkt;
>+
>+		sk = vsock_find_bound_dgram_socket_net(&dst, net);
>+
>+		if (!sk)
>+			goto free_pkt;
>+
>+		vsk = vsock_sk(sk);
>+		lock_sock(sk);

A comment here would be appreciated.

>+		if (sock_flag(sk, SOCK_DEAD) ||
>+		    vsk->transport != &t->transport ||
>+		    (sk->sk_socket->state != SS_UNCONNECTED &&
>+		     !vsock_check_source(vsk, &t->transport, &src))) {
>+			release_sock(sk);
>+			sock_put(sk);
>+			goto free_pkt;
>+		}
>+
>+		if (sock_queue_rcv_skb(sk, skb))
>+			kfree_skb(skb);
>+
>+		release_sock(sk);
>+		sock_put(sk);
>+		return;
>+	}
>+
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..296e1fa7970b 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -161,7 +161,8 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
> 	if (!vsk->transport)
> 		return -ENODEV;
>
>-	if (!vsk->transport->read_skb)
>+	/* Datagram receive is not implemented by the sockmap callbacks. */

So, it never worked on VMCI?

Again, why this check is in this patch and not in a preliminary one?

>+	if (sk->sk_type == SOCK_DGRAM || !vsk->transport->read_skb)
> 		return -EOPNOTSUPP;
>
> 	vsock_bpf_check_needs_rebuild(psock->sk_proto);
>
>-- 
>2.56.0
>

