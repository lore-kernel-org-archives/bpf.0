Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561833B97D;
	Mon, 19 Oct 2026 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376833; cv=none; b=KGpCmujopvMYBIdKlicFjp5xtIFGm1dhzdxlev3T/WZWv9Kofyovm4TfzJVNgWZ6wIZ909ffQRAZ4aFmNycnEuvsjNkx9FOpvTCR8sp4Wb5+2CeW63jlfGXEdkdAEbHj4qCMZvnnlZbkqFCDuzoTQrUdkdwP96C7zpi1h/YU5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376833; c=relaxed/simple;
	bh=5Vlx++ZrB1lA0LXFqW1xMRq3aBHMSTYKQtgFBrHEenc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsUabgS6aXJGnB5wPn2g/maQcZ6s1rbV8Fy+Vl8jqorxpwgmUnTk4VFhzqdT2eik0HhGpDWNawVICUq7LxxqcUNn5ZIQlaf11qwL89JvF2SWzG/zCr0CyOG/HRs0ygWlprn6dPp7Oo4+ymRwo3JdL7a/YdaNts4n6/S7zJk3NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxfdL7f9VqXicXAA--.1756S3;
	Mon, 19 Oct 2026 10:27:08 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs36f9VqNtstAA--.54458S2;
	Mon, 19 Oct 2026 10:27:06 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Use snake_case for subtest descriptions in jit_insns_arena.c
Date: Mon, 19 Oct 2026 10:27:05 +0800
Message-ID: <20261019022705.30670-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs36f9VqNtstAA--.54458S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry3GF1DGw4ftryrZr4kZrc_yoW8AF13pa
	y8CwnxtrWfJF13ua4kZrW2g3WruFn3GFy5Kr48Xr4fuF15JFyvgryxK3W5KwnIkrWfZrnY
	9w42yr9Fvr4UCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zyIUUUUUU==

Normalize two inline assembly test descriptions in jit_insns_arena.c
from space-separated strings to snake_case for consistency and to fix
command-line filter parsing in test_progs. Otherwise:

$ sudo ./test_progs -t jit_insns/arena access with zero offset
Usage: test_progs [OPTION...]
Try `test_progs --help' or `test_progs --usage' for more information.

$ sudo ./test_progs -t jit_insns/cast to a user address
Usage: test_progs [OPTION...]
Try `test_progs --help' or `test_progs --usage' for more information.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
Note: This issue was introduced by the recent commit 54e8bde13a3a
("selftests/bpf: Add JIT instruction tests"). Since it's only in
bpf-next and hasn't been merged into mainline yet, no need to add
Fixes tag IMO.

 tools/testing/selftests/bpf/progs/jit_insns_arena.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index b396d5aefb5a..16276ec192ac 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -34,7 +34,7 @@ struct {
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 SEC("syscall")
-__description("arena access with zero offset")
+__description("arena_access_with_zero_offset")
 __success __retval(0)
 int arena_zero_off(void *ctx)
 {
@@ -82,7 +82,7 @@ int arena_zero_off(void *ctx)
 }
 
 SEC("syscall")
-__description("cast to a user address")
+__description("cast_to_a_user_address")
 __success __retval(0)
 int cast_to_user(void *ctx)
 {
-- 
2.42.0

