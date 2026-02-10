Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A813FEE
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727254; cv=none; b=JwE9M0iyw/BlS5mJw1K6dUSoIBtBJYoLtzthtozHcNPn7kjEn7yWJcE9I2YOkpA+CcpfIvrHHl2+CCxETq3u4dJ5WreBKTTy8XE7y89li1IHxs6tSDmt7o4ABFhWWHnkY10vVobx/33xNNMmtSxaCaaqLl599EgZnG6N8R5j7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727254; c=relaxed/simple;
	bh=ii8d5JbDEOLB3qkhrZNWvOD4a5Bnj1yBjFJuMHqf0jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeiDc+yK9jMyHglLBU+3P/1WtWUw0qM5hnWs2VCxFDf5CHbDJYGk65Z1b1sevdI3LIV4pG31b6mtb+s8q1RkLB8vsYhDKmNGy28geuNNrtPjaCuigf92nz0pqddKdJFHgESsoG11lgmuy0/b1z51Is4YPT74Cw9O5s97Xhm+Bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAeEdxgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAeEdxgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770727252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2PwLna+SGXfk/EnsUFjb/78r8O9Rvbo7NhZSM+kbMZE=;
	b=ZAeEdxgm1Zq7+DF8g/clZESRLlpLuqlQgaawuJwXwbp660A4Oel03vUEmTMou5EpaqblKM
	PhxbHoTfNCOJ8oezCukc6KCqgK7JwFdSMxCdvNxSJSrYuDvC/ezbm4GOWC+qp6TivBzF9T
	d9YcflGQhXpM7svQT5GWLCBjBPeOugs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-GFF_M_jBM_-3Pf0PvTbA1Q-1; Tue,
 10 Feb 2026 07:40:48 -0500
X-MC-Unique: GFF_M_jBM_-3Pf0PvTbA1Q-1
X-Mimecast-MFC-AGG-ID: GFF_M_jBM_-3Pf0PvTbA1Q_1770727246
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBF2B180025C;
	Tue, 10 Feb 2026 12:40:45 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1511800464;
	Tue, 10 Feb 2026 12:40:40 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/3] Separate tests that need error injection
Date: Tue, 10 Feb 2026 13:40:31 +0100
Message-ID: <cover.1770723724.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 .../selftests/bpf/progs/read_vsyscall.c       |   8 +-
 .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
 8 files changed, 244 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

-- 
2.53.0

