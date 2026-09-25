Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0072F3C37
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296536; cv=none; b=Kv+PofrqAmEmbKNGJT/P40xgw0ZItTD7cp0OWyLMkRc131IZf4RVY0e3BiK91mqkzrIgCJiwV8aZoSEDs4VqnRdO28Bs365mA9d3fLAfTHYHbcbEJk+l+ffFPKb8VG1ssBnuLRqPj1gyjpTQnS+iIINLfmRCryXFZVEQ3JqsiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296536; c=relaxed/simple;
	bh=7FwtI/Mdf7a1hU67sxb7K0Iqjw0jLYC/Tb7vxw7a1ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHkLbYf2YvC2Gny15trzp1JPXFOvvDKC9ux5nFaSq25qDZxGp7jXplsuAxhaDK5S+s1xbMu/MWJmzCLkUUDpljO0qkVa8DMiZQjvH6mVzcZnoAmugpysKb1SiKaxzhcYQIf/TS4Grh+YAOyr1mF8mxbmHSUDLwI8E5LIP90kC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+YvhN1D; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+YvhN1D"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so216608a34.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296532; x=1790901332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/Rv9LEywAn/T2L1qIFwIESUKEKqSrD36JO469m4yiQ=;
        b=m+YvhN1DGuV2XUaSvCMTC2CmUSn3t+euf9MG+1hRKh+ldvZXg259cuyEcuCYE2Oysk
         qhNUMxjDUvjHULswOAT6gS/Z0hO63+MdEt4YnW10GavxzYYXjwP/+SbHVlRe6tNFtTDq
         wOTCx65vc98pgAKh8aDfw05tuQiLdOitces6HZKXZ+yXDs8BP5ox4wNqMmkNMRl8yhNs
         MR2s3B3cuYsNZEy0P3sOYZ2ciO4HnmZ8csvCKQRKd2R+zbQ/OAzHSzUXbA4nUaOATjVe
         LohiC+WUWeGcUVY7rAr23n6+7RlZpsT8oCvWJaeLOUBoDuTtYeQuf1qiVXPw9BBIjACF
         CfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296532; x=1790901332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/Rv9LEywAn/T2L1qIFwIESUKEKqSrD36JO469m4yiQ=;
        b=oTpLLJpp8E27W/LmQ7TFgyG5ex7FtG0GlP2HfXgfzBd+aPqI7xnhcb0oTZmGE2zFlB
         TgomiH+aGqrYLymwDBPJ8jDG+Z5zhvtxNthXgfRuC8y22Dl+dw7wLfHcD4iOgPPKKHjN
         wpWl1DXP7qDKlRhDXefidJNdZmwb6kynMfI0OfEdY5JqvWFQdLxiGpuov2rAnD4BuOop
         eR+oUXwOnXNliYp7qf93V8HP6G21GHhRXMQp9Ko+lBp2wiowKy+iOq44FT/qSvkkOP6L
         mjdNQ4vrYAAnJmuG2o7Xx5+I/0KGEFQSZ/F1RnSqkaGQrNO5DxHpERylF7WWY+lKyXSt
         R5jg==
X-Forwarded-Encrypted: i=1; AKwUvBxhWU0vs7geI9buir9OoE+mNFgiraS4FjOBCAhTJ1gaNMhZpJKDGkWRSpy/NRhh5AktVhY=@vger.kernel.org
X-Gm-Message-State: AFuF++m9ntC7FdSJizTcJMEPBDBFH/G6gjlJYBiFGXCHeckwVZUkwttg
	HaqyEIGJFqIx2RjhmYpEc5AdA9pvGq1Q1DYHweNqC0Wwa+UUNL/Q/Yry
X-Gm-Gg: AYBFou2ARemEYqTDw/MRqiJ7getLgGt4njULYLGIqEWU3khSEG2RZtFVbQf6pvwHnVa
	dqsw3kZ0a8pvwLALySrBYKjvxbPvuzZKULDhmkury3OL8ARWzahitRZTmjJpf2J4Jyy9jBPyL6R
	D+fHx5yKzLiHoP2EF0i2dfnb+ERM32ssOIBl2uyvXyxaIln9DMEFgn1q21bLnE7qTMpsqQuAwm6
	8oOmpxm57AKKrbbQws1NGtXZcmLAjEctCmMdCteHjnxb0vgPeC8NZUoMrR6+XZFpnu4ovu25S8W
	FM2rXfXwE3pcYCwxbK0P1qeG9G7Vx3oXkLd0EvIpH2AU19z1FeqbPBA6yRdlu4djPhg+O9S/94L
	jXGcvK5/bbHqYDZCyYQYt/9tPKq2vWQtrQ73lNs5MbZ/70lhWwwfcPFUx4ZIhACxAl5PPBMAq6C
	iHV2epJrGHHOVz3DYaap0Q3juukaohkYSiwhL0XqQW/OTsbEUBsu0xxZtn2ku0ozgreWqgJd05N
	0+YLaM=
X-Received: by 2002:a05:6830:4425:b0:7f4:eb76:8820 with SMTP id 46e09a7af769-8178168df1dmr4473730a34.13.1790296531547;
        Thu, 24 Sep 2026 17:35:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8190ee1b002sm563803a34.8.2026.09.24.17.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:30 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:15 -0700
Subject: [PATCH net-next v2 2/8] eth: mpnic: add register init for the
 device
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-2-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

From: Mohsin Bashir <mohsin.bashr@gmail.com>

Perform one time register initialization during mpnic_probe(). These CSR
settings are either static configs that only need to be set once, or
pulses for zeroizing on chip SRAMs, which also only need to be done
once.

This initialization is idempotent and does not require any matching
deinitialization in the remove path. We can unbind and re-bind the
driver and perform the same initialization without problems.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- derive the TQS TXB credit limits from the TXB private credit config
- program the BMC to MAC XOFF threshold (TXB_THRESHOLDS_P0[16]) instead of
  the host to BMC one, and drop the now unused MPNIC_TXB_BMC_THRESH
- drop L2_HLEN from the default TWD, it only matters for csum/LSO
---
 drivers/net/ethernet/meta/mpnic/Makefile     |   1 +
 drivers/net/ethernet/meta/mpnic/mpnic.h      |   9 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h  | 163 ++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c | 556 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c  |   8 +
 5 files changed, 737 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
index 2588f1f1f1d5..9dcaa1c72605 100644
--- a/drivers/net/ethernet/meta/mpnic/Makefile
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -8,5 +8,6 @@
 obj-$(CONFIG_MPNIC) += mpnic.o
 
 mpnic-y := \
+	mpnic_init.o \
 	mpnic_pci.o \
 # End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
index 6b8bee93033a..67d48b7ce315 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -11,14 +11,23 @@
 
 #define MPNIC_DRV_NAME		"mpnic"
 
+#define MPNIC_MAX_TXQS		1024u
+#define MPNIC_MAX_RXQS		1024u
+
 struct mpnic_dev {
 	struct device *dev;
 
 	u32 __iomem *uc_addr0;
+
+	u32 mps;
+	u32 readrq;
+	u8 relaxed_ord;
 };
 
 u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg);
 
+int mpnic_dev_init(struct mpnic_dev *mpd);
+
 static inline void mpnic_wr64(struct mpnic_dev *mpd, u32 reg, u64 val)
 {
 	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 473a2e9f5a09..3ddd6acea085 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -9,6 +9,16 @@
 #define CSR_BIT(nr)		BIT_ULL(nr)
 #define CSR_GENMASK(h, l)	GENMASK_ULL(h, l)
 
+#define DESC_BIT(nr)		BIT_ULL(nr)
+#define DESC_GENMASK(h, l)	GENMASK_ULL(h, l)
+
+/* Transmit Work Descriptor Format */
+#define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
+
+/* Common fields for all DESC_CFG CSRs */
+#define MPNIC_DESC_CFG_NUM_DESCS	CSR_GENMASK(2, 0)
+#define MPNIC_DESC_CFG_START_ADDR	CSR_GENMASK(19, 8)
+
 /* Register Definitions
  *
  * The register file is addressed as an array of le32, so the byte address of
@@ -19,6 +29,159 @@
  *****************************************************************************/
 
 /* NIC_CORE_RBP_HP_GLBL */
+#define MPNIC_BDQ_GLBL_CTL0		0x420080		/* 0x1080200 */
+#define MPNIC_BDQ_GLBL_CTL0_MAX_REQ_SIZE	CSR_GENMASK(26, 18)
+#define MPNIC_BDQ_GLBL_CTL0_PREFETCH_SPACE_THRESH \
+						CSR_GENMASK(42, 32)
+#define MPNIC_RDE_CTL			0x420082		/* 0x1080208 */
+#define MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD	CSR_GENMASK(10, 0)
+#define MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD	CSR_GENMASK(21, 11)
+#define MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD	CSR_GENMASK(42, 32)
+#define MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD	CSR_GENMASK(53, 43)
+#define MPNIC_BDQ_MEM_INIT_REQ		0x42013a		/* 0x10804e8 */
+#define MPNIC_BDQ_MEM_INIT_DONE		0x42013c		/* 0x10804f0 */
 #define MPNIC_BDQ_SPARE			0x42013e		/* 0x10804f8 */
+#define MPNIC_HPQ_DESC_CFG(i)		(0x420140 + 2 * (i))	/* 0x1080500 */
+#define MPNIC_PPQ_DESC_CFG(i)		(0x420940 + 2 * (i))	/* 0x1082500 */
+
+/* NIC_CORE_RDE_GLBL */
+#define MPNIC_RDE_MEM_INIT_REQ		0x4240e6		/* 0x1090398 */
+#define MPNIC_RDE_MEM_INIT_DONE		0x4240e8		/* 0x10903a0 */
+
+/* NIC_CORE_RCM_GLBL */
+#define MPNIC_RCM_MEM_INIT_REQ		0x42507e		/* 0x10941f8 */
+#define MPNIC_RCM_MEM_INIT_DONE		0x425080		/* 0x1094200 */
+
+/* NIC_CORE_RNI_GLBL */
+#define MPNIC_RNI_RBP_CTL		0x427000		/* 0x109c000 */
+#define MPNIC_RNI_RDE_CTL		0x427002		/* 0x109c008 */
+#define MPNIC_RNI_RDE_CTL_MPS			CSR_GENMASK(1, 0)
+#define MPNIC_RNI_RDE_CTL_CLS			CSR_GENMASK(3, 2)
+#define MPNIC_RNI_RCM_CTL		0x427004		/* 0x109c010 */
+
+/* NIC_CORE_TDF_GLBL */
+#define MPNIC_TWQ_DEF_PRI_TWD		0x428082		/* 0x10a0208 */
+#define MPNIC_TDF_MEM_INIT_REQ		0x42813a		/* 0x10a04e8 */
+#define MPNIC_TDF_MEM_INIT_DONE		0x42813c		/* 0x10a04f0 */
+#define MPNIC_TDF_DESC_CFG(i)		(0x428140 + 2 * (i))	/* 0x10a0500 */
+
+/* NIC_CORE_TQS_GLBL */
+#define MPNIC_TQS_GLBL_CTL0		0x42a000		/* 0x10a8000 */
+#define MPNIC_TQS_GLBL_CTL0_TWD_ERROR_CHECK_EN	CSR_BIT(2)
+#define MPNIC_TQS_GLBL_P0_0		0x42a002		/* 0x10a8008 */
+#define MPNIC_TQS_GLBL_P0_0_TXB_MAX_CRDTS_0	CSR_GENMASK(63, 48)
+#define MPNIC_TQS_GLBL_P0_1		0x42a004		/* 0x10a8010 */
+#define MPNIC_TQS_GLBL_BMC		0x42a012		/* 0x10a8048 */
+#define MPNIC_TQS_GLBL_BMC_TXB_MAX_CRDTS	CSR_GENMASK(15, 0)
+#define MPNIC_TQS_SLOWDOWN_CTL		0x42a026		/* 0x10a8098 */
+#define MPNIC_TQS_SLOWDOWN_CTL_ENABLE		CSR_BIT(6)
+#define MPNIC_TQS_MTU_CTL0		0x42a030		/* 0x10a80c0 */
+#define MPNIC_TQS_MTU_CTL1		0x42a032		/* 0x10a80c8 */
+#define MPNIC_TQS_SET_P0_MAP0(i)	(0x42a082 + 2 * (i))	/* 0x10a8208 */
+#define MPNIC_TQS_SET_P0_MAP1(i)	(0x42a092 + 2 * (i))	/* 0x10a8248 */
+#define MPNIC_TQS_GLBL_SHAPING		0x42a108		/* 0x10a8420 */
+#define MPNIC_TQS_GLBL_SHAPING_DISABLE		CSR_BIT(0)
+#define MPNIC_TQS_ARB_CTL		0x42a122		/* 0x10a8488 */
+#define MPNIC_TQS_ARB_CTL_SET_CRDT_BUCKET_EN	CSR_BIT(9)
+#define MPNIC_TQS_ARB_CTL_SET_IMM_DECR_EN	CSR_BIT(8)
+#define MPNIC_TQS_ARB_CTL_GROUP_CRDT_BUCKET_EN	CSR_BIT(5)
+#define MPNIC_TQS_ARB_CTL_GROUP_IMM_DECR_EN	CSR_BIT(4)
+#define MPNIC_TQS_ARB_CTL_QUEUE_CRDT_BUCKET_EN	CSR_BIT(1)
+#define MPNIC_TQS_ARB_CTL_QUEUE_IMM_DECR_EN	CSR_BIT(0)
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_0 \
+					0x42a124		/* 0x10a8490 */
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_0_QUEUE	CSR_GENMASK(19, 0)
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_0_GROUP	CSR_GENMASK(59, 32)
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_1 \
+					0x42a126		/* 0x10a8498 */
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_1_SET	CSR_GENMASK(27, 0)
+#define MPNIC_TQS_CEV_MIN_SCHED_THRESH_1_PORT	CSR_GENMASK(63, 32)
+#define MPNIC_TQS_SRAM_INIT_CTL		0x42a128		/* 0x10a84a0 */
+#define MPNIC_TQS_SRAM_INIT_CTL_QUANTUM		CSR_GENMASK(31, 20)
+#define MPNIC_TQS_SRAM_INIT_CTL_INIT		CSR_BIT(32)
+#define MPNIC_TQS_GROUP_INIT_CTL	0x42a12a		/* 0x10a84a8 */
+#define MPNIC_TQS_GROUP_INIT_CTL_QUANTUM	CSR_GENMASK(51, 32)
+#define MPNIC_TQS_GROUP_INIT_CTL_INIT		CSR_BIT(52)
+#define MPNIC_TQS_SET_INIT_CTL		0x42a12c		/* 0x10a84b0 */
+#define MPNIC_TQS_SET_INIT_CTL_QUANTUM		CSR_GENMASK(51, 32)
+#define MPNIC_TQS_SET_INIT_CTL_INIT		CSR_BIT(52)
+#define MPNIC_TQS_PORT_INIT_CTL		0x42a12e		/* 0x10a84b8 */
+#define MPNIC_TQS_PORT_INIT_CTL_QUANTUM		CSR_GENMASK(55, 32)
+#define MPNIC_TQS_PORT_INIT_CTL_INIT		CSR_BIT(56)
+#define MPNIC_TQS_SRAM_STS		0x42a130		/* 0x10a84c0 */
+#define MPNIC_TQS_PORT_CTL(i)		(0x42a1e4 + 2 * (i))	/* 0x10a8790 */
+
+/* NIC_CORE_TDE_GLBL */
+#define MPNIC_TDE_MEM_INIT_REQ		0x42b1ee		/* 0x10ac7b8 */
+#define MPNIC_TDE_MEM_INIT_DONE		0x42b1f0		/* 0x10ac7c0 */
+
+/* NIC_CORE_TCM_GLBL */
+#define MPNIC_TCM_MEM_INIT_REQ		0x42c0be		/* 0x10b02f8 */
+#define MPNIC_TCM_MEM_INIT_DONE		0x42c0c0		/* 0x10b0300 */
+
+/* NIC_CORE_TNI_GLBL */
+#define MPNIC_TNI_GLBL_TDF_CTL		0x42e000		/* 0x10b8000 */
+#define MPNIC_TNI_GLBL_TDF_CTL_MRRS		CSR_GENMASK(2, 0)
+#define MPNIC_TNI_GLBL_TDF_CTL_CLS		CSR_GENMASK(5, 3)
+#define MPNIC_TNI_GLBL_TDE_CTL		0x42e002		/* 0x10b8008 */
+#define MPNIC_TNI_GLBL_TCM_CTL		0x42e004		/* 0x10b8010 */
+
+/* NIC_CORE_TXB */
+#define MPNIC_TXB_PORT_CONFIG		0x600000		/* 0x1800000 */
+#define MPNIC_TXB_PORT_CONFIG_PORT_MODE		CSR_GENMASK(15, 13)
+#define MPNIC_TXB_BMC			0x600122		/* 0x1800488 */
+#define MPNIC_TXB_P0(i)			(0x600124 + 2 * (i))	/* 0x1800490 */
+#define MPNIC_TXB_P0_CNT		17
+#define MPNIC_TXB_P0_THRESH(i)		(0x60025e + 2 * (i))	/* 0x1800978 */
+#define MPNIC_TXB_P0_ARB_WEIGHTS(i)	(0x600378 + 2 * (i))	/* 0x1800de0 */
+
+/* NIC_CORE_RXB */
+#define MPNIC_RXB_MEM_INIT_REQ		0x620002		/* 0x1880008 */
+#define MPNIC_RXB_MEM_INIT_DONE		0x620004		/* 0x1880010 */
+#define MPNIC_RXB_PORT_CFG(i)		(0x620006 + 2 * (i))	/* 0x1880018 */
+#define MPNIC_RXB_PORT_CFG_FCS_STRIP_MODE	CSR_GENMASK(22, 22)
+enum {
+	MPNIC_FCS_MODE_KEEP	= 0,
+	MPNIC_FCS_MODE_STRIP	= 1,
+};
+
+#define MPNIC_RXB_PORT_CLASS_CFG(i)	(0x620020 + 2 * (i))	/* 0x1880080 */
+#define MPNIC_RXB_PORT_CLASS_CFG_DEFAULT_L2_ACTION \
+						CSR_GENMASK(0, 0)
+enum {
+	MPNIC_L2_ACTION_DROP	= 0,
+	MPNIC_L2_ACTION_PASS	= 1,
+};
+
+#define MPNIC_RXB_TC_CRDTS(i)		(0x620418 + 2 * (i))	/* 0x1881060 */
+#define MPNIC_RXB_POOL_COMMON_CRDTS(i)	(0x620458 + 2 * (i))	/* 0x1881160 */
+#define MPNIC_RXB_COMMON_CRDT_CTRL_TC(i) \
+					(0x620472 + 2 * (i))	/* 0x18811c8 */
+#define MPNIC_RXB_COMMON_CRDT_CTRL_TC_THRESH	CSR_GENMASK(15, 0)
+#define MPNIC_RXB_COMMON_CRDT_CTRL_TC_TC_EN	CSR_BIT(29)
+#define MPNIC_RXB_COMMON_CRDT_CTRL_TC_MAX_CRDTS	CSR_GENMASK(47, 32)
+#define MPNIC_RXB_HOST_DROP_THRESH(i)	(0x6205b0 + 2 * (i))	/* 0x18816c0 */
+#define MPNIC_RXB_BMC_CRDTS(i)		(0x6205d0 + 2 * (i))	/* 0x1881740 */
+
+/* NIC_CORE_RPC */
+#define MPNIC_RPC_MEM_INIT_REQ		0x780440		/* 0x1e01100 */
+#define MPNIC_RPC_MEM_INIT_DONE		0x780442		/* 0x1e01108 */
+
+/* NIC_CORE_ROF */
+#define MPNIC_RSC_GLOBAL_CONF		0x7e2002		/* 0x1f88008 */
+#define MPNIC_RSC_GLOBAL_CONF_RSC_DISABLE	CSR_BIT(0)
+
+/* NIC_CORE_TOF */
+#define MPNIC_TOF_TCAM_DEST_REMAP	0x7e3022		/* 0x1f8c088 */
+
+/* PEMO_WRAPPER */
+#define MPNIC_OB_ATTR_RO			CSR_BIT(1)
+#define MPNIC_OB_ATTR_TDE_H		0x9a000e		/* 0x2680038 */
+#define MPNIC_OB_ATTR_TDE_P		0x9a0010		/* 0x2680040 */
+#define MPNIC_OB_ATTR_TDF		0x9a0012		/* 0x2680048 */
+#define MPNIC_OB_ATTR_RBP_HPQ		0x9a0014		/* 0x2680050 */
+#define MPNIC_OB_ATTR_RBP_PPQ		0x9a0016		/* 0x2680058 */
+#define MPNIC_OB_ATTR_RDE_H		0x9a0018		/* 0x2680060 */
+#define MPNIC_OB_ATTR_RDE_P		0x9a001a		/* 0x2680068 */
 
 #endif /* _MPNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
new file mode 100644
index 000000000000..2daed458f5fc
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cache.h>
+#include <linux/if_ether.h>
+#include <linux/iopoll.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+
+#include "mpnic.h"
+
+#define MPNIC_MEM_INIT_POLL_US		500
+#define MPNIC_MEM_INIT_TO_US		5000
+
+/* BDQ mem init:
+ *  bit 1: fifo_wrptr_mem
+ *  bit 0: fifo_rdptr_mem
+ */
+#define MPNIC_MEM_INIT_BDQ_VAL		0x3
+
+/* RCM mem init:
+ *  bit 3: cq_base_addr
+ *  bit 2: cd_fifo_rptr_stats
+ *  bit 1: cd_fifo_wptr_stats
+ *  bit 0: cq_head_ptr_stats
+ */
+#define MPNIC_MEM_INIT_RCM_VAL		0xf
+
+/* RDE mem init, bits 0-18. Bits 0-12 are the per-queue packet, error and
+ * drop counters, bits 13-18 the two context memories of each of the HPQ,
+ * PPQ and SPQ descriptor prefetchers.
+ */
+#define MPNIC_MEM_INIT_RDE_VAL		0x7ffff
+
+/* RPC mem init, bit 0 covers the whole classifier. */
+#define MPNIC_MEM_INIT_RPC_VAL		0x1
+
+/* TCM mem init:
+ *  bit 3: cq_head_ptr_stats
+ *  bit 2: cd_fifo_wptr_stats
+ *  bit 1: cd_fifo_rptr_stats
+ *  bit 0: cq_base_addr
+ */
+#define MPNIC_MEM_INIT_TCM_VAL		0xf
+
+/* TDE mem init:
+ *  bit 1: stats mem
+ *  bit 0: dma_head_ptr SRAM
+ */
+#define MPNIC_MEM_INIT_TDE_VAL		0x3
+
+/* TDF mem init, bit 0 covers the descriptor fetch SRAM. */
+#define MPNIC_MEM_INIT_TDF_VAL		0x1
+
+/* RXB mem init, bit 0 covers the DMAC TCAM statistics RAM. */
+#define MPNIC_MEM_INIT_RXB_VAL		0x1
+
+/* TQS arbiter SRAM init done, one bit per DWRR level. */
+#define MPNIC_TQS_ARB_INIT_VAL		0xf
+
+/* On-chip SRAM allocated to each queue for descriptor fetch, in units of
+ * descriptors. Valid values are 64, 128, 256, 512 and 1024.
+ *
+ * The partition sizes are chosen for the maximum number of queues the
+ * device supports, so they do not have to be adjusted when the active
+ * queue count changes:
+ *
+ *   BDQ: 1 MiB / (8 B/DESC) / (1024 HPQ + 1024 PPQ) =  64 DESC/QUEUE
+ *   TWQ: 2 MiB / (8 B/DESC) / (1024 TXQ * 2 TWQ)    = 128 DESC/QUEUE
+ */
+#define MPNIC_BDQ_SRAM_DESCS		64u
+#define MPNIC_TDF_SRAM_DESCS		128u
+
+/* A total of 1 MiB worth of Tx credits is available, in units of 128 B.
+ * The BMC to MAC and host to BMC paths each get a guaranteed share of them
+ * whether or not anything is routed their way, everything else goes to
+ * MAC TC0.
+ */
+#define MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL		800
+#define MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL	\
+	(SZ_1M / 128 - 2 * MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL)
+
+/* The recommended lower bound for the TXB threshold is 80, based on a 10K
+ * MTU. Round up by 25% to stay on the defensive side. The same reasoning
+ * applies to the arbitration weight, which has to exceed the full packet
+ * size.
+ */
+#define MPNIC_TXB_INIT_BMC_THRESH		100
+#define MPNIC_TXB_INIT_P0_THRESH		100
+#define MPNIC_TXB_INIT_P0_ARB_WEIGHTS		0x64
+
+/* RXB host drop threshold in units of 128 B beats. Packets targeting a
+ * queue are dropped when the available credits fall below it. 80 beats is
+ * 10 KB, which is also the largest frame the device is configured for.
+ */
+#define MPNIC_RXB_INIT_HOST_DROP_THRESH		0x50
+
+/* A total of 8 MiB of Rx buffer is available. The recommended per-TC pool
+ * for a 800G configuration is 420 KB with all 8 TCs enabled. Only one TC
+ * is in use, so give it 8 * 420 KB (in units of 128 B) and push the rest
+ * to the common pool. Start drawing from the common pool as soon as the
+ * TC0 credits fall below one max sized frame. The BMC keeps a small
+ * reserve of its own whether or not the host talks to it.
+ */
+#define MPNIC_RXB_INIT_POOL_TC_CRDTS_P0		(0xd20 * 8)
+#define MPNIC_RXB_INIT_BMC_CRDTS		0x20
+#define MPNIC_RXB_INIT_COMMON_CRDT_MAX_THRSH	\
+	(SZ_8M / 128 - MPNIC_RXB_INIT_POOL_TC_CRDTS_P0 - \
+	 MPNIC_RXB_INIT_BMC_CRDTS)
+#define MPNIC_RXB_INIT_COMMON_CRDT_THRSH	0x50
+
+/* TXB port mode selects the number of active MAC ports for Tx buffer
+ * credit distribution and arbitration. The hardware only supports single,
+ * dual and quad port, encoded as b'001, b'010 and b'100.
+ */
+#define MPNIC_TXB_PORT_MODE_SINGLE	1
+
+/* The MAC traffic classes start at index 8 in the TXB arrays, the BMC
+ * sits above them.
+ */
+#define MPNIC_TXB_TC_IDX_MAC_0		8
+#define MPNIC_TXB_TC_IDX_BMC		16
+
+/* Largest frame the Tx queue scheduler will pass through. Anything above
+ * it gets truncated.
+ */
+#define MPNIC_TQS_MTU_CTL0_MAX		0x2800
+
+/* The unit of the DWRR quantum is 256 B. It has to be large enough for at
+ * least 11 MTUs to be transmitted in one quantum; use 15 for headroom.
+ */
+#define MPNIC_TQS_DWRR_INIT_QUANTUM	(15 * MPNIC_TQS_MTU_CTL0_MAX / 256)
+
+/* Lower bound on the credit available to a queue, group, set or port
+ * before the scheduler stops issuing requests for it. 15 MTUs, matching
+ * the DWRR quantum above.
+ */
+#define MPNIC_TQS_DWRR_CEV_MIN_SCHED_THRESH	(15 * MPNIC_TQS_MTU_CTL0_MAX)
+
+/* The TQS view of the TXB partitioning between the MAC and the BMC, in
+ * units of 1 KiB. It has to match the TXB private credits above.
+ */
+#define MPNIC_TQS_GLBL_TXB_CRDT_UNIT	SZ_1K
+#define MPNIC_TQS_GLBL_TXB_CRDT_BMC	\
+	(MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL * 128 / MPNIC_TQS_GLBL_TXB_CRDT_UNIT)
+#define MPNIC_TQS_GLBL_TXB_CRDT_MAC	\
+	(MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL * 128 / \
+	 MPNIC_TQS_GLBL_TXB_CRDT_UNIT)
+
+struct mpnic_init_poll {
+	u64 exp_val;
+	u32 addr;
+};
+
+struct mpnic_poll_state {
+	int poll_idx;
+	u64 val;
+};
+
+static void mpnic_tdf_glbl_init(struct mpnic_dev *mpd)
+{
+	/* Default metadata descriptor, used for frames the driver did not
+	 * prepend one to.
+	 */
+	mpnic_wr64(mpd, MPNIC_TWQ_DEF_PRI_TWD, MPNIC_TWD_FLAG_REQ_COMPLETION);
+}
+
+static void mpnic_txb_init(struct mpnic_dev *mpd)
+{
+	int i;
+
+	mpnic_wr64(mpd, MPNIC_TXB_BMC, MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL);
+
+	/* Zero the private credits of every traffic class, then hand the
+	 * unreserved ones to MAC TC0.
+	 */
+	for (i = 0; i < MPNIC_TXB_P0_CNT; i++)
+		mpnic_wr64(mpd, MPNIC_TXB_P0(i), 0);
+	mpnic_wr64(mpd, MPNIC_TXB_P0(MPNIC_TXB_TC_IDX_MAC_0),
+		   MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL);
+	mpnic_wr64(mpd, MPNIC_TXB_P0(MPNIC_TXB_TC_IDX_BMC),
+		   MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL);
+
+	mpnic_wr64(mpd, MPNIC_TXB_P0_THRESH(MPNIC_TXB_TC_IDX_BMC),
+		   MPNIC_TXB_INIT_BMC_THRESH);
+
+	mpnic_wr64(mpd, MPNIC_TXB_P0_THRESH(MPNIC_TXB_TC_IDX_MAC_0),
+		   MPNIC_TXB_INIT_P0_THRESH);
+	mpnic_wr64(mpd, MPNIC_TXB_P0_ARB_WEIGHTS(MPNIC_TXB_TC_IDX_MAC_0),
+		   MPNIC_TXB_INIT_P0_ARB_WEIGHTS);
+	mpnic_wr64(mpd, MPNIC_TXB_PORT_CONFIG,
+		   FIELD_PREP(MPNIC_TXB_PORT_CONFIG_PORT_MODE,
+			      MPNIC_TXB_PORT_MODE_SINGLE));
+}
+
+static void mpnic_rxb_init(struct mpnic_dev *mpd)
+{
+	/* Accept all packets that miss dmac tcam, until l2 filtering is
+	 * implemented.
+	 */
+	mpnic_wr64(mpd, MPNIC_RXB_PORT_CLASS_CFG(0),
+		   FIELD_PREP(MPNIC_RXB_PORT_CLASS_CFG_DEFAULT_L2_ACTION,
+			      MPNIC_L2_ACTION_PASS));
+	mpnic_wr64(mpd, MPNIC_RXB_PORT_CFG(0),
+		   FIELD_PREP(MPNIC_RXB_PORT_CFG_FCS_STRIP_MODE,
+			      MPNIC_FCS_MODE_STRIP));
+
+	mpnic_wr64(mpd, MPNIC_RXB_HOST_DROP_THRESH(0),
+		   MPNIC_RXB_INIT_HOST_DROP_THRESH);
+
+	mpnic_wr64(mpd, MPNIC_RXB_TC_CRDTS(0),
+		   MPNIC_RXB_INIT_POOL_TC_CRDTS_P0);
+	mpnic_wr64(mpd, MPNIC_RXB_COMMON_CRDT_CTRL_TC(0),
+		   FIELD_PREP(MPNIC_RXB_COMMON_CRDT_CTRL_TC_THRESH,
+			      MPNIC_RXB_INIT_COMMON_CRDT_THRSH) |
+		   FIELD_PREP(MPNIC_RXB_COMMON_CRDT_CTRL_TC_MAX_CRDTS,
+			      MPNIC_RXB_INIT_COMMON_CRDT_MAX_THRSH) |
+		   MPNIC_RXB_COMMON_CRDT_CTRL_TC_TC_EN);
+
+	/* Only pool 0 is used, it gets all of the common credits */
+	mpnic_wr64(mpd, MPNIC_RXB_POOL_COMMON_CRDTS(0),
+		   MPNIC_RXB_INIT_COMMON_CRDT_MAX_THRSH);
+
+	mpnic_wr64(mpd, MPNIC_RXB_BMC_CRDTS(0), MPNIC_RXB_INIT_BMC_CRDTS);
+
+	mpnic_wr64(mpd, MPNIC_RXB_MEM_INIT_REQ, MPNIC_MEM_INIT_RXB_VAL);
+}
+
+static u64 mpnic_desc_cfg(unsigned int sram_descs, unsigned int q_idx)
+{
+	/* The hardware encodes the partition size as 64 * 2^n descriptors,
+	 * and its start address in units of 64 descriptors.
+	 */
+	return FIELD_PREP(MPNIC_DESC_CFG_NUM_DESCS, __ffs(sram_descs) - 6) |
+	       FIELD_PREP(MPNIC_DESC_CFG_START_ADDR,
+			  q_idx * (sram_descs >> 6));
+}
+
+static void mpnic_desc_sram_init(struct mpnic_dev *mpd)
+{
+	int i;
+
+	for (i = 0; i < MPNIC_MAX_TXQS * 2; i++)
+		mpnic_wr64(mpd, MPNIC_TDF_DESC_CFG(i),
+			   mpnic_desc_cfg(MPNIC_TDF_SRAM_DESCS, i));
+
+	for (i = 0; i < MPNIC_MAX_RXQS; i++) {
+		mpnic_wr64(mpd, MPNIC_HPQ_DESC_CFG(i),
+			   mpnic_desc_cfg(MPNIC_BDQ_SRAM_DESCS, i));
+		mpnic_wr64(mpd, MPNIC_PPQ_DESC_CFG(i),
+			   mpnic_desc_cfg(MPNIC_BDQ_SRAM_DESCS,
+					  MPNIC_MAX_RXQS + i));
+	}
+}
+
+static void mpnic_rxglb_init(struct mpnic_dev *mpd)
+{
+	/* Descriptor prefetch reads are only issued once 32 descriptors
+	 * worth of FIFO space is available, and no more than 64 descriptors
+	 * are fetched for one queue at a time so that a single queue cannot
+	 * monopolize the bus. Both have to be multiples of 16 to keep the
+	 * reads 128 B aligned.
+	 */
+	mpnic_wr64(mpd, MPNIC_BDQ_GLBL_CTL0,
+		   FIELD_PREP(MPNIC_BDQ_GLBL_CTL0_PREFETCH_SPACE_THRESH, 32) |
+		   FIELD_PREP(MPNIC_BDQ_GLBL_CTL0_MAX_REQ_SIZE, 64));
+
+	/* Minimum number of descriptors which has to be available before
+	 * the descriptor engine considers a queue usable, globally and in
+	 * the per-queue prefetch FIFO.
+	 */
+	mpnic_wr64(mpd, MPNIC_RDE_CTL,
+		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_DROP_THRESHOLD, 16) |
+		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_DROP_THRESHOLD, 16) |
+		   FIELD_PREP(MPNIC_RDE_CTL_HPQ_LOCAL_DROP_THRESHOLD, 16) |
+		   FIELD_PREP(MPNIC_RDE_CTL_PPQ_LOCAL_DROP_THRESHOLD, 16));
+
+	/* Receive side coalescing is not supported yet */
+	mpnic_wr64(mpd, MPNIC_RSC_GLOBAL_CONF,
+		   MPNIC_RSC_GLOBAL_CONF_RSC_DISABLE);
+
+	mpnic_wr64(mpd, MPNIC_BDQ_MEM_INIT_REQ, MPNIC_MEM_INIT_BDQ_VAL);
+	mpnic_wr64(mpd, MPNIC_RCM_MEM_INIT_REQ, MPNIC_MEM_INIT_RCM_VAL);
+	mpnic_wr64(mpd, MPNIC_RDE_MEM_INIT_REQ, MPNIC_MEM_INIT_RDE_VAL);
+	mpnic_wr64(mpd, MPNIC_RPC_MEM_INIT_REQ, MPNIC_MEM_INIT_RPC_VAL);
+}
+
+static void mpnic_txglb_init(struct mpnic_dev *mpd)
+{
+	/* Nothing is redirected to the BMC until the Tx offload TCAM gets
+	 * programmed with its addresses.
+	 */
+	mpnic_wr64(mpd, MPNIC_TOF_TCAM_DEST_REMAP, 0);
+
+	mpnic_wr64(mpd, MPNIC_TCM_MEM_INIT_REQ, MPNIC_MEM_INIT_TCM_VAL);
+	mpnic_wr64(mpd, MPNIC_TDE_MEM_INIT_REQ, MPNIC_MEM_INIT_TDE_VAL);
+	mpnic_wr64(mpd, MPNIC_TDF_MEM_INIT_REQ, MPNIC_MEM_INIT_TDF_VAL);
+}
+
+/* Fill the DWRR arbiter memories. Setting the INIT bit makes the hardware
+ * write the given credit and quantum into every entry at the queue, group,
+ * set and port level, so nothing has to be programmed per queue.
+ */
+static void mpnic_tqs_sram_init(struct mpnic_dev *mpd)
+{
+	mpnic_wr64(mpd, MPNIC_TQS_GROUP_INIT_CTL,
+		   FIELD_PREP(MPNIC_TQS_GROUP_INIT_CTL_QUANTUM,
+			      MPNIC_TQS_DWRR_INIT_QUANTUM) |
+		   MPNIC_TQS_GROUP_INIT_CTL_INIT);
+	mpnic_wr64(mpd, MPNIC_TQS_SET_INIT_CTL,
+		   FIELD_PREP(MPNIC_TQS_SET_INIT_CTL_QUANTUM,
+			      MPNIC_TQS_DWRR_INIT_QUANTUM) |
+		   MPNIC_TQS_SET_INIT_CTL_INIT);
+	mpnic_wr64(mpd, MPNIC_TQS_PORT_INIT_CTL,
+		   FIELD_PREP(MPNIC_TQS_PORT_INIT_CTL_QUANTUM,
+			      MPNIC_TQS_DWRR_INIT_QUANTUM) |
+		   MPNIC_TQS_PORT_INIT_CTL_INIT);
+	mpnic_wr64(mpd, MPNIC_TQS_SRAM_INIT_CTL,
+		   FIELD_PREP(MPNIC_TQS_SRAM_INIT_CTL_QUANTUM,
+			      MPNIC_TQS_DWRR_INIT_QUANTUM) |
+		   MPNIC_TQS_SRAM_INIT_CTL_INIT);
+}
+
+static void mpnic_tqs_init(struct mpnic_dev *mpd)
+{
+	u64 val;
+
+	/* Initialize to the largest frame we support, the scheduler
+	 * truncates anything above it. The BMC gets the same limit.
+	 */
+	mpnic_wr64(mpd, MPNIC_TQS_MTU_CTL0, MPNIC_TQS_MTU_CTL0_MAX);
+	mpnic_wr64(mpd, MPNIC_TQS_MTU_CTL1, MPNIC_TQS_MTU_CTL0_MAX);
+
+	mpnic_wr64(mpd, MPNIC_TQS_GLBL_CTL0,
+		   MPNIC_TQS_GLBL_CTL0_TWD_ERROR_CHECK_EN);
+
+	mpnic_tqs_sram_init(mpd);
+
+	/* Only port 0 is used. A single traffic class is in use as well, so
+	 * TC0 gets all of the Tx buffer credits not reserved for the BMC.
+	 */
+	mpnic_wr64(mpd, MPNIC_TQS_GLBL_P0_0,
+		   FIELD_PREP(MPNIC_TQS_GLBL_P0_0_TXB_MAX_CRDTS_0,
+			      MPNIC_TQS_GLBL_TXB_CRDT_MAC));
+	mpnic_wr64(mpd, MPNIC_TQS_GLBL_P0_1, 0);
+	mpnic_wr64(mpd, MPNIC_TQS_GLBL_BMC,
+		   FIELD_PREP(MPNIC_TQS_GLBL_BMC_TXB_MAX_CRDTS,
+			      MPNIC_TQS_GLBL_TXB_CRDT_BMC));
+
+	mpnic_wr64(mpd, MPNIC_TQS_PORT_CTL(0), 0);
+
+	/* Map all sets to port 0 */
+	mpnic_wr64(mpd, MPNIC_TQS_SET_P0_MAP0(0), ~0ULL);
+	mpnic_wr64(mpd, MPNIC_TQS_SET_P0_MAP1(0), ~0ULL);
+
+	mpnic_wr64(mpd, MPNIC_TQS_CEV_MIN_SCHED_THRESH_0,
+		   FIELD_PREP(MPNIC_TQS_CEV_MIN_SCHED_THRESH_0_QUEUE,
+			      MPNIC_TQS_DWRR_CEV_MIN_SCHED_THRESH) |
+		   FIELD_PREP(MPNIC_TQS_CEV_MIN_SCHED_THRESH_0_GROUP,
+			      MPNIC_TQS_DWRR_CEV_MIN_SCHED_THRESH));
+	mpnic_wr64(mpd, MPNIC_TQS_CEV_MIN_SCHED_THRESH_1,
+		   FIELD_PREP(MPNIC_TQS_CEV_MIN_SCHED_THRESH_1_SET,
+			      MPNIC_TQS_DWRR_CEV_MIN_SCHED_THRESH) |
+		   FIELD_PREP(MPNIC_TQS_CEV_MIN_SCHED_THRESH_1_PORT,
+			      MPNIC_TQS_DWRR_CEV_MIN_SCHED_THRESH));
+
+	/* The rate limiters are left uninitialized, so shaping has to stay
+	 * off or nothing would ever get scheduled.
+	 */
+	mpnic_wr64(mpd, MPNIC_TQS_GLBL_SHAPING, MPNIC_TQS_GLBL_SHAPING_DISABLE);
+
+	/* Enable fairness protection (phantom eligibility). Read modify
+	 * write so that the reset default slowdown cycle is preserved.
+	 */
+	val = mpnic_rd64(mpd, MPNIC_TQS_SLOWDOWN_CTL);
+	val |= MPNIC_TQS_SLOWDOWN_CTL_ENABLE;
+	mpnic_wr64(mpd, MPNIC_TQS_SLOWDOWN_CTL, val);
+
+	/* Use immediate credit decrement at every DWRR level so that the
+	 * credit reflects a grant in the same cycle.
+	 */
+	val = mpnic_rd64(mpd, MPNIC_TQS_ARB_CTL);
+	val |= MPNIC_TQS_ARB_CTL_SET_CRDT_BUCKET_EN |
+	       MPNIC_TQS_ARB_CTL_SET_IMM_DECR_EN |
+	       MPNIC_TQS_ARB_CTL_GROUP_CRDT_BUCKET_EN |
+	       MPNIC_TQS_ARB_CTL_GROUP_IMM_DECR_EN |
+	       MPNIC_TQS_ARB_CTL_QUEUE_CRDT_BUCKET_EN |
+	       MPNIC_TQS_ARB_CTL_QUEUE_IMM_DECR_EN;
+	mpnic_wr64(mpd, MPNIC_TQS_ARB_CTL, val);
+}
+
+/* The MPS and CLS fields sit at the same bit positions in every block, so
+ * one set of masks covers both the RNI and the TNI registers.
+ */
+static void mpnic_mps_init(struct mpnic_dev *mpd, u32 reg, unsigned int mps,
+			   unsigned int cls)
+{
+	u64 val = mpnic_rd64(mpd, reg);
+
+	val &= ~(MPNIC_RNI_RDE_CTL_MPS | MPNIC_RNI_RDE_CTL_CLS);
+	val |= FIELD_PREP(MPNIC_RNI_RDE_CTL_MPS, mps) |
+	       FIELD_PREP(MPNIC_RNI_RDE_CTL_CLS, cls);
+
+	mpnic_wr64(mpd, reg, val);
+}
+
+/* Likewise for the MRRS and CLS fields, which have their own common
+ * layout.
+ */
+static void mpnic_mrrs_init(struct mpnic_dev *mpd, u32 reg, unsigned int mrrs,
+			    unsigned int cls)
+{
+	u64 val = mpnic_rd64(mpd, reg);
+
+	val &= ~(MPNIC_TNI_GLBL_TDF_CTL_MRRS | MPNIC_TNI_GLBL_TDF_CTL_CLS);
+	val |= FIELD_PREP(MPNIC_TNI_GLBL_TDF_CTL_MRRS, mrrs) |
+	       FIELD_PREP(MPNIC_TNI_GLBL_TDF_CTL_CLS, cls);
+
+	mpnic_wr64(mpd, reg, val);
+}
+
+/**
+ * mpnic_axi_init - Configure AXI bus parameters from host PCIe capabilities
+ * @mpd: Device to configure
+ *
+ * Programs the max read request size, max payload size and cache line size
+ * of the DMA engines. The hardware encodes all three as a power of 2 index,
+ * MRRS and MPS relative to 128 B and CLS relative to 64 B.
+ *
+ * MAX_OT and MAX_OB are left at their hardware defaults.
+ */
+static void mpnic_axi_init(struct mpnic_dev *mpd)
+{
+	int mps, cls, mrrs;
+
+	mps = clamp(ilog2(mpd->mps) - 7, 0, 3);
+	cls = clamp(ilog2(L1_CACHE_BYTES) - 6, 0, 3);
+
+	mpnic_mps_init(mpd, MPNIC_RNI_RDE_CTL, mps, cls);
+	mpnic_mps_init(mpd, MPNIC_RNI_RCM_CTL, mps, cls);
+	mpnic_mps_init(mpd, MPNIC_TNI_GLBL_TCM_CTL, mps, cls);
+
+	mrrs = clamp(ilog2(mpd->readrq) - 7, 0, 3);
+	mpnic_mrrs_init(mpd, MPNIC_RNI_RBP_CTL, mrrs, cls);
+	mpnic_mrrs_init(mpd, MPNIC_TNI_GLBL_TDF_CTL, mrrs, cls);
+
+	/* TDE supports a wider range of MRRS encodings. */
+	mrrs = clamp(ilog2(mpd->readrq) - 7, 0, 5);
+	mpnic_mrrs_init(mpd, MPNIC_TNI_GLBL_TDE_CTL, mrrs, cls);
+}
+
+/**
+ * mpnic_ro_init - Set relaxed ordering on the outbound TLP attributes
+ * @mpd: Device to configure
+ *
+ * Completions must stay ordered so that they are not observed before the
+ * payload DMA they describe has landed, so RCM and TCM are left alone.
+ */
+static void mpnic_ro_init(struct mpnic_dev *mpd)
+{
+	u64 attr = mpd->relaxed_ord ? MPNIC_OB_ATTR_RO : 0;
+
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDE_H, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDE_P, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDF, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_RBP_HPQ, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_RBP_PPQ, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_RDE_H, attr);
+	mpnic_wr64(mpd, MPNIC_OB_ATTR_RDE_P, attr);
+}
+
+static bool mpnic_init_status_ready(struct mpnic_dev *mpd,
+				    const struct mpnic_init_poll *polls,
+				    struct mpnic_poll_state *state)
+{
+	u64 val;
+	int i;
+
+	for (i = state->poll_idx; polls[i].addr; i++) {
+		val = mpnic_rd64(mpd, polls[i].addr);
+
+		if ((val & polls[i].exp_val) != polls[i].exp_val) {
+			state->poll_idx = i;
+			state->val = val;
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/**
+ * mpnic_mem_init_poll - Wait for the memory initializations to complete
+ * @mpd: Device to poll
+ *
+ * The blocks initialize their memories in parallel, so walk the status
+ * registers in order and only go back to sleep on the first one which is
+ * not done yet.
+ *
+ * Return: 0 on success, -ETIMEDOUT if not everything completed in time
+ */
+static int mpnic_mem_init_poll(struct mpnic_dev *mpd)
+{
+	static const struct mpnic_init_poll polls[] = {
+		{ MPNIC_TQS_ARB_INIT_VAL, MPNIC_TQS_SRAM_STS },
+		{ MPNIC_MEM_INIT_BDQ_VAL, MPNIC_BDQ_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_RCM_VAL, MPNIC_RCM_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_RDE_VAL, MPNIC_RDE_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_RPC_VAL, MPNIC_RPC_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_TCM_VAL, MPNIC_TCM_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_TDE_VAL, MPNIC_TDE_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_TDF_VAL, MPNIC_TDF_MEM_INIT_DONE },
+		{ MPNIC_MEM_INIT_RXB_VAL, MPNIC_RXB_MEM_INIT_DONE },
+		{ 0 },
+	};
+	struct mpnic_poll_state state = {};
+	bool done;
+	int err;
+
+	err = read_poll_timeout(mpnic_init_status_ready, done, done,
+				MPNIC_MEM_INIT_POLL_US, MPNIC_MEM_INIT_TO_US,
+				false, mpd, polls, &state);
+	if (err)
+		dev_err(mpd->dev, "Poll timeout for reg 0x%x: 0x%llx\n",
+			polls[state.poll_idx].addr, state.val);
+
+	return err;
+}
+
+int mpnic_dev_init(struct mpnic_dev *mpd)
+{
+	int err;
+
+	mpnic_tdf_glbl_init(mpd);
+	mpnic_txb_init(mpd);
+	mpnic_rxb_init(mpd);
+	mpnic_desc_sram_init(mpd);
+	mpnic_axi_init(mpd);
+	mpnic_ro_init(mpd);
+	mpnic_rxglb_init(mpd);
+	mpnic_txglb_init(mpd);
+	mpnic_tqs_init(mpd);
+
+	err = mpnic_mem_init_poll(mpd);
+	if (err) {
+		dev_err(mpd->dev, "Device initialization failed: %d\n", err);
+		return err;
+	}
+
+	if (!mpnic_present(mpd))
+		return -EIO;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 96393e781241..68a64377e6c5 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -58,6 +58,10 @@ static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, mpd);
 	mpd->dev = &pdev->dev;
 
+	mpd->mps = pcie_get_mps(pdev);
+	mpd->readrq = pcie_get_readrq(pdev);
+	mpd->relaxed_ord = pcie_relaxed_ordering_enabled(pdev);
+
 	return mpd;
 }
 
@@ -108,6 +112,10 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
+	err = mpnic_dev_init(mpd);
+	if (err)
+		goto err_free_mpd;
+
 	return 0;
 
 err_free_mpd:

-- 
2.52.0

