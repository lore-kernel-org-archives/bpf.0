Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F11ACEDE
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838906; cv=none; b=X1iAHBXzxC6GeiZVBnyxs1YdORC7NPEzTNEt+CSz982cys1ejBAS9pHBrnA4jZEs1RiwyO8jnexFm9Wb5Ucikh7Xdc0cy7Yav4gxTZ6YqZF5Eq4WVMF78OBFruUPdVhy1YUO4ckQqnbgxYLZeEdL4pE54KG7e9ApE+toBgix7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838906; c=relaxed/simple;
	bh=xrdzMaMX12T/DWE/5RLs4IQTmkrgtSmy+knGebiriVQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j1/0nhNh/XwYOIfitK5vrFigLKvqGm9LII50Tt6OE870oXfXq9QzrAdCb5fhTmJwzWMUdZo++L8Mfr1kB3lDy6khR1AXX+a9CJ3wgytPjsgZh9tKTAoU0QF62jFP01zzrPiGPPRZl7BQqOuWvLdMV8JNQsM2CdYfhX0/gBjFKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rf0+bUNu; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rf0+bUNu"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6729caff479so3358183a12.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777838903; x=1778443703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgU6xWhnpJGwOPfx6OHGVpHA4tSvcnkLG8nnOc5TcgA=;
        b=rf0+bUNuvDDph1Jp3CQRoEQ5c3jaNs/Arf5Qz3gtRQidP/Zu07SYlkV8VjxkInnph6
         au02Wu/MJNOzmI2B16+PIDUiiKlE3sZUtqa0dA3vokDe1Y8sKaKRysnOQl+SNTvKvifa
         q+MQJtxxVlBl4ASwThrlMISWx5gIGTrbQAOYDdg+PIsa2sbGTyJ+Vl8W7lVYl8uIaEdP
         tcUbCySkr7ca1ZFcJiW/uygBWD9froZ8r/EzsN9pjpIL0Y++u2PPTsF1sOY+BLXsl0vR
         olYalM322IsgQ8xrzOqH5e2b/Bz93kc4zZmkZKxQlav3xpLwYvq8gwBPKbV/pemJ+IwU
         NsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838903; x=1778443703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgU6xWhnpJGwOPfx6OHGVpHA4tSvcnkLG8nnOc5TcgA=;
        b=mB1KusBlbsp2GxYB2RK2OzuQNpfrFSTRah5axI2gwDmvlVj2IMjqk1/qn8B76S0o7D
         LTd7YoXdRO9I7VFfh2QcNvGrYQc9liNVyAlBMCTpcxymTSX5OYlX+ZU5FHGHYYI61hUE
         6djIu6p2KhkTE5ijlecJrHSTn8jAc0gOm/PN27Nddj4c8TcklObWRgoPGlaxgkT8/Rtu
         R0sghAz6ijxTmfZmuWz2QsbCJ0M5Ia60ScJ8yLW42oEHHvCcqwAkv+vflvv0qh/FDwiC
         yOuw+ZFct1dUL8wBCveXNMg8bko3KdO4LPkNiIQmlNFaKqdfmgCrslUrJACieAdt04gd
         xNEA==
X-Gm-Message-State: AOJu0Yy0J/vZhbixIJ4SxayNQ2cRZfpYP3rn/+6wYMsEWyDIwNPqNcw7
	ECZm/SqMzZLJuWQYQLaNJ4NDPwX6gJWM17wY63V0cz4hiFrOsTXDoCMKpfZlnwctKll/KASH97I
	VLQCuTtVydI7qHT5tTijrv3TCQxztD9CPePAF0bgnYFn6ABqfOVlqnLigmdQhbblgKZytcjyVzd
	6lFi5Yo/VPXM2qhRJSLXtQeUNIz2eC3O5UeT7ixDK4+lXyB8GDMx8qfd8uGwIQyOgUCtapPQ==
X-Received: from eddz17.prod.google.com ([2002:a05:6402:2751:b0:672:29ae:9a33])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4282:b0:66b:f0b3:42a7 with SMTP id 4fb4d7f45d1cf-67c1abb49d1mr2660736a12.24.1777838903309;
 Sun, 03 May 2026 13:08:23 -0700 (PDT)
Date: Sun,  3 May 2026 20:08:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503200819.1530328-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next 1/2] bpf: enforce VFS constraints for xattr related
 BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Enforce VFS constraints and semantics regarding name and value lengths
within the xattr related BPF kfuncs. Specifically, reject names that
are empty or longer than XATTR_NAME_MAX, and values larger than
XATTR_SIZE_MAX. Also validate the supplied flags to ensure that only
XATTR_CREATE and XATTR_REPLACE can be used alongside the default flag
value 0.

Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Closes: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/bpf_fs_kfuncs.c | 80 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9d27be058494..a48cf35dedd2 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,21 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+static int bpf_xattr_validate_name(const char *name)
+{
+	u32 name_len;
+
+	/*
+	 * Impose the same restrictions on the supplied name as done so within
+	 * the VFS by helpers like import_xattr_name().
+	 */
+	name_len = strlen(name);
+	if (!name_len || name_len > XATTR_NAME_MAX)
+		return -ERANGE;
+
+	return 0;
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -117,10 +132,10 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *dentry* and store the output in *value_p*.
  *
- * For security reasons, only *name__str* with prefixes "user." or
- * "security.bpf." are allowed.
+ * For security reasons, only *name__str* values prefixed with "user." or
+ * "security.bpf." are permitted.
  *
  * Return: length of the xattr value on success, a negative value on error.
  */
@@ -133,6 +148,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	void *value;
 	int ret;
 
+	ret = bpf_xattr_validate_name(name__str);
+	if (ret)
+		return ret;
+
 	value_len = __bpf_dynptr_size(value_ptr);
 	value = __bpf_dynptr_data_rw(value_ptr, value_len);
 	if (!value)
@@ -150,10 +169,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *file* and store the output in *value_p*.
  *
- * For security reasons, only *name__str* with prefixes "user." or
- * "security.bpf." are allowed.
+ * For security reasons, only *name__str* values prefixed with "user." or
+ * "security.bpf." are permitted.
  *
  * Return: length of the xattr value on success, a negative value on error.
  */
@@ -187,10 +206,18 @@ static int bpf_xattr_write_permission(const char *name, struct inode *inode)
  * @value_p: xattr value
  * @flags: flags to pass into filesystem operations
  *
- * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ * Set xattr *name__str* of *dentry* to the value in *value_p*.
  *
- * For security reasons, only *name__str* with prefix "security.bpf."
- * is allowed.
+ * For security reasons, only *name__str* values prefixed with "security.bpf."
+ * are permitted.
+ *
+ * The length constraints imposed on both the xattr name and value abide those
+ * that are also enforced by the VFS. Additionally, the flags argument respects
+ * what's enforced by the VFS in the same way. By default, the flag value of 0
+ * is permitted and an xattr will be created if it does not exist, or the value
+ * will be replaced if the xattr already exists. More course grained control
+ * over these exact semantics is permitted by explicitly specifying either
+ * XATTR_CREATE or XATTR_REPLACE.
  *
  * The caller already locked dentry->d_inode.
  *
@@ -206,7 +233,17 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 	u32 value_len;
 	int ret;
 
+	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
+		return -EINVAL;
+
+	ret = bpf_xattr_validate_name(name__str);
+	if (ret)
+		return ret;
+
 	value_len = __bpf_dynptr_size(value_ptr);
+	if (value_len > XATTR_SIZE_MAX)
+		return -E2BIG;
+
 	value = __bpf_dynptr_data(value_ptr, value_len);
 	if (!value)
 		return -EINVAL;
@@ -237,8 +274,8 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
  *
  * Rmove xattr *name__str* of *dentry*.
  *
- * For security reasons, only *name__str* with prefix "security.bpf."
- * is allowed.
+ * For security reasons, only *name__str* values prefixed with "security.bpf."
+ * are permitted.
  *
  * The caller already locked dentry->d_inode.
  *
@@ -249,6 +286,10 @@ int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
 	struct inode *inode = d_inode(dentry);
 	int ret;
 
+	ret = bpf_xattr_validate_name(name__str);
+	if (ret)
+		return ret;
+
 	ret = bpf_xattr_write_permission(name__str, inode);
 	if (ret)
 		return ret;
@@ -274,11 +315,19 @@ __bpf_kfunc_start_defs();
  * @value_p: xattr value
  * @flags: flags to pass into filesystem operations
  *
- * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ * Set xattr *name__str* of *dentry* to the value in *value_p*.
  *
  * For security reasons, only *name__str* with prefix "security.bpf."
  * is allowed.
  *
+ * The length constraints imposed on both the xattr name and value abide those
+ * that are also enforced by the VFS. Additionally, the flags argument respects
+ * what's enforced by the VFS in the same way. By default, the flag value of 0
+ * is permitted and an xattr will be created if it does not exist, or the value
+ * will be replaced if the xattr already exists. More course grained control
+ * over these exact semantics is permitted by explicitly specifying either
+ * XATTR_CREATE or XATTR_REPLACE.
+ *
  * The caller has not locked dentry->d_inode.
  *
  * Return: 0 on success, a negative value on error.
@@ -327,14 +376,15 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *cgroup* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *cgroup* and store the output in *value_p*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* values prefixed with "user." are
+ * permitted.
  *
  * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
-					struct bpf_dynptr *value_p)
+				      struct bpf_dynptr *value_p)
 {
 	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
 	u32 value_len;
-- 
2.54.0.545.g6539524ca2-goog

