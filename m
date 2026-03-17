Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D91D6187;
	Tue, 17 Mar 2026 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713115; cv=none; b=KGmCoAhKVpC9MFVz4sFs4FOT3zX+A65S4JdxTBWLJLilzdASk/a3kPoj7+vjUn0R8cEX3HuSEEDu5ngxbElC2vaL4ZJt8JFVnrT5YAqmhfTVzJbxmZBz+voAyDj8N+i/+4yWwuL/wiecfR9Tv4QUBNHwk8XfRwkIFlzpy570dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713115; c=relaxed/simple;
	bh=tfwNf41ejK8KnD9NFWnuWxv4enrqedRikctxYHlNzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAfcLv1LW/br1YfqBD4CTWR0YpDdxh23Mctd9vEuwBOxUEk6Racc0BoVL7xL90m/zNt8jOo1bDwLsjqUeRoLTdfhHfZIDQOHbeQ4LiW+DdhhDffPdl5cwNQmLxzvzTeXbs7IM4FWIiQByXeCofg5vsEMZw9XZHw2CxIw5nhMDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxssDXtrhpEsobAA--.21330S3;
	Tue, 17 Mar 2026 10:05:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxHOHTtrhpKcVWAA--.34870S2;
	Tue, 17 Mar 2026 10:05:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Add alignment flag for test_verifier 190 testcase
Date: Tue, 17 Mar 2026 10:05:06 +0800
Message-ID: <20260317020506.27797-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHTtrhpKcVWAA--.34870S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4DAry7tryrCF4xAFyktFc_yoW8Wrykpw
	1fAa90kFn5tF17CFy7A39ruFWrWFZ8XryfGF1jkryUZw10yry7JrWxKF17Xr9xZ395tw4S
	yrySyFW2v3Z5ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unconditionally for the
most archs such as x86_64, aarch64, ppc64el and s390x, but this config
may be not set by users for riscv64 and loongarch64.

There exists failure about misaligned access when executing the testcase
"./test_verifier 190" when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not
set on LoongArch due to CONFIG_ARCH_STRICT_ALIGN is set by default.

It means that the program has unaligned accesses, but the kernel enables
the compiler option -mstrict-align to prevent unaligned accesses, so add
a flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS into the testcase to avoid the
failure.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
---

v2: Update the commit message and collect R-b and A-b,
    thanks Emil and Paul.

 tools/testing/selftests/bpf/verifier/calls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 86887130a0ef..29e57f0e56c3 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1521,6 +1521,7 @@
 	.errstr = "R0 invalid mem access 'scalar'",
 	.result_unpriv = REJECT,
 	.errstr_unpriv = "invalid read from stack R7 off=-16 size=8",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
-- 
2.42.0

