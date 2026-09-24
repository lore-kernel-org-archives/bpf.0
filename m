Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B7409281
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267183; cv=none; b=p03d5XvPgQR46CdmpxRIk30Ow3xKmgerI+Tk+dD5epktEnZuUQGhQGu7mWTHva/IoqINRUCvz5+G2Qwv2xrRFpMq64fnI0Ln/rT0F+D9fKMV+iNXzXtcNvFaKwuztC30iVyvv+i9cveXIUPaY/sPGjN2IDxbR0KhM1Rxj4yzciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267183; c=relaxed/simple;
	bh=71iAdynAxrj7tmrUVeZABs6H9752Gn6wRFgvPBXigvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBsNW93cRhFMrACigxMmv6Tc/NWwri8J0e2Gg+DFGXuRIQxCu3V3puFSzlWd9j37HxPmywXewDkfcIu6JEIltPoIKj+DDwfGtqvebOjUvbf2OtpXQ2FNpLtVyTTq5mU3vHI8df0ePVrI+73V96DyxW8a13vjemBRg315Crffras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii4DvUPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii4DvUPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A6D1F000FF;
	Thu, 24 Sep 2026 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267182;
	bh=6H26jfO9ZmI/Lt6u0JRXdqK0Hl7yEwPPM+kGD3FLCPc=;
	h=From:To:Cc:Subject:Date;
	b=ii4DvUPPo7P+a80dOPhkyOcASvjMTiX+/k/6hSn4iiF25tOftkJNeOb0vYEZUXPmN
	 20DXqU9z1t10F2EmxEFt2r8DiXTo7yryoTyl+jeknEOC8hnm9xl1Z2tTxYFrV6ozai
	 /BIdl7pb4ueempBy63upTikJKopHqBA++gGHs57ov4QRVd9pSv1YPdGwsr6OJtgpIH
	 coffipokeFDS8tfOfORVJz7mccfTZys+lw6e/UdtyK+DTt2rFZRAEK5mvOqtFuwci0
	 C5tcAP7bIm9jThvryq4gjJ5+tYdTygpHLzs9wA9T9CUpVpUb9ChtLJhQMifj8xH281
	 A6XVgz3vluwqw==
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
Subject: [PATCH bpf-next v2 0/2] bpf: Fix loop detection for re-arming async callbacks
Date: Thu, 24 Sep 2026 09:26:05 -0700
Message-ID: <20260924162609.1746610-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: https://lore.kernel.org/all/20260923140152.4005097-1-puranjay@kernel.org/
Changes in v2:
- Patch 1: also fix push_callback_call(), which numbered a new entry
  from the caller frame. When the callback re-arms from a subprog that
  frame is not frame 0 and its count is 0, so every entry was numbered 1,
  is_state_visited() never saw a difference, and a loop in such a
  callback was still rejected.
- Patch 2: loop_cb() now re-arms through a __noinline subprog, so the
  caller frame at bpf_timer_set_callback() is not the callback's own
  frame. The v1 test re-armed from frame 0 and passed without the
  push_callback_call() fix.

push_async_cb() sets in_async_callback_fn and async_entry_cnt on the
callback's own frame, which is frame 0 of the fresh state it starts, and
setup_func_entry() copies neither, so a subprog called by the callback
carries neither. Two places read them from the innermost frame instead.

is_state_visited() skips the infinite loop check when two states differ in
async_entry_cnt, since seeing the same state on a second entry into an
async callback is not a loop. push_callback_call() assigns that count as
the caller's plus one.

A callback which re-arms itself and calls a subprog therefore has its two
entries compared at a loop inside that subprog, where the innermost frame
is the subprog's, and both entries are numbered 1 anyway, so it is
rejected:

  infinite loop detected at insn 57

Patch 1 reads both from frame 0 in both places, which push_async_cb() makes
the callback's frame at any call depth. A loop within a single entry still
has a matching count and is still caught.

Patch 2 covers both directions: a timer callback which re-arms through
bpf_timer_set_callback() from a subprog and reaches a bounded loop through
another one, which fails to load without patch 1, and a callback which
never returns, which must still be rejected either way. Nothing covered an
async callback before, so neither direction was tested.

Puranjay Mohan (2):
  bpf: Look at frame 0 when telling async callback entries apart
  selftests/bpf: Add timer tests for a re-arming callback with a loop

 kernel/bpf/states.c                           |  4 +-
 kernel/bpf/verifier.c                         |  2 +-
 .../testing/selftests/bpf/prog_tests/timer.c  | 33 ++++++++++
 tools/testing/selftests/bpf/progs/timer.c     | 60 ++++++++++++++++++-
 .../selftests/bpf/progs/timer_failure.c       | 29 +++++++++
 5 files changed, 124 insertions(+), 4 deletions(-)


base-commit: 4f3a5eae895b9995e93425a75235d8f1f3268caa
-- 
2.53.0-Meta
