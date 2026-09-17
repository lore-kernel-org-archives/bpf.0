Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DD23FC5AE
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622414; cv=none; b=Namm23+rZ6QeEdMdrPBHvAcFlXeJ5kzArmRYj4hcMKGdEmVSd0Jv5UFk3MNT4oAdGk30iEGCQWeLQ+Tq2Q904Ch1bBATWv1GzCM7zQY1viz+0TCEJRSRHVMOGNbdWJAkCDIk6To+Wj5lW9mDY8DHkK+3OjL2yK2NPETN2N7+Ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622414; c=relaxed/simple;
	bh=jByJFP6oLV8TMOR6IXh50+DxwX4WRWZfEoNwd+eQ9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTWi8qSik10JPvXFdByrkkqS9xWwk+/pok9sLcGmB5XbI+Giutx4vuALwXlJDdqMhb2qtSGZXfhiHUsnacqOyRRl5Nzp4FugG4ivNr/x68U1ipzYUEi9vXSEAWieOf3x33QjsZA9jph1RL7XOkBAB+M3YKzgMjDyjC+hXdYXNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=d/7N+sTD; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="d/7N+sTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=MFfcEWomsx
	1ngAoux/pMTZWLvI62gke6tja2CwWWKWM=; b=d/7N+sTDMW9nwnSmju32a0VInU
	i3w/bICXPmrR0e+8LRaX71WXXcPFe7t7I+yvA57zsfcAXnXvF4S/7/G9lZRenjIt
	J66qYDUCP2PygwfZUXUI5+6zAwkJITvm+GjWgO2NROzpc6pBwmyXs7W/BQLjJoXC
	EPQM4UxmPN5GlCYqk=
Received: from localhost (unknown [222.195.81.43])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHNBt3eKtq0aYqAQ--.538S2;
	Thu, 17 Sep 2026 13:19:51 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/2] bpf: Track iterator-owned BTF pointer lifetimes
Date: Thu, 17 Sep 2026 13:19:46 +0800
Message-ID: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHNBt3eKtq0aYqAQ--.538S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxZrWfCw4kuFWUGFyrXrb_yoW5Jw4DpF
	WxuFW5trn7A3ZrKwsrAw17Wa4F9ryfWa15ua4rtw1Svr4UJFy8Ar4fK3WY9asxCFZ2kr12
	qw1Yv3ZxGrZrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUqJGODUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Associate non-RCU iterator BTF results and their trusted fields with the
lifetime that protects them. Check child-resource cleanup and invalidate
previous results before modeling the next iterator result.

Use the source register lifetime in the common dynptr constructor path,
while preserving clone relationships and explicit-release ownership.

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

Previous posting:
https://lore.kernel.org/r/20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn

Review that prompted this revision:
https://lore.kernel.org/r/CAMB2axMX07j49sZRmGFm2s==FMgKFzvKPWxc8hDvU=b3Lp=VOg@mail.gmail.com

This local v4 refresh is based on bpf-next 10c4f610b215.
The code and tests are unchanged by the rebase. The Fixes tag is scoped
to the task_vma snapshot implementation and its file reference.

Validation on this exact candidate, with a matching bpf_testmod:
  - W=1 verifier object and complete kernel/modules builds passed.
  - test_progs -t iters: 109 subtests passed, no skips or failures.
  - test_progs -t dynptr: 132 subtests passed, no skips or failures.
  - test_progs -t file_reader: 8 subtests passed, no skips or failures.

The first iters run aborted because the guest lacked libgcc_s.so.1 for
pthread_exit. After adding it, only iters was rerun, with the kernel,
runner and module unchanged. No kernel WARN, Oops or panic was found.
The full unfiltered BPF suite and sanitizer configurations were not run.
The new iterator cases assert verifier load outcomes and diagnostics;
they do not assert program execution return values.

Xu Yunxiang (2):
  bpf: Track iterator-owned BTF pointer lifetimes
  selftests/bpf: Test iterator BTF pointer lifetimes

 kernel/bpf/verifier.c                         |  88 ++++-
 .../selftests/bpf/progs/iters_testmod.c       | 332 ++++++++++++++++++
 2 files changed, 405 insertions(+), 15 deletions(-)


base-commit: 10c4f610b215bf961235141161992f010cf7e451
-- 
2.43.0

