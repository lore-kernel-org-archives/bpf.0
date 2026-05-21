Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2AF202F70;
	Thu, 21 May 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368203; cv=none; b=cYesUwnJxfcduRFFKnEPFoLotfPUmAMrmtHmcpeUvSbmSXN2JHlzoCGFYUo5yky5FqML3izB8DOnn2zXBjcjSxm64IJoLUjLCY9zqTESNwJBvVDETMH0F2EMLsmzW/15tqfF0h5Gj8j1fY+SX+ZSa2UWCzJjocGQuEW1AxWgv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368203; c=relaxed/simple;
	bh=8TajBhZDe/DuXX6kTPbnhJbe3X0PQLd7VdoDY/AynWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE4BHp0KH1BOw3LdkDYXOfl+JTWQNZVfOASFS0a/Yp6wcqxIA0aDx3NifB/UlbRNvTgTOCWRZqUdsNc+C6Laa3oVeejB6IR8u32dg/gLvyIfH83sRSfW8uByfj0w0qAvz/985JSjUG/NK6+RTgDvTbOytELr9EFSpp7tLraSJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxBOkGAQ9qqP4LAA--.28949S3;
	Thu, 21 May 2026 20:56:38 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx+8EFAQ9qPBuLAA--.2485S3;
	Thu, 21 May 2026 20:56:38 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Support get_preempt_count() for LoongArch
Date: Thu, 21 May 2026 20:56:35 +0800
Message-ID: <20260521125636.26744-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260521125636.26744-1-yangtiezhu@loongson.cn>
References: <20260521125636.26744-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8EFAQ9qPBuLAA--.2485S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4xCr4fZr1xGr4xZF13Awc_yoW5tF47pr
	y8Aryjyw45JFW8KF97Jw4kZF1aqwn7Was5Gw1akw4Ska1jq3y8Xr1SgFW3tr45GryFgrW0
	vrZ7K3y3uanrAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2ID7UUUUU

There is no LoongArch support for get_preempt_count() currently and its
fallback path always returns 0, just add it so that bpf_in_interrupt(),
bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), bpf_in_task()
work for LoongArch as well.

Since LoongArch is transitioning to CONFIG_THREAD_INFO_IN_TASK, use
bpf_core_field_exists() to provide compatibility for both legacy and
future kernels. A struct flavor "task_struct___local" is introduced
to bypass static compiler checks when thread_info is missing from the
base task_struct.

For the newer kernels that select CONFIG_THREAD_INFO_IN_TASK, it reads
preempt_count from the thread_info embedded within task_struct. For the
older kernels without selecting CONFIG_THREAD_INFO_IN_TASK, it retrieves
the thread_info pointer from the bottom of the kernel stack (task->stack)
and then reads the preempt_count. This ensures the BPF selftests remain
functional across various LoongArch kernel versions.

With this patch, "./test_progs -t exe_ctx" passes on LoongArch regardless
of whether CONFIG_THREAD_INFO_IN_TASK is set.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d1db355e872b..1d0b29a9acb8 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -401,6 +401,12 @@ struct task_struct___preempt_rt {
 extern struct lowcore *bpf_get_lowcore(void) __weak __ksym;
 #endif
 
+#ifdef bpf_target_loongarch
+struct task_struct___local {
+	struct thread_info thread_info;
+} __attribute__((preserve_access_index));
+#endif
+
 static inline int get_preempt_count(void)
 {
 #if defined(bpf_target_x86)
@@ -423,6 +429,18 @@ static inline int get_preempt_count(void)
 	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #elif defined(bpf_target_s390)
 	return bpf_get_lowcore()->preempt_count;
+#elif defined(bpf_target_loongarch)
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct task_struct___local *task_alt = (void *)task;
+
+	if (bpf_core_field_exists(task_alt->thread_info)) {
+		return BPF_CORE_READ(task_alt, thread_info.preempt_count);
+	} else {
+		void *stack = BPF_CORE_READ(task, stack);
+		struct thread_info *ti = (void *)stack;
+
+		return BPF_CORE_READ(ti, preempt_count);
+	}
 #endif
 	return 0;
 }
@@ -433,6 +451,7 @@ static inline int get_preempt_count(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* loongarch
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -454,6 +473,7 @@ static inline int bpf_in_interrupt(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* loongarch
  */
 static inline int bpf_in_nmi(void)
 {
@@ -466,6 +486,7 @@ static inline int bpf_in_nmi(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* loongarch
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -478,6 +499,7 @@ static inline int bpf_in_hardirq(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* loongarch
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -498,6 +520,7 @@ static inline int bpf_in_serving_softirq(void)
  *	* arm64
  *	* powerpc64
  *	* s390x
+ *	* loongarch
  */
 static inline int bpf_in_task(void)
 {
-- 
2.42.0

