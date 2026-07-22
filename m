Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9963C5546;
	Wed, 22 Jul 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703707; cv=none; b=lgLLzyIGzs12T3Y4vmvci95HACdFGCVk5qO4K58lQGXapigFz4xQH3ptxqq2AVBLKXLlbdkAuPbzOCoOfBI4pSOhjg4xYvDpv+FsFgM5ME9bNrLz+R+KAgGFYPJWnhDQSlVRPhs1UMEwpO3JhBhzBIufptqQP+oIsqgMdpoVVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703707; c=relaxed/simple;
	bh=Zwc5T9avhil0jd7AX8TzA05YtCv8q+LChCTeOfgkJz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CODThs2eDjUWygoNcOZa1DUBab5mcq0fAXTNIcy/wOpy/IZJ0jHJ8MxqfGthpdGvjx8x9YrDhdj4bHS9P3iPLRnPzeiRDD0WTYBEtnqhVt5AFIcXXERMPvQcF52RSxn5Z5GAtwTLi3ggrl+HHOwEXWovpy1qdQsU3H80HTsJ7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGOvKamBqaOwFAA--.23337S3;
	Wed, 22 Jul 2026 15:01:30 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxb8fIamBqYc8UAA--.45358S2;
	Wed, 22 Jul 2026 15:01:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Test jited inline of bpf_get_smp_processor_id() for RISC-V
Date: Wed, 22 Jul 2026 15:01:27 +0800
Message-ID: <20260722070127.9679-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxb8fIamBqYc8UAA--.45358S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4xJr1fCF48Gw1rGryUArc_yoW8Ary8pF
	ykurnrtr1DGa9Fgay7AF4UAFW5XF95Z3y5Zw18C398GF1UJwnrJr98Gr13CF98CryFk3sY
	vF129F4Fga4UJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
	jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=

Add the JITed inline instruction of bpf_get_smp_processor_id() for RISC-V
to pass the test case.

On RISC-V, the 'cpu' field of 'struct thread_info' resides at offset 0x20,
BPF_REG_0 maps to the a5 register, and the thread pointer (tp) is used as
the base address. Therefore, the JIT compiler emits "lw a5, 0x20(tp)" to
optimize this helper call.

Tested on a RISC-V virtual machine.

Before:
  $ sudo ./test_progs -t verifier_jit_inline
  #610/1   verifier_jit_inline/inline_bpf_get_current_task:OK
  #610/2   verifier_jit_inline/inline_bpf_get_smp_processor_id:SKIP
  #610     verifier_jit_inline:OK (SKIP: 1/2)
  Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED

After:
  $ sudo ./test_progs -t verifier_jit_inline
  #610/1   verifier_jit_inline/inline_bpf_get_current_task:OK
  #610/2   verifier_jit_inline/inline_bpf_get_smp_processor_id:OK
  #610     verifier_jit_inline:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 02e562f56f9d..c696baa5364b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -25,6 +25,8 @@ SEC("fentry/bpf_fentry_test2")
 __success __retval(0)
 __arch_loongarch
 __jited("	ld.wu	$a5, $tp, 16")
+__arch_riscv64
+__jited("	lw	a5, 0x20(tp)")
 int inline_bpf_get_smp_processor_id(void)
 {
 	bpf_get_smp_processor_id();
-- 
2.42.0

