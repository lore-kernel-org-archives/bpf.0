Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795857021;
	b=zdiMlF3FSgA/IWHgU6irVurwmt+tb451JJBVylYwv6bXAqgAlmaYVVSaY3qv83Kt6vuZ
	 XMAEtk/VS5jeU3NveuFaASEzlc57dJR6rbGFD8ph19OKVYC2szR1263kp0LdbMHPEqNZC
	 TKgxR+kl6KJGgCsHgPTwhPGsTm9MDe5Pz1cdHWKiA8mC0NIsxhtOPeJ60PLHevXUwSvci
	 dfxYDom3Ix4SZhZm235wHrpXc+FkzBGjecy9bwHPqDty4oABZghG0XhZvwJVIf8eQ7pVG
	 SQH47wGjaiPyXT3jtAxnBVmcKw26+nqCMCAS/0ljnMgw0wIeO8kq1dtH3EdPRQ1vNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857021;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=TRjhuNso5HcsJNHM/Yrs9ASTdOEKrDBmRimAlXk+gRM=;
	b=f83QQbSWgJblf2GV7tDtOj30fyOeCf9Xxyqr1bOFu0I8gHq99hcSTMpbuchksgx50PdI
	 eGhdDVFul35w+vPl16zKEjbWna60uUa5v8X08ef93sT38ftFc8I/yM62FEP1IKN2ZMAa3
	 HZSVubL0VnHaSWBFtjQ67dPU09Me7DoNJB1JQI/8/g93ACWI7DPUm/GKI0ljy/qQV1Pbc
	 cBUYvLNygZS1NLk9X6OXuzYv7MZ6n9pVQnK74H1L3APHOLKdCAXVu8+q756riwoCoisPX
	 f/MqnNSPbjfbpdq4EM5a9EQ7uwAS1lBAW7c/zKmBohNaHiVmjVe+qfGQGt8tN7rlIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A84606A31F;
	Sat, 28 Nov 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A84606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxyLVzmgprCsMjAA--.7735S3;
	Sat, 28 Nov 2026 17:10:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cxxmgprh_I3AA--.16824S4;
	Sat, 28 Nov 2026 17:10:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Define FUNC_REG_ARG_CNT for LoongArch
Date: Sat, 28 Nov 2026 17:10:07 +0800
Message-ID: <20261128091007.25084-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261128091007.25084-1-yangtiezhu@loongson.cn>
References: <20261128091007.25084-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx1cxxmgprh_I3AA--.16824S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWDuFy8GF47KFW5Cw4Dtrc_yoW8Cw13pa
	97ZFyakF90q3y3ZFyUCayUWr4SqrnFqr1DAr9Fy34fZF15Gw4ktwn7Jr43KwnxJrsYqr45
	Zwnrt348XFykAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

According to the Procedure Call Standard for the LoongArch Architecture,
LoongArch uses 8 general-purpose argument registers ($a0 - $a7) to pass
function arguments on both 32-bit and 64-bit ABIs.

Define FUNC_REG_ARG_CNT as 8 for LoongArch in bpf_arch_regs.h instead
of falling back to the default value of 5, so that uprobe_autoattach
can test all 8 register arguments ($a0 - $a7) on LoongArch.

Before:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  test_uprobe_autoattach:PASS:arg4 0 nsec
  test_uprobe_autoattach:PASS:arg5 0 nsec
  #659     uprobe_autoattach:OK

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
  #659     uprobe_autoattach:OK

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/bpf_arch_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arch_regs.h b/tools/testing/selftests/bpf/bpf_arch_regs.h
index 4b5744f941bd..a49686323e8f 100644
--- a/tools/testing/selftests/bpf/bpf_arch_regs.h
+++ b/tools/testing/selftests/bpf/bpf_arch_regs.h
@@ -21,6 +21,8 @@
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

