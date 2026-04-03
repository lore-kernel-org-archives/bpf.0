Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9726ACC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181837; cv=none; b=D9ujJDHBqx5MWpU13F5PPnhxP8V9TqzHjgWnzjW0v2LbcIy39ByrJri7LyZX77IB0BUPibhSMhlV62LIWax6J6a/OgYERgqo3Bga/K0flpvPHQk+JvF/p5uDAuU3/LEzEM4B8nK4HaaZSmulcD+YlHbQivkBCJVQOOvXFuGbCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181837; c=relaxed/simple;
	bh=eH8zojZ3+sx/3ZMQPcmY+N2BAA63nZmLajpUHyqna60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sm2ubqXcaok8SBhx7AeUgvqhiu1yb3F60iwS/gpHxfZ5xJhU1c4+caGjYGzOpYFWC0QRgc5c++OOk0vlCUsf4jxu0EH8k5+Up7Yh3DPLgNBfc6NNCuZfNvQBtEYyQsJHFZMOEYSXP+bP1QFRyv+HcS2RQdN/GC+QgBuHOQEfLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL08uDJb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL08uDJb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so684812b3a.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181835; x=1775786635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=hL08uDJbz1pObrRwnhIqOYVl31pLSrX3pVDJO5ZY0+g5THpHc8O1We8ez3PydTGnj3
         /Gi6h44lpZ4BRIa370lARUs5kW5aICtUIiOop6bIcrDGYPd1LJ9LcJqcLW9dIJ0e0vce
         8oVN3Gh4c3YmWIw7i3glitl1wH4xUt9MQGp+F2Vumq6QSoZCn1HAdX34wfHaF/fgiGU1
         5e94Vn3wxjftxF59vXEyo57QKvltmnACUcQfllA3CFy+utNxNycX3DV9BYhXp4xSZuj8
         2yox2NE02vdt/MGPwHowt816CqZLCXIAFUrHK8akNzEgympOyyhGuE9X8MGhbR1NCVRK
         oZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181835; x=1775786635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=BYKsnY9G3SlCGE9x5a+rfgch9vd7LAZCpwrn2YALDoR/FD/kkJHBqN2QCBvZ4hqkO/
         kd7t4kzAVyiQGg2spgh6pjG7Y2Sod8d3x2JkIITHfCH5/CX9USsjSzS2ON3QGW2jWRSJ
         vFeQ2dxbrp16dwhSyi90ckMAUqhal6E6qfKs0CwHsLxPpSSulumCo5pESyJBKXfxPSlJ
         oGqRsDCSCFYJK8G4OzzQraKdui0tPfYgp8YOyq5PvW7do8XUztaWCBWYhui6Pp3D8j6W
         hBcvQlSeKjElstq7PzqAYIQRTDocNDiT1W3tmhr2THG1w3PHjuciXdPX3KjtkrvEgKke
         uTwg==
X-Gm-Message-State: AOJu0Yzvd/Z54Jhg5ReLoJOdoD6fSTF1EEuD0WY8xsrImx2f/O5bmXDi
	7hkA/v+Gb9TDjFjAaOcCd39+aph/1tdVFo840yk8hh7iUOW0WJfvRcW3uA1Ugg==
X-Gm-Gg: ATEYQzz5eiWxLnMEEMIGvcI5umGXqeE3A9u9QpAVj6SKaUuma9QYyEmB9Dz9tISlrX+
	STUZRo6tV4RrsAh83nSRTGSwknmFveDZz2Lxs8wu8aue1UdmOhGOK5NU74yOQ/VNV044DMMv25u
	T0n8L1cVQV1XCe941VS1CgCI5N597KKCUndspXgcVamrjQRigZv1eDnOi/tEKsWKG+1mAYcM2Xf
	nHMWsAsNhH56T3Vn/ou/sdcS39wZIxpzXDisyISMgnejC/9oK6usvzDVj+eGv8rh7hDHBsi2RWp
	6uLmkA7z3kz5hd2C9EfoGq+oQ5zBileD3W2ypAR1a42hWqj2zk/K25UId155aVk2AJvZWIh2mBR
	eC/hJkt1lEPTNq3dRLp5ZGnk5ZjuCisg7qEdDUhjqHDELqdF8quwQm4lwx26nelZL2sp0aCoZ6X
	2zL/cpnmKK4I3f65IeKU2zS09sI3PtyvD/HPmzH8PAq4js12oQKUm2c2iZ0WVORF1DWJ48G5IUN
	FuX8m/ys3AV22sHiVZYvxNhLfPonkTbCC4RqQ89UBbQtLzx5FgPDM6FBt5raQ==
X-Received: by 2002:a05:6a00:815:b0:82a:81b6:d8a6 with SMTP id d2e1a72fcca58-82d0da7f8d6mr1457082b3a.25.1775181835117;
        Thu, 02 Apr 2026 19:03:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3baffsm4446537b3a.14.2026.04.02.19.03.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:03:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 1/6] bpf: Do register range validation early
Date: Thu,  2 Apr 2026 19:03:45 -0700
Message-ID: <20260403020350.73823-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
References: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Instead of checking src/dst range multiple times during
the main verifier pass do them once.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 34 +++++--------------
 .../selftests/bpf/verifier/junk_insn.c        |  4 +--
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..8234d80b892a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2249,13 +2249,6 @@ static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
 				struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs */
-		for (regno = 0; regno < MAX_BPF_REG; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_known_zero(regs + regno);
 }
 
@@ -2908,13 +2901,6 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_unknown(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_unknown(env, regs + regno);
 }
 
@@ -2947,13 +2933,6 @@ static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 static void mark_reg_not_init(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_not_init(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_not_init(env, regs + regno);
 }
 
@@ -3958,11 +3937,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	struct bpf_reg_state *reg;
 	bool rw64;
 
-	if (regno >= MAX_BPF_REG) {
-		verbose(env, "R%d is invalid\n", regno);
-		return -EINVAL;
-	}
-
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
@@ -21953,6 +21927,14 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 		return err;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn->dst_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->dst_reg);
+			return -EINVAL;
+		}
+		if (insn->src_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->src_reg);
+			return -EINVAL;
+		}
 		if (BPF_CLASS(insn->code) == BPF_LDX &&
 		    ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
 		    insn->imm != 0)) {
diff --git a/tools/testing/selftests/bpf/verifier/junk_insn.c b/tools/testing/selftests/bpf/verifier/junk_insn.c
index 89d690f1992a..7d10b0a48f51 100644
--- a/tools/testing/selftests/bpf/verifier/junk_insn.c
+++ b/tools/testing/selftests/bpf/verifier/junk_insn.c
@@ -28,7 +28,7 @@
 {
 	"junk insn4",
 	.insns = {
-	BPF_RAW_INSN(-1, -1, -1, -1, -1),
+	BPF_RAW_INSN(-1, 0, 0, -1, -1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unknown opcode ff",
@@ -37,7 +37,7 @@
 {
 	"junk insn5",
 	.insns = {
-	BPF_RAW_INSN(0x7f, -1, -1, -1, -1),
+	BPF_RAW_INSN(0x7f, 0, 0, -1, -1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "BPF_ALU uses reserved fields",
-- 
2.52.0

