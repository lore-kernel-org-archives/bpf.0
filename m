Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D356779;
	Thu, 13 Aug 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604955; cv=none; b=GPZihOvYK8YhiOC4FUmSSDEhKy0qQiaJYeFperg94pjPbF/3PMfrd4bB4NpmTL6E1jTj9Dbcq4lcjhZy0Pz/bmEwNFYrcIY3U7gfTnXAjk63M84eHpJLQMka1+jqo4AqNIG1Q6DnEiGDth4xl/H8obcDXcC3fX9AE3Z3LXU39PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604955; c=relaxed/simple;
	bh=6Z1KVKHKC7XX4FfaZ954+tbK1vGqBHuDIcjuPObLF5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcYfBxNxB+LxaaqBQUMSdHYYy+vPtQAqzuG1FJrtZnUJKcLm+Ona2Z2EJf/aGQ5t+Ci1l02Pbtap/ph1I4hqvY7UMLK7XBNG5zaWMi3eWx+XW3v+n/edGZO9FnDDlEpVeElJmoQ4jLFPw+XLAICQ61h3V2c6cbH8qZ3v4mofRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9KVbX1qc9MAAA--.2500S3;
	Thu, 13 Aug 2026 15:09:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxNs2UbX1qrRADAA--.7861S2;
	Thu, 13 Aug 2026 15:09:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Enable timed may_goto tests for LoongArch
Date: Thu, 13 Aug 2026 15:09:06 +0800
Message-ID: <20260813070906.5164-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxNs2UbX1qrRADAA--.7861S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw48XFWfGw4fArWkWw4kAFc_yoW5KFWxpa
	4kuasIkr18Jw1DJF9rGr4UWFW5Xrn293yaqr4ftryfAF17Jr97WF1xK34UKFyY9F4ruw4F
	va129F98Xa18ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Enable stream_cond_break, may_goto_interaction, and verifier_may_goto_1
tests for LoongArch, aligning with recent architectural infrastructure
support (timed may_goto and arch_bpf_stack_walk JIT).

With this patch, the following tests passed on LoongArch:

  sudo ./test_progs -a stream_success/stream_cond_break
  sudo ./test_progs -a verifier_bpf_fastcall/may_goto_interaction
  sudo ./test_progs -a verifier_may_goto_1

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
This patch is based on the latest bpf-next tree, it depends on the
following two patches:

LoongArch: BPF: Add timed may_goto support
https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@linux.dev/

LoongArch: BPF: Implement arch_bpf_stack_walk()
https://lore.kernel.org/loongarch/20260813045306.21571-1-yangtiezhu@loongson.cn/

They are expected to be merged into v7.3-rc1 during the upcoming merge
window through the loongarch-next tree.

 tools/testing/selftests/bpf/progs/stream.c                | 1 +
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 1 +
 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c   | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 00a37933e411..8e8e1339dc74 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -65,6 +65,7 @@ __arch_x86_64
 __arch_arm64
 __arch_s390x
 __arch_riscv64
+__arch_loongarch
 __success __retval(0)
 __stderr("ERROR: Timeout detected for may_goto instruction")
 __stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 4cfaa6b4ab40..328cf630210a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -665,6 +665,7 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __log_level(4)
 __msg("subprog 0 (may_goto_interaction) main {{.*}} stack 24")
 /* may_goto counter at -24 */
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 0e211f030d0d..db7e30da234f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -12,6 +12,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -33,6 +34,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -56,6 +58,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -83,6 +86,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r12 = *(u64 *)(r10 -16)")
@@ -120,6 +124,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
+__arch_loongarch
 __success
 __retval(0)
 __naked void timed_may_goto_preserves_regs(void)
-- 
2.42.0

