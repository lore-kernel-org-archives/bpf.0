Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625121A459;
	Wed, 23 Sep 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142038; cv=none; b=UVUiuM25ubndXaSeAbQ9bQH7cB0jOc5DRHneemZ2elkGTKtHg0tWz/vBFzjW7v/TuEeyy//Y3BqMF0d2xuUDPJRPaUhCGoYDyaP05nYyt3gloFvR/u7+TZP3ZOe8ytrbgkz2m5fWdwF76fcM59JjSUF38zr7Bqip/IlQlON67jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142038; c=relaxed/simple;
	bh=Tfn8qvtEMA3bVae84++iK1W+N2jp6kiBt73YYSQudGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b37LIfOsjl5y7fE1d18yTEzWXZwD1ihg8KRixHcvANy2Ef8Wvn1VkImi08jaPRjIF5SZhU7CxqH1/eByplcKCzbc0LRJvpaN+G1ES1jht0yb+WCbxh2+WbJNWRx6s3SKxqEGfngDvX3jl1x/KAIS1OAV4kF8J1u1UAwwyAiakPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dWTNutNd; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dWTNutNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142036; x=1821678036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNOFMcm0ALQtx8uNz3E+ErHcgScbjyXVRxmwiRpaAqs=;
  b=dWTNutNdYX5MvjpmeEqbwtcNvivNU1edMSQjbUF5flQjjwkqIYGb1HV/
   1M1J4z7koUCEuDBoSX9rCVz+SqGVn/39SuZEaE46JjziSMwv9Zh0Bi9QJ
   DYXAKYWLkmrwQy54JLcRJMYjGBMQGlDX7cFhYb3gQwOjaFvjP7/vkYEln
   NG/qBassS/nYcshneYdUvKWXAOMlbrh2Qi2qeJT/B6ewBXZEvyudGSI5T
   tnBSyp1O9J5jKKkRaMKpDrTiB4i3eDu4aBOL2pSHZgy7fzyxByIoqSWgv
   WM3ErQsTus/dAca8nPiPmh92b9yLyoXXZgX+MKG1Qn0Abxjq7mA//PezH
   Q==;
X-CSE-ConnectionGUID: SBWtaKhPSbOjzZ252NTu3w==
X-CSE-MsgGUID: XhJ/DhJTTymXN7+atpYlng==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29195618"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:40:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:23925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.208:2525] with esmtp (Farcaster)
 id 8069c48d-6f98-4c16-adc6-07f7fb2f3ce0; Wed, 23 Sep 2026 05:40:35 +0000 (UTC)
X-Farcaster-Flow-ID: 8069c48d-6f98-4c16-adc6-07f7fb2f3ce0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:35 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:35 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Wed, 23 Sep 2026 05:39:45 +0000
Message-ID: <20260923053948.30617-4-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923053948.30617-1-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

bpf_check() fetches the vmlinux BTF up front for every program, whether
the program uses kernel types or not.  With the upcoming
CONFIG_DEBUG_INFO_BTF=m that fetch loads a module and parses 5 MiB of
BTF, and since systemd loads socket filters at boot, it would happen on
every system, whether anything uses BTF or not.

Stop fetching up front and fetch at the points where kernel types enter
the verifier state instead:

 - bpf_add_kfunc_call(), for the first kfunc call of a program;
 - check_pseudo_btf_id(), for ldimm64 of a kernel variable;
 - check_ptr_to_map_access(), for accessing a map pointer's fields;
 - check_helper_call(), when the helper's prototype takes or returns a
   PTR_TO_BTF_ID (helper_uses_vmlinux_btf()).

Together with the existing fetch in bpf_prog_load() for attach_btf and
the struct_ops map creation, every PTR_TO_BTF_ID register a program can
hold originates from one of these sites.  A program that uses none of
them, such as a socket filter, no longer touches the vmlinux BTF.

bpf_snprintf_btf() and bpf_seq_printf_btf() run in program context and
cannot afford a fetch that may sleep.  Add bpf_peek_btf_vmlinux(), which
returns the parsed vmlinux BTF or NULL without parsing anything, and use
it there; the helpers fail with -EINVAL if the BTF is not parsed, as they
do on a kernel without BTF.

With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is parsed at boot by the
first kfunc registration, so nothing changes.  Without BTF, a helper that
takes or returns a kernel pointer is now rejected with -ENOTSUPP at the
call rather than with -EINVAL for its zero return type id.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/verifier.c    | 54 +++++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c |  3 ++-
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..a3c4caad5dfc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3165,6 +3165,7 @@ static inline s32 bpf_call_args_imm(s16 idx)
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
+struct btf *bpf_peek_btf_vmlinux(void);
 
 /* Map specifics */
 struct xdp_frame;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..2425ea74b61d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2873,7 +2873,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	tab = prog_aux->kfunc_tab;
 	btf_tab = prog_aux->kfunc_btf_tab;
 	if (!tab) {
-		if (!btf_vmlinux) {
+		/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+		if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 			verbose(env, "calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF\n");
 			return -ENOTSUPP;
 		}
@@ -6257,7 +6258,8 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	u32 btf_id;
 	int ret;
 
-	if (!btf_vmlinux) {
+	/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
 		return -ENOTSUPP;
 	}
@@ -11568,6 +11570,20 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return err;
 }
 
+/* Does calling @fn bring kernel BTF types into the program state? */
+static bool helper_uses_vmlinux_btf(const struct bpf_func_proto *fn)
+{
+	int i;
+
+	if (base_type(fn->ret_type) == RET_PTR_TO_BTF_ID)
+		return true;
+	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return true;
+	}
+	return false;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -11637,6 +11653,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	/*
+	 * Helpers that take or return kernel BTF pointers need the vmlinux
+	 * BTF; with CONFIG_DEBUG_INFO_BTF=m this is where it gets loaded.
+	 */
+	if (helper_uses_vmlinux_btf(fn) && IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
+		verbose(env, "helper %s#%d is not supported without vmlinux BTF\n",
+			func_id_name(func_id), func_id);
+		return -ENOTSUPP;
+	}
+
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
@@ -19235,12 +19261,13 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 	} else {
-		if (!btf_vmlinux) {
+		/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR_OR_NULL(btf)) {
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
-		btf_get(btf_vmlinux);
-		btf = btf_vmlinux;
+		btf_get(btf);
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
@@ -21153,6 +21180,17 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf;
 }
 
+/*
+ * The vmlinux BTF if it has been parsed already, else NULL.  Unlike
+ * bpf_get_btf_vmlinux() this never loads or parses anything, so it is safe
+ * to call from a running BPF program.
+ */
+struct btf *bpf_peek_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	return smp_load_acquire(&btf_vmlinux);
+}
+
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
@@ -21724,7 +21762,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto err_prep;
 
-	bpf_get_btf_vmlinux();
+	/*
+	 * The vmlinux BTF is not fetched up front: with CONFIG_DEBUG_INFO_BTF=m
+	 * it is loaded on demand, at the points where kernel types enter the
+	 * program (attach_btf, kfuncs, ksyms, map pointers, BTF-typed helpers).
+	 */
 
 	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..c022b2877f0b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1015,7 +1015,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 	if (btf_ptr_size != sizeof(struct btf_ptr))
 		return -EINVAL;
 
-	*btf = bpf_get_btf_vmlinux();
+	/* Called from a running program: only use the BTF if it is parsed. */
+	*btf = bpf_peek_btf_vmlinux();
 
 	if (IS_ERR_OR_NULL(*btf))
 		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;
-- 
2.47.3

