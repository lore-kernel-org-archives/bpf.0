Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280824B95A3;
	Wed,  7 Oct 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390359; cv=none; b=UID7VjDUzK0uBXY8VLpkp9eGweHlQo3AptaNeKY+7tOI7DWyFAg56RxGrwKdnveXnpsBmkGBP+qy9GJTJRi6uYklJdRKiogmuvBiDW2/j4rgUaVE3+hBMHKlMJTMjwkFnm00U9smRmH1Iaec/E/OXQydxf52Q/dSP3ZlAj4lgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390359; c=relaxed/simple;
	bh=cQusPdDPNbDWGpHhwS0Fv27/F6VdnElJAJaeEcVyEXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBt7KM7jPaiOWci3DJqyUv/gaO9lY3a+6Sb9Tapu/9HFcQzw9/t3Rj4CQFuIuK5zZrOK4Ewxzqc8Z1Ms/sJrvMc8WaQAkh/cyYlNGCj2zcR1r6HRRjGjK7Ube2Aop2lPkFt6zBceZWIGEnJnGE0/rfw+swAF3Ma7RqKKDCh6+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZRNfDcu2; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZRNfDcu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=GYk5wt7JUL6Q53FrGIkpAy+qa3LERwj
	NY2crI+MicAE=; b=ZRNfDcu2DKzy42QY+FhAiVRm6II8Q9MzNrVLR/UVF9grMS0
	JfudatJ1Wbk0eUXbRsd8wNQhlrOC3YJiVFhSF9PuWwbxpB5ElttqR1rPCJ8Q9SYf
	9i5BKJ0WuX8fQCjfsDJHjPSf33eSgMiwPxAYOyHbC0ynJmqPRvW2Ul3trXZM=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQA3qzt6csZqskPbAA--.57300S3;
	Thu, 08 Oct 2026 00:25:33 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Wed, 07 Oct 2026 16:25:29 +0000
Subject: [PATCH bpf-next v4 1/2] bpf: Enforce trusted BTF ID argument
 provenance
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn>
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
In-Reply-To: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
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
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Brahmajit Das <listout@listout.xyz>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791390334; l=4542;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=cQusPdDPNbDWGpHhwS0Fv27/F6VdnElJAJaeEcVyEXU=;
 b=0tqs60e+kdULLAX93MtZBTKlLho5Y+oJMLJVFP5C0l2aUstzszbQil1YdCMbNMO7A5U6N8dW0
 mu/1gIVGZZvAuskgHatQBQKIkU6gJrkhx/eESXqtCJqy/CAo3+rlC1d
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQA3qzt6csZqskPbAA--.57300S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17Wr43AF18ur4fJF1xuFg_yoWruryfpF
	48G3sFvr48Jr43u397JF4xAry3Ka4Iq3y8Ca4ru34IkFn3WFy8tFyjkF1rZwn5CF95C342
	vr12vrWUXw47ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY
	02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnwZcUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is verified with
PTR_TRUSTED, but the common call-site type check accepts bare PTR_TO_BTF_ID
and MEM_RCU registers. The callee can consequently pass a pointer with
weaker provenance to a kfunc that does not accept RCU-protected pointers.

RCU protection only guarantees that the object remains allocated through a
grace period. It does not guarantee that an object's refcount is nonzero,
so an RCU-protected pointer cannot satisfy the trusted-pointer contract.
For example, an RCU-protected bpf_cpumask loaded from a map may have a
zero refcount. Passing it through __arg_trusted lets the callee pass it
to bpf_cpumask_acquire(), whose plain refcount_inc() can retain an object
that will be freed after the grace period.

Make the existing provenance check contract-driven. Mark generated BTF ID
kfunc argument types with PTR_TRUSTED, and add MEM_RCU only for KF_RCU
kfuncs. Normalize PTR_MAYBE_NULL when the argument contract permits it.
Then use the argument flags to require trusted or referenced provenance
and allow MEM_RCU only when the contract says so.

Split is_trusted_reg() so the normalized type is used for type and modifier
checks while reference lookup still uses the original register. Conversion
of scalar-struct BTF ID arguments to fixed-size memory continues to
construct a new ARG_PTR_TO_MEM type without PTR_TRUSTED.

Fixes: e2b3c4ff5d18 ("bpf: add __arg_trusted global func arg tag")
Suggested-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae2274..a0ab793f041d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5327,15 +5327,17 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
-static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+static bool is_trusted_reg_type(struct bpf_verifier_env *env,
+				const struct bpf_reg_state *reg,
+				enum bpf_reg_type type)
 {
 	/* A referenced register is always trusted. */
 	if (reg_is_referenced(env, reg))
 		return true;
 
 	/* Types listed in the reg2btf_ids are always trusted */
-	if (reg2btf_ids[base_type(reg->type)] &&
-	    !bpf_type_has_unsafe_modifiers(reg->type))
+	if (reg2btf_ids[base_type(type)] &&
+	    !bpf_type_has_unsafe_modifiers(type))
 		return true;
 
 	/* If a register is not referenced, it is trusted if it has the
@@ -5347,8 +5349,14 @@ static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_st
 	 * Eventually, we should make PTR_TRUSTED the single source of truth
 	 * for whether a register is trusted.
 	 */
-	return type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS &&
-	       !bpf_type_has_unsafe_modifiers(reg->type);
+	return type_flag(type) & BPF_REG_TRUSTED_MODIFIERS &&
+	       !bpf_type_has_unsafe_modifiers(type);
+}
+
+static bool is_trusted_reg(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg)
+{
+	return is_trusted_reg_type(env, reg, reg->type);
 }
 
 static bool is_rcu_reg(const struct bpf_reg_state *reg)
@@ -9578,6 +9586,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	{
 		const u32 *arg_btf_id = fn->arg_btf_id[arg];
 		const struct btf *arg_btf = is_kfunc(meta) ? meta->btf : btf_vmlinux;
+		enum bpf_reg_type reg_type;
 
 		if (!meta->btf) {
 			const struct bpf_reg_types *compatible;
@@ -9605,8 +9614,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			}
 		}
 
-		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
-				       bpf_type_has_unsafe_modifiers(reg->type))) {
+		reg_type = reg->type & ~(arg_type & PTR_MAYBE_NULL);
+		if ((arg_type & PTR_TRUSTED) &&
+		    (!is_trusted_reg_type(env, reg, reg_type) ||
+		     bpf_type_has_unsafe_modifiers(reg_type))) {
 			if (!(arg_type & MEM_RCU)) {
 				const char *actual_type, *arg_name, *expected_type;
 
@@ -13671,6 +13682,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		else
 			proto->arg_btf_id[arg] = ref_id_ptr;
 
+		arg_type |= PTR_TRUSTED;
+
 		/*
 		 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
 		 * otherwise demand a referenced or trusted one. Other argument kinds

-- 
2.43.0

