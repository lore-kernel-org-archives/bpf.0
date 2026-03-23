Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2711C84D0
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253915; cv=none; b=NDGAO95HBijc83pW96TfMBxpQEBmN0UEHNsJruT/OEIrQ1r2DqHMDoHfkHl9WiBBqD4wF/cwppghqupgF3kMRvzTdXxxM+CVn/+MB5ZweaWz1I2ShBgyuDTNG8gpVaAAX3qZTG25RLD79++iHNQ4PACrd3XUXV12Do6q0G/Nocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253915; c=relaxed/simple;
	bh=B+Wy/lobYZodbTi4NqS/IlwVnsnFsdp4hEGs7AVPA+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2kjJSdwo7Qn2xgXpiSLkdlZ7FNsKEeAJxZJhQtU0mlWpGvQyjSs47GRVXjC1YFhYQMLPK6xPU4QB//595jluCzoiDW9TLoVchllZ/DXTMNM2wsh+UDxdUJnvekrTynYIN8xFhqnBuXAfSgARvaFYFpHsARe9xp24QzIGz58eCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wCHj6c398Bpmc1GAA--.917S3;
	Mon, 23 Mar 2026 16:18:00 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3WzQ298BpJ0UMAA--.514S2;
	Mon, 23 Mar 2026 16:17:58 +0800 (CST)
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
Subject: [PATCH bpf v2 0/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Mon, 23 Mar 2026 16:17:45 +0800
Message-ID: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3WzQ298BpJ0UMAA--.514S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMQCmm8UYsYPgABs3
X-CM-DELIVERINFO: =?B?srCPDAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BZfZ83D7fDWWCSgyGjOU4+nB41fZDbWbkypx8bH5SGBT6MtvduMdqR6BdD64BJNnn1a
	iNcjUDNbaTp6ZwVfePWu8DIUZu+5IHNFY4BkdQ+i3QQmIyqmN6TD3OI5FLsRrA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4fCr4fKFWUAry8tFWDtrc_yoW8Cw4fpa
	ykJa4fGryxKFW7Cr43AanrWF43Gan3u3y7uF1fX3s0yw1Utry7Jr1kKF45C3ZxGryfCr1f
	ZFW2yF95W3Z5AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwrWrDUUUU

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

Changes v1 => v2:

1. Move the s16 boundary check from fixup_call_args() to bpf_patch_call_args(),
   and change the return type of bpf_patch_call_args() to int. (Emil)
2. Add Patch 3 to fix the incorrect subprog ID in dumped bpf_pseudo_call
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
 .../selftests/bpf/prog_tests/call_large_imm.c | 53 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 37 +++++++++++++
 5 files changed, 106 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

-- 
2.53.0

