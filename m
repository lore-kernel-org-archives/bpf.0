Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4947F3DC;
	Mon, 19 Oct 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398612; cv=none; b=ODizG4ZkjsjqbN7c7JcVaLzVS/hbF+gqEEngg+Y8ZmUgr5C41GUlRNiAVVXKfFJnt9uoY4O34gjEe311uxrhjpqLMkp/9O5InaNRt5lnhwaJW9OophGIOAqAmILvoCfd3GxvX4r5RGp74i+O5zR6QkkVrWN02szSGxWJwafgcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398612; c=relaxed/simple;
	bh=aOzna2tKsxYTR2RxunC5kBmzZ1wRrGC3l57QIAzemNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pl7GVDsH+FHLoHEGIiask6y23gYrKlWjDryWuO4JByBeMo3jAOAimXcGHmGFn9cn5hXvCdaLGxX1usIgsLRJHJILOxgLmgaEi8pKauJrk1jF3UhuDvkaACF6piYYpdmgxsrIyGnxsQV6LLTtLDn3NQvJV2dYPBF6ZfcvZVgoZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxC9IP1dVqWToXAA--.2050S3;
	Mon, 19 Oct 2026 16:30:07 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs0O1dVqy_ItAA--.54644S2;
	Mon, 19 Oct 2026 16:30:06 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Drop subtest descriptions in jit_insns_arena.c
Date: Mon, 19 Oct 2026 16:30:05 +0800
Message-ID: <20261019083005.12236-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs0O1dVqy_ItAA--.54644S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4UuFy8CFWUuryrKry5KFX_yoW8Zw1xpF
	Z7Ww18trWfX3WSvw48Zr1kG3WruFs5GFn8Gw4rXr4rurs8Jrn8XryxKFsIkF90kFW2v3WY
	kF12yrZFqF17ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOuc_UUUUU=

Drop the redundant __description macros from arena_zero_off and
cast_to_user inside jit_insns_arena.c.

This allows the test_loader framework to automatically fallback
to the snake_case C function names rather than the description
string for test display.

Before:

  $ sudo ./test_progs -t jit_insns/arena_zero_off | tail -3
  #191/1   jit_insns/arena access with zero offset:FAIL
  #191     jit_insns:FAIL
  Summary: 1/0 PASSED, 0 SKIPPED, 1/1 FAILED

  $ sudo ./test_progs -t jit_insns/cast_to_user
  #191/2   jit_insns/cast to a user address:OK
  #191     jit_insns:OK
  #192     jit_insns_blinded:OK
  Summary: 2/1 PASSED, 0 SKIPPED, 0/0 FAILED

After:

  $ sudo ./test_progs -t jit_insns/arena_zero_off | tail -3
  #191/1   jit_insns/arena_zero_off:FAIL
  #191     jit_insns:FAIL
  Summary: 1/0 PASSED, 0 SKIPPED, 1/1 FAILED

  $ sudo ./test_progs -t jit_insns/cast_to_user
  #191/2   jit_insns/cast_to_user:OK
  #191     jit_insns:OK
  #192     jit_insns_blinded:OK
  Summary: 2/1 PASSED, 0 SKIPPED, 0/0 FAILED

The main goal is that if a test fails, developers can immediately
recognize the exact, actionable test name from the standard output
and rerun it without any confusion.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/jit_insns_arena.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index b396d5aefb5a..95736eae2a58 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -34,7 +34,6 @@ struct {
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 SEC("syscall")
-__description("arena access with zero offset")
 __success __retval(0)
 int arena_zero_off(void *ctx)
 {
@@ -82,7 +81,6 @@ int arena_zero_off(void *ctx)
 }
 
 SEC("syscall")
-__description("cast to a user address")
 __success __retval(0)
 int cast_to_user(void *ctx)
 {
-- 
2.42.0

