Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6830EF7C
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804481; cv=none; b=nv5iBiFcK2QiJq/UhE5o32dRRZwPD5VfwJRB/2pNo328vLGldjtB79gu9r9lngpWg5ytHhk0YktGvvkEAR6I6IUgt1xlbZwrssruWhVeOGkDjxdKPZGFLCdU7/5Ydc8TS+AGUNAd2KamVfNro6xthcu0/j/Sf1i+dqse6hn9e9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804481; c=relaxed/simple;
	bh=eMZPuTKtx0f7fBgijl0k1lNXhP8a6gCGTa7Njeh1AJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPdqwslNlSNgLG2GcYtrEXIpb0QTReaJYEvfDaPisyn5+W44BOMW8e2OX0rdd9An8x+BiE175aDY/qbR8/NT6rP/VZZ6NbZp3vwsDOJ99MOQIdSgoy3uV9afeoc6Bx5brmUGkRhYsw5RbzRhJwWdamUVF0VxNOu4XxUDH8spcuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FExt6pfp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FExt6pfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772804477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EMYfWbz/8nidgLAFeEufMsiToS1JnsQKfakXhiWuoe0=;
	b=FExt6pfplNAvy/aEhdYP7S5qLeQQsRJK4s1uocoiA2YcpKCdYUpI6Qnjtc98qBCW8CpUA5
	gOIoFJIjt1aZiyVjiU0qNNWRHMmlw3hs5s9C/plsZLDtMIaDirhDyOCKW/rkGlHjng95/T
	JarZGDGsOTh3qp66EiThiBSVCFnhJBs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-vMa3IRjDNhOH6awe7bF7xA-1; Fri,
 06 Mar 2026 08:41:14 -0500
X-MC-Unique: vMa3IRjDNhOH6awe7bF7xA-1
X-Mimecast-MFC-AGG-ID: vMa3IRjDNhOH6awe7bF7xA_1772804471
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EFB8180035D;
	Fri,  6 Mar 2026 13:41:10 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40E2B1800361;
	Fri,  6 Mar 2026 13:41:03 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 0/3] Always allow sleepable and fmod_ret programs on syscalls
Date: Fri,  6 Mar 2026 14:40:56 +0100
Message-ID: <cover.1772804199.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Both sleepable and fmod_ret programs are only allowed on selected
functions. For convenience, the error injection list was originally
used.

When error injection is disabled, that list is empty and sleepable
tracing programs, as well as fmod_ret programs, are effectively
unavailable.

This patch series addresses the issue by at least enabling sleepable and
fmod_ret programs on syscalls, if error injection is disabled. More
details on why syscalls are used can be found in [1].

[1] https://lore.kernel.org/bpf/CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com/

Changes from v1:
- Check "sys_" prefix instead of "sys" for powerpc syscalls (AI review)
- Add link to the original discussion (Kumar)
- Add explanation why arch syscall prefixes are hard-coded (Leon)

Viktor Malik (3):
  bpf: Always allow sleepable programs on syscalls
  bpf: Always allow fmod_ret programs on syscalls
  selftests/bpf: Move sleepable refcounted_kptr tests to syscalls

 kernel/bpf/verifier.c                         | 83 +++++++++++++++----
 .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
 3 files changed, 72 insertions(+), 17 deletions(-)

-- 
2.53.0

