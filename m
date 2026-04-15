Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073328DB54
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241682; cv=none; b=GND0T2LgUJ29xv4+izc6EnBSC2yPQuadkKiADBWixopdsiGo9DUuGxIt5oakzjzU9t0UWHtt3q5EoCnmaKorZhr8DLHxONjej0LbwB2XWTTjW1GTrvzcl65HKE6PIohuVS3RJ36+d5MS8CgHZWAFHmSECptnBnihkT9872i9ntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241682; c=relaxed/simple;
	bh=3mHXFHK70OSdJNBZjn/0H04y2sG+NOM/khAr0FoqF/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epdRfVTQGx3x1GFMqFoo895HgXOTDDHFeKW4wLOrvVPCAIr9SB1vp1n/gYmCk1/fQJMF2pYkhYaAKtNCPWBGhskNqJztYd9fr6mOhtRWsio4TWzbgGHIPh6mZyUVjndRhIPDgnsMolAwdx/BKbBCKz8I62uhwOFQC3de20ADETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APb6LZ4w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APb6LZ4w"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf43014d0so39509305ad.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241681; x=1776846481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/MNUs3KKL19o802zzgTmKKF9qbiyfFCqHVSPcscCsI=;
        b=APb6LZ4w5RKHfIsjLq8LkFXNk05ocAbHa1dmSH1M2n/RU96BZzbg9DHvt7aJOAymng
         jXlKtP5/aegT+f1r62idIdD+qhxzTttAz51xlm3ThZFkE/arQP8sRmBAaxXGz5vh6lJC
         ILl7kq/jc/ltTsLfpK0AA/Wwjm5xHbSjUaj0Es4LXlPP46RVRBvA2EpDhYJty5k5hCyq
         PDd0iE8mlLlzGZrp4bxJ/uVqa5UtqeuVwp6csN4zM7kqQdYmQfdwuDQz/8g7Wj7XdBOY
         aXlTJ3zeLai69jEtzoQ7z4j7qwjZFrnMv8NAlX5IDIaMS8fQAMLA6pRKNcC08UtI7pLy
         KLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241681; x=1776846481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/MNUs3KKL19o802zzgTmKKF9qbiyfFCqHVSPcscCsI=;
        b=H8fz+zit+ZFa0GeGO0pR3LHHzW7Lg6JHy5pMe+osppupEL8CHwb52bG3zjV2SvvOFh
         0die7sT9Nd9+gtf/UDNhgmDlQVeFZrAR9hLLzPs3vatYCcIT/QWnWwbLL6PCRO0Ql4wY
         kRHYdltfHnJVGjjiToDMRRv2x0zoBTh9Idb8fQog+dKXrL5zJ5+946GSTPVCST3ixblM
         aQUJHjMP1ETNqbNAKPEzzZVMzf6gKsbj7fWChcvh8gl7yoxHuxHw9efcJbS0tQPCbu9p
         2POj+H3Cxoe/t57xi3tzkUOt9EEP5sOJwloxSHyxZdYmjRZG/xqbTLL3LA653N78J8mI
         v9AQ==
X-Gm-Message-State: AOJu0YzO6DJoQJAl26zZg0i1XnbHZis/3a0u1x8IF5XWO96G90EOdek0
	ApUX6Ea47MRBw/4fDeX1PFdYNh6iTtCZfZY5awvZ6zcDsVhLodO2s9qg
X-Gm-Gg: AeBDiev9GZ6tTb/ii6sulVQvyjq9iUle5rtxhchcgMWRbse27qyvJk7HyiKGP0omg95
	g/qI2p3lJTuhlopNSYkG8O04EW1fBo2Sqf6lu9U+Mxr5KNVnx4DvKI98JKth+kQFg6Ky3DPYkgs
	z3tqFv6aJRgATYLvNm68j/NRpRxIyDzEiJrg462jJ1+DLdjXUybXRyMepo1okEjiHyWIOZLwh+H
	LQgO0B6c2lj9NTAsjp7QisU/MtiBFPXr5m5OlPFScN6U3JnxUpUOK5GmFr2XFdN57eKQNZxsd/t
	EBPgJxbaGTuQpPmdnga0rB1b7AZr2CkQDdBQaqlfOQNedVq3R+DjZFOJCRaNX5d2TuhXggFLUQO
	A8TKp4lFXsqY0vH6plvc8C74jYHldmK+hePv+Vt0pg/PlwE+g7EkU4iTYnVByUtTubjwbWMqgFN
	RCHjTnqKKfJqFTOEgt3qX1Dyl+blj56Ap3iivHlhrIal1gWFr+kGkpmoLqAR6YLuUjq21L0qmAa
	Ux8FQ4m
X-Received: by 2002:a17:903:3def:b0:2b0:cb96:9815 with SMTP id d9443c01a7336-2b2d5a90324mr153302545ad.43.1776241680653;
        Wed, 15 Apr 2026 01:28:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 09/14] xsk: extend xskq_cons_read_desc_batch to count nb_pkts
Date: Wed, 15 Apr 2026 16:26:49 +0800
Message-Id: <20260415082654.21026-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new parameter nb_pkts to count how many packets are needed
practically by copy mode with the help of XDP_PKT_CONTD option.

Add descs to provide a way to pass xs->desc_cache to store the
descriptors for copy mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index ec08d9c102b1..354f6fe86893 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -263,12 +263,12 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	parsed->mb = xp_mb_desc(desc);
 }
 
-static inline
-u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+static inline u32
+__xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			    struct xdp_desc *descs, u32 max, u32 *nb_pkts,
+			    u32 max_segs)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
 	u32 total_descs = 0, nr_frags = 0;
 
 	/* track first entry, if stumble upon *any* invalid descriptor, rewind
@@ -288,9 +288,11 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		if (likely(!parsed.mb)) {
 			total_descs += (nr_frags + 1);
 			nr_frags = 0;
+			if (nb_pkts)
+				(*nb_pkts)++;
 		} else {
 			nr_frags++;
-			if (nr_frags == pool->xdp_zc_max_segs) {
+			if (nr_frags == max_segs) {
 				nr_frags = 0;
 				break;
 			}
@@ -304,6 +306,14 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	return total_descs;
 }
 
+static inline u32
+xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			  u32 max)
+{
+	return __xskq_cons_read_desc_batch(q, pool, pool->tx_descs, max,
+					   NULL, pool->xdp_zc_max_segs);
+}
+
 /* Functions for consumers */
 
 static inline void __xskq_cons_release(struct xsk_queue *q)
-- 
2.41.3

