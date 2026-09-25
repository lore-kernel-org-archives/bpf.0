Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDD2D060D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330636; cv=none; b=GrN8vMeF0iDIduUMomYzBkCkmxfsJ97F1Y5HBeOpzpv3cD7o/Wo1LRi+rN1KjhG6Fnwor9LstQDzxwH5RlfqN3b8zjcV9Wnw/UAWdfuVX2OB6OE5T/Ubn/zT/Apxp6Gywi9KAt08coM6jL5kZIkonyEuDMzNdxyV6BMh7xkYWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330636; c=relaxed/simple;
	bh=1b+JF5KLCCVK5IPqGWkBoybqB76qs/M88oEinSvldGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXURV+vpYsfi/NrNqvfeiGgYP+mepxwXtug34WH1oZCJnbmK/b/8989/61N93k1KSV9Ilj2S/uZQxl3Q2wuZE9miYcZhJUzVoFl12dCxf5EcVMKxQvHZVjsytMyrHd49XVQHWbWooRJ91Ilo+3Fzc5TFlbrOFdaQ/7cDOsuJV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEQYMdAb; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GEQYMdAb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1b+JF5KLCCVK5IPqGWkBoybqB76qs/M88oEinSvldGA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790330631; v=1; x=1790935431;
 b=GEQYMdAb0C1Bskf/4cfoqCVDPGrHWBPv9Qs2nvZxuRunJfpBgRcn1jWDmypnEnE219E6Vp8h
 /iXihle+0cFKm4jLbTUcSOcPDryi0G/Egvyv5Uii5bYObEhyBxNLCMj55lavDXh2UjQnI4/AKy0
 nnRIDC4FlykznFIgr686LLks=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d69167434a93a146;
	Fri, 25 Sep 2026 10:03:51 +0000
X-Mizu-Trace-ID: d69167434a93a146
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
Subject: [PATCH bpf v4 0/3] bpf: Fix use-after-free of progs detached from busy trampolines
Date: Fri, 25 Sep 2026 10:03:29 +0000
Message-ID: <20260925100342.481242-1-florent.revest@linux.dev>
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
patch 2 handles the sleeping case by patching detached progs out of the
images that still call them and patch 3 adds a selftest for the sleeping
case.

v3 patched all the nops of an image when it was put. bpf-ci pointed out
that this lets a task skip fmod_ret and LSM progs that are still
attached, for as long as it sleeps in an earlier prog, and Alexei asked
to go back to what v2 did: only the nop of the prog that is detached is
patched, in every image that isn't freed yet. Patch 2 explains why that
takes a list of images and not just the current one. ip_after_call is
gone in both versions, and the call to the original function is never
skipped.

sashiko noted that on riscv and loongarch a task can be preempted in
the middle of a multi-instruction patch site. ip_after_call has this too
and it isn't addressed here, pending input from the JIT maintainers on
whether a single instruction site is fine for these in-image jumps.

Tested on x86_64 under KVM and on arm64, s390x, powerpc64le, riscv64
and loongarch64 under qemu TCG, all with KASAN: the new selftest crashes
the unpatched kernel and passes with the series on every one of them,
along with trampoline_count, fentry/fexit, fentry_fexit, modify_return
and lsm_cgroup (and the full test_progs on x86_64). On x86_64, 18
fsession progs with cookies on an 11 argument function still fit in the
image. Same on bpf-next, where patch 2 has a trivial conflict in x86's
arch_bpf_trampoline_size().

Changes since v3
(https://lore.kernel.org/bpf/20260924170543.1017048-1-florent.revest@linux.dev/):
- Only patch the nop of the prog that is detached, in all the images
  that aren't freed yet, like v2 did, and explain why a list of images
  is needed (Alexei, bpf-ci)
- Lower BPF_MAX_TRAMP_LINKS to 36 on x86, the worst case no longer fit
  in a page with the nops (bpf-ci, Alexei)
- selftest: wait for the detached progs to really be freed before
  releasing the task, the grace period of patch 1 made the previous wait
  too short (bpf-ci). Detach two progs one after the other, so that the
  second detach has to reach an image that isn't the current one anymore
- Keep a single comment block in bpf_tramp_image_put() (bpf-ci)

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
  bpf: Skip detached progs in trampoline images that are still in use
  selftests/bpf: Detach a trampoline prog while a task sleeps before it

 arch/arm64/net/bpf_jit_comp.c                 |  33 +--
 arch/loongarch/net/bpf_jit.c                  |  45 +++--
 arch/powerpc/net/bpf_jit_comp.c               |  45 +++--
 arch/riscv/net/bpf_jit_comp64.c               |  39 ++--
 arch/s390/net/bpf_jit_comp.c                  |  46 +++--
 arch/x86/net/bpf_jit_comp.c                   |  26 ++-
 include/linux/bpf.h                           |  46 ++++-
 kernel/bpf/syscall.c                          |  19 +-
 kernel/bpf/trampoline.c                       |  75 +++++--
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |  34 +---
 .../bpf/prog_tests/tramp_prog_detach.c        | 188 ++++++++++++++++++
 .../selftests/bpf/progs/tramp_prog_detach.c   |  56 ++++++
 tools/testing/selftests/bpf/testing_helpers.c |  28 +++
 tools/testing/selftests/bpf/testing_helpers.h |   2 +
 14 files changed, 526 insertions(+), 156 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c


base-commit: 5fc5768c7ca92895ccd1de94dc521e5a55ae7896
-- 
2.55.0

