Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731F3EF0DD
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460224; cv=none; b=inIL4EmfkGInliZbOyzxi6y894hw3HVRZ1LqsK8VwnzGYQGYPm/hAMtTyLVwqe0EbZQ6OnwBqbJh1Dd8Z1ZZK/JDN5PRzbFHslT2widWtnIep1WGa6aoRaFusuImVbfyH5Ep1sfSUmBaDHENAiKFmM8JGcXNHdYknoK6lDLSAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460224; c=relaxed/simple;
	bh=bMiJ2LDHBaCByZYr7D6TO/LltG1wwyK05mRoM7U2ulg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG9iiwmad4Dnhw9BZM5sk4toannwN1zSTXuOShfXBV0+oTHf/c/QvIiMc950NsdwL/S9ijkzQd/DdxrHP9URKMfAqI/b7adrvWw7MNufxOeiyStCSLnZLLH3w4zy0C0aMQR4VM1FxIt/ib5TNXJB4JZ9S6rODaZ5QxCj2SvtL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; dkim=pass (1024-bit key) header.d=zju.edu.cn header.i=@zju.edu.cn header.b=TKhH1lw7; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zju.edu.cn header.i=@zju.edu.cn header.b="TKhH1lw7"
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBHMQ_d4_FpQmfgAA--.931S3;
	Wed, 29 Apr 2026 18:56:31 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zju.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=7HIwpD4olK
	qImdy08AlbunkJwzlXd7xu4VF13M+Uc2g=; b=TKhH1lw77Edc2Yrd+7EOoYjc2m
	PvQ74ANCpdDO0QsiJaxbwRXyFEGMXfkm18zNCNqfqE6aZ+/+2ja5LOpp2w/iI5sW
	uC/XPfJn1hIawOMbxOO2mEX08g29uRLSLVWbIXdv6+SB9jD+k97O7/obo3rfDcfw
	xrJA5qixmWMcwlsGg=
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app4 (Coremail) with SMTP id zi_KCgBnSzTb4_FpAxGSAA--.7734S2;
	Wed, 29 Apr 2026 18:56:27 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
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
Subject: [PATCH bpf-next v8 0/3] bpf: Fix call offset truncation and OOB read in bpf_patch_call_args()
Date: Wed, 29 Apr 2026 18:56:05 +0800
Message-ID: <20260429105608.92741-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBnSzTb4_FpAxGSAA--.7734S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgUQCmnxDY40WgAAso
X-CM-DELIVERINFO: =?B?ROeUJwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Kb2a6UWAznWKC97Udwvoguj8++rr/2jVi7nQCyqKp8G7OnJnb5iBEJsdgIpEclLqOl0
	7uwExcSfgedQLqQImyIn1mIsl88nhRbBvjfvXk+smrvo42xzkgwbmrn5NzNBRw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXr48Ww48ZF1UXFyUJw4kZrc_yoWrZFW8pF
	Z5G34fKryvqrW0krWxAa1xCF45KFs5uF47uF18X343uF4avF1xtryxKF4akF9xGrZ3G3WU
	ZF4avF9xG3WUuagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Patch 1/3 fixes the pre-existing OOB read in bpf_patch_call_args(). It changes
the function to return an int and explicitly rejects the JIT fallback if 
the stack depth exceeds MAX_BPF_STACK, preventing a potential stack buffer
overflow.

Patch 2/3 fixes the s16 truncation bug. It keeps the original imm field
unchanged and uses the off field to store the interpreter function index.
It also adjusts the JMP_CALL_ARGS case in ___bpf_prog_run() and the dumper
code accordingly, while safely removing a previous workaround in the 
selftests disasm helpers.

Patch 3/3 introduces a selftest for this fix.

---

Change log:

v8:
1. Update cfg_partition_funcs() in bpftool to use insn->imm for call target
   calculation. (Sashiko AI reviewer)
2. Modify the selftest in patch 3/3: add a large padding before the call
   instruction, preventing the kernel panic on kernel without the fix.
   (Sashiko AI reviewer)
3. Modify the selftest in patch 3/3: make it more clear.

v7: https://lore.kernel.org/bpf/20260421144504.823756-1-tangyazhou@zju.edu.cn/
1. Rebase the patchset to the bpf-next tree to resolve the apply conflict. (Alexei)
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

 include/linux/bpf.h                           |  2 +-
 include/linux/filter.h                        |  3 -
 kernel/bpf/core.c                             | 17 +++--
 kernel/bpf/fixups.c                           | 12 ++--
 tools/bpf/bpftool/cfg.c                       |  2 +-
 tools/bpf/bpftool/xlated_dumper.c             | 10 +--
 tools/testing/selftests/bpf/disasm_helpers.c  | 18 -----
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_call_large_imm.c       | 66 +++++++++++++++++++
 9 files changed, 94 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c

-- 
2.54.0

