Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4B17B425
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121137; cv=none; b=GsKOyi3N9Cauwb04TZV7OjU7tBt9NrnwZntY7JpvvAUIe7P7f4tCjQO+FJ9xCS3A7rfxT013ipuvTVdQXxjRvf1vbQJyIQOQ7uNTbarsz6TO4OSJdtXBmZZ3DwkKucjrPhSi10efHG1BCSCDpdNcwN3nyRwLFWKpaMzIkEx8JH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121137; c=relaxed/simple;
	bh=33vCQttXFHEQU94EOmLlvQdz7Itv7c/oUa31u8ymozQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asTQyeyXDRcAFerT4R/AHNPoHj3IDgUlQ8QQAdPPwQWur0zFdtdiyLNJZAIJepKZPs4M7piyX3hi1W9M8CMFX1L+ePdkbvzkrCRabWK80G2KSp3bXo7ZykAfNckzvCR/b8tHohXF8bV75u14CN8txSG2LB506NZpmxH80ZiUQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRI5981B; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRI5981B"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so291099a91.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121136; x=1791725936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oS/Vjc6EK0RQSM0PbgztWkSvy2x/evtKdnJvouo1qIM=;
        b=QRI5981BuiaQr6ysQOjmxyEE+SIv4D4X34peHXSpjZwTFwgjW/KrAPFQKepaXAp7Ze
         uDUXAx9UIiMVEUa9u2AzADE3rSHtL+z998eN3ltN+ZMMUF9VtqnQc3zsfTQ/12uBQkPD
         3EvvSeXY0r3jdftA6LS6DXCJPw4XOZa3QnbTj3vwJwQ10tZPrpMx/teifsanc5S4A/1t
         QqCb1oN9rDGn0Q2edUvetANvtv2uMJg8pQFvCc4VDl2+KBs6LEYpR9YbWfonLQD/VcaN
         gvwOMxz8YdGfeeRtZbTGH5GME2KNhIoEknVPKxTFXwWJtQEBthWeSwb51rIwEBmG6AVh
         YCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121136; x=1791725936;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS/Vjc6EK0RQSM0PbgztWkSvy2x/evtKdnJvouo1qIM=;
        b=WU7IFp1+8347dQ7FSCIShRSpy6JCH137ka/71ExMfTXjDZ2N9n7YcB6hq5lQhNXsCz
         QsJvhsd5AcgYhKFcCjyuJH+PjrK/pBgEahLI0PTMOyb0zzZ8HKEtjWd77UF9c3GTgnlF
         /MqZkIUAFGlcd5rdsKwbToCr8N/WxDBhg+lV43el2isy07xpleYNN1ZoC7tB03kw51uM
         OqDusT7qpYC+7I7rqI4BEB3w8oEBqGRQgSqEdFubgOCdh+g141SE7/bvHH8XaV81Dtha
         HIrpeJq+omAFG4raS1QSt3noikUBepkDoaw++H79GihxJmPwv0OUZDuorrctctFc7uvz
         y/Qg==
X-Gm-Message-State: AFq9FYK3QkhoBawESV0PFGjz0mEZQCUFZNMFzlezn07MlnQXijN9/0St
	XucxWqyJes61hZmhrIw+4jNr8M/OKiEPIhGrmnupIU8iOyBKqAcQ1WOZPofSgA==
X-Gm-Gg: AYBFou2Npsf4IzxZ3+To9Mh6wt1aCKceD4YD4LqggGkZR8CPC/stTeTflJNNXmDmH/X
	c0N9tI5uoIasSw8CQ0wb6SheAUJNhVVjo9+HnyoTWTE14g979Q1WajFS7u6Mjv3ZfngTesbpkQS
	56d6GhanDeI9R3/POpsz+/CePsvBDnPT9ZxkTy537mj9LWCmNXxW3byKNfh3SPc99LppRp8siRl
	3NnZI5VQi7tI+80bX68v07P61Rs/HSOQF6SHWC/4LNKpYhFyDRFJr1PdOZTfym5caRK959OMgf7
	X/SooJI3n8TZDyye4cjo3M0xKfn7Z87SlHu1AgxlksL8QPvNal1+DrwlIS0FavLhXXJ2TvzD0r/
	x9a225Dxh8hubjNLwKU6M57Pyac6Bn+YVldHyuTgfgsnUimy5thI6risUZ1OVM+WmfupsEKj6Z3
	zKdHbzdsyitma4xGz29mxJfQ4qoIPRvbTBX19/hZnGF2w+JVaHqPWZobaY+wXUd2YpHScTi6q1T
	C2NbD0WZMKX2H6qTiImX/q2WQ==
X-Received: by 2002:a17:90b:39cd:b0:3a7:fa5d:fd6d with SMTP id 98e67ed59e1d1-3a7fa5e045fmr293787a91.14.1791121135915;
        Sun, 04 Oct 2026 06:38:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 21/43] bpf: add bpf_mark_reg_known_scalar()
Date: Sun,  4 Oct 2026 06:38:03 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-21-f6254e29fdf2@gmail.com>
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

Provide a helper to set a register to a known scalar value for use outside
verifier.c. To be used by SCEV widening logic.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e1c0d0d3f1e1..73bbd7f8f1cc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1348,6 +1348,7 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
 void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 				  struct bpf_verifier_state *st);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22369b6f747d..5fd6376da171 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2049,6 +2049,12 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	___mark_reg_known(reg, imm);
 }
 
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
+{
+	__mark_reg_known(reg, imm);
+	reg->type = SCALAR_VALUE;
+}
+
 static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const_subreg(reg->var_off, imm);

-- 
2.53.0
