Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881830EF7B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506865; cv=none; b=bEWupJPswQQUEAkz8YHlu+wIiCBPckhT2q1TR3d8KMOjhQxER45T5bsIOawfVtwdQo9M4LkemtH4Qx4iA06O0h7LVmS4Sz0vLu5L4TJoBr9hPFAiQrUWneaC6L2LRQIH+2uiV2wbo8jRxaDYmsQonEMHL8ASo3vJ0w8SVWDQptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506865; c=relaxed/simple;
	bh=xBzvgQnv0g3ZH/dBE3R5fgQwYFnDo4h1E3v0LFWdJKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cii+i0poqaE6Ohb5x/PzecMCeT2ka2yAmXRZ/wuLNc5dQUpHceSsjBzKvlsCBChYbOrwYzMh8E5HC368DSUQZapF9otY7kjNHvus5B5U6jXqMkZZka1wQpEot66RCfpO3iw6Z8+4ZVHy7I96JLqJAu3RooCRUzSsp7oTzP9dsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wAXeLBN08RpTuAEAA--.9698S3;
	Thu, 26 Mar 2026 14:33:50 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [115.236.2.94])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH+c5B08RpA3kqAA--.55576S2;
	Thu, 26 Mar 2026 14:33:38 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf v4 0/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Thu, 26 Mar 2026 14:33:26 +0800
Message-ID: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH+c5B08RpA3kqAA--.55576S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIBCmnC6QtZNQABs7
X-CM-DELIVERINFO: =?B?x7VPHAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9EgOJRkhWYhllRvpYFmgQv/m1oHotqNwaoWelSOfl8lCO5P7RtaL6gMsBCLET446myPI
	7cyb+odkRC5uxTZHPdafLS1+7GEO9aonCHy/6M1uZv00UxOl1UEwQDbUhBa4SA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4fCr4fKFWUAry8tFWDtrc_yoW5JF18pF
	4kJ34fJr97trW7Cr4fAanrWF43Kan5u3y7ur1fX3sIyr4YyF18JF1kKr45CasxJrW7Cr1I
	vFW2yF98W3WrAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
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
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset addresses a silent truncation bug in the BPF verifier that
occurs when a bpf-to-bpf call involves a massive relative jump offset.
Because the BPF instruction set utilizes a 32-bit imm field for bpf-to-bpf
calls, implicitly downcasting it to the 16-bit insn->off causes incorrect
call targets or subprog ID resolution for large BPF programs.

Patches 1/3 and 2/3 fix the interpreter path by explicitly checking the offset
boundary in bpf_patch_call_args() and introduce a selftest for verification.

Patch 3/3 fixes a related issue in jit_subprogs() where the truncated
insn->off causes tools like bpftool to incorrectly dump the subprogram name.

---

Change log:

v4:
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
  bpf: Reject bpf-to-bpf call with large offset in interpreter
  selftests/bpf: Add test for large offset bpf-to-bpf call
  bpf: Fix incorrect subprog ID in dumped bpf_pseudo_call instructions

 include/linux/bpf.h                           |  2 +-
 kernel/bpf/core.c                             |  7 ++-
 kernel/bpf/verifier.c                         | 12 ++++-
 .../selftests/bpf/prog_tests/call_large_imm.c | 54 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 46 ++++++++++++++++
 5 files changed, 116 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

-- 
2.53.0

