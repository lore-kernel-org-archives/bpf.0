Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3B3DD51A
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484872; cv=none; b=drLjGa94DGFkRLZQq1NDj4rO8rkJE01CREzi0rrsTULHAZyj32X+u400E6k1Xq0soDl6wPNdQWlOBnpm90jHMpCoFoz6tHP9TlWgbqvOzoyJ2PaWT0l9PlZVoT72UoHIhJc4qYKxWiAMDSFZ4m1HCtL1v6+dDaINkwoTUvi8Ns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484872; c=relaxed/simple;
	bh=XBZY4Gwj7CXqfYp0kHxE8cO8SoG17OUvxwik+0BEjRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oizEM6aGJBt/RMbuEH+WltZlNkKBn/Kc47RyUYKWAfL3KfhfEX1NK9WT6H39LtyzASjzymXY1OGHr4T4u2tLHD5lYZC8G68gCqzTutuiucc+vBfmKAqgvmxT/yVn4O+XFo8grQNXwF4jXiRw1IO7BIYEMBK6eO0FlNbBn9p2v9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NjzlzlfJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NjzlzlfJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=htNYv4UAsC/JgWm9B91fCljuZnblj9pTPtIUHyVrDc0=; b=NjzlzlfJmBZoU3YltQow1jWTJa
	UH12tcPMMi8W7dMfKnxxrtvCHhKKDujeA7qjvOvMIBi7eigJt3sAzR8r7C0Cv5Aogjne4cWa0uv4r
	wtSbT+T2z4Xxdx6jcXggppjhY2Nd5dbXH/lE4vUlWxjuoWqqXcviVX3ey3XdFYMyskJdMJtACunzX
	R30D/Wz1opgU23WsGAaGmfFUBIR9GGsUtvMmxSb9mFbEU/pHzFmOwZ5JdCUOrTRbQmlauUN2FgSVT
	4wrxRf7qyVBqe5LM5KPgLl0nnUNoVFFucZNqHKEjPlma1/pfzi5GEm8Mh8yTLKhlMaHf17siJc1ms
	erVfYcAQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul2-0007Jj-2J;
	Tue, 15 Sep 2026 17:07:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/8] BPF LSM xattrs at inode creation support
Date: Tue, 15 Sep 2026 17:07:31 +0200
Message-ID: <20260915150739.284189-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

Many in-kernel LSMs store security labels in extended file system attributes
(xattrs). For these LSMs, atomic labeling during inode creation is critical:
If the inode becomes accessible before its xattr is set, it is briefly
unlabeled, which can disrupt LSMs making policy decisions based on file
labels. Existing LSMs solve this by setting xattrs in the inode_init_security
hook, which runs before the inode becomes accessible. BPF LSM programs
currently lack this capability, and this series addresses this gap along
with BPF selftests. Thanks!

Daniel Borkmann (6):
  ocfs2: Copy the xattr name in ocfs2_initxattrs
  bpf, lsm: Reject writes into the BPF LSM program context
  bpf, lsm: Mark the BPF LSM hook overrides noinline
  selftests/bpf: Test that the BPF LSM context is read-only
  selftests/bpf: Add verifier tests for the __ctx_out plumbing
  selftests/bpf: Add tests for BPF LSM inode init labelling

David Windsor (2):
  bpf: Support passing context output arguments to kfuncs
  bpf, lsm: Let BPF LSM provide xattrs at inode creation

 Documentation/bpf/kfuncs.rst                  |  23 +
 fs/bpf_fs_kfuncs.c                            |  99 +++++
 fs/ocfs2/namei.c                              |   2 +
 fs/ocfs2/xattr.c                              |   5 +-
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_lsm.h                       |  11 +-
 kernel/bpf/bpf_lsm.c                          |  26 +-
 kernel/bpf/bpf_lsm_proto.c                    |  19 +-
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/diagnostics.c                      |   2 +
 kernel/bpf/verifier.c                         |  36 +-
 security/bpf/hooks.c                          |   1 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  19 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../bpf/prog_tests/lsm_inode_init_xattr.c     | 399 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/lsm_inode_init_xattr.c          |  98 +++++
 .../bpf/progs/lsm_inode_init_xattr_budget.c   |  37 ++
 .../bpf/progs/lsm_inode_init_xattr_value.c    |  47 +++
 .../selftests/bpf/progs/verifier_lsm.c        |  13 +
 .../bpf/progs/verifier_lsm_init_xattr.c       | 245 +++++++++++
 21 files changed, 1080 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c

-- 
2.43.0

