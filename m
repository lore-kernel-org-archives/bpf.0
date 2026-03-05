Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391C17B418
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724383; cv=none; b=mk/ApYziI+SX0PEi7ff+i43pm8x6JChFXdrkyrtFZHN9dqvdKbhOQopO9noTYGX0OZuYwlAbxiku+QDfcMWqS7DojN3ZRydBm1QRmV1m1IoQZ1YTjjSWtlvvacT65JliZhuzoYyL209TBK9m18NWEtV3q627FZ5azdvpXqds1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724383; c=relaxed/simple;
	bh=30gPcwF+jrYoH24gz3g31+z1FdOlQ1G5CDYA8FICLTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfo+uh/6WexUQZy5aCDefqk3KpDDVK9ULkIt+fzPWsxLmLXfyuYgjp9cBpSl8b7oyGgDLpHM9KLlatNSYrZg4H5czJmY904k7yxhD1V8pDDee2x7YjWvOaEpX/DA6FD2wa5e2X12iXNSCdyk5q2//YmFXSwtKX69vLDad/Zh5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuR+Y9Dd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuR+Y9Dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772724381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ee3ICeYE4yNNkF20aKgdPs1w5/apXdsc49lHY1PAcQ=;
	b=MuR+Y9DdvTif+B85+32b8KSbWyBjpbxAzfLylM6uY9EZiK1yumtwR2O6v1wimk9nhYpQfF
	O/7LAWWyPkkpuil1upGViZBhPwKKzl54HogvMzQTdi7s3Bd//fUmKsbquq7GLedDKSQmAM
	5eY/+Xad+GnwPv9syJFnv2A+mcSowfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-bmcXNvFxOhyR2dRxmNvUeg-1; Thu,
 05 Mar 2026 10:26:15 -0500
X-MC-Unique: bmcXNvFxOhyR2dRxmNvUeg-1
X-Mimecast-MFC-AGG-ID: bmcXNvFxOhyR2dRxmNvUeg_1772724370
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D191920327;
	Thu,  5 Mar 2026 15:25:58 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B88441800760;
	Thu,  5 Mar 2026 15:25:52 +0000 (UTC)
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
Subject: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on syscalls
Date: Thu,  5 Mar 2026 16:25:35 +0100
Message-ID: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
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

Sleepable BPF programs can only be attached to selected functions. For
convenience, the error injection list was originally used, which
contains syscalls and several other functions.

When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
that list is empty and sleepable tracing programs are effectively
unavailable. In such a case, at least enable sleepable programs on
syscalls.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..cb80a3ddb7a4 100644
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
@@ -24951,6 +24953,51 @@ static int check_non_sleepable_error_inject(u32 btf_id)
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
+	return !strncmp(func_name, "sys", 3);
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
@@ -25230,12 +25277,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

