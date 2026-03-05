Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18486346ACE
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724371; cv=none; b=NSeQWR+bNz4TEfbN69exualyyRC+xwmUbcCy2IK8s0082AYDQceSSCeR0MieJDd8yblE4CeP1rWO2VFt2l6N3iswASw5IB/QFVKtq7Mz37fGGXxYxFC/0ajFDbRnK0GryMIuMouEwtEBNofnhMACmM9boRI7yFNBFIlQxepiqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724371; c=relaxed/simple;
	bh=+n3U0vqZ/rUphlBnXgLJt6AnAAJvy/0RR3ye8CahqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dM4rrK3W+kh48BnUwHzvgK8nj190g0Yb7hyAzhIadzhMt53cNqcLTCwVDxFUn4ditQuZxSVzOBZUWl2CFA5Dksyvc0AECf1Olmx8VIF0S15IFOmF2jzgDturA+jNcxzvUf1Vg6ly98Jha17aDwJrl9nbRI4sGUbl9rTw7c48vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDbFNy6W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDbFNy6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772724369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pLHChNYKtJH0H5Z9NGXYmzE+sb78LzU6U5iAR5Vjt+M=;
	b=LDbFNy6W4/wZ4nYWNHHEXNh3qJhvAAT+A1h+oaqjEPdYC4uAhVPJULYP9eSEo3UljxMLBV
	+MgVmfaXisBk91D0B2WWr2AA2Q+Rf/MY7+ptJplTZ2idcqDELL4aT4Hof8RVQA8yiiX6/7
	Z2hyitGMH6Emox3uFtunp7dc04WViDQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-5CBnwvBMMzmJvV6QDg0ijw-1; Thu,
 05 Mar 2026 10:26:06 -0500
X-MC-Unique: 5CBnwvBMMzmJvV6QDg0ijw-1
X-Mimecast-MFC-AGG-ID: 5CBnwvBMMzmJvV6QDg0ijw_1772724363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED1F195420D;
	Thu,  5 Mar 2026 15:25:52 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 141F31800769;
	Thu,  5 Mar 2026 15:25:41 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/3] Always allow sleepable and fmod_ret programs on syscalls
Date: Thu,  5 Mar 2026 16:25:34 +0100
Message-ID: <cover.1772721009.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Both sleepable and fmod_ret programs are only allowed on selected
functions. For convenience, the error injection list was originally
used.

When error injection is disabled, that list is empty and sleepable
tracing programs, as well as fmod_ret programs, are effectively
unavailable.

This patch series addresses the issue by at least enabling sleepable and
fmod_ret programs on syscalls, if error injection is disabled.

Viktor Malik (3):
  bpf: Always allow sleepable programs on syscalls
  bpf: Always allow fmod_ret programs on syscalls
  selftests/bpf: Move sleepable refcounted_kptr tests to syscalls

 kernel/bpf/verifier.c                         | 79 +++++++++++++++----
 .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
 3 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.53.0

