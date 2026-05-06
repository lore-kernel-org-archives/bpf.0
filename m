Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82F3EBF18
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060891; cv=none; b=p22vWQUJNEGxzddRn13UvHSh7XEdmCI0GnKPA/ZafXe79vYG0c4goyYKH0kzRpUjtfkZlNYeMM91CDMGkjhJf4KP/xiW3e9IRzbqjZnUN/+wNQ8Ruj+GOCHv7U5lsG4chR3Vr8jOMMGlHxJNOA0qKoaOGUxvaRFdp0uBahbQTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060891; c=relaxed/simple;
	bh=F9IJ9m3rerkQ9nWug00p1ofBLBzY7opWFWwkl2upgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJvimPcqMukWhzIsvv4ozdKmpFa3iCWjb5GWKR2ya8ZgLVt4nQZqBUyMnhgfPy3te673vHo2CnnS8xkXmubgxQZapLy7atH4rjSOs0DSwmwDDy7oa279Zq3K4DBYxC7gN5GeJzUlYkc4h6kjJ350NvkagDzM5zXszgTzaPt7NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDHNkQ2DvtpB+EWAQ--.1141S3;
	Wed, 06 May 2026 17:47:35 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgBX7KY0Dvtpk2ffAA--.1606S2;
	Wed, 06 May 2026 17:47:32 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v10 0/3] bpf: Fix call offset truncation and OOB read in bpf_patch_call_args()
Date: Wed,  6 May 2026 17:47:11 +0800
Message-ID: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBX7KY0Dvtpk2ffAA--.1606S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgUDCmn6SA801gABs5
X-CM-DELIVERINFO: =?B?V4NdegXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9MGY/uOLFlHC2dypexd+liVpOoIXhrGzgObvaWedo+//ZGkoHJX14/EQNspT5a87xRrC
	MOkHeYrfITyqILgV/DmlDTwtDRBa6hKmIj2tRuapTLdH4gN4RiB1unmWZ4+waA==
X-Coremail-Antispam: 1Uk129KBj93XoWxXr48Ww48ZF1UXFyUJw4kZrc_yoW7Jr4UpF
	s5G34fGr1vqrWIkrZ7Aw429F45tan5ua17uF1rJ3s3ZF4YvF1xtFykKr4a9F9xJrZ7C3WU
	ZF4avF95Ca4UC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YFAJUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset addresses a silent truncation bug in the BPF verifier that
occurs when a bpf-to-bpf call involves a massive relative jump offset.
Additionally, it fixes a pre-existing out-of-bounds (OOB) read issue
in the interpreter fallback path.

Because the BPF instruction set utilizes a 32-bit imm field for bpf-to-bpf
calls, implicitly downcasting it to the 16-bit insn->off in bpf_patch_call_args()
causes incorrect call targets or subprog ID resolution for large BPF programs.
While fixing this by swapping the imm and off fields, it was discovered that
the original code also had a load-time OOB read vulnerability when the stack
depth exceeds MAX_BPF_STACK during JIT fallback.

Patch 1/3 fixes the pre-existing OOB read in bpf_patch_call_args(). It
changes the function to return an int and explicitly rejects the JIT
fallback if the stack depth exceeds MAX_BPF_STACK, preventing a potential
stack buffer overflow.

Patch 2/3 fixes the s16 truncation bug.
1. Keep the original imm field unchanged and use the off field to store
   the interpreter function index.
2. Adjust the JMP_CALL_ARGS case in ___bpf_prog_run() accordingly.
3. Restore the legacy xlated dump layout in bpf_insn_prepare_dump().

Patch 3/3 introduces a selftest for this fix.

---

Change log:

v10:
1. Make the error log in patch 1/3 more clear. (Kuohai)
2. Drop bpftool and disasm_helpers.c changes, and instead restore the
   legacy xlated dump layout in bpf_insn_prepare_dump(). This avoids
   requiring bpftool compatibility handling. (Quentin and Alexei)

v9: https://lore.kernel.org/bpf/20260429171904.107244-1-tangyazhou@zju.edu.cn/
1. Modify the selftest in patch 3/3: use __clobber_all in inline asm.
   (Sashiko AI reviewer)

v8: https://lore.kernel.org/bpf/20260429105608.92741-1-tangyazhou@zju.edu.cn/
1. Update cfg_partition_funcs() in bpftool to use insn->imm for call target
   calculation. (Sashiko AI reviewer)
2. Modify the selftest in patch 3/3: add a large padding before the call
   instruction, preventing the kernel panic on kernel without the fix.
   (Sashiko AI reviewer)
3. Modify the selftest in patch 3/3: make it more clear.

v7: https://lore.kernel.org/bpf/20260421144504.823756-1-tangyazhou@zju.edu.cn/
1. Rebase the patchset to the bpf-next tree to resolve the apply conflict.
   (Alexei)
2. Add Patch 1/3 to properly fix a pre-existing OOB read in bpf_patch_call_args().
   (Sashiko AI reviewer)

v6: https://lore.kernel.org/bpf/20260412170334.716778-1-tangyazhou@zju.edu.cn/
1. Use a different but clearer approach to resolve this issue: keeping
   the original imm field unchanged and using the off field to store the
   interpreter function index. (Kuohai)
2. Update the related dumper code and remove a previous workaround in the
   selftests disasm helpers, which is no longer needed after this fix.

v5: https://lore.kernel.org/bpf/20260326090133.221957-1-tangyazhou@zju.edu.cn/
1. Some minor changes in commit messages. (AI Reviewer)

v4: https://lore.kernel.org/bpf/20260326063329.10031-1-tangyazhou@zju.edu.cn/
1. Remove some redundant commit messages of patch 2/3. (Emil)
2. Change the number of instructions in padding_subprog() from 200,000
   to 32,765, which is the minimum number of instructions required to
   trigger the verifier failure. (Emil)

v3: https://lore.kernel.org/bpf/20260323122254.98540-1-tangyazhou@zju.edu.cn/
1. Resend to fix a typo in v2 and add "Fixes" tag. The rest of the changes
   are identical to v2.

v2 (incorrect): https://lore.kernel.org/bpf/20260323081748.106603-1-tangyazhou@zju.edu.cn/
1. Move the s16 boundary check from fixup_call_args() to bpf_patch_call_args(),
   and change the return type of bpf_patch_call_args() to int. (Emil)
2. Add Patch 3/3 to fix the incorrect subprog ID in dumped bpf_pseudo_call
   instructions, which is caused by the same truncation issue. (Puranjay)
3. Refine the new selftest for clarity and add detailed comments explaining
   the test design. (Emil)

v1: https://lore.kernel.org/bpf/20260316190220.113417-1-tangyazhou@zju.edu.cn/

Yazhou Tang (3):
  bpf: Fix out-of-bounds read in bpf_patch_call_args()
  bpf: Fix s16 truncation for large bpf-to-bpf call offsets
  selftests/bpf: Add test for large offset bpf-to-bpf call

 include/linux/bpf.h                           |  8 ++-
 include/linux/filter.h                        |  3 -
 kernel/bpf/core.c                             | 27 +++++---
 kernel/bpf/fixups.c                           | 13 ++--
 kernel/bpf/syscall.c                          | 26 ++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_call_large_imm.c       | 66 +++++++++++++++++++
 7 files changed, 129 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c

-- 
2.54.0

