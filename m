Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F64052B7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796711; cv=none; b=eO2/YOIPgi1GtiysSFT+7LqAwq7kxFIuF6zCxWsj47fNMtjAMzuw/YGVwt8yoL8/46uDmIH6iMeL6LphH4Kw4vxsY8jhGRbNSLTEW7u3PLBYit6/YwFXjgzajQe9gksvVdydbFpTP0ufMIAUiVg1lx6o4p0+vdjTlbqHK3DXqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796711; c=relaxed/simple;
	bh=K3EeLIofe7g/58c9JRuYUukTNNq7bZsNP1LKI06JiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikz28IGxm2asrhG2B0qg17/GYB4BEgOrk3zLFIp+a3MkyWO3IhjefTAhguwmYvqSyI/1wuKGe5OK+f13VZu02ed7PKvxyTp0qIW3N3wssojZMWnP/xbz8IQPyzp2TR7Fkk1Dg1b0MGoRknypSC6K92BSqDD3AwaCZFq9KvwmMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovWIT7kF; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovWIT7kF"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso1834621a91.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796709; x=1791401509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZrMgVuwC79fUUzmv8j3ElA3MI6K/uZQCWy7pwDWg0Q=;
        b=ovWIT7kFC7YVmAYEN5iCkrQ7NiLB8iVo7zT3iiyPczkmy7MujzDNe6ISw8imMTNbA8
         DAn9t/ceLTDuA3H2HEMfRwrHkiDn0jOf7v2RP7ttj4uDdIgCiR9zy6cpv1Ti802XpYVe
         zdGroj2yJRKTo8TZ35eLn+2Lu3WlK9p0m8zNpY9YDff0lWG5vaNhRJAmXOYyMNu2ofWM
         4sKDjulZXmJWmz+V2Sh8EmuWNPnBmfIvycOO7/QtC9JlwEVKm7sDTL3yh9KE5t9uAiZ4
         LkEllhE7rPA8dS42X56siO2h9EL6V2wcVJz9NKX8yf4TgOzLHC63YJ2XnNmhmi++kD8X
         6kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796709; x=1791401509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZrMgVuwC79fUUzmv8j3ElA3MI6K/uZQCWy7pwDWg0Q=;
        b=LmKu4qTsnYkYF0Lg4QZ0v3iarr4dirqgsmV7aLU1P+V4/A0M4e/Adq3AAjmpkIF0GB
         mpJarLjeDdxwh/lP4tH6D32mbBUe7C9WoPIWfgCH4mPfpQSI6FbTI+5u377AqoMAy9pG
         19tgTlY5/XAnXYyrFYN1C2AZyMy6JJYJ+wDZpZG4WpOETqVZp5Whr/h/TdyK1nbUHjmZ
         aS2f2U+KQhqvu4VhUWk3S+i4qWwuluY60KZD0/VTJ3rok0muvDLe5QWAn4g0cmtEMmhl
         EaUQd3l4h5kQeilAtccCFHegMzzATGWbU/9m9wTJTLwrLudcl+OQAgEfTSpD9d8RmNIV
         2vmQ==
X-Gm-Message-State: AFq9FYJ7nCYxKqBbGWUwwizr+t0fAOTRGRc66l0YemQShr9XdDdqN1GM
	IH5f6o3ojqHsFy2yh/ryCeLoPVWl9fSR6zy6w8nuR2ArdhKY+TRKi0nU1BHdiGoA
X-Gm-Gg: AYBFou2PJhe9kFFTxNmme0Q6zu8/s8GRmBj1sZnfran5jZ1Pktif2DFjQ8JjelVo70t
	q4glkkGEbbx1UYmKYTgC1NH5p3WoFXYYKtGLr+3ktpeEy9xzDiIi3ov1nh3SRMzN0Zl51QnEejl
	4gHolmMdYAIgkf1QcUxTMzEynquOTu+mq5m8EqsgkRUWm89TLsH+r57fWACuBuTQMNDRT1c4NcL
	EnxHZ3ZYjr8taPdOfOjjzR3eu0chgircG3HIMCLcc+ALPfiDv6HYK9xGAD395C2wBGVfFudKfQS
	P/m9YKsVvfyMLgVR8TdCxuK6nY6m3uAOHmZVC2zm8ndD++Yzg/zBRsY1yaYC7aULNg+zNU1uvyx
	4LX9c3BKh244/oaqT9s8gbJyaw8MwnMOzewmEpe3Mqx4Vt7ceuMqT/0YVxLkVcnp8CzEBcjpwpd
	39wyRQBLrjhZM/WnlYxYQj0xoLTd+d/KyhJ/B/L2s8XKiKW8JugkXfMAR7bjoz9PycvZexOsoF1
	lJwszBLbJyVp0FAgd+/0Ny2sbnIbOY1zT7I3PtZxtoTx1VI6CAtBjW+CpSTUwqdDC7IdLKdHz3L
	vxek9CsLxuCKi+8LvDn17b8BAAWNLmtFl6aZg2sskrm3eKxKnv8HZA==
X-Received: by 2002:a17:90b:3ec2:b0:3a0:b40d:827 with SMTP id 98e67ed59e1d1-3a4d059c0b5mr1569885a91.0.1790796709209;
        Wed, 30 Sep 2026 12:31:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f439f9f9sm729558a91.1.2026.09.30.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/14] selftests/bpf: Add tests for names of Rust types and functions in BTF
Date: Wed, 30 Sep 2026 19:31:19 +0000
Message-ID: <20260930193127.2181684-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that BTF with names of STRUCT, FWD, TYPEDEF and FUNC that Rust
makes is loaded and that the name of FUNC is an identifier in kallsyms.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 15 ++++
 .../selftests/bpf/prog_tests/btf_rust.c       | 82 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_rust.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 87b554067071..207341f4bd99 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3593,6 +3593,21 @@ static struct btf_raw_test raw_tests[] = {
 	},
 	BTF_STR_SEC("\0?foo"),
 },
+{
+	.descr = "names of Rust types and functions are ok",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(NAME_NTH(1), 0, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_NTH(2), 1, 4),		/* [2] */
+		BTF_MEMBER_ENC(NAME_NTH(3), 1, 0),
+		BTF_FWD_ENC(NAME_NTH(4), 0),			/* [3] */
+		BTF_TYPEDEF_ENC(NAME_NTH(5), 2),		/* [4] */
+		BTF_FUNC_PROTO_ENC(0, 1),			/* [5] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(6), 1),
+		BTF_FUNC_ENC(NAME_NTH(7), 5),			/* [6] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0u32\0Option<&str>\0__0\0*const str\0{impl#9}<[u8; 4]>\0self\0fmt<str>"),
+},
 
 {
 	.descr = "float test #1, well-formed",
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_rust.c b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
new file mode 100644
index 000000000000..b0128daceaa1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define FUNC_NAME "write_fmt<scx_simple::BpfStream>"
+#define KSYM_NAME "write_fmt_scx_simple__BpfStream_"
+
+static bool kallsyms_has(const char *sym)
+{
+	char line[1024], name[512];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/kallsyms", "r");
+	if (!ASSERT_OK_PTR(f, "kallsyms"))
+		return false;
+	while (!found && fgets(line, sizeof(line), f))
+		found = sscanf(line, "%*s %*s %511s", name) == 1 && !strcmp(name, sym);
+	fclose(f);
+	return found;
+}
+
+/* The name of a function of Rust is a part of the name of the program in kallsyms */
+static void test_func_name(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int int_id, proto_id, prog_fd = -1, i;
+	struct bpf_func_info func_info = {};
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	char sym[128], *p = sym;
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		return;
+	int_id = btf__add_int(btf, "i32", 4, BTF_INT_SIGNED);
+	ASSERT_GT(int_id, 0, "int");
+	proto_id = btf__add_func_proto(btf, int_id);
+	ASSERT_GT(proto_id, 0, "proto");
+	ASSERT_OK(btf__add_func_param(btf, "ctx", int_id), "param");
+	func_info.type_id = btf__add_func(btf, FUNC_NAME, BTF_FUNC_STATIC, proto_id);
+	ASSERT_GT(func_info.type_id, 0, "func");
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf load"))
+		goto out;
+
+	opts.prog_btf_fd = btf__fd(btf);
+	opts.func_info = &func_info;
+	opts.func_info_cnt = 1;
+	opts.func_info_rec_size = sizeof(func_info);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,
+				ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_GE(prog_fd, 0, "prog load"))
+		goto out;
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(prog_fd, &info, &len), "prog info"))
+		goto out;
+	if (!info.jited_prog_len) {
+		test__skip();
+		goto out;
+	}
+
+	p += sprintf(p, "bpf_prog_");
+	for (i = 0; i < BPF_TAG_SIZE; i++)
+		p += sprintf(p, "%02x", info.tag[i]);
+	sprintf(p, "_%s", KSYM_NAME);
+	ASSERT_TRUE(kallsyms_has(sym), sym);
+out:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	btf__free(btf);
+}
+
+void test_btf_rust(void)
+{
+	if (test__start_subtest("func_name"))
+		test_func_name();
+}
-- 
2.55.0

