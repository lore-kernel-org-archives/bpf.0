Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB47477E4D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432452; cv=none; b=t5UZ640w6UEJhy2yrccnbEAxkSSPgJBHM77Sl01qSui/YNUU0N+WLkcUZHDow6XtEOowag/KKd9WqGclBelCmoARuwLlssRb03Ai42wTavXEGlXYC33lTiNZPfwNX1hyNk2SQ9arWrK3AvcgHkAQQXEiMFUzYslAkLwWEP73+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432452; c=relaxed/simple;
	bh=xFLZdMldeUUrtJQ4OwElrS1V21pzj2HbAyq8trUUtHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncBMT8FgIEcv+Os2ygwym2zc/xH8qxZgOVyp2Z8o2EcLBE6A9cFF8dVrWkghqHb5EKvzM6THw2NZYfMkWaE5uR0jfpytFcoVifjpdxjSs/EIAFJ8iTlqOLlJ5ysHZp6PWS3zVaOyR3WLn2z1CbEv2GuhBYp/KZkGx4YznQ1UdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEc5jAWN; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEc5jAWN"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so651036a12.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432451; x=1791037251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DUN7rIY0rFmPflhkVcT/r4kvfQ0zAT35FSENAfD5lKk=;
        b=YEc5jAWNpHCwItW27PBWXPrYlS6pXhwRWNxMU6y6mmrxACP6f0PaW/pTL1W/e91Aef
         UuBtnMi+d29ROj7DQRxMGzuYQLFQGQUAHo2V0+XdLDlqTNnQ8BYwTwhbnL69VX2cqsft
         r/Lsg+7kM1YN7QO0GrIgUarJhk7a7azd5D2OrNptX1x4085zjqjTC3hwJPau3CmJ+SrO
         u5BeR4DgH/wWidXJu6SE1+jH10Jc8Hd0F2v4LrIdrWX5vqueEYMconvUuJltoIa3K35q
         64KQRYeNvGMPC4422OLFmgeXgJPkbKir/74pK8MfBPZNzpSv96yqiqIKOpksmB7Fx5mr
         dj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432451; x=1791037251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUN7rIY0rFmPflhkVcT/r4kvfQ0zAT35FSENAfD5lKk=;
        b=B+RYtYbkcrmJkC+UT2MOUgElAoz9XUvRpXr/yVDY8dB6ip7+hm+g+FV/uqy+ghHXSq
         o1F9OSDdxB0kiw9DEG8fN4Cu7c0hv0EAyV2rYRZ/ecaeo85Sn9KVh8dsDmjtrGtxkKlA
         A0JiHy9Pds0TAUPPLHnDVTXPYWZY8A6YMRYeLRT7R0p7aypKiRDFOTP5cYRxlChTC5xk
         mByhmp65Nifo+VwtsCTOGm/PfQgbJ54kJxDD576eT89QgLrGYwNn/qHMPdxSM7tDpLO8
         ZojUJ7sdBS+TXe26dbreAa8YYRV+8aWNj8mRBrRSINcgIgwG5peODREfAcNmCcT85343
         GrXQ==
X-Gm-Message-State: AFq9FYKnrUP0rnrmlEyYCm+NcEQolGbMy/qvCQ/kzz+M9MQcGypQKG5a
	1TZPo3D+tUJxc57eR4DW2/DMho2J6ZHPp+oJw6sUXdDt2hDuO/w76bmKvTWeXhTNmEo=
X-Gm-Gg: AYBFou0tZakm5YT+c3BFazcxlbDBRArpa0dU0g+5GlH4zmHD4SUmBU9GPuZO7SsgN+N
	F0VEnl09ZQ56ieFF7RzOT7KOWeNQvSTNMd6a1JiWJRSGKmnjCp+E7Il1GkyYGHoaHZVWukNGNua
	L8QW/aT5sUtDA3eU3ji6OHI50trKjChBGKogK5N1oDN+Bcm5edOtMzqXjFXAFHrfeH9kG1qT0Li
	syi2T+fbvqsZIGrsHjguTT0dhc0sCJvaK0DcWyvhnQi18K7n2cUJh0I7iHJHSL5uBbJQnRO7sna
	Dfk0t1qQKN6p7i7GvlFMoKBWA8FMvmWzuXfZspJ3ewQc/gyn1ataiZEzdftl6VKL61gW73AT9Ez
	ZnBuOPcmZAOkaIT2O73LddnvHEhm3YGrWFSGDqfzmSpcHRDHDtglolft5Ymr0ygj+wfDEiWl2HY
	q+CGEF6zIMMZzbN6MQajBWm0bYGYkrkjebXoTM70b/2k9kethIJ27Nh6TmBc7gZs75wGpgarUau
	14wwxgQCJHILvtm8nVfi/3v7zYl8ATFnwawZgZAFg==
X-Received: by 2002:a17:90a:d44e:b0:3a0:bfa4:b966 with SMTP id 98e67ed59e1d1-3a0bfa4e2c5mr3508882a91.61.1790432450656;
        Sat, 26 Sep 2026 07:20:50 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/36] bpf: summarize regs that may hold a frame pointer in insn_aux_data
Date: Sat, 26 Sep 2026 07:20:02 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-4-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV needs to know which registers might be stack pointers at a
particular instruction. This information is used to invalidate SCEV
expressions for slots that might be overwritten by indirect writes.

liveness.c:compute_may_write_masks() already tracks this information.
This commit modifies it to save the information in insn_aux_data for
further usage.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/liveness.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7f31ce5ea6b7..c9fb0a9985d4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -668,6 +668,7 @@ struct bpf_insn_aux_data {
 	 */
 	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
 	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
+	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool nospec; /* do not execute this instruction speculatively */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index b6b7fd479569..1cce0c7406eb 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1899,6 +1899,17 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 	}
 }
 
+static void record_stack_ptrs(struct bpf_verifier_env *env, int idx, struct arg_track *at_in)
+{
+	u16 r, mask = 0;
+
+	for (r = 0; r < MAX_BPF_REG; r++)
+		if (arg_is_fp(&at_in[r]))
+			mask |= BIT(r);
+
+	env->insn_aux_data[idx].stack_ptrs |= mask;
+}
+
 /*
  * Compute arg tracking dataflow for a single subprog.
  * Runs forward fixed-point with arg_track_xfer(), then records
@@ -2048,6 +2059,8 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 			snap->slots = nslots;
 			memcpy(snap->at, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*snap->at));
 		}
+
+		record_stack_ptrs(env, idx, at_in[i]);
 	}
 
 	info->at_in = at_in;

-- 
2.55.0
