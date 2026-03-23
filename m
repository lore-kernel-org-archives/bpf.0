Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235839D6F9
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268618; cv=none; b=j14SiO6zPIODuWqKsk2WDJxDxZpzzXf3YyI6qPY1UXiWHzqj4YRZ9hruyu2f4Z7NbQH7W3vKCKPAMi/sRf/+EuQufnKMfsSXMTDVM7a9DbweBDQEINI8UpTL/Jtax8qyLnDifWec33VYkvHrp440mMgaZhd+HgP+VjXIidqk/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268618; c=relaxed/simple;
	bh=xb4fwtomHS7GnMKD0L+9zeQGcSbORvyXFmKy0bEtxnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExFfAXbraqOJPlQc6Pzn1QsueWgwEoFah1NhFasbX1SaBiHuJ930VwwqmUd60jIT/0mo6XW2N0lfj1q5w8OQAwMjJ6Q0oW6GRqVMw+t6IOU/YHq+xqqXgm99hkYcmCuX9TfVVQDlzwsrg8H0afpxyWs88pUzhuKCaFWKQrOyxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wCHjESoMMFpoyFIAA--.3841S3;
	Mon, 23 Mar 2026 20:23:05 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app3 (Coremail) with SMTP id zS_KCgBXIXWmMMFptSYOAA--.54013S2;
	Mon, 23 Mar 2026 20:23:02 +0800 (CST)
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
Subject: [PATCH bpf v3 0/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Mon, 23 Mar 2026 20:22:51 +0800
Message-ID: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBXIXWmMMFptSYOAA--.54013S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg0TCmnARgsoNgAAss
X-CM-DELIVERINFO: =?B?DaOLKgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9DlEdwel4skQ0XAijiVSoCJhzTQvTp9OqYEVPpIKLxKINCX6ej97p8F/iRS+c84hwQmS
	StixpMqe2TiiNN++3ZrRLaMVvrZtcVRXZZyknMUR01wI7QAhDAco4i1qF83GcQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4fCr4fKFWUAry8tFWDtrc_yoW8uF4kpF
	4kJ34fGryxKrW7Cr4fAanrWF45Kan5u3y7uF1fX3sIyr15tFy7Jr1kKF45u3ZxtrW7Cr1f
	ZFW2yF95W3Z5AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

v3: Resend to fix a typo in v2 and add "Fixes" tag.
    The rest of the changes are identical to v2.

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
 .../selftests/bpf/progs/call_large_imm.c      | 37 +++++++++++++
 5 files changed, 107 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

-- 
2.53.0

