Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2B26ACC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181839; cv=none; b=mNX8c9GklIUaIg27eA0WTuUFU3av6lNAZRpD7w2dlP9t4SxMdq4QCL9bw3LGHJcuUeSnfFBYLt2uB0kQHsIpJC3GGb6xkA7zipw5HuILbHuIbnA3dGzFfklXqsknA61BtW2+kgAEwyVb1M2KzyderELEhsD3BP6QJ6JkMoXrzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181839; c=relaxed/simple;
	bh=7fEj5J/4I1R0Kl35vzS1uw/WyLdfjTtL4m0rHVRxsCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjwb5ehydHpS5iQpiOHtczoCoTURi529rTi7bhv8Q4cS13aufXNUoK6H0GDP7U3Zz0ZAkzP8nfac5tS00IfQ56HbybNZkUvv8gRD/k4CC7+/e5VMvBH1I6JgVV6q/CANKIuWdEjFll0kuA1yr1aeVV4kGXLcXX2Q0yd3Viti9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVVikU/W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVVikU/W"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b9efc299so611644a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181838; x=1775786638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuUFJ7Su7M4Un2BoaSlt0H+1nvr9x4vJo2MbwD/n8HA=;
        b=cVVikU/Wd0dTtGlgJUrcQXXibpcJ4LL5Z56WCNAJVNDNLAE/M7hQD+pRLGs0gLNCyZ
         Ni6fqGj5iOSn0QL72hDpsydA6NyMV6X/HPm7uJhQto8Dzv+nxglMiJktZ0XvGnc2ww6K
         079cGTAoLEHpzQ22yO54ywQ1L4sahck2hadu1PSbHZ+nXfW5BAokb68ZNwGg5zBqhnYX
         /sL0UfGkGhu02FDt/OC7VHcsHLUAHfNWQA+uyVbh6HZZllH6rB2WkcFm2UYMutNpEOU2
         NBEzAkQTISGhgzof3pOW6R0TzTXtRF7Cadnf1bJoTBJSfcPPwUszaX6/uAl/xx6Y9laU
         IlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181838; x=1775786638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuUFJ7Su7M4Un2BoaSlt0H+1nvr9x4vJo2MbwD/n8HA=;
        b=bJvdDqAP71Gb9yFISws86sdnW0t/2HxU6vYQeP8H1KUw7mxDXj2N03sFHmEkK1Ocyj
         3JtapxbkAayBXqi4wz03vmwJXLSgM8pixGjOWHUl4xOiafeA/vEsX57ZfIWa/tEN93C/
         XbkT/rUD/i7a2oamkMaBzRiCHGaKvelBh+Xen/vpF7ff6JOSSOFjhkytEI667LguGlmG
         JXN49qjHJmW6i/wmQioIIx32FY/6U3Ocr/9wLBPZyQqdsI7N/AqV+F6iiYD9w9tnNUrT
         /LBsOYT5lVskBXlQ7VlMYL+I+uOIV+VFbUWn29mCFtYo17LJcEFhlugZ+NYlkUYXf2mX
         k/yw==
X-Gm-Message-State: AOJu0Yyhgfvf765/AGt6Nw/rtfKfGbzVb2l3Gk3sNjcHhl1GxeCGBPf/
	/xPABFMExdch3TJNdkAOr0z7EiezmqqbUplgKtJ5YoQHVqGemwuRcOOwqSxecA==
X-Gm-Gg: ATEYQzzS1Na7iDZMVHUnDpPAohOCjA9qam5JL353vNMwxlmjaRGc7ESHLTA1fK8PwFl
	U2DoYOu/0tYhdpOD+BUXNV76Rgguaf45IaNlRfz/Z9xdSfwG5Afzam0ZxLtpN8TXxgiKczLcFb0
	qec+DvJFKnvZwUq3lm/KhfBFT+lgMslWX9HN9DB6LfrIHeOL0qH5ljSRGTs4EVSWN8Q2LaDCqTg
	QIjxBhw6Wd9xMqeg2J5NSHOc8/2Z2Mxi7q50BaIUm8LhNnYtR2mfGyay8hBs4ichExWf6Z/IVCL
	s2stVSF9muC71MxtzpMXBvzhVBYupv6Aa6nN+YNteYm4wmWfCLkzzOfre7unwKZ3oHUMIBMvtIl
	LEJh9w/cGDsOZPVsSZqZ2n7EnTu2KI739F612W+oG0wx4bKC5yVNNaRBX0PKBJN9dBr/PhfdGB7
	TfmljWdDreFnsgsaOoK8nkNQCkzNRcUSAZgnU7jwjn0Oj8/3TxXIwX+FTCZ6H/Qs2BE+oUbezl5
	pnNlJBT6+YXZY9M9yx8VQbpiPjayDMwxJZsRPncH8+1+LwW1x3b+nwla70vig==
X-Received: by 2002:a05:6a21:3283:b0:398:7d4a:c2c4 with SMTP id adf61e73a8af0-39f2f09882bmr1109198637.48.1775181837634;
        Thu, 02 Apr 2026 19:03:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm4474385b3a.35.2026.04.02.19.03.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:03:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 2/6] bpf: Sort subprogs in topological order after check_cfg()
Date: Thu,  2 Apr 2026 19:03:46 -0700
Message-ID: <20260403020350.73823-3-alexei.starovoitov@gmail.com>
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

Add a pass that sorts subprogs in topological order so that iterating
subprog_topo_order[] walks leaf subprogs first, then their callers.
This is computed as a DFS post-order traversal of the CFG.

The pass runs after check_cfg() to ensure the CFG has been validated
before traversing and after postorder has been computed to avoid
walking dead code.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/verifier.c                         | 92 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_loops1.c     |  3 +-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..4f492eaad5c2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -787,6 +787,8 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
+	/* subprog indices sorted in topological order: leaves first, callers last */
+	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8234d80b892a..0afabc3567dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3742,6 +3742,94 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * Sort subprogs in topological order so that leaf subprogs come first and
+ * their callers come later. This is a DFS post-order traversal of the call
+ * graph. Scan only reachable instructions (those in the computed postorder) of
+ * the current subprog to discover callees (direct subprogs and sync
+ * callbacks).
+ */
+static int sort_subprogs_topo(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int *insn_postorder = env->cfg.insn_postorder;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cnt = env->subprog_cnt;
+	int *dfs_stack = NULL;
+	int top = 0, order = 0;
+	int i, ret = 0;
+	u8 *color = NULL;
+
+	color = kvzalloc_objs(*color, cnt, GFP_KERNEL_ACCOUNT);
+	dfs_stack = kvmalloc_objs(*dfs_stack, cnt, GFP_KERNEL_ACCOUNT);
+	if (!color || !dfs_stack) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * DFS post-order traversal.
+	 * Color values: 0 = unvisited, 1 = on stack, 2 = done.
+	 */
+	for (i = 0; i < cnt; i++) {
+		if (color[i])
+			continue;
+		color[i] = 1;
+		dfs_stack[top++] = i;
+
+		while (top > 0) {
+			int cur = dfs_stack[top - 1];
+			int po_start = si[cur].postorder_start;
+			int po_end = si[cur + 1].postorder_start;
+			bool pushed = false;
+			int j;
+
+			for (j = po_start; j < po_end; j++) {
+				int idx = insn_postorder[j];
+				int callee;
+
+				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
+					continue;
+				callee = find_subprog(env, idx + insn[idx].imm + 1);
+				if (callee < 0) {
+					ret = -EFAULT;
+					goto out;
+				}
+				if (color[callee] == 2)
+					continue;
+				if (color[callee] == 1) {
+					if (bpf_pseudo_func(&insn[idx]))
+						continue;
+					verbose(env, "recursive call from %s() to %s()\n",
+						subprog_name(env, cur),
+						subprog_name(env, callee));
+					ret = -EINVAL;
+					goto out;
+				}
+				color[callee] = 1;
+				dfs_stack[top++] = callee;
+				pushed = true;
+				break;
+			}
+
+			if (!pushed) {
+				color[cur] = 2;
+				env->subprog_topo_order[order++] = cur;
+				top--;
+			}
+		}
+	}
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		for (i = 0; i < cnt; i++)
+			verbose(env, "topo_order[%d] = %s\n",
+				i, subprog_name(env, env->subprog_topo_order[i]));
+out:
+	kvfree(dfs_stack);
+	kvfree(color);
+	return ret;
+}
+
 static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    int spi, int nr_slots)
 {
@@ -26274,6 +26362,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = sort_subprogs_topo(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = compute_scc(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index fbdde80e7b90..d248ce877f14 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -138,8 +138,7 @@ l0_%=:	exit;						\
 SEC("tracepoint")
 __description("bounded recursion")
 __failure
-/* verifier limitation in detecting max stack depth */
-__msg("the call stack of 8 frames is too deep !")
+__msg("recursive call from")
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
-- 
2.52.0

