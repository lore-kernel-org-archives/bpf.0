Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36093E49F5
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938282; cv=none; b=hmGG1Ix/JVKop2vL40YF32HjiG6b6PSHBUDTUxq2GHFG1ieYh6GIjPt1smNH7S6IhtKvB4tlNsSXqfBe2wnsxamZjCmbUzRpkaLoBArj7LIaZ+lHzGeSfljvWXiLrQ+TYdihRBTygX+v3XpVb3hPX+7Esc2w+t1yzFU0p5GXekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938282; c=relaxed/simple;
	bh=FQbTeE7GvuRVEjQFUevmQskVn3LYo+6JF3u1sfo1dA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ll9NmlVr7rp/5hVC1PETw3UtYGupQR/DEqbyBmb69GTBvGQGJvfWm2evRFjQz4tO5Q+dEviCv0eHXJ1rmPkC4kAHLHrYQVwf1IByYNEhntfWhTZ9SUTumHtKRLsQ17TNEXj4Mjlg8+L26rTO+BuSy4kcu2FSBQ7T2rDwVEZmITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=UAzxrBcR; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="UAzxrBcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=l54M4TAXHd
	D1469nJTMpv6079gnYwauyAd0TmM82QhQ=; b=UAzxrBcRBPwHsUthW5W/TmHPiN
	DZRFWUoOc3CJzMACNxzGVIHNLaKzi5/a4v0iawajVd3mIJqbTMQRN2cjuczvQ1r7
	rV4X7wwfuICL/zuf8cbnG04ytjgT3gBnvjvBcRQ26Hr8TKO4osXREeMuGbmFEY7m
	lKtjhREKTqppwdjtA=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgC3bTRmSrBqADFAAQ--.2273S2;
	Mon, 21 Sep 2026 05:04:38 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v5 0/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Mon, 21 Sep 2026 05:04:36 +0800
Message-ID: <20260920210438.345847-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgC3bTRmSrBqADFAAQ--.2273S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZryftF1xXr1DXw1rAFyrZwb_yoW5KrW7pa
	ykCa4Y9FWktF17KFsrGa17KFyYgFn5XF43Gas7t34fZr4UAFykZF97KF10qF98KryfCFW8
	Zw13JFn8AayUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r
	1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6F4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYbL07UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

A dynptr data slice is valid only while the specific dynptr that produced
it remains valid. Apply the normal dynptr stack-slot teardown before a
callee frame disappears, so its descendants are invalidated and its last
release-capable referenced dynptr cannot be lost.

Patch 1 performs that teardown after all return registers are copied and
before the callee is freed. It reuses the existing API and diagnostic,
with the affected callback expectation in the same commit. Patch 2 adds
return-time rejection tests and a caller-owned-slice acceptance control.
The later shared-resource release test remains a compatibility guard.

Changes in v5:
  - Remove the on_func_exit boolean and return-specific diagnostic from
    destroy_if_dynptr_stack_slot(), as requested by Alexei.
  - Restore unchanged callers to the existing API and update both affected
    test expectations to the existing referenced-dynptr overwrite message.
  - Rebase onto bpf-next b99f71407ce5.

v4:
https://lore.kernel.org/r/20260917052000.1589643-1-xyx2021@mail.ustc.edu.cn
Review:
https://lore.kernel.org/r/DLHO9Y7TLIK7.HLZOCWK5B3I8@gmail.com

Validation on this exact candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel/modules, changed BPF objects and test_progs
    builds passed.
  - dynptr: 2/136 passed; 0 skipped.
  - file_reader: 1/8 passed; 0 skipped.
  - ns_bpf_qdisc/invalid_dynptr_returned_slice: 1/1 passed; 0 skipped.
  - global_func: 3/29 passed; 1 skipped.
  - cb_refs: 1/0 passed; 0 skipped.
  - subprogs: 5/33 passed; 0 skipped.

No selected test failed. The VM ran with panic_on_warn and panic_on_oops;
no kernel WARN, Oops or panic was found.

The ctx_arg_rewrite compatibility case skips because this kernel supports
native context-argument tags.

Annotated verifier tests check load outcomes and diagnostics. The full
unfiltered suite, sanitizer configurations and architecture matrix were
not run.

Please queue the verifier fix for stable after it reaches the BPF tree.

Changes in v4:
  - Add a function-return-specific diagnostic, keep teardown before the
    caller instruction switch, and move the callback expectation into
    patch 1. v5 removes that dedicated diagnostic as requested.
  - Isolate the later shared-resource release control from local teardown.
  - Rebase onto bpf-next and preserve the complete R0:R2 copy loop.

v3:
https://lore.kernel.org/r/20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn

Changes in v3:
  - Replace slice reparenting with normal destruction of departing-frame
    dynptrs, following Amery's review.
  - Cover immediate use, the last-reference error and a caller-owned slice
    surviving destruction of a separate local clone.

v2: https://lore.kernel.org/r/20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn
v1: https://lore.kernel.org/r/20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Destroy callee-local dynptrs on subprog return
  selftests/bpf: Test dynptr teardown on subprog return

 kernel/bpf/verifier.c                         | 28 ++++++
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 ++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 99 ++++++++++++++++++-
 4 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c


base-commit: b99f71407ce529ba01a9392f477522d2e76c6613
-- 
2.43.0

