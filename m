Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218725;
	b=hvYABkn/eNlN1L1v7KvdabhG8w4Y4dlW2Udl5vsBRqDD7TUwlGdsyHPbQi94tA46El1l
	 BOd7+o/h+ok4KjhS5PFktpeM6KBLOX3ISi+9m60X2fUUZ9cdh0H7f727izUp/oKqRe5Fm
	 cB9Aamt5ZaHRHyRFL35RDbNtZyq99rIjeBf25WSqsDihbIvsLyq5t1Eu3xDQkNMJZp2wI
	 VdmEmkm/QL0Q2wBrAIk9RaTHQVsVx0bKb8bhMtjNwOXTY7EOt3ruXfS/mU2IbNDpPFrk3
	 8QHDOgqdhV9U0AlSDndp6DurKxkTDlyoiI7F+WBoLSP4P2iZtez5mCViEDEjlaH/jKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
	b=FNP52izIcjDZcZjekt8fmHhbPDuWz2KZp3zotrWF/SKVLPVwHlhoxCrK2MhrW4O85sHF
	 TG2FNUgHLl/caQzwwTDdaJ+jywTgC1ETT6AWWfalhUsWX0UhkrxozwGWKOljwG3b9bmSW
	 0KIOAvw01PvWQ79PqggYZKNcJD83Y44mKOBJs/TPiUEBtmtt1MDSgUxQkA+zj+uhNL3FT
	 FevJq8Mn81opr/verx6/ibKHAYTjGsdf7KmqOwJYlOTDz3Y0nrX6r/PBQEG+wHdQb7TKz
	 X+s4pnpJyik63xcZewXVtuV18BRAn7ud8pj7fgMnctUz8jJAXpFqpMvcZEHV9UdcFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlromTHX;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE9606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 10:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CE9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlromTHX
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1200564eec.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 02:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218724; x=1794823524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
        b=wlromTHXqlNDcGqKiVJjw0vw8vMkcQ1/dgdG8oGvptPI4AKx5hzvAG2oPLaNgi3FBT
         XraKeqI/g8Gp0q0uMl2+LBqAgILgLLZc5vCw5niwDJPw7nKvkPpMs7ntvKsBSXRqkjna
         NVHAEaV8MmPp9AVPrRot9jIqdzXn/WpvtKgR+SzbYBa+0Svk8rib0suTI2KlgKul0Yxz
         HgDP4YKrJuv/N93lA8UcqFu5pGeZaDig9ONXQELh3tWEp7lKyUCgT8uEYmdx8Wkx2Xuj
         qDH8HYZUQ517c1Sge5DDjO5vNfJIzN6PWXTRo7OVriuRACwBtT6vWoUsqe3EQbnw7gtG
         onTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218724; x=1794823524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
        b=cQ1mJFe/GCwuODidxl3AdKSFxEAb8JATXpLzeTRdIc/rAPYNF+AiMJk7eYIulc8Rl1
         iNXPi8vQYDDOBa1PWKZxbT4zvA4PuP8xwM+jRsZ6ZI/G1Jx1zpwHNI20STmXdtOrJLwN
         P/jcx7/t/Vwp2ichpItDJJbHwr+1Nc9LmDQgLuEEEANntgwjXPqULQpGy2ZUipKg0TFE
         Kq5Y0B8pynfzTMRKo59IFAIar3jMM1hA8wlHP6PNvXJsg+7P/Qq8slYvTllHDHKVvQ/r
         IC5uvCOXb1K9OmUn6KqXZqusC8TvS5YnU8qK80CyQsTo8slhiGK7QdCxp7rb6TzMg0WD
         EPBg==
X-Forwarded-Encrypted: i=1; AL+hErGqEZip1LBjL3pnUzVbj1uEZqQcrBCPCEgYXVNHyDfspUuJteoLXoOJB/5Yb5zLJUYlhfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F29SA4+R6P7N0662O6zrPEAO5wHiJfJRHiuDJ7YiOdSSvIPgS
	53cIvpE5+68F1Se8+dWOsvJ7GIgs88CPj+LME0epq5hO7oo8srLg8Oyc
X-Gm-Gg: AYBFou3qeckCgIjRMHdZF9lJMwgyEYP+Cm3/72RFydspXauc6qJXBIwkhdRnC//LV/u
	ZWwPLX1dAzLQjGzWlkQdTakz3zSlyBFyWkzTFWGzHtsSvEirbCnv0i5zHM/6WALpL53uSU2B6ti
	uN+n9m7AXfkR9xScnwJ6DKuGuuLKV3H0pe+Gl74wgSXI88j5a7hafbzx4ctIBeY35MxmYu07MFz
	7opp0Fy5Y43H7t11ldYldvuzfSGibN4LdoTTHKYOlla41P9XtD0kyTHPfBjc//LtwC+6HH+4Y6Q
	8fRjBSoNnqm9EWySOaNUUuHILdFnfzixrBoTHdeMCLD/QXbd6Ep4/hw3EmejQPtI0FwpAGsWh9F
	FeUpN6xYfRUHjeNXVDAT5iDIIkVQtd/liVDH/Rn1Ujeg50H5SN0m7AS164/LTM9lZGe+9cGtMxS
	3Dk31AzPYvvhUekLL7EPJlV1TyX+XyL4CM0zwonmOANOX7ZW/XBq/Y0IV3Y8KasZYG8poHwndi2
	vK9eUKsrD73CPDsT6ByhUwIBc/0Zo3NE5/FzBY8qXdfOcs77+aDZMb5sV7WPyVn39ciYLqgfAan
	bilmHbaHVs+rRXQSJeyRdWlkLyRtw2i265IcRlm+ycFt
X-Received: by 2002:a05:7301:da0a:b0:36a:1434:c691 with SMTP id 5a478bee46e88-37256bed190mr6227845eec.14.1794218723536;
        Mon, 09 Nov 2026 02:05:23 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:5a62:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12886710eec.26.2026.11.09.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:05:23 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
Date: Mon,  9 Nov 2026 15:34:36 +0530
Message-ID: <20261109100437.331423-2-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109100437.331423-1-amaan.cheval@gmail.com>
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
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

Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
verify_xdp_configuration(), which until then refused every format but
GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
socket on top of it, can still be attached on a queue format the driver
does not support.

The DQO-QPL RX path was never written for that. Its page accounting
assumes the driver keeps a reference of its own across every handoff:
gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
recycles it with gve_reuse_buffer(), so a redirect target that releases
the buffer synchronously, such as an AF_XDP socket in copy mode, can
drop the page's last reference when pagecnt_bias runs out. The page is
then freed while it is still DMA-mapped and registered in the QPL, and
the driver posts it back to the device.

Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
advertises no XDP features for the current queue format, which today
means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
for the same reason, and a copy-mode bind never reaches the driver and
is harmless without a program.

Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v5:
 - Check dev->xdp_features instead of queue_format, and reword the
   subject and message around that (Joshua).
v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@gmail.com/

 drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..fe560f5c5408 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
+	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported on this queue format.");
+		return -EOPNOTSUPP;
+	}
+
 	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when HW-GRO is on.");
-- 
2.47.3

