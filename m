Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809D1DE8AE;
	Sat,  6 Jun 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743065; cv=none; b=WEeRzIMho7BCc+KdS3FmeJQ4yWlP2SCSVsN+7E9oVzSk6+IM7dLB0l6nigk5Px67N7/CZ6Kf6wIB5sNlqcOnh346LTJugr1BAYojxjq5XQD7aX6BmUV1hGmrOyOzVLXVwvyW2JGaG79UwTa7oQwqn7BAPrvhfjyMy3tdu7Yvr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743065; c=relaxed/simple;
	bh=3WKnqiuCgpZ4Rp/sq+DwdP+pvJyuhG86erKPK93MD+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srVe2ztr7BWACZwxNCfhf8thoalb076B1asGFKCFLmjPdEhIz+BPjpqJpUTLPu9Z4Gq5kMLz+plRz5ZFMwONAJDkfXXSp1cKG3sPMVUKdhaMZ01sU/eZpomHTg4+zSetvJphqdSAa6MZ1FsPJnsbWf10mcz2vuHpTqiE+VYfzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=cOULiTlj; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="cOULiTlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=ce7d/WdUbTDORvcIrULpQib/hqt6wR+
	TyKyy7F4b9sg=; b=cOULiTljw5oDO1p6Ca1k5afZGDz322zuUpqu04MBLuwRNvV
	3QltvDElWSWJLSSn30ze3Xbh8Q+tBL9jUBFAWQ0/gkl9LWJSZWE9j+R39ORZDkzB
	h2iVZ7g7G6YQHGEwUFyS64sSTYi9fW0MOUaq1IrE88wXIokHcsE4br1m5aGE=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3cMB++yNqENcwAg--.58351S3;
	Sat, 06 Jun 2026 18:50:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 06 Jun 2026 18:50:37 +0800
Subject: [PATCH bpf-next v3 1/2] bpf, verifier: fold reg->var_off into
 PTR_TO_FLOW_KEYS bounds check
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-c3-01-v3-v3-1-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
In-Reply-To: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780743040; l=3996;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=3WKnqiuCgpZ4Rp/sq+DwdP+pvJyuhG86erKPK93MD+8=;
 b=BTLKFAmXh834tN0iRneiTf5uoKV7Djw0Ve0r0f/JejApD31GwHXcsV+V6qIZRn/QXhXNMXk2p
 9WjQSqmMl8vAczn99pFOQijk7H4aQaalk5sIOYgVaiG4sLmm//QUP4O
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3cMB++yNqENcwAg--.58351S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDGw4rXrWfCFWUtFW7twb_yoWrXFyxpF
	s8W342yr4DJr12ga12y3W7AFy5Gwsaqa1akFWjy34fAFn5Zwn0gFyjgrW29rySkr98Cw4I
	vr40qFZF93WDAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_Gw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1Z2-7UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgAKA2ojTRugSwADs8

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
 kernel/bpf/verifier.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935595138aa0..68ddd465584c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4728,9 +4728,21 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, struct b
 	return err;
 }
 
-static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
-				  int size)
+static int check_flow_keys_access(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg, argno_t argno,
+				  int off, int size)
 {
+	/* Only a constant offset is allowed here; fold it into off. */
+	if (!tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "%s invalid variable offset to flow keys: off=%d, var_off=%s\n",
+			reg_arg_name(env, argno), off, tn_buf);
+		return -EACCES;
+	}
+	off += reg->var_off.value;
+
 	if (size < 0 || off < 0 ||
 	    (u64)off + size > sizeof(struct bpf_flow_keys)) {
 		verbose(env, "invalid access to flow keys off=%d size=%d\n",
@@ -6239,7 +6251,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			return -EACCES;
 		}
 
-		err = check_flow_keys_access(env, off, size);
+		err = check_flow_keys_access(env, reg, argno, off, size);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (type_is_sk_pointer(reg->type)) {

-- 
2.34.1

