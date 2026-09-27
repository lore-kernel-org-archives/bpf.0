Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75B3D3CF2
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510730; cv=none; b=k74SnoUA6pZQDmcbELsNrxpODeckhFyGvKip1lr47JqQaOQ+RmZ0Sh2lGGz8pemadTpfQsUTfOgOYhRShuVDigxEdkSv1EZryIfwsXyX1oq5V8L04/Up05jepWGC6yUj1kDNAvZL0+v5Hn8/dW5zI7l35QtLMw/jh1AbZ/dxdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510730; c=relaxed/simple;
	bh=4Ln5QD20pLCY7g0D0xAJ8uxQxSHc8TxSBoUMhI4ktqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYCHnFEv0sd8vTVukZkkVube8YrvPLJemhR9jjQuwe3JNCV2xbveP8F+vTZW63TARZ6poBf1sql6y3mQLGFVSoxnykytzCjOiquwiU6wFzpV+PGH1n9LJay77brdjYx3vT8LTsyYWF7pFHAiJ5nPChAXhXLDJQzGqAUBvcpk07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=DivODOA/; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="DivODOA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=OPfl8Jb0Ru
	JauDOG45Xvuj7HR/Zpshq7KUEBxWyrrF4=; b=DivODOA/y6UH7z9dPAL3x2frPC
	vUjdVoWH4LakgeoQcqC0vmkmUgm6PFplDTeGJ8zm9+6KoouqpYlyCa1iLkUKs8XJ
	SMXtQeBDssx2tuUe3yk8a4m+zXt5s/tM8vcS2nXd/SMpt4/GTthCSXH3IaRYOnkS
	iBxbG3HcCmKNNhNbg=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn1h05Brlq6IhqAQ--.5156S2;
	Sun, 27 Sep 2026 20:04:09 +0800 (CST)
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
Subject: [PATCH bpf-next v6 0/2] bpf: Track borrowed iterator result lifetimes
Date: Sun, 27 Sep 2026 20:04:04 +0800
Message-ID: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDn1h05Brlq6IhqAQ--.5156S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4ktFW3Zw45ur4rXrW3Awb_yoWrAw4fpa
	yxGrWYyFnrJF47Kr47Aw4xCF1F9r93Ga15GFn3J395Zr4UGr18JFWxK3WFvF9xAF1Fqr1S
	vr1Igas5Cas7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUgmL9DUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Make non-RCU, non-acquired struct iterator results borrow the current
element lifetime by default. KF_ITER_RET_INDEPENDENT marks the explicit
exception for results whose lifetime is independent of the iterator.
This follows Amery's and Alexei's opt-out feedback on v5.

Keep the v5 propagation through trusted fields and dynptr constructors,
and reuse the reference traversal when invalidating iterator dependents.
Next preserves the iterator itself and invalidates old dependents before
both return outcomes; destroy propagates outstanding-child errors.
The second patch covers these rules and the independent/RCU controls.

Scope and overlap: the trusted-field propagation was already in v5 and
overlaps the work Amery pointed out to Kumar. This revision adds no general
kfunc borrowed-return annotation and does not fix the separate
bpf_real_data_inode() return-lifetime gap Kumar said he would handle.
The iterator policy itself has no dependency on such an annotation.
We will need to reconcile the shared field-propagation code when that
work is available; this series does not claim complete coverage through
ordinary kfunc returns.

Changes in v6 (relative to the posted v5):
  - Replace KF_ITER_LIFETIME opt-in with KF_ITER_RET_INDEPENDENT opt-out.
    Native borrowed struct iterators no longer need individual flags;
    mark the independent testmod iterator explicitly.
  - Reuse the reference graph traversal for next while retaining the root
    iterator reference, instead of the PTR_TO_BTF_ID-only scan.
  - Retain the fifteen v5 lifetime tests and use scalar opaque storage
    for the one-word testmod iterator.
  - Correct the iterator Fixes tag to its introduction and rebase onto
    bpf-next ea9358e1270ab. Keep implementation and tests in two commits.

v5:
https://lore.kernel.org/r/20260920210432.345758-1-xyx2021@mail.ustc.edu.cn
Amery's opt-out clarification:
https://lore.kernel.org/r/CAMB2axMt8K6tnLZ_wNzx_c=tCqpUeLOETitN98_v1y7Z7J2EwQ@mail.gmail.com
Alexei's opt-out review:
https://lore.kernel.org/r/DLM8JHZUINUJ.3V54PKAS0QV9B@gmail.com
Kumar's related work:
https://lore.kernel.org/r/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com

Validation on the rebased candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel and modules builds passed.
  - Changed BPF objects and required fixtures compiled strictly.
  - iters: 1/121 passed; 0 skipped.
  - dynptr: 2/133 passed; 0 skipped.
  - file_reader: 1/8 passed; 0 skipped.
  - verifier_vfs_accept: 1/6 passed; 0 skipped.
  - verifier_vfs_reject: 1/12 passed; 0 skipped.
  - kmem_cache_iter: 1/3 passed; 0 skipped.
  - dmabuf_iter: 1/4 passed; 0 skipped.

No selected test failed. The VM used panic_on_warn and panic_on_oops;
no WARN_ON report, Oops or panic was found. Unprivileged BPF was
enabled only in the isolated guest; the kernel printed the expected
Spectre-v2 notice when enabling that sysctl.

The broad test_progs build used BPF_STRICT_BUILD=0 for unselected
objects requiring unavailable kernel features. The changed objects
and required fixtures were also compiled in strict mode. Annotated
lifetime tests check loading and diagnostics. The unfiltered full
suite, sanitizer and architecture matrices, and new unmodified-base
differential probes were not run in this rebase validation.

Please queue the verifier fix for stable after it reaches the BPF tree.

Rebase adaptation: use bit 19 for KF_ITER_RET_INDEPENDENT because
upstream KF_PERFMON uses bit 18, and use the new stack-slot accessor.

Xu Yunxiang (2):
  bpf: Track borrowed iterator results by default
  selftests/bpf: Test borrowed iterator result lifetimes

 Documentation/bpf/bpf_iterators.rst           |  10 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/verifier.c                         | 103 ++++-
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 8 files changed, 512 insertions(+), 19 deletions(-)


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.43.0

