Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792836429;
	b=Ba73dnUyat2hceulY23MyNAVpMtko7ji1ZYatJZyb+l6HT6XLBE5VSRpUuWB5x39VzFX
	 T4pFoSIubQs6LQWH9Ifwu6XTeDayHa78FPq8MsTMFP9e9aATmktVw+ywIz/YyQ/5njzoS
	 9Xc9Q7ROycAyLjssO0fHbNai4RSVz85O1P6aO0Gu1AzWIrO4XYsHTLuUKNREQgtDdTReu
	 XSX+OrSOMHaxc8FKSYbo85xwrum1aUEufvoXnz9hqY59aHon0gGIWT+8Xx0pDNR9PnfIP
	 seo4U5TJ3ttUuBFQckEJXKvdtDt3z7okoT50Vo1WiemkY52L77mYeAgwostxfBZKdjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792836429;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=SazYImGiQqMDzwN6m1nAxE6q6PUSCx7mF2GdxvRYCsI=;
	b=5VQ2Gh4/0Du+FCyno1A1sYNBRiEMWTty9zgcBcnyDSg3upyTboRM5sDRAA17wOAWky3+
	 MqNozTpYBfRQpyUKmYgDUE/3VDYBDi3xKw6G/onFSn6Yw8LGJq4HXW5Dr8ENNdc+ycQ0R
	 IcfKzN0Q/5FRe3sCMb6vp2LPzQOyVRWzOA3/Kq253a/wc/LClQeEPjbbq9cg03pLdwgwk
	 RBYWe88SNjJjhSSdZ6pDqs4T8US5Cd/3du1dZ5hMS+fQdMzsYMYdIx6uTBgHsQB6BUW1r
	 iMwtu+nPGoBhSwRq0UTBG22Le4OsAryKc7PhiMCbZoUaBOyOtIta5l/8OJxoNhGQhKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=p2iQtcmt;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBA606A31E
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 10:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88DBA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=p2iQtcmt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=SazYImGiQq
	MDzwN6m1nAxE6q6PUSCx7mF2GdxvRYCsI=; b=p2iQtcmtGC1tfx4BQYl4zHZj03
	fxKVGAIB8nK/D2lNCAgwGWPu9IymumapwmfnZq1xevFq16LsgYB4edn7lCZCuGfZ
	F78ZkEk4WyIIp49j1FqZySUc0TmVIei70Bte1Tg/5obDwqEc/91kW1KHf5h3Fpd2
	moM7cITsxjWFhs9Qk=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXETY6g9xq8zU7AA--.649S2;
	Sat, 24 Oct 2026 18:06:50 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	utilityemal77@gmail.com
Subject: [PATCH bpf-next v8 0/2] bpf: Track borrowed iterator result lifetimes
Date: Sat, 24 Oct 2026 18:06:45 +0800
Message-ID: <20261024100647.2579244-1-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgCXETY6g9xq8zU7AA--.649S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyfWF1fCr47GFy7Kw47CFg_yoW7uw43pF
	WkGr43tFs7Jw47Grs7Ca17WFyF9a95JF15JFn5t3sYvrs8tF1kAFWIkF4rZFZ0yrnYkFy3
	Zw12q3Z5Ja4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b5-ewUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Make non-RCU, non-acquired struct iterator results borrow the current
element lifetime by default. KF_ITER_RET_INDEPENDENT marks the explicit
exception for results whose lifetime is independent of the iterator.

Trusted field loads and dynptr constructors propagate the source lifetime
so derived pointers stay in the invalidation graph. Next preserves the
iterator itself and invalidates old dependents before both return
outcomes; destroy propagates outstanding-child errors.

This revision addresses Alexei's implementation review. Share the pointer
invalidation traversal through invalidate_reference(), with root reference
release performed separately by release_reference(). Iterator next calls
invalidation directly. The existing result classification already keeps
MEM_RCU results out of the iterator dependency graph, so the duplicate
RCU checks at next are unnecessary. The traversal excludes STACK_ITER,
so it also needs no special guard for the iterator's own stack identity.

Patch 1 retains the generic trusted-field rule and its file/inode lifetime
explanation. Patch 2 retains the iterator lifetime tests and the VFS
before-release and after-release controls unchanged.

Justin has coordinated the overlapping work and dropped the iterator
and acquired-parent trusted-field fixes from his v3 series. This series
keeps those fixes; his series covers RCU-parent field classification and
the __derives_ret kfunc argument annotation, including bpf_real_data_inode().
The two series are based independently on bpf-next. They overlap at
reg_lifetime_id() and the struct-return parent_id assignment and will need
those sites reconciled when combined.

Changes in v8:
  - Remove the duplicate RCU checks before iterator-next invalidation.
  - Separate pointer invalidation from root reference release, removing
    release_root and its unreachable root-alias guard. Keep the existing
    inline acquired-child leak check in the shared traversal.
  - Retain the test code and carry Amery's Reviewed-by tags from v7.
  - Rebase onto bpf-next 4169c9c90532 without changing either patch diff.
  - Remove the obsolete Assisted-by trailer for the current submission
    tooling; retain the AI-assistance disclosure in this cover.
  - Document the scope coordination with Justin and add him to Cc.

Changes in v7:
  - Explain the generic trusted-field lifetime rule and the file/inode
    example in patch 1's commit log, as requested by Alexei.
  - Add a positive and negative VFS test for that example in patch 2.
  - Rebase onto bpf-next b116ac6087541. The implementation's added and
    removed lines were unchanged from posted v6; the field-load hunk's
    context includes the upstream __nullable handling.

v7:
https://lore.kernel.org/r/20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn
Alexei's v7 review:
https://lore.kernel.org/r/DMB212RCKZ56.LTNAJWB2D39T@gmail.com
v6:
https://lore.kernel.org/r/20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn
Alexei's v6 review:
https://lore.kernel.org/r/DMA2SZ5PRG4N.3I51MHSTWUUTS@gmail.com
Justin's scope-coordination reply:
https://lore.kernel.org/r/att73Z9XpompG3k1@zenbox
Justin's v3:
https://lore.kernel.org/r/20261023212041.884996-1-utilityemal77@gmail.com
Kumar's related work:
https://lore.kernel.org/r/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com

These lifetime paths were investigated through AI-assisted source
inspection and annotated verifier programs. The regressions check loading
and diagnostics. The independent-lifetime control uses a small bpf_testmod
iterator; the VFS control uses existing kfuncs. No delay or fault injection
is used to force runtime reclamation.

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
  - verifier_ref_tracking: 1/57 passed; 0 skipped.
  - task_kfunc: 1/47 passed; 0 skipped.

The before-release VFS program loaded on both the unmodified
baseline and this candidate. The after-release program loaded on the
baseline and was rejected by this candidate with the expected scalar
access diagnostic. These annotated programs are load-only.

The VMs used panic_on_warn and panic_on_oops. No WARN_ON report,
Oops or panic was found. Unprivileged BPF was enabled only in the
isolated guests.

The complete test_progs build used BPF_STRICT_BUILD=1. The unfiltered
full suite, sanitizer and architecture matrices were not run. The
fresh baseline comparison covers the VFS example retained from v7.

Please queue the verifier fix for stable after it reaches the BPF tree.

Xu Yunxiang (2):
  bpf: Track borrowed iterator results by default
  selftests/bpf: Test borrowed iterator result lifetimes

 Documentation/bpf/bpf_iterators.rst           |  10 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/verifier.c                         |  68 +++-
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c |  17 +
 .../selftests/bpf/progs/verifier_vfs_reject.c |  19 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 10 files changed, 519 insertions(+), 13 deletions(-)


base-commit: 4169c9c90532df9585c0a2ae513337a58f5e59ab
-- 
2.43.0

