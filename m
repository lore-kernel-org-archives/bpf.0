Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795148924;
	b=1BHVRDyZcgYyLuvqOO3Da6qVS2mfJ+vhBDVD4Nam7mLHP4Lg3HLfwIlXnTmSwUaJnuaO
	 GS6egYhfvbk2a8LvLLvnrKe9/LAcfUT5QqAGVsDpewlaseKC3+ZW9YgBJm+RaH859qIbL
	 /7x7bFruhIPTSDZ/LGE7JHlDjFRnwptYoCqyxlE+j4hsjQBciQa+Ohbvcoap+sdhJv3iH
	 08gwwUaIpSmPF6H0x7mOAESH2rCIaH4njPcHWaFGSAqD5/gAnHPwnpDBX03GSpLz6vwYr
	 4UrKtwu+O9pfCyPosP6eAmYUwDmoQngcs1QaILj28X0vSCUHz0sZaOIiTSWMMpqUgIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795148924;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=fOEWrJZtywxHqIC6enC++RBPtKCtrgZZJPePAFSlkWM=;
	b=jkKlT1+EeZIh50g9xt9SzOPPPXa98nMdViZUiJgttiIjdkp6KW8MyqdF7aY+Ugd24wDa
	 CN7xVDk7XMvxDTG1XSC0RmOrMh3Bdrt+xaYqxtPpCyZIzbHpSQp/g0wu3iDyzOixZl0ml
	 T79Eb/ah0vz7JAxHxT2AtEtCM/Z+TcC0mmieLXGVQ1IF/2ysb5yi98O0HRb7eVNM21N71
	 kfPcHDCV4PVnxAHEhfXhVq8+5XkhpROe+46oW3z2/aT5loEAWm6mWk6gyJLIbiCbsqlpH
	 hUUTM85XuIVwJupIznMCqK1pEpZ1LMWtWHl2160E6hS07ara0De57cGskZIAQAJAjgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NEwhAfZz;
	arc=none smtp.remote-ip=91.218.175.143
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86E606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 04:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A86E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NEwhAfZz
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9qFmDBtDjKXXhxRLQFA5L7yZm0Cyx68K1IIN39IpzpM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795148921; v=1; x=1795753721;
 b=NEwhAfZzOW1pwYal/oZ/PjWYWOYECnIJmgLiaJuX5lrZnXuet3ap7hF73a1BR4lPXeshCsus
 CouNYjpkqkUhFWIwSDwR0ke94iEqe8nmG0xM4Z5mbiSy/dSn7/45xHjDaINfPuvTbhMhGt0PHXo
 byWUrRjLTb6jIjSF2G0gL8KY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1fdff059cb70f213;
	Fri, 20 Nov 2026 04:28:41 +0000
X-Mizu-Trace-ID: 1fdff059cb70f213
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 04:28:36 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range() return
 void
Message-ID: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
X-B4-Tracking: v=1; b=H4sIAFCO/2oC/yWMQQqDMBBFryKz7kAStASvUrqIdtKOaCozUQTx7
 o12+fj/vR2UhEmhrXYQWln5mwrYWwX9J6Q3Ib8KgzPubq31OETs5oijTiiU1zCiXDcfTG1cQ1Q
 3Hoo9C0XervIDTiPRluH5X3TpBurzGYbj+AGFyV7thQAAAA==
X-Change-ID: 20261118-jf-bpf-lsm-retval-range-8a04025ee458
X-Mailer: b4 0.15.2
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With CONFIG_BPF_FMODRET_SCAN=y, fmod_ret programs can attach to tagged
functions, so a program on bpf_lsm_get_retval_range() can make it fail
for an LSM hook that returns a value. get_func_retval_range() then
reports no range, and do_refine_retval_range() and check_helper_call()
ignore the error and use a range the call did not set.

The function fails only for a void hook, which every caller but
get_func_retval_range() already rules out. Check for a void hook there
and make the function return void, so resolve_btfids no longer tags
it and no fmod_ret program can attach to it.

Fixes: bc45414d1690 ("bpf: Allow fmod_ret on tagged functions and check the return value")
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
Built with W=1 on x86_64 and arm64, with gcc and clang, with and
without CONFIG_BPF_LSM. With CONFIG_BPF_FMODRET_SCAN=y, the BPF LSM
selftests give the same results with and without this patch. They ran
under QEMU emulation only, not on real hardware, and we have no
reproducer for the failure.

AI coding agents found the bug by reading the code, wrote this patch
and its changelog, and ran the builds and tests above.
---
 include/linux/bpf_lsm.h |  9 ++++-----
 kernel/bpf/bpf_lsm.c    | 10 +++-------
 kernel/bpf/verifier.c   |  5 +++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index eb4a38eef87e..14b8bb6cc25f 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -55,8 +55,8 @@ void bpf_inode_storage_free(struct inode *inode);

 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);

-int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
-			     struct bpf_retval_range *range);
+void bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *range);
 int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags);
 int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
@@ -98,10 +98,9 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }

-static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
-					   struct bpf_retval_range *range)
+static inline void bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+					    struct bpf_retval_range *range)
 {
-	return -EOPNOTSUPP;
 }
 static inline int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 					      const struct bpf_dynptr *value_p, int flags)
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0aa2fd61daba..f28754e8ac72 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -478,13 +478,10 @@ bool bpf_lsm_hook_returns_errno(u32 btf_id)
 	return true;
 }

-int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
-			     struct bpf_retval_range *retval_range)
+/* Callers must skip void hooks, which have no return value range. */
+void bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *retval_range)
 {
-	/* no return value range for void hooks */
-	if (!prog->aux->attach_func_proto->type)
-		return -EINVAL;
-
 	if (btf_id_set_contains(&bool_lsm_hooks, prog->aux->attach_btf_id)) {
 		retval_range->minval = 0;
 		retval_range->maxval = 1;
@@ -497,5 +494,4 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 		retval_range->minval = -MAX_ERRNO;
 		retval_range->maxval = 0;
 	}
-	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a8e5a108a68..3ebd5106358a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6978,9 +6978,10 @@ static int check_stack_access_within_bounds(
 static bool get_func_retval_range(struct bpf_prog *prog,
 				  struct bpf_retval_range *range)
 {
-	if (prog->type == BPF_PROG_TYPE_LSM &&
+	if (IS_ENABLED(CONFIG_BPF_LSM) && prog->type == BPF_PROG_TYPE_LSM &&
 		prog->expected_attach_type == BPF_LSM_MAC &&
-		!bpf_lsm_get_retval_range(prog, range)) {
+		prog->aux->attach_func_proto->type) {
+		bpf_lsm_get_retval_range(prog, range);
 		return true;
 	}
 	return false;

---
base-commit: 32b66b94c86f009b49668de7340f2ed65aad2dc5
change-id: 20261118-jf-bpf-lsm-retval-range-8a04025ee458

Best regards,
--
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

