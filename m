Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0483612DB
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938286; cv=none; b=Cb3QO6d9qH8ALxN3YlooFFS4/WnkEhPckX7yf2MDlaCMpoCC+x6w6EAJI1mzkbU+AWuA0fLOo1xYZBBj+CIt5UobaZyNpL8fNNBYO5U99AKtXIjvkP5FoOZqbHh+mXcE2/WypqUCKTSWu29FZU3buRFhtaKl2MgxG+5Np9fw038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938286; c=relaxed/simple;
	bh=QDtN32furUVLxkAow9sga3RN3+sQhxLjPv0e/8efYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iigz/5Ycf6oifyB9qK0ZEmpQULOidZvRSSKCLYRtAWdwQzXfU5M68Zc3Y7S555wBw9PGbfS6cEN4XGQsaHVm9sugAFg2nvIsF+b+42b9JjgiLub6QXWqeje0WNeAGdMutkVrghrvvFCtKJXNcsi0/VFKljSLXjksG2hV1HC0OCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=bh0OEknR; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="bh0OEknR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=zVLMsE5ZCG
	QQv+8YffW1+xpPATHAcp/uoYSxVu6o6ms=; b=bh0OEknR42T519DHjOgCvfggqA
	Y8usWf6yjvOzeJJrBZrQplUhcRj36ik3HbNBrvVNEVI4KaSXwxnP+iCyx90ow2HU
	DGj3BoutINNw0Fyr3zCMy4fiTpffpyPYsKUlRXL51kAmXLZb5XoRYjTtClay6Xop
	c+zdTcERokiW2Nq3s=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgA3OjFgSrBq6zBAAQ--.11822S2;
	Mon, 21 Sep 2026 05:04:32 +0800 (CST)
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
Subject: [PATCH bpf-next v5 0/2] bpf: Track iterator-owned BTF pointer lifetimes
Date: Mon, 21 Sep 2026 05:04:30 +0800
Message-ID: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgA3OjFgSrBq6zBAAQ--.11822S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4DGF17Gw1fuF1UCr4DArb_yoW5KrWUpF
	Z7Cw45trn7Aa17Krs7Ca17uFyF9r95Ja15CF95twsYvF4UtFy8AFWIg3WYvF9xAryIkF13
	Z34Fv3Z8GayUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6F4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUyX10UUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Some non-RCU struct iterator results borrow the current element's lifetime,
while others return objects that remain valid independently of the iterator.
Make current-element lifetime tracking explicit with KF_ITER_LIFETIME on the
next kfunc, and opt in task_vma, css_task, kmem_cache and dmabuf after checking
their native ownership and release paths.

Track the selected results and their fully trusted fields through the
iterator reference. Check child-resource cleanup and invalidate the previous
result before either next outcome. Use the common dynptr constructor's
backing lifetime while preserving clone and explicit-release ownership.
Unflagged struct iterators and RCU results retain their existing rules.

Changes in v5:
  - Add KF_ITER_LIFETIME opt-in, as requested by Alexei, instead of applying
    the current-element rule to every non-RCU struct iterator result.
  - Validate the flag on a NEXT method returning a strict struct pointer,
    without KF_ACQUIRE, and opt in the four audited native iterators.
  - Add a module iterator returning current, with positive verifier tests
    for using its independent-lifetime result after next and destroy.
  - Rebase onto bpf-next b99f71407ce5; retain the existing lifetime tests.

v4:
https://lore.kernel.org/r/20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn
Review:
https://lore.kernel.org/r/DLHO7NCJVWJV.1K8VWK8LFIKGD@gmail.com

Validation on this exact candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel/modules, changed BPF objects and test_progs
    builds passed.
  - iters: 1/111 passed; 0 skipped.
  - dynptr: 2/132 passed; 0 skipped.
  - file_reader: 1/8 passed; 0 skipped.
  - kmem_cache_iter: 1/3 passed; 0 skipped.
  - dmabuf_iter: 1/4 passed; 0 skipped.

No selected test failed. The VM ran with panic_on_warn and panic_on_oops;
no kernel WARN, Oops or panic was found.

Annotated verifier tests check load outcomes and diagnostics. The full
unfiltered suite, sanitizer configurations and architecture matrix were
not run.

Changes in v4:
  - Rebase onto bpf-next as requested by Amery Hung.
  - Keep update_ref_obj() and reg_is_referenced() unchanged; introduce
    reg_lifetime_id() for owned and borrowed source lifetimes.
  - Use the common constructor path instead of a FILE-only special case.
  - Capture the source lifetime before marking a BTF field destination.
  - Move next-time invalidation into process_iter_arg().
  - Share the child-reference leak check with release_reference(), while
    removing only the initially released ID from acquired references.
  - Retain the existing lifetime selftests on the new base.

v3:
https://lore.kernel.org/r/20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn
Earlier review:
https://lore.kernel.org/r/CAMB2axMX07j49sZRmGFm2s==FMgKFzvKPWxc8hDvU=b3Lp=VOg@mail.gmail.com

Xu Yunxiang (2):
  bpf: Track iterator-owned BTF pointer lifetimes
  selftests/bpf: Test iterator BTF pointer lifetimes

 Documentation/bpf/bpf_iterators.rst           |   9 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  12 +-
 kernel/bpf/helpers.c                          |  10 +-
 kernel/bpf/verifier.c                         |  88 ++++-
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 9 files changed, 503 insertions(+), 20 deletions(-)


base-commit: b99f71407ce529ba01a9392f477522d2e76c6613
-- 
2.43.0

