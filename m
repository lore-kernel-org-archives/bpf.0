Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2078632B
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736459; cv=none; b=YZPpQ8SCs+WLqISGe5dAQ6OZmItkGRKPRuBrelwEWeYljSS4rI/ZtmCpB2hKL05KXc1ceaadqsSsUOhFyZgsfzdiuak4s1vuxe3gfK1qSrlyNAEhM0wNNi2R9bEJmDx8kvOVlDGKKUJZqgzyLHMiu3dzhWd/cjIGrsdpHDiWOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736459; c=relaxed/simple;
	bh=berEah5oPIbe0V6wNi2IAeDI8K+V4h/GmEIrkFP09Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvt+IDy1EZvi0uUt2cywbviqPY+Wh7dC6q5lhRZhSZN8hbN/ZMRkiYaoA93rSlYU8LmUSqLLuvTmLl4fevxBkR2Yp6q5FBVysCyxCo2RcNvSI2UR1+s6CqiOVZCs/vYPOPWpyAJUMfMEo7Re5aXelNBwDn8OlldOI8q4e7iQzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3jK9eG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3jK9eG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770736457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3wv8DSpLzNBAIV/x3EiN7STk0nujPAXUqofBPAi8skc=;
	b=S3jK9eG0cgUTNnIYnoZeLWYsTzkRXYweG7ti9fVRzXMduZJVeKYFW7eGgIqgZ9+62dxvuC
	Emo8uwLnl6ds1MpUqOhtbpEC2XPJH1AgBYoXyIXpGMeQ7X5UCFKrahiOMK4IStQAZr52B2
	qn65XtdU8z55DqxwMyCezqjEqt7raXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-j4O97LxuPX-H3TBkX44PuQ-1; Tue,
 10 Feb 2026 10:14:13 -0500
X-MC-Unique: j4O97LxuPX-H3TBkX44PuQ-1
X-Mimecast-MFC-AGG-ID: j4O97LxuPX-H3TBkX44PuQ_1770736451
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E72961955F1D;
	Tue, 10 Feb 2026 15:14:10 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F140530001A5;
	Tue, 10 Feb 2026 15:14:05 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Qais Yousef <qyousef@layalina.io>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v3 0/3] Separate tests that need error injection
Date: Tue, 10 Feb 2026 16:13:59 +0100
Message-ID: <cover.1770736390.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some enterprise kernels (such as RHEL) do not enable error injection via
BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
When running test_progs on such kernels, a lot of test cases fail since
they use sleepable fentry or fmod_ret program types which require error
injection to be enabled. While it is possible to skip these via custom
DENYLIST, some test_progs are not properly split into subtests and
therefore must be entirely skipped.

This patch series split such tests into subtests, namely module_attach
and read_vsyscall. In addition, the last patch separates a sleepable
fentry test out of the LSM test suite into a separate test so that it
can be skipped without skipping other LSM tests.

Changes in v3:
- Replace `return` by `goto cleanup` when skeleton is already open
  (found by AI review)

Changes in v2:
- Fix indices in read_vsyscall/copy_from_user subtest (reported by CI)

Viktor Malik (3):
  selftests/bpf: Split module_attach into subtests
  selftests/bpf: Split read_vsyscall into subtests
  selftests/bpf: Split sleepable fentry from LSM test

 .../bpf/prog_tests/fentry_sleepable.c         |  28 +++
 .../selftests/bpf/prog_tests/module_attach.c  | 168 +++++++++++++-----
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  41 ++++-
 .../selftests/bpf/prog_tests/test_lsm.c       |   8 -
 .../selftests/bpf/progs/fentry_sleepable.c    |  28 +++
 tools/testing/selftests/bpf/progs/lsm.c       |  21 ---
 .../selftests/bpf/progs/read_vsyscall.c       |  18 +-
 .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
 8 files changed, 249 insertions(+), 126 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

-- 
2.53.0

