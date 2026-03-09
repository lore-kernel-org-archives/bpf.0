Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431138BF8C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055457; cv=none; b=hsJ/V9/y3r6NmaDysNs5yxWaabJc9vO/dr/jfwVsBqBsU9IFOG0F3UojvMmWw1cIzO71WNY/t2zXXukHu9u4ysPrMQhWeoZqFPpZPkorwETakim0QsjOBBVcYqtA4pua09EQm5/caXshejQiP+m/o/wr11ef32jMmzraDRxl7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055457; c=relaxed/simple;
	bh=eIALdGRnq+MjzDJ+8FySFac/UuYzVZY+jpJGYyDG0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz82KvKn7d+3b6vny60hJE6RdqZlVVVWXOPMBWwnldPwer3DyjRByy1MpKVtnZZ1xfOFQjMX9HvAxfFl4j8kjsgQ9SF0qLUoDrceUJe0vq2c9e42g3mjO5D4eK4H2BouxLLvsaNRR1ukRkEj8FbYSQC7KSeVXDteFZm1krHW0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9nfhL01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9nfhL01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773055454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOPpJNoREswPdcvAKaEHabVfipcjA6/xdw8+OzmItMw=;
	b=I9nfhL01X5kE6Qcq60kHnQg6Qc+AjJkmNfjonBku41TdUpwOEjVq8lz/rsif4NfE73pEKj
	1/GQG8ynIJL1/7LT428OWsPS9aw6TFP+I56+6/eUmdxAtSk1NJaEFhUFDCfAY4BiP6yGkT
	SL74O5VYS/Mrr6mHxX6hu8ZSHpFDGbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-nMvq_BJjNQ6QoY-XtfRNaA-1; Mon,
 09 Mar 2026 07:24:11 -0400
X-MC-Unique: nMvq_BJjNQ6QoY-XtfRNaA-1
X-Mimecast-MFC-AGG-ID: nMvq_BJjNQ6QoY-XtfRNaA_1773055449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004E91800365;
	Mon,  9 Mar 2026 11:24:09 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDECC180058B;
	Mon,  9 Mar 2026 11:24:02 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 0/3] Always allow sleepable and fmod_ret programs on syscalls
Date: Mon,  9 Mar 2026 12:23:55 +0100
Message-ID: <cover.1773055375.git.vmalik@redhat.com>
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

Changes in v3:
- Handle LoongArch (Leon)
- Add Kumar's and Leon's acks

Changes in v2:
- Check "sys_" prefix instead of "sys" for powerpc syscalls (AI review)
- Add link to the original discussion (Kumar)
- Add explanation why arch syscall prefixes are hard-coded (Leon)

Viktor Malik (3):
  bpf: Always allow sleepable programs on syscalls
  bpf: Always allow fmod_ret programs on syscalls
  selftests/bpf: Move sleepable refcounted_kptr tests to syscalls

 kernel/bpf/verifier.c                         | 85 ++++++++++++++++---
 .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
 3 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.53.0

