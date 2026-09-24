Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1A40B0FE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267186; cv=none; b=MLDgKXP59lnWZGi9RRBBbeZbGoyXxoA518Rk4ECL7sA5WwVKFPhdIYVmxFRdsVATdikPcltJCVrMaTcc81K9UnlQzjav9XkrZe9x53M5zda9hMmPQJsiFwFqX0n6LmZ4lRjvfHvbyeOQPv3lrlqbrFT0gqP8byjJsFulpwxxisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267186; c=relaxed/simple;
	bh=Do1wc4MLHUaLoTywtD1eAlZ1P1j+ULdFFMedrvlIzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSKvjLAvqdwi1muxia7AG/v4iMxis5BpzA1bM8UGqnacLL90GX2RGaFoHwlqJ/vyw84smAMolemFfeNxFgWw3/LYuFh/0oaDiWUlOJfxyLsxNbt0cnByJppDBvyeam8+bGDB/1sONymxaJCiacpRd9YIw5Q+kj4PSAe90tV7Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDIKpK4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDIKpK4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5B21F000FF;
	Thu, 24 Sep 2026 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267185;
	bh=g6A68FLUcQdtS6PYqENV8kMUpJLiyYiQoAZpJnFTnIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDIKpK4d+eBF56OiwozvIUg1pqI+rNXGJEOzUU6jFlB2FpL1ojLMztm8uJOjAdTeE
	 3+U7vtXQmnpO8qIMziU0rs18EJl+t/1lzUGfRX63++Xen7r9vvtW2IAGGNaguQzOnH
	 DshcCih2MAX3Nf3OTodzsdq7o09D3+7KJtLmKWmm3x6Ayry9VifWrg8km83IhZki9G
	 CIN5wwkgUUnjYOD1e8UZmRvlFoe3m1+yDeA1Octppy/O8MFbG9mZMT+pa5WuDSZUur
	 piZFDL0T5rwg2tXxG0mScdZLUUG3nFeyNi1nQEbEMdj8AhUB+dPVV+WPMu4Dfq9JKh
	 BIyktt2uUbdgg==
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
Subject: [PATCH bpf-next v2 1/2] bpf: Look at frame 0 when telling async callback entries apart
Date: Thu, 24 Sep 2026 09:26:06 -0700
Message-ID: <20260924162609.1746610-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162609.1746610-1-puranjay@kernel.org>
References: <20260924162609.1746610-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

push_async_cb() sets in_async_callback_fn and async_entry_cnt on the
callback's own frame, which is frame 0 of the fresh state it starts, and
setup_func_entry() copies neither, so a subprog called by the callback
carries neither. Two places read them from the innermost frame instead.

is_state_visited() skips the infinite loop check when two states differ
in async_entry_cnt, because seeing the same state on a second entry into
an async callback is not a loop. A callback which re-arms itself and
calls a subprog therefore compares the two entries at a loop inside that
subprog, where the innermost frame is the subprog's and has no flag set,
and the state is rejected:

  infinite loop detected at insn 60

push_callback_call() numbers a new entry as the caller's count plus one.
When the callback re-arms itself from a subprog, the caller is that
subprog's frame with a count of 0, so every entry is numbered 1, the
check above never sees a difference, and a loop anywhere in such a
callback is rejected the same way.

Read the flag and the count from frame 0 in both places. A loop within a
single entry still has a matching count and is still caught, and frame 0
of a non-async state does not have the flag set, so nothing else changes.

The two other readers are already correct: check_return_code() reads
frame[0], and the one in do_check() is reached only after an early return
for curframe != 0.

Fixes: bfc6bb74e4f1 ("bpf: Implement verifier support for validation of async callbacks.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/states.c   | 4 ++--
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a76..32e141aa6a117 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1273,10 +1273,10 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			continue;
 
 		if (sl->state.branches) {
-			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
+			struct bpf_func_state *frame = sl->state.frame[0];
 
 			if (frame->in_async_callback_fn &&
-			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
+			    frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
 				/* Different async_entry_cnt means that the verifier is
 				 * processing another entry into async callback.
 				 * Seeing the same state is not an indication of infinite
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fec5a1ae6a4da..957ce8692b1a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10936,7 +10936,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		if (IS_ERR(async_cb))
 			return PTR_ERR(async_cb);
 		callee = async_cb->frame[0];
-		callee->async_entry_cnt = caller->async_entry_cnt + 1;
+		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
 		err = set_callee_state_cb(env, caller, callee, insn_idx);
-- 
2.53.0-Meta

