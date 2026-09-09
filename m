Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE7E33CEA5
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928155; cv=none; b=g529Ndj+pHDbOEA0CqmVzLz38n+wf8OqDc/5YRKKBUV3PgjQUEbyJVIQQsL5RR+kJOoGHKehMQ8Ax74xA3pN4DOTcXy+6C7jdBMenYhr2R9/JOiuyhVAj5QIoeAWsvV8RJlNv+7hcRC2uaCYlgNL7ymi2Imaf4lniW6mPaeCLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928155; c=relaxed/simple;
	bh=EJz+gUVUN8rwx++sHfXCML+DSgVAxA/cqVXiAX6KONY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8IPg/gRdrhg3P8MG+QcTOi6cbFL+kF5TZfizc/MgBlfSQ12vl5Dci+rvvgLXy5wLwXgKBLoQQXGXVxnPMdsdKzE91uPAbQSsHcqigPAiU6ppRp5wwDlGlHjF8F0+p71CGom+WR0T+uGtduvieJnzmxEppVXmtBT2em2ycwdf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=bgHIbMqC; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="bgHIbMqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=dSwrpOYeBJYtXorahNv6YERN8Bx7dqgpbH
	lNga2MXa0=; b=bgHIbMqC1x1hw6JeRyj8izVquG23ddVOBcwnsHzcBYD6f2zTG+
	HdEXdB2GgGcWSEPjIwu1oWC4GD0V37Pv/Kf1FJbBDJEdwXg1dhB8CaQSN14l2mi5
	JW1yFVF8ccFkiEmJud3oqsLXJnW9QyZ0xbqTefGfOx1FIhtoFfcZyTVr4=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn2yKN4KBqBD_5AA--.3075S2;
	Wed, 09 Sep 2026 12:29:02 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf 0/2] bpf: Preserve escaped dynptr slice ancestry
Date: Wed,  9 Sep 2026 12:28:56 +0800
Message-ID: <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829040712.B1B511F000E9@smtp.kernel.org>
References: <20260829040712.B1B511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDn2yKN4KBqBD_5AA--.3075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18tw1DZFy8ZFW3tw1kZrb_yoW8Cr1xpa
	1F9a90qrsYyF12k39xZayUu34rAFZ3t345Gw1xtr1rAF15trWrtrW7K3W5XryYyrs5Cw15
	Wr1rtay3CF4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUyT7NUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Sashiko reported a verifier lifetime gap for a dynptr slice derived from a
clone in a subprogram. The slice can escape into its caller before the
subprogram returns. Once the clone's frame is gone, the slice still names
the clone id as its parent, but that graph node no longer exists. Releasing
the original dynptr therefore fails to reach the escaped slice, and the
verifier permits a subsequent access to the released ring buffer
reservation.

Patch 1 reparents surviving slices before the clone's frame is freed. Patch
2 adds a success case for using the slice before release and a failure case
for using it after release.

On the unpatched bpf tree, external BPF_PROG_TEST_RUN checks covering
stack-spill, direct-R0, two-level-return, and nested-clone escapes were
accepted and returned a known value through the stale slice. With this
series applied, the verifier rejects every stale access.

The checks use dynptr operations that require CAP_BPF. This series is
submitted as a verifier correctness fix.

---
Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j12 bzImage modules
  - test_progs -t dynptr -v --workers=1
    (Summary: 2/134 PASSED, 0 SKIPPED, 0/0 FAILED)
  - external stack-spill, direct-R0, two-level-return, and nested-clone
    checks on unpatched and patched kernels

The full unfiltered BPF selftest suite was not run.

Xu Yunxiang (2):
  bpf: Preserve escaped dynptr slice ancestry on subprog return
  selftests/bpf: Test slices escaping a clone call frame

 kernel/bpf/verifier.c                         | 34 ++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 46 +++++++++++++++++++
 2 files changed, 80 insertions(+)


base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
-- 
2.43.0

