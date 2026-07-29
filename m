Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405063F6615
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357433; cv=none; b=uXDCOq1err9Q4vFV1Nrm15GAs+WbOxn0lMmmVKpNHuAJ7NbCwX6yztMx/yXgTSnRn6B9L0P9DjftEjGUFnQxdNf2+TpZ1iVBIbDGnf2ULNWWl2Mo+AjzL8OpPzJl22WTtM9oXTkU3DbaHB/Ztbd7qiC+Is6WY2XoPLXH0wg827I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357433; c=relaxed/simple;
	bh=F/DGbDyMBXt3PN3odH1cDrMs+dSXhmTu7Q801PPJqMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln7+MO/3SYMGGgUYHgIpIoSe4jlWXt0pwCqCq/RaJY/wqfVZV2LJ3U1yhUkUlwXWkM2E8UkcM9+xMWSAK2AYrlalyFDYhqlr1zY5QUT4g4xTd6Pf6y9u9YUgZUSEuMBPVH0A9HPitDZnNBUavNUi24YY62MVAht76hlDIKZ+2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHGQUfns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHGQUfns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CA1F000E9;
	Wed, 29 Jul 2026 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357423;
	bh=6AZoUrSJodQIbTSUnINZGkcLQO0yiub3aucjNDtOsTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHGQUfnsqu91RMU6KXnbv03ioFgns5NVJnanyjto2DY0wcthpuVD/N7VNApXmSTwb
	 l3CyxGY/h8+qyHO/k+bnYKeh75iPEnqNZn2oaO2G6U58Ieufx7XZffICF5HPvjgy60
	 vRoeNgKpjkwjqy/d1fa8wybQIVFfZAO3RkEWlWzwe2noJ9cYCopjdni3h1P7LF+znU
	 IUYHhtYtGE3pkgqPvBitVcwq+ZNdZmVeRHGPe1fXPipZf1f7gOqHNLLjzNzTP14R9z
	 JCl8XGIWWCWM/lDeWj6tGuG0bByFPFO1TI79/pLx0+sxG+aF6lmH70TxF8uUCO5krx
	 JTZjQXG6Z4C/g==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 4/6] bpf: Inline bpf_iter_num_destroy() as a no-op
Date: Wed, 29 Jul 2026 13:36:24 -0700
Message-ID: <20260729203633.213973-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729203633.213973-1-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_num_destroy() ends every bpf_for() loop. The kfunc only zeroed
the 8-byte on-stack iterator state, but once destroy() returns that slot
is no longer tracked as iterator state, so nothing reads it and the
zeroing is dead work.

Drop it on both sides: make the bpf_iter_num_destroy() kfunc a no-op, and
inline the call in bpf_fixup_kfunc_call() to a single BPF_JA 0 (nop) so
the per-loop call is removed without emitting any store. The nop is
elided by the JITs.

The emitted instruction is plain BPF and is handled by the interpreter,
so interpreter fallback stays correct and no jit_required marking is
needed.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/bpf_iter.c |  8 +++++---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f190f2b250048..ff2055399f3c0 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -821,9 +821,11 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
 
 __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
 {
-	struct bpf_iter_num_kern *s = (void *)it;
-
-	s->cur = s->end = 0;
+	/*
+	 * Nothing to do: the stack slot backing the iterator is no longer
+	 * tracked as iterator state once destroy() returns, so its contents do
+	 * not matter. The verifier inlines this call away entirely.
+	 */
 }
 
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a3d096f3966e..36f3e80d2f0b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19838,6 +19838,18 @@ static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
 	return i;
 }
 
+/*
+ * Inline bpf_iter_num_destroy(). The stack slot is no longer tracked as iterator state after
+ * destroy(), so nothing has to be done to it; emit a nop just to drop the call. Keep in sync
+ * with the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
+{
+	insn_buf[0] = BPF_JMP_A(0);
+
+	return 1;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19971,6 +19983,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = inline_bpf_iter_num_new(insn_buf);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
 		*cnt = inline_bpf_iter_num_next(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+		*cnt = inline_bpf_iter_num_destroy(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

