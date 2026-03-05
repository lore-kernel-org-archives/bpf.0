Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD630E0D5
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724386; cv=none; b=K1iOb00zDmjpzjlsyaXbfrCOxm/PxWbEQl2J2ogYcZ4TQfhx/2k4mKIBkWuucspZWKfodn6olkeqxxUYnj2lAByLjxysH3m9qBSPi1XQhmL1x3g8WRX45ZH7ZI0aSoHhLTiE/BgmxwaqkIGX4MmevyoZm0K1yLtikA4p2gZBrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724386; c=relaxed/simple;
	bh=RkVWOFwP7ZONBziMgLshO0cwpsou6W4j9LO6QCzekgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aydd7QRo1PE7YFR7ayHnV2n+ngrA5aVnRzzGLUJZQXs3Xp14+KNVr1Vz9uAbPj0JhEu0FPt1gZAu/0XYtYSe7g/G3qoqBN48IltWvNiEmu/ZuoRfb/QpokjaLm1gEja30inyQYL/wRwS+8MYJsAx9Xb3aCZVNO/rI1AM8lJXXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaGIicMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaGIicMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772724384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuZJ2yAL8xf7dLGiN0ZoFYbymbAPnEoBHRlCNXS4yrs=;
	b=JaGIicMvFtNX/e0hLSUhNvyDKbNmLYUApwtJMzfX/YbSvG7yAZnno7/k9FQdaBG0OUcQp6
	nyUMiAqzf0CR3hZYEZr2COVgEMEQLKZLKjRkcslWwigRhn8aKnzod+hb8T7jMvaug7xC3F
	IsI7xprjTyYrl+wDPFGnHewnZzjBYFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-QP1qHxUoPieQ9g9VCryKuQ-1; Thu,
 05 Mar 2026 10:26:20 -0500
X-MC-Unique: QP1qHxUoPieQ9g9VCryKuQ-1
X-Mimecast-MFC-AGG-ID: QP1qHxUoPieQ9g9VCryKuQ_1772724378
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C57901954102;
	Thu,  5 Mar 2026 15:26:05 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E845180075E;
	Thu,  5 Mar 2026 15:25:59 +0000 (UTC)
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
Subject: [PATCH bpf-next 2/3] bpf: Always allow fmod_ret programs on syscalls
Date: Thu,  5 Mar 2026 16:25:36 +0100
Message-ID: <a5d01f18517a1834c7905f1725c09d20f80620a2.1772721009.git.vmalik@redhat.com>
In-Reply-To: <cover.1772721009.git.vmalik@redhat.com>
References: <cover.1772721009.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index cb80a3ddb7a4..6883b18f1355 100644
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
 
 static bool has_arch_syscall_prefix(const char *func_name)
@@ -24986,7 +24986,7 @@ static bool has_arch_syscall_prefix(const char *func_name)
 #endif
 }
 
-/* Without error injection, allow sleepable progs on syscalls. */
+/* Without error injection, allow sleepable and fmod_ret progs on syscalls. */
 
 static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
 {
@@ -24996,6 +24996,15 @@ static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *fu
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

