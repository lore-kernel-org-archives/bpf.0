Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9230288AD
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248972; cv=none; b=uZJyX2Ct+SJS7gbsaA2LvoEHFKJZFeJsshxmaR6tl75MEX/aGbtWlqkBB5GliURHnQoHOUOFGguab8EUCuujf0ZQORkbFPzhmSWzctJIugc27dFpSdtekdZPJ+21zxEvkJF+Ljp41/00Qk6rIj4fxQWLE8S3VhjaEJegNm+dQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248972; c=relaxed/simple;
	bh=z7MLazaduib8g62VIW1d1g15kxvL62ovQ2DG9o5FWwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVhm5ueoiJhUqaAx0iZ/5L6S2dV7H0kfSYqUK7+UtVFXtK3rlE5fLzqXkZHGsxIRhzLsw6vm0u0juCA1aGwsjRKNERMc3ib2lROU+F+FwU1CzvpmLzmmAxqq1K7gN/K7qA3uJlJco1bkhoGWwR32P/iA4Km6UnzJvZtT+gMVwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXq2oR3e; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXq2oR3e"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3bae8d3eso867621485a.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248970; x=1777853770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGj5DT8UeoevfbQnuxlyLFrs/iO3+u31kGkBrWkvs+c=;
        b=mXq2oR3eSy3p63WXYunDvL1ad1iYVG/UdKuIR27MNf/AmK8LdF1VlkkL/imIbEpi8Z
         Bfpz3DKlqzSmv3l+ekeEOcuRAO5ZL6fY/9GmYxckopJnuUxag3XTNFgNdqhXLVx2tSSV
         SwO4EnfpA4X9bZzKd/irKCjEnRP3QogTkj6wyHB0lRBJQOFjW0mrOaICvG73SDOUWItn
         Fanz2wALE4aFPWhfRFFtngx3q+F7tKRXsAoyoJ1DTw+qrmvuS3F3zbJ6X7JvVAteiphY
         HJbIBmu5VUS+0aEcFf+lggZFeK7zInn8afhvxV1ByahXNJCAHcwYn12t9ugG71B8swaP
         mPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248970; x=1777853770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGj5DT8UeoevfbQnuxlyLFrs/iO3+u31kGkBrWkvs+c=;
        b=dDEU81VcYeaOxePfGTAhxwANSJc8ABHuqpuj9ZvV+Tm9H6bzFvU3qxYpmyKUT0+tYm
         prbiwXzzQLviy/ywr6nAjNqSgefSBrsDDrrqxKvnLalzdLByPhitoZGYVgEwEG1bL+Ye
         HGrKvsjgaoEV9QlVe0b8hLhhp6Z2aHfitlJamRdqAUSwfCENTwuZVZVu4pxXrG8xlf1J
         Qt9tl4VDy4RdhQn3vA/jKYHZVayH3zet2mbK8FvvVg85y3IRrUpMsZBvgQ88vHExBI3g
         qlnWDuiWEXljR2/KD/xlTuG6s2NmNcyieD9U3GB5oKoCQtL2I0CLpOZLtHtYTg+03h71
         EYLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bmu6q6fG+Dm84zKfiJNqLpxzjYO2lOQbhjBJYRzwlk4/1CMtOJjJsN3WGOySY41T1CW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKK00rJmwsmVy1CWC4tzYms8i/To506+pIrjornby5PvUXWYfG
	tCozINMOxvdCNN8sw6J4FAjLr6sLwr8pMiD99VAcJ6ux6ODIB8NDIq5eASJ2Hw==
X-Gm-Gg: AeBDies5CICzS6B8jgJg4E4RBaZ0Gomf+bg/fhTpht5bGCMX2Un0JnZHWK/6Y5bWpKr
	O52EVzL2bGjBj1vDfUzLbgLGvfydKeZYOtQHaxZa+5UxIUU0pqBFARdfBnplIcKth1ghb0ghvTG
	Yl9pXCtgVsWHmJLruRdAx+ayXDz0YM+RxBVi0BJnun4P476IeEpKdTGFkBUwzJ4JPgzF8kokRVt
	MsMKpEbKXNXgTKQ/HVAE36VZ4zZrCrHhDm+83sR1ALxYsEDaS2XgM5yqqIFkWWRMSiY5v1OC9pM
	3tgSN2xT2fz2nrtk1Q9RKEnVpxHaLbFI2NdmHKluIrR78u8t0O5wJQLL3CD2p5djbiZ9N+2OndM
	Y9nZJp9cU84FJdLsXBKfyGdCLSTJMK8vUp+b/fkHR4zvOX2WPpkYAl0Mm6iIEbTL7KfSQJLnrCv
	cEU6b+IDYslTGU370+P4PnzIMZMofjp8AufnMUMPDPYVtTuCQs8LUSayuCnQYp7dDoNeo5OWwb5
	5YZnWC7iUhHL0KGOG1XGlydulNJ1RyjHxlRM6rQyrDN9/M9itQQ
X-Received: by 2002:a05:620a:4623:b0:8d7:a015:5dbe with SMTP id af79cd13be357-8e792a61cc3mr5861434285a.55.1777248969886;
        Sun, 26 Apr 2026 17:16:09 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d6ba19c3sm2464025485a.21.2026.04.26.17.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:16:09 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: 
Cc: David Windsor <dwindsor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Sun, 26 Apr 2026 20:15:56 -0400
Message-ID: <20260427001602.38353-1-dwindsor@gmail.com>
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
cannot write to, and existing kfuncs like bpf_dentry_set_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the hook's PTR_TO_CTX to access xattrs and xattr_count, and
internally writes to xattr_count via lsm_get_xattr_slot().

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 80 ++++++++++++++++++-
 include/linux/bpf_verifier.h                  |  3 +
 kernel/bpf/fixups.c                           | 20 +++++
 kernel/bpf/verifier.c                         | 54 +++++++++++++
 security/bpf/hooks.c                          |  3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  3 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 49 ++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         | 32 ++++++++
 8 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 6c60b2dd5a7889a583389e95e79689191206f86f
-- 
2.53.0

