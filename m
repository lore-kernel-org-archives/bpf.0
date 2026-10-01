Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB34B7A35
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867606; cv=none; b=HOAeuoi4OhnVMUkTpIlNjxQRKgbykSIY7OI5JQhPldf1L3aOs6R7/zYYxmwiX9SJI1xVp3cl8iQD5x7fX2kHmeWOwTUKu9jE4YdPrH59mh5YYtYATPm4Ad8cLqoecjhc0TtHiJ9FGkMyrGRKUMCFCezUyZb2Dq6RewlKKeLJTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867606; c=relaxed/simple;
	bh=E3+ztsI9L8TnSfKfGghOBEwhvnL/Z5/eVhFzRSfVwfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2N1zuxfjSwUOQphyb8Db3uvyNK41yomZflTpM4xu/YhUBI+iAaaD8kn2fw30MFlIsPJnivBm77Bg/RLf+Gz4HDzmUJh/LjgRNDlT5fZLa4qBqX9cxHvBLkFS2BBTJvQP3vXYG25flGMF/yV2eBUXE0IqkJ2S6ogRdHbFsevnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoyMcaab; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoyMcaab"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so3989439a12.2
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790867605; x=1791472405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BL1X3zbhdEDEFiVdKCvJlVwYpTEdcagn9KrGuz3r0JE=;
        b=PoyMcaabx/gW0xFbl8Te+5Lz1Jyjm2pSvBuzu74WRekkfnYdcAIkWlqm11FyBlaDxG
         /BMvhsjsSDSBnOTK3Lb3JyXDCCSSo+OWu6w42vWakqSULqEW43h7yUA0BP+n2QJXe3Lt
         xn+W0hO0YgHil6WPbg/1+Xup9LIfnDDxFFbGQ38KuAq0ogsUgybZphaTWoTy1GwRXU2W
         2YrCBi+NUq5z33Eo9aBF+fPLOA6eU7lJBsR/CuG21mGypc603Pwv7Q0jmmjv1m41kvuW
         z6CMjV2cfwyQOh/Hzc1/YVjAtij7xT8leQkKE2uZ8tRYi4ITI8JXYQzFViTvf7sLZmZg
         Eg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867605; x=1791472405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BL1X3zbhdEDEFiVdKCvJlVwYpTEdcagn9KrGuz3r0JE=;
        b=tTUqKEclSdsr/5FUnhxkCat0eOKIxgXdoYaCfCUAYw2R3oWpZ+sB3zfK6YqAz8Np48
         IfSdeZ1WXtTB3JNxxTPxGOHy+kgkK7NZ6NUbSfGo9HE4NkqGMAhTSnqH/qlE1tIotbXS
         YZO4o3I9xIQtIh3B5nZj/vJRf+1Duct7pUF1893P0GRYyMVvlwzg2bm+jbAzo4801wXn
         P2S+J2bzvAWnfsqjObNo3cjJCcqp6aImk6hr0rKIurnYR2hDLwfhA3IrxQgAFvoLopam
         ZyNrho2jblwjdGId45Wb8/awqdzBxCRPh8jazAA5GqVtCinVg6jx0Wi4GcLW1No9dUV2
         AMQA==
X-Forwarded-Encrypted: i=1; AKwUvBx1VoWJPR8T/PRzUlZEDK2swbpTIJqwNNoKscm4KnCmDLIXK2OKfj2rgBNm1VtpsHEINSM=@vger.kernel.org
X-Gm-Message-State: AFuF++ncwLcUK3FWS8YHZyeFtLcIa1TdkEYMoIIjIBMZ8GIAvxUFJsyX
	z8F65DlZPHLc5h9wHtoKuvhZUL4rLTk23KWYOU6iQx3UpbOrVi4IxC2E
X-Gm-Gg: AYBFou0s4lgYqxA3nDyQorPUb3ZdpOB6yWw2gqKqOCHVD3/8YXjAY0fzQSyITlAdA8a
	3uFR77bqz2wl3l6KP2++mMChxJeiQ8uTegRa+T2fvpy3zoLSIfDm1/6itOIPO+BRY3Y2BtUSv8g
	BbuM2rgICnZFwvUfKLepGn9otUolgsmsB9WfqV1f/3AGWdYlm9uYz/fJygwPJ4J+Dy4+h+9CjKu
	HZdirfrwTBK1+euYu+viFTQO3o2ORldciGOrVhW8cW87M07hGoVpKrFsxhQ8ucfNkBLSVUMn3I/
	UiF5WTDQrc+nM55ECe2AMUc1u+ejCfa5wcvUY4SsZ0e5KF06cp5iz35r6NZ5DleyjZcFGQ596Jz
	3MGd/1Lk3AOujbl9yCUeGz35cjGhZSW1BYqiVyp6WCJ4QB8SsZ8QY2sGrz1cMjFqUtgqPbZmEIk
	oJPcFTVgqeUVTDDPITgpx3ehFKlCfnIGVeQmTAXsQpKEunvMxKFlzKknBC326EdNqH0BXMuFQzl
	DKe3OaOGv4=
X-Received: by 2002:a05:6a21:9216:b0:3de:72d5:281f with SMTP id adf61e73a8af0-3de9e79e727mr5170098637.34.1790867604744;
        Thu, 01 Oct 2026 08:13:24 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8881589a0c3sm1290039b3a.7.2026.10.01.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:13:24 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: leonardi@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] vsock/virtio: account only unread bytes in read_skb()
Date: Fri,  2 Oct 2026 00:13:10 +0900
Message-ID: <20261001151310.4101006-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a partial stream receive, rx_bytes tracks the unread suffix while
buf_used and peer credit still cover the whole packet.
virtio_transport_read_skb() dequeues that packet but passes pkt_len for
both counters, underflowing rx_bytes.

On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
from a 100-byte packet made SIOCINQ report -40, an empty recv return
ELOOP, and poll report the empty socket readable.  After verdict detach,
receiving 40 bytes wrapped the counter to zero and hid those queued bytes
until one more byte arrived.  The fixed run kept the counter balanced
and exposed all queued data immediately.

This was found during an LLM-assisted manual source audit of VSOCK
receive accounting while re-evaluating virtio_transport_read_skb() after
CVE-2024-50169.

Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
full packet length for buf_used and peer credit.

Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
Cc: stable@vger.kernel.org
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Narrow the subject prefix to vsock/virtio as suggested by Luigi Leonardi.
- State that the issue was found during an LLM-assisted manual source audit.
- Add Luigi's Reviewed-by tag.
- No code changes.

Link: https://lore.kernel.org/r/20261001121541.2983379-1-4ncienth@gmail.com
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..1e762a480df49 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 bytes_read;
 	u32 pkt_len;
 	int off = 0;
 	int err;
@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 		vvs->msg_count--;
 
 	pkt_len = le32_to_cpu(hdr->len);
-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);

base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
-- 
2.55.0
