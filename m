Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB843BB126
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269554; cv=none; b=XCUYKk4STNGveneNTS6s+1/crO/A3o/IoD1mdBzQ72lC/M9Lbl4pET4F7EQhpkTFAEMCwh2TFi7wRSR0zwIhHenmOECxFMt46IZfDkLo1KXaZPg5G+iSjZd6y5BQOQd76/Q7K2uxSWjuYP7WsOm3Wg9NHaOEZ9u3mqvc3WNE7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269554; c=relaxed/simple;
	bh=eDJX9QaV3IHt0wCWoAv6swWD/bQVYY7m30368kiM6to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8jBfnuy5H02gC2hKLH2eBCRndMB7nIdpv1zLZ0L/n23LLxYHo8WZBg6WhnEqiUah2oEictNRyAGODrciPT9pV849Wu2ugU3xPyR9QBzHwneWEWgYJRarZHXoAX37LlE6sQT6HeVaab9H8bykEMrnpAPssiKw69JXdqxYjIMzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pS7KC8Xe; arc=none smtp.client-ip=91.218.175.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pS7KC8Xe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eDJX9QaV3IHt0wCWoAv6swWD/bQVYY7m30368kiM6to=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790269550; v=1; x=1790874350;
 b=pS7KC8Xe3Q9Lqggya+MKj5B3lg6sVb6kg3QE0QJkaHKtLN7z+6v7MwklR2BkWswY+ZpLRdHh
 Ij9nE+0X/ooxbHJFEKUoRTglAuLlFvjKxyeXq12/mBgesivAGHhJTMqv5jsSrhJoCGPEaWgrAiT
 mV21/4Q5Tj3Pd3w1wobs1dsU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d3bf36292817e91;
	Thu, 24 Sep 2026 17:05:49 +0000
X-Mizu-Trace-ID: 3d3bf36292817e91
X-Migadu-Flow: FLOW_OUT
From: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 0/3] bpf: Fix use-after-free of progs detached from busy trampolines
Date: Thu, 24 Sep 2026 17:05:37 +0000
Message-ID: <20260924170543.1017048-1-florent.revest@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task running in a trampoline image can call a prog that was detached
and freed in the meantime, when it slept in a sleepable prog before
reaching the detached one or was preempted right before calling it.
Patch 1 handles the preempted case with an RCU tasks grace period,
patch 2 handles the sleeping case by extending the ip_after_call nop
patching to every prog in the image and patch 3 adds a selftest for the
sleeping case.

v2 only patched the nop of the detached prog, at detach time, in the
images still in use, which needed the trampoline to track them. v3 goes
with Alexei's simpler proposal: bpf_tramp_image_put() patches all the
nops of the image it retires, the same way it patched ip_after_call,
which goes away. A task that is in an old image when the trampoline is
updated now skips the rest of that image's progs, attached or not, like
it already skipped its fexit progs.

v3 doesn't jump over the call to the original function. With a fexit
prog on a regular kernel function that call is the function itself, so a
task that is before it in an old image would return to its caller
without the function having run. The fentry_fexit subtest of patch 3
checks that it still runs.

sashiko noted that on riscv and loongarch a task can be preempted in
the middle of a multi-instruction patch site. ip_after_call has this too
and it isn't addressed here, pending input from the JIT maintainers on
whether a single instruction site is fine for these in-image jumps.

Tested on x86_64 under KVM and on arm64, s390x, powerpc64le, riscv64
and loongarch64 under qemu TCG, all with KASAN: the new selftest crashes
the unpatched kernel and passes with the series on every one of them,
along with trampoline_count, fentry/fexit, fentry_fexit, modify_return
and lsm_cgroup (and the full test_progs on x86_64). Same on bpf-next,
where patch 2 has a trivial conflict in x86's
arch_bpf_trampoline_size().

Changes since v2
(https://lore.kernel.org/bpf/20260912095924.866254-1-florent.revest@linux.dev/):
- Patch all the nops in bpf_tramp_image_put() instead of the detached
  prog's nop at detach time, drop the image list, the trampoline
  backpointer and ip_after_call (Alexei)
- Wait for an RCU tasks grace period before freeing progs that were
  linked to a trampoline, for tasks preempted right before the enter
  helper (Junseo, sashiko)
- Initialize the jit ctx in loongarch's arch_bpf_trampoline_size() and
  the dummy image in every arch_bpf_trampoline_size() (bpf-ci)
- selftest: move the userfaultfd helper to testing_helpers.c and share
  it with bpf_mod_race, comment fixes (bpf-ci), add a subtest where the
  original function runs between the sleeping prog and the detached one

Changes since v1
(https://lore.kernel.org/bpf/20260819122252.1782790-1-florent.revest@linux.dev/):
- Patch nops in front of detached progs instead of taking prog
  references from the image (Alexei)
- Lower BPF_MAX_TRAMP_LINKS on arm64, loongarch and powerpc so the
  image still fits in a page
- Explain that the sleepable case doesn't depend on CONFIG_PREEMPTION
  (Kumar, Alexei)
- Add a selftest (Jiri, Alexei)
- Add Sechang's Reported-by (Junseo, Kumar)
- Drop Leon's and Kumar's acks since the code changed entirely

Florent Revest (Anthropic) (3):
  bpf: Wait for an RCU tasks grace period before freeing trampoline
    progs
  bpf: Skip the progs of trampoline images that are being freed
  selftests/bpf: Detach a trampoline prog while a task sleeps before it

 arch/arm64/net/bpf_jit_comp.c                 |  33 ++--
 arch/loongarch/net/bpf_jit.c                  |  45 ++---
 arch/powerpc/net/bpf_jit_comp.c               |  45 ++---
 arch/riscv/net/bpf_jit_comp64.c               |  39 +++--
 arch/s390/net/bpf_jit_comp.c                  |  46 +++--
 arch/x86/net/bpf_jit_comp.c                   |  26 +--
 include/linux/bpf.h                           |  36 +++-
 kernel/bpf/syscall.c                          |  19 ++-
 kernel/bpf/trampoline.c                       |  37 ++--
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |  34 +---
 .../bpf/prog_tests/tramp_prog_detach.c        | 158 ++++++++++++++++++
 .../selftests/bpf/progs/tramp_prog_detach.c   |  56 +++++++
 tools/testing/selftests/bpf/testing_helpers.c |  28 ++++
 tools/testing/selftests/bpf/testing_helpers.h |   2 +
 14 files changed, 453 insertions(+), 151 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c


base-commit: 5fc5768c7ca92895ccd1de94dc521e5a55ae7896
-- 
2.55.0

