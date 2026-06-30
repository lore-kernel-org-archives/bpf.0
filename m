Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC72D73B9;
	Tue, 30 Jun 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808932; cv=none; b=N388d2khZUOEGElJ+lxfJiq/wLRq4DkrYjcZzazeHUjzZv4EF2GWdi6FWz0iz0/CCsSZXUzjSVmIfgdzU+XTyEoVHwNDRpWdVKuXUTD5xFsfmWNVZhHqPnUH8gL/zgHa423LqCKbL/x5gYeJZzUZcEcfxFJDgJGm1jdC44oBpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808932; c=relaxed/simple;
	bh=3Y8RkmzV/fPQxy7RxK5PrhfNbXfZfo47f9ed120lvm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoEScG4n/kcVQAjD3kvjOoffPq+Mzi4K7icDBuJ2eDbPIi0J5eXTvhSexTl8Uv8woNszvM50KZbfzng4gF5BO1mdXxk7rKxyUjT3hfrHfxAE1nPFBk0+A1+KtMolieGi8SZivCucI68/7PIZOeryaPqYYXYvLsIDkM2JN6HgnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kq24Gjgm; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kq24Gjgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=SN3p6icHQEtn64EpvVFBmuWe3vVei45Gf/
	Fy58CGV1Q=; b=kq24GjgmHWQYbwYvuWpwbzPYAcz8fViq4Cd6PvdfkS7uTLqMNe
	yFRusRS/nEMGHJGloT2DCwSEg4WZC/0NKjFvK76CjcgZD4aBuxIEd4N8+3sGgwhf
	uiLe7xitni8lFEnCXlWHzbsaKMVd0hHIYGOAWG7Z1KDAWL2CZ93wk+JG4=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQCnbKE5gUNqiZafAg--.37989S3;
	Tue, 30 Jun 2026 16:41:53 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Reject MEM_ALLOC BTF accesses past object bounds
Date: Tue, 30 Jun 2026 08:41:26 +0000
Message-Id: <4b8c8a81102ba4b595011434c881194f264ddc59.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQCnbKE5gUNqiZafAg--.37989S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUCw47ury5AFy8Kry8Xwb_yoW7Zw1xpF
	48Gwn7ArWkAr47uwnrGa15urW3ta18Za1UCr98G34rtF42qr1qqF1DKryxZ343Kr4DKw13
	Xr1qqrZ8u3W8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUUCJmDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

BTF struct walks relax the struct-size check for accesses through a
trailing flexible array. That is valid for ordinary BTF type walking, but
PTR_TO_BTF_ID | MEM_ALLOC values point to objects allocated with the static
BTF type size.

When walking a MEM_ALLOC object, reject the access before applying the
flexible-array relaxation if the access range extends past the struct size.
Apply the same policy to struct ID matching so kfunc and kptr type checks
do not walk past the allocated object bounds either.

Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local percpu kptr")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/btf.c      | 17 +++++++++++------
 kernel/bpf/verifier.c | 11 +++++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528..314d606dc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3146,7 +3146,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id,
-			  bool strict);
+			  bool strict, bool walk_flex_arrays);
 
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64572f85e..dff5c0d91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7108,7 +7108,7 @@ enum bpf_struct_walk_result {
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, int off, int size,
 			   u32 *next_btf_id, enum bpf_type_flag *flag,
-			   const char **field_name)
+			   const char **field_name, bool walk_flex_arrays)
 {
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
@@ -7135,11 +7135,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		*flag |= PTR_UNTRUSTED;
 
 	if (off + size > t->size) {
+		struct btf_array *array_elem;
+
+		if (!walk_flex_arrays)
+			goto error;
+
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
 		 */
-		struct btf_array *array_elem;
-
 		if (vlen == 0)
 			goto error;
 
@@ -7404,7 +7407,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(btf, id);
 	do {
-		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name);
+		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
+				      field_name, !type_is_alloc(reg->type));
 
 		switch (err) {
 		case WALK_PTR:
@@ -7463,7 +7467,7 @@ bool btf_types_are_same(const struct btf *btf1, u32 id1,
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id,
-			  bool strict)
+			  bool strict, bool walk_flex_arrays)
 {
 	const struct btf_type *type;
 	enum bpf_type_flag flag = 0;
@@ -7482,7 +7486,8 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	type = btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL);
+	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL,
+			      walk_flex_arrays);
 	if (err != WALK_STRUCT)
 		return false;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271..4d3bb7156 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4379,7 +4379,8 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 */
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->var_off.value,
 				  kptr_field->kptr.btf, kptr_field->kptr.btf_id,
-				  kptr_field->type != BPF_KPTR_UNREF))
+				  kptr_field->type != BPF_KPTR_UNREF,
+				  !type_is_alloc(reg->type)))
 		goto bad_type;
 	return 0;
 bad_type:
@@ -7970,7 +7971,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 
 			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
 						  reg->var_off.value, btf_vmlinux, *arg_btf_id,
-						  strict_type_match)) {
+						  strict_type_match, !type_is_alloc(reg->type))) {
 				verbose(env, "%s is of type %s but %s is expected\n",
 					reg_arg_name(env, argno),
 					btf_type_name(reg->btf, reg->btf_id),
@@ -11429,7 +11430,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
 	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->var_off.value,
-					   meta->btf, ref_id, strict_type_match);
+					   meta->btf, ref_id, strict_type_match,
+					   !type_is_alloc(reg->type));
 	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
 	 * actually use it -- it must cast to the underlying type. So we allow
 	 * caller to pass in the underlying type.
@@ -11876,7 +11878,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 	et = btf_type_by_id(field->graph_root.btf, field->graph_root.value_btf_id);
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->graph_root.btf,
-				  field->graph_root.value_btf_id, true)) {
+				  field->graph_root.value_btf_id, true,
+				  !type_is_alloc(reg->type))) {
 		verbose(env, "operation on %s expects arg#1 %s at offset=%d "
 			"in struct %s, but arg is at offset=%d in struct %s\n",
 			btf_field_type_name(head_field_type),
-- 
2.34.1

