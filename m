Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5884A6CDA
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188399; cv=none; b=fEWVXkm5fz1Es7ORWmfaZiTF+7S1q0hJRJD6L1M56O+qrTXOXBSUGbRGIyfkKL6PWcMbCIHla2aZQQe9MbQnCsT+cUx5THRl0TJ4V9FY70yXCdj3oHqrkUIRS8uKUGc8b57W+e0b9+bN4hL/fquKO4nGMsv0ZMEohE4/6aiYNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188399; c=relaxed/simple;
	bh=xzF999ibqg4mw3Kbq/zTe/hVGJfzKbE0cK8gaGiljdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASrEoiZRUbH5dIfp+L5QInkqB6MU0kPfY57483ktG//inhrbygovAv0eZezyIo3b5n//JIVovoZWEl72FMuKf0LCPTTPtvUFTgHZ373dtNCRDmH/6zSCT1PqqSXHuQjInYLc9s5ncsSTsbccyc0YyKdZcth2WVqjejRZLvCmMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knWJMLeP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knWJMLeP"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e6f0b4610so32283407b3.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188397; x=1788793197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuP/HSiHorbIS7zM6H5giX6A7B2bIefcFZ0dGi8JhTg=;
        b=knWJMLePsGezU9SC3FmP7QKkENKt554Gq1XxmU4QKQ4WcpnEzvtvbo/08Hrx8JeCye
         IQQgbx77Og2IuYQ5UJl+Psbigr6QjSaUbqoTKAhxjdEUjvXQGd9CWsE0z/7AJUETNqyC
         aTB36OpSKgfZfK2OkqoztKqGCGN+LUoCVUilHChbEpq12TQ3x3Jw7lQ7uiTWIDsHCPLl
         nXbqeoSRXYXbiphon+tP2G3vffRqK8iQ7976SnK1u88VYch+uGPxkRlYxIdm7dX1yVMK
         cagDmTCWobvLa/wC5+2vmsA6LAoQKn+C3BZxAZahUSFOYPvT3zwq3VhXkf8DOdVo4yEl
         FkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188397; x=1788793197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuP/HSiHorbIS7zM6H5giX6A7B2bIefcFZ0dGi8JhTg=;
        b=f87jDEbHpVzak0QebxGYIuAlUVqwg1bEPRHXZO1jMInGPktJ4+sKUro/6VKU+N9S7e
         mTVxHhpHFvOHQPPQL8ykQYeO9hf+188znTr5sbn1D62n/+E0uVftvjGdKUIbVkX5/SC/
         BQrYNNzyh+7LTnSSyNLu27j4f7jAGI7Qm6nU+HDEjbzxgqWz2wX6lf6oC2nOF9zQszPq
         Ju6sC9aJefFhi/YSnxjuzA4cy8FvOdFq3LfXpwf/xguqE2i7aOVwIu+l4TbFOMncvKhq
         Qt34gjv48aFCotsPYomwn22Ptdj83uo1u0Dj9s82P76y5rFs7zpZ3dYZQcnoIT6DVzqn
         /QNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7QCEoZdujNn1uqwCafd6UAUbdISw2NudKjKEsc6hCgizM0t0/HpZURcTTkKjRwKbQUzY=@vger.kernel.org
X-Gm-Message-State: AFuF++lmvXEawRUkIGYyzQxObtoTJx6YEPEOMHDMO+4U7HS5LbakbGu0
	MN9BSz4bCNGqET2m49Id5dckXRkDDw3HQ6/5v8XrW++p5a0fd2Wucrdl
X-Gm-Gg: AYBFou0ESfLuOU9sP0NbxlQqW4Tgn5BLWynedy1cfQyv+UoQ5O6zNG2b9hb79fg11iq
	ehKeGrjKCGsTrFVaG5I6NUuB90yrqXl5zHksThUnp9tfr6hnlE9FgK9ymQFe+GC+LPsvUpJJWhw
	3Vf5LRMLCdnfc58moCnsTEFaf/2wuIim7HO/9LsgtZlf1+YAoLN5HqPCJZHFKHSp+woOOl8vDQW
	/kVtu4jZ3wjVsj5fsMphiPtGTPba59bRjssnzAeDYBGIOPGLQLeYXEAOZiDtEy5nOe1r+N638gT
	FBtb8uhS7y5nBQRYzGNyxfxkchh/fe0WrP+z3pRPHMwVe3veqSSl/NXFFxPmoyVYEdQb2BCf6XD
	xbu/N+WKLN0+XrHvVTGmXnpBP5oLrjAdRfAtrK7tleab8NceVeUg74twtZWMosbwRexDSzU920G
	6EusLzcaufUKI91imI2y73++0EmFx6LEXPgSHCEh28eDhFX8ls9MXqkm7wkR4wBGx63VE85RmWN
	iSeHptwfiZ5JbBODhg7QOs=
X-Received: by 2002:a05:690c:38a:b0:858:ad19:324d with SMTP id 00721157ae682-868703e165fmr7145687b3.3.1788188397150;
        Mon, 31 Aug 2026 07:59:57 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:56 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 04/15] lsm: Add the bpf_lsm_policy_release kfunc and policy object destructor
Date: Mon, 31 Aug 2026 10:58:46 -0400
Message-ID: <20260831145858.3869191-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
policy objects to BPF programs, with the first of them:

  bpf_lsm_policy_release(object)                KF_RELEASE

The kfuncs are the LSM framework's own BPF interface: there is no
per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
walks the matching hook's implementation list and calls the one
registered by the LSM whose lsmid the policy object carries.  Calling
a kfunc for an LSM that is not active or has no policy object support
fails at runtime rather than hiding the kfunc at verification time,
so BPF program loading is independent of the boot-time LSM
configuration.

A policy object reference is meant to be handed over through a map
kptr field, so also register a destructor for struct
lsm_policy_object: map-held references are dropped on map teardown,
possibly from a context that cannot sleep, which the
policy_object_put() hook contract accounts for.  For the same reason
the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
releasing a reference must be allowed wherever one can be held.  The
filter itself is needed because BPF_PROG_TYPE_LSM and
BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
kfunc lookup buckets with other program types.

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 MAINTAINERS               |  1 +
 security/Makefile         |  2 +-
 security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 security/bpf_lsm_kfuncs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5301c30ea91..2af6a25a1399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5037,6 +5037,7 @@ F:	kernel/bpf/bpf_lsm.c
 F:	kernel/bpf/bpf_lsm_proto.c
 F:	kernel/trace/bpf_trace.c
 F:	security/bpf/
+F:	security/bpf_lsm_kfuncs.c
 
 BPF [SELFTESTS] (Test Runners & Infrastructure)
 M:	Andrii Nakryiko <andrii@kernel.org>
diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..a9364ea9828b 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
-obj-$(CONFIG_BPF_LSM)			+= bpf/
+obj-$(CONFIG_BPF_LSM)			+= bpf/ bpf_lsm_kfuncs.o
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
 
diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
new file mode 100644
index 000000000000..e1190215d477
--- /dev/null
+++ b/security/bpf_lsm_kfuncs.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* BPF kfuncs exposing LSM policy objects. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/cfi.h>
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+#include <linux/security.h>
+
+#include "lsm.h"
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_lsm_policy_release - Release a policy object reference
+ * @object: policy object to release
+ *
+ * Release an acquired reference on a policy object.
+ */
+__bpf_kfunc void bpf_lsm_policy_release(struct lsm_policy_object *object)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, policy_object_put) {
+		if (scall->hl->lsmid->id != object->lsmid)
+			continue;
+		scall->hl->hook.policy_object_put(object);
+		return;
+	}
+	/* A held reference implies the owning LSM implements the hook. */
+	WARN_ON_ONCE(1);
+}
+
+/* Destructor for referenced lsm_policy_object kptrs. */
+__bpf_kfunc void bpf_lsm_policy_release_dtor(void *object)
+{
+	bpf_lsm_policy_release(object);
+}
+CFI_NOSEAL(bpf_lsm_policy_release_dtor);
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
+BTF_KFUNCS_END(bpf_lsm_policy_kfunc_ids)
+
+BTF_ID_LIST(bpf_lsm_policy_dtor_ids)
+BTF_ID(struct, lsm_policy_object)
+BTF_ID(func, bpf_lsm_policy_release_dtor)
+
+/*
+ * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
+ * lookup buckets with other program types, so restricting the policy
+ * kfuncs requires a filter.
+ */
+static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
+				       u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_lsm_policy_kfunc_ids, kfunc_id))
+		return 0;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SYSCALL:
+	case BPF_PROG_TYPE_LSM:
+		return 0;
+	default:
+		return -EACCES;
+	}
+}
+
+static const struct btf_kfunc_id_set bpf_lsm_policy_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_lsm_policy_kfunc_ids,
+	.filter = bpf_lsm_policy_kfunc_filter,
+};
+
+static int __init bpf_lsm_policy_kfunc_init(void)
+{
+	const struct btf_id_dtor_kfunc bpf_lsm_policy_dtors[] = {
+		{
+			.btf_id = bpf_lsm_policy_dtor_ids[0],
+			.kfunc_btf_id = bpf_lsm_policy_dtor_ids[1],
+		},
+	};
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_lsm_policy_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					       &bpf_lsm_policy_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_lsm_policy_dtors,
+						  ARRAY_SIZE(bpf_lsm_policy_dtors),
+						  THIS_MODULE);
+}
+late_initcall(bpf_lsm_policy_kfunc_init);
-- 
2.55.0

