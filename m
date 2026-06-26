Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618743F86F8
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488649; cv=none; b=Y7RrxVXO0tTW/pOa1ZA+GCMPPWmiWNYzts6Q0tCWj1KHdwHKr42PjPvP88I/VOyYeyzMA2EjMpvB7NuH0oeGEBY5/+Bb18jyOO3Vqxf3VExUcMBzgbKC/a+Km27dIvqZeUDZKDDWSezcBeckFQkXTnPP/4xbRl0nbXQKxU9blF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488649; c=relaxed/simple;
	bh=En6NdW5lgDrZ6eqXlcZQRog0X6qWVIPqHaGMPnQI4bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUvNeFN74kkWUKOgJOZQjt7FjUZWWGPeZeU6IRbii5vXsu8HpRq284TrC4XPWub4q77DaTUTDe83+czhwVsA+43U6JJR8y3yBRjozKgfHkgx8qBu3MVbPjUEC7DsQfNqHwt+PETQMNjjmqpN69fkVPuphwtxz4hhxYBIqWq7A58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovA4XC6l; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovA4XC6l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM/r5lYq63t/aatW7tqLH81Z/7odyMGKkwxtqtfR+X4=;
	b=ovA4XC6lvFn128+/NR7+kf6mzPYFYlaALBak2ul5IxkCh1++kdP4Qo9AlbCW3t6nV+/eK0
	oIRnzNv14zQvRQLGyRi2ysT2J2SCkGo6upQL14TkL1ARVKTf2rWhqxpaLG+rBuOcMXyDC5
	hfR304qK24FdBJ8MmnDggWOM1+fO60o=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
Date: Fri, 26 Jun 2026 23:43:25 +0800
Message-ID: <20260626154330.33619-2-leon.hwang@linux.dev>
In-Reply-To: <20260626154330.33619-1-leon.hwang@linux.dev>
References: <20260626154330.33619-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The interpreter is unable to handle the user BPF_ADDR_SPACE_CAST insn,
whose '->off' is 1:

static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
{
	ALU64_MOV_X:
		switch (OFF) {
		case 0:
			DST = SRC;
			break;
		case 8:
			DST = (s8) SRC;
			break;
		case 16:
			DST = (s16) SRC;
			break;
		case 32:
			DST = (s32) SRC;
			break;
		}
		CONT;
}

On the fallback path from JIT in __bpf_prog_select_runtime(), reject
the insn to avoid being ignored by interpreter.

Fixes: 142fd4d2dcf5 ("bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0db6e55bad52..e92eb8b7f945 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2608,23 +2608,37 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	return prog;
 }
 
+static bool bpf_insn_requires_jit(struct bpf_insn *insn)
+{
+	if (insn_is_cast_user(insn))
+		return true;
+
+	return false;
+}
+
 /* Fix up helper call offsets on JIT fallback path. */
-static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
+static int bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
 {
 	struct bpf_insn *insn = fp->insnsi;
 	const struct bpf_func_proto *fn;
 	int i;
 
-	if (!env || !env->ops->get_func_proto)
-		return;
+	if (!env)
+		return 0;
 
 	for (i = 0; i < fp->len; i++, insn++) {
-		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
+		if (env->ops->get_func_proto && bpf_helper_call(insn) &&
+		    bpf_jit_inlines_helper_call(insn->imm)) {
 			fn = env->ops->get_func_proto(insn->imm, env->prog);
 			if (fn && fn->func)
 				insn->imm = fn->func - __bpf_call_base;
 		}
+
+		if (bpf_insn_requires_jit(insn))
+			return -EOPNOTSUPP;
 	}
+
+	return 0;
 }
 
 struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
@@ -2663,8 +2677,11 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 			return fp;
 		}
 
-		if (!fp->jited)
-			bpf_fixup_fallback_helpers(env, fp);
+		if (!fp->jited) {
+			*err = bpf_fixup_fallback_helpers(env, fp);
+			if (*err)
+				return fp;
+		}
 	} else {
 		*err = bpf_prog_offload_compile(fp);
 		if (*err)
-- 
2.54.0

