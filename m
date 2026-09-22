Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EF29AB02
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039033; cv=none; b=tjmU8pf3Zds4yuwZZrNaCGqNoA4YU+2eLsFv+tlHjTjWc5CnQE47H0+s7ZQPy49JKCfe4UOWZ0JzaLeSnNIW0y1JzMc3dY1J8lHfgav4byNvM7iUr3T8i4/RhIE8HDF6RIqjJEAjId5dPGWUHrf4LcDRHLkA0IfO4/mVAgInyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039033; c=relaxed/simple;
	bh=goeRcFPiGJqHuAO8lnax9XtMB4JH7BGri9MlFXHFz/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy92dxoDBVxek3StdNilfSA5R8x69meLb60st5KrqH7O8ehuxwOHzNcaRXb9+0iwtktDhDabeIqWLDsb4Udl+ldfY7tKTef9Qmv3XD1c3+OuVcqn+viK44tvJ5l4gcJf7+IfW7yHJHJ/9EZTD3o/yPJuCw6HC5fLBRFXi1k1GKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muj77TK/; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muj77TK/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=goeRcFPiGJqHuAO8lnax9XtMB4JH7BGri9MlFXHFz/A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039029; v=1; x=1790643829;
 b=muj77TK/YRGtGN78HbyXSHG8CL4DbU0ts6ajhfovSVCJKMWNRN7Rw9jgBQBtWD2B9pxrkuPY
 jV3KG6weaPdioiwhoQvpEAtUzbyk3tEPMOcY3XGSJTRU1bLW3ZxE+kz6KaUnmbHwa0w7LcwejBz
 7dhnd57rIyVVG+Ceq8N742JU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 1984e50358f104ba;
	Tue, 22 Sep 2026 01:03:49 +0000
X-Mizu-Trace-ID: 1984e50358f104ba
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
Subject: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their frame
Date: Mon, 21 Sep 2026 18:03:27 -0700
Message-ID: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A callback-calling helper or kfunc can pass its callback a pointer
that is only valid for the duration of the call, and the verifier has
no way to express that.

Two helpers need fixing:

  * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
    sample it releases as soon as the callback returns. When parked in
    callback_ctx, that register describes reused kernel stack and
    gives the program an arbitrary kernel read and write (bpf-next
    only, see patch #2).

  * bpf_for_each_map_elem() over an (percpu-) array map passes the
    address of a u32 held in bpf_for_each_array_elem()'s own frame,
    leaking four bytes of kernel stack.

Neither has a local fix: both arguments point into a helper's own
frame, with nothing longer-lived to anchor them to.

Introduce REF_TYPE_FRAME for this use case: a reference owned by a
callee frame, dropped when the frame is popped. Then use this
mechanism in both bpf_user_ringbuf_drain() and bpf_for_each_map_elem()
callee state setup.

---

The series is composed as follows:
  * patch #1 implements REF_TYPE_FRAME and relevant infra code, but
    it's not used yet
  * patches #2 and #5 use the new mark_frame_scoped_arg() helper
  * patch #3 adds relevant diagnostics
  * patches #4 and #6 add selftests to cover the changes

---

Ihor Solodrai (6):
  bpf: Introduce REF_TYPE_FRAME in the verifier
  bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
  bpf: Name the callback in frame-release diagnostics
  selftests/bpf: Cover the user ringbuf callback dynptr lifetime
  bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
  selftests/bpf: Cover callback-frame map key lifetime

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/arraymap.c                         |  18 ++-
 kernel/bpf/diagnostics.c                      |   3 +
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/states.c                           |   4 +
 kernel/bpf/verifier.c                         | 149 +++++++++++++++---
 .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
 .../selftests/bpf/progs/exceptions_fail.c     |  20 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 143 +++++++++++++++++
 .../bpf/progs/verifier_iterating_callbacks.c  |  91 +++++++++++
 11 files changed, 419 insertions(+), 26 deletions(-)


base-commit: 79dc258c9392051420a26f1504c647bd3d27c66a
-- 
2.55.0

