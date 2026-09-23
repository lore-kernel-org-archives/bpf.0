Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52E5349A6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172139; cv=none; b=NOVYl5BXho6XFUo/903j2QpJ580RAJA4iSwtQ5pY+CbVlQwFTGLx+g8Lozzznv3SEWTOyzjBlJ7WdGQiohoA3ZX+Rvpf4S/lPbz8YDCzXpOQTwfYxlm7KMUiXjI0LtRL0AHaHYWwJiYRiPaSqmjNzP63jtuBVeWuHdBDNXjJvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172139; c=relaxed/simple;
	bh=+b5oCxQGZnpyo+mDRe/el0P0QgxIEWYfwP1KwJb8tsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feik2mtDp6N89qRezpM6AEfVM/cg9WlLigU1QpG37KDgQ0wO712Zi6oGcrp94au9H49FRT+ab9KBI1SMxY/ew/zJgPwrsl9Fqpnxvq6F+ZGtwJWiCYfaShl5wrGEAX30n6mY5g0VspgslbdMrMDcBF347P3xmM8C4te+k16OjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwBvmyH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwBvmyH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44B91F000FF;
	Wed, 23 Sep 2026 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790172138;
	bh=QEyS0n6sZbl2bCc0NQzaSW6x2asZ+YkRZEY/hYIXDys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwBvmyH/5/iDmtJVI0RoAc2gRndEiX8njUJU+G4Hg27VgLkPPsEi2vEsWdtjcpqtN
	 3w4yoQVItN7gPo80sNwcEYXHZRqNMpwS9v2O20gHUxxNrSsLwUI08M9sW7oAogGCui
	 0v6JeJkQ02j7paRMwSP+3eQiZeCqRCKFL/RbQykT5ExihhwEmoga7CpyvOG/qSXvbR
	 n7/2OkwrWKd3A/zIUcnEitnYlBmEyVSTvm4ci975YCbuRLUAH6+SI67MVLwXguzPER
	 bp/sLYaK1Pcq3G7hot25BwmTOgZyJFGteKU52XmBRKelERubPxfofdzyVdxeN4JPDN
	 yMi+lE0EBsfuw==
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
Subject: [PATCH bpf-next 1/2] bpf: Look at frame 0 when telling async callback entries apart
Date: Wed, 23 Sep 2026 07:01:49 -0700
Message-ID: <20260923140152.4005097-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923140152.4005097-1-puranjay@kernel.org>
References: <20260923140152.4005097-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_state_visited() skips the infinite loop check when two states differ
in async_entry_cnt, because seeing the same state on a second entry into
an async callback is not a loop. It reads that from the innermost frame,
but push_async_cb() sets in_async_callback_fn and async_entry_cnt on the
callback's own frame, and setup_func_entry() copies neither, so a subprog
called by the callback carries neither.

A callback which re-arms itself and calls a subprog therefore compares
the two entries at a loop inside that subprog, where the innermost frame
is the subprog's, and the state is rejected:

  infinite loop detected at insn 60

Read the flag and the count from frame 0, which push_async_cb() makes the
callback's frame. A loop within a single entry still has a matching count
and is still caught, and frame 0 of a non-async state does not have the
flag set, so nothing else changes.

Fixes: bfc6bb74e4f1 ("bpf: Implement verifier support for validation of async callbacks.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/states.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.53.0-Meta

