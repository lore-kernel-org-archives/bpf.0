Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CE221D89
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804493; cv=none; b=rKk87ITLW41PTJYS7Z5KrIi5QSqAAgOrA/tSmp1nZUPqdRxcGAefg9/T3fgzasOdUvoITtaMUyS570c/cOFqohE48YQDnLenYBdxFW85fRnijPBXHtF0mEB9ZHo/Ofb4IhO6Exs7pBJUsMrPfXCC6jhOU/HGRc0d1Bpb2vqAtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804493; c=relaxed/simple;
	bh=01d2qnuGgaioHiOVhr3Uu3ijCw3ySHcMBLn+f5V/sws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo8B65kNsA4peAK6tkpa/8StOIiCbIKLqMBvGRon+j52Wwn+EnRPGcY2aFcesG5UHPO7hT6705T4uSs690MKOBvNMk0PL28v5kxZxPZToQ94r9I/Wl1LIWqjN5g0UyiV5mwOi8+mmdq0uyLmZ24k2SzgHWqbj56LfEu+CuSMTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZf1kWsH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZf1kWsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772804490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2XViuwxL1URmhjvZ0jiFFleYIf+oo5jNtwPYGzii0g=;
	b=VZf1kWsHYdhEkEGgD7UzKU76ut7h/VKPPg+oR7E2J0CiQ0UPYGTOStUcIV2EAmCbL0GlqZ
	LBLR2tK7PGf77DEvHaVxJZx1wlWrkOAgeiCBZGEzd3ycmTIKLWits7t7eGavK98F9SEda+
	zRAaH8aPxBdf7nTqxScDZtFse2ep6bE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (35.165.154.97 [35.165.154.97]) by relay.mimecast.com with ESMTP with
 STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-tV-S4o1zNRO9LAMuJqsnMw-1; Fri, 06 Mar 2026 08:41:25 -0500
X-MC-Unique: tV-S4o1zNRO9LAMuJqsnMw-1
X-Mimecast-MFC-AGG-ID: tV-S4o1zNRO9LAMuJqsnMw_1772804478
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C40481800561;
	Fri,  6 Mar 2026 13:41:17 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED12180058B;
	Fri,  6 Mar 2026 13:41:10 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Always allow sleepable programs on syscalls
Date: Fri,  6 Mar 2026 14:40:57 +0100
Message-ID: <df4e8730627c311b18fb0634989070eaa1567c75.1772804199.git.vmalik@redhat.com>
In-Reply-To: <cover.1772804199.git.vmalik@redhat.com>
References: <cover.1772804199.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sleepable BPF programs can only be attached to selected functions. For
convenience, the error injection list was originally used, which
contains syscalls and several other functions.

When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
that list is empty and sleepable tracing programs are effectively
unavailable. In such a case, at least enable sleepable programs on
syscalls. For discussion why syscalls were chosen, see [1].

To detect that a function is a syscall handler, we check for
arch-specific prefixes for the most common architectures. Unfortunately,
the prefixes are hard-coded in arch syscall code so we need to hard-code
them, too.

[1] https://lore.kernel.org/bpf/CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com/

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..458fc528ccc6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24930,6 +24930,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+
 /* list of non-sleepable functions that are otherwise on
  * ALLOW_ERROR_INJECTION list
  */
@@ -24951,6 +24953,55 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
+{
+	/* fentry/fexit/fmod_ret progs can be sleepable if they are
+	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
+	 */
+	if (!check_non_sleepable_error_inject(btf_id) &&
+	    within_error_injection_list(addr))
+		return 0;
+
+	return -EINVAL;
+}
+
+#else
+
+/* Unfortunately, the arch-specific prefixes are hard-coded in arch syscall code
+ * so we need to hard-code them, too. Ftrace has arch_syscall_match_sym_name()
+ * but that just compares two concrete function names.
+ */
+static bool has_arch_syscall_prefix(const char *func_name)
+{
+#if defined(__x86_64__)
+	return !strncmp(func_name, "__x64_", 6);
+#elif defined(__i386__)
+	return !strncmp(func_name, "__ia32_", 7);
+#elif defined(__s390x__)
+	return !strncmp(func_name, "__s390x_", 8);
+#elif defined(__aarch64__)
+	return !strncmp(func_name, "__arm64_", 8);
+#elif defined(__riscv)
+	return !strncmp(func_name, "__riscv_", 8);
+#elif defined(__powerpc__) || defined(__powerpc64__)
+	return !strncmp(func_name, "sys_", 4);
+#else
+	return false;
+#endif
+}
+
+/* Without error injection, allow sleepable progs on syscalls. */
+
+static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
+{
+	if (has_arch_syscall_prefix(func_name))
+		return 0;
+
+	return -EINVAL;
+}
+
+#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -25230,12 +25281,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			ret = -EINVAL;
 			switch (prog->type) {
 			case BPF_PROG_TYPE_TRACING:
-
-				/* fentry/fexit/fmod_ret progs can be sleepable if they are
-				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
-				 */
-				if (!check_non_sleepable_error_inject(btf_id) &&
-				    within_error_injection_list(addr))
+				if (!check_attach_sleepable(btf_id, addr, tname))
 					ret = 0;
 				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
 				 * in the fmodret id set with the KF_SLEEPABLE flag.
-- 
2.53.0

