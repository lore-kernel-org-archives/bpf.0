Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB534BA50
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296543; cv=none; b=iFiKiqq5rcJZN9Ak3z9wOyst4Q5H1eCnBlYWxlrgJVeOeLKfsqLcdiii8lsoMnsghnGAagElanX8tRPP6CeiaXCJFcp+JrljS9Rix0e5j5oaqGL0RL7KDRhHHy1JYjpYdZOMo36q0qbSwO/i163iWBJyBzRdmQQ8w5BPUAfryMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296543; c=relaxed/simple;
	bh=jZnDdleH/Byx/keWvs6ljHD8KcvWbbNghj3/gAaF6ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj7223W/fxmB34i5Z4xEED/KqW0r8kktSFwJxNqFBsRbKrGYyqMLMfzXjiORZuDQGlu2t82WKuvJxToCsRfOiN4oe8A3O2RsPvPTQ5ZaCu7AdYKiVvxcGc1XaOJaQBkMnHJ0eF/yNvK2jwCaAjAS37LfDJpACv2EPr/NBZYQxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfT6zuy9; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfT6zuy9"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-8177a7fc354so182345a34.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296540; x=1790901340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tLAlq4g8XPAUTdrakeC8GC7UE6/N3opUCGWzik/CGs=;
        b=DfT6zuy9CxbXM/LmIGCumMUsM8TegwQFLHnwR5KlgMmIO8NHAnkfTsfmdgzmPT2kmE
         9LrxAGJT/3YlXosJEuneh7ffl/8K8i1M9SN8A1dIrsDQKINEolaomUMwF5R1dKvX7MNz
         4MdeKf/iwl47yvihOwG4R0mdHS+K2M4g+8Vx0Ahuvw20RutnkBtwUsMElO2LXABrn0WC
         I4O5Tn0lp1gAE6MLOdd2cVNikVJQgeLcG8gt27890LwWdfLCWaDHj322U7cCx/ATXdyW
         vD2TRlfK54pZR/YeUbSZZCpOxvy/lAE8zMsB5/iBWz/OA4wKovT2UwDYrZMOeIWMDMyZ
         a8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296540; x=1790901340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tLAlq4g8XPAUTdrakeC8GC7UE6/N3opUCGWzik/CGs=;
        b=CEcKEY8XqFTLz/RrKk/XIdONf74RmN41p6RBUchPncBpxM5uAnWyB3r7KqaqtV0eUO
         RFcrGSpKzswCcppQm40p42lizxJWSOYuHBIWJ3+oL5vhwWsm6zubEJSHNd0saA9pb0rD
         5ZOxO3XB9mts3/28nQC9bAskHysbOq85xLbZOzfQMkcLS6XZ6hm8EQv3v902waA0DRvK
         S/37Pjcvn5MNssQfDgrLVPMWPqMOCRhqfjorl4GROK+WwHRvHVFeRtYDdeA3UEWp0wGk
         V8+JasxkjUevsajPkCEUnqZstzJikbq11y1Vs6YQtxOw1o7owm9aTgPTE2GS4iVxLLyZ
         C/hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLg1kac3nckV2h5aGn3s17ohjYvAjpui+24GMRVhqoA7AwaTXvkcwa2OrlYNsB3VxgXzk=@vger.kernel.org
X-Gm-Message-State: AFuF++mVkaimiF+Mr4YDDhxK99FZvfFtbjLkum0kKuw70k4becBp9Bcq
	6wdEAxMM/ItoVBUOEt1TH+Tc/FcG15WjDJr775Q5QLe2lSBTY3t1iMrk
X-Gm-Gg: AYBFou1JQLWSeI/iN3f1gBd3KlIJWMg1j+0RL+ermYz1TZFCkRFDFMMrwhDrh9IbMfu
	HivEj7pyDt6jv2pDaY7ghw235+uxf3ePVXMzFA4r5KkgLz4ohNB5yJO4z88iKejdFCiPXMK5Io1
	iaSFs1D/DEStYlCgKULRnZP+GeTnBnHxb3pSSE/ytxP6qo0c7YlrEZQRwQBKzvQza6FFHCkbYYb
	FODrrFL2kc22J2w+MoKiG+9ykxfIoEz3jdVpy86ufAt4v1NfNxovKmURuX2ebJkAzhGumJ9roo/
	ml+OG1OoyObdNaFSCQTi24wzpH0g18PnEEv2GRoBW1Nf0cOmAIeKxEfVe/AQI6a0VSwYlibkD0L
	jGlUVTDw9CxdVZa2AHveY63Wy0JRAEehTIHH0Ey4naWVHhEtUC0ucc8rElws4ov5lgFRLtNV2BA
	jiIrjiql8XQSJsQ6ayrVJgNiPtlARxKWUTN1LuLGm1Jr6XoxAvpDAeokcR1VwxkHmJJZs=
X-Received: by 2002:a05:6830:3784:b0:804:d4b0:a36 with SMTP id 46e09a7af769-81783697cb5mr4172436a34.27.1790296540622;
        Thu, 24 Sep 2026 17:35:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e8055020sm966535a34.7.2026.09.24.17.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:39 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:18 -0700
Subject: [PATCH net-next v2 5/8] eth: mpnic: start and stop the Tx HW
 queues
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
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

Point the hardware at the descriptor rings and provide functions for
turning the Tx queues on and off.

Teardown has to wait for the DMA engines to go idle before the ring
memory can be freed: disabling a queue only stops the device picking up
new work, it does not tell us that the work already fetched has been
retired. Each block exposes an idle bitmap per queue, and every one of
the four blocks a packet passes through on its way out has to report
idle before the descriptors are safe to free.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h  |  28 +++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 175 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h |   4 +
 3 files changed, 207 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index adf81b5ef49c..44ff664e3f3b 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -36,11 +36,26 @@
  *****************************************************************************/
 
 /* NIC_CORE_TDF */
+#define MPNIC_TWQ_CTL(i, j)		(0x0 + 1024 * (i) + 2 * (j))
+								/* 0x0 */
+#define MPNIC_TWQ_CTL_RESET			CSR_BIT(0)
+#define MPNIC_TWQ_CTL_ENABLE			CSR_BIT(1)
 #define MPNIC_TWQ_TAIL(i, j)		(0x4 + 1024 * (i) + 2 * (j))
 								/* 0x10 */
+#define MPNIC_TWQ_SIZE(i, j)		(0x10 + 1024 * (i) + 2 * (j))
+								/* 0x40 */
+#define MPNIC_TWQ_SIZE_SIZE			CSR_GENMASK(3, 0)
+#define MPNIC_TWQ_BASE_ADDR(i, j)	(0x1c + 1024 * (i) + 2 * (j))
+								/* 0x70 */
 
 /* NIC_CORE_TCM */
+#define MPNIC_TCQ_CTL(i)		(0x80 + 1024 * (i))	/* 0x200 */
+#define MPNIC_TCQ_CTL_RESET			CSR_BIT(0)
+#define MPNIC_TCQ_CTL_ENABLE			CSR_BIT(1)
+#define MPNIC_TCQ_BASE_ADDR(i)		(0x86 + 1024 * (i))	/* 0x218 */
 #define MPNIC_TCQ_HEAD(i)		(0x8e + 1024 * (i))	/* 0x238 */
+#define MPNIC_TCQ_SIZE(i)		(0x94 + 1024 * (i))	/* 0x250 */
+#define MPNIC_TCQ_SIZE_SIZE			CSR_GENMASK(4, 0)
 
 /* NIC_CORE_TIM */
 #define MPNIC_TIM_CTL1(i)		(0xc0 + 1024 * (i))	/* 0x300 */
@@ -50,6 +65,11 @@
 #define MPNIC_TIM_CTL1_MASK			CSR_BIT(51)
 #define MPNIC_TIM_CTL1_MASK_EN			CSR_BIT(52)
 #define MPNIC_TIM_CTL1_TRIGGER			CSR_BIT(53)
+#define MPNIC_TIM_INTR_MASK(i)		(0xc8 + 1024 * (i))	/* 0x320 */
+#define MPNIC_TIM_INTR_MASK_MASK		CSR_BIT(0)
+
+/* NIC_CORE_TIM_PRV */
+#define MPNIC_TIM_CTL(i)		(0x100100 + 1024 * (i))	/* 0x400400 */
 
 /* NIC_CORE_RBP_HP_GLBL */
 #define MPNIC_BDQ_GLBL_CTL0		0x420080		/* 0x1080200 */
@@ -83,6 +103,8 @@
 #define MPNIC_RNI_RCM_CTL		0x427004		/* 0x109c010 */
 
 /* NIC_CORE_TDF_GLBL */
+#define MPNIC_TWQ_IDLE(i)		(0x428042 + 2 * (i))	/* 0x10a0108 */
+#define MPNIC_TWQ_IDLE_CNT		32
 #define MPNIC_TWQ_DEF_PRI_TWD		0x428082		/* 0x10a0208 */
 #define MPNIC_TDF_MEM_INIT_REQ		0x42813a		/* 0x10a04e8 */
 #define MPNIC_TDF_MEM_INIT_DONE		0x42813c		/* 0x10a04f0 */
@@ -100,6 +122,8 @@
 #define MPNIC_TQS_SLOWDOWN_CTL_ENABLE		CSR_BIT(6)
 #define MPNIC_TQS_MTU_CTL0		0x42a030		/* 0x10a80c0 */
 #define MPNIC_TQS_MTU_CTL1		0x42a032		/* 0x10a80c8 */
+#define MPNIC_TQS_IDLE(i)		(0x42a040 + 2 * (i))	/* 0x10a8100 */
+#define MPNIC_TQS_IDLE_CNT		32
 #define MPNIC_TQS_SET_P0_MAP0(i)	(0x42a082 + 2 * (i))	/* 0x10a8208 */
 #define MPNIC_TQS_SET_P0_MAP1(i)	(0x42a092 + 2 * (i))	/* 0x10a8248 */
 #define MPNIC_TQS_GLBL_SHAPING		0x42a108		/* 0x10a8420 */
@@ -135,10 +159,14 @@
 #define MPNIC_TQS_PORT_CTL(i)		(0x42a1e4 + 2 * (i))	/* 0x10a8790 */
 
 /* NIC_CORE_TDE_GLBL */
+#define MPNIC_TDE_IDLE(i)		(0x42b000 + 2 * (i))	/* 0x10ac000 */
+#define MPNIC_TDE_IDLE_CNT		32
 #define MPNIC_TDE_MEM_INIT_REQ		0x42b1ee		/* 0x10ac7b8 */
 #define MPNIC_TDE_MEM_INIT_DONE		0x42b1f0		/* 0x10ac7c0 */
 
 /* NIC_CORE_TCM_GLBL */
+#define MPNIC_TCQ_IDLE(i)		(0x42c09e + 2 * (i))	/* 0x10b0278 */
+#define MPNIC_TCQ_IDLE_CNT		16
 #define MPNIC_TCM_MEM_INIT_REQ		0x42c0be		/* 0x10b02f8 */
 #define MPNIC_TCM_MEM_INIT_DONE		0x42c0c0		/* 0x10b0300 */
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 853976e11b03..aaa3a3e99a13 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -3,6 +3,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -467,6 +468,180 @@ void mpnic_reset_netif_queues(struct mpnic_net *mpn)
 	}
 }
 
+static void mpnic_enable_twq(struct mpnic_dev *mpd, struct mpnic_ring *twq)
+{
+	u32 log_size = fls(twq->size_mask);
+	u32 i = twq->q_idx;
+
+	/* Reset head/tail */
+	mpnic_wr64(mpd, MPNIC_TWQ_CTL(i, 0), MPNIC_TWQ_CTL_RESET);
+	twq->tail = 0;
+	twq->head = 0;
+	twq->deferred_meta = -1;
+
+	/* Store descriptor ring address and size */
+	mpnic_wr64(mpd, MPNIC_TWQ_BASE_ADDR(i, 0), twq->dma);
+	mpnic_wr64(mpd, MPNIC_TWQ_SIZE(i, 0), log_size & MPNIC_TWQ_SIZE_SIZE);
+
+	mpnic_wr64(mpd, MPNIC_TWQ_CTL(i, 0), MPNIC_TWQ_CTL_ENABLE);
+}
+
+static void mpnic_enable_tcq(struct mpnic_dev *mpd,
+			     struct mpnic_napi_vector *nv,
+			     struct mpnic_ring *tcq)
+{
+	u32 log_size = fls(tcq->size_mask);
+	u32 i = tcq->q_idx;
+
+	/* Reset head/tail */
+	mpnic_wr64(mpd, MPNIC_TCQ_CTL(i), MPNIC_TCQ_CTL_RESET);
+	tcq->tail = 0;
+	tcq->head = 0;
+
+	/* Store descriptor ring address and size */
+	mpnic_wr64(mpd, MPNIC_TCQ_BASE_ADDR(i), tcq->dma);
+	mpnic_wr64(mpd, MPNIC_TCQ_SIZE(i), log_size & MPNIC_TCQ_SIZE_SIZE);
+
+	/* Store interrupt information for the completion queue */
+	mpnic_wr64(mpd, MPNIC_TIM_CTL(i), nv->v_idx);
+	mpnic_wr64(mpd, MPNIC_TIM_INTR_MASK(i), 0);
+
+	mpnic_wr64(mpd, MPNIC_TCQ_CTL(i), MPNIC_TCQ_CTL_ENABLE);
+}
+
+void mpnic_enable(struct mpnic_net *mpn)
+{
+	struct mpnic_dev *mpd = mpn->mpd;
+	int i, j;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0; j < nv->txt_count; j++) {
+			mpnic_enable_twq(mpd, &nv->qt[j].sub0);
+			mpnic_enable_tcq(mpd, nv, &nv->qt[j].cmpl);
+		}
+	}
+
+	mpnic_wrfl(mpd);
+}
+
+static void mpnic_disable_twq(struct mpnic_dev *mpd, struct mpnic_ring *txr)
+{
+	u64 twq_ctl = mpnic_rd64(mpd, MPNIC_TWQ_CTL(txr->q_idx, 0));
+
+	twq_ctl &= ~MPNIC_TWQ_CTL_ENABLE;
+	mpnic_wr64(mpd, MPNIC_TWQ_CTL(txr->q_idx, 0), twq_ctl);
+}
+
+static void mpnic_disable_tcq(struct mpnic_dev *mpd, struct mpnic_ring *txr)
+{
+	mpnic_wr64(mpd, MPNIC_TCQ_CTL(txr->q_idx), 0);
+	mpnic_wr64(mpd, MPNIC_TIM_INTR_MASK(txr->q_idx),
+		   MPNIC_TIM_INTR_MASK_MASK);
+}
+
+void mpnic_disable(struct mpnic_net *mpn)
+{
+	struct mpnic_dev *mpd = mpn->mpd;
+	int i, j;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0; j < nv->txt_count; j++) {
+			mpnic_disable_twq(mpd, &nv->qt[j].sub0);
+			mpnic_disable_tcq(mpd, &nv->qt[j].cmpl);
+		}
+	}
+
+	mpnic_wrfl(mpd);
+}
+
+struct mpnic_idle_regs {
+	u32 reg_base;
+	u8 reg_cnt;
+	char name[4];
+};
+
+static u32 mpnic_non_idle_queues(struct mpnic_dev *mpd,
+				 const struct mpnic_idle_regs *regs,
+				 unsigned int nregs)
+{
+	u32 non_idle_bitmap = 0;
+	unsigned int i, j;
+
+	for (i = 0; i < nregs; i++) {
+		for (j = 0; j < regs[i].reg_cnt; j++) {
+			if (mpnic_rd64(mpd, regs[i].reg_base + 2 * j) !=
+			    ~0ULL) {
+				non_idle_bitmap |= BIT(i);
+				break;
+			}
+		}
+	}
+
+	return non_idle_bitmap;
+}
+
+static void mpnic_idle_dump(struct mpnic_dev *mpd,
+			    const struct mpnic_idle_regs *regs,
+			    unsigned int nregs, u32 non_idle_bitmap, int err)
+{
+	unsigned int i, j;
+
+	dev_err(mpd->dev, "error waiting for queues idle %d\n", err);
+	for (i = 0; i < nregs; i++) {
+		if (!(non_idle_bitmap & BIT(i)))
+			continue;
+
+		dev_err(mpd->dev, "%s block not idle:\n", regs[i].name);
+		for (j = 0; j < regs[i].reg_cnt; j++)
+			dev_err(mpd->dev, "  0x%04x: %016llx\n",
+				regs[i].reg_base + 2 * j,
+				mpnic_rd64(mpd, regs[i].reg_base + 2 * j));
+	}
+}
+
+void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
+{
+	static const struct mpnic_idle_regs queues[] = {
+		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
+		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
+		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
+		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
+	};
+	u32 non_idle_bitmap;
+	int err;
+
+	err = read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
+				!non_idle_bitmap, 20, 500000, false, mpd,
+				queues, ARRAY_SIZE(queues));
+	if (err)
+		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
+				non_idle_bitmap, err);
+}
+
+void mpnic_flush(struct mpnic_net *mpn)
+{
+	int i, j;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0; j < nv->txt_count; j++) {
+			struct mpnic_q_triad *qt = &nv->qt[j];
+			struct netdev_queue *txq;
+
+			/* Clean the work queue of unprocessed work */
+			mpnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+
+			txq = netdev_get_tx_queue(mpn->netdev, qt->sub0.q_idx);
+			netdev_tx_reset_queue(txq);
+		}
+	}
+}
+
 void mpnic_napi_disable(struct mpnic_net *mpn)
 {
 	int i;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 0d4667666b5b..68a773133fa2 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -76,5 +76,9 @@ int mpnic_set_netif_queues(struct mpnic_net *mpn);
 void mpnic_reset_netif_queues(struct mpnic_net *mpn);
 void mpnic_napi_enable(struct mpnic_net *mpn);
 void mpnic_napi_disable(struct mpnic_net *mpn);
+void mpnic_enable(struct mpnic_net *mpn);
+void mpnic_disable(struct mpnic_net *mpn);
+void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd);
+void mpnic_flush(struct mpnic_net *mpn);
 
 #endif /* _MPNIC_TXRX_H_ */

-- 
2.52.0

