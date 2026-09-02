Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA52E0B71
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392233; cv=none; b=Pp/3PZJGzoFuP4IDi3Qjg+TpAX4mWMMNCMdzobiyV2ypzQcgvIVyqbWYXNNHQQY4kzWhLs1i4uTinBLieE9MjVVYanhTJM/RAhhFS07I+ppw4DJqtDPcFTQ/udSS3SYE7Rfov2BeyWCcVTTeKN+7WkD9RkWdUEUJXz61TJsG5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392233; c=relaxed/simple;
	bh=UyrPsxzTRystKOQjqIJaXjSc7NVFMatc55rbgL1x2ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PclVj6XqoGImum/261yRAa9GihML6oEBvmHIHtFFo1e5ICX1ln8oNMnqt2ZaCJG63STfq9WYvJulLYtz55Us07tB4NGY1KmyuWwc4DXxQ6yooJUWvrmgTRwAstxjv+bszDRwTwlitvqwRA//l5oNFVbAYaKtw8YPIucBO7g6CLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0OKaLhs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0OKaLhs"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5cad1a6baso16111355ad.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788392230; x=1788997030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2jzYBvvyBI1YbpyMbJLodew59SQxOrHAf/6mf/TImE=;
        b=Z0OKaLhsggsPdyTnI3X6breUMXZE16uuA5vK+FHM05/OgQrdMi+D4XBaHx081vmyhp
         WdGx/zQWHWbW3knUHEh2IIg02T2jIVmTGsbBu/jkm348KKDy6PsA1Dj2NtMINhX5cGha
         6gs2TMQ8OU8HMv8q1AKQ4os84oz7Ox0nLrqKnZ0GmW5yBWEp6DdGLRfYW9jLnkPTQWZD
         nih4KUPa3n8YmJI8+7hwZImsxlY68ibagAQPlC5cWGfoZcGeZtJ2sxILaisCbNxu3/fU
         fyq4UrPusbG0ANIjJfYFkovsq2aVAs/+OS9MX1WWBwsQdGPTgnfObRXKXCPB1kxyJh0r
         WYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788392230; x=1788997030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2jzYBvvyBI1YbpyMbJLodew59SQxOrHAf/6mf/TImE=;
        b=qHgUy+DuD/9B0ureYCrit4QZj7BcJFAFmgz9E8erYSS5FAwa6P0NEyjUkIh7ZIAIJj
         LQ/JPWcDk0GUf3FOgSsHklavN8E5rue3L8iowUjZRcRWxuWAmsPhRkvkAkmbKY/tR/B5
         jqEcHNAtB5qJvKNRNlGLgk65yK23M4VWLssXkOjQ7hAIJzwHO1ypzHOWIJmKNxJmz9ZM
         mY0Jc3PvCkxx/nP9h1ZUbxVBCDxCQqBLHuUnECxYQEf225suTJ01s5UVEgutGJXa89Sc
         OcTkkwQPD0Ua9bYwUdcvsM/CYUGhUocEEBdZTvZ105+yDFdC10cyheGvGKK7KJ8RLg+I
         OzTQ==
X-Gm-Message-State: AFuF++kiomEiM/VR/ClWNv+gp4S/cjmf1qF/IfhIMKXMvMhhat5561Rs
	V/Ep/xuw/0R0XXQAcSsCwRokcaNAOm/Udt8o7aGycuN0/FN5HxrXMXNnPXgI/mdu4Ps=
X-Gm-Gg: AYBFou1deFy2vfNS3vXuGna2x0WvDSJU1aUK1zxSu1VLZo7qbHD83oXI6zSXuSiATBH
	PiiROhm5YkDX9N5cQfP5QyQ41jwSgdWHT6OqPB/SMiXgAGXypPEPcMZNmZ5bkrHZGcw2Rb26U6c
	NhECZMAayOp7fWIZ1D1zhQPIiR0Yx86+B2QvBXFYXRFCbTpmEmXn7smZxRvh2OxC7G5I1Ga5oqj
	BmotBBGYr64E0QH3Xx8TEx2iK1tEa6dGhNcleK9ptwAeaFVoF6XmqJTeP5gkeAzy7eqFaGRxsvX
	aJfyF98HVmTnU63ZtaIDrxlgwqr0bDKs/F3YZxQ+HB12MOb4+k5lFhfc1BQNM2Cy2A5Stsvaxn2
	hG+BVBuEadS/1KU+HFXd6LpxOpNLoPj8CpiQhx29pztt2UNEYWSWcI/RYIg4YugZtDOi6ivvO3g
	8qQQIrCd5g1sDayIq6jIkyllhmrPCDyiezZFXxaMxO9Ynn10r40JQ/2V+WnaDe8+JxVUKUKadLT
	85sz8DAJAVHJwyHD7JQpIYM81YYElEmy0yIkmnnSlV/2w==
X-Received: by 2002:a17:90b:57eb:b0:398:9be6:f995 with SMTP id 98e67ed59e1d1-39aee1110f5mr12416164a91.20.1788392229570;
        Wed, 02 Sep 2026 16:37:09 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33253672933sm2583725eec.4.2026.09.02.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:37:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 2/2] selftests/bpf: BPF_PSEUDO_FUNC reference to the main program
Date: Wed,  2 Sep 2026 16:36:58 -0700
Message-ID: <20260902233658.1186477-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902233658.1186477-1-eddyz87@gmail.com>
References: <20260902233658.1186477-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for a BPF_PSEUDO_FUNC load instruction that references
the entry function of the program it belongs to. W/o the previous
patch the verifier accepts this program thus allowing a runtime call
at a bogus address. See previous patch for detailed description.

Main function needs to be marked with BTF_FUNC_STATIC for the test to
trigger the bug, the patch uses test_verifier harness instead of
test_prog because libbpf has no way to convey this.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/pseudo_func.c      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/pseudo_func.c

diff --git a/tools/testing/selftests/bpf/verifier/pseudo_func.c b/tools/testing/selftests/bpf/verifier/pseudo_func.c
new file mode 100644
index 000000000000..63c5c67d51de
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/pseudo_func.c
@@ -0,0 +1,45 @@
+/*
+ * Buggy verifier accepted the program below while not patching BPF_PSEUDO_FUNC
+ * load instruction to contain a real address. Which resulted in a function call
+ * to a bogus address.
+ */
+{
+	"BPF_PSEUDO_FUNC reference to the main program",
+	.insns = {
+	/* r6 = bpf_map_lookup_elem(&timer_map, &(int){0}); */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	/* bpf_timer_init(r6, &timer_map, 0); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_LD_MAP_FD(BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_EMIT_CALL(BPF_FUNC_timer_init),
+	/* bpf_timer_set_callback(r6, <insn #0>); */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, -15),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
+	BPF_EMIT_CALL(BPF_FUNC_timer_set_callback),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_timer = { 3, 9 },
+	.result = REJECT,
+	.errstr = "callback function cannot be the main program",
+	.func_info = { { 0, 4 /* main_prog */ } },
+	.func_info_cnt = 1,
+	.btf_strings = "\0int\0ctx\0main_prog",
+	.btf_types = {
+	/* 1: int            */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	/* 2: void*          */ BTF_PTR_ENC(0),
+	/* 3: int __(void *) */ BTF_FUNC_PROTO_ENC(1, 1),
+				BTF_FUNC_PROTO_ARG_ENC(5, 2),
+	/* 4: main_prog      */ BTF_FUNC_ENC(9, 3),
+	BTF_END_RAW
+	}
+},
-- 
2.55.0

