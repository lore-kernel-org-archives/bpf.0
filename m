Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8ED336EF8;
	Mon, 15 Jun 2026 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513859; cv=none; b=FBKGdWO5OmDqLV6WYJX5CHO02EdBNV9/xV//IL1wowyRnL5OiBmb7k34owW+o0T9E5ig7O+eiAAkdMbHaGOcxAP9pNMvXzPWSC1KQU4iOky0wARrKzYxqTGteCeNkmo/9DkoeUGwUQeVFXRHtbGDtGPT2qODvv6Hrl6pTYnTlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513859; c=relaxed/simple;
	bh=0ZmxJwX0TNvfZyUvqRReauaUChMUhfTmeoPCo3hDwfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBU/ermDTBe17D9euWZWBVxBvz68EGgIt4pomMXhpNBe6fhfmqAATqiWl3exH6lJOe324XP8F9423GsEzSv4bksTy0Zxvw0U2gYNV8Oi/SgniC2Gnv7V0mo/cahrCJEj2N9XupmQu0nwDYny9hz6fN2v8Yb/bVfHVwXQC5cj8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=biLB3FOJ; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="biLB3FOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=LPg1Nn6vrL88IG0ir4EweS9hqoHbdKi
	vd8bG6IaSvng=; b=biLB3FOJxAR1/zANUzRsTL9fSc1c4hcL+0aQG+npxDV3oi3
	vpMvXey/59BGPpKkX4iOKJCGyUpXqbAiJZ3fHBPV7e9wbQNwpBtPIbzW47rZj706
	Qr/sPe9hhnAahFZJ9vFHmPMUvo4gqNzIFvMF1/wbTf0syPh148JRL1NcWGD4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQA37r1vvi9qPuFwAg--.22668S3;
	Mon, 15 Jun 2026 16:57:21 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:57:17 +0800
Subject: [PATCH bpf 1/2] bpf: Preserve dynptr slice lifetime across
 rdonly_cast
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-1-2dd0a369e153@mails.tsinghua.edu.cn>
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513842; l=4776;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=0ZmxJwX0TNvfZyUvqRReauaUChMUhfTmeoPCo3hDwfg=;
 b=BhLVITKpvP6onNKe8J1gTuLDESWhMspmXjgE9Eagfa+ooHfmh8WeI56RHZFOj0oYx1mKsGYTo
 qFDHE9wP1giBLH414Z2PV26td737kkB+sh+2Gu48UJ6i/2dYfSLisfY
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQA37r1vvi9qPuFwAg--.22668S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1UCFWDCF45Jry5Zr4fZrb_yoWrKF1UpF
	4Sgr9Fqr4kAw47GFnxAan7ZF1F9r4vqa17CrySk34xtF1UXrWYvF18KryYq3sxtFyYyw4U
	tr4jvrZ8W3W7XFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUxv38DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQETA2ovr0If+gABsc

bpf_rdonly_cast() is an identity operation at runtime and is also fixed
up to a register move by the verifier. Its verifier return-state setup
must preserve lifetime metadata that belongs to the source pointer.

On this verifier model, dynptr-slice kfunc returns carry dynptr_id, while
refcounted dynptr release invalidates aliases by ref_obj_id. Attach the
ref_obj_id to bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() returns.
Propagate source id and release metadata through bpf_rdonly_cast().
For typed rdonly_cast() aliases, keep the source dynptr_id in reg id so
stack-overwrite invalidation can distinguish the originating dynptr when a
clone keeps the ref alive.

Otherwise, a cast alias can survive bpf_ringbuf_discard_dynptr() and
remain readable after the dynptr release.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Fixes: a35b9af4ec2c ("bpf: Add a kfunc for generic type cast")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 185b2aa43a420..0bc4b40e76bd0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1366,6 +1366,11 @@ struct bpf_kfunc_call_arg_meta {
 		u32 id;
 		u32 ref_obj_id;
 	} initialized_dynptr;
+	struct {
+		u32 id;
+		u32 dynptr_id;
+		u32 ref_obj_id;
+	} rdonly_cast_src;
 	struct {
 		u8 spi;
 		u8 frameno;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff9b1f68ceca4..7cdf20944f31a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -832,10 +832,16 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	dynptr_id = state->stack[spi].spilled_ptr.id;
 	/* Invalidate any slices associated with this dynptr */
 	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
-		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
-		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
+		if (base_type(dreg->type) == PTR_TO_MEM &&
+		    dreg->dynptr_id == dynptr_id) {
+			mark_reg_invalid(env, dreg);
 			continue;
-		if (dreg->dynptr_id == dynptr_id)
+		}
+
+		/* Typed bpf_rdonly_cast() aliases keep dynptr_id in reg id. */
+		if (base_type(dreg->type) == PTR_TO_BTF_ID &&
+		    (dreg->type & PTR_UNTRUSTED) &&
+		    dreg->id == dynptr_id)
 			mark_reg_invalid(env, dreg);
 	}));
 
@@ -12085,8 +12091,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i)) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast] &&
+			    i == 0 && is_spillable_regtype(reg->type)) {
+				meta->rdonly_cast_src.id = reg->id;
+				if (base_type(reg->type) == PTR_TO_MEM)
+					meta->rdonly_cast_src.dynptr_id = reg->dynptr_id;
+				meta->rdonly_cast_src.ref_obj_id = reg->ref_obj_id;
+			}
+
 			continue;
+		}
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
@@ -12935,10 +12950,17 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].btf_id = meta->arg_constant.value;
+			regs[BPF_REG_0].id = meta->rdonly_cast_src.id;
+			if (!regs[BPF_REG_0].id)
+				regs[BPF_REG_0].id = meta->rdonly_cast_src.dynptr_id;
+			regs[BPF_REG_0].ref_obj_id = meta->rdonly_cast_src.ref_obj_id;
 		} else if (btf_type_is_void(ret_t)) {
 			mark_reg_known_zero(env, regs, BPF_REG_0);
 			regs[BPF_REG_0].type = PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED;
 			regs[BPF_REG_0].mem_size = 0;
+			regs[BPF_REG_0].id = meta->rdonly_cast_src.id;
+			regs[BPF_REG_0].dynptr_id = meta->rdonly_cast_src.dynptr_id;
+			regs[BPF_REG_0].ref_obj_id = meta->rdonly_cast_src.ref_obj_id;
 		} else {
 			verbose(env,
 				"kfunc bpf_rdonly_cast type ID argument must be of a struct or void\n");
@@ -12975,11 +12997,9 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			return -EFAULT;
 		}
 		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
+		regs[BPF_REG_0].ref_obj_id = meta->initialized_dynptr.ref_obj_id;
 
-		/* we don't need to set BPF_REG_0's ref obj id
-		 * because packet slices are not refcounted (see
-		 * dynptr_type_refcounted)
-		 */
+		/* ref_obj_id is zero for non-refcounted packet slices. */
 	} else {
 		return 0;
 	}

-- 
2.34.1

