Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F63BE14A;
	Mon, 15 Jun 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532886; cv=none; b=JZyER3YRTYCi0sYc5ZUOEdysYiwXUEm74gvLPT1MIDFg602fVFo+jpL3pmtcRXs2HcGTkcldi5c7qWjCbUmnJiFKKJYsauUpztCalUypUZKjfqt3w+IXR9tUOECAgKNtz+z6CSnaKIb65jrve1+jOh2/aZOAFVEZuhlEz15seqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532886; c=relaxed/simple;
	bh=y8XD9SDah6p33tm7vzsCNC5aTdZwzbpIQ+iS7NxPN9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTOnkpN2pBAHFcOgPnCoBnou1nfYUePTOqhtG61El93CCBi0J7845o72/d36xxrcgD2rEMvaGtBO6i4Jzd2nFOBS+jl2mqOdUKcH+bSZkvr8Ml6Vjku3HOnGbHgIp+Fh8/tJ1+40ulFaMD4S1wjMgdv4/4RMLtmIUbiwDw1Rh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=qz0NkDmb; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="qz0NkDmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=R6JVmQKUTslaGY65rvpMFq9qLt0NLyDloL
	SNgMPYWjo=; b=qz0NkDmbLzlWedm+mpX8yV6GwSVsWwYNNTWKoE+jKNTZsjGRGK
	gPjKSueDtvbsdWCqn3axfUI75N5MHBmI8h947/4J/dQbGXVVzL4xKn9ABRH4IoDQ
	pDcOYd88DkGVLkhUmIP7Kan4ghh7Fyho4l2vu+I/f3vkwJzL4mlqkJ3Ww=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXaZ69CDBqq7FKAg--.53046S2;
	Mon, 15 Jun 2026 22:14:30 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 14:14:05 +0000
Message-Id: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBXaZ69CDBqq7FKAg--.53046S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UWr47uw1xArW3ur1xXwb_yoW5Ar4xpa
	yrGryaq34kXF17ZFnrAF48Zr15Wan5ZFW3Ga45try5ZwnYqr90qFyIgr15uF9IyF1fZw4I
	vFyjv398Kry5C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjp6wPUU
	UUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writer kfuncs can mutate skb packet data.
The verifier does not currently treat those kfuncs as packet-changing.
A direct packet pointer checked before the call can stay usable after the
write.

bpf_dynptr_write() already clears packet pointers through the helper path.
Teach kfunc argument checking to do the same for skb and skb-meta dynptr
destinations. For static CFG analysis, conservatively classify dynptr writer
kfuncs as packet-changing so global subprogram summaries are correct even
before register states exist.
Keep source-only dynptr arguments unchanged.

v3 also treats unspecialized global-subprogram dynptr arguments as possibly
packet-backed in the precise verifier path. This covers packet pointer
invalidation inside a global subprogram body where the argument may point to an
skb dynptr provided by the caller.

Validation:

  Rebase:
    fetched bpf-next origin/master on 2026-06-15;
    series base is e4287bf34f97a ("selftests/bpf: Work around llvm stack
    overflow in crypto progs").

  Without this series:
    linux-stable-v7.0.12 accepts the three original stale packet pointer cases;
    linux-mainline-v7.1-rc7 accepts the three original stale packet pointer
    cases;
    the source-only bpf_dynptr_copy() control loads on both kernels.

  With this series applied:
    patched bpf-next rejects the five stale packet pointer cases with
    "invalid mem access 'scalar'";
    the source-only bpf_dynptr_copy() control still loads;
    QEMU direct-runner reports PATCH008_SUMMARY failures=0 total=6.

  Build and style checks:
    git diff --check HEAD~2..HEAD: OK
    checkpatch.pl --strict --no-tree: OK
    make O=$BUILD kernel/bpf/verifier.o kernel/bpf/cfg.o: OK
    make O=$BUILD -j$(nproc) bzImage: OK
    dynptr_fail.bpf.o build against patched vmlinux BTF: OK

v2:
  https://lore.kernel.org/bpf/cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn/

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---

Changes in v3:
  - Rebased onto fetched bpf-next origin/master (e4287bf34f97a).
  - Split static CFG packet-changing detection from precise checked-argument
    invalidation.
  - Treat unspecialized global subprogram dynptr arguments as possibly
    packet-backed for writer invalidation.
  - Add global subprogram regression tests for caller-side and local stale
    packet pointer invalidation.

Changes in v2:
  - Resend as a properly threaded series. No code changes.

Yiyang Chen (2):
  bpf: Fix packet pointer invalidation for skb dynptr writes
  selftests/bpf: Add skb dynptr writer packet invalidation tests

 include/linux/bpf_verifier.h                  |   3 +
 kernel/bpf/cfg.c                              |   2 +-
 kernel/bpf/verifier.c                         |  79 +++++++++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 140 ++++++++++++++++++
 4 files changed, 222 insertions(+), 2 deletions(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
-- 
2.34.1

