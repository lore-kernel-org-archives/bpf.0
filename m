Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590171;
	b=Ahv85AC56MsVt6UB3xhFo4J/faUDqxBDchW5ty6K3mcihz+Ny4rrnLQcKysHBQiihUb1
	 61PWEPI+lUiqAdQKTYHGAW8qbo0u4RzAp/cZn0qOSoNQZrwxxeE5KNu1xvXxrqhUcZqmE
	 xY+7DQDKzmvASk4q9p92ZTIXLXOTS/dQ5c1xs2WEshQJLbeXPmjS+982Ef48G2W+AJBIc
	 BU1zvawcK5VtVWL3wmq36Kfunu4s9xEDGQb0+/QgSk7ltBUV6FEmhA3vSJvf4cgmppzvh
	 MXJ8EAJJOcK1EVILBeWF5frVcV2OWM4zU1Pn/Gnbhmw7NRjRDhaZWDpEMITlr0wYQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590171;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=AWOfM1w4jgNJVmcQ6/VWp+tR3/mvitB1BrN2bjabmooc88maQCPr04WJ63OUPAYVhUfs
	 Ilwc5C9DEP/DQftyPqXD7IQ4cTDIhUxnuPQjCZsRrpZ/5A15Kf1hJBKUeaYOI5/ZHvw4S
	 yfVy5blbwg0m8hT/77v2d+8ifYqZSGPQywUdTNGTwZgy6o9Q9VF/OxqUysr/AGDKLwAdr
	 SQYo4kujfjpPZ+KDT8GzoeMp4QyW/pr/oHC40KB8VWZUIKcZtpZ93WfgOWtBzKlM+rghu
	 hiVKWWZKKVJ7ekQTZgCiXCa0No1foNPGqKDcMEc2wg8lnvqkzL9dzrNuos68zLqPb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8QdYgDN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I4BbvWGO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7491606E653
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7491606E653
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8QdYgDN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I4BbvWGO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=a8QdYgDN8AudaG5YD+oJ1jjouCKb66LW+eR52d+htCnqs60amomEeKzM3kbe2ld0P+7QCV
	wzCyEHMJ6B0po+LcfA/N/aSnIRYgp+9CtoKzAoURSPVO+a69KCbOTDihdYfcVwu0DCqp/+
	FGCo5bkw4Fsy7JPew7PowrEIldWCP2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-6fB7AQ4POKqIkg18KfWm4A-1; Fri, 13 Nov 2026 12:16:08 -0500
X-MC-Unique: 6fB7AQ4POKqIkg18KfWm4A-1
X-Mimecast-MFC-AGG-ID: 6fB7AQ4POKqIkg18KfWm4A_1794590167
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490ab0a20ebso783542f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794590167; x=1795194967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=I4BbvWGOfYndeQ1dQu+Cwn4LN3kfkeQuDwhk7oRe/EaXpDHgqrVq6Y7IpgC+dlbgre
         dNBmVA/ywe0ZDjNkwrzseq3Y9eFayMnZ+wwvRhaxQaWbWXQiOvjYp6ja7l0pcDqi1/pQ
         eLeFbN44k77L+T+OqzHYEjnBUHwmmb1uQORl6oHaKbn5SeNM2nRNEN8XvAhklg2DtdRx
         cMgAC7dYJajQa24yaAuytFovZVdqnCKKc+SqQtQIgH+Iy88dBvSIZEZj7T9ulQ83AU8K
         K1v+OfJQCVoCRuJLIr9QJZg2VZcbu0gCvsBq2laN5B26ESyg0SrIJCopPA5yfmDEmuj9
         WzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590167; x=1795194967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=DS8wZOEXxJp4Z2cHcKplayRiVG2bILnv4Z+mrfH0GjYfS6sajqmuaIKPskA1+CmtHB
         e2pMm7BpAKpFDTtLr2vPihiI7oYDuCzYEwO4rJtJPbwOH3HunoRmDj8WgjzsPuWU0l7L
         RNhn3DoeDrEayuM2ypTxutN6eA7bVoZ8y3BAzmqTMrHxYpZqzhOyn3CDsGap8oA0QpeY
         LEogwNMo89AaFchIeE1lOGhQpfm0hie0mkYFkODKp7Do8l3+lb+eb2l/K3KT4bgbXfqL
         TwJHvbl3cd7kWKlzBPnjR6NC8WGjB8DQPTlfFb4aVtnF0O+/4nXp5Fjoy+UEkUxN6vQN
         Tj9w==
X-Forwarded-Encrypted: i=1; AL+hErG2IqjEm0Pi2IN8cYezOkkp0shrbzkDHPbS1BjSyHChOfxprEOlyp0svXO8bKseF2gdivg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TqI1tB6vUDaV2DOaPdes0KNKdZ2xms5ObhMog8SurfzaBaQJ/
	xZOzuBoX5uJPlaxWW89Bap3J737oKFWZQIQ5EBWupx5VieuQC+BtGBiWZPEit8p2QqQCJxq9fqj
	CRz1AXK4Q1goT9dqgu7Prch6WHlqKRETfsB3nmAr7m2l0Xqj7ulAKBQ==
X-Gm-Gg: AYBFou2QNIjcJa2BUtA3Z69AF8Ho+v41vohvrOyVcVDvLN/Dt22SpBNEh9LcKUN/wjv
	KytXlTpyrW5sSeXY5ryaf/kg4KeD6omr4UQB/myjk0/chWhW+dg85jIGQNE6rUaDXu3+6370A5c
	ICd2m7Wwljrlg7cQ5EYOn5CVVXUpRkY/44L70hZHsY7A7jtvsM/rkZOgRGJIKZN+hbE23SbSz9l
	RSdwy3u4/vae5GE1o3yELUW32t631QqoMmXQjD+qulXwqjeEjSPPjr4eZWrftFdjMu05ljEYbJx
	21OX22JMa+SHX1b47Ew4AnPOxzBWhn0CJ0XRCZEjUslC4Cb1xMwafJbUGVzqWpFfhtPSPfInvLP
	AD+vjvj56qJAMwHzpQgDz1GDYNEnszVl0881aaQTcuOO7abGieYZ5mj8Q6PYnEBmjcCFzFlh9Zb
	XOJlkIX/1piMo=
X-Received: by 2002:a05:6000:490a:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-49c6dc01369mr7027352f8f.1.1794590167339;
        Fri, 13 Nov 2026 09:16:07 -0800 (PST)
X-Received: by 2002:a05:6000:490a:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-49c6dc01369mr7027274f8f.1.1794590166887;
        Fri, 13 Nov 2026 09:16:06 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:06 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:15:42 +0100
Subject: [PATCH RFC v3 2/8] vsock: report datagram receive and send queue
 state
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vsock-dgram-support-v3-2-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XIreajZ9sPLqnxrRyNPvzJRU0Io7e2OxtiN
 6rwdgMKWyyJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFyAAKCRD0aSeNLwwC
 NaHAEACQ95E153IO/phwfTijz24avrBMLZWaj9Ed8fBh5YY68WHbWnE1aCms+dqMaB24KPyE7wb
 X0zpl1q3dDmzYvkvYgR8YOFtwOxgj5Ga22RREE4aoqjaE9BILwVLCjbHTljdK3N23nW0z5OIJJU
 KM9V4A9rgbHVKYAERIKfcI9+4fB4C5DUsWE4HKbhfxYkvN/BT/gAPKFaF/L80BlN7fyoEtp+OV8
 UEYPaEm5QiV3f5TgHRFkmp8535mnJfXbMEQC7qU3/3SAdjqjN2OIWsR2eBT3b8/iFWrAtYXN+P3
 IJYjf/LIMYiWXOyYLx5j77BIpX8JiCgeO+G6YdqmNKcA5DO5qVUI91DL+5t/XfIJGKYROrGcwvb
 Oaob46SOwl4/+c6ic3yTyEp5d1lGaXn1NDaXCKySFZ0YlMhJJ0BjpKIVmF8ovJ7KeEEI52BN2ej
 RwDQmuqdcFYIPIFqsRcfjTM6noI91hyS3XnFOdVCz4O3w+nCEaRPi/X5cFA8NKJiVlTzVKft/OD
 R7nDEQsMsBOd+vzZSpfzd2lhx2zhcp5nkfX6EIU6GToqnbnpmALJJMn0dVBb+sh5iVBICPyfiHT
 Z8unW8scI/2K34XYCpyHvlEnze02bpd1ka1UG2EGtWlGoaNmv0dI3FK9vdKArxiDF5unKDxrfHL
 bMHFCEaNYrenSvA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Datagram receive queues hold whole messages, and transports may charge
queued datagrams to the socket send buffer. Report the size of the
next datagram payload for SIOCINQ under the receive-queue lock, so
concurrent recvmsg() cannot free the skb during the query. Let
transports override the length calculation to exclude headers such as
VMCI's.

Report datagram write readiness only while the send buffer has space.
Set the asynchronous no-space flag when it is full so freeing pending
send buffers can wake poll waiters.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h         |  2 ++
 net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
 net/vmw_vsock/vmci_transport.c |  9 +++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ac061115ed30..e4fbea3b0e46 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -124,6 +124,8 @@ struct vsock_transport {
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional payload length override, called with the receive queue locked. */
+	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d5cf240d4ece..8a271eb66860 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* For datagram sockets we can read if there is something in
-		 * the queue and write as long as the socket isn't shutdown for
-		 * sending.
+		 * the queue and write if the send buffer has space and the
+		 * socket isn't shutdown for sending.
 		 */
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			if (sock_writeable(sk))
+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+			else
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		}
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 			break;
 		}
 
-		n_bytes = vsock_stream_has_data(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+		if (sk->sk_type == SOCK_DGRAM) {
+			struct sk_buff *skb;
+
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb && vsk->transport->dgram_payload_len)
+				n_bytes = vsk->transport->dgram_payload_len(skb);
+			else
+				n_bytes = skb ? skb->len : 0;
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+		} else {
+			n_bytes = vsock_stream_has_data(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 		ret = put_user(n_bytes, arg);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..2b9493e987d1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct vmci_datagram))
+		return 0;
+
+	return skb->len - sizeof(struct vmci_datagram);
+}
+
 static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 					struct msghdr *msg, size_t len,
 					int flags)
@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
 	.dgram_dequeue = vmci_transport_dgram_dequeue,
+	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,

-- 
2.56.0

