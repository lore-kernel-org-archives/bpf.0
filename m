Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B8402B92
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537244; cv=none; b=KsBdprebW8CEBh7gVWbfIvqIvQ/fmA7M8pUud6si7N+eb06ajSn+3GIrwxzYrls4uskdeH8CODDjeUYbpiFlKHx6YmAJ6eXJGDYRrDMGLDNVsahROlT1ou5jpkj8b2D6PNHqpy3EU/ky73Fx1Z9dGxugwxjtWzP/FT+d3Q3UrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537244; c=relaxed/simple;
	bh=Z0qfQjJblwu8s+4B5pL4Mksy16QGHVIlooLz2Jnlntk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVsXUmMrFKOd/XQJ82hgrhI+LN14i+GMNSRD246mlGGqfeEZItQiA4CCe/0GMhUWDyrKzU7HvDbE0mjRo9QGVxWu23cXe1BEeO8r7RSD9kwUt6vPYPw1tbgeFJJRICs5ODVCqwPJldTTO3M+X8eAuD5ZhrXYEzf7YTS6gEuHX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CR84t2yp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CR84t2yp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781537241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOeuhkE7bT1i7LhQpQdY0Tbv49F428SSOXD70kUVgIo=;
	b=CR84t2yph0KEpAk9215BdrBIN/isg+35E57FSfLCDaHMWBdjM0I/LNcL3JPw2Ur0F/YdWa
	Af+P9BSDlOtDTJCxaTyFNSeM0s+wgw9fznWa59IGIzxcd4ey7liN1rPvgiRskFmMJDc/y6
	/xY3egy70/LWDsiLdf2a5OXCco54+oQ=
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
Subject: [PATCH bpf-next v6 02/12] bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
Date: Mon, 15 Jun 2026 23:26:36 +0800
Message-ID: <20260615152646.27639-3-leon.hwang@linux.dev>
In-Reply-To: <20260615152646.27639-1-leon.hwang@linux.dev>
References: <20260615152646.27639-1-leon.hwang@linux.dev>
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
index 56f5da2b437f..5f48a6ab8a1a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1780,6 +1780,7 @@ struct bpf_prog_aux {
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

