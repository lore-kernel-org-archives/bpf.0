Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B5384CE2
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207179; cv=none; b=i980DYbEG5IyNiFeNYS/QDk7PBwzKB/ejztzbMURtr+tF7UTL/98a/eVVQA25Rq2/2XmCUCwQJwdsXqX820FE9qrd8F15psG3BbklJNDUVboZ5I135XBcUnOIt9O6pwHb+TSnEEuHg7PyAhUu6IdjXuCDfyVd6Hna1rzoiu9TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207179; c=relaxed/simple;
	bh=+w2ty0N07ehYbihR8BaJqeYkPu0Z+RDmERKCPLpF3Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djgLG3WDK1qZflmf0/Kmy2AEe/L8xRyIWH5cnqOrXBwiC7OM55VLqwIsXrH1GOG0G6h+fg5bI8o0dCX9OtheB3ZjE5DyDeESLLqgxkQzfe409uULmPTDRjK4qe45RVs4xeWBYdPWlDjkyXqKqKFg9sJJtYbueF0H4Zgg916KukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pfCi46XD; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfCi46XD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+w2ty0N07ehYbihR8BaJqeYkPu0Z+RDmERKCPLpF3Fs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789207175; v=1; x=1789811975;
 b=pfCi46XDSxlQqOuq6RwrmV6nfObOlntIZi3T55pYb2aiEegXMGMU9tSoUhb1/Iigs7T0SG60
 CnQA16JAnS/127neb01k9UYXFFdfv2eZO+74VQ1F0X1h7bkpFlp5eXZYqKa2Tj1U/nFl+ZZZAbb
 RUKZ8F3iOlA0ExtV1GLQWkgI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1eb9cb2a28a517dd;
	Sat, 12 Sep 2026 09:59:34 +0000
X-Mizu-Trace-ID: 1eb9cb2a28a517dd
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
Subject: [PATCH bpf v2 0/2] bpf: Fix use-after-free of progs detached from busy trampolines
Date: Sat, 12 Sep 2026 09:59:13 +0000
Message-ID: <20260912095924.866254-1-florent.revest@linux.dev>
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
reaching the detached one or was preempted between two progs. Patch 2
adds a selftest that demonstrates this and patch 1 contains the fix.

v1 kept the progs alive by having the image hold a reference on them
until it is freed, which Alexei pointed out pins detached progs for as
long as a task sleeps in the traced function. v2 follows his suggestion
to extend the ip_after_call nop patching instead: every prog call in the
image is preceded by a nop, and detaching a prog patches its nop into a
jump over the call in the images that are still around. Nothing is
pinned and nothing changes on the fast path besides the nop.

One thing is a bit different from what we discussed: instead of
patching all the nops to jump to the epilogue when the image is put,
only the nop of the detached prog is patched, when it is detached, and
it jumps over just that prog. Patching all of them would make tasks that
are in an old image skip fentry and fmod_ret progs that are still
attached whenever the trampoline is updated (e.g. an LSM prog missing a
check because another prog got attached to the same hook), and those
can't jump to the epilogue anyway since the original function still has
to be called. This needs the trampoline to know which of its images are
still in use, which is the list added here.

The nops also cost a bit of room in the image: 38 progs no longer fit in
a page on arm64 and loongarch, so BPF_MAX_TRAMP_LINKS is lowered there
(and on powerpc, where 38 already didn't fit) the way s390 does it. The
alternative would be to let images span two pages, I can do that
instead if it is preferred.

Tested on x86_64 under KVM and on arm64, s390x, powerpc64le, riscv64
and loongarch64 under qemu TCG, all with KASAN: the new selftest crashes
the unpatched kernel on every one of them and passes with the series,
and trampoline_count, fentry/fexit, modify_return and test_lsm pass too
(the full test_progs on x86_64). The trig-fentry/fexit/fmodret
benchmarks on x86_64 are within noise.

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

Florent Revest (Anthropic) (2):
  bpf: Skip detached progs in trampoline images that are still in use
  selftests/bpf: Detach a trampoline prog while a task sleeps before it

 arch/arm64/net/bpf_jit_comp.c                 |  29 ++-
 arch/loongarch/net/bpf_jit.c                  |  35 ++--
 arch/powerpc/net/bpf_jit_comp.c               |  38 ++--
 arch/riscv/net/bpf_jit_comp64.c               |  34 ++--
 arch/s390/net/bpf_jit_comp.c                  |  35 +++-
 arch/x86/net/bpf_jit_comp.c                   |  23 ++-
 include/linux/bpf.h                           |  40 +++-
 kernel/bpf/trampoline.c                       |  51 ++++-
 .../bpf/prog_tests/tramp_prog_detach.c        | 191 ++++++++++++++++++
 .../selftests/bpf/progs/tramp_prog_detach.c   |  56 +++++
 10 files changed, 465 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c


base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
-- 
2.55.0

