Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203510;
	b=U7BiXAIxS2ZsLaq6MZIQ52qiPUuXHkw21CQCtXXo5IwlU8USldu+c1/wmNiS98ISJypV
	 W7pRagxzpXrK4EzGQMeYC2KIe/UyJyTU5QbCt7BQqwQAalLNr5Huy5tbeDREjyaC9lipE
	 u0jPQyMDycArri7X+GfPF85kUp6JSs0cfeAHcEPJOfNnYukg+0AyT/SpbqAaYH4Nr5SjO
	 HaEpTCZ9QGfYavQmUQQc1W1SllGeMjtTq6YAK7ubmIpDPocLBew5dRFwgi0n3wiz1KkIt
	 0VEiCv7ncXiEaiNVARbExcI5wALlN6GdcXkHwAWf6nKcF2LIvfiG64Vhb4ulmLHz0uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203510;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=h9Z9LKrTGikCMQqzckYYHv2ubr5Q3HMVXa/qfuzyxNHuScDbWZOTlpmK+HMU8/aZrIKr
	 SgYFQzmg+EqbZjm+P6lsfru/qlTwwMRzU3ctoU0124sKF+yZOZdpTx/f66+Q2k7buWv4p
	 aiUP9UL0LbRB9e57ngimnFMUmd1XpLr0eJGaG2p5eh9ALAcCnBJ6t/t6jDC3bc1WoQYoO
	 4Z4r6p8FHvl/5PCSN/R2g/OVX09q5prZ5t2IKClVBO5voU5ZSBT+GsNIBKyK13X3+RPV1
	 q9WBvfLi7ZFMhZ1r8aFPNNRT7BKEF2CBp8Slc3RHzVoPhSGwC/HU7Kbkzj9BojVb5sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bpbQmIUm;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CkAIW1Qz;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BC606A331
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bpbQmIUm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CkAIW1Qz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=bpbQmIUm7J9Jgs2KHMvyJEGhhB1sTai39FYIwO0Hi5c8p0IXc0sHzxxGaL5QX2ed0AnsdT
	UxrxB4SIwMrLTwU/qSAGdbEN2yWh1IKptYCUxZQoia51fQiAwx6ji4w9lHbdDfZJE9tkHm
	E2XoSSbuUWIITY5P7UQa+423K7x4w48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-DSvm5FQuOYGKDs5amzkIzg-1; Wed, 28 Oct 2026 12:05:07 -0400
X-MC-Unique: DSvm5FQuOYGKDs5amzkIzg-1
X-Mimecast-MFC-AGG-ID: DSvm5FQuOYGKDs5amzkIzg_1793203506
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c46582442so748615f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203506; x=1793808306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=CkAIW1QzC7kaDvqdbWcK/KCvSYXymrBN0Wm70a8qSBU5yFAajaUEk74iOZAI3ldxmC
         qt0P+fSLgfnZ19xsbzg0LpGEpxiLRHw4dBxuhV9sIVzROwcPmnGYi9tRkgJNh6cMgDtb
         Gud8e3UiJcF2JceTWraHKLiuKsfTDzbUYOAUs1YoqLh19NY7TFK/1VEtjm9DxnUTQZ3y
         7Q/azYz3ONEO9R3je3BBV3ZqGPYwrReK1Y2N4ShsUERlXPHjDrELPuXu/6WvAI0NRLua
         jSB4JVuSAxIY7aB9hssJOYXcyq8f1KrSpON+m1WF3DxAvUgZVSSWgThCoWGTapMSxTBO
         oKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203506; x=1793808306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=21ZWz6uEVJkdj7KsD1L4r7q/X+oPasdlij8BSDTXc5FlGRbSV09j3e1ohBgEN9c2bQ
         gsuAmRofSF8mXvcLpUgyUE211Rp3d20B+EXGdazwjX1g0lksntgBuKglztDwrpeRZZMg
         cJun+aiP/CuhBv/OZZ6raQf+A1kwGH7TLXlDLB/EiMUrwkoeWn4Sq1vQLhJFr/6kyAh3
         vNiszYlLYL8iwGv1jz6I9J3P4fRa2jhp6Om93RGmUzRZEbouIdjb0aNwyq7mVfGp1oOF
         7w1ftCo8ZujldP6qCSW5YSqLsgeu0rHEqOcq0UQat3wEcXfDEx0QDigGJ45UjmIbZF+j
         bZDg==
X-Forwarded-Encrypted: i=1; AKwUvBw9M/1RcituMMkhSah9RBbGpj+1Vhue3XBgOS8sX+ok9kASq1v8cDOO852ujLX1lJB8U+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFjuL7mA7O/oYewM6cqzkQCP6DMdeJcfZZtJQ7SYRYCXc8DHmi
	WjippgjrKsT3Qkra+Fx7C14R5tcWKGf/4o6j2lAGho7JfoQ3qFCBJk3TJgyMv+4Ste+Z+Uiw2Um
	+Ui5ci8OCLpxOm/SlF4mCCvI7s4zMPXGYk5m0YY+TyL4ynq0YQyVp3A==
X-Gm-Gg: AYBFou2MaRBC7O+AnJm0sHPnWZWJ3DsEVa9IfeJXL+N2wkraMf1iEIUPPicoqEu3Gqp
	DehE0KzETdTAwBlTlJTx1/arTSWAeDbnBXHwcZmnS9j8OuDlO6INZbydG+GtR0AgrxMMV1URyx4
	Kz/6KMP+X/o6e4OkUAGCWVnb7t3ZLX30GUNqb8dr0Ez/2xOqnR+eTzB/hWj6n2v2KSBRyZ22hEF
	lM5uX2rwtYNZMevrSiOKVi/NQibRGanypERQg3y9nkU8S6pfJzy/gK1P2OSHYBhUMZVO5GgA6tn
	sAi8uFcwK/VE1+AmaCqbzRsOda0hj+xYra9BICaba3FSl//G0MBnr9LzSzgmQ5MftbibPfmpdLA
	UWsa9lVuKHIIYUWYNTx1ZvkvGmtnPV1lu65mcTNDgTXxQ0tL0BSkOLODBqqd4mTp9aYbLinRkPc
	ZyuOy9RRnzRAw=
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017694f8f.7.1793203503986;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017631f8f.7.1793203503646;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:02 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:34 +0100
Subject: [PATCH RFC 5/8] vhost/vsock: negotiate datagram support with
 guests
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
Message-Id: <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=slp@sinrega.org;
 h=from:subject:message-id; bh=S/4WwL5dbPWCiZa0zeuBb6RBsuWeJgQfZUwqCMWgNGg=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0e97Xa4zjSMJH/xL6mXhEFJLr5iP+9ch7tW
 39VyLppJZSJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHgAKCRD0aSeNLwwC
 NRheD/402018X9FBIyAMMgECnQa6yDcTR5QuwyzPlGz5FU3Usm0YdBiY4B7W9pjUCrlUNUDsPBh
 ksIdh4bV9svFPsQ9oCZgZRwfFoY3hSJNnyvTN3tE7MYRPA0uZZpTQACnKw0FrTz2+luenFHGnF/
 ycD0KQ0ejq5Uje3XgSzl9vNFIaNQZjgV1ii62A+qKzTOoLDxcYTHcYKzkpE0O731ZH0P9qRLpME
 OLusu+MT47wAqaWVvGA7v+F7q+NIO65WdytU4jx7KxqIdFFuI5B5zqBReSNOcW0u17DiMcUuWhJ
 87+N4tt2foVeHlcNtLGyi8A//zJuvc0zmEuuVi39QStNZyDYyhF4xq2T168g6Jw79ok+wCfHZFp
 XtXcmIp6Z0Uso6z5/fU7AnJvgCHAaJv4qAj5FB5nkuI/NQwo80oDApKvKRWoyB4B/WkuPwbZWVo
 y6dGBTrEINxRHOqywyEEEvvz6rYZe3WY5naK0fpnr+HNHVfBiO6ias62HtsrGO36MnE2s+sHJC/
 cpYz0guHd7QByD6nTn7TJJJTjUk0Q1+7sFkxIBBTryZ5PxAT/aVB4hmF7eBeQFTBqvY34ccn4cP
 CqzmK8OoKeB1Fshdqvito+Go6gpfCtRrXApVO13D0UFAnSn2qxBp1TzjcJDhAl48UAEETZHxUHB
 fV584fy3LMal/ew==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..eb2fbdb721aa 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -436,6 +438,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +464,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -737,6 +759,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +913,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

