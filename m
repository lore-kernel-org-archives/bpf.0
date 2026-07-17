Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6B3EBF19;
	Fri, 17 Jul 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282798; cv=none; b=RNRIhWLirvOOrwzz3TJF1mdz9TAVkX8RGNEVr7tf86zI1HflVvAdkA1stM+u/35bOxmpgxrT9bM8qBAx/aYGsjgUMLLvySEnGbejuFYo0bajukMSCb5CVpBjk6MEJlQFASXOvO0tXlb2lwIqTApjTReMxlxb0ZRbQ1Z4zocKLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282798; c=relaxed/simple;
	bh=cEUglNTU42hYq85eqcknhLHrufR9jtVIORvDZmHuG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ilt/tOatSiQ/g+lacfxPodhNfTTq8COQ98L+q5nHYQg71k9ffdude9klayCblWZwGogtw+cp8ELFVZfpaV0Kjxernfnh6jWrUnd+EUh30qhAap+Ezwo22VGjaRkN5BFsWolsvJQL97fg2zmEALklQuQZagGe5adTaBsj5vLs6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=hq4XE0QB; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="hq4XE0QB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bp8Gc4LkX5+LNoXfj0iJ9sg+oAKDRVxcEM
	KUbjXxp5Y=; b=hq4XE0QBZTAaD4X/W2B4HAwhO+U5WhK9V8xA9QKg/uYgrBoihj
	C8RlWaY8rgDOOgLDVRLPfQmFZjAFkv3v/W+9JMUhjgrOoB8eYl6efFidB9U7osII
	wiZJXJ70nfTc8QO5zAsZbBVZVyRl93q4ds4+LOh6mVJ9j9ZglPvPFGF8Q=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDXpRR7_llqNYAPAA--.22378S4;
	Fri, 17 Jul 2026 18:06:14 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover helper reads of invalid spill siblings
Date: Fri, 17 Jul 2026 10:05:45 +0000
Message-Id: <4cacb17794793237658cf039d7df5e14f2aab335.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDXpRR7_llqNYAPAA--.22378S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17ZF43ur4Uur15WrWUtwb_yoW8uF1xp3
	4kW3W3W34rWr1I93W3CFW8JFWrCr4kZry5XFn3Kw1kurW0qr12qr4Ika17Aw1Y93W5XrWF
	va4aqFW7Ca1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8twCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUPl1PUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier_spill_fill case that passes an untouched byte next to a
one-byte scalar spill to bpf_map_update_elem(). The full-capability load
retains the existing uninitialized-stack behavior, while the CAP_BPF-only
load must reject the STACK_INVALID helper read.

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 8b166c42c4e0e..2e62a7ddcbce2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -11,6 +11,13 @@ struct {
 	__uint(max_entries, 4096);
 } map_ringbuf SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u8);
+} map_partial_spill SEC(".maps");
+
 SEC("socket")
 __description("check valid spill/fill")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
@@ -1307,6 +1314,33 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("helper read must reject an invalid sibling of a narrow spill")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv __msg_unpriv("invalid read from stack R3 off -7+0 size 1")
+__naked void helper_read_invalid_partial_spill_sibling(void)
+{
+	asm volatile ("					\
+	r5 = 1;						\
+	*(u8 *)(r10 - 8) = r5;				\
+	r2 = 0;						\
+	*(u32 *)(r10 - 16) = r2;			\
+	r1 = %[map_partial_spill] ll;			\
+	r2 = r10;					\
+	r2 += -16;					\
+	r3 = r10;					\
+	r3 += -7;					\
+	r4 = 0;						\
+	call %[bpf_map_update_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_update_elem),
+	  __imm_addr(map_partial_spill)
+	: __clobber_all);
+}
+
 /*
  * stacksafe(): check if 32-bit scalar spill in old state is considered
  * equivalent to STACK_MISC in cur state.
-- 
2.34.1

