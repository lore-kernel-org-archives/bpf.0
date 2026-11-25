Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593201;
	b=mbLuuPfDMxy4J0hrK1ARPE3yw8l2474HM0eVrArwRNbVCwLOfS8EIW5zP8yLqHDXSFiB
	 8y3kq70vYpx3Rb99JNTVllcjI7rRmGZn7XZKF1EFKhKCGO8S/9ZVtbmoBdnIHhuWMtbt/
	 SyVsRkcvQU4VTfevIouPFRjS0JVNXvZzq9kNk+pKOHRdt2/GDq0KHKa58AnKsTmg1qbSC
	 jXlR5fwOqt36aVXU+Tyk0Sbt4Fs/6SFeIsmLK+EYiLYXtt2GTOcnnmeM2NPhWyAY0wubF
	 jAsVgN3OCm/QW3WoZnI2Rg4++pCuB8EnPESNY1oEHJe/ujL8dtV4iszANXoNPgGvncQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CGefND4gzGTszWXRJgmWXMeV4b965wnEKkDAEyQnj58=;
	b=VXRvyOeAldVUddFExyuSe+T8uaeNu5pdXo2aC7xoi4TBq/6piD89NRB4IR4KA2v6/NEB
	 +PlOrXJHdAaVgPggs3DM7tWpOvaJ0IsOgXI67/PYTxvdfooMkIyVUWBMzRJ5aJcag83d3
	 pxPiMM+D6O8Gt88PDJor8dwCSqbOsDnzIzaNw4UDOUgiYwHsFwhswlT1Df3Ty8HiszwOv
	 J54icV4mKS5XHGHqWM/06Jnji/hVq0zAty6BosFqxyOh6KOc8ADYXb37zgEHEPa0Iy0Tv
	 sm+J+yhR30LmnDfbQDOSZPpcm3zog9MAQT8jXvXBbUwJ0AjZRhjBoWJv0lX8AsW5p9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r9Pz/jTv";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A4606A331
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8A4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9Pz/jTv
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491971ac844so4890869f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593199; x=1796197999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGefND4gzGTszWXRJgmWXMeV4b965wnEKkDAEyQnj58=;
        b=r9Pz/jTvu8nlaajttnts3gXhr3rmwU8DPLsLhMj+ZbhCTIdvsA1/zMkJhnnUR/pemd
         Isxmrixd//XcHlSLSRzcXNyBI3DBPLIWc68W8he6Qf/OB9sygbWlgUgUeeITxqbRdTar
         qdQZdXeX+xLIRU9dQ7qpVmUDaDbGu5nf4n2LSIl9xjpc2MRM4apyMWj/T1FLYSltzPXT
         TufFGBuZ0H1b7Ng+PGR8HB0ihRVr5j5BGTSSXk8NtlMEOr72cE+DbUqvgUO8rxn9Izlj
         l/cdVaxrvpSmzaNdqUuctDMKA6ifuUO79V5t/CqIesqvOQNfZm/1cSA07yjRQ+JU/Mlx
         1iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593199; x=1796197999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGefND4gzGTszWXRJgmWXMeV4b965wnEKkDAEyQnj58=;
        b=g5Cm9MDWDbqFRiaMzIK7ZJuzYU37DsStTIhhdaPDRZ3fapoSGK3OUHXt+b1o4bmCQO
         4+oy/VoklFwhaUY49XqAxPADejg3rqT3Tn1fzRffQxB4pp6f829J6t7swcfhF9LVaPbT
         KYbnvOrMmhz6HhMZ7X3JJ1q52S0lX3IXNAdHGFzCwXHyWZgDzDjyKflOQ7g7JT0xP925
         7G8339ytQ3/0qmetnzwj7MFk9MHPMLcBYpNOza+6sr63DTJ9nHlBvQf2hfmJcHE5WRFm
         uFMFDWzQIczkRU8r1sDoAI9N2vAGy13yn5Qiheo0kOgyyOLzP++zO+0EiempywHs84q9
         W8Fg==
X-Forwarded-Encrypted: i=1; AL+hErGOtDdBOtpgsG+UvWwgok+buz0awbzBuWbPAkUUTei2BXfsP5Bp8CjHd1j6bX9uTGZrjg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z89DJOBsI+MRuTxFyH8h2m3QldGXyFiP4DWx8Oce1dv2XE8/T0r
	4CrASzrjVTTYgztPfBfcmVQz8WVA7T+epZHFWLI3d4orquYP9aqb66MB
X-Gm-Gg: AZFdTZddrQ95lTJ3y1oTo2SNSDO2knrUWcFgxVxBBx+XrGLWXxO4q7TPpLRUVSJQ5Gu
	G0sEZO/f42rtdHnoh4vJuKXqFZ2J7woKOhfGO2IXmYsXWiAiMlGgO5ozlrvE5wHt9iIQh9NiJTv
	jXKufNe4wN7gnkCY6ahD34AoY3fc6dmi8Pa6d3UKKRa0lBoUZ1gFDYUHP8ZEEkAtbWuCje7VZAf
	mM36BqEG6QiVX5zx+Pjs+ueL51lghLGZeP/BXQ/B1uLGj5cUhecJgPBmbmQ0TF3AP6siFUX35Vz
	tZdI25rhvrFlDwwYXUzLsIoeFjKvwRyiCQCtKepi+FTxPu85x+onfvtr85N0LeSr4c8st0QrOM4
	tXDyGW0rJGgDruUBUoC0JVGIvMbnRml5zRlsK1UVv9orvCKeVJNiUtMPwtonicsoQqucwJdqtT3
	gRztQk+DgSEW7Jro18ZOXMki1LNVi+8IOrIa6Fkm/rqCKhoTjTFlWr0b0EHqvTIVA8AtMj5390S
	PKud+eoQzJQK2xP//7bW0JneerWpDuN6u3hTt6wlcLtqF4rPZFyu/VQ0zRDgqd3kKqjrVSYYgSc
	NpoOZuUlQdtXfqXOTeeqLE/D20Si8Fo+NFP6Y4g=
X-Received: by 2002:a5d:5888:0:b0:48d:f488:f32a with SMTP id ffacd0b85a97d-4abb55183b4mr32368217f8f.56.1795593199308;
        Tue, 24 Nov 2026 23:53:19 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm33001138f8f.28.2026.11.24.23.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:53:19 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v3 5/5] vmxnet3: keep the XDP program across device resets
Date: Wed, 25 Nov 2026 10:52:55 +0300
Message-ID: <20261125075255.1517-6-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261125075255.1517-1-filzador@gmail.com>
References: <20261125075255.1517-1-filzador@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmxnet3_rq_cleanup_all() clears adapter->xdp_bpf_prog. It is called
from vmxnet3_quiesce_dev(), so on every MTU change, down/up, ring
resize, reset work and resume. After that the driver no longer runs
XDP, while the core still reports the program as attached, and the
driver's reference to the program is never dropped: a later detach
finds xdp_bpf_prog already NULL and returns early.

Seen on 6.12.117 and 7.2.12: after "ip link set dev X mtu 1400",
"ip link set dev X down; ip link set dev X up" or
"ethtool -G X rx 512", the attached program is no longer called, and
each detached program stays loaded.

Do not clear the pointer there. The program is exchanged and released
by vmxnet3_xdp_set(), which also runs when the device is unregistered,
and which since an earlier patch of this series leaves the driver and
the core in agreement on failure. Rx rings are then recreated in XDP
mode after a reset, as vmxnet3_xdp_enabled() stays true.

Since the program now survives an MTU change, reject an MTU above
VMXNET3_XDP_MAX_MTU while XDP is attached, as vmxnet3_xdp_set()
already refuses to attach a program at such an MTU.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was reproduced and tested on the
reporter's lab systems as described in the cover letter.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 234897a..bc56b0f 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2111,7 +2111,6 @@ vmxnet3_rq_cleanup_all(struct vmxnet3_adapter *adapter)
 
 	for (i = 0; i < adapter->num_rx_queues; i++)
 		vmxnet3_rq_cleanup(&adapter->rx_queue[i], adapter);
-	rcu_assign_pointer(adapter->xdp_bpf_prog, NULL);
 }
 
 
@@ -3670,6 +3669,11 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
+	if (vmxnet3_xdp_enabled(adapter) && new_mtu > VMXNET3_XDP_MAX_MTU) {
+		netdev_err(netdev, "MTU %d too large for XDP\n", new_mtu);
+		return -EINVAL;
+	}
+
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
-- 
2.47.3

