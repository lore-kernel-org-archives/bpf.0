Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3453B47D3
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677472; cv=none; b=mPk+s6lxoS5Y8FxHuZielKLDH478dTZXxoxmX6rRELd5PpaKl7H92kmRJUP+fdcFWxA3T6ew5nJ1h/yIwACbh8X3FfB06KdSU8KlN0Xe6TpLw1g1T749/MTkK4CnJr6TmcYJ0QBLO4zccsnAPNQNi69M+E0eqBj+VrA/cK3MBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677472; c=relaxed/simple;
	bh=8G5lQEJnrIsdsRBk8/Fkg1GkTmTkdfI5WAEQL9Ml8dM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jl3LHjlyK9XvbuZufyGYKjZu6QUCr6BpjDZ3oK3Hmp9meGSUGnk5olfSmRPX3gvtx3z8qSPW2lMS7RY9SXl8NeL0UYL8rlCD7AWH9A4VSXrhpIElu0a/RE4W9rRDSefUzuEKBCWkKqASpI5BzxqJIJG0IX9Kqd4DsRSoc6bBDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yop6cX+W; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yop6cX+W"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c126399a328so36326666b.1
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782677468; x=1783282268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AKKHjOTOyHeYDIo2AsxJL21BNV9L4QizagbBhszJaA=;
        b=Yop6cX+W3hBMHjdCxtNqRbdJypmB586R2fS+zP5ZwAvt+DxcRoivuCyWB9+gjBt+4h
         fxT/9j0HNfghHHaqUyZ1xwC9iQlJ3HwAq9ffq/mgV6TlIq7e/3g97np0OKaQ0H7Xs/vo
         c3ynyUh3WGlcEwqeTuKorJH07YeuGzjbIIaoHvDfam17UjnO7Yl1Mt2CGEl9caKJ2EO4
         6GrLGFEEZW92SKkSAwdO+IPnqEsqqHbIV7FEPv3knNyNZ3kqym6S9Wr/+9eRzllaWCC9
         IU9WFPVNzJFOBGyLylzr64xl1I73/U2A1g/rxsyLOLRFFHK8qIFsWghllQXPgjX9cAtq
         n4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782677468; x=1783282268;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AKKHjOTOyHeYDIo2AsxJL21BNV9L4QizagbBhszJaA=;
        b=Vliz8UbqxJrqW6NDTMbhhGZzqhjRpXlkmWXKW9YTqPEBx0FluZhiRW5o01SK2HEzQs
         sZe/3l8/o8ejigd37RAgKAmCMc1FfWsLaK5YAkLC4A/EJiFCyv7RnbXW+TuUSsUeMOKR
         PiNNzeQZzpx5XaVwfS/U8/6g45rMK240NGRcxaxOFIvqfItn//rBw6Dp4ZPwBYX9NoDo
         mP15BR3C/A5d2ym+4ZN3f7rlB1lqD7/j4OfL2tqiIOJ7P/uyBJFYUdFYKlfWUaAbWFod
         KBzR1SXmrAvqhvydRXthlUv+tfkLsYkEcIt4M/jtfdtELt+5pIi3rHTk1DvJDRXcYQdJ
         y7HQ==
X-Gm-Message-State: AOJu0Ywoxd7ivBR8U7qRl5VTZhLXUTECF1V7gr2EWCJ5lrd5AUqBD0F3
	kNXZldoAfJRGkPvniobomjHLCHhvIEwKzeLFwvC4RZBa+kDTuj97wyuTkw+kX2n5R02xYVAnuxE
	PPOTLtPST/B71Mw5p5oX68ugk+gpuL19X13YNhpUMprtzDEVGe7Ej/qpIl5BFPyIbN96TyQ8yvO
	v4p1JPkXnuPz4K05XjjX1WHJvbohtJjsaGGaqXFh2JQTdPq5Si8oxAaHmMKG8midlk2GPMMQ==
X-Received: from ejdaq6.prod.google.com ([2002:a17:907:f506:b0:c12:1ae0:33db])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d12:b0:c12:13cd:9579 with SMTP id a640c23a62f3a-c1213cda86emr620806766b.0.1782677467647;
 Sun, 28 Jun 2026 13:11:07 -0700 (PDT)
Date: Sun, 28 Jun 2026 20:11:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260628201103.3624525-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] bpf: reject BPF_MAP_TYPE_INODE_STORAGE creation if
 BPF LSM is uninitialized
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Paul Moore <paul@paul-moore.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, oxsignal <awo@kakao.com>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_BPF_LSM=y is set, BPF inode storage maps
(BPF_MAP_TYPE_INODE_STORAGE) are compiled into the kernel. However,
if the BPF LSM is not explicitly enabled at boot time (e.g. omitted
from the "lsm=" boot parameter), lsm_prepare() is never executed for
the BPF LSM.

Consequently, the BPF inode security blob offset
(bpf_lsm_blob_sizes.lbs_inode) is never initialized and remains at its
default compiled size of 8 bytes instead of being updated to a valid
offset past the reserved struct rcu_head (typically 16 bytes or more).

When a privileged user creates and updates a
BPF_MAP_TYPE_INODE_STORAGE map, bpf_inode() evaluates
inode->i_security + 8. This erroneously aliases the struct
rcu_head.func callback pointer at the beginning of the
inode->i_security blob. During subsequent map element cleanup or inode
destruction, writing NULL to owner_storage clears the queued RCU
callback pointer. When rcu_do_batch() later executes the queued
callback, it attempts an instruction fetch at address 0x0, triggering
an immediate kernel panic.

Fix this by introducing a global bpf_lsm_initialized boolean flag
marked with __ro_after_init. Set this flag to true inside
bpf_lsm_init() when the LSM framework successfully registers the BPF
LSM. Gate map allocation in inode_storage_map_alloc() on this flag,
returning -EOPNOTSUPP if the BPF LSM is in turn uninitialized.

This fail-fast approach prevents userspace from allocating inode
storage maps when the supporting BPF LSM infrastructure is absent,
avoiding zombie map states.

Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
Reported-by: oxsignal <awo@kakao.com>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 include/linux/bpf_lsm.h        | 4 ++++
 kernel/bpf/bpf_inode_storage.c | 9 +++++++++
 security/bpf/hooks.c           | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 143775a27a2a..dda272d78f01 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -56,6 +58,8 @@ bool bpf_lsm_hook_returns_errno(u32 btf_id);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 0da8d923e39d..f9e81060c1f4 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -178,6 +178,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
 	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..7b98f5d1e2be 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_lsm.h>
 #include <uapi/linux/lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -24,6 +26,7 @@ static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
 			   &bpf_lsmid);
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

