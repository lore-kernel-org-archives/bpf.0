Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A7392C3C;
	Sun, 16 Aug 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877822; cv=none; b=GWXPlOX5M7cxTx8M9UPFdbJjLPLANPL2V2TBkVmgIXy/0xP+km8SUrOy8kuz2iWBhlmtBDrJ9/y5U894vTbfQ6yvrzh2In0eUP0+ZHE1tlzOWZ8/psIIJvTAm/VAQ9v2eA/CEe61pcWcIHCqKZLFYvCN0av+UBlS4Sa3rBa2I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877822; c=relaxed/simple;
	bh=ahQwkTcrG4aaZYLGG9YsiqY65/vRRrXv/j1ISMGitM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hX3M+swRjATehB6Ta1gJcNuiM65czEZ0BwxbKcxcjnkN20sg/QoPaLA1ZS6W6b3/oODW78njyiDR35SK3f1frTZzAAR/suAOaCo/+mQicdA/7gD+KGVrSsGGOr35tzxZALUt9l+HziJvbOM5qedWb19QJmEAOTblwHA3svaD7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=K6Ul2Nb/; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="K6Ul2Nb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=/qTMXs+zGKOFAlHpmacnhqgiIsr0/kC
	lDL1GnzJ34ls=; b=K6Ul2Nb/O4U8CAuhZgPBDJfGgR+gQ/sgoedVWDcR/6g3e7y
	ynHUxKBsMjNtdCdXaXAocVRVGNH172IqJImvpi1RJPxeQw3MQayb7mBBp9T84Ffo
	qMJofBKYBpUyGaIYQYi5n/15xD2aTjC55W3aYshiU0AXOxdOhH9YJTwU8VIc=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQB3Gclkl4FqEsoEAg--.40530S4;
	Sun, 16 Aug 2026 18:56:45 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Sun, 16 Aug 2026 10:56:34 +0000
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover mixed arena and stack
 atomics
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
References: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
In-Reply-To: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786877805; l=1790;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=ahQwkTcrG4aaZYLGG9YsiqY65/vRRrXv/j1ISMGitM8=;
 b=O9IfrpEsdvhxGaR9DF6g5j1twV6nnzH+mSyhUUWoTA5q2ht3SbjbPMmBw37angx2n1D9kAgGN
 xYar6TlvtAWDQ2P8P2xPpkkMI01FcojnHPkDSCK058HKvMdxPH/66zF
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQB3Gclkl4FqEsoEAg--.40530S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4fZF1rZr4xXry5Jw1xGrg_yoW8Ary5pr
	ykuasxta1rXa13u3Z3GFW8WF1akrs3ZrWjyr1xJr97AF1UJFn3XrWxKF13tr13Cr4fuw4Y
	vF1jv34UWF1UA3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUza0mUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier test with one atomic RMW instruction reached through
PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
shared instruction with the existing incompatible-pointer diagnostic.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index b241bbcf54a8a..b22bab33301ab 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
 
 #endif
 
+static const struct bpf_insn addr_space_cast_insn = {
+	.code = 0xbf,
+	.dst_reg = BPF_REG_7,
+	.src_reg = BPF_REG_7,
+	.off = 1,
+	.imm = 1,
+};
+
+SEC("socket")
+__description("arena and stack atomic at the same instruction")
+__failure __msg("same insn cannot be used with different pointers")
+__arch_x86_64
+__load_if_JITed()
+__naked void mixed_arena_stack_atomic(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r6 = r10;					\
+	r6 += -8;					\
+	r9 = 0;					\
+	*(u64 *)(r6 + 0) = r9;			\
+	r7 = 8192;					\
+	.8byte %[addr_space_cast];			\
+	call %[bpf_get_prandom_u32];			\
+	if w0 != 0 goto 1f;				\
+	r8 = r6;					\
+	goto 2f;					\
+1:	r8 = r7;					\
+2:	r9 = 1;					\
+	lock *(u64 *)(r8 + 0) += r9;			\
+	r0 = 0;					\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_insn(addr_space_cast, addr_space_cast_insn),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 static __noinline
 u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
 {

-- 
2.43.0

