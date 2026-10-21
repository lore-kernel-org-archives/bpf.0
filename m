Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616891;
	b=qjhCTwUDs9wba7ukLeyd4njQEJP90Pc0ojAVJeubhg7yNc3AFWfxywwJN2JxL1QwFhZD
	 QWQOfQXCH/UmiWNyEsdV+6v1RdHmmwMdFvpMTogzOR717Vkf2v0katvRu4p1LT/2Esb43
	 015k8c3KawJcsGXLao5hofrVmCcOA5gKumymELtMp8DIowTJAJjyCeg3hbYphUGxhxfdo
	 zANLA5N5uDCFpddjLmxdt7KXnzEePMYFSG0JnzpE8nHA4heqiwGvXY/nkUc3XZfwi6pSe
	 99Da6UdB8D+53leSmJrcg317eI4HsurL455LY04O5HiSQlA8t6FfoOtUnPOfD5nbcQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616891;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4ey4eJFG3vmM+qX3jhoO2JWgHe6JmYNzqea0vvc8ZdM=;
	b=JRdwIHLCMFTv4+2//FsCflgSWS3Ven/MbGPvXmw6RFEmqrRyziPLM8m8wGC69BxyMvC1
	 uZEwVkw5YL7eInR4PGm4YHWYjwPPi0omZNiDQDZ4TE9CRSzP4UgSXXov8FZnsVEDnHLy/
	 zAyQz8o2cWL4AArPyVMifq2Yj4xG1iYojqtMp9onRxu2/2oZ/4/4HCs+ZNsPbxbNZ/KXp
	 8JC76R+c/1LYxVZytk/CJWhs4zqIh2uW5sU8EtLK3gbg5NHxf1nYs+mxK7bpk3PGVL9Lw
	 LG/AwYYJgxpdo3i46p8bgMe+sqPLzjghdr7ZQFGwVvM7gesyUBpUpZzyKd+pYeM7z9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=WtbmUDIO;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CDC606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CDC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=WtbmUDIO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=4ey4eJFG3v
	mM+qX3jhoO2JWgHe6JmYNzqea0vvc8ZdM=; b=WtbmUDIOlJ9Bx+wOywo05aKTE3
	Y4EantDeY/3o0ApmJl9jXfNAJu/u7C9Rwaqud+ymXxAYENWgUjzzCRe/K1lFU3yq
	OS9cEej5dg87VCU3NidPX3OKWFnFtpUOetGm53TUAbV/nqj5ZN4e8nvEjHB9nZq8
	WLei1kfPUxkrZEGSg=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTmsKdlqwjsnAA--.7175S2;
	Thu, 22 Oct 2026 05:07:56 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org
Subject: [PATCH bpf-next v7 0/2] bpf: Track borrowed iterator result lifetimes
Date: Thu, 22 Oct 2026 05:07:52 +0800
Message-ID: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHxTmsKdlqwjsnAA--.7175S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF13Gw1xZF1kGw17Kr18Grg_yoWrGFyrpa
	ykC3yYkF4kJ3W7Kr4xAa17uFyru3Z5JFW5JF1rt34vvan8JF18JFWxKr15ZF9xAF1FkFyf
	Zr1agas3Ga48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6F4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x07bzCzNUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Make non-RCU, non-acquired struct iterator results borrow the current
element lifetime by default. KF_ITER_RET_INDEPENDENT marks the explicit
exception for results whose lifetime is independent of the iterator.

Trusted field loads and dynptr constructors propagate the source lifetime
so derived pointers stay in the invalidation graph. Next preserves the
iterator itself and invalidates old dependents before both return
outcomes; destroy propagates outstanding-child errors.

As Alexei pointed out, the trusted-field rule is generic. Patch 1 now
explains why an inode pointer loaded from an acquired file becomes
invalid when that file reference is released, and how the same rule
applies to fields derived from an iterator result. Patch 2 adds VFS
tests for the valid before-release access and the rejected after-release
access alongside the existing iterator lifetime tests.

The field-propagation overlap with Kumar's related work remains. This
series introduces no general kfunc borrowed-return annotation; the
separate bpf_real_data_inode() return-lifetime gap remains outside its
scope. The iterator policy has no dependency on that annotation.

Changes in v7:
  - Explain the generic trusted-field lifetime rule and the file/inode
    example in patch 1's commit log, as requested by Alexei.
  - Add a positive and negative VFS test for that example in patch 2.
  - Rebase onto bpf-next b116ac6087541. The implementation's added and
    removed lines are unchanged from posted v6; the field-load hunk's
    context now includes the upstream __nullable handling.

v6:
https://lore.kernel.org/r/20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn
Alexei's v6 review:
https://lore.kernel.org/r/DMA2SZ5PRG4N.3I51MHSTWUUTS@gmail.com
Kumar's related work:
https://lore.kernel.org/r/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com

Validation on this candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel and modules builds passed.
  - Changed BPF objects and required fixture compiled strictly.
  - iters: 1/122 passed; 0 skipped.
  - dynptr: 2/137 passed; 0 skipped.
  - file_reader: 1/10 passed; 0 skipped.
  - verifier_vfs_accept: 1/7 passed; 0 skipped.
  - verifier_vfs_reject: 1/13 passed; 0 skipped.
  - kmem_cache_iter: 1/3 passed; 0 skipped.
  - dmabuf_iter: 1/4 passed; 0 skipped.

The new before-release VFS program loaded on both the unmodified
baseline and this candidate. The after-release program loaded on the
baseline and was rejected by this candidate with the expected scalar
access diagnostic. These annotated programs are load-only.

The VMs used panic_on_warn and panic_on_oops. No WARN_ON report,
Oops or panic was found. Unprivileged BPF was enabled only in the
isolated guests.

The broad test_progs build used BPF_STRICT_BUILD=0; no compile skips
were reported. The unfiltered full
suite, sanitizer and architecture matrices were not run. The fresh
baseline comparison covers the new VFS example.

Please queue the verifier fix for stable after it reaches the BPF tree.

Xu Yunxiang (2):
  bpf: Track borrowed iterator results by default
  selftests/bpf: Test borrowed iterator result lifetimes

 Documentation/bpf/bpf_iterators.rst           |  10 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/verifier.c                         | 103 ++++-
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c |  17 +
 .../selftests/bpf/progs/verifier_vfs_reject.c |  19 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 10 files changed, 548 insertions(+), 19 deletions(-)


base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.43.0

