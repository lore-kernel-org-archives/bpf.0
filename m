Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B539524B;
	Tue, 26 May 2026 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777591; cv=none; b=Su1tYRj0bbm081deFuUcSclikO63Cm8me/sqtoGX8jGuFiCbEca45FJA2RiUpzVbqs9BUBUJaMK0rJUGPeUBxKIcvva48N/nfDjf4je07hM/03krgLp3WR7RWveRfVX7JoSZFT5a5h185vLmuRYV0KWvIx0+ZuO/J7YAAXjFvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777591; c=relaxed/simple;
	bh=InmskBsL43DvgxQ4LZbni0cgwDfdI+KD/WkqFlumQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDRa9LjYgwZGDxWdcQ8G49L9aJ0Nad+ud8UQOJxUZBchylwV5200UUF4n7ix1p7D5tMWO+7pf2ENqgPukIj0qelW86IL9Dnhz3se8z+pzyA/RwYWAjyJK4gFrpU6DN9Y+ugOebMQEGldOlx211X0NnrnfF9eA+ikhdOdtwoug80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxRektQBVqYUsNAA--.31804S3;
	Tue, 26 May 2026 14:39:42 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxGMEpQBVqHV2RAA--.64236S2;
	Tue, 26 May 2026 14:39:38 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add __NR_bpf definition for LoongArch
Date: Tue, 26 May 2026 14:39:36 +0800
Message-ID: <20260526063936.16769-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMEpQBVqHV2RAA--.64236S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFy7Gw43Kw1DJFy7JF1kZwc_yoW8Ar4xpw
	4UCa40kr15GFW5Jw10vFsYqw43Grn7tryjqayrCw4xCFs5J3WxJr1qvFZ8ZF1aqw4Fk342
	kr1Yg3s8Zr18AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jepB-UUUUU=

LoongArch uses the generic syscall table, where __NR_bpf is defined
as 280 in include/uapi/asm-generic/unistd.h.

To align with other architectures, add the __NR_bpf definition for
LoongArch to avoid a potential compilation failure: "error __NR_bpf
not defined. libbpf does not support your arch."

This is a follow up patch of:

  commit b0c47807d31d ("bpf: Add sparc support to tools and samples.")
  commit bad1926dd2f6 ("bpf, s390: fix build for libbpf and selftest suite")
  commit ca31ca8247e2 ("tools/bpf: fix perf build error with uClibc (seen on ARC)")
  commit e32cb12ff52a ("bpf, mips: Fix build errors about __NR_bpf undeclared")

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/build/feature/test-bpf.c | 2 ++
 tools/lib/bpf/bpf.c            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
index e7a405f83af6..89d59674f39b 100644
--- a/tools/build/feature/test-bpf.c
+++ b/tools/build/feature/test-bpf.c
@@ -20,6 +20,8 @@
 #  define __NR_bpf 6319
 # elif defined(__mips__) && defined(_ABI64)
 #  define __NR_bpf 5315
+# elif defined(__loongarch__)
+#  define __NR_bpf 280
 # else
 #  error __NR_bpf not defined. libbpf does not support your arch.
 # endif
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3cd705802330..bc513aa8f404 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -59,6 +59,8 @@
 #  define __NR_bpf 6319
 # elif defined(__mips__) && defined(_ABI64)
 #  define __NR_bpf 5315
+# elif defined(__loongarch__)
+#  define __NR_bpf 280
 # else
 #  error __NR_bpf not defined. libbpf does not support your arch.
 # endif
-- 
2.42.0

