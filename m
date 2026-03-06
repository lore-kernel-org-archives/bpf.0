Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43661A2389
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804494; cv=none; b=ECa3Ht3z7dZOuU81NFt1PmUxtstTPmUW0sVgvxYVlRieYlVDfwfGMsgqtYhi0ysvyJpbhFgmCQrnjjfyHPAP7P5JSdybPJAGLzplYtXfDjpVymksRKT8pwgGx6C6dOwcfkTVwGymLL+lDOnetIPN/WydbwtYGELm9tpyq0cEa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804494; c=relaxed/simple;
	bh=W5Yk6UZEOdjdy90OrbeCWPRiPsGbHUGuDLP2Fj4Ib6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abIlaaq5QK3X094ITxqhTg302ywan7thglIvHTTK4WmVq1WQ+RVjorUKF/O+fxSDZtJx/KTX6cbETGGF5i+9dypaSI6b10wHt+ErWbKt8lG8sLcQvADWvOIq6XTRiRAx0rxpgKLSjZ6dbnecFb3f4NlG701x8dVczysLJ0sK4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWubt8Uu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWubt8Uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772804492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEwNwOdpPOyF/kQTFgzPcU3A57fwNCMpCI8CYnVSmr0=;
	b=BWubt8Uu1AVlzFNXJt2sgY2azS2jT9PPqsSK1mzrv0SlxZlReKJMUNcujSG+yDeVSbuoi0
	zcPuL73pX8lVXeontG0KFEATVWu9NKxGm6DpwfQMOUlLHo5bD2HKTLFZpXhvVlXXVjBUc6
	yvk4ihPtSwEok/m/2ysIrdo3r2AOfRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-6Sl9ql2JPt6R5g-7qXHrxw-1; Fri,
 06 Mar 2026 08:41:28 -0500
X-MC-Unique: 6Sl9ql2JPt6R5g-7qXHrxw-1
X-Mimecast-MFC-AGG-ID: 6Sl9ql2JPt6R5g-7qXHrxw_1772804486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DE291956059;
	Fri,  6 Mar 2026 13:41:25 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61103180035F;
	Fri,  6 Mar 2026 13:41:18 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 2/3] bpf: Always allow fmod_ret programs on syscalls
Date: Fri,  6 Mar 2026 14:40:58 +0100
Message-ID: <710368d4559b13d2d82a47ef1fa7d70a9a038add.1772804200.git.vmalik@redhat.com>
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

fmod_ret BPF programs can only be attached to selected functions. For
convenience, the error injection list was originally used (along with
functions prefixed with "security_"), which contains syscalls and
several other functions.

When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
that list is empty and fmod_ret programs are effectively unavailable for
most of the functions. In such a case, at least enable fmod_ret programs
on syscalls.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 458fc528ccc6..f05dea10c1b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24921,15 +24921,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 }
 #define SECURITY_PREFIX "security_"
 
-static int check_attach_modify_return(unsigned long addr, const char *func_name)
-{
-	if (within_error_injection_list(addr) ||
-	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
-		return 0;
-
-	return -EINVAL;
-}
-
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
 /* list of non-sleepable functions that are otherwise on
@@ -24965,6 +24956,15 @@ static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *fu
 	return -EINVAL;
 }
 
+static int check_attach_modify_return(unsigned long addr, const char *func_name)
+{
+	if (within_error_injection_list(addr) ||
+	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
+		return 0;
+
+	return -EINVAL;
+}
+
 #else
 
 /* Unfortunately, the arch-specific prefixes are hard-coded in arch syscall code
@@ -24990,7 +24990,7 @@ static bool has_arch_syscall_prefix(const char *func_name)
 #endif
 }
 
-/* Without error injection, allow sleepable progs on syscalls. */
+/* Without error injection, allow sleepable and fmod_ret progs on syscalls. */
 
 static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
 {
@@ -25000,6 +25000,15 @@ static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *fu
 	return -EINVAL;
 }
 
+static int check_attach_modify_return(unsigned long addr, const char *func_name)
+{
+	if (has_arch_syscall_prefix(func_name) ||
+	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
+		return 0;
+
+	return -EINVAL;
+}
+
 #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
 
 int bpf_check_attach_target(struct bpf_verifier_log *log,
-- 
2.53.0

