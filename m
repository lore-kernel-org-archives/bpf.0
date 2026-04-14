Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AE2253EC
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193820; cv=none; b=FvGYQKRWJPLCqJRSFit5Vb1IL/e/hN3b+VpcoRf08FNbsssvKfWJ3iJFBbzJZ/lL0ggyFPvqZx9FINBxhfYt84l+2HIIHttrX46V/+28HW7LVtf9fsHHHeJARLQQFMCxgQqIDFLqs6KIm3+k4N2y9VxseRUQDvndWFdjn6zYMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193820; c=relaxed/simple;
	bh=ZKvleww0OhB/duEYimfkfhZKwRZjTbGJoViSjCzyAQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNYzxy6+5PBdKR+1qO7bwQc0LWoVDLB48Ddef351tZCD0eCegcROqihCeZVfVThsOuSbBJOi5fv4ssS2P/HRo6U9yvJxsBikANC8HaZA3mvRFi4GzmBb/gMcIsHTk7dKB/MIy4KiZFqXrqD7wFnnEHoBvm1HX03YVHOZxFBAdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+bygFt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+bygFt"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f2385724aso2272906b3a.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193817; x=1776798617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lDAYhuHHlUJd4atGhX34b/Lb7vJAA7CkoyuE5hqgPk=;
        b=Od+bygFtrsssJEhAID62mfTD1knRBm9kGjGVvNsKUtY0S0rGn7cjifXPklxu9ACtGW
         olOMSi0rih8YDQJrqW/DeCXlQU5HK0hUBUeAwXwkBmf+nCEQ9Yw8T59vP/FpeNNucZ5L
         tWckohOufbr3fz01/km30g6qIjtf5zZtV53v2y6r1+wc/UpMFZOx2B8OF6H5cd5GtyP/
         5hIee6aXcry04sG2yE9HUIK7MKX+QwYJVG2IU3aDZKJmQeGAV76+YmX2aiaYh2tN4KCY
         oVeBAGz16LesjqGnK1AywxdsHNeKEbyDbg/ANLY/DOtInTfCyZNTRCaYPg5ZoFL+YCSY
         5QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193817; x=1776798617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lDAYhuHHlUJd4atGhX34b/Lb7vJAA7CkoyuE5hqgPk=;
        b=ja0Htt7WLRDyxHfMbK7mKqiWRtC5j8z5SFQpAttexy2zMQeNzegWZzoDn0pGnHjZHI
         scxXUQ0NiqI69LB1WET0aNwPAxW/+cTAfZFAmFdo/JGUqHTcSyzm21ZGY7qvaPbqEMbA
         b5KH3chzAST1hhpKpdkVFx+yI6PoETZAOeMTPP99Rpyw4Q0GmB7hApAY7Gh0KLOf08DR
         E7l+P3CbEx3lwWLpm4+IyNtzqFfFSOAMTw6KgMC1i+uqYahOAWgTzX2nAaZth4bcnhwG
         5NH+eDfkxsu3BOMp4m4SwXBQmbh1vS4Mx1jh4r1ooWgQ+szVhK7ctqlxM/JEzI0X5sqn
         K/2Q==
X-Gm-Message-State: AOJu0YxW3JResuukxFVmolAyx+uziq/zlNjathYwJq1d3jszxd1nnN8/
	NI2r35js4yYdsU0dJKzWmTa4HpAwXbj/kT8xbue7Qpcj3Agok2g1z4AvV+h7EA==
X-Gm-Gg: AeBDietmr8JrQ/3CBhA0MbR4gDmTnYwzRgYibYtvGzQFMTlFEs7IdGECSp47ljyr+0a
	bpkYF/MdCkBReB2g+GF88y/x9S6792aZs01O9ECwraQIjUb8AJTUThjYwi+CxB2k4kXsRPlhxLV
	gbbQURvF7yzwQnfJ397pZ/8zn6CarMnX+0hE4NwnjXiOubwek+gOd21DY9p8IokePLFrUiS3ovl
	Fma3HX1gvABxLdzjQzTleDZBZprt9r2rgu06a3Us98JrFfFPkBwpA1mnpBrwmI+gQktovtndpxd
	tAQeTrej3lvospYCh7zEoyVN6bZSl85mSIEr+yonMkhpCqG7/xSb5lANuX+HxQwS7aHVKZTDAJG
	qiPjSQtk3NjgXZBa3vTsFhO6UXyqZR4Y2oIsBJsoUqQxWwP2eD0p5607/KvO3hFfURNWGBDKE7w
	IkUKzJgOZRFakA8g==
X-Received: by 2002:a05:6a00:a21b:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-82f5051f6f7mr6107397b3a.27.1776193817192;
        Tue, 14 Apr 2026 12:10:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c311a06sm17024488b3a.10.2026.04.14.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:10:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/1] bpf: Refactor dynptr mutability tracking
Date: Tue, 14 Apr 2026 12:10:14 -0700
Message-ID: <20260414191014.1218567-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Redefine dynptr mutability and fix inconsistency in the verifier and
kfunc signatures. Dynptr mutability is at two levels. The first is
the bpf_dynptr structure and the second is the memory the dynptr points
to. The verifer currently tracks the mutability of the bpf_dynptr struct
through helper and kfunc prototypes, where "const struct bpf_dynptr *"
means the structure itself is immutable. The second level is tracked
in upper bit of bpf_dynptr->size in runtime and is not changed in this
patch.

There are two type of inconsistency in the verfier regarding the
mutability of the bpf_dynptr struct. First, there are many existing
kfuncs whose prototypes are wrong. For example, bpf_dynptr_adjust()
mutates a dynptr's start and offset but marks the argument as a const
pointer. At the same time many other kfuncs that does not mutate the
dynptr but mark themselves as mutable. Second, the verifier currently
does not honor the const qualifier in kfunc prototypes as it determines
whether tagging the arg_type with MEM_RDONLY or not based on the register
state.

Since all the verifier care is to prevent CONST_PTR_TO_DYNPTR from
being destroyed in callback and global subprogram, redefine the
mutability at the bpf_dynptr level to just bpf_dynptr_kern->data. Then,
explicitly prohibit passing CONST_PTR_TO_DYNPTR to an argument tagged
with MEM_UNINIT or OBJ_RELEASE. The mutability of a dynptr's view is not
really interesting so drop MEM_RDONLY annotation for dynptr from the
helpers and kfuncs. Plus, if the mutability of the entire bpf_dynptr
were to be done correctly, it would kill the bpf_dynptr_adjust() usage
in callback and global subporgram.

Implementation wise

- First, make sure all kfunc arg are correctly tagged: Tag the dynptr
  argument of bpf_dynptr_file_discard() with OBJ_RELEASE.
- Then, in process_dynptr_func(), make sure CONST_PTR_TO_DYNPTR cannot
  be passed to argument tagged with MEM_UNINIT or OBJ_RELEASE. For
  MEM_UNINIT, it is already checked by is_dynptr_reg_valid_uninit().
  For OBJ_RELEASE, check against OBJ_RELEASE instead of MEM_RDONLY and
  drop a now identical check in unmark_stack_slots_dynptr().
- Remove the mutual exclusive check between MEM_UNINIT and MEM_RDONLY,
  but don't add a MEM_UNINIT and OBJ_RELEASE version as it is obviously
  wrong.

Note that while this patch stops following the C semantic for the
mutability of bpf_dynptr, the prototype of kfuncs are still fixed to
maintain the correct C semantics in the implementation. Adding or
removing the const qualifier does not break backward compatibility.
In addition, fix kfuncs dropping the const qualifier when casting the
opaque bpf_dynptr to bpf_dynptr_kern.

In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
-Wuninitialized-const-pointer warning.

Signed-off-by: Amery Hung <ameryhung@gmail.com>

---
v1 -> v2
  - Fix incorrect flags masking in process_dynptr_func() (Mykyta)
  - Add const to dst when casting const bpf_dynptr to bpf_dynptr_kern
    (Mykyta)
  Link: https://lore.kernel.org/bpf/20260402065013.884228-1-ameryhung@gmail.com/
---
 fs/bpf_fs_kfuncs.c                            |  2 +-
 fs/verity/measure.c                           |  4 +-
 include/linux/bpf.h                           |  8 +--
 kernel/bpf/btf.c                              |  2 +-
 kernel/bpf/helpers.c                          | 36 +++++-----
 kernel/bpf/verifier.c                         | 70 +++++--------------
 kernel/trace/bpf_trace.c                      | 22 +++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 +--
 .../selftests/bpf/progs/dynptr_success.c      |  6 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  9 +--
 10 files changed, 65 insertions(+), 102 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index e4e51a1d0de2..9d27be058494 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -200,7 +200,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags)
 {
 
-	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	const struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
 	struct inode *inode = d_inode(dentry);
 	const void *value;
 	u32 value_len;
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 6a35623ebdf0..265fa0253e3d 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -118,9 +118,9 @@ __bpf_kfunc_start_defs();
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_p)
+__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_p)
 {
-	struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;
+	const struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;
 	const struct inode *inode = file_inode(file);
 	u32 dynptr_sz = __bpf_dynptr_size(digest_ptr);
 	struct fsverity_digest *arg;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0136a108d083..48b747b35008 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3620,8 +3620,8 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
 struct bpf_key *bpf_lookup_system_key(u64 id);
 void bpf_key_put(struct bpf_key *bkey);
-int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
-			       struct bpf_dynptr *sig_p,
+int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
+			       const struct bpf_dynptr *sig_p,
 			       struct bpf_key *trusted_keyring);
 
 #else
@@ -3639,8 +3639,8 @@ static inline void bpf_key_put(struct bpf_key *bkey)
 {
 }
 
-static inline int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
-					     struct bpf_dynptr *sig_p,
+static inline int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
+					     const struct bpf_dynptr *sig_p,
 					     struct bpf_key *trusted_keyring)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..3c2aaa3c5004 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7973,7 +7973,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
 			}
-			sub->args[i].arg_type = ARG_PTR_TO_DYNPTR | MEM_RDONLY;
+			sub->args[i].arg_type = ARG_PTR_TO_DYNPTR;
 			continue;
 		}
 		if (tags & ARG_TAG_TRUSTED) {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb95e287b0dc..35870f32e51c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1929,7 +1929,7 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
+	.arg3_type	= ARG_PTR_TO_DYNPTR,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -1986,7 +1986,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.func		= bpf_dynptr_write,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
+	.arg1_type	= ARG_PTR_TO_DYNPTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
@@ -2029,7 +2029,7 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.func		= bpf_dynptr_data,
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_DYNPTR_MEM_OR_NULL,
-	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
+	.arg1_type	= ARG_PTR_TO_DYNPTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
@@ -3057,7 +3057,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
 	return bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk);
 }
 
-__bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end)
+__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr *p, u64 start, u64 end)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	u64 size;
@@ -3078,14 +3078,14 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end
 
 __bpf_kfunc bool bpf_dynptr_is_null(const struct bpf_dynptr *p)
 {
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
 	return !ptr->data;
 }
 
 __bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
 {
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
 	if (!ptr->data)
 		return false;
@@ -3095,7 +3095,7 @@ __bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
 
 __bpf_kfunc u64 bpf_dynptr_size(const struct bpf_dynptr *p)
 {
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
 	if (!ptr->data)
 		return -EINVAL;
@@ -3107,7 +3107,7 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 				 struct bpf_dynptr *clone__uninit)
 {
 	struct bpf_dynptr_kern *clone = (struct bpf_dynptr_kern *)clone__uninit;
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
 	if (!ptr->data) {
 		bpf_dynptr_set_null(clone);
@@ -3130,11 +3130,11 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
  * Copies data from source dynptr to destination dynptr.
  * Returns 0 on success; negative error, otherwise.
  */
-__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
-				struct bpf_dynptr *src_ptr, u64 src_off, u64 size)
+__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
+				const struct bpf_dynptr *src_ptr, u64 src_off, u64 size)
 {
-	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
-	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	const struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
+	const struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
 	void *src_slice, *dst_slice;
 	char buf[256];
 	u64 off;
@@ -3185,9 +3185,9 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
  * at @offset with the constant byte @val.
  * Returns 0 on success; negative error, otherwise.
  */
-__bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u64 offset, u64 size, u8 val)
+__bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offset, u64 size, u8 val)
 {
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	u64 chunk_sz, write_off;
 	char buf[256];
 	void* slice;
@@ -4199,13 +4199,13 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
-			       struct bpf_dynptr *sig_p,
+__bpf_kfunc int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
+			       const struct bpf_dynptr *sig_p,
 			       struct bpf_key *trusted_keyring)
 {
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
-	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
-	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
+	const struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
+	const struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
 	const void *data, *sig;
 	u32 data_len, sig_len;
 	int ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e4980128151..f6a8d4fc3ed6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -717,15 +717,6 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, ref_obj_id, i;
 
-	/*
-	 * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
-	 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
-	 * is safe to do directly.
-	 */
-	if (reg->type == CONST_PTR_TO_DYNPTR) {
-		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
-		return -EFAULT;
-	}
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return spi;
@@ -7426,23 +7417,12 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
  * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
  *
- * Mutability of bpf_dynptr is at two levels, one is at the level of struct
- * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
- * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
- * mutate the view of the dynptr and also possibly destroy it. In the latter
- * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
- * memory that dynptr points to.
- *
- * The verifier will keep track both levels of mutation (bpf_dynptr's in
- * reg->type and the memory's in reg->dynptr.type), but there is no support for
- * readonly dynptr view yet, hence only the first case is tracked and checked.
- *
- * This is consistent with how C applies the const modifier to a struct object,
- * where the pointer itself inside bpf_dynptr becomes const but not what it
- * points to.
- *
- * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
- * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
+ * Mutability of bpf_dynptr is at two levels: the dynptr and the memory the
+ * dynptr points to. At the first level, the verifier will make sure a
+ * CONST_PTR_TO_DYNPTR cannot be reinitialized or destroyed. The mutability of
+ * a dynptr's view (i.e., start and offset) is not tracked as there is not such
+ * use case. The second level is tracked using the upper bit of bpf_dynptr->size
+ * and checked dynamically during runtime.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
@@ -7457,14 +7437,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		return -EINVAL;
 	}
 
-	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
-	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
-	 */
-	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
-		verifier_bug(env, "misconfigured dynptr helper type flags");
-		return -EFAULT;
-	}
-
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
 	 *		 constructing a mutable bpf_dynptr object.
 	 *
@@ -7472,13 +7444,12 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	 *		 pointing to a region of at least 16 bytes which doesn't
 	 *		 contain an existing bpf_dynptr.
 	 *
-	 *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
-	 *		 mutated or destroyed. However, the memory it points to
-	 *		 may be mutated.
+	 *  OBJ_RELEASE - Points to a initialized bpf_dynptr that will be
+	 *		  destroyed.
 	 *
-	 *  None       - Points to a initialized dynptr that can be mutated and
-	 *		 destroyed, including mutation of the memory it points
-	 *		 to.
+	 *  None       - Points to a initialized dynptr that cannot be
+	 *		 reinitialized or destroyed. However, the view of the
+	 *		 dynptr and the memory it points to may be mutated.
 	 */
 	if (arg_type & MEM_UNINIT) {
 		int i;
@@ -7497,10 +7468,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		}
 
 		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
-	} else /* MEM_RDONLY and None case from above */ {
+	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
-		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
-			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
+		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
+			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
 			return -EINVAL;
 		}
 
@@ -7511,8 +7482,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 			return -EINVAL;
 		}
 
-		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected type */
-		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
+		/* Fold modifiers (in this case, OBJ_RELEASE) when checking expected type */
+		if (!is_dynptr_type_expected(env, reg, arg_type & ~OBJ_RELEASE)) {
 			verbose(env,
 				"Expected a dynptr of type %s as arg #%d\n",
 				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno - 1);
@@ -9358,7 +9329,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
 				return -EINVAL;
 			}
-		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+		} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
 			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_DYNPTR);
 			if (ret)
 				return ret;
@@ -12265,9 +12236,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 			int clone_ref_obj_id = 0;
 
-			if (reg->type == CONST_PTR_TO_DYNPTR)
-				dynptr_arg_type |= MEM_RDONLY;
-
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
@@ -12280,7 +12248,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
-				dynptr_arg_type |= DYNPTR_TYPE_FILE;
+				dynptr_arg_type |= DYNPTR_TYPE_FILE | OBJ_RELEASE;
 				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
@@ -18735,7 +18703,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			} else if (arg->arg_type == ARG_ANYTHING) {
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
-			} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
 				/* assume unspecial LOCAL dynptr type */
 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index af7079aa0f36..e916f0ccbed9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3397,12 +3397,12 @@ typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struc
  * direct calls into all the specific callback implementations
  * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
  */
-static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u64 doff, u64 size,
+static __always_inline int __bpf_dynptr_copy_str(const struct bpf_dynptr *dptr, u64 doff, u64 size,
 						 const void *unsafe_src,
 						 copy_fn_t str_copy_fn,
 						 struct task_struct *tsk)
 {
-	struct bpf_dynptr_kern *dst;
+	const struct bpf_dynptr_kern *dst;
 	u64 chunk_sz, off;
 	void *dst_slice;
 	int cnt, err;
@@ -3438,7 +3438,7 @@ static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u64
 					     u64 size, const void *unsafe_src,
 					     copy_fn_t copy_fn, struct task_struct *tsk)
 {
-	struct bpf_dynptr_kern *dst;
+	const struct bpf_dynptr_kern *dst;
 	void *dst_slice;
 	char buf[256];
 	u64 off, chunk_sz;
@@ -3539,49 +3539,49 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
 	return bpf_send_signal_common(sig, type, task, value);
 }
 
-__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					   u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				 copy_user_data_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					     u64 size, const void *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
 				 copy_kernel_data_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_probe_read_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					       u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				     copy_user_str_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
 						 u64 size, const void *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
 				     copy_kernel_str_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_copy_from_user_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					  u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				 copy_user_data_sleepable, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_copy_from_user_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					      u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, (const void __force *)unsafe_ptr__ign,
 				     copy_user_str_sleepable, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_copy_from_user_task_dynptr(const struct bpf_dynptr *dptr, u64 off,
 					       u64 size, const void __user *unsafe_ptr__ign,
 					       struct task_struct *tsk)
 {
@@ -3589,7 +3589,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
 				 copy_user_data_sleepable, tsk);
 }
 
-__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr, u64 off,
 						   u64 size, const void __user *unsafe_ptr__ign,
 						   struct task_struct *tsk)
 {
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 7dad01439391..ae71e9b69051 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -40,7 +40,7 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u64 offset,
 extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u64 offset, void *buffer,
 				   __u64 buffer__szk) __ksym __weak;
 
-extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u64 start, __u64 end) __ksym __weak;
+extern int bpf_dynptr_adjust(struct bpf_dynptr *ptr, __u64 start, __u64 end) __ksym __weak;
 extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
 extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
 extern __u64 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
@@ -70,13 +70,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
 
 extern int bpf_get_file_xattr(struct file *file, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym;
-extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
+extern int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynptr *digest_ptr) __ksym;
 
 extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __ksym;
 extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
 extern void bpf_key_put(struct bpf_key *key) __ksym;
-extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
-				      struct bpf_dynptr *sig_ptr,
+extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_ptr,
+				      const struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 struct dentry;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0d672d93adf..e0745b6e467e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -914,7 +914,7 @@ void *user_ptr;
 char expected_str[384];
 __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
 
-typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
+typedef int (*bpf_read_dynptr_fn_t)(const struct bpf_dynptr *dptr, u64 off,
 				    u64 size, const void *unsafe_ptr);
 
 /* Returns the offset just before the end of the maximum sized xdp fragment.
@@ -1106,7 +1106,7 @@ int test_copy_from_user_str_dynptr(void *ctx)
 	return 0;
 }
 
-static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
+static int bpf_copy_data_from_user_task(const struct bpf_dynptr *dptr, u64 off,
 					u64 size, const void *unsafe_ptr)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
@@ -1114,7 +1114,7 @@ static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
 	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
 }
 
-static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u64 off,
+static int bpf_copy_data_from_user_task_str(const struct bpf_dynptr *dptr, u64 off,
 					    u64 size, const void *unsafe_ptr)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index d249113ed657..1c6cfd0888ba 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -11,12 +11,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-
-extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
-extern void bpf_key_put(struct bpf_key *key) __ksym;
-extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
-				      struct bpf_dynptr *sig_ptr,
-				      struct bpf_key *trusted_keyring) __ksym;
+#include "bpf_kfuncs.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
@@ -38,7 +33,7 @@ SEC("?lsm.s/bpf")
 __failure __msg("cannot pass in dynptr at an offset=-8")
 int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	unsigned long val;
+	unsigned long val = 0;
 
 	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
 					  (struct bpf_dynptr *)&val, NULL);
-- 
2.52.0

