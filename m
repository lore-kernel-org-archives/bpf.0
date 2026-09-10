Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1A44F57C
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076122; cv=none; b=XfSrlEENqED9D6YwEr83aGIDzub6hFNhE6KCV1F/cchSbZgN6Y35XDj66rDMY5qgkz2oUpbOkpwkBN+aqfK5FSL6FIpkOlg0IJkYivdYJYDVB10DbefRUUhFbp0qVMNeQ0qoMp1rWdACI7HHIFynRLz7k0GJLf0UGNs/pk/UGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076122; c=relaxed/simple;
	bh=BjIJ1xnc2WOk2M7MXtF4gqQ5rA3NwA+uVDbameNVUsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMnI6r6VZoIpDfgzg8lOivv/zX2hR+XSYzZgzyFkblOpoglSinLbStDIeVFueS47oNuDwZV9u+y/aLan1PvagFOjrnbseL22HYv0onk/R8l0I53VGxWDp9vFVPal+2Gkr1Q7BVyYKxCqjvtnDfC9c1bkAhkRq3SidD5eOOGzXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GBcmvFrc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GBcmvFrc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=FGGIE2OMoF7QCZDLTXwYkwzNN2MqT+FGSOjqddXXihc=; b=GBcmvFrc/D6eCWz0xElXPQ0pWc
	V9COpC2GQLy5rAHdbyqQEoPP9Ogrv97/TCJN1h09jZpqQf1Y4r45OHr8g/ZWPXaz540MP3CzMnhq/
	zgf5v800Nn+3nGiuBo1Xqwt/MHCa2wJjCDoCUdPqtlcI+ThDzATGtP+IezuePb0Fk4l6SKd4n88aS
	fIDDOwDQrcB/CVybq7Bh39NPuuBbOCepKxpaHABaNZ3oAIBSzDkOt57Kmux0yHPfoPFLWhAnNntSh
	3JureS5wIsTVC+ib4jUbmkAih5/tCmlPX+mr9Xo1hNhQ+hxtAArsP0W8v7PegDwcacmNi9EC8skej
	GmEqTTqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4mQJ-000H2G-0j;
	Thu, 10 Sep 2026 23:35:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 1/4] bpf: Add KF_PERFMON kfunc flag
Date: Thu, 10 Sep 2026 23:35:07 +0200
Message-ID: <20260910213510.49358-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
behind CAP_PERFMON. However, the same is currently not true for kfuncs
and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
which can be used such that check_kfunc_call() ensures env->allow_ptr_leaks
is permitted. This follows similar pattern to existing KF_DESTRUCTIVE flag.

The rejection returns -EPERM to match the other CAP_PERFMON gates in the
verifier, that is, check_ptr_to_btf_access() and check_ptr_to_map_access(),
which report the very same policy to user space.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/bpf/kfuncs.rst | 10 ++++++++++
 include/linux/btf.h          |  1 +
 kernel/bpf/verifier.c        | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 85f73e0bbd0f..6691fe8a32c3 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -486,6 +486,16 @@ Example usage in BPF program:
 	/* note that the last argument is omitted */
         bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
 
+2.5.10 KF_PERFMON flag
+----------------------
+
+The KF_PERFMON flag is used for kfuncs that can expose kernel memory or kernel
+addresses to the BPF program, for example by reading through a pointer that the
+verifier does not check. Calling such a kfunc requires CAP_PERFMON, or
+CAP_SYS_ADMIN, in the same way that the equivalent BPF helpers are gated in
+bpf_base_func_proto(). A program loaded with CAP_BPF alone is rejected at load
+time.
+
 2.6 Registering the kfuncs
 --------------------------
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 89d5a5c4f117..7c62ea17b116 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -80,6 +80,7 @@
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
+#define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..939e535a3442 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11356,6 +11356,11 @@ static bool is_kfunc_destructive(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
 }
 
+static bool is_kfunc_perfmon(struct bpf_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_PERFMON;
+}
+
 static bool is_kfunc_rcu(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RCU;
@@ -13834,6 +13839,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (is_kfunc_perfmon(&meta) && !env->allow_ptr_leaks) {
+		verbose(env, "%s is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+			func_name);
+		operation = bpf_diag_fmt(env, "kfunc %s", func_name);
+		bpf_diag_policy(env, insn_idx, operation, "the kfunc requires CAP_PERFMON",
+				"Load the program with CAP_PERFMON, or avoid the kfunc.");
+		return -EPERM;
+	}
+
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
-- 
2.43.0

