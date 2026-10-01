Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF43DECF
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827995; cv=none; b=P29yA7ECHh5QnUJCRo2szusBiCTeRDCDL/Ly6k/z2L74YPfR/NKFl3xC4YyYyPqbZLBHHgOGCv4w4VjQiQanP1XO0kQQCarZBtoENdDWI1EMTk5oUvPtLa5SnQgWUwjEILn83uiXLAo4Ygjc/Y/YZs+0TnCpHlejZgn0IubB98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827995; c=relaxed/simple;
	bh=JqVHAPj89HWa81+we6BZBLt0+rQ7wmAZgK8lTwYGnbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npkmwSAp8z5NsqH+Gfs3QgI/TpH1+P4Z22wiWVfPujtB+WAXZMr8wfEs6HyT4WcKiaAmRhl+ZI07UJwRX96FNGFnTsGwsHH/fasc/lFgM9WM0RH3HgY10h0yWXB/mGrFE/hmF6cen9B39phm1T+2zNL9QRTCrFnu4sWFja92ADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7w2BVlF; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7w2BVlF"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so3760301a34.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827982; x=1791432782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aw44SwDO/yC3GpJxvHwdzqMal7Qk8ZwfQ5Su1z/QvHY=;
        b=U7w2BVlFLFmLjJjQmHD6YUgLFw4F+2DkTskH49yd7OhOPgF0lDHYg8YVd1zr6dZf/5
         zeTzbjd6D/IQdl1SzHwomxTdZbJWaGaS1wDCQvEg/kaL7EEGLyRKFoT4wYRnc8qjcJWo
         i4EUlguPKJnnoCHjunfp3rcmmV2KaL/ShAGDUP3reK92uqnvkdwr/2R7ixNOa9ed4jym
         ui2K3fl15bJf1qlS/wjP87LMjip3+C7VGAzxJKJ79yLmteMzcAgc9C3wi1xH//QZoJ5x
         kqpigSda0I9LN+Pg0QzWOJItuGQdZKipkKjEP0sth5nP1lv/jdi+oITa0F9YTdKx0JiI
         9VWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827982; x=1791432782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw44SwDO/yC3GpJxvHwdzqMal7Qk8ZwfQ5Su1z/QvHY=;
        b=KOP7ykhiOMPCihwxvyTMEHZ294KbKig9puP6YLNogxx6kllbEg6d/iePZZTV3fRNCx
         odU0kNERFBoaV7MdhqkH5KiRDm/tp69cYLUmlkjC0aWgQN7Gp78q3TAXgJjFMNeJrjs/
         eBbNztGxVPJ7CLs5AJVbAPhGLp8LXmzs2A4ShGRHrjA9sFM2Wu4UCfNeygybMH1H8g/i
         o9znT/nyVStg0pYXxVdo+EkiLGlhcm/Kl4k/O3KsF6m426NOiPCjKiZwm0h2tXoWMu60
         NvTbdS9KBrNXrbXQ7cDe4Wf1PDZgELnhpN1tXZ9J8AdUBX46pEryxNlojJUUQAOgvDYE
         tYwg==
X-Forwarded-Encrypted: i=1; AKwUvBx+DjB+HHziXEVquIOBqvwrH9ZQOmqxA1Ta575pcDzqbI5fj1c9CYD9fKoKqAIiyC1CKBM=@vger.kernel.org
X-Gm-Message-State: AFuF++lnc86xYuowr74fpWNzxqXfYDP1NuMr84Xea+siSp23GVdK5LqW
	HY+osW3PD3QIzo81VNWn8R2Dt955TfNZD5vFJStyenxyt+NYv0OpNg+Y
X-Gm-Gg: AYBFou3OVL/r41x8nPAoA9M3gUQWvZLxJKJjkGtl82L95TvGSZMu5/fKPGeS9JIioLo
	NRmheQruJzdD+xiRnfSpMqieKstreXIhmjlsiq9Og4qgXtPb6VisPJVDyq6Fzwfs88GUNXghghe
	Xvibw4OnWKVBJm69YVI/y4LJ4Xs3QvOF0XdEnMEUHrqxG7H3hjY0R9SSNbnFe+ik0UEkPwd9nve
	oQ6jI7MFgmPGhRdVMZqCxDIBxoiUHnhKusYSFx25+r0cTbeSnDEY1MCv9++5Z86GQK4a54go7RG
	39X5aKuOXuckbWb30WDRh6GXqU3R9F2wmxzO1VMuVYx+A1MJyc55+jKwkY3RCi5taUHlVH6RxqG
	usKntpFVY5l9/8yv6e9mtCaNrCErF6JQWmFKHB0fxwTKE2SRxC6fyJQfv4zFmSiLdR5iNdp1p1g
	hlYrW3a4W9PEX2QASuv/sgixY3cb6/5ApbtHK0wWG0GcSLhggyH0LLd2NKFHLlzAQODD1bE3Dy0
	VCUCABrlBa/MTLsZWQWQNxNqNCcGgpKfS/ZYV+USCMFGI53dKQwZPrCRF/u7RYIVvMQRGrNwT2K
	+L9UPzBj+yvStc59swb1b7Dxn1sm0WXDwN4Yy5Dip/qwhEDTbsIJ8OyVt+8iGx/JKrhiMmsXv8o
	1Zfi8w3VDfTr082O3EG5X
X-Received: by 2002:a05:6830:6a8b:b0:81b:a5aa:e82b with SMTP id 46e09a7af769-8204a43ba8emr4004205a34.24.1790827981820;
        Wed, 30 Sep 2026 21:13:01 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:13:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:12:51 -0600
Subject: [PATCH net-next v4 3/4] net: stmmac: preserve the installed EST
 schedule on errors
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-3-9d4366587b73@gmail.com>
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
In-Reply-To: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.15.2

TAPRIO replacement clears the installed EST cache before validating
all entries. An invalid interval can leave enable set with a zero
cycle time. A later PHC adjustment then divides by zero while
calculating the next base time.

Build and validate a separate schedule and publish it only after
hardware setup succeeds. If setup fails, restore the installed
schedule using a base time advanced by whole cycles, not the expired
base time from its original installation.

Use the same checked clock-read and programming helper for new
schedules, rollback and PHC adjustment. Hold est_lock throughout a
clock step and return disable, adjustment or replay errors. Attempt
to rearm the schedule even when the clock update fails.

Based on the schedule replay helper in Lorenzo Bianconi's EST work.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c |  41 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h |  13 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c |  57 ++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 113 ++++++++++++-----------
 4 files changed, 134 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index f15d4d046aa7..15c2d1794e22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,47 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+/* Program either the installed schedule or an unpublished replacement. */
+int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	unsigned long flags;
+	u64 now;
+	u64 cycle_time;
+	int err;
+
+	lockdep_assert_held(&priv->est_lock);
+
+	if (!priv->ptp_enabled)
+		return -EOPNOTSUPP;
+
+	read_lock_irqsave(&priv->ptp_lock, flags);
+	err = stmmac_get_systime(priv, priv->ptpaddr, &now);
+	read_unlock_irqrestore(&priv->ptp_lock, flags);
+	if (err)
+		return err;
+	current_time = ns_to_timespec64(now);
+	current_time_ns = timespec64_to_ktime(current_time);
+
+	time.tv_nsec = est->btr_reserve[0];
+	time.tv_sec = est->btr_reserve[1];
+	basetime = timespec64_to_ktime(time);
+
+	cycle_time = (u64)est->ctr[1] * NSEC_PER_SEC + est->ctr[0];
+
+	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
+	est->btr[0] = (u32)time.tv_nsec;
+	est->btr[1] = (u32)time.tv_sec;
+
+	err = stmmac_est_configure(priv, priv, est,
+				   priv->plat->clk_ptp_rate, true);
+	if (err)
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+
+	return err;
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..5665e7a53994 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -65,3 +65,16 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est);
+static inline int stmmac_setup_est(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	mutex_lock(&priv->est_lock);
+	if (priv->est.enable)
+		ret = __stmmac_setup_est(priv, &priv->est);
+	mutex_unlock(&priv->est_lock);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 64d890664421..05c7e15fcb2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -8,6 +8,7 @@
   Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
 *******************************************************************************/
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_ptp.h"
 
 #define PTP_SAFE_TIME_OFFSET_NS	500000
@@ -54,8 +55,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	u32 sec, nsec;
 	u32 quotient, reminder;
 	int neg_adj = 0;
-	bool xmac, est_rst = false;
-	int ret;
+	bool xmac;
+	int ret, err;
 
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
@@ -68,49 +69,31 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	sec = quotient;
 	nsec = reminder;
 
-	/* If EST is enabled, disabled it before adjust ptp time. */
+	/* Keep the installed schedule stable across the entire clock step. */
+	mutex_lock(&priv->est_lock);
 	if (priv->est.enable) {
-		est_rst = true;
-		mutex_lock(&priv->est_lock);
-		priv->est.enable = false;
-		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate, false);
-		mutex_unlock(&priv->est_lock);
+		ret = stmmac_est_configure(priv, priv, &priv->est,
+					   priv->plat->clk_ptp_rate, false);
+		if (ret)
+			goto out_unlock;
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
+	ret = stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
-	/* Calculate new basetime and re-configured EST after PTP time adjust. */
-	if (est_rst) {
-		struct timespec64 current_time, time;
-		ktime_t current_time_ns, basetime;
-		u64 cycle_time;
-
-		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est.btr_reserve[0];
-		time.tv_sec = priv->est.btr_reserve[1];
-		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC +
-			     priv->est.ctr[0];
-		time = stmmac_calc_tas_basetime(basetime,
-						current_time_ns,
-						cycle_time);
-
-		priv->est.btr[0] = (u32)time.tv_nsec;
-		priv->est.btr[1] = (u32)time.tv_sec;
-		priv->est.enable = true;
-		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate, true);
-		mutex_unlock(&priv->est_lock);
-		if (ret)
-			netdev_err(priv->dev, "failed to configure EST\n");
+	/* Also try to restore EST after a failed clock update. Keep the first
+	 * error, but do not report success if only schedule replay failed.
+	 */
+	if (priv->est.enable) {
+		err = __stmmac_setup_est(priv, &priv->est);
+		if (!ret)
+			ret = err;
 	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&priv->est_lock);
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 67c6fc32d0ea..58dda3282973 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -10,6 +10,7 @@
 #include "dwmac4.h"
 #include "dwmac5.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
@@ -942,7 +943,7 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 	return time;
 }
 
-static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
+static void tc_taprio_map_maxsdu_txq(struct stmmac_est *est,
 				     struct tc_taprio_qopt_offload *qopt)
 {
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
@@ -959,7 +960,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est.max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -968,10 +969,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
-	struct timespec64 time, current_time, qopt_time;
-	ktime_t current_time_ns;
-	int err, i, ret = 0;
-	u64 ctr;
+	struct timespec64 qopt_time;
+	u64 ctr = qopt->cycle_time;
+	struct stmmac_est *est;
+	int i, ret, err;
 
 	if (qopt->base_time < 0)
 		return -ERANGE;
@@ -979,6 +980,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (!priv->dma_cap.estsel)
 		return -EOPNOTSUPP;
 
+	if (ctr > (u64)U32_MAX * NSEC_PER_SEC)
+		return -ERANGE;
+
 	switch (wid) {
 	case 0x1:
 		wid = 16;
@@ -1015,6 +1019,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
+	if (!priv->ptp_enabled || !priv->ptp_clock_ops.gettime64)
+		return -EOPNOTSUPP;
 
 	if (qopt->num_entries > dep)
 		return -EINVAL;
@@ -1023,25 +1029,27 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	mutex_lock(&priv->est_lock);
-	memset(&priv->est, 0, sizeof(priv->est));
-	mutex_unlock(&priv->est_lock);
+	/* Build the replacement without changing the installed schedule. An
+	 * entry rejected below must not leave an enabled, zero-cycle cache for
+	 * PHC adjustment or reset replay to consume.
+	 */
+	est = kzalloc_obj(*est);
+	if (!est)
+		return -ENOMEM;
 
 	size = qopt->num_entries;
-
-	mutex_lock(&priv->est_lock);
-	priv->est.gcl_size = size;
-	priv->est.enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->est_lock);
+	est->gcl_size = size;
+	est->enable = true;
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0))
-			return -ERANGE;
-		if (gates > GENMASK(31 - wid, 0))
-			return -ERANGE;
+		if (delta_ns > GENMASK(wid - 1, 0) ||
+		    gates > GENMASK(31 - wid, 0)) {
+			ret = -ERANGE;
+			goto free_est;
+		}
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
@@ -1053,55 +1061,56 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			gates &= ~BIT(0);
 			break;
 		default:
-			return -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
+			goto free_est;
 		}
 
-		priv->est.gcl[i] = delta_ns | (gates << wid);
+		est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->est_lock);
-	/* Adjust for real system time */
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-	current_time_ns = timespec64_to_ktime(current_time);
-	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
-					qopt->cycle_time);
-
-	priv->est.btr[0] = (u32)time.tv_nsec;
-	priv->est.btr[1] = (u32)time.tv_sec;
-
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est.btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est.btr_reserve[1] = (u32)qopt_time.tv_sec;
-
-	ctr = qopt->cycle_time;
-	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est.ctr[1] = (u32)ctr;
+	est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	est->ctr[1] = (u32)ctr;
+	est->ter = qopt->cycle_time_extension;
 
-	priv->est.ter = qopt->cycle_time_extension;
+	tc_taprio_map_maxsdu_txq(est, qopt);
 
-	tc_taprio_map_maxsdu_txq(priv, qopt);
-
-	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate, true);
-	mutex_unlock(&priv->est_lock);
-	if (ret) {
-		netdev_err(priv->dev, "failed to configure EST\n");
-		goto disable;
-	}
+	mutex_lock(&priv->est_lock);
+	ret = __stmmac_setup_est(priv, est);
+	if (ret)
+		goto restore;
 
 	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
-					      qopt->mqprio.preemptible_tcs);
+					     qopt->mqprio.preemptible_tcs);
 	if (ret)
-		goto disable;
+		goto restore;
 
-	return 0;
+	priv->est = *est;
+	mutex_unlock(&priv->est_lock);
+free_est:
+	kfree(est);
+	return ret;
+
+restore:
+	/* A failed hardware update must not publish the rejected schedule. */
+	if (priv->est.enable)
+		err = __stmmac_setup_est(priv, &priv->est);
+	else
+		err = stmmac_est_configure(priv, priv, &priv->est,
+					   priv->plat->clk_ptp_rate, false);
+	if (err)
+		netdev_err(priv->dev, "failed to restore EST\n");
+	mutex_unlock(&priv->est_lock);
+	goto free_est;
 
 disable:
 	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
 			     priv->plat->clk_ptp_rate, false);
-	/* Reset taprio status */
+	/* Reset taprio stats */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;
 		priv->xstats.mtl_est_txq_hlbf[i] = 0;
@@ -1109,9 +1118,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	}
 	mutex_unlock(&priv->est_lock);
 
-	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
-
-	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
+	return stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 }
 
 static void tc_taprio_stats(struct stmmac_priv *priv,

-- 
2.53.0

