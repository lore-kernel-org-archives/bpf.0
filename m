Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E83E2756
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622414; cv=none; b=KqqlJwhRK1ItLPWKoMLZiRCZSFBhOUqoeq1LNnK0gx7Lqm4nk7Q/LOmU04mkxl7D+p1CA4MvIh+nx2m6mM9CFOscalWWy1LdkohTzjMI+Dwznzk0FTs6U7tDeCKk58FXd/B3gCMlKAXcTc2KAjVTe9kdOPPx5a+JIpFSSAvdkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622414; c=relaxed/simple;
	bh=NkDWfBrRrF8XCifKF+H0kH05qJGZnIdpt5yoDZikAKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CE4nPpbXt90aFTLqxbNwmk0ineeuxpwO1VWRjrlcSkLY5TqFkVYPVcMp1/e84ow3tB2hj3suQBtaptaYEAX+3NjPa98S0/jcccHUvdYGZenjhNn9lvtVIofxL8dWLnwfhi0xtqX3cq10nD/9dsQ+8dRCXmo8LZhsgMfHm2nwuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=U+3/9E89; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="U+3/9E89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=AqCGcJkk0X
	+wUaYNyjm0PGHNPC9Mh3FV2f8TO38l6As=; b=U+3/9E892YZENo+gufUqScr11Z
	kktUmT4J7gy/hGjKR2GZrffKYks1AwDqd8dMfdYcWTpkkbh7Q0Zanzj3a2ZDQf06
	VviyS6oYN+is8ZWlejyFsff3blJT41eNOPYKyE06rEviuDXdBqu6oGjWScrYKbfl
	e2JkmC6XxFVymk/jg=
Received: from localhost (unknown [222.195.81.43])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHeyKBeKtqCKcqAQ--.2823S2;
	Thu, 17 Sep 2026 13:20:01 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Thu, 17 Sep 2026 13:19:58 +0800
Message-ID: <20260917052000.1589643-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHeyKBeKtqCKcqAQ--.2823S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxZFyfZw15CFyfWrW3KFg_yoWrZrWxpa
	yvka90vFykJF12krsrJa18GFyFkrs3Xay3G3s0g347Aws8tryvvFW7Ka4jqF98Kr4fCw40
	vw4Yq3ZxGF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bOxRgUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

A dynptr data slice is valid only while the specific dynptr that produced
it remains valid. prepare_func_exit() currently frees a callee stack without
running the normal dynptr teardown. A slice derived from a callee-local
dynptr can therefore escape into the caller and remain usable after its
source dynptr has disappeared.

Patch 1 destroys every callee-local dynptr before freeing the frame, using
the existing stack-slot teardown so exact descendants are invalidated and
the last release-capable referenced dynptr cannot be lost. It distinguishes
function-return teardown from stack-slot overwrite in the diagnostic and
keeps the affected existing callback expectation in the same commit.

Patch 2 covers immediate use of a ring buffer clone slice, release-time
invalidation of a caller dynptr slice after it crosses a subprogram return,
an immediate skb use, and the last-reference error path. Its success control
checks that destroying a callee-local clone preserves a slice derived from
the caller-owned dynptr.

The release-time case protects existing submit-time invalidation; the
return-time cases check the lifetime of the source descriptor. The
positive control checks verifier acceptance without a runtime assertion.

Please queue the verifier fix for stable after it reaches the BPF tree.

This local v4 refresh is based on bpf-next 10c4f610b215. Teardown
follows the complete return-register copy loop, including R0:R2 on this
base.

Validation on this exact candidate, with a matching bpf_testmod:
  - W=1 verifier object and complete kernel/modules builds passed.
  - test_progs -t dynptr: 2/136 passed, no skips or failures.
  - test_progs -t file_reader: 1/8 passed, no skips or failures.
  - The qdisc invalid_dynptr_returned_slice case passed (1/1).
  - test_progs -t global_func: 3/29 passed, one conditional skip.
  - test_progs -t cb_refs: 1/0 passed, no skips or failures.
  - test_progs -t subprogs: 5/33 passed, no skips or failures.

The global-function skip is the compatibility ctx_arg_rewrite case,
which skips when the kernel supports the native context-argument tag.
The first subprogs run lacked two auxiliary BPF object files; after
packaging those already-built objects, only that group was rerun. The
kernel, runner and module were unchanged. No kernel WARN, Oops or panic
was found. The full unfiltered suite and sanitizer configurations were
not run; these results do not claim a dedicated R2 slice-return test.

Changes in v4:
  - Emit a function-return-specific diagnostic when a departing frame holds
    the last dynptr capable of releasing a referenced resource.
  - Run callee dynptr teardown before switching to the caller instruction so
    diagnostics and invalidation records identify the actual BPF_EXIT.
  - Move the existing callback expectation update into patch 1 to keep it
    with the diagnostic change.
  - Make the release-time test derive its slice from the caller-owned dynptr,
    isolating submit-time invalidation from callee teardown.
  - Rebase from e4a62833adff to bpf-next 10c4f610b215.

v3: https://lore.kernel.org/r/20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn

Changes in v3:
  - Replace slice reparenting with normal destruction of every dynptr in the
    departing callee stack, as suggested by Amery.
  - Invalidate escaped clone slices on frame return and test immediate use
    before resource release.
  - Cover loss of the last release-capable dynptr and add a control preserving
    a caller-owned slice while destroying a separate callee-local clone.

v2: https://lore.kernel.org/r/20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn
v1: https://lore.kernel.org/r/20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Destroy callee-local dynptrs on subprog return
  selftests/bpf: Test dynptr teardown on subprog return

 kernel/bpf/verifier.c                         | 51 ++++++++--
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 ++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 99 ++++++++++++++++++-
 4 files changed, 220 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c


base-commit: 10c4f610b215bf961235141161992f010cf7e451
-- 
2.43.0

