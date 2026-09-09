Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2433F8AA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928158; cv=none; b=aH3cEOS+9/GOyAsw418SOGgjjbNDoiXNnU1XzaXMa8J4bPQLYJcOMBpBc2a6qFd6UTUB8ye3CxtSHK2DuUqwc6V2jFwoaoxfl8s90DDc+M2uGzMxWISg8CCoSCM2SePnpsRTK2nzcisIueKc6b9kM+KzQW0nwDcvBE410QpBN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928158; c=relaxed/simple;
	bh=feXfHXawagn209qUVfeESIu5iiShYYVi0xyZEytNUNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMaYNvL5cQp4neARQ89qPkZvMH9nN0b1OwUIe3CjUJkUAQgxnfxiNy7TLz7RZfXgJ8KUMWu+msjbhLgk9NTkx7cTDCcRp0rvLjmo+Gnxbi/NL2wopf3dkap0QPqU+0dY+IAnVGytQw7lH9K7T37hUizZ17bqXINs2YAdoeQIUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Au3SJCje; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Au3SJCje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=dYQG/NQoI2
	VzDsf3DSupzJf2yNEmCzKCZfq9eKf6Tvk=; b=Au3SJCjeDgN/hgEZdlu05p1KJG
	AQsReuhzd59sSeQ0bIGxkUc6Ap4q1HaJuRydmAyDpS/1h22n6iKeMgsuYhESP44b
	vNDX3yJYDyLDCrW1zIkYZjLMxnhFbIDg2GPDIMKLbQCfV0pX8qCUY3+A1MuU8TzH
	aaxlsDcF/VcIeKpbg=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAH_yWV4KBqJj_5AA--.3021S2;
	Wed, 09 Sep 2026 12:29:09 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf 0/2] bpf: Invalidate iterator-owned BTF pointers
Date: Wed,  9 Sep 2026 12:29:05 +0800
Message-ID: <20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAH_yWV4KBqJj_5AA--.3021S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4kAFWrKw4xZw1DKr18Grg_yoW8uryxpF
	WY93y5tr4kCa1jk3y3AF4Uua4fWa93Aa45W3Wrtr1rCwn8Gry8tryjg34Y9F90kFn5WwnI
	vrWYyayfCFW7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5AUU5UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

bpf_iter_task_vma_next() returns an interior pointer to an
iterator-owned VMA snapshot. The PTR_TO_BTF_ID result lacks the iterator
reference as its parent, so destroying the iterator releases the backing
allocation without invalidating the returned pointer. The verifier then
permits a read through that stale pointer.

Patch 1 associates non-RCU PTR_TO_BTF_ID results from iterator next kfuncs
with the iterator reference. MEM_RCU results keep their independent
read-side protection. Patch 2 adds a failure test for the task VMA snapshot
after destroy and a success control for an RCU-protected task pointer after
destroying its iterator.

On the exact unpatched bpf/master base, the iterator suite passed 97
subtests and failed only the new stale snapshot case because the program
loaded. With this series applied, all 98 subtests passed. In an external
runtime triplet, the unpatched kernel accepted and successfully ran all
three programs. The patched kernel rejected only the stale program with
EACCES; both legal controls loaded and completed BPF_PROG_TEST_RUN.

The external triplet uses a privileged BPF_PROG_TYPE_SCHED_CLS program and
BTF kfuncs. This series is submitted as a verifier correctness fix.

---
Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j12 bzImage modules
  - strict clang-20 build of iters_testmod.bpf.o
  - test_progs -t iters -v --watchdog-timeout 180 --workers=1
    (Summary: 1/98 PASSED, 0 SKIPPED, 0/0 FAILED)
  - external live, stale, and destroy-then-reacquire runtime checks on the
    unpatched and patched kernels

The full unfiltered BPF selftest suite was not run.

Xu Yunxiang (2):
  bpf: Invalidate iterator-owned BTF pointers on destroy
  selftests/bpf: Reject task VMA snapshot use after destroy

 kernel/bpf/verifier.c                         |  3 ++
 .../selftests/bpf/progs/iters_testmod.c       | 43 +++++++++++++++++++
 2 files changed, 46 insertions(+)


base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
-- 
2.43.0

