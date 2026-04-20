Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C62C15AB
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683732; cv=none; b=h3GcqC4SE81kbbSSFmP/0dGqlG9xh1tQ9E7dN8oOGoDmBQ94tUNZH9a0RY//RDbGUDpWaQh4tmrTEj9TmSl77l4ttN9nP9C+2b2Db6LkMyU7pUUnuk/B23DBHRzQPjMNLRsgDTZjtDEUgIiaWDsyTZY+gwUz3cXdkZMmwWZBNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683732; c=relaxed/simple;
	bh=Pl4KSEI9LenD+jwl9WDOG+DgcPUdhzStM2jihU1PLUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jydr0jgQZ4bzUQqpvSiWKuWzipVsuYPD2uIfKcZG4aJ+ct0R9UoIXc7QqD43NHNpT031aj8Gu+jHdP6JAksaTNBjKui6VeDaoV1R799eNdXI/R+dTd0zxTdZ3GwKtrj3RywsFzjxWS/4skegJ3DJ5WYiZmHNnPa/7XEAIcwxL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx8erLCuZpcRUCAA--.7954S3;
	Mon, 20 Apr 2026 19:15:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxLMLFCuZp00RxAA--.17475S4;
	Mon, 20 Apr 2026 19:15:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC bpf-next 2/2] selftests/bpf: Add LoongArch support for get_preempt_count()
Date: Mon, 20 Apr 2026 19:15:16 +0800
Message-ID: <20260420111516.19982-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxLMLFCuZp00RxAA--.17475S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1rZrWxur4xZw13Ar48Xwc_yoW8Zr17pr
	WxAryjywn8tFW7JFsrGw4kWr4Yqrn7uas5Gw43K397AF1UXrWDXrySvrW3tF4Ygry8WrWF
	vw4Fkay5uasrJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=

There is no LoongArch support for get_preempt_count() currently and its
fallback path always returns 0, just add it so that bpf_in_interrupt(),
bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), bpf_in_task()
works for LoongArch as well. With this patch, "./test_progs -t exe_ctx"
should pass on LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index e5c039bc44cb..5847bbf12d24 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -507,6 +507,8 @@ static inline int get_preempt_count(void)
 	return bpf_get_lowcore()->preempt_count;
 #elif defined(bpf_target_riscv)
 	return bpf_get_current_task_btf()->thread_info.preempt_count;
+#elif defined(bpf_target_loongarch)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
@@ -518,6 +520,7 @@ static inline int get_preempt_count(void)
  *	* powerpc64
  *	* s390x
  *	* riscv
+ *	* loongarch
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -540,6 +543,7 @@ static inline int bpf_in_interrupt(void)
  *	* powerpc64
  *	* s390x
  *	* riscv
+ *	* loongarch
  */
 static inline int bpf_in_nmi(void)
 {
@@ -553,6 +557,7 @@ static inline int bpf_in_nmi(void)
  *	* powerpc64
  *	* s390x
  *	* riscv
+ *	* loongarch
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -566,6 +571,7 @@ static inline int bpf_in_hardirq(void)
  *	* powerpc64
  *	* s390x
  *	* riscv
+ *	* loongarch
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -587,6 +593,7 @@ static inline int bpf_in_serving_softirq(void)
  *	* powerpc64
  *	* s390x
  *	* riscv
+ *	* loongarch
  */
 static inline int bpf_in_task(void)
 {
-- 
2.42.0

