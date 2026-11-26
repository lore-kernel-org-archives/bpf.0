Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669998;
	b=uA193Sb+QnZxLWoMQqrw93srMaG8xfmHC1nm79Oc84KgSa7sKR6GWE7zwJ8FkeSBuwrn
	 oFfqDJEvouoJOcJrWjjrYDq20nnJ3BfFojx73ecwHJ1KWd6fJO8yjOBKStOuvsyrq2kx3
	 SjV+cZsJ51FyUb1AbYcZRxAI6OKVx54XkRCachcCjYavRg5XBdZoMbuPeNKLyrHSeWESA
	 ZnWWkX43c2gmfrTClTbVG0augiA4kV3r9daJakbdtxUa0UWh3Tg7uLA6izKjwqTRJtfZ/
	 MPXFWkjQd+2RhXwuYBU31SDKEugjVg3MfvfFvkyvW+nYrmlCvHWCoH+Qfq78dQZPdxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669998;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=NGv2vBY+WlW+S7cf+GIX+vt5o+4l9d9qj0Qvjd5vPws=;
	b=SUVfDFgcWmYsnnvosmEZMKmuXT2PkaQYqtCoscU3mtWv32wNIsaCNRXrANNdrq5oH2S4
	 qP4jaeZ7LvDA4MJ+eD0HmqL3Ek/6WI70VMNTP2vPcGxZaDGVnWTIkkNKW5QzujJRU6oz6
	 yTG8mL25Wt169fmMa7vGvVyxUGbpQN3wE0Gm4A5f5bLuwtYlRvBinLHMF0u8l+5dObLaV
	 yZDhEnd7trRz9tZ+nUSh4BHog42YnEE7ehZtqdPf5XQhbR+gxr72f/+G3yI7ZzM/a0TaC
	 jDFty+/4aOQVDiRt/eac+xw1B+mpgyUqEjt3rL+0QcQN2Q3DWfoTATPrE3CcuEMvjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C2606A321;
	Thu, 26 Nov 2026 05:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cx_9LqvwdrQSUjAA--.34322S3;
	Thu, 26 Nov 2026 13:13:14 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxFs3jvwdr63k3AA--.52601S4;
	Thu, 26 Nov 2026 13:13:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Define FUNC_REG_ARG_CNT for LoongArch
Date: Thu, 26 Nov 2026 13:13:07 +0800
Message-ID: <20261126051307.13170-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs3jvwdr63k3AA--.52601S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1UJF1xXry8WrWkGw4DAwc_yoW8Cw1kpa
	9rZFyakF90q3y3ZFy7GayUWr4Fqrn7tr4UAFZI934fZF1rGw4ktwn7tr43KwnxXrsYqr45
	Zwsrt34rXFWkAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

According to the Procedure Call Standard for the LoongArch Architecture,
LoongArch uses 8 general-purpose argument registers ($a0 - $a7) to pass
function arguments on both 32-bit and 64-bit ABIs.

Define FUNC_REG_ARG_CNT as 8 for LoongArch in bpf_misc.h rather than
falling back to the default value of 5, so that uprobe_autoattach can
test all 8 register arguments ($a0 - $a7) on LoongArch.

Before:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  test_uprobe_autoattach:PASS:arg4 0 nsec
  test_uprobe_autoattach:PASS:arg5 0 nsec
  #656     uprobe_autoattach:OK

After:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  test_uprobe_autoattach:PASS:arg4 0 nsec
  test_uprobe_autoattach:PASS:arg5 0 nsec
  test_uprobe_autoattach:PASS:arg6 0 nsec
  test_uprobe_autoattach:PASS:arg7 0 nsec
  test_uprobe_autoattach:PASS:arg8 0 nsec
  #656     uprobe_autoattach:OK

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 589e68e4fa5c..c738dd36d1b8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -274,6 +274,8 @@
 #define FUNC_REG_ARG_CNT 6
 #elif defined(__TARGET_ARCH_riscv) || defined(__riscv__)
 #define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_loongarch) || defined(__loongarch__)
+#define FUNC_REG_ARG_CNT 8
 #else
 /* default to 5 for others */
 #define FUNC_REG_ARG_CNT 5
-- 
2.42.0

