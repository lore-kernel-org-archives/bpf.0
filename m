Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F44E06E1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292716; cv=none; b=LA1/TzNmAI3kUHfao8jZKFj4fuf8p/daHmLtMgRu499U5Y8uvbRlGUgOemi26U9ApYPTvyz2A8wzswpJeGEga9nLtMDyFmCLG7gA3ZezrG1ApFoemM+UJrpA9AiVK9kf35/sG43Roqkx0YbQsWkmp8WkYn+DyE8e2QbY8BgXCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292716; c=relaxed/simple;
	bh=8UXlR2GW9kltXCMw+7En8oeHk3qgDGTTG9i+sNtjgQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyRszKrsr5iJnipwEXtNVHRtMQMq8fhvNwTTCBPiX5FG2Np7LETTZmycAWQHXXrduRYzOK+EMufUWdtlvysDv7Bt/ZIXQhVVfp+Cbivoh8WWQALMWzALr9GelcS6j8YKktHN7L4pgtIzIu8Smg34pNxWtguMEw48FG/srLZQ7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpr5vJnm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpr5vJnm"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so279579a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292714; x=1790897514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miMw08SQyTCte99qbb+OZkJNkGFzKVJzDGDGE/zoiUU=;
        b=Zpr5vJnmm86CcZsOujCcEubcp7MWRy1Ak3D4+TqxNbvPC7Oa0oHEdHy2qekaA2ZhIS
         Ir7SySf/dQ092yqp67awW5hj915ZPgIhEECjc1xZsUilPjLSlelQmz4FPE6rKnETQDFK
         8ID6nvaFHMVzpiS4GOPtxVVEGSTpBgkzvnp8lc6HGy7TRGDpxaO7p7fTBMXD2kNk7egR
         TkdCxV0TxKeVLsbHGEi7Be0rHj/fYklYcbr+8djP5bnTQpyihHM9flZhNc/w+LXfwht0
         kY9Vct4mHsitIbI4c8i/5b9t1+8uXjC8mkCeEQRUzCh8fRYLmGI7LjnVPSt1UsiJwH0U
         HclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292714; x=1790897514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=miMw08SQyTCte99qbb+OZkJNkGFzKVJzDGDGE/zoiUU=;
        b=AtPfcXctqhk8oSwKGvunXU9lCig8BNI7qFKte0j40xXdHZEjapE7TPlzoYAIVPFr3S
         nqL4wPNOJ9IeHEK6eYhiGPXgp4cQ0fZw1RvRBCf5qUP+XI3cl2EF58+rjWAAb2hYmpKc
         G/KcXKuhUtq6M9dJ0iSgBwmIX/VXAIEtwXp+cqwOZkF76SQ21qVFBT2i73ivF4D/2lP5
         KPLiMQ5WiB0WtQ2wnqjQ/ZDjJgjgJcj5DAw7t+g9txYt8uOTOkiJCqjcjIZpRuwqi/1i
         QChUIZZQh7conYxC7efrm6ngCm52NcTFTrpwI/v4lf9vyw4REqFuSp6GD4uV8usvLtfb
         nhIA==
X-Gm-Message-State: AFuF++mc1SVJZxjyJpCIfpPgbGyJmhppKHoIs0E5z7KZhBc682zEg3/F
	jwfahhOyDjnSKLTcr5Au/hiflls/tdLrVFfLjHTwBF3R+FCWOx6ErCdmMZypLQ==
X-Gm-Gg: AYBFou0gCmoF9thiM7k7zO98NEDaZG9q+8MCq/3brICehM6qGmmddiqR3+iYpbV0v/+
	OUbhaF+CR5UpxusPKSW/yQEKIogTGLY3JTkD5FN15CwrdU+S5gFXkYy+KHbSBI1i4o4G/9En5cs
	EIW6/E1g67McNsByQu3YD/k0k3vJ1AmEMln3TSMZoH6z20ge2AIQ39a9l6Ymk5mC0EmJcskONB3
	pF02JSPjsw8EmPVD0AQlowvYzoBChZ2IBbJfNVQvdiGmuhipL6+eREkcJO7jq3qJJjmvx2NHYn+
	2jlddr7KJM3PLnKENVxxlT9duwjGyNxEyDt5luhBRoh453zETqvvOTCRKGOvo3boRialqBllneM
	VW/SAoEJo7EgQ6logJ5O1agddVga7rjkj3LdysqPs6wEKSALQr7m5Co3u+NxYp7MnW1FXzqsZzi
	AWurCRM4Rbm4rHvGyeuzuhXifY+3sazoSXdRgcPEoRKU79Tcl8jm63L2PuahS5OP5lRwaostrmK
	JO8/qhNSCHfUWlHmgSMj7sbupci+XbHICNqS69VD+Da9J0/DtCx1NL6D4t44AEskXstkLgn09W2
	t8Nx8RWn83QxO6LnMAUvj94QXEIiFXcopb0YX8OxSIlj
X-Received: by 2002:a17:90b:4c82:b0:39e:6c68:1552 with SMTP id 98e67ed59e1d1-3a09896ee0fmr3297950a91.26.1790292713643;
        Thu, 24 Sep 2026 16:31:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm895785a91.6.2026.09.24.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/8] selftests/bpf: Add tests for may_goto with far target
Date: Thu, 24 Sep 2026 23:31:28 +0000
Message-ID: <20260924233130.1213812-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Generate syscall progs with may_goto that jumps up to 32767 insns
forward and 32768 insns backward. The prog loops until may_goto expires
and returns 0 when it lands on the target.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/may_goto_far.c   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_far.c

diff --git a/tools/testing/selftests/bpf/prog_tests/may_goto_far.c b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
new file mode 100644
index 000000000000..8d0ff30bd068
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <linux/filter.h>
+
+#define MAY_GOTO(off)	BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0)
+#define FILL_CNT	33000
+
+static struct bpf_insn *fill(struct bpf_insn *insn, int cnt, int reg)
+{
+	while (cnt--)
+		*insn++ = BPF_MOV64_REG(BPF_REG_0, reg);
+	return insn;
+}
+
+/*
+ * Syscall prog that loops until may_goto expires. Its target is 'off' insns
+ * away:
+ *
+ *	r6 = r7 = 0, but not a constant for the verifier
+ *	r8 = 2
+ *	r9 = 0
+ *	r0 = r8		x FILL_CNT or 1
+ * 1:	if r6 == r9 goto +1
+ *	exit
+ *	r6 = r8
+ *	r0 = r9		x N when off is negative
+ *	if r7 != r9 goto 3f
+ * 2:	may_goto off	(1b or 4f)
+ *	goto 2b
+ * 3:	r0 = r8		x N when off is positive
+ * 4:	exit
+ *
+ * The prog returns 0 when may_goto jumps to its target and 2 when
+ * it lands in one of 'r0 = r8' areas. There are no constants between
+ * may_goto and its target to keep the distance when constants are blinded.
+ */
+static void test_far(int off)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int front = off < 0 ? 1 : FILL_CNT;
+	int mid = off < 0 ? -off - 5 : 1;
+	int back = off < 0 ? FILL_CNT : off - 1;
+	struct bpf_insn *insns, *insn;
+	int fd, err;
+
+	insns = calloc(front + mid + back + 16, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "calloc"))
+		return;
+
+	insn = insns;
+	*insn++ = BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns);
+	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_0);
+	*insn++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 63);
+	*insn++ = BPF_MOV64_REG(BPF_REG_7, BPF_REG_0);
+	*insn++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 63);
+	*insn++ = BPF_MOV64_IMM(BPF_REG_8, 2);
+	*insn++ = BPF_MOV64_IMM(BPF_REG_9, 0);
+	insn = fill(insn, front, BPF_REG_8);
+	*insn++ = BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_9, 1);
+	*insn++ = BPF_EXIT_INSN();
+	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_8);
+	insn = fill(insn, mid, BPF_REG_9);
+	*insn++ = BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_9, 2);
+	*insn++ = MAY_GOTO(off);
+	*insn++ = BPF_JMP_A(-2);
+	insn = fill(insn, back, BPF_REG_8);
+	*insn++ = BPF_EXIT_INSN();
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", insns, insn - insns, &opts);
+	free(insns);
+	if (!ASSERT_GE(fd, 0, "prog_load"))
+		return;
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "retval");
+	close(fd);
+}
+
+void test_may_goto_far(void)
+{
+	if (test__start_subtest("32762"))
+		test_far(32762);
+	if (test__start_subtest("32767"))
+		test_far(32767);
+	if (test__start_subtest("-32767"))
+		test_far(-32767);
+	if (test__start_subtest("-32768"))
+		test_far(-32768);
+}
-- 
2.55.0

