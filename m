Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916638CFF8;
	Wed, 22 Jul 2026 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687360; cv=none; b=SBsdf1uwm3apo1R2TQpZjqe71uZf2DC1ge0g6EpBJPnaPyYmLVuby6hyegurdQEk8A4Tqn6SP0QJdXUiud9if2dq0KPsmlgyBva28/0e8yHR09VsZrzDciXWAD8xwe/lg8S/EWNld3DIwXB7CNZFpu1Y7RpMMEeFUV3GESadvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687360; c=relaxed/simple;
	bh=2a2xFxA0Pk7iVCaTkFnjhuUyLzsaMAYo8+BBU6pKASw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTDqplIxg0ignMU6FPS/xRxgSeWswwq1mL0PAKEZrlRtDkr5UHg8cnOkSV4WaYfgjwNF7c34TNbHECsdHmzvNwpvOdw9RsMlio5D4xBIY1BXudDCAy3qkQOM9G0RXMQsMUul1Qj44yD9wyY77lCw9NeVBpeZw55+6UZTkHxXefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxVer1KmBqxtsFAA--.21644S3;
	Wed, 22 Jul 2026 10:29:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxb8fyKmBq9qgUAA--.44439S2;
	Wed, 22 Jul 2026 10:29:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Add get_preempt_count() support for RISC-V
Date: Wed, 22 Jul 2026 10:29:06 +0800
Message-ID: <20260722022906.8778-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxb8fyKmBq9qgUAA--.44439S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4DAF18Kr1rWFWDGw1fXwc_yoW5XF17pr
	WxJr1jywn5tFW7JFZrJw4DXF1Yqrn5Wa4rCr43K393AF1UtrWqqFySgry3tFnYgry8KryF
	v343Ka4ruasrAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=

Currently, there is no RISC-V support for get_preempt_count() and
its fallback path always returns 0.

Add it so that bpf_in_interrupt(), bpf_in_nmi(), bpf_in_hardirq(),
bpf_in_serving_softirq(), and bpf_in_task() work for RISC-V as well.

Given that RISC-V has supported CONFIG_THREAD_INFO_IN_TASK since its
initial commit fbe934d69eb7 ("RISC-V: Build Infrastructure") in 2017,
directly retrieve preempt_count from the thread_info embedded within
task_struct via bpf_get_current_task_btf().

This aligns the implementation with arm64, powerpc, and loongarch.

Tested on a RISC-V virtual machine.

Before:
  $ sudo ./test_progs -t exe_ctx
  ...
  #114     exe_ctx:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

After:
  $ sudo ./test_progs -t exe_ctx
  #114     exe_ctx:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
RFC -> v1:
  -- No code changes
  -- Update the commit message
  -- Add Tested-by and Reviewed-by
https://lore.kernel.org/bpf/0191fe3f-b956-480d-aef2-a4d75f9e02de@huawei.com/

 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 67ff7882299e..ff37ae5a113d 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -425,6 +425,8 @@ static inline int get_preempt_count(void)
 	return bpf_get_lowcore()->preempt_count;
 #elif defined(bpf_target_loongarch)
 	return bpf_get_current_task_btf()->thread_info.preempt_count;
+#elif defined(bpf_target_riscv)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
@@ -436,6 +438,7 @@ static inline int get_preempt_count(void)
  *	* powerpc64
  *	* s390x
  *	* loongarch
+ *	* riscv
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -458,6 +461,7 @@ static inline int bpf_in_interrupt(void)
  *	* powerpc64
  *	* s390x
  *	* loongarch
+ *	* riscv
  */
 static inline int bpf_in_nmi(void)
 {
@@ -471,6 +475,7 @@ static inline int bpf_in_nmi(void)
  *	* powerpc64
  *	* s390x
  *	* loongarch
+ *	* riscv
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -484,6 +489,7 @@ static inline int bpf_in_hardirq(void)
  *	* powerpc64
  *	* s390x
  *	* loongarch
+ *	* riscv
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -505,6 +511,7 @@ static inline int bpf_in_serving_softirq(void)
  *	* powerpc64
  *	* s390x
  *	* loongarch
+ *	* riscv
  */
 static inline int bpf_in_task(void)
 {
-- 
2.42.0

