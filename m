Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C13939A5
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055472; cv=none; b=FZwMozM8IYU+CPViPXKoJ3YbOvrj1RT62MowRRrOV5jhRQ+p9jhJ0dy1orx89Z3TNXe29iVgY+mkoDnGneQEi+O5alGpeSOUb2DbqjHVBMMV/zqorqgMLlg69srVjfnGoqXblVFSNpy9ME2YKl7QNNJkQfbRGrLAiB/BCjRQsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055472; c=relaxed/simple;
	bh=CICxnT7DGoKTCdO1fEpfL9HL8DkYtSihyHnNbdGk1bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvZxmVI7pi7LX6obvAWFmRp/BO83+8eGkNo29NakViq8lQtE2Ra2iWMFOYSRE8PG8snEWFh/2M1B01H9TngjHAKKBKADPMTPo3OfAuYDmqFUFWu4evfl2cCb5w3uYSBgsYYABaTNqaUzifYVz1gVqvj7EHbcK/gDaj6rypokVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgOt80ER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgOt80ER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773055470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yOJgxxosTMZ/bEWW2X3R4fPw1OjBz46vtsAvuc0TtQ=;
	b=FgOt80ERPPQb1Q6euPo38xiC4mtm82P4/T2quCnZHm1zWKdlV6kpOxu38QviOR3FO+24dE
	rbf8N1DR8DpLE/wIDr98ZVjLmV2hfi4g1Lckv9PJhna7wO8LYKPwZ+jmYmEbUIn36olEPA
	QkvTZtO9lpA/72u1xggu5nQeFY23hQE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-vbjvEEB6NPqLtKkxYK5zOA-1; Mon,
 09 Mar 2026 07:24:25 -0400
X-MC-Unique: vbjvEEB6NPqLtKkxYK5zOA-1
X-Mimecast-MFC-AGG-ID: vbjvEEB6NPqLtKkxYK5zOA_1773055463
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 530241800345;
	Mon,  9 Mar 2026 11:24:23 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A920C1800351;
	Mon,  9 Mar 2026 11:24:17 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 2/3] bpf: Always allow fmod_ret programs on syscalls
Date: Mon,  9 Mar 2026 12:23:57 +0100
Message-ID: <472310f9a5f4944ad03214e4d943a4830fd8eb76.1773055375.git.vmalik@redhat.com>
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

fmod_ret BPF programs can only be attached to selected functions. For
convenience, the error injection list was originally used (along with
functions prefixed with "security_"), which contains syscalls and
several other functions.

When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
that list is empty and fmod_ret programs are effectively unavailable for
most of the functions. In such a case, at least enable fmod_ret programs
on syscalls.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a52e57f3eb80..8e4f69918693 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24952,15 +24952,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -24996,6 +24987,15 @@ static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *fu
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
@@ -25023,7 +25023,7 @@ static bool has_arch_syscall_prefix(const char *func_name)
 #endif
 }
 
-/* Without error injection, allow sleepable progs on syscalls. */
+/* Without error injection, allow sleepable and fmod_ret progs on syscalls. */
 
 static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
 {
@@ -25033,6 +25033,15 @@ static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *fu
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

