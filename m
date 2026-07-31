Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA373322A1C
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464489; cv=none; b=Pi/XOLPgDFVoX5oGhsz3YdbP2jbyrPqjAmwpJjCsJFkOuph3YKalR1BfEx5Zy+UG340v1migGXKCChKpVR9hWygsBYndfPLMiqdIZ/Pi7e2r+7nr/1zu2bZlLC/hx9EjqMsEgj3Pz9KjBTMqgIH36f4Ubb9ZP9lj5oR1K4kBYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464489; c=relaxed/simple;
	bh=NL8mBC7WHXg65243KavwzxselJ8EusI6R5QSuWKlbs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpRt+R6zNiytsXIp80m2KN2ivHFHsfsCpkh/dt/+djctI4jnMx2bTuTgSL7+qMKAwjbr3ybxbcX6KoGxVWmf41RAMq/etIaGHQY/5ygxQ1fdU4DYlS3GhXNwmISqaOd5wfv6nWkWs/R5B2OKAkVS6R9iOF94hBQh+qfEfv7FouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiFkuMY3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiFkuMY3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81eaf3709b4so7391147b3.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464484; x=1786069284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTtFKNvHB2/Ojp2xHTtFD0mxvMCw7gVj2kPcAk5LXGw=;
        b=oiFkuMY3lsVKuL5Qqrwgzh1oEskSwGwnF/VvkkRpNEVvd7Ze1SZ7Sr6sFaEQP8VM1u
         +h5CM+4Mr3xQxgfXpsjb+lnScR40QZyEJ+4YzDr/LEyKL7uobe3hKZdfuN/K39k0ad/W
         JBClrrfN+8u3bU3jJfPLgDreaVabggDWRmMNcwISOKOZ7WmbTNAyn0lvt0zPIYM33dHA
         Nz38dwhtYkaEnZQoCbGkyr2M8zEk0zIAVspRyZt6H7iPbMYPFd/X++htTZUOkCdRmzBc
         kcIWZqDYX9VDa8LxGRu3rm/O2275AjVeiyQpVceoj2Y+G3uGe+SkX28InW5FQQnWKaJp
         Xqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464484; x=1786069284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTtFKNvHB2/Ojp2xHTtFD0mxvMCw7gVj2kPcAk5LXGw=;
        b=OdrTYTdJBTuDoUe84XHL2I1guk8k96cmyvIbsNmDX3OO/EIavsf+hmvQT4VpXkiZuz
         FibQIKdo+AkJVdzgfhClhQta2fUTYH4xEw/BnwbrFHsrvxlI4ViGLH/Cz78Dx+YpLOiK
         A1NxB2DTs1i/+BkRljXGPVDNVYcGocv39/kozIJrWNQBKC3k+qtZCYAcxOrx6uDOoVPB
         rZQR46WFdX5OXFuHg3Yx51Y7eGRcwZxILnW8WQUBZWEOCzzghBLxPQ4a2caX0RH4QU7b
         FP8TYk7cmmIXBx8ajA/WyPaMB7BViMqd9N84tySmUgTud92iqa0Ncc2dS6DvZBxKSVuQ
         fmhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6icL5ChEjVnEYPaRNE5eB257p7QLkS6oyZfswjQbkuZG9B4aFzAb7m2csTYfT5KnVeQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuM6qmwyQuhX8i4P58viMjKfufjAN6RZ9vsVcIpwHl4RJ4W8u
	GF52By0u4Y9fr/mWX+2Vm6PhsQ61Zn2sghtJa5m3Vey1ZMmdAxDLE9KK
X-Gm-Gg: AR+sD10kpqTmNGsRatgtocltd1bdheMzzlaeMF702Pn5MCgTFljvf5vxYLTMzDwDgM5
	uThK486F6LXHUmOLh0nL6f7NhG8eqEcC5O4HNvwtNsK4jCuGYR+wIqMR/3mnX+MrRsypR4HEwoB
	0u7Ieg/YoBcOhrL3g0Rec+Em9vbVAUoYldEF5k9M8PKXplTuqanagG6hOoEzKK3RTg8AsD6rtEz
	/TdFTu0j6GloAf/nODb0IBJIAmRLKfFgzGbCq92fbQh4ZP25UssS3+iLyRX11eQd4MucV3EB9IA
	sASeZ30UwVA1zIr0geMKVyFbOHRzDQVl4CMNjjq45Oo3lNRcIoM06yYQYg/NGCb9or8lQ5RVrsC
	u+UwBY64D0sFYmKK9PQSoBgqlyBQr2yldiTyqw7auipO74zTBtj+qgeR8DPrP/UpImvsloT0uW8
	PhLmtcE+NHFMJ6x4MyGH0Hmii44NEvD+aSK9J5Pq2Jk2lYQtZOf+lGZCNSRygwx3a944z/Y+VSS
	Rq8CBRHRKy8sCr74loco3A=
X-Received: by 2002:a05:690c:3705:b0:80d:66b2:850 with SMTP id 00721157ae682-81fcc1238e6mr120377b3.42.1785464484423;
        Thu, 30 Jul 2026 19:21:24 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 08/13] bpf: Add the bpf_landlock_put_ruleset kfunc and ruleset destructor
Date: Thu, 30 Jul 2026 22:20:41 -0400
Message-ID: <20260731022047.189137-9-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the release kfunc for Landlock ruleset references:

  bpf_landlock_put_ruleset(ruleset)             KF_RELEASE

It is a thin front end to security_policy_kptr_put(), invoked with
LSM_ID_LANDLOCK; the handle travels in the Landlock member of union
lsm_policy_kptr, staying typed end to end.

A ruleset reference is meant to be handed over through a map kptr
field, so also register a destructor for struct bpf_landlock_ruleset:
map-held references are dropped on map teardown.  The release path
may thus run from a context that cannot sleep, which the
policy_kptr_put() hook contract requires implementations to support.

The release kfunc is available to both program types the kfunc set is
registered for.  For BPF_PROG_TYPE_LSM, the filter only accepts
programs attached to the bprm_creds_for_exec() or
bprm_creds_from_file() hooks, where the upcoming enforcement kfunc is
specified to operate, and rejects BPF_LSM_CGROUP programs, which run
under classic RCU; KF_SLEEPABLE limits the callers to sleepable
programs.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index dd58c5bd0119..877dd0352607 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -14,8 +14,10 @@
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
+#include <linux/cfi.h>
 #include <linux/ima.h>
 #include <linux/bpf-cgroup.h>
+#include <uapi/linux/lsm.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached. Notably, we qualify each with
@@ -481,9 +483,49 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
  */
 struct bpf_landlock_ruleset {};
 
+/*
+ * The sleepable LSM hooks bpf_landlock_put_ruleset() may be called
+ * from.
+ */
+BTF_SET_START(bpf_landlock_kfunc_hooks)
+BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
+BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_SET_END(bpf_landlock_kfunc_hooks)
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_landlock_put_ruleset - Put a Landlock ruleset
+ * @ruleset: Landlock ruleset to put
+ *
+ * Release an acquired reference on a Landlock ruleset.
+ */
+__bpf_kfunc void bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset)
+{
+	union lsm_policy_kptr policy = { .landlock.ruleset = ruleset };
+
+	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
+}
+
+/* Destructor for referenced bpf_landlock_ruleset kptrs. */
+__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
+{
+	union lsm_policy_kptr policy = { .landlock.ruleset = ruleset };
+
+	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
+}
+CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
+
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
 
+BTF_ID_LIST(bpf_landlock_dtor_ids)
+BTF_ID(struct, bpf_landlock_ruleset)
+BTF_ID(func, bpf_landlock_put_ruleset_dtor)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the LSM
@@ -498,6 +540,17 @@ static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	case BPF_PROG_TYPE_SYSCALL:
 		return 0;
 	case BPF_PROG_TYPE_LSM:
+		/*
+		 * BPF_LSM_CGROUP programs run under classic RCU and
+		 * cannot sleep.
+		 */
+		if (prog->expected_attach_type == BPF_LSM_CGROUP)
+			return -EACCES;
+
+		if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
+					 prog->aux->attach_btf_id))
+			return -EACCES;
+
 		return 0;
 	default:
 		return -EACCES;
@@ -512,6 +565,12 @@ static const struct btf_kfunc_id_set bpf_landlock_kfunc_set = {
 
 static int __init bpf_lsm_policy_kfunc_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_landlock_dtors[] = {
+		{
+			.btf_id = bpf_landlock_dtor_ids[0],
+			.kfunc_btf_id = bpf_landlock_dtor_ids[1],
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
@@ -519,7 +578,13 @@ static int __init bpf_lsm_policy_kfunc_init(void)
 	if (ret)
 		return ret;
 
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					&bpf_landlock_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_id_dtor_kfuncs(bpf_landlock_dtors,
+					   ARRAY_SIZE(bpf_landlock_dtors),
+					   THIS_MODULE);
 }
 late_initcall(bpf_lsm_policy_kfunc_init);
-- 
2.54.0

