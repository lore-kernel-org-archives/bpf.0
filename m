Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669997;
	b=ES+GbErxWV+RKVLN/MUPapLwVjoNOYWSwSbKXS+rJeJdFwcKKxDqdeT9jC64y2jdhdjq
	 ym6f9tGqDwELF9xwx6plHeswNiX66KT8kF5jkHTSxJpQ9VJaeTV0X0WGRdHpPLA54r5tU
	 7qouyjFzy/LO3DtBefO7zH3D2wCm/K06PbdOiF6kx38Jy14xu9Eeeupi0hG1nzWkFAK+V
	 oHDDZoaXlen633qZ4IfigChp1ftxZkaLDUMS1/2jBsHwXGWi7mvbNArGmZeR88wggZizj
	 msHZZbNFzQa5Vb5tx3G6KnoNLKEyYlLjvjJBsqd4hEvE0p92RZ1uxYuOQo37ldxr5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669997;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=1+rdBCo8pQymdZ09uE1sFtVuaCKUGgMaXoyurLdm0AI=;
	b=az9JFTxgdaQZnorCUvLOWXnlTaT9yplGq0ofVzNJKjNquNShLAwBsAtLKOw8zX1OzZf9
	 +BXpVY7Dd/I12svqFMN4Mph1HiglOMEeOs5JMsVXKtMJrpHnbji2BmhqmID1H0OWHWfh0
	 xs4BaLAVsLKzFlU+CJpmgGAJVuelO0F/RB5GILS5MIGnl4WDO4L9x8dCZWObseFE/lNQ1
	 pTHZ9LTN5OZLb7GY7Z96CqFk6abwm717ECD2JwsZetYuG11asG7LMVWFACsATSljjvXYh
	 uLnbiIFM5WiXBYLEH1sHzeR5hWbmPJMa9fSvHQ9NjXK1AkFKcJDVS/ZjRRrVsGllkJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F43606A31C;
	Thu, 26 Nov 2026 05:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F43606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxS_DpvwdrPCUjAA--.34294S3;
	Thu, 26 Nov 2026 13:13:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxFs3jvwdr63k3AA--.52601S3;
	Thu, 26 Nov 2026 13:13:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Include bpf_misc.h in uprobe_autoattach.c
Date: Thu, 26 Nov 2026 13:13:06 +0800
Message-ID: <20261126051307.13170-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261126051307.13170-1-yangtiezhu@loongson.cn>
References: <20261126051307.13170-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxFs3jvwdr63k3AA--.52601S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyxAr4UGFWkCrWrCFykJFc_yoW5tr13pa
	ykuFyakF1Sq3W3Xa47GayDWr1rWF1vqr1UAFWqq34fZF1DW3ykJr1Iqr45Jrn8WrZYvw4r
	Z3ZrKr1fXFW8ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=

Commit bc72742bebec ("selftests/bpf: Validate arch-specific argument
registers limits") originally included the header "progs/bpf_misc.h"
in prog_tests/uprobe_autoattach.c so that FUNC_REG_ARG_CNT is defined
when checking argument assertions (arg4 through arg8).

Commit 8c2b5e90505e ("selftests/bpf: add bpf_for_each(), bpf_for(),
and bpf_repeat() macros") accidentally removed this include, causing
FUNC_REG_ARG_CNT to evaluate to 0 in the preprocessor and silently
skipping all assertions beyond arg3 on every architecture.

Restore #include "progs/bpf_misc.h" in prog_tests/uprobe_autoattach.c,
while guarding __naked and SYS_PREFIX in progs/bpf_misc.h with #ifndef
to avoid redefinition conflicts with user-space headers.

Here are the test results on LoongArch, where default FUNC_REG_ARG_CNT
is 5.

Before:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  #656     uprobe_autoattach:OK

After:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  test_uprobe_autoattach:PASS:arg4 0 nsec
  test_uprobe_autoattach:PASS:arg5 0 nsec
  #656     uprobe_autoattach:OK

Fixes: 8c2b5e90505e ("selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c | 1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h               | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index d5b3377aa33c..6558c857e620 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -3,6 +3,7 @@
 
 #include <test_progs.h>
 #include "test_uprobe_autoattach.skel.h"
+#include "progs/bpf_misc.h"
 
 /* uprobe attach point */
 static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6b930cb48f8d..589e68e4fa5c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -206,7 +206,9 @@
 #define CAP_BPF			39
 
 /* Convenience macro for use with 'asm volatile' blocks */
+#ifndef __naked
 #define __naked __attribute__((naked))
+#endif
 #define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memory"
 #define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
 #define __imm(name) [name]"i"(name)
@@ -231,6 +233,7 @@
 #define __used __attribute__((used))
 #endif
 
+#ifndef SYS_PREFIX
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
@@ -250,6 +253,7 @@
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
 #endif
+#endif /* SYS_PREFIX */
 
 /* How many arguments are passed to function in register */
 #if defined(__TARGET_ARCH_x86) || defined(__x86_64__)
-- 
2.42.0

