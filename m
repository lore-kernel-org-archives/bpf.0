Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593193;
	b=yJbK+DNN8df3FhfzsvW2wxT6R10M76sJfYHVNjMMCuiySBA4hL+rAJTWEQAvKpNufqm2
	 vQzAr7vD5vaw1+JZl8hGdt83qSmbDb1dgqkN1ma6MiNNOAxp+JIhSncCyhOTQXDp6/1J6
	 6K9oVzkxdFFtlNEua13JKWnw1FujJJxxPw6ucesrFmHGhGIHP2xa/ozld+1cDwod7KaJ7
	 iGcEe7dGTtL53Zw/i1zDYPSFPpRg1au7ZilTKea77duirgi6CJl0eV0CC1tiLrZiZgu36
	 10DCp5F3/D9Grke1FDL4Oi4hCMC78ot/Ujot6XR8y530TNExjAleO7dHo6a+tnR36Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XsSU7eqNTjksHlmxyRYfctDcfzFjixMJdHtfM73cHGo=;
	b=uJHSjtPmFTOEDJobWki48of+Qn3JbeU5cV9p3up9L3l33A1IzD+jTK9Guv3GSzgVUAIx
	 XbRX8earMnK5R0PtI7xLj6yoP1KSw8dMrYLJblrAN1Jk2ABIoI7xpoOYcCWnuTgvwmjqI
	 2P/rEgbP9CBjm0mvoRr9szmdP7eKa2iAtoo/BE2Lenz5O+Dk0zvOeBPIWWpwJyXCATJq4
	 MLXYHDGSd6PiAZjBXUn5C0c/jWjKazKVZNcTu3ubSwVDD9Xgni00Aucrnrkzu3fVZIu+d
	 vzAoQRdlH2u6Irdf8P8CnP31siiJAXh62ND7+T+RXKE/E+gdCiOT/isyiDzwWieNtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jvjv9VZ3;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00846606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00846606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jvjv9VZ3
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso4692789f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593191; x=1796197991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsSU7eqNTjksHlmxyRYfctDcfzFjixMJdHtfM73cHGo=;
        b=Jvjv9VZ3s5X8quh6tXtHcacxvIpDOyaKxUSiYi4XQs04Xbul4MSB9fuMGiE7mLSWe1
         SqjfBYiv0CNquSrbCvmg6ABm5YBOC6eO8NAXbsQaRBZW+Rd9XdAVZDaNiYFnkXemgqC6
         67N3Vb061WCInjUv99NJjE2eJiDhCeaPp7L+xJMOEBTc/5dnY/9BEidSEAdJqMGUtGNu
         MGqO/Cc3TUu5ej1/Uab2AJ/jCx88Eo8xzcXqAyLuStLvh5Fv/Yjgk4xBD8XCDgux1K1F
         8iE1+KXzPKu3LT+o7/wHDYTujpiAUjQqDH0NPKw8u36Syva0acTpUeJz0dLSWXFfkr3v
         lP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593191; x=1796197991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsSU7eqNTjksHlmxyRYfctDcfzFjixMJdHtfM73cHGo=;
        b=lKurCRlJpb08G0d86EUdJX+e+lww1OaLZsgNHsFfn7t4JKuRb6v8up6rd4y5MNwR1N
         K4Pqt7LIbhaMs3tDPusZZSfTbY6LRXH8rjTgKr48M/eJ1Kc3wjSVyVmNrS9w4d3zH8kC
         N2vmgbcHCSctd3jhcH0XIgiBj9N6uPh7M+8/J6Lv8zxMuo6Has292lGA6cYQVeME0fc+
         at+WYSlm7eGUcKiDTSRICZ2QnfSVPvVfkHeN1t6Z81+gWaogi6Dctwm3Jx0vf6kL1ePv
         xw3SimoOczZDf8GaNBo2S0c2hzBy4ZAs7jHvYw/A+Js+wrG7/6udyMefBk7jw9iXPyU0
         yilg==
X-Forwarded-Encrypted: i=1; AL+hErEj1DWxp6ZJwUaAn6uv+PFEaYzNl8nj9NETRDIIxAHvoXDM30Uyhl0s4tSphT112y2xky4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8apKcsgfjlrKSNlvXnYS3E8eei24TgIoiN526GdFE+mV94RZh5
	76Z3Uzh7SzXD1qEyAX3Oy4aecwX6B11DBLi5xlhccgNAeElHJMQLj7ts
X-Gm-Gg: AZFdTZcXOkS0WtV6+SyAvkUgOPdjqw4Q1T/nHc+nnUsJu2EpZxUATocX9kh6HL03kqs
	53notlqgRBfmeCpkoF5Id/QK9VKDvGy6DsLcRzTGuXaEbl0H8WUZPRWdsXcP+iwJD6rmkfTsq/t
	BSkxOLo2xSjUF6lFEzSZHYFEz8Ogt8mTtqevtIUocGQPJPett4ytTqrU2h4Fuu3z4Y7w/mHos7n
	EhzjeoRwV1VhoqTZukJr/iQyig8dJOS9H96yAk99S8xZPciFmI25JqL8H/PERHpygHSb3WcyuTv
	C6MnZLrc9MgHtZiZ3i9vrRUyrpQLFijG/gXpgWUeB/zo5wuoKYn8a8Sbvo/NFOXzZHK3fS9NtbV
	8QSrJVxh8A7/nNbppKfFr+w3woQug0sUO/Jz/Ow/lQ0TF6XNUziriaQV1iVlobdO6q2uWUHKBsS
	Y8/AfuDwhj2jbyhLYmtH2qsPlc0Kn/RFdkiwq4zfIsv8a6jJDrGvLM4BAi7snxhi3zSCqYwaPhc
	7/I/VRKG0VYbdjjROHqZ4ZzW3NkRq4gsFltp7IQ+wbJm14R6sY9gO97759I7AMow/6CYdgOTN7+
	83O1pSBdEZ5iaJco+P+8UFPKlr7dqri9fq4/66eVEqV9mrj/HmYO09PSse/N
X-Received: by 2002:a05:600c:a085:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb88811c75mr366080335e9.19.1795593191278;
        Tue, 24 Nov 2026 23:53:11 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm33001138f8f.28.2026.11.24.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:53:11 -0800 (PST)
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
Subject: [PATCH net v3 2/5] vmxnet3: fix the error path of XDP program setup
Date: Wed, 25 Nov 2026 10:52:52 +0300
Message-ID: <20261125075255.1517-3-filzador@gmail.com>
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

vmxnet3_xdp_set() publishes the new program and drops its reference to
the old one before it recreates the rx queues and reactivates the
device. If vmxnet3_rq_create_all() or vmxnet3_activate_dev() then
fails, it returns -EOPNOTSUPP without rolling anything back:

- On a failed attach, dev_xdp_install() drops the reference it took
  for the new program, but the driver still points to it.
- On a failed detach, the driver has already dropped the old program.
  The core keeps it recorded as attached, except on XDP link release,
  where dev_xdp_detach_link() ignores the error.
- The interface stays up with NAPI disabled, IRQs freed and, if queue
  creation failed, no rx rings. vmxnet3_suspend(), vmxnet3_resume()
  or a pending vmxnet3_reset_work() can then hang or crash.

So far the stale program pointer was mostly hidden because every error
path of vmxnet3_activate_dev() goes through vmxnet3_rq_cleanup_all(),
which also clears xdp_bpf_prog.

On a failed attach (the old program is always NULL there, as replacing
a program does not reconfigure the device), drop the new program, bring
the device back up without XDP and return the error. On a failed
detach, complete the detach and return 0, so that the driver and the
core agree. In both cases, if the device cannot be restarted, close the
interface with dev_close(): the device is already quiesced, with NAPI
disabled and IRQs freed, and vmxnet3_force_close() would quiesce it
again and free the IRQs a second time.

Release the old program, and update the redirect target feature, only
once the change is done. The feature is now also updated when the
program is set while the interface is down, as the program now stays
in effect when the interface comes up. Use rtnl_dereference() to read
the current program: ndo_bpf runs under RTNL, not in an RCU read-side
section.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was also reported by an automated
review of an earlier version of this series.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 84 +++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 5f47049..a578667 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -33,6 +33,23 @@ vmxnet3_xdp_get_tq(struct vmxnet3_adapter *adapter)
 	return tq;
 }
 
+/* Recreate the rx queues in the mode given by adapter->xdp_bpf_prog and
+ * reactivate the quiesced device.
+ */
+static int
+vmxnet3_xdp_restart_dev(struct vmxnet3_adapter *adapter)
+{
+	int err;
+
+	vmxnet3_reset_dev(adapter);
+	vmxnet3_rq_destroy_all(adapter);
+	vmxnet3_adjust_rx_ring_size(adapter);
+	err = vmxnet3_rq_create_all(adapter);
+	if (err)
+		return err;
+	return vmxnet3_activate_dev(adapter);
+}
+
 static int
 vmxnet3_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf,
 		struct netlink_ext_ack *extack)
@@ -55,46 +72,61 @@ vmxnet3_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf,
 		adapter->netdev->features &= ~NETIF_F_LRO;
 	}
 
-	old_bpf_prog = rcu_dereference(adapter->xdp_bpf_prog);
+	old_bpf_prog = rtnl_dereference(adapter->xdp_bpf_prog);
 	if (!new_bpf_prog && !old_bpf_prog)
 		return 0;
 
 	running = netif_running(netdev);
 	need_update = !!old_bpf_prog != !!new_bpf_prog;
 
-	if (running && need_update)
-		vmxnet3_quiesce_dev(adapter);
+	if (!running || !need_update) {
+		vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
+		goto done;
+	}
 
+	vmxnet3_quiesce_dev(adapter);
 	vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
-	if (old_bpf_prog)
-		bpf_prog_put(old_bpf_prog);
-
-	if (!running || !need_update)
-		return 0;
-
-	if (new_bpf_prog)
-		xdp_features_set_redirect_target(netdev, false);
-	else
-		xdp_features_clear_redirect_target(netdev);
-
-	vmxnet3_reset_dev(adapter);
-	vmxnet3_rq_destroy_all(adapter);
-	vmxnet3_adjust_rx_ring_size(adapter);
-	err = vmxnet3_rq_create_all(adapter);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "failed to re-create rx queues for XDP.");
-		return -EOPNOTSUPP;
+	err = vmxnet3_xdp_restart_dev(adapter);
+	if (err && new_bpf_prog) {
+		/* Attach failed (old_bpf_prog is NULL here): the core drops
+		 * its reference to the new program and keeps nothing
+		 * attached. Bring the device back up without XDP.
+		 */
+		NL_SET_ERR_MSG_MOD(extack, "failed to restart device for XDP");
+		vmxnet3_xdp_exchange_program(adapter, NULL);
+		if (vmxnet3_xdp_restart_dev(adapter))
+			goto err_close;
+		return err;
 	}
-	err = vmxnet3_activate_dev(adapter);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "failed to activate device for XDP.");
-		return -EOPNOTSUPP;
+		/* Detach failed. The core may ignore an error here (XDP link
+		 * release), so complete the detach on a closed device.
+		 */
+		netdev_err(netdev, "XDP removal failed to restart, closing\n");
+		goto err_close;
 	}
 	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
 
+done:
+	if (need_update) {
+		if (new_bpf_prog)
+			xdp_features_set_redirect_target(netdev, false);
+		else
+			xdp_features_clear_redirect_target(netdev);
+	}
+	if (old_bpf_prog)
+		bpf_prog_put(old_bpf_prog);
 	return 0;
+
+err_close:
+	/* The device is left quiesced, with IRQs freed and NAPI disabled,
+	 * as vmxnet3_close() expects after a quiesce: close the interface.
+	 * vmxnet3_force_close() would quiesce it and free the IRQs again.
+	 */
+	dev_close(netdev);
+	if (new_bpf_prog)
+		return err;
+	goto done;
 }
 
 /* This is the main xdp call used by kernel to set/unset eBPF program. */
-- 
2.47.3

