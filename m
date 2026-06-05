Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AED3C6A38
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695324; cv=none; b=AF2F+vwHraMDSeYssJUYVvl5OnHmIuzzwI6sor3a3AOUCqGObQDDwYpnQqTMOa/1HtO3IrO+ZMKLmd7uuVy02AIT+0tsSUTvpTc21U4j3/BdDI5F/o6HtMcqdnYh4uVnN/yBIZLmwSbyROs6K/9zMwv2u3p7XC5JQCykNiST4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695324; c=relaxed/simple;
	bh=ibjKwB9FsVVKFn+oqg2UuPK2SQqyLS7+PIOI6wJ4KT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkkUv+foyGSgf56+t5ZmRwWlKlMRHNLkAkslCfcJ7ccwolbbupmpZ3P+u9Hd7c67h3NnjXIiV5XdFwwmb0xue9WCDY7TKIgG7VdyvHxSNf4VHQZtx3Q86NYrIfUEVf2XwsMwwOur0vbUzPrI5bXrrXGxmfLl9/VmMVIkA6gC09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IpRX4g0g; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IpRX4g0g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=6V56JbLY3UqLQC9si9HPypSz4uBXmwCaW1ti7KjCuDA=; b=IpRX4g0gURGzO8VKRMZKsa8bsO
	QooJK7CW6xjgt1d0esYyDKVIEU0wAhy/ohQPtn3N0+/8vEn7unLXXEhOUqPDaFc4O6zf0g6fAha6t
	a43dncxklsxAI9iGKFUziv4j11W7XUOioinob8EEjPYgna2j5PFUem8Z+6ZH4v541tKhBUzqb5/0p
	qzRyyo8GWhvPyCQajnOOIff8bKrSUtxOEsTlnT8w7sHyGd+npBzibNSkQwP4QwIEqL7pmiHori8yI
	ofJ+8ikNUz8FPuNeUVKn/IreL7X3x9y/f59BwSWUYgxMPpD36l7S9XNnpyt3ZobgobOxJccpXnOmZ
	aXyVrdUQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wVcCE-00026R-2e;
	Fri, 05 Jun 2026 23:35:18 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kpsingh@kernel.org,
	ast@kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Expose signature verdict via bpf_prog_aux
Date: Fri,  5 Jun 2026 23:35:17 +0200
Message-ID: <20260605213518.544262-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28022/Fri Jun  5 08:25:05 2026)

From: KP Singh <kpsingh@kernel.org>

BPF_PROG_LOAD verifies the loader signature but does not record the
outcome on the BPF program. [BPF] LSMs and audit can read attr->signature
and attr->keyring_id to infer "was this signed, and if so, against which
keyring".

Add prog->aux->sig (verdict + keyring_{type,serial}), populated by
bpf_prog_load before the LSM hook. keyring_type classifies the keyring
the load referenced (builtin, secondary, platform or user), while
keyring_serial records the serial of the keyring the signature was
actually validated against. System keyrings carry a pseudo key pointer
with no user-visible serial and are reported as 0, as are unsigned loads.
Failed verifications reject the load before the hook runs, so it observes
only either UNSIGNED or VERIFIED.

Signed-off-by: KP Singh <kpsingh@kernel.org>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h  | 45 ++++++++++++++++++++++++++++++++++----------
 kernel/bpf/syscall.c | 29 +++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8599b451dd7a..f615b56730d2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -32,6 +32,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/key.h>
 #include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
@@ -1674,6 +1675,19 @@ struct bpf_stream_stage {
 	int len;
 };
 
+enum bpf_sig_verdict {
+	BPF_SIG_UNSIGNED = 0,
+	BPF_SIG_VERIFIED,
+};
+
+enum bpf_sig_keyring {
+	BPF_SIG_KEYRING_NONE = 0,
+	BPF_SIG_KEYRING_BUILTIN,
+	BPF_SIG_KEYRING_SECONDARY,
+	BPF_SIG_KEYRING_PLATFORM,
+	BPF_SIG_KEYRING_USER,
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1716,6 +1730,11 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	struct {
+		s32 keyring_serial;
+		u8 keyring_type;
+		u8 verdict;
+	} sig;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
@@ -3697,8 +3716,14 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL) */
 
-#if defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL)
+#ifdef CONFIG_KEYS
+struct bpf_key {
+	struct key *key;
+	bool has_ref;
+};
+#endif /* CONFIG_KEYS */
 
+#if defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL)
 struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
 struct bpf_key *bpf_lookup_system_key(u64 id);
 void bpf_key_put(struct bpf_key *bkey);
@@ -3706,6 +3731,10 @@ int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 			       const struct bpf_dynptr *sig_p,
 			       struct bpf_key *trusted_keyring);
 
+static inline s32 bpf_key_serial(const struct bpf_key *key)
+{
+	return key->has_ref ? key->key->serial : 0;
+}
 #else
 static inline struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
 {
@@ -3727,6 +3756,11 @@ static inline int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline s32 bpf_key_serial(const struct bpf_key *key)
+{
+	return 0;
+}
 #endif /* defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL) */
 
 /* verifier prototypes for helper functions called from eBPF programs */
@@ -4002,15 +4036,6 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
 static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
 #endif /* CONFIG_BPF_LSM */
 
-struct key;
-
-#ifdef CONFIG_KEYS
-struct bpf_key {
-	struct key *key;
-	bool has_ref;
-};
-#endif /* CONFIG_KEYS */
-
 static inline bool type_is_alloc(u32 type)
 {
 	return type & MEM_ALLOC;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 625a4366fe6d..243db131cb22 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2865,8 +2865,22 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
+{
+	switch (keyring_id) {
+	case 0:
+		return BPF_SIG_KEYRING_BUILTIN;
+	case (s32)(unsigned long)VERIFY_USE_SECONDARY_KEYRING:
+		return BPF_SIG_KEYRING_SECONDARY;
+	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
+		return BPF_SIG_KEYRING_PLATFORM;
+	default:
+		return BPF_SIG_KEYRING_USER;
+	}
+}
+
 static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
-				     bool is_kernel)
+				     bool is_kernel, s32 *keyring_serial)
 {
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
 	struct bpf_dynptr_kern sig_ptr, insns_ptr;
@@ -2902,7 +2916,8 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 
 	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
 					 (struct bpf_dynptr *)&sig_ptr, key);
-
+	if (!err)
+		*keyring_serial = bpf_key_serial(key);
 	bpf_key_put(key);
 	kvfree(sig);
 	return err;
@@ -3089,13 +3104,17 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
-
 	if (attr->signature) {
-		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel);
+		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel,
+						&prog->aux->sig.keyring_serial);
 		if (err)
 			goto free_prog;
+		prog->aux->sig.keyring_type = bpf_classify_keyring(attr->keyring_id);
+		prog->aux->sig.verdict = BPF_SIG_VERIFIED;
+	} else {
+		prog->aux->sig.keyring_type = BPF_SIG_KEYRING_NONE;
+		prog->aux->sig.verdict = BPF_SIG_UNSIGNED;
 	}
-
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
-- 
2.43.0

