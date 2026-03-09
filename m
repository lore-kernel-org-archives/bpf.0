Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928E392C46
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055466; cv=none; b=VzyWvQPPKKOQVtApE0N3lGcimlgxw/WWzpAUXy0s973iI3Ub5iI52mMOgClQlRS4XEjj3qGSSMnUdLCxIOLQhq2OJZZBLBdHPqfPjGcr4e/nPPdajUP0/873qXhq6QRAX5RIoHchhSvY+mErGqPq61rKSFdLdGddrjsoCI46jEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055466; c=relaxed/simple;
	bh=tq1x+BdC1z3Ai9o3C18Cxqn+Odr6xxPGjXpRAyNQDjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3TCgBe2rUJ9D9vGR0EcylgRgycXyBLsyWvxS02v+nOkpC+2ryt36Lv97e9OcBXUI6zJSQsFwwHYaI5aXWoXLTH5ZuLC85SFvYhz0OaU7RFZ6v4GsrX/2OYqK3/oSWCCvQ9MXg1dBkSEswtSyjQwd7dzyvS5+7d6drrw9IvJ1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WryCbKCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WryCbKCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773055464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLk8cRT2OEX31Io++dkMy9oYq+qbKkyO25lV+6GS+O8=;
	b=WryCbKCrcWtf5km97NVht2SqqR805jQDoWo7ElYlY6S6Pb74uQ+rCbUl+nVwQ6tlX8sgOF
	KOy/BOLNRlbNmbtr6CLlEZ/f7ykRaqV0qCOb2PxEnQh681xj8xEsA+ndrexLMi/EkN7tF4
	5JSUek2uJRJElrBV/jb+RNfv3gu6Sws=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-JD5Iz_BVMk6XeqOh4zO_Aw-1; Mon,
 09 Mar 2026 07:24:21 -0400
X-MC-Unique: JD5Iz_BVMk6XeqOh4zO_Aw-1
X-Mimecast-MFC-AGG-ID: JD5Iz_BVMk6XeqOh4zO_Aw_1773055457
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43D5419541A5;
	Mon,  9 Mar 2026 11:24:17 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9138D1800576;
	Mon,  9 Mar 2026 11:24:09 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Always allow sleepable programs on syscalls
Date: Mon,  9 Mar 2026 12:23:56 +0100
Message-ID: <2704a8512746655037e3c02b471b31bd0d76c8db.1773055375.git.vmalik@redhat.com>
In-Reply-To: <cover.1773055375.git.vmalik@redhat.com>
References: <cover.1773055375.git.vmalik@redhat.com>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 60 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa06f534cb2..a52e57f3eb80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24961,6 +24961,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+
 /* list of non-sleepable functions that are otherwise on
  * ALLOW_ERROR_INJECTION list
  */
@@ -24982,6 +24984,57 @@ static int check_non_sleepable_error_inject(u32 btf_id)
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
+#elif defined(__loongarch__)
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
@@ -25261,12 +25314,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

