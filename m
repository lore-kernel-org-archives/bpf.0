Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF22459DD
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304587; cv=none; b=oRq4nOgucjbu5D3Qm3m0RiipnU8SP5c+PxXQoDfRHzJrfUFJwVcM6ZKjwFzmbKpaHoJp2fDPU0UMK4WmmOBaxJH79TknkcpsQzyamivFDhPXD5eQ75/hflbRxl27ycPjFXuJg8hvZfmHB/W5jykVexQLsX7uV45k8AQg8sWdJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304587; c=relaxed/simple;
	bh=G51EetVb3Hxxsje1nsaG0GEgHNkcGH/7dnAHm5rsRXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tycO1GjJx0HpbX/n6VZ4EPVzazz/JWc8Vnoi004LXiBGq3l6ugICpAqQ7+3IWPUTd2E3pMhbS17VCoTmUc3E1qzFm5Bcj1qqsM92ex9fTC863uQrRFgKJ8nFhwGGZaLsVDT9w/8Brf8oHBITCCwj2e0BNQ2vWpeZUakyiKXgWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9akqsgY; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X9akqsgY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782304584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eq/lVcYT8y2d7pq6HSStFNoFBGXpM2QcZdIafFwr974=;
	b=X9akqsgYkWDyhgSDy3NBJVHNPD2HYxgavdBtZL3yEvcCX4bo9PlXVLAiym0zIpWLiLQVoS
	aVnrqjyE2QqifVP5zGAHKJ2+OTIyzTjs1KnTMAC3dFytrgGg9vm8hqsS8qj4Pac2LapiY3
	+WWQubHLowiRIxzWszDUbWkwUClMtuo=
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf 1/1] bpf: Fix insn_aux_data leak on verifier err_free_env path
Date: Wed, 24 Jun 2026 20:35:35 +0800
Message-ID: <20260624123536.114757-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When bpf_check() allocates env->insn_aux_data successfully but later
fails to allocate env->succ, it jumps directly to err_free_env.

The existing vfree(env->insn_aux_data) sits before the err_free_env
label, so that direct jump bypasses it and leaks insn_aux_data.

Move vfree(env->insn_aux_data) into err_free_env so all early and late
exit paths release it consistently.

Fixes: 2f69c5685427 ("bpf: make bpf_insn_successors to return a pointer")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21a365d436a5..3ccea8985946 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19994,13 +19994,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	bpf_clear_insn_aux_data(env, 0, env->prog->len);
-	vfree(env->insn_aux_data);
 err_free_env:
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	vfree(env->insn_aux_data);
 	kvfree(env);
 	return ret;
 }
-- 
2.43.0

