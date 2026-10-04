Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E8436BF0
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121146; cv=none; b=mUfgHhuStCOrUTkaMY9CQNAFJpUgk6+QpW4cfrWV5pdkJDV1adYByCH4w3p+0YQs3nOztctx05zBZU06MUr/Wc3BjHIh+ksg1jvoML5YPn8IiIe+zDNI7u8ljGDPOAoQoK8uiARVcR+CuAFAuT3EVK/YUf8Kjrt3BOZkeKruRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121146; c=relaxed/simple;
	bh=n1NJejKkVYlZVUD3+vo8lTOQ1r34tUeNgulBGWPK7Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0OFOWtMLiLhgiRZSgEKTNRIMgf8shRgSr1Dy3DaGMSFIYC40vRIH71J+pcD7VIGm3FrYuvpqRBlmfEmZ91t0mWn4HJkzEcatcbn3b9e/jrPtahJ9C+lSRCD56PgYHZcSbQ/vX6hS80XuaCVy0fwmuvOI8WdE4iM6JZYW2wK390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY1xP4oJ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY1xP4oJ"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so211460a12.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121145; x=1791725945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkPxvuJI6LReOYLzsGVuXBvIibNAf6m65u9Yv1oY2q0=;
        b=HY1xP4oJsKULqPL21NvIc0oHRzGWfx5XkmVh+UaU4E62P1BNd0+SZrDIerrXxTtMva
         tkihYqRRaLAkEDqpbr5oJWoeiQz/ORb3T5ZM0Z0rUaAwJxA1Ye01wXUasfB9LtU4rQuG
         ma0xI4eGds4enHNqsL/gzX11YHr1PuXDMRAOrzvVvnkd3O1S1vXQr52ceU5cLp+EBH2N
         OrY0KXKkMD9YEGCzsKpFO2H3Wbgl7j7bJ5AC64PSp8OLArKtcELpUsEyCTxKVa7VUWKw
         TmcIQeIuXV2ycVoT/c2a+7+SKUyzEo1IxVe6jAir/W74aPzKKR7/Eo9+C+g80PqBpUaO
         w+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121145; x=1791725945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkPxvuJI6LReOYLzsGVuXBvIibNAf6m65u9Yv1oY2q0=;
        b=FeJfhROLCFLFeVUOsD9C3awW3kiN40IQjsVW011f4AgI/B9SHf6YNKsXqwhW3ZdBP+
         8yggjD6j+hmm8MxuVnY0b92ud22WlnIZ/luxkvC4Nh1mfJ0U+ZqJYwQYme5dvwqj2vuL
         bM+RX7ykF8Ni1l/jXAK3DzinSNIVEkd/hdphAPNLw/DaeorKizpVHP9TQqP3ieiiWJEA
         k+mLoCK0sX53psG6RrzjtvGOBdkxfogPY8MFVngiWnKhvPK883QNigQc94nLx0DvCG/O
         blbvxdjtvNdgGaXtiKzetwy/ze4DeL+YTMMEuUqq0V30QJTAOdm5P9YUfXA85E/6iT+O
         KY3A==
X-Gm-Message-State: AFuF++nBQrLTC/Wqb5SgDuxbEZk2/yXf8Vg1kSEuxCgfYS8oZnra43bT
	opiY4WQcD56qQW1WN5g4TthY37az8oW74f85C7GCichn7sMifFoMa8d0+2e6gA==
X-Gm-Gg: AYBFou3rdUMuEwNrMp+DGn2cIvvqeoWlYhuu2GIsEFKEBw4l1qXEZl2Q7U/iDyHltHm
	PxrwAdBbIJze7HZeFs6ArhOL1nqmWRd46apncqvdL+++7yPxdsJ2KVb1OPwzlJZFONdhNSGrDe2
	NY+hnbVrGrzOe9h3xGn8FBhlMIbpDTSwqjQBKKDh5AW2eZA6KkO0E7mfVTuPhxooG6si0moks1f
	rRuqu8YF0veWeObbqdgDvMJfVfnb7Atp7vQD58/CPg3L3LFOrq44wazfun2Mwpka/5zbsyC8103
	c+agDIehRZo4Tweu1QSMHbpU7d3mp1XgUc/zqivo7BTkN1mKkiia1sA88SmHiLFQqr99ZZI6qsi
	UidQTzK7xEZp8EPc6miyy3g3PUXoBf8k4Y2ONpL1CjwjGFRKoEaN8lxuRjT8m/awVq/Batxjh+/
	6q1+bI0HMGBAoOvEH1z1jQ8hbWm1/CqxNLuH0Iq38F6WF/8LM+OYdSexMuSy4BHtwlqy0zLQFfZ
	dy5o6CvtZc7jXk=
X-Received: by 2002:a05:6a21:e10f:b0:3dd:a196:30aa with SMTP id adf61e73a8af0-3e0bd4d6844mr7755661637.90.1791121144739;
        Sun, 04 Oct 2026 06:39:04 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 31/43] bpf: bpf_func_state size optimization
Date: Sun,  4 Oct 2026 06:38:13 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-31-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pack bpf_reg_state to bring it's size from 88 bytes to 80.
Consequently, bpf_func_state changes from 1048 to 960.
Thus bpf_func_state moves from 2K to 1K allocator bucket.
1K bucket is the one it fit before the SCEV series.

With this optimization SCEV increases memory consumption on a subset
of Meta internal programs by 3%, without this optimization the
increase is 48%.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 14 +++++++-------
 kernel/bpf/states.c          |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d47d4613eb3c..a539c5f049ff 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -172,12 +172,6 @@ struct bpf_reg_state {
 	 * gets parent_id set to the dynptr's id.
 	 */
 	u32 parent_id;
-	/*
-	 * Distinguishes inner-map lookups and their keys and values. Zero for
-	 * other registers. Kept outside the metadata union for ID remapping
-	 * during state comparisons.
-	 */
-	u32 map_uid;
 	/*
 	 * The value described by this register, interpreted as s64, lies on
 	 * a line described by a linear equation base + step * k.
@@ -185,8 +179,14 @@ struct bpf_reg_state {
 	 */
 	u16 base;
 	u16 step;
+	/*
+	 * Distinguishes inner-map lookups and their keys and values. Zero for
+	 * other registers. Kept outside the metadata union for ID remapping
+	 * during state comparisons.
+	 */
+	u32 map_uid:31;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	bool precise;
+	u32 precise:1;
 };
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 94339729f524..862f7ceb1daf 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1171,7 +1171,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	fcur = cur->frame[fr];
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, precise)))
+			   offsetofend(struct bpf_reg_state, step)))
 			return false;
 	return true;
 }

-- 
2.53.0
