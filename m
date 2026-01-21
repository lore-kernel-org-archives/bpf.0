Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41302D7DFE
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970649; cv=none; b=ZiWl1wLVoGUYtJ2DfnvXrv//joh++j+jKk6Hdce6+TYFtQLSbgKUElvjJ8lUR2huuSgdxp9uNUDND7D8i0M+XO84a45s/5SOBeZJvNf3GHmhk3UdstmzMztWPawn0udak8/5aDz6z5FkSrhYPFxgUnYTIaKLrWuM0yAtwU9FGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970649; c=relaxed/simple;
	bh=/tEYBlRULVvkLeB76xmCUAWDFSQE4AoadZrfuKWXOFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlJ7lZqrOqKPkbiXA85eAO8hA9y0iQlA47fQUpo1qK202BSHNuLxObFVmkPCGdZet2hOaAjJBjRLfp334mVCzhYp329ftZ5g3I+rZWW2X6F2k3MvCwH93LTBXZnZlBpCUo8YNndECzHwc1rDESH1bbZuFgKIq4CJrdl+hNsoS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFA5A9aX; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFA5A9aX"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so1483965ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970647; x=1769575447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x61tdpYrSBGuJhFRwERbZzIz3z8AUYfOzinRogdRAfQ=;
        b=UFA5A9aXqKtO2WV9vrlHC9a9xV21odJLaV+eoGBv8P/eebZ/skMsrs0CawG1Qqpk36
         qSmTFP3ZHNMUj4nucUtRT5wB1IAgyRMi4esooz1wZxQpKPNINac21/VcnsFn45i+FX7m
         dQCro40v/0X4TOM+RMzFHEVXF8X25816i4IsgorelWYrjm8r+/ZQNsYlOtFN2NOOstZ2
         /z/1C7c5vRdUOMkJkeuMdPA8eU8Q2XfYXriSCKSJvavyGj3B5pqrYvsqs3cwiDGrOq/m
         I5qyP/cMYEDMQoff/0PurAaREza+34dc6x0jVY2yQ+zEfHoS+9ip+NRry7YWPu62svtq
         u1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970647; x=1769575447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x61tdpYrSBGuJhFRwERbZzIz3z8AUYfOzinRogdRAfQ=;
        b=bN2QNx3W76OckODRLc2yRVj7QpVCGI0bqB4/PR5D341Y7fGbVKyqA/rDAy8IgwojsQ
         Yld/Bq7dNH4mraMEtf9z43H3c+VGSzng/PJM33uNDQmrtPeHtwQy+aozqlD4yGcvGl01
         CiN8FwN0IJ0FVo3kOIby3DMgTBMAt7Lws2Z81n3J8zgwS7UJ+j45Tpk8RimCCVA3KpuD
         prRpJtqSKBAxonnP0+tg2T4uU0Ixv3NCVaRYCTvM0XyQh2Qfdbkv9Fgb8SUmG2VNQiI9
         7I/P/kt/rLaCgZ06d+r3l6oGxiSuCya0+wOl1VEp2YqPcJJKtkWCkqtgog9wL3TxnK6m
         uoHw==
X-Forwarded-Encrypted: i=1; AJvYcCVtKRnw28EjYzZR++VqpT1vGk5W5rQFqLT+R8BNaqTGyH+m45aLGsFztVDhd6KQYhN9eQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkgi6hDxchbLM2jLPxEyLZ4za0eNSS0wYxzBNw6lbp4SpdHX1u
	GSf2o6sGsEtPZejcINtc4Yy2LwSaRxfJYv1zm2OXiYcLIde9s0CG2IDE
X-Gm-Gg: AZuq6aI/0RcoBS19LIbEZN7E+DlSQ9Q9xfSKjS/GQui8yrICmuHMzfnWvjglBDRlbly
	QzWtfOkX15kwuTH+DWh45jITt5Gj+oyWKfI9ievAlYdF2c8lrhX+9V1IHkLvBD5Ws3orqQxygY4
	GB0cmnsL/UdoM4ktOk435q9j8EfDYyZMdRaxWNKVcp4SSJldbza3IBvO1n11hZ9hcEHw+vJ/Ta+
	Pm/pcaZOMXnPOvExTc+vCA9CQdWTcQlcfYKoeNXIQnnrHoo/2OJizMmRYLzaBISn32Kz7zNoaeS
	ZBoeNKc4ObIUkEBPn55SjAyzkkkSCYBSwAkUv1+8Hs8vs2sB/BCi1T+rW+QMPXYwYW0c2YWd2C2
	Xa6aZubtO8Jn3uv+UUFFHtlyq3Xx7GUe685zV3jrIWWwBYHrHKeyiXcH2OlvStZnL2ZTVpd60zw
	2d8U1exHEw
X-Received: by 2002:a17:902:f54f:b0:2a0:8be7:e3db with SMTP id d9443c01a7336-2a768d75158mr36337295ad.15.1768970646715;
        Tue, 20 Jan 2026 20:44:06 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm139754815ad.58.2026.01.20.20.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:44:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Wed, 21 Jan 2026 12:43:47 +0800
Message-ID: <20260121044348.113201-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121044348.113201-1-dongml2@chinatelecom.cn>
References: <20260121044348.113201-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
tracepoint, especially for the case that the position of the arguments in
a tracepoint can change.

The target tracepoint BTF type id is specified during loading time,
therefore we can get the function argument count from the function
prototype instead of the stack.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
v5:
- some format adjustment

v4:
- fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER

v3:
- remove unnecessary NULL checking for prog->aux->attach_func_proto

v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 22 ++++++++++++++++++----
 kernel/trace/bpf_trace.c | 10 ++++++++--
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..c3f8870ac5dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23323,8 +23323,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23376,8 +23383,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement get_func_arg_cnt inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f73e08c223b5..73c8f92c5d65 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1734,11 +1734,17 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
+		if (bpf_prog_has_trampoline(prog) ||
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_proto;
+		return NULL;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
+		if (bpf_prog_has_trampoline(prog) ||
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_cnt_proto;
+		return NULL;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
-- 
2.52.0

