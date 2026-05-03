Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC92244687
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777843118; cv=none; b=pbLp7+3tBAcaoFHSKDGieq9bC9sjaoUavXq20H0sYCsT/LcM8Rbsbt3wKMeRcvH/uIknvauzSEpTnPte/9Ftu4mQr68slijKRYku0Th+jsaB9Jhv/Zfqu9tzsOn8oIS/9dmurGs27xVBl/4uVpoVu1SDIDvdwyCJTMEQQLkGkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777843118; c=relaxed/simple;
	bh=haN1sX6U4lKH6nUQoeLAygvoIHtzLbgJQI2ir///UcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1xWqUJ/wVx3rAr244+SQSzcKYDSwUD/9zzVtANPZTWQ8FP+AM9LNLz0E2Bh9lZyS5st8d0jOVN1JrziMqbbVgBGBpk+Au6SYK92pqI0j5w5zEvXlyUEj5Kb9lvFK0H4ywZtFCNW8iOZLqTWicSNMQyv62v6oJKovjoz41qAngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJRGytHh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJRGytHh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5ad864a6so39989001cf.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777843116; x=1778447916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nX7JRFIn+c55jasTYHXgs4OSkjxaNZAxpIUIWQNuYaM=;
        b=PJRGytHh8YtTh+RYk6L0ZB5bS7PGBGMCPFTkzqCwJ22yZLenTkRLQndJETm2XFxAfn
         Cs08efOfZAG6UEu+QUIZz/VIfLvTJP4Bkm95I9CcxeXGLt07BZEXoYJgLmESNS93j9+a
         T6zSAWCkkT1/yh2XdqJf0vNqeEH/uki7o90UHv2An3EIuMeoHT099StDoqAecLPG211J
         sq4dRqflDYhGHs1HRIubcS0jWQbCPQuGgbIogb6aM6JB/znu1RDbG2fI1xLGEhOKcSrU
         3QEnApG+5i+AEnqUcV8SWzwKTRELIzKfFeyAKAk//6TtnyDWyKiWJY9wXQHnsyFxIzOm
         RqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777843116; x=1778447916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX7JRFIn+c55jasTYHXgs4OSkjxaNZAxpIUIWQNuYaM=;
        b=VCdW+JYPA/W0YOAhfZqGiAIqZ6eMiCGXKvT5k0VRi+42OlZZntKIukhZEjnmPeVMox
         wbQZlb7gjJsjQArRORrWfCAPCTXiZXzgwEnnyt88Qvl+2Sud6iEkR/tsjH/3YImVXwNk
         RU9RxBQq1m75WiX9DHivQsxH/vePtX/TC6XJIE9eR/Uo+HBYC9ijHKhLFDkasOzbpaaa
         mN04ZFCLXxMU+fyc17hAQswfxHCGNC6W1NvWS8A7vlADVuMl9jlHfnJma4vLWblgvKZR
         ebyE2PZSWCI3UqKKKmhYgovZrCqeMLxp4XDzOo9Z4j2xHzcIbiZRnfNbrcigvg2xPWzk
         A1GQ==
X-Gm-Message-State: AOJu0YzT3ASQq/5SID1X/GN8c2S+4zgkBu4EBQZJUYNz4ItN8jToJe5Z
	H20frpeYbXP1vq61k3vJQSGjIuyECJGqWLy7AWu32NmASH7FzcF+KBWC/hJXyQ==
X-Gm-Gg: AeBDieu/Z1ZHcB9Wxv72VjmNhBfRSd8mmkTR/ZX40i2YZ7FJaG5uqjQWSvvdNqdM4Cg
	wXVfISp4NGAiyJfldsEVQL4CiPy8tTTsRAczkX+U+T5CeaIejuUusy7M4/3SUACyWpkm8nzc0yT
	elgLbIBqHIjey+eu1NuhBe9v4nOYYLPt+K/k2XNPlryd+6GtrJU/5sBRVS68mdsUDRIT+laQVBZ
	7vw0qD5vZ58N8UVyyqRsX2p9zuIkkXZPHBFeocoEtMNq5bHwJEbVUM7kJCk0WdCR5dohGPFlR8v
	eyd6Upu1Ca3k4CvvmOLyt1cDNQ18It3l0sX340j88xEZgiGBwMDDjuHnnB+MfaeLOdnECSNY7Zw
	wwlkNyuR5FrNJ8QD80ArOMv4sGk5h8J7CVxz/1LOZQH5TgT/R7udjACLWE0wrxtQNcVTiZ1htzU
	9wERjc7GCIgD6LPWR9lZ+e4IPHMYlaAm4w5hIc2ihcCeAd+S63uGugwUORalIoYODe9a7oxlize
	N/xNhxfhnSBBUFVvnKiDOxbLDYOLqQrppCqUtjwfpBv7iwQY1xe
X-Received: by 2002:a05:622a:1e8c:b0:50d:912c:c2cb with SMTP id d75a77b69052e-5104bf92bbcmr105928041cf.42.1777843116123;
        Sun, 03 May 2026 14:18:36 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm96146346d6.47.2026.05.03.14.18.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:18:35 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: 
Cc: bpf@vger.kernel.org
Subject: [PATCH v2 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Sun,  3 May 2026 17:18:29 -0400
Message-ID: <20260503211835.16103-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs
for inode_init_security hook") allows us to reserve an xattr slot
for BPF. Before this, the hook returned a single xattr owned by one
LSM, leaving nowhere for a BPF program to write without clobbering
an existing entry.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 106 +++++++++++++++++-
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 ++-
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |   1 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |   7 +-
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  13 +--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  49 ++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  32 ++++++
 15 files changed, 233 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 2ca6723a5f7b68c739dba47b2639e3eaa7884b09
-- 
2.53.0

