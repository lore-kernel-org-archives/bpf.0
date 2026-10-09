Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB64F7CA2
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577702; cv=none; b=HGlNErYyCGbWntUlYetJhPVxfIrVLgXKBuTBRVAGMybbpmPE7F6f61Lz73eJfK17PcUEZOyoB3QR1VuGCDwqJxcWH4fyTD4UZCPd15Z0vQOzAE64Twtdvm990UTKqbBxK4rIXPcCUzxXvIKkzBE3oNRAZtYjMZQgMm6hvlxvrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577702; c=relaxed/simple;
	bh=W7ebJft0jBk/q71+j5ISxIGWQliRr+LjwO/kr8Fgi1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOVKtGhBAwS1G8NblXIoiQD5fTrs09pvK2cl6GoUT2HGG81PRQsD88oQafKKEAB/gOvh/EMuqNsZ1IT70Vx9u2z4LcLceOayvmf8kJLzXaMDS0UFmjz8/3pIdK3sooMHex4mcxnJnCIy2vx9L0jxhYab+GCBVoG3m0OWhvbYOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z55K6R/V; arc=none smtp.client-ip=95.215.58.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z55K6R/V"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W7ebJft0jBk/q71+j5ISxIGWQliRr+LjwO/kr8Fgi1I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577696; v=1; x=1792182496;
 b=Z55K6R/VB0shH5POA26GD9/htfH+7GCFHle+AqH6SNjh2sE+i8jXTVzZqBTYxZE50EooSO1t
 kLlqaDVUg93k8YF7rV9HaTKAsLTs1UQwifoS8da+ispVqjaCeXHkr1HDMgH07osGpNggNXtTYu2
 2t7b4cZYCcQIebC7g/qG/KjI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38b53f9433b6338c;
	Fri, 09 Oct 2026 20:28:16 +0000
X-Mizu-Trace-ID: 38b53f9433b6338c
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/11] bpf: Scope callback arguments to their frame
Date: Fri,  9 Oct 2026 13:27:47 -0700
Message-ID: <20261009202759.50520-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A callback-calling helper or kfunc can pass its callback a pointer
that is only valid for the callback invocation, and the verifier has
no way to express that lifetime.

Two helpers need fixing:

  * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
    sample it releases as soon as the callback returns. Saving this
    pointer in callback_ctx leaves it pointing into reused kernel
    stack and allows arbitrary kernel read and write (bpf-next only,
    see patch #8).

  * bpf_for_each_map_elem() over an array or per-CPU array map passes
    the address of a u32 held in bpf_for_each_array_elem()'s own frame,
    leaking four bytes of kernel stack.

Both arguments point into a helper's own frame, with nothing
longer-lived to anchor them to. Rejecting spills of the dynptr pointer
alone would still allow derived slices and clones to escape.

Introduce REF_TYPE_FRAME for this use case: a reference owned by a
callee frame, dropped when the frame is popped. Tie each argument to
this reference so callback return invalidates it and its descendants.

Callback setters repeat register defaults and map metadata setup,
while reference release couples descendant invalidation to object
release. The refactoring patches give common initialization one owner
and separate invalidation from reference removal. Frame lifetime
tracking can then reuse the existing reference machinery.

---

Patches #1-6 are non-functional preparation. Patch #7 introduces
REF_TYPE_FRAME and its diagnostics; #8 and #10 apply it to the
helpers, and #9 and #11 add selftests.

v1->v2:
  * Add the refactoring patches: release frame references in one scan,
    and fold diagnostics into the REF_TYPE_FRAME introduction
  * Replace temporary argument mask and deferred register scan with
    reference acquisition directly in the owning verifier state during
    callback setup (Eduard)
  * Reuse callback_park_dynptr() for the nested drain test

v1: https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linux.dev

---

Ihor Solodrai (11):
  bpf: Set up callee state outside of setup_func_entry()
  bpf: Pass the owning verifier state to callback setters
  bpf: Append complete reference states
  bpf: Separate reference removal from descendant invalidation
  bpf: Share map-backed callback register setup
  bpf: Rely on callback frame initialization defaults
  bpf: Introduce REF_TYPE_FRAME in the verifier
  bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
  selftests/bpf: Cover the user ringbuf callback dynptr lifetime
  bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
  selftests/bpf: Cover callback-frame map key lifetime

 include/linux/bpf.h                           |   5 +
 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/arraymap.c                         |  18 +-
 kernel/bpf/diagnostics.c                      |   3 +
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/states.c                           |   4 +
 kernel/bpf/verifier.c                         | 392 +++++++++---------
 .../selftests/bpf/progs/exceptions_fail.c     |  20 +
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 135 ++++++
 .../bpf/progs/verifier_iterating_callbacks.c  |  91 ++++
 10 files changed, 476 insertions(+), 199 deletions(-)


base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
-- 
2.56.0

