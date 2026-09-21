Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B04BA1E5
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005630; cv=none; b=T0fpesBNhntTwE+MfEFa1u0PVluqq4IhvZOoBjkhQqmxrQo4pu2dyLPiau6fchaN2UQc9PCSvJ/mAKXFxte7tCl+OGfTt2zDz3CytCpEOBtn1P4itm5aLoY1dgCjgGWmTNdzYmcXAD2Y8dVy1HXwYWVgvWFr0I/4ncH9A+nPPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005630; c=relaxed/simple;
	bh=C4xwW2mOduY+1qJomfHxU2ms1BcQsIMtec0pb8iWWZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfFkwFrbhvfd3MU5tKguj8plkVI4/Yoo40ZNjQFgsx5hmAJzMsj5udAEgJHidOL9afV2YZAXciyOjDpJbKgkzsfysFELmzr8ArGYUAK7x0sCU91u+V5aJu1FTD6zAtQDGP0813z3kZqkWbCVmUK0rnL9xbcgYOIgcvuNMrdaLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeY0AY4C; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeY0AY4C"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2464416a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005628; x=1790610428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqoyuLnxl7hAbksadhiNpkBzn5St1OFv+pfKgvkEAqY=;
        b=EeY0AY4CEzemyQ/eUCBkvoGnbNL7SrzBiOo5U8J+MEVOqEN138vceTAVwqSPSvTa6a
         TEOqD0VJAuS/nYTcJUrx/8Wjp3c2JX62gU+VgZ9JU4S8g0RhL2tDeaK7J0umGpgeFWSV
         sfkbJ0yLF2QYjMBXPFVMn8JxyshNORytUA7qt7plrdbFCcM5uypbDdBqpC0LYumyqyQW
         BwZ+KqBk0Oiv1waiMoSNXHq8q7Exo2eaEE3kf7L/gOAhinmpeROxEURbvr4v2WoIVWc/
         qnDebq1PeknrO2pCpJ/a9vOW7hgcjpewabTbUIFkMwKl4gYjRAkNKzy7SqaOZPmMnxwB
         zEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005628; x=1790610428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqoyuLnxl7hAbksadhiNpkBzn5St1OFv+pfKgvkEAqY=;
        b=brd01twKqqKb6F63TCvjB1JUgziGo4kFLB7uKgNS5gtw2lufnnCTo78a9LfBOUP4Gi
         BN4qqPlh1NS1gtk6vBk3FXiZGTkEyQj2LyzdGABUNaiVNQAxHxu1PCC3+F/CFEbaULXL
         g0z6FMEWuJSnXs9sh4+C6c0svxDZRPF7/1HQtjsKSLVq0L9xMtcGINlqtzus5tbLRzS9
         nAE+v9Fz/5tFeadfohtkMRQoYUS6lM0WIuQ8ikuj3Tpj9SJXmNvDmBusSsmJzRpElkJ7
         Lqj5hRNTRc1LLgWkbAzmpDQYEUGMuv0K5zCUB724nGWy2m/bJJufvGDVqOvKkWvjAmq4
         5NNQ==
X-Forwarded-Encrypted: i=1; AKwUvByO1YiDiApD3cPqB5PqCgD8B4oy8afod4aHPk+l7xQ3K1BjeHu+YvTemLvVBTP0MJSVqkg=@vger.kernel.org
X-Gm-Message-State: AFuF++mesad/6dc5/VYyOvOoVPFBltPBw1GNcGaAuix9290IjmiHkedV
	pbCwsoPoP2xLTA0HNEhD0tupmztq2URTc3mc52ts5s5U0f8uABSaiBKS
X-Gm-Gg: AYBFou1LGUsH2bpoU5fzEHYumpXhXtliuUpfl7UyBkbZ9lkqjk3Au+4lQOQOmlQKy2i
	QcGfGL2RDBKl3fBsCXw9TngtD9J/Y7ZC2dSW1IcJ9tgpKgb4+tzGBuQ0Ceep7dJr/COH4Zy13/c
	ALvbQwDvnG3gsUha8s+8l613OygW016vl+Rl3Y91y/scDUfJsUPEbrFoz32YdA6APNv2GJ9+dBn
	ksCHpag+8xYrKWZT+7WlBUJV626DBkdCUetOAjO/XGQwQ/DbFYi3reiKKwFS3WMCAdm4kgPwq9k
	QiS5bHah8lRjApBWeRHoKKuqHSbzzmlEp7ShJWofiKe5M754xVkLQtDXiA4+mHJFQnKEy3u8nQK
	Ihi95VEFJ4I/HydY8cESmVbJ1Hbpyq4om2c0nAtexHAgGl4NcEokvaDvMKKix1vcKO023ZuJWEX
	ZimVA/4AQYTpN+lWLyWQX4lp9YJoTehFYfiA7KbSB7MW1ZUaAxzWa4tSa/ccOSZS6OZEKcSlLW0
	LxswSXWOZ9nHQjdYVTg/gN1ZDqedfZMTywBXEhqeVWLwQ1I
X-Received: by 2002:a17:90a:d648:b0:39e:6c6a:6577 with SMTP id 98e67ed59e1d1-39e6c6a67b4mr9499408a91.58.1790005627594;
        Mon, 21 Sep 2026 08:47:07 -0700 (PDT)
Received: from archlinux ([205.254.163.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e554e5529sm7838802a91.4.2026.09.21.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:47:07 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] bpf: add diagnostics for rejected memory and map accesses
Date: Mon, 21 Sep 2026 21:16:50 +0530
Message-ID: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit structured verifier diagnostics when BPF programs are rejected for
unsupported or prohibited memory operations. Cover sign-extending arena
loads without JIT support, read/write access restrictions on maps, writes
through read-only pointers, direct packet writes, and modifying helpers
used with BPF_F_RDONLY_PROG.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/bpf/fixups.c   |  5 +++++
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..b8baf77d933e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -9,6 +9,7 @@
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <net/xdp.h>
+#include "diagnostics.h"
 #include "disasm.h"
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
@@ -958,6 +959,10 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
 				if (!bpf_jit_supports_insn(insn, true)) {
 					verbose(env, "sign extending loads from arena are not supported yet\n");
+					bpf_diag_policy(
+						env, i + delta, "sign-extending arena load",
+						"the current JIT does not support this load instruction for arena memory",
+						"Use a kernel and architecture with JIT support for this arena load.");
 					return -EOPNOTSUPP;
 				}
 				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a676fc70f4b..ebfa53930276 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4365,12 +4365,18 @@ static int check_map_access_type(struct bpf_verifier_env *env, struct bpf_reg_st
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
 		verbose(env, "write into map forbidden, value_size=%d off=%lld size=%d\n",
 			map->value_size, reg_smin(reg) + off, size);
+		bpf_diag_policy(env, env->insn_idx, "map value write",
+				"this map does not permit BPF programs to write its values",
+				"Remove the write, or use a map that allows writes from BPF programs.");
 		return -EACCES;
 	}
 
 	if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
 		verbose(env, "read from map forbidden, value_size=%d off=%lld size=%d\n",
 			map->value_size, reg_smin(reg) + off, size);
+		bpf_diag_policy(env, env->insn_idx, "map value read",
+				 "this map does not permit BPF programs to read its values",
+				 "Remove the read, or use a map that allows reads from BPF programs.");
 		return -EACCES;
 	}
 
@@ -6527,6 +6533,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (t == BPF_WRITE && rdonly_mem) {
 			verbose(env, "%s cannot write into %s\n",
 				reg_arg_name(env, argno), reg_type_str(env, reg->type));
+			bpf_diag_policy(env, insn_idx, "write through a read-only memory pointer",
+					"this pointer permits reads only",
+					"Use a writable destination, or copy the data into a writable buffer before modifying it.");
 			return -EACCES;
 		}
 
@@ -6613,6 +6622,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 	} else if (reg_is_pkt_pointer(reg)) {
 		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
 			verbose(env, "cannot write into packet\n");
+			bpf_diag_policy(env, insn_idx, "direct packet write",
+					"direct packet writes are disabled for this program type",
+					"Remove the direct write, or perform the modification in a program type and hook that support packet writes.");
 			return -EACCES;
 		}
 		if (t == BPF_WRITE && value_regno >= 0 &&
@@ -11188,6 +11200,10 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	     func_id == BPF_FUNC_map_push_elem ||
 	     func_id == BPF_FUNC_map_pop_elem)) {
 		verbose(env, "write into map forbidden\n");
+		bpf_diag_policy(env, insn_idx,
+				bpf_diag_fmt(env, "call to %s", func_id_name(func_id)),
+				"this helper modifies the map, but BPF_F_RDONLY_PROG forbids modifications from BPF programs",
+				"Remove the modifying helper call, or use a map created without BPF_F_RDONLY_PROG if updates from BPF programs are intended.");
 		return -EACCES;
 	}
 
-- 
2.55.0

