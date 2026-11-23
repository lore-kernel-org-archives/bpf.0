Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409414;
	b=iZBrW67neRG0brPGR+Jbz6ZBCm+m95LT7Fpsjq+hFF14Vy8i2LiLgHORI+tMlNlQS6Dh
	 z/H298gCsM0hI5M6PPKjQ+/s2StPSdAL7e6rXwe+e+qdef4TCZubzlJdhQES6W2l+pBOV
	 fhHtMg4fFfhJgqbSb40VTQLQ0mVRZXLr6JiKMRCt9ogywJwv9astPyqY+zWOKqEQ1o3Dj
	 6OHEukaMUglp6GT1dmn2vnXc+2K9nxbWDJh5kGwWlbzBdnmxEjY00nNX2WXHWZ2amSxR1
	 a+kbZIq+bYPNzCXqU1JCRof6zv+GU8EmGU1+DFYHQQyGJjbV9PbAuRJQKzPL+GbPhIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409414;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=4iuo+qnHY3sqHshJJ3dhJfZ/o44FpiiMLN1F2IDDpgg=;
	b=dwES/dVYi8doLNBdcV4cUgHcF68cLotmFx0ceN3s9NcSN6fhCV2uM/JqLQa3V52KO0dY
	 v3AqiC0aQGvG6PncQIaHw3XmnIVqfK3xq0O46v4zfDBpvHC3PwqylJo2fti7hXx2/RCeM
	 /aP8gGmI90MpnQQtcrPThGdlsxZnOJN3irgrqHHt7hO+mXVkcMp26z4XvwJREa1H2kJL+
	 HYcZDZ3zY6oL920NkgGY7kHGya2PPflPqUn4eA5XH/WOjvpgd/AVEp7uZCM6/6HbYE7LC
	 z9IPk0gL04f81CC7HdNyPWN9al4IWSiKQqMwoC8ZK8ycGv304TDX6YFtwaMCSdhEZxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F64606A33D;
	Mon, 23 Nov 2026 04:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F64606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxBbUDxgNr+B0iAA--.3846S3;
	Mon, 23 Nov 2026 12:50:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX88AxgNrIsw2AA--.43924S5;
	Mon, 23 Nov 2026 12:50:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Enable callx related testcases for LoongArch
Date: Mon, 23 Nov 2026 12:50:08 +0800
Message-ID: <20261123045008.23691-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261123045008.23691-1-yangtiezhu@loongson.cn>
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxX88AxgNrIsw2AA--.43924S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1ruw1Dtw43Wr1UArWfCrX_yoW5Gr4Upa
	ykA34FkryIkF13K3WxGFWagrZ3GF1kWrWUAF42grs8uFnrJ3yxXr4fKFZ0qFn0g3yFvrZ5
	Zw1xKas3ur48ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUVo7KUUUUU

As the LoongArch JIT supports indirect calls to subprogs, enable the
corresponding callx BPF selftests for LoongArch.

With this patch:
  $ sudo ./test_progs -t callx | tail -1
  Summary: 6/89 PASSED, 6 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c | 2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h                | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
index cc63b84e4d94..c052fa7624e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
@@ -9,7 +9,7 @@
 #include <bpf/btf.h>
 
 #if defined(__x86_64__) || defined(__aarch64__) || \
-    (defined(__riscv) && __riscv_xlen == 64)
+    (defined(__riscv) && __riscv_xlen == 64) || defined(__loongarch__)
 
 #define CALLEE_INSN	6
 #define DATA		0x1234
diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
index acd821fb568f..f89bfe3e429d 100644
--- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
+++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
@@ -4,7 +4,7 @@
 #include "callx_rodata.lskel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__) || \
-    (defined(__riscv) && __riscv_xlen == 64)
+    (defined(__riscv) && __riscv_xlen == 64) || defined(__loongarch__)
 
 static void run(int prog_fd, int expected, const char *name)
 {
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6b930cb48f8d..523e54383d7e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -306,7 +306,8 @@
 
 /* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALLX */
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) &&		\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
+     defined(__TARGET_ARCH_loongarch)) &&				\
 	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
 #define CAN_USE_CALLX
 #endif
-- 
2.42.0

