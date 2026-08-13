Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FF416852;
	Thu, 13 Aug 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622794; cv=none; b=LyX14F4X7dy8O+3IUx9FMQzuVo99aOUOHI2amX1CDs9PcFosIij8Tg9BiKYkQF5zBih0bpDAmaJwtyoyGURpwuGnMzi/ODiN2BcNBvYgbqr+EQPXPY2hpUpqvNCFIhz+gbn2cku0kbqlGlhnLv8oFXM61llhd/EuAY8T7D6mAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622794; c=relaxed/simple;
	bh=olDO4MoiCEtiR0uFNeRK/O6KsrYTRFrgyDMjbSvo1T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngSs6EHB9SVD6ouEPbO6kblX912urZyx0uxox0zB1jKpL+Vl7Wj4W2hy8MR8VM9iErvMrTbE/jkFuLh/E3Eje9FGAoduTx0iUVR0FsRj47jpV61SVB6AFPwo3A71+zsdBTZ1rWcruaTvYj3O9tXoFl468Fa+/p/fSlQhYPHfzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Y75g8JKR; arc=none smtp.client-ip=101.6.4.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Y75g8JKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=zMY4svxhvDYYbHsdLL+c3C46FNIu/6K
	FTsVb2L65vKQ=; b=Y75g8JKRtHZKRgRcolU/q43eapRXnYCxf6omdhDE2FzvXIl
	kKH/zw5XcG1qNAeKGAqOB6H7stVPZDOdl9T8JahyrmywVgFiYNjrxX94Bw/cGLXa
	RyjIozn3Sr8iORl3HAkw+0KV7r4gb4GnlkN8Vn6WZpZztvQ6xUwJTCuMzIWk=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXlLYLsn1qPyv_AA--.41218S4;
	Thu, 13 Aug 2026 20:01:23 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Thu, 13 Aug 2026 12:01:04 +0000
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover mixed arena and
 map-value atomics
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-bpf-next-038-mixed-atomic-v1-v1-2-e79aadb46a8a@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
In-Reply-To: <20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622482; l=2205;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=olDO4MoiCEtiR0uFNeRK/O6KsrYTRFrgyDMjbSvo1T4=;
 b=uA1Vvj/z8/7Z6pEkYOaav/8dUVzhuujMR9NEXVNUHoysYGgrMR6kauzIK/vZeTvchFatpHOWF
 euQUkxljW84C0irqrb61Sl1cnaF9KHJ19FeWxcYe+67RDQoO6q3LU9N
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQCXlLYLsn1qPyv_AA--.41218S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fZF1rZr4xXry5Jw1xGrg_yoW8uFyfpr
	97CasxJFWrXF1Uu3s3Jay8uFyakrs2vryUAw48J34xZF1UJr97XFs7KFy3Jr13Cr1fuw4F
	kF1Iva4UWw4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG_M-UUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier test with one atomic RMW instruction reached through
PTR_TO_ARENA and PTR_TO_MAP_VALUE paths. The verifier must reject the
shared instruction with the existing incompatible-pointer diagnostic.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index b241bbcf54a8a..2e43da188194b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -25,6 +25,15 @@ struct {
 	__ulong(map_extra, ARENA_VM_START); /* start of mmap() region */
 } arena SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} atomic_map SEC(".maps");
+
+static __u64 arena_atomic_target SEC(".addr_space.1");
+
 SEC("socket")
 __success __retval(0)
 int basic_alloc1_nosleep(void *ctx)
@@ -637,6 +646,41 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
 
 #endif
 
+SEC("socket")
+__description("arena and map value atomic at the same instruction")
+__failure __msg("same insn cannot be used with different pointers")
+__arch_x86_64
+__load_if_JITed()
+__naked void mixed_arena_map_value_atomic(void)
+{
+	asm volatile ("					\
+	r1 = 0;					\
+	*(u32 *)(r10 - 4) = r1;			\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[atomic_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 1f;				\
+	r6 = r0;					\
+	r7 = %[arena_atomic_target] ll;			\
+	.byte 0xbf; .byte 0x77; .short 1; .long 1;	\
+	call %[bpf_get_prandom_u32];			\
+	if w0 != 0 goto 2f;				\
+	r8 = r6;					\
+	goto 3f;					\
+2:	r8 = r7;					\
+3:	r9 = 1;					\
+	lock *(u64 *)(r8 + 0) += r9;			\
+1:	r0 = 0;					\
+	exit;						\
+"	:
+	: __imm_addr(atomic_map),
+	  __imm_addr(arena_atomic_target),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 static __noinline
 u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
 {

-- 
2.43.0

