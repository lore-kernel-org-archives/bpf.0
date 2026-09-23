Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707D1BD9C9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172136; cv=none; b=iL+M5kYjCOdgHGHap+FDvYriKIE76wjPckE5uwIZPWaRvTvqKZDgVuLxtME5nyH9n/f6+MLncPtv3xUFeRLX/EclIZCEu/Qj9NbunP6p1TxCaTVSs5Yd3VMqPO+E6yEGNtBtAe2OT9g5wK6p292ZevGIu+PwS7AoPDrTCLQG7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172136; c=relaxed/simple;
	bh=LXvl/qUJ37h4FkoSVE3G5fyr63b7m75DJ0CZksxVXIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7USayQXU4KRV5b9hSCRjEryFkyV4GeQMr3IyD2JXu+QD6ebUaSRRlWHlhWL6xDQ4TwWPn9mS5kImGm5jiZFld6dx8bhZItZO5Kl//4SHcQ/C1e8y9u3nEYOeEksx6tcTHPGPiK90UgEJcCEqSsWRg8L7sUaiNrGXeU4OP1rNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b55QB9sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b55QB9sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED481F000FF;
	Wed, 23 Sep 2026 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790172134;
	bh=f3NCkfWK690TRx2kDOXO3j1cSKTHL+MVUIiHN64MvmY=;
	h=From:To:Cc:Subject:Date;
	b=b55QB9sUQk0w0dZhFO/RmXpAFuZEjq4PyxTrCWA6zmN1qUvrRvhBZ3/01arZbE5rN
	 WN7OjJSMH06Sewf73M9sraxtL3jw5wsuYsIS5uLnDhn3Bod8X+Ez4ewxMrNoJDRS1H
	 +3VICvVp3uAOayFYRjTIkuP++00cAuAdnBMoKwsK7Emd83bhHtfryUJ5X/9JVoXxs9
	 Mol/1SfHwdlS+GQUntHvosfM0jxXIRxkYjRUHBLjvBw24nK0CQ5NHfhJoKxWorgiC0
	 Cbg0+Vvyw0wEpmwEp0ZSQqyK7/WL+AW6frpCKb/Un4AzGdwFo5OL0U7TLMwsrD/y8c
	 JcnVsuuyacWNA==
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
Subject: [PATCH bpf-next 0/2] bpf: Fix loop detection for re-arming async callbacks
Date: Wed, 23 Sep 2026 07:01:48 -0700
Message-ID: <20260923140152.4005097-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_state_visited() skips the infinite loop check when two states differ in
async_entry_cnt, since seeing the same state on a second entry into an
async callback is not a loop. It reads that from the innermost frame, but
push_async_cb() sets in_async_callback_fn and async_entry_cnt on the
callback's own frame, and setup_func_entry() copies neither, so a subprog
called by the callback carries neither.

A callback which re-arms itself and calls a subprog therefore has its two
entries compared at a loop inside that subprog, and is rejected:

  infinite loop detected at insn 57

Patch 1 reads both from frame 0, which push_async_cb() makes the callback's
frame at any call depth.

Patch 2 covers both directions: a timer callback which re-arms through
bpf_timer_set_callback() and reaches a bounded loop through a static
subprog, which fails to load without patch 1, and a callback which never
returns, which must still be rejected either way. Nothing covered an async
callback before, so neither direction was tested.

Puranjay Mohan (2):
  bpf: Look at frame 0 when telling async callback entries apart
  selftests/bpf: Add timer tests for a re-arming callback with a loop

 kernel/bpf/states.c                           |  4 +-
 .../testing/selftests/bpf/prog_tests/timer.c  | 33 ++++++++++++
 tools/testing/selftests/bpf/progs/timer.c     | 50 ++++++++++++++++++-
 .../selftests/bpf/progs/timer_failure.c       | 29 +++++++++++
 4 files changed, 113 insertions(+), 3 deletions(-)


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.53.0-Meta

