Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031021D3F3
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804501; cv=none; b=ZrDq+QpcKHf9qWMNFC5RA5TGZcOx3E5yqLZI0dItjFncciHjJoTlUHFJJZz5x8by5vkBvnfKojspb32aoaFlB3Kv7JNHHzA/TtRiykl6+uCvxIlvWVIHTIsInAORo5PJx48CyW1MJjjMMDzANM8Byaz7EHJCxd7JiQV0jthlOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804501; c=relaxed/simple;
	bh=G6VY5RDVjhZMohKXuUVetgaAVnAeU49myyQ1Nlk+vvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIiQobqz4IPfpGA657OTRb7ZqFQ8YEzHOoogb4cTkd11CbsfIF2hPN2SQF/mrpElaQgg//OhwpkIUKAAYM/qWHl2vUuYx+ev51Ia0/2Al6QUqaSQkbOhn12KCzEppKPDPNKcXDTvW7OVCNG0RiDvOqBf9BnavU6fsR4Xw56kMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8UQyFRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8UQyFRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772804499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48AgRvPpMmicOhvi4SBNaTEWDoQoTwK8k7XE/ZL8mJk=;
	b=V8UQyFRk5CwM2TdhwFj9nAlGqASpIzQmOtIukfDM1ApOhQOW5R99iDFJvPyQkpjSlrVP+G
	KxsDpsWiPcFY+pEThpDeGWfhtw4ylhu9USbbuMdrJuGstaisAX2xbIH/6kKqIjEnmqSjUV
	UM9tTtJCEwVumzdITnveM1he9euj6eE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-1ywtGvzlNpSIpfFcLkJSiQ-1; Fri,
 06 Mar 2026 08:41:35 -0500
X-MC-Unique: 1ywtGvzlNpSIpfFcLkJSiQ-1
X-Mimecast-MFC-AGG-ID: 1ywtGvzlNpSIpfFcLkJSiQ_1772804492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F31D195608D;
	Fri,  6 Mar 2026 13:41:32 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50001800361;
	Fri,  6 Mar 2026 13:41:25 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
Date: Fri,  6 Mar 2026 14:40:59 +0100
Message-ID: <8ce28b8f962759f5177b4b426f4ab372775aeef2.1772804200.git.vmalik@redhat.com>
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

Now that sleepable programs are always enabled on syscalls, let
refcounted_kptr tests use syscalls rather than bpf_testmod_test_read,
which is not sleepable with error injection disabled.

The tests just check that the verifier can handle usage of RCU locks in
sleepable programs and never actually attach. So, the attachment target
doesn't matter (as long as it is sleepable) and with syscalls, the tests
pass on kernels with disabled error injection.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
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

