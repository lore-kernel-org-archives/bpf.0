Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93403955E4;
	Mon, 19 Oct 2026 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382472; cv=none; b=rbpioHazSTAq9lOibg6216ihc0ap7XWXOBxNFwIMmKOjPgJ2X+8isfcyEhveMuaIpCZbh18NtRxebKyqIGlUOC5d7GRVpfab+AQ+6mGsRUIDezME2l4KGlV1mFKVIbjWZgvxqn5hY1rLkw6aKjasmFX55QzRsMvAaQc8fvUi59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382472; c=relaxed/simple;
	bh=hML0u60eL3ia2fxzAGEOE6MtfiYK0ZmVCWLTbbvcHG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI7eyl9wyLjI9BbKiNmWbqHjvWi6Xs81oZIiIvzu7d0xwBnGbmsukAoBgh6gucEK7Zsn2gmzZsgP5VsulppaV0zWRgt5cn51VWiO9zzAbF+wq1Vhhj8d0xu7OtQ5Y/vQKFMJ2grE3n+BeGgsp6EA/poU90NLIHibIRZ2empectg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9MEltVqqCsXAA--.1944S3;
	Mon, 19 Oct 2026 12:01:08 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs8DltVqbeEtAA--.30517S2;
	Mon, 19 Oct 2026 12:01:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Use snake_case for subtest descriptions in jit_insns_arena.c
Date: Mon, 19 Oct 2026 12:01:06 +0800
Message-ID: <20261019040106.27309-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs8DltVqbeEtAA--.30517S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW3ZryUWw4UWFW7WFy5ZFc_yoW8CF4kpa
	ykWw13trWrAF1a934kZF47W3WruFn3JFnxWr48Xw4fAF15JF1qgrWxKF15t3ZFkrWfZwnY
	9w4Iyr9rWF4UCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnUUUUUUUU=

Normalize two inline assembly test descriptions in jit_insns_arena.c
from space-separated strings to snake_case.

It is done for consistency with other neighboring subtests registered
in test_jit_insns() (such as alu_imm, alu_reg, etc.). This also makes
it convenient to execute these subtests directly from the command line
without being forced to use shell quoting.

Otherwise, unquoted shell word-splitting causes test_progs to reject
the extra arguments before the filter code runs:

$ sudo ./test_progs -t jit_insns/arena access with zero offset
Usage: test_progs [OPTION...]
Try `test_progs --help' or `test_progs --usage' for more information.

$ sudo ./test_progs -t jit_insns/cast to a user address
Usage: test_progs [OPTION...]
Try `test_progs --help' or `test_progs --usage' for more information.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v2: update the commit message to make it accurate.

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

