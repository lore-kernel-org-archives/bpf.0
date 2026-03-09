Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FF39283E
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055481; cv=none; b=HPvEVmKiw+nxc2ZQBwapBFFAQjwc8vTvtOexJfX9JrcIxeM7vQJIkxfeTauVdyhRGsF008dMW1DI3zQEYLtKFOYn5pepf2Zwq205zM9t0yS05ejXRfKb/zK/uu1uhSUOkABKE9Lumja0KfCJJJGniWIUf4NudSDc8uq7hDbZkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055481; c=relaxed/simple;
	bh=e8Y+U1o7vcPRxDkorWEfJvo22WS28py7tI2S0BEezm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIrwf0n+K6fkb0VH2IzxB5V93GF8xUIe+WBlkBNohNUugYsC9pb/3u/DKdLP/K6wXPysMVZxC58Wn7XIE1QbTFHW10mlvaa3OQ1BkumfSaxAaVd6nKppFxI+/rVWSlFL+08cQ7aYIoIvuTeftywEjh+gRShFJC45Ouo5AJNy5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K35059XD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K35059XD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773055479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BR0KJsk0yZseKZrePh4vjCvx36i0RQruWCsySvGgo8Q=;
	b=K35059XD8a4O9E+iNV2mV5FpOBxLpgGLdP4pb56QVD8wcAoGPMmFuOEYEEVVL96gxTdTbV
	dwFsv4qeNNWgNm1xD48FdP/LM9uHkE+/TK4oKQPffyjecJNDoddtVyrSDo03EBQdVd2Ma2
	WvShLIBeslYXaV5UDW7BAwDbJQvcLNg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-4VHIhPVfPXCk1RqgZ8jDcQ-1; Mon,
 09 Mar 2026 07:24:33 -0400
X-MC-Unique: 4VHIhPVfPXCk1RqgZ8jDcQ-1
X-Mimecast-MFC-AGG-ID: 4VHIhPVfPXCk1RqgZ8jDcQ_1773055470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B84218005BD;
	Mon,  9 Mar 2026 11:24:30 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE918180035F;
	Mon,  9 Mar 2026 11:24:23 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
Date: Mon,  9 Mar 2026 12:23:58 +0100
Message-ID: <8b6626eae384559855f7a0e846a16e83f25f06f6.1773055375.git.vmalik@redhat.com>
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

Now that sleepable programs are always enabled on syscalls, let
refcounted_kptr tests use syscalls rather than bpf_testmod_test_read,
which is not sleepable with error injection disabled.

The tests just check that the verifier can handle usage of RCU locks in
sleepable programs and never actually attach. So, the attachment target
doesn't matter (as long as it is sleepable) and with syscalls, the tests
pass on kernels with disabled error injection.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/refcounted_kptr.c      | 4 ++--
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1aca85d86aeb..c847398837cc 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -500,7 +500,7 @@ long rbtree_wrong_owner_remove_fail_a2(void *ctx)
 	return 0;
 }
 
-SEC("?fentry.s/bpf_testmod_test_read")
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __success
 int BPF_PROG(rbtree_sleepable_rcu,
 	     struct file *file, struct kobject *kobj,
@@ -534,7 +534,7 @@ int BPF_PROG(rbtree_sleepable_rcu,
 	return 0;
 }
 
-SEC("?fentry.s/bpf_testmod_test_read")
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __success
 int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
 	     struct file *file, struct kobject *kobj,
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 836c8ab7b908..b2808bfcec29 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -93,7 +93,7 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 	return 0;
 }
 
-SEC("?fentry.s/bpf_testmod_test_read")
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("function calls are not allowed while holding a lock")
 int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
 	     struct file *file, struct kobject *kobj,
-- 
2.53.0

