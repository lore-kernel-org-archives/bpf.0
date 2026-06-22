Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAE3BADB2
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139026; cv=none; b=ZKeY/wS6hCKIIJzhk/Fu0+Uf7YhZLza+IlXCwwiG8/h3WdVvUJxlhS3UcM5rAwBpIGjuxbr6Sg95d7emYm6ud8S0ysW2+XoTtLlvlkdA24tIMqHDcoqiTseFqGMTRAtBSop+GhAP5e89u0I9Iu8TYJj45aR4rSblg1W4bGXZWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139026; c=relaxed/simple;
	bh=Fq3WYTnSqZS5zJK7JL8kP38nBrMaU9mMaFvCQOx9saI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9fBMtyZs2wAihwH1wCAISeEV08/qSMOKkiKS/V1Poy8zycxEHY5/lzCzJObhqgy9bR5Ec2ZxRkblWX76hAeOLEwULD/2RDExTD6WTUmq8KAMh98f/9J96hn6Ki8QUoUTCOR6+Kdc7nok1Ca+08tFpf3v6SY4v3GMOS9c7MJtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ID4pRR07; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ID4pRR07"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782139022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCMiiSAWxWBXgCBfZXqftEZxdWrpCAJoKV6Pf7Wc5UA=;
	b=ID4pRR07awIdlZljgbBCNhQC8LQXSLSRcfBttXFVF8QUp13Y3VlDUd4WC39YU+Ls+I6eQs
	V+iqNG5LK+P+QrjS38B/DnkGcYFx/NJzmJ+YpQkw9VCTZmhNdnT6DCiLJoiFVz2I6ZSPdT
	bHSIlsDBgX8zjSk0OGx0iL41efOZPqA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v7 02/11] bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
Date: Mon, 22 Jun 2026 22:35:48 +0800
Message-ID: <20260622143557.22955-3-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-1-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since interpreter is unable to handle the 'insn_is_cast_user()' insn,
require JIT in __bpf_prog_select_runtime() when the prog has the insn.

Fixes: 142fd4d2dcf5 ("bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 1 +
 kernel/bpf/fixups.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..5e1843d2859e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1781,6 +1781,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	bool has_addr_space_cast_insn;
 	struct {
 		s32 keyring_serial;
 		u8 keyring_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..49398b5bd172 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2620,6 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 		goto finalize;
 
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
+	    fp->aux->has_addr_space_cast_insn ||
 	    bpf_prog_has_kfunc_call(fp))
 		jit_needed = true;
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3cf2cc6e3ab6..2d5958774b61 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1523,6 +1523,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				insn->off = 0;
 				insn->imm = 0;
 			} /* cast from as(0) to as(1) should be handled by JIT */
+			if (insn_is_cast_user(insn))
+				prog->aux->has_addr_space_cast_insn = true;
 			goto next_insn;
 		}
 
-- 
2.54.0

