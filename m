Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FCFF4F1
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776013473; cv=none; b=KPYR65xszIVclK8LRftRVTp4JNSfA8fl/pXKaZCuzp4KJQOFi9L1MhmC+5ciOsAPTPEgeE07mmoVR0AJMiaM8CvmwKGRMBWOuy9IRDJTsiSjbUgjDjPAm+loZjbS3atYTJK8VS3yWTfH6+d3C9cU1hNpFkK9ScmcCN68NY7dyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776013473; c=relaxed/simple;
	bh=njt/dt8pZXOBdYcCiws+7I9kh9JDwOWiezwWsW4/1Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6kOwa8z3qx3TUcfsf9ETHv61bzpn7RWboINumf6GV5+MwHmRgFncOWKMb86JdohjOS78e1YuCCXXiVz+lg8to8kndkCAWbi2par9n0NBZPKrx9LBhIq5nsr5Fh6FRnA3nAOpeanADvGTIHcQISYt/pLZ0XCKbv15v0jWGX0ysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDXygJ60NtpCSZPAA--.6146S3;
	Mon, 13 Apr 2026 01:03:55 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3z3F30Ntpza9xAA--.20595S2;
	Mon, 13 Apr 2026 01:03:52 +0800 (CST)
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
Subject: [PATCH bpf v6 0/2] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Mon, 13 Apr 2026 01:03:32 +0800
Message-ID: <20260412170334.716778-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgC3z3F30Ntpza9xAA--.20595S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgcTCmnapA0XkQAAsA
X-CM-DELIVERINFO: =?B?dXMiDQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9ChsEUMqhoN+0lPZhtsLtYcbci40Sv46CutSryw8bs2Zgrx28D9MavfgzuNjvt1ODl4y
	aejhuej2B4TaJdio7mOueYKdVMh3LynohC7zz5pvopsuxaEPtsAJQxxNe01LGw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXr4UGw13ArykAw4DAr1fAFc_yoW5ur4kpa
	1kG34fKrZ7trWxGr4xAa17uF45KF4kuw47uF1fJ34Svw4YvFyxJr1xKr4YkF9xGFZ7Cw17
	ZF4S9F98W3W8AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
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
Because the BPF instruction set utilizes a 32-bit imm field for bpf-to-bpf
calls, implicitly downcasting it to the 16-bit insn->off causes incorrect
call targets or subprog ID resolution for large BPF programs.

Patch 1/2 fixes the interpreter path by keeping the original imm field
unchanged and using the off field to store the interpreter function index
in bpf_patch_call_args(). It also adjusts the JMP_CALL_ARGS case in
___bpf_prog_run() and the dumper code accordingly, while removing a
previous workaround in the selftests disasm helpers.

Patch 2/2 introduces a selftest for this fix. When JIT is disabled, running
the test without this fix triggers a kernel panic due to an invalid call
target caused by the truncation issue.

---

Change log:

v6:
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

Yazhou Tang (2):
  bpf: Fix s16 truncation for large bpf-to-bpf call offsets
  selftests/bpf: Add test for large offset bpf-to-bpf call

 include/linux/filter.h                        |  3 --
 kernel/bpf/core.c                             | 10 ++--
 kernel/bpf/verifier.c                         |  6 +--
 tools/bpf/bpftool/xlated_dumper.c             | 10 ++--
 tools/testing/selftests/bpf/disasm_helpers.c  | 18 --------
 .../selftests/bpf/prog_tests/call_large_imm.c | 29 ++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 46 +++++++++++++++++++
 7 files changed, 88 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

-- 
2.53.0

