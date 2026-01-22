Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF08354AFB
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083157; cv=none; b=MbTlLWOZY/vtGJ4XQiqT99QP658Xn1Dc9aDvrT9x3gaPTEH2DdNbPhgQsIqR2H057ha9Djc1+vMVswbSGfRy+wOCsqUhy0UgSsC6yPdad8QNtvQZWxIiv7rl4vMU0yQ9Kqt1eHJZsreuZ6PVK4IckU508m6hkiujTnIqTDteB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083157; c=relaxed/simple;
	bh=eva9DrrsK/241iLZFqZawDxFjcutxCR9wuaeQak42Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlNPShWgJ4R6j4QmFtAT7wGte0FRaafjBZpY06kX218NHPAEug4jTCVl5/GGYdpz2IsaTXyvqDRt7wSwmp3e2b+tO8fvmBKh7MHUq/Q9yGa7ywnmA+RkyN2eCjUxEYpTr6JmV4pUCTWVLpTk7bB7ewEpXHoBZLtOpZ0N8VvnWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpdxC7cm; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpdxC7cm"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so559748f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083153; x=1769687953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHQH2tuwsPtOFd3izFWcKKfA+oabkq2AYc4o0wR9UC8=;
        b=YpdxC7cmxJDfreFKQ7+h/9Fcqhq8Wuv+SZgGsHKerJRSMV9uvbFv37rKO0NSrE+58g
         A4Eyr6jksfLHhk+4D/OUXQFapcjbdlmQiQgLfGeWYdmyLIUu4W4pg7DMZzBFzhLWGegm
         znZ/2sqdOjImgxJbUG1B3tn7pfx1OH8b2+9ZJsJzhTijJoDEP1rc2cCh7u8DuhlEtxmM
         gUiWEzT52pSE87XudFMiyioZ1l6An2LvmAXIpjai1OQ19OHNTQStSExO9wbilyKdBmRJ
         ltVQbKxHNt+R7443D9NzcDHCPjIexOXbBEPvk0FzfOByAnBpeyE8IaFMv2VItftuFMGC
         ZUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083153; x=1769687953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHQH2tuwsPtOFd3izFWcKKfA+oabkq2AYc4o0wR9UC8=;
        b=XCUDEHIcSRJIbsrJ3glONp9/Jw9PV3ccLuH2GprHSJ7LdwIGNMAB2grQHixCkuK3a8
         zXU6dYoFz60d28OCsgIcRzTWnQ7GmgQ0nyb5wZLY2Z19v+rJY58UMs6vG3iYmk3Q3BCj
         Q/NdeBsU7cBld8cSyWVA1It/CyPvQF4xT96DMWaTPziQywC3ixFoSiR/iqvsmDraL+vM
         b5ZjFHixvzTMdNMIJgioTDW+nMbZgJnePrsqYjR/1hglxXj87lWiBSvXyhXqklqxOGyQ
         u13ysY0tGJ3S+cRS5rh+fNwylv2g+uvEKVoIam5o4M/2rHBIorbp9DC8FBsQ+BRaoZ7P
         1rRQ==
X-Gm-Message-State: AOJu0Yw1TXoy0enqaberxmh9XO/qrMyhhOX/MCRn9mVJi19vZfbuVUCN
	WBpb4v6wFKvrbi619UO4LkKFuY1MGAVy9MkTB8oRZXKNb3jKPK/EI+YtFSq/2pIbGXI=
X-Gm-Gg: AZuq6aLalzMsA17QAgHFFp2L6tye7veDBbGgK0nwFd2lDKQSjaa63EsGNsonZVqH7MA
	VuzhZj0x23IoMDdWzrhv4OjevhRoRLk6pgkos+Q2htIWLJOAOfTs8Lqo2ViFS6YLFIK3U8ImuQg
	DzqvNlgADl3gGjhxXmfK1gjKeDTVTx0StcvpxUZXhLCgTz158Q/kl9H2oJn1vkm1ylpr+mHtaqq
	+qAqnvdWLsXZzamQ2SmMudRvLFThYsHH5MxydILj1TzBTn8ZzPu/6+GlfrrLL/mO1frGC95wEZr
	Y0aCkECRH+9g+L2tJToJE1epYeNZv3I3P01sO1MfVZjZTS3EcuI6fVKrlgc4QwTVkBt5dFuvL6s
	z4Mvz8Lqj4J+ArzJdZ0VZ8HXTunL5Hbb9Ms78AIKZPj+9S4RwfSpt+LjSMFdSuakeUYiQ4uNRST
	kkaY1mTxx4rzaXm8DJbBSbYcYiT+poyS0=
X-Received: by 2002:a05:6000:2481:b0:430:f463:b6bb with SMTP id ffacd0b85a97d-4358ff4465cmr12988254f8f.16.1769083152939;
        Thu, 22 Jan 2026 03:59:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm46093197f8f.6.2026.01.22.03.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:59:12 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf] rqspinlock: Fix TAS fallback lock entry creation
Date: Thu, 22 Jan 2026 03:59:11 -0800
Message-ID: <20260122115911.3668985-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TAS fallback can be invoked directly when queued spin locks are
disabled, and through the slow path when paravirt is enabled for queued
spin locks. In the latter case, the res_spin_lock macro will attempt the
fast path and already hold the entry when entering the slow path. This
will lead to creation of extraneous entries that are not released, which
may cause false positives for deadlock detection.

Fix this by always preceding invocation of the TAS fallback in every
case with the grabbing of the held lock entry, and add a comment to make
note of this.

Fixes: c9102a68c070 ("rqspinlock: Add a test-and-set fallback")
Reported-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c          | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 0f2dcbbfee2f..5c5cf2f7fc39 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -191,7 +191,7 @@ static __always_inline int res_spin_lock(rqspinlock_t *lock)

 #else

-#define res_spin_lock(lock) resilient_tas_spin_lock(lock)
+#define res_spin_lock(lock) ({ grab_held_lock_entry(lock); resilient_tas_spin_lock(lock); })

 #endif /* CONFIG_QUEUED_SPINLOCKS */

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index f7d0c8d4644e..2fdfa828e3d3 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -265,10 +265,11 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)

 	RES_INIT_TIMEOUT(ts);
 	/*
-	 * The fast path is not invoked for the TAS fallback, so we must grab
-	 * the deadlock detection entry here.
+	 * We are either called directly from res_spin_lock after grabbing the
+	 * deadlock detection entry when queued spinlocks are disabled, or from
+	 * resilient_queued_spin_lock_slowpath after grabbing the deadlock
+	 * detection entry. No need to obtain it here.
 	 */
-	grab_held_lock_entry(lock);

 	/*
 	 * Since the waiting loop's time is dependent on the amount of
--
2.47.3

