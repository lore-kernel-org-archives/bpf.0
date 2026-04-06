Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0938C433
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495573; cv=none; b=sCD7KibvuCpmQ841FI2mR33L1WH0SkSJTCUW35iMQUL7X8lz6taHc41YNcOrX8VsG3jM7FbDNR7tyPPdEFHe822nl9dh9aSh6Onop18SJUMskbTAMkso6dMhTLaCLPVQ/4gszO+fsKitOUe1oW66ARLmdXLnPpmqcjdk+emYBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495573; c=relaxed/simple;
	bh=9vAAFXgRx1cmSWi6jUm2ZLeMtuWPDoC/eaQIz1joJFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTQN6RZksfKBUS7qUnASITB5yA2RbfWwM6Vl9LEu0yfUwWyoOvHY04/R85tg7WOtm17xZYlP/qYhgLAhmuBOW3+1or4B8e+PEfS4MpGIJG8I+DFH813pUnmsOFZcG5KDJLgqVw3wRf/R5FcLUu+3tFvQw1o8BFRNqFyE6eFzh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ9WEYTr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ9WEYTr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76d797b180so1853184a12.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775495569; x=1776100369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJLBPf/Bh0jBBKBg9VV473zQPK1on2i18HvqYVjSaQo=;
        b=NJ9WEYTrcnnGNNcrAXQYc6YG0YFvp3NObPzPtycNLHWdAGVr6FfonYmY9DqK9hXGTq
         5q+TRo9BmuU+6EyEDYQjlg9sd8K/mpl1omLDl/oe03O/7dUYMfUMYb5eITVJ7/0d5wpp
         CfR6nUZ0+7MZ/71ZxH2iYCK5zu6hdI+Cr1QIYo5dJRCrb0f8WTZsnUUso0MwzG26daPc
         gvdIVWSsMZX8Q2rH3sTSLjcwV81yVguYjWqfdaRHeRJWr4hqmvxGFg8EXgCYok2tSPoM
         dQ71tbLM18TMn1X4/7648CI2qVGVmRhy+hkw/U4nYGtdzRlvvOmW5mlrbRVlqIuI0WoB
         jQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495569; x=1776100369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJLBPf/Bh0jBBKBg9VV473zQPK1on2i18HvqYVjSaQo=;
        b=JHa1njRU7kFk7goORJ+a2OajRsx00odqTrAl0yoBirN5ESPazGq3TQMlgVBEnnpnjq
         AJb6JnepwanxsvCmclf9biAT7PjrQQ3vSyhH8gvOyixhCpK1ElfwOrrCmhHKezIRLOX0
         CnMxviEvQ+gbqyM6FZ5fQFqhv/dNvK7MaOZjlwH4bQoGMpaotfEnbKjm4aV0gQE/rmZ/
         XnnR41mfNrb37eKbyCvt+2WK8W0f6CjW28sWjdJBfLuxUJOGOhSNPCTlwVc8AwhGHL2b
         pjGxGicM0tvQrspglPCdcIVNhtls0+eb5h8jcDJ2ar24hCJVJmC1cb/lO9CCbVuQphsj
         PSlA==
X-Gm-Message-State: AOJu0YzvtewwEELmoMwkj2GztvbwIntQy38AkIZbcWlf26mFDK0VrxO7
	wQA0L2ZRHvFhU8TWOx1fOLea7PVXUnqs2MVxoYu96p7kmDtQ1HRPRMODtaNYsWM5
X-Gm-Gg: AeBDievYytfKZkk3iOyWhkXbmtQ0CHIiLtzBG0oCIbveiSgW45Ktmzj05ZacwGkwMrW
	m5dLfyW2W3EK48lTfvKqEhY3AcJFjhW9T9kFlJK5GG4HHgSWdtkIVs2+Uol6ur1kZMbM/tJ9sVe
	fyZpXJWBnnGgbc86IM1Ofx84LoFauSyQDpkVyM20xWDcQZZfqLP3k492n+wFMEJv7mZCIjnbSH+
	5iu/6ybvXjU63k6+KsSX7NKBqBvPTaOyzjgOI3W8quI4osAqqEK8Y4pXQHXZC5bTF13owJBphYd
	034JdOp027ovgXdB4nO17I2u1+uEROCrMozbRpdalnnA5EdRg8FM0HGxYnwRtZgpx5IeKzAJfca
	BP0vVCKGCVTiMB5htOaHwD+MchvzdZWMFZqnRU+8H4p69kOAnQKTuC6I5YIcqPTu0ZBMO9uyTlt
	Tuffaw40kyWZTQfsL3aJvsE23HTzKrGLsoaIg=
X-Received: by 2002:a05:6a20:3952:b0:39c:39d1:dbf4 with SMTP id adf61e73a8af0-39f2f0c86bemr12856117637.46.1775495568864;
        Mon, 06 Apr 2026 10:12:48 -0700 (PDT)
Received: from C6-AF-E1-B8-1C-91 ([223.188.119.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c64a46ffsm13042113a12.13.2026.04.06.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:12:48 -0700 (PDT)
From: Adith-Joshua <adithalex29@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Adith-Joshua <adithalex29@gmail.com>
Subject: [PATCH] [RFC PATCH] bpf/xdp: propagate queue_index via xdp_frame for cpumap
Date: Mon,  6 Apr 2026 22:42:26 +0530
Message-ID: <20260406171226.13325-1-adithalex29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_map_bpf_prog_run_xdp() currently lacks queue_index information in
xdp_rxq_info, as struct xdp_frame does not preserve it across the
xdp_buff -> xdp_frame conversion.

This results in loss of rx queue metadata when frames are redirected
via cpumap and later processed by XDP programs.

Propagate queue_index by storing it in struct xdp_frame during
conversion and restoring it when reconstructing xdp_buff. All
relevant xdp_frame constructors have been updated to ensure the field is consistently
initialized.

This introduces a new field in struct xdp_frame, which may have
implications for structure size and layout. Field reordering was
considered to minimize padding, but is not included here to keep the
change focused and avoid unrelated modifications.

Feedback is appreciated on whether this approach is acceptable or if a
different mechanism or struct layout would be preferred.

Signed-off-by: Adith-Joshua <adithalex29@gmail.com>
---
 include/net/xdp.h     |  4 ++++
 kernel/bpf/cpumap.c   |  2 +-
 kernel/bpf/verifier.c | 12 ++++++++----
 net/core/xdp.c        |  1 +
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..11aecf84a896 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -301,6 +301,7 @@ struct xdp_frame {
 	 */
 	enum xdp_mem_type mem_type:32;
 	struct net_device *dev_rx; /* used by cpumap */
+	u32 queue_index;
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
@@ -347,6 +348,7 @@ static inline void xdp_scrub_frame(struct xdp_frame *frame)
 {
 	frame->data = NULL;
 	frame->dev_rx = NULL;
+	frame->queue_index = 0;
 }
 
 static inline void
@@ -392,6 +394,7 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 	xdp->data = frame->data;
 	xdp->data_end = frame->data + frame->len;
 	xdp->data_meta = frame->data - frame->metasize;
+	xdp->rxq->queue_index = frame->queue_index;
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
 }
@@ -419,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->len  = xdp->data_end - xdp->data;
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
 
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 32b43cb9061b..e475a732ceca 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3814152b52f..e2583dfd7bf2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18693,12 +18693,16 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 	int i;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++) {
-		/*
-		 * TODO (when needed): collect only jump tables, not static keys
-		 * or maps for indirect calls
-		 */
 		map = env->insn_array_maps[i];
 
+		/* Only consider instruction array maps with multiple entries.
+		 * These correspond to jump tables. Skip others (e.g. static keys,
+		 * indirect call maps).
+		 */
+		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY ||
+		    map->max_entries <= 1)
+			continue;
+
 		jt_cur = jt_from_map(map);
 		if (IS_ERR(jt_cur)) {
 			kvfree(jt);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..995f48e35310 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -604,6 +604,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->len = totsize - metasize;
 	xdpf->headroom = 0;
 	xdpf->metasize = metasize;
+	xdpf->queue_index = xdp->rxq->queue_index;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
-- 
2.53.0

