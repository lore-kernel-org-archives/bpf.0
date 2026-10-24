Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800248;
	b=coaUwLuzVXMOzL42GTsTEuM6tTbig6wPFtTrTfxuvyldq4qA65TWoQpGAxtETXcpjigI
	 dUd6ngcPoBoQVhjKeOHg2OE9L2/unTZIKprzRzypHc88RFt3LnmNNoDEtUZ7tNcgpMTGT
	 YJb4RsWUnVmU3EPVRtJFr/szxSloenW/eHAlJ1CEE8sDx8CwDzhp+RQmvVrm/GCngnJaa
	 iXTrJTp06X8R03RPzNM2G/8WNFEGxG9BPerPkXLJZ4Ye1qGeYeIT29DQDuiHX6JmJM7Is
	 77mceSNVkIk6Cz/J3iDga49v4Yn4MNGvioQUccWBNuTXmQWvuIHk/Yw84fB5i4+SHbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xeWkpdV4nGYGVAm2Of+7Cp+1ZdNfjHkdE99+xSiAysE=;
	b=0bssikXicrxUvJN1y94F2TGFwcBqbj1BZeQnDRoKPS3jKk9d5Aff1zmaJOXZ/7e34dCm
	 0CcEqXHjkMF2HvhpD1VoHHBk5V3wUIWMfNpZlMpmPm2emthHFtGRlFg5H0G/0qWejozWo
	 /Z8o4k0Xm3iFyndw42DmmpNWLFJVs13/M02IzofViTFMTaLOQbaWhPmMmsmKck/CGYy8K
	 lw/t1o3W0uNQguzOUmexxjCYMPYzGfAIOZ3NpjNVKvIeObkZAwGOdY+fU7yNCfMNJccjD
	 0gc5DTzmCMSatfiLaiplysZqOd3C8/NStGKPYqEyzh9Yjr+ZgU5vgtkad+sBfSmIE6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EN+kBIha;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B23606A324
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B23606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EN+kBIha
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso808093a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800248; x=1793405048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xeWkpdV4nGYGVAm2Of+7Cp+1ZdNfjHkdE99+xSiAysE=;
        b=EN+kBIhaCEj8SdLLX5RkB/SpkwTwuOEBAMQ+t6sR9Iagk6PAGoqET5rAGfoUKRR3gl
         XxChCl/qihyo/NqFr53u6oDnhfOn3VBpYWyvYaYU/3CKl/6FUpYXP0MAoQc3+UgautjR
         z1ocf9azCwIKjfNW7B8xumIXFMl+JOF6I+38RE6eOMQf3T+SXkhPg8SXVWv754XCzpUR
         ym5+B7KVwNY5iyQISSTh64dr8325sYWplJgvvTUsBxqq78sPi1oNH9e86hl6dI4+3WWT
         83isBBXQnCWNzDHUfjHiYl5fvfAlJdCP1rMchL+Ht6Q7+836waHMnHWFtFB0Z7M9gf6Q
         Z5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800248; x=1793405048;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeWkpdV4nGYGVAm2Of+7Cp+1ZdNfjHkdE99+xSiAysE=;
        b=Q4Pk284N7Zdg3YxaTEw2V22eZ9DpJStGrK6ATEbjf7wRyukUSUp3S8GGneSO8bcH+A
         wLbZJokWHqqHdKQrIexOPvlRdiSPI6pis5upLEFLM+6MmIYbSQ2yBEmo1o8iILTIj/0f
         bY2GNVhFAQxK44wDsvxNV/5t4fN5wzLET6Ww0rrLReae0gk39h33GC4RMn65Wr2Pqe6q
         wqIkMLgE+vkmgkb75Vg9AjZCxeVOgp/Sm2xRjJpcI533jv8GcNADhswra/VKyB/+ydVb
         +rdEpJIRrfGW0scwDbf5+YHlD+7wyjuapxxrHLIX4wzHRorNPB7VfYUBx1Mcc8r1Ggp3
         i8eQ==
X-Gm-Message-State: AFq9FYLDezpjV2tFmC9DT9ayQtmtd1ROOazF+sKT7ASSsKboCI2Qdya4
	GzHwrVeSzW1s79/s+jnHF5bBG/Z3IP1k9/RVKaeY9s/HGt2tOOIEx4KkhLd1hv3Y
X-Gm-Gg: AYBFou2CVBp8tkz9a8UhjYuNAU2XGgL+cabDAfJYRicQZ0xQoMRYNi+dQIyQYnhZkk4
	36sKqohCwm10qk7GtxHP4bdtmUi3VkMo8Q+uUbtvr9X2EGK3T2odtmwYXv/Z0A+QqF7vUrIDi2W
	KfceimimhhJXR+bigYLQ0zH9JHfagm6i1Nl+/ehVKSvZYe019jjhoWGAfE4C+Es0mEtuTdho5HF
	VlGR7quMjVbWWvUGPkfzHba0WCw5ux3ygWN0oyZwQ7vMtbtHJJkEAKel84BPq+IkMfmRTyTcdoe
	UFksNabAaOvUQLGygsfYE+4oZ8urcgJJGJdnXlJI5k9TG72Kqn0QrsuCLo2V698cGx5jEXiOp6M
	o74yX11LK7r/zTKdfoooBYRBq/V3FOEh2iyKHaMGUWysHzjR7AlDJVCirgqSPG053JrbCptTfXf
	8NpODIzPK5723RRn40pRaSFdo/kUA6NeDMXxWHnOcEsi35KeI38zC5fvBDA0KVi2+qsImyREvIx
	pmDsCPJs9igfmAtDjMwKfcedhaJ0be9zE192tc0LT88VyVHEI2CXdmzqwnnoIoe9TI7qBio
X-Received: by 2002:a17:90b:2ecb:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3adead4dd00mr618262a91.32.1792800247691;
        Fri, 23 Oct 2026 17:04:07 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 04/11] bpf: check the iteration count before the predicted exit value
Date: Fri, 23 Oct 2026 17:03:46 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-4-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The comment before `total_change` computation:

    /*
     * compute_backedge_taken_count() guarantees that 'total_change'
     * does not overflow in 64-bit domain.
     */
    total_change = initial + step * backedge_taken_count;

Is not true before the check:

    if (backedge_taken_count >= U32_MAX - 1)
        return false;

Move the check before `total_change` computation in order to reconcile
the code with comments. Old position is not a bug the check was
performed either way.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index d67e793d7a18..e3c2220f89c9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2307,11 +2307,15 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (!compute_backedge_taken_count(op, initial, step, bound, &backedge_taken_count))
 		return false;
 
+	/*
+	 * max_header_count is u32 and U32_MAX means "infinite",
+	 * check to avoid overflow below.
+	 */
+	if (backedge_taken_count >= U32_MAX - 1)
+		return false;
+
 	if (latch->zext32 || latch->jmp32) {
-		/*
-		 * compute_backedge_taken_count() guarantees that 'total_change'
-		 * does not overflow in 64-bit domain.
-		 */
+		/* total_change is guaranteed not to overflow at this point */
 		total_change = initial + step * backedge_taken_count;
 		if (latch->jmp32 && is_signed_op(op)) {
 			if ((s64)total_change < S32_MIN || (s64)total_change > S32_MAX)
@@ -2322,13 +2326,6 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 	}
 
-	/*
-	 * max_header_count is u32 and U32_MAX means "infinite",
-	 * check to avoid overflow below.
-	 */
-	if (backedge_taken_count >= U32_MAX - 1)
-		return false;
-
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
 	iters->max_header_count = backedge_taken_count + 1;
 	/*

-- 
2.53.0
