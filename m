Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E621FF23;
	Thu,  4 Jun 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585706; cv=none; b=VsicbpxLhBpJBWtwqvLorEd8BM9x2i76hAxW7DmHHd++QwrJjHOVxq1t3qOjLalnMdtsKkkDSaVswVAbnt8WFMgcDhxhE32W0vRMLO/2pB4Cq4jbDbK9idD+5QmoViiwc73IFYjV31g5ZUnaGCLg8HJYQLIpjEJQhP3Ma6XcOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585706; c=relaxed/simple;
	bh=ivaft6h2vtMBBEKsH4DSfYs705jHasFPibsk8VO0NHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8/X3YxkM2tx57MZLu75wqv0frNSUEuxsQJEP1OMBarseykz6j8sk4hMzX4GzULvCWRYoUqXWVtQh2CEHZoqg950+U5s3VxpOz2c0nDzBaEYPZD8yBp4F+MRKATkgSATju1egxJq/s4NO3ojl2PhXBvRm6dCyiAqwryIFRuCb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Z1SFiqSW; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Z1SFiqSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=nb+VCPFeIBKGGScbvfbULNhXgDUoBKj5To
	aKEdEdkds=; b=Z1SFiqSWTbFNiycExFeMybe4UNVj4njQc8Sh3P+Nbt2nJdWiTA
	nhq68URHkzVbvdT6Rg1jV5Zk7ctJU6Yi33L+7amzEBBkjMiWK2SNd7r/QWpPhCxl
	SM8kSZ/HisczfWTRSEtsKaZjTwZoJMBk0OCgDmHhvEbN2XmOzaVKJv6bQ=
Received: from dumpling.. (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQDHE5HQlCFqqyQrAg--.52018S3;
	Thu, 04 Jun 2026 23:08:03 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
Date: Thu,  4 Jun 2026 23:07:54 +0800
Message-Id: <20260604150755.2487555-2-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDHE5HQlCFqqyQrAg--.52018S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDGw4rXrWfCFWUtFW7twb_yoWrXFyrpF
	s8W342yr4DJr129a12y3W2yFyUG39aqa13CFWjy34fAFn8Zw1qgFyUWrW29rySkrZ8Cw4I
	vr10qFZF93WDAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjzSoXUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQIA2ohcr8y2AADsh

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
Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..e8a8dd89af06 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4997,9 +4997,22 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -6514,7 +6527,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_flow_keys_access(env, off, size);
+		err = check_flow_keys_access(env, regno, off, size);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (type_is_sk_pointer(reg->type)) {
-- 
2.34.1

