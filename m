Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E618AE2;
	Mon, 22 Jun 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104225; cv=none; b=Vc9LvF6OAIg0u7bx3uCh71Gq5s6j811hq9OkNs4CKv1ZOkHl+J+cWXTDUMS04+TFjaZ7SoKzcTOZL74nFTKZzWeT+/KTIOx5SGXd/RcHr3uRvFhbiwHHDT2HsGstxRUk2U1lfxzMA+bxBDXxNoJCPQrdoglIU/eOzrBxwZ6CqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104225; c=relaxed/simple;
	bh=2MnsrNw/tOEaUXQc7FinVhtDq/QeHrcPeynq4B5vp9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLdbTn7oB/0bCbnrZUVHUg5kIcw2kAWtOQwe4r7IDBEhxCr5D1W3ycU+qVFH4Jpq802NcUYBdu2L2TzRjfMl/L5D0gRf12UsEt2Y+NLdnJ2hmQ7hrEpDlXld5sVAVuXx3kvarqHXomFkHcxKvaQAu57ruTsruXR2vZPkLaYTfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=cVMVbA3L; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="cVMVbA3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+oe2H5Yw8tGj0MNWAtTbhprqmEjDg0kV+m
	ECpTtqyi0=; b=cVMVbA3LUUMhfI9xTgp/G9qGbtlESkNDr+gnx2LwBwFkQJnajL
	C3h5HArcML9YVWwLSZK95z7DBbz3ryG0kEgdidsKQFildI1L7NMox3pWPYbE5VV3
	yfrgcTQCHdMaEfLdIJ4xtuQrP0USoYQlWtgJaGNfqW/lsjs8QN4e3UAKM=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBHWZ6GwDhqUmtwAg--.53540S3;
	Mon, 22 Jun 2026 12:56:49 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] bpf: Reject flexible-array allocation types
Date: Mon, 22 Jun 2026 04:56:36 +0000
Message-Id: <c230ebd7f2e28e0cc3820bcb2701ec517933063e.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBHWZ6GwDhqUmtwAg--.53540S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DGr1UGFWfur1fWryxAFb_yoW8KrWUpF
	48J34Yyr4kJrW7WwnxJa15CryYqw48J3y7Ga45Z340yFs3Xr1DZF4UC340vFyYkF4kG340
	qr4vvFZxGw17ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUUzV1UUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_obj_new() and bpf_percpu_obj_new() allocate the static BTF size for
the selected program-BTF type. A struct type can still end with a
zero-length flexible array, and generic BTF struct walks have special
handling that can accept accesses beyond the static struct size through
such a member.

Reject allocation kfunc types with trailing flexible arrays before marking
the return value as PTR_TO_BTF_ID | MEM_ALLOC. This keeps the
verifier-visible BTF access shape aligned with the object size allocated by
the runtime kfunc.

Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local percpu kptr")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf..c3a574cc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10955,6 +10955,30 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 	return true;
 }
 
+static bool btf_type_has_trailing_flex_array(const struct btf *btf,
+					     const struct btf_type *t)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	const struct btf_array *array;
+	u32 vlen;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	vlen = btf_type_vlen(t);
+	if (!vlen)
+		return false;
+
+	member = btf_type_member(t) + vlen - 1;
+	member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+	if (!btf_type_is_array(member_type))
+		return false;
+
+	array = btf_array(member_type);
+	return !array->nelems;
+}
+
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
@@ -12749,6 +12773,10 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct\n");
 			return -EINVAL;
 		}
+		if (btf_type_has_trailing_flex_array(ret_btf, ret_t)) {
+			verbose(env, "bpf_obj_new type must not contain a flexible array\n");
+			return -EINVAL;
+		}
 
 		if (is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
 			if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
-- 
2.34.1

