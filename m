Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67042DA3D
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538143; cv=none; b=lvesnQ4isk/is2xk0Xl06Yd4f8Uyb2wrZOiZ3XvtJAQtj0jo+6r7i/odvTP89Oe15rpnHhUaQR3jcIYV2C4LcWLiY+ZbxbivLxrFvbGb7MAB+lKZKoqwpv7nsb6oL6UbvUGm34Bcsh/Ox4SFCLxqZuncWMDrLYRfqYjrhJA3QqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538143; c=relaxed/simple;
	bh=Vzfq6gaMAxxYQjMbXpn5SfSyE6GdJEf+lCxC834l2YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFX4enSSR1FJH/n5+fXlJ8t2cSUK8+gP4L6tD5m08vjzl38jh10YHJe6m0UkrnlIFhjBzU4twnOLE81wV8q6r5FdXsUlIQL9ub+Bbz0odjqV9KDOt23W/B/z5lBOFFgKVKlSWsydfVngkAcq5cNEBa1mVcBjDh0pqipbiOZctP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MokkfSRb; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MokkfSRb"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so1187278eec.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790538141; x=1791142941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnA6PP0x0bKf2d8Jul+q5m9frxuZwjq1oQnZKPMUkjE=;
        b=MokkfSRbpGeh5wKaaAr9aVmoG1lQeCZPzY4Uyv7wzFWxc6d18md4B4UpRu0Q4H1x3Q
         x/t9GLh7DvZ1uY5QyY3n5XZ0UIHYWM5Obejpv34HMabbYa/bBWL+lmC8+U9MCQdXbUEF
         47Mo1EkM8i9Xclu58as15q1fAuqXCo5kAYG/d+r8y1V2DHNUxYJMLeyGEYGpuI5nJH95
         aIz22ESwQ6mQsSilHmVTnGdYHCFLd6OT9ssoVy2cTni3WBc4FdXkd/9+xaWi/r8q4t6x
         kW6lk7Zey1EdfdJTJZjnjwA6coDDkgLkeiW3tdLPaE7MfJjSMhRbOqIbELLCVXzUuxGH
         2ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790538141; x=1791142941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnA6PP0x0bKf2d8Jul+q5m9frxuZwjq1oQnZKPMUkjE=;
        b=NMePD9R0UXtNAfzZ+h0TO5zrWdH+PG8FW/SSOW/2x3nvxvQjLhUzDNWwu3PRAm26pP
         e2InhLQIMMWNOiXPwYSN10u152tw5H+9hmMIWdqc6QgL5xqkg+tyTTTUWX/WD6tTdhQ/
         bT04RS+YV+4qB+UmihvAj9g/+/QCBHqsx9u5gMniw2zEa+/4GRTYbLJ/fwDn8Rampwjs
         IfDhK0xHOWBbJgExeyAsm6BJjDh4itO4sspUgDvjvkzMlyJjVuK7GXvHSeSTVJFX/KEN
         zmvBgpmW1GphnKv4rDPiLBn5phuzp5nXFxraD9BJJxhd76CuMcUZX4TJDDzLKXo0Ntah
         pbxw==
X-Forwarded-Encrypted: i=1; AKwUvBxYlTfxPj3Kwc4hGybkmToB+7Iei2Bk7Scqs5YdsVpoRKu2q0S84M75NZX2bZ15J0qJwxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4ZHDghGZSDOaA2AFU19MuwtDSw3CdlCx/q8JDuSe2BuDcFdoo
	Ss/82PF7pgo4LnwY8k/mR0pTWIg4n9Gqc8pXq0/0tISS/zeNVe5+QcaD
X-Gm-Gg: AYBFou1D/1Jinr/E797fUjEhL68CbslxPw3GbAYgpHs+xda3EFgz3Gp5MBYaiTjd7L5
	Mnfhd6R7eJBZAWhu8sd5q6Ta3ujL5Shm0PuL58v8XQz76a2e7bkAg6dC7m9h9zBn049NPotpUvQ
	9nqr3jNtZw4C8ueLOvpwHQr+OwnQAinONQUayQW+sJKt9FeC1mAnlTeMN0XkjwUbiTtPne+5tpF
	qxXIyPTYYNB31jrcB4FEHeFk1wlJUSji5pAA0gEP9qLSJ/y8i819CVvoscVhfFsJ33U7pAbjgau
	kcaV/EjX4UWCJ8EaxgRJ+o+oGhUI17FxQ0AC9N0M0/aYXv/1PoVL6tI4XRAfVOvbaecdmMeIVKn
	owd4KhWsNB4r6Y0Q9MN2Ohh2//o/8XPfMZOmxpbLnXHBu+wavJ7tjMN6WaHBbqtj0LwHeLG/kuU
	2t/XznFb5VWF82FYTmK+7miWMtQMJMDhVr3V4Nlt+rzFjuuDyA4cdTNNCUkzxgDYDghbdgxxxtm
	9GIJJXx1rfkB6JdXqhUr2sIuY4DtDH8Jnhi1Q==
X-Received: by 2002:a05:693c:8812:10b0:33c:6e0:3cd7 with SMTP id 5a478bee46e88-34755659554mr992638eec.1.1790538140541;
        Sun, 27 Sep 2026 12:42:20 -0700 (PDT)
Received: from archlinux ([205.254.163.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm23135201eec.23.2026.09.27.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 12:42:19 -0700 (PDT)
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
Subject: [PATCH v2] bpf: add diagnostics for rejected memory and map accesses
Date: Mon, 28 Sep 2026 01:12:05 +0530
Message-ID: <20260927194205.125086-1-suchitkarunakaran@gmail.com>
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
Changes since v1:
- Modified the diagnostics messages to better explain the issues to the
  user
---
 kernel/bpf/fixups.c   |  6 ++++++
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index e9c2d6c06218..4216b359bf28 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -10,6 +10,7 @@
 #include <linux/perf_event.h>
 #include <linux/sched/signal.h>
 #include <net/xdp.h>
+#include "diagnostics.h"
 #include "disasm.h"
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
@@ -1055,6 +1056,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
 				if (!bpf_jit_supports_insn(insn, true)) {
 					verbose(env, "sign extending loads from arena are not supported yet\n");
+					bpf_diag_policy(
+						env, i + delta,
+						"sign-extending arena load",
+						"this JIT backend doesn't support it yet",
+						"Recompile the BPF program with Clang's -mcpu=v3 to avoid generating sign-extending load instructions.");
 					return -EOPNOTSUPP;
 				}
 				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c8626215ee6..bbe88c259fd0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4472,12 +4472,22 @@ static int check_map_access_type(struct bpf_verifier_env *env, struct bpf_reg_st
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
 		verbose(env, "write into map forbidden, value_size=%d off=%lld size=%d\n",
 			map->value_size, reg_smin(reg) + off, size);
+		bpf_diag_policy(env, env->insn_idx,
+				bpf_diag_fmt(env, "write to map '%s'",
+					map->name[0] ? map->name : "unnamed"),
+				"this map was created with BPF_F_RDONLY_PROG, which allows BPF programs to only read it",
+				"Remove the write, or create the map without BPF_F_RDONLY_PROG if BPF programs need to write to it.");
 		return -EACCES;
 	}
 
 	if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
 		verbose(env, "read from map forbidden, value_size=%d off=%lld size=%d\n",
 			map->value_size, reg_smin(reg) + off, size);
+		bpf_diag_policy(env, env->insn_idx,
+				bpf_diag_fmt(env, "read from map '%s'",
+					map->name[0] ? map->name : "unnamed"),
+				"this map was created with BPF_F_WRONLY_PROG, which allows BPF programs to only write it",
+				"Remove the read, or create the map without BPF_F_WRONLY_PROG if BPF programs need to read from it.");
 		return -EACCES;
 	}
 
@@ -6944,6 +6954,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (t == BPF_WRITE && rdonly_mem) {
 			verbose(env, "%s cannot write into %s\n",
 				reg_arg_name(env, argno), reg_type_str(env, reg->type));
+			bpf_diag_policy(env, insn_idx, "memory write",
+					bpf_diag_fmt(env, "%s points to read-only memory",
+						reg_arg_name(env, argno)),
+					"Use a writable destination, or copy the data into a writable buffer before modifying it.");
 			return -EACCES;
 		}
 
@@ -7032,6 +7046,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 	} else if (reg_is_pkt_pointer(reg)) {
 		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
 			verbose(env, "cannot write into packet\n");
+			bpf_diag_policy(env, insn_idx,
+					"direct packet write",
+					"packet data is read-only through direct access for this program type",
+					"Remove the direct write, or perform the modification in a program type and hook that support packet writes.");
 			return -EACCES;
 		}
 		if (t == BPF_WRITE && value_regno >= 0 &&
@@ -11805,6 +11823,12 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	     func_id == BPF_FUNC_map_push_elem ||
 	     func_id == BPF_FUNC_map_pop_elem)) {
 		verbose(env, "write into map forbidden\n");
+		bpf_diag_policy(env, insn_idx,
+				bpf_diag_fmt(env, "call to %s on map '%s'",
+					func_id_name(func_id),
+					map->name[0] ? map->name : "unnamed"),
+				"the map was created with BPF_F_RDONLY_PROG, which blocks modifications from BPF programs",
+				"Remove the modifying helper call, or use a map created without BPF_F_RDONLY_PROG if BPF programs need to modify it.");
 		return -EACCES;
 	}
 
-- 
2.55.0

