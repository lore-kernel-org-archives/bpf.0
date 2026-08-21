Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935953C10A4
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348484; cv=none; b=LoJY8ICUAVGIOnztFBalO/xbTaqSN6rKT8ZmVlkZPLnvAUCuwdxuqqGKpdyom1/k4lkWzYBQcXJZ6ndQEtpKJ9iYx3cqyj0hKFam0HqT/r2I62izq6c2xhMn2HrnxzjH4gLhOxzUW2uSlElL9SV0cEEtUtn8mPCv0IzGpMCEQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348484; c=relaxed/simple;
	bh=eYb9799/x8WoucfE7qS7p1I2ZO1sbQ2MBR7D7dHOUBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm5Ef8XibfTP/tdH5BkdqWpqprHR3gWvF+xcauk7m5LhSTCGJMf0lUFOsEgJGzUEqI9hUqJJ7XdZxSH7SwAnd1I140qR0iynV43/MryUEgQypZJrpEdPaQSIdvn8GHppROy6gyN5lr+syV8VeE1n7mN1KNBcFGmetp9Jxb6720o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Xrl0abu8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Xrl0abu8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tRNTqxFwso/eRKOWfQ0X+oJXEMfH2H+TtAes0pVMFVc=; b=Xrl0abu88KeINKQlIM3XFQnBSw
	iBn+VoeFGX8um+oDT4ZszMeEIqbTK+AOC52NicC1GVfp7mAVrmiummJrZj1YZwXDwRwso3RC4e8Sb
	XEwfe8dNfKLmSlGzGae1R1DHnnt1HZBhmk3iFrSpeukd0YT0ms6eCexElJOgBPFbs8wGXi2S+JeFj
	3fXqrQUr272rB3ifdpDO0850Mapf+wzX4ImcgMQe9cJ0fH4xXBqqV01soaHNABjAKW+HraYxDjuA3
	l7inMfwTmhPbkPZnAeKWS1je4iRBj3PINJ3bw5/eDqYUn/Mx8ZbrNo9QICtdI26o/U9VccVXFKv1e
	1/o618Tw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzB-000Mpd-32;
	Fri, 21 Aug 2026 23:41:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 02/11] bpf: Refuse caller-supplied keyrings when the bpf one is active
Date: Fri, 21 Aug 2026 23:41:02 +0200
Message-ID: <20260821214111.1120748-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28099/Fri Aug 21 08:26:38 2026)

Nothing changes for systems that do not use the bpf keyring. Without
bpf.keyring_unsealed=1 a caller-supplied keyring behaves exactly as
before, which also lets it serve as the staging step for software
installed onto a running system whose signing key is not enrolled
anywhere yet.

Passing bpf.keyring_unsealed=1 states that the bpf keyring is the trust
anchor for this boot, so from the first program load onwards a caller-
supplied keyring is refused with -EPERM. Deriving this from the boot
flag rather than from the keyring's runtime state keeps the decision
immutable from userspace.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++
 include/linux/bpf.h                           |  6 ++++
 kernel/bpf/keys.c                             |  5 ++++
 kernel/bpf/verifier.c                         | 29 ++++++++++++-------
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2beb61092bb3..543f245cc255 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -673,6 +673,13 @@ Kernel parameters
 			keys. Once the keyring is restricted it becomes active
 			and can be used for BPF program signature verification.
 
+			Setting this also means that the bpf keyring is the
+			only keyring a loader may select for the rest of the
+			boot: caller-supplied user/session keyrings are
+			refused with -EPERM, whether or not provisioning
+			actually completed. Leaving it unset keeps the prior
+			behaviour, where a caller-supplied keyring is allowed.
+
 			See Documentation/bpf/signing.rst
 
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 240e527c864b..f6ef16c938cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3821,6 +3821,7 @@ struct bpf_key {
 struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
 struct bpf_key *bpf_lookup_system_key(u64 id);
 struct bpf_key *bpf_lookup_keyring(void);
+bool bpf_keyring_enforced(void);
 void bpf_key_put(struct bpf_key *bkey);
 int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 			       const struct bpf_dynptr *sig_p,
@@ -3846,6 +3847,11 @@ static inline struct bpf_key *bpf_lookup_keyring(void)
 	return NULL;
 }
 
+static inline bool bpf_keyring_enforced(void)
+{
+	return false;
+}
+
 static inline void bpf_key_put(struct bpf_key *bkey)
 {
 }
diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
index dc4d3a33158a..60cb85295c89 100644
--- a/kernel/bpf/keys.c
+++ b/kernel/bpf/keys.c
@@ -18,6 +18,11 @@ static bool bpf_keyring_unsealed __ro_after_init;
 module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
 MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
 
+bool bpf_keyring_enforced(void)
+{
+	return bpf_keyring_unsealed;
+}
+
 struct bpf_key *bpf_lookup_keyring(void)
 {
 	struct bpf_key *bkey;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3be8d51d35ac..a93a8dc427d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21018,21 +21018,28 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	if (!attr->signature_size ||
 	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
 		return -EINVAL;
-	if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
-		key = bpf_lookup_keyring();
-		if (!key) {
-			verbose(env, "the bpf keyring is empty or has not been restricted\n");
-			return -ENOKEY;
-		}
-	} else if (system_keyring_id_check(attr->keyring_id) == 0) {
+	if (!system_keyring_id_check(attr->keyring_id)) {
 		key = bpf_lookup_system_key(attr->keyring_id);
 	} else {
-		key = bpf_lookup_user_key(attr->keyring_id, 0);
+		if (attr->keyring_id != VERIFY_USE_BPF_KEYRING) {
+			if (bpf_keyring_enforced()) {
+				verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
+				return -EPERM;
+			}
+			key = bpf_lookup_user_key(attr->keyring_id, 0);
+		} else {
+			key = bpf_lookup_keyring();
+		}
 	}
 	if (!key) {
-		verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
-			attr->keyring_id);
-		return -EINVAL;
+		if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
+			verbose(env, "the bpf keyring is empty or has not been restricted\n");
+			return -ENOKEY;
+		} else {
+			verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
+				attr->keyring_id);
+			return -EINVAL;
+		}
 	}
 
 	sig = kvmemdup_bpfptr(usig, attr->signature_size);
-- 
2.43.0

