Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC1396B76;
	Tue,  3 Feb 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111541; cv=none; b=G0s3JiIdQSCU2/Nb7C1g1M5M4nKCL9Ia2y3NtXAdQRv9gqPYsepYBTv+y+CbbH5hXUqI8lYY28tOYQP+1CIElLdUbxQM5bxfeS7MF4+tY18cAtWodfLx3BdNOnchOQCENPigqZA5mQf/FJ3HvpU7+WwkAG/9G24k8VEFlHW/eVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111541; c=relaxed/simple;
	bh=nzWBeMZ+0In0tENYkGO/B4RWM4FRsy/QZDxOgEkWyo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwPU2Zt+IuRgf8gV/lxikyXzw5B7VxZ7YgvSy6R8lvQvfxHPpmluv7/KvzvAqp8W9YWh6rIzu9AvgLzbR3JMspA8aF1t82R8Ahuj/9295wPQcnV3mWyICZ6+R+X2R7Thnd4AWkjpz9d2h7WbR6/43e+r66xsUU4z6uyKy3I5olA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwzKaZKJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwzKaZKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45327C116D0;
	Tue,  3 Feb 2026 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111540;
	bh=nzWBeMZ+0In0tENYkGO/B4RWM4FRsy/QZDxOgEkWyo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwzKaZKJgd0Ds1Aoa7M7HD6kNbm1DtK/MCs5KHxzxSNSSXmLnDHeJrr6uFHQSaGPp
	 KH9e+3tISZOijBQ9mvZhHD6EL7irCYugoSTANI6XPlC+SAVp5PYS4k9qikUvUQdjyb
	 upwZ12EG1SFep3ImzIG15iSYZwVkHf0S9es5QZUvY2+z9YnLRiBzjJOBXw2ugBzQN5
	 tcIwJphH3d4xcL6RqH3bNGUjygghgbcXc7WQ6PiJ2SdcHQUDtDDg2/8qSOOt4H+auY
	 1DEoxMmPApVqsN5GtWdEF6KL9l2bdeGx63oE4+sgn6kWXUWRmB+PDjK6KWhOZ8uCoZ
	 YzHGHuFVyFMGQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 03/12] bpf: Add struct bpf_struct_ops_tramp_link object
Date: Tue,  3 Feb 2026 10:38:10 +0100
Message-ID: <20260203093819.2105105-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct bpf_struct_ops_tramp_link for struct_ops link, to follow
the code of all the other users of bpf_tramp_link object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  4 ++++
 kernel/bpf/bpf_struct_ops.c    | 17 +++++++++--------
 net/bpf/bpf_dummy_struct_ops.c | 14 +++++++-------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434904..512d75094be0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1878,6 +1878,10 @@ struct bpf_shim_tramp_link {
 	struct bpf_trampoline *trampoline;
 };
 
+struct bpf_struct_ops_tramp_link {
+	struct bpf_tramp_link link;
+};
+
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
 	struct bpf_trampoline *trampoline;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c43346cb3d76..ecca0a6be6af 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -585,9 +585,10 @@ static void bpf_struct_ops_link_release(struct bpf_link *link)
 
 static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
 {
-	struct bpf_tramp_link *tlink = container_of(link, struct bpf_tramp_link, link);
+	struct bpf_struct_ops_tramp_link *st_link =
+		container_of(link, struct bpf_struct_ops_tramp_link, link.link);
 
-	kfree(tlink);
+	kfree(st_link);
 }
 
 const struct bpf_link_ops bpf_struct_ops_link_lops = {
@@ -747,7 +748,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-		struct bpf_tramp_link *link;
+		struct bpf_struct_ops_tramp_link *st_link;
 		struct bpf_ksym *ksym;
 		u32 moff;
 
@@ -815,15 +816,15 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		/* Poison pointer on error instead of return for backward compatibility */
 		bpf_prog_assoc_struct_ops(prog, &st_map->map);
 
-		link = kzalloc(sizeof(*link), GFP_USER);
-		if (!link) {
+		st_link = kzalloc(sizeof(*st_link), GFP_USER);
+		if (!st_link) {
 			bpf_prog_put(prog);
 			err = -ENOMEM;
 			goto reset_unlock;
 		}
-		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
+		bpf_link_init(&st_link->link.link, BPF_LINK_TYPE_STRUCT_OPS,
 			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
-		*plink++ = &link->link;
+		*plink++ = &st_link->link.link;
 
 		ksym = kzalloc(sizeof(*ksym), GFP_USER);
 		if (!ksym) {
@@ -833,7 +834,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*pksym++ = ksym;
 
 		trampoline_start = image_off;
-		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+		err = bpf_struct_ops_prepare_trampoline(tlinks, &st_link->link,
 						&st_ops->func_models[i],
 						*(void **)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 812457819b5a..4029931a4fce 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -130,10 +130,10 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr)
 {
 	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
+	struct bpf_struct_ops_tramp_link *st_link = NULL;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
 	struct bpf_tramp_links *tlinks = NULL;
-	struct bpf_tramp_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
 	u32 image_off = 0;
@@ -164,18 +164,18 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 	}
 
-	link = kzalloc(sizeof(*link), GFP_USER);
-	if (!link) {
+	st_link = kzalloc(sizeof(*st_link), GFP_USER);
+	if (!st_link) {
 		err = -ENOMEM;
 		goto out;
 	}
 	/* prog doesn't take the ownership of the reference from caller */
 	bpf_prog_inc(prog);
-	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog,
+	bpf_link_init(&st_link->link.link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog,
 		      prog->expected_attach_type);
 
 	op_idx = prog->expected_attach_type;
-	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+	err = bpf_struct_ops_prepare_trampoline(tlinks, &st_link->link,
 						&st_ops->func_models[op_idx],
 						&dummy_ops_test_ret_function,
 						&image, &image_off,
@@ -196,8 +196,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 out:
 	kfree(args);
 	bpf_struct_ops_image_free(image);
-	if (link)
-		bpf_link_put(&link->link);
+	if (st_link)
+		bpf_link_put(&st_link->link.link);
 	kfree(tlinks);
 	return err;
 }
-- 
2.52.0

