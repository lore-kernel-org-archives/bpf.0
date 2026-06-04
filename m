Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEDD2D594F;
	Thu,  4 Jun 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596473; cv=none; b=r2r3UWIzXp2mUth7ktrTvQ+nJAHk85WY/Z6zDvSuAqtrYfE2Flb1vYE8YpM0oUOkMJHet5j0kKWeRlJloQ/os3rxQytKdSzxG/W3BAA70EJ3nXyX81t8/ccHE17CP/lxt+uMgn9pD1xCHIuI1v7wbXdknyAJp8urkX74B5VTj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596473; c=relaxed/simple;
	bh=OolDQtW8XBvTilYxMNitovCOns4lLBmZWJmCu3GZFNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVrfnDLncklXk8ZVefSzQzJa2V/vDAdB7f7EpdYUTnikylf9PsrOxobzLwQvbdp7ZtcuCJ7R48VJYPvVBp5unI0BQTeV0fg+S3lkfOBI6ofqYooSvOIabWeXYOjN6USJ+W1q/qgEI0L0v5RQ/u736hNCiLeAym2fhHSB+fWXu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=GTk4A60o; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="GTk4A60o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=WEyguf1hqzT9o6cdEFuM08vc/KzbaM4KyV
	LtG6few6M=; b=GTk4A60o49grWfRGtLRPy9iFAOXGjozjcdXF8jEqt3PLD0ySkH
	QaUATwQCo0j86+5QlY76faF7W0QWSTvkLMcXaISEGSKU6rsWBZHWR+8NsmtiVYd5
	iYRWZSO00M+Oi7qSV1j+/yJhxsPplY7KHcK04myPtzvFW7grhb37tjwPo=
Received: from dumpling.. (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQDHn5fnviFqazoNAg--.16320S3;
	Fri, 05 Jun 2026 02:07:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
Date: Fri,  5 Jun 2026 02:07:29 +0800
Message-Id: <20260604180730.2518088-2-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDHn5fnviFqazoNAg--.16320S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDGw4rXrWfCFWUtFW7twb_yoWrXFyrpF
	s8W342yr4DJr17Wa12y3ZFyFy5Gwsaqa1akFWjy34fAFn8uw1qgFyUWrW29rySkrZ8Cw4I
	vr40qFZF93WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY
	02Avz4vE14v_XwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUcksgUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYIA2ohcr+KuAAAs4

Constant pointer arithmetic on a PTR_TO_FLOW_KEYS register lands the
constant in reg->var_off (e.g. flow_keys(imm=4096)), but the
PTR_TO_FLOW_KEYS path in check_mem_access() passes only insn->off to
check_flow_keys_access() and never folds reg->var_off.value.  The
verifier therefore accepts an access that, at runtime, dereferences past
struct bpf_flow_keys -- a verifier/runtime divergence that yields an
out-of-bounds read and write of kernel stack memory.

Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
pointers") removed the generic "off += reg->off" that check_mem_access()
applied before the per-type dispatch and replaced it with per-path
folding of reg->var_off.value (for example the ctx path now folds the
register offset via check_ctx_access()).  The PTR_TO_FLOW_KEYS path was
not given the equivalent fold, so a constant offset that used to be
folded and rejected is now silently accepted:

  before 022ac0750883: the offset stays in reg->off and is folded
    generically, so the access is checked with off=4096 and rejected.
  after  022ac0750883: the offset lands in reg->var_off, the flow_keys
    path checks off=0 and accepts; at runtime the access dereferences
    base + 0x1000.

For a BPF_PROG_TYPE_FLOW_DISSECTOR program the following is accepted:

  r2 = *(u64 *)(r1 + 144)   ; R2=flow_keys (PTR_TO_FLOW_KEYS)
  r2 += 0x1000              ; R2=flow_keys(imm=4096), accepted
  r0 = *(u64 *)(r2 + 0)     ; accepted, var_off.value=0x1000 ignored

while the equivalent insn->off form

  r0 = *(u64 *)(r2 + 0x1000)

has the same effective offset but is correctly rejected with
"invalid access to flow keys off=4096 size=8", which isolates the defect
to the missing var_off fold.  Once attached as a flow dissector, the
accepted program reads kernel stack past struct bpf_flow_keys (a
kernel-stack / KASLR information leak) and can likewise write past it,
corrupting kernel memory.

Fix it by folding reg->var_off.value into the offset before the bounds
check and rejecting non-constant offsets, mirroring the other pointer
types (e.g. check_ctx_access()).

No released kernel is affected; the regression is confined to the 7.1
development cycle (reproduced on v7.1-rc1..rc5), and v7.0.x rejects the
program above.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..c04941636ef4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4728,9 +4728,22 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, struct b
 	return err;
 }
 
-static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
-				  int size)
+static int check_flow_keys_access(struct bpf_verifier_env *env, u32 regno,
+				  int off, int size)
 {
+	struct bpf_reg_state *reg = reg_state(env, regno);
+
+	/* Only a constant offset is allowed here; fold it into off. */
+	if (!tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "R%d invalid variable offset to flow keys: off=%d, var_off=%s\n",
+			regno, off, tn_buf);
+		return -EACCES;
+	}
+	off += reg->var_off.value;
+
 	if (size < 0 || off < 0 ||
 	    (u64)off + size > sizeof(struct bpf_flow_keys)) {
 		verbose(env, "invalid access to flow keys off=%d size=%d\n",
@@ -6239,7 +6252,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			return -EACCES;
 		}
 
-		err = check_flow_keys_access(env, off, size);
+		err = check_flow_keys_access(env, regno, off, size);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (type_is_sk_pointer(reg->type)) {
-- 
2.34.1

