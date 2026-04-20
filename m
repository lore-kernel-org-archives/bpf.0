Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5B34A3AB
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683731; cv=none; b=V4lnOQXqrcsYxpHTgkNfgXWflufipgJCLo74BCF8154lmmPlB6fZl6kLxcByHEiPKyKtqHKwDL+8sgBAUwvrPb9Iz/D4VWZr4qOPKH/+OMgE8X1sTLPgz5EnLf/KSTvDq9zhlKrbW4YIEa8RmkynMx16plBeFv712P55XQSlRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683731; c=relaxed/simple;
	bh=MxvGhSm2daiOI3czmESnePC57J9GRBOC0tMTwf1WQdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+BXNfbchyUTlWGCMS9rRWynfQr6INd89XoW8aVcfQux0g5/vsI5E9TKZgYAmJO3f5Ii/nfvHYTl4F9cwIogdT5OzNrTD158NhjW3qTR+lXRmg/H7/N+oUUfs2lZIBHJZjQx6aUjMt8VLzButqc9mZzvXBKDQ6CFBFzNW1u3xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxVunHCuZpbxUCAA--.2051S3;
	Mon, 20 Apr 2026 19:15:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxLMLFCuZp00RxAA--.17475S3;
	Mon, 20 Apr 2026 19:15:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC bpf-next 1/2] selftests/bpf: Add riscv support for get_preempt_count()
Date: Mon, 20 Apr 2026 19:15:15 +0800
Message-ID: <20260420111516.19982-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260420111516.19982-1-yangtiezhu@loongson.cn>
References: <20260420111516.19982-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMLFCuZp00RxAA--.17475S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWrGrWrGFy3AFW3Jw4kZrc_yoW8CFyfpr
	W8try0yw1YyFW7JFsrGw4kGw4Yqrn5Was5Cw13KrZ7AF1YqrWkXFyS9rW3trs0gryFqrWF
	vw1akrWruasrJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

There is no riscv support for get_preempt_count() currently and its
fallback path always returns 0, just add it so that bpf_in_interrupt(),
bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), bpf_in_task()
works for riscv as well. With this patch, "./test_progs -t exe_ctx"
should pass on riscv.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..e5c039bc44cb 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -505,6 +505,8 @@ static inline int get_preempt_count(void)
 	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #elif defined(bpf_target_s390)
 	return bpf_get_lowcore()->preempt_count;
+#elif defined(bpf_target_riscv)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
@@ -515,6 +517,7 @@ static inline int get_preempt_count(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* riscv
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -536,6 +539,7 @@ static inline int bpf_in_interrupt(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* riscv
  */
 static inline int bpf_in_nmi(void)
 {
@@ -548,6 +552,7 @@ static inline int bpf_in_nmi(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* riscv
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -560,6 +565,7 @@ static inline int bpf_in_hardirq(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* riscv
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -580,6 +586,7 @@ static inline int bpf_in_serving_softirq(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* riscv
  */
 static inline int bpf_in_task(void)
 {
-- 
2.42.0

