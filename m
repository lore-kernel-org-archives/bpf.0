Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B282BE034
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997844; cv=none; b=Wmgctkjh/1TnGLB0+58Fo2A/wlczjE2NQxloJAvs6Ls9mxASvD1htMlddBGPWVQWE7ZrabkYJ4qmVzKu8rzt0qtEp3CABniW4MC+AcU8eAK2UqEAqVhAzzOa9y/WrsVAJG23PusHB7Mt+sO4CB7WvLinlBCGGUXBTXf9R952WhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997844; c=relaxed/simple;
	bh=MCiXQ0dABCaBfrYiWdwHuYpT6QHn7wrzuD9XpbOrLSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOCpLhzZib3e0PjqDSQ+fXgfkfk6VMdI16EIMyOfygYqzKrORU4KAUzgp5dMuHvJ7yw0hxv4eplZ1Etxzam8CARD3fPCiyE6Vocj3GzzBuRVTUnDyz2funbGfbbaWKrLhZNrJk4fKw1Edlry0/R0lqsvnmszBdKg++R55R0VBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWlN5WXI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWlN5WXI"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490b9318997so38664745e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997841; x=1781602641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfJ1D8Ow/VrksajB8DqtLlu7BzJN86BBLF8kad/MgEI=;
        b=VWlN5WXIe+0VbeCLvBKJI6l9KbVFu8tXziyQGgtRkiWukjXlgsCi7CTL8PRblitrmi
         HgPlT5KHDAF8L0rPcZWTI5bQj/1zyGTIfRbQ3FDFkfFT0L30Ku7UUFTNsMWrTc4dw1ns
         wUs4VFlJBRazO62t/RhpPcsXKKUSTvfAwVcod1kZk6Xhiye7jl6MBZwdLwuGX5RC1MjD
         lbMRIE00A5THtncotvqF8QX6CgbGKQUtFJJagBYX8B34FGsMwBUxRXl1kNLOGLk3GEVU
         JLtP4t5LeXNqjpCIpGE8UaXCccMRwrt2OJg56wa6iA1KMnaUSGxcps5yZNhBcHTM5miZ
         xpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997841; x=1781602641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfJ1D8Ow/VrksajB8DqtLlu7BzJN86BBLF8kad/MgEI=;
        b=ekmCEi5nUCckbQcMir3Wfa7eSb+xZz9iItBj0w0/t10k8YZjjc++oA38+saEaSkY91
         DkobkGhC2YXF1WF7JSIXc/NjRU+Oe/LsK+F9y2VoyjYUOoHCFFXcfAcikKu4uDbXLcyE
         Cdsrdgwje1uasPUQ8rMyStRZRpPHdeEpNWOJkuziA3aztAKReZ3zjmPA3MIaDpz9tyEB
         UIkffUdKz/4Pnn1/DUyn5BjSCsY0pytymXH+mVFwfqAJOgh/+RVtKuLJJ3+cZ9UJJJoQ
         l9n6iHO6gevRVzpuMg7UZWB5KbVvw1DB8fCaFxkm0zj5C6hmLu7sKdV45FScZQmP+9Ai
         /u6Q==
X-Gm-Message-State: AOJu0YweCFqITz3Bekvl9rlC1hCB/QRDXFxyA3pGHMgbS/MecCo+eP4K
	B4MW3ZO+fgcvr1Vdq04gk4xrz0u4w1Z5Ehsp9tFfJMGKE6b3XqsfsOPQ1SuTtrIG
X-Gm-Gg: Acq92OFZEey4XK1+hueGy2SCNUAaRBFZKw5XaLs//nB34KlQ+tB/VNqkB1VjBw+ypez
	WRVetWDXkb8rb7MG1cBY4vhw2F1Pn/Hy5yWqXlEy3e1e7QuoRUCsU/5PlhD1G3kJXXwVya6Zu9F
	ZANoIcL1a3qKECzaO0PlCrrVRr88mkYZ0oX+R1u2aFuwMilarng8EX4QbNb48qucp6lusXnt1Z7
	x5SI7/Vl2xAnFHLGlzb1w5eIrNxcHOdsr7QKXZF0ceXboD5XtasOoDeVuRA59UbZ+bxeQ3jZjDP
	pb/Hke6DszCBdO77KR4wUPPnG5UwqiOKMUV9UoTpws9Bqg5fbcB9d3Yz+1fJjVCKRPb0zHB4ykn
	f4QMsvHcP4BwhRZmYMEuFlgG6mUjXAPAPOeRYqVpIOnJfdPC/hREZTJQXo/Tu7jEyx8L6UAcn3m
	d5o4bXYLGDbiaQDJCDEEWO05sJd1ONwJmROPYY9bGOSkr6rVqtBo4XQlWW9+tRqsAx6TnptoWa0
	NVNawAy2aw3VjZMvqYQZ1zr+Vsg92iAWlwquG000mossMfDlAL17tLWduzsREbdwpuzNe4R4GIU
X-Received: by 2002:a05:600c:45d1:b0:490:b9c3:6c62 with SMTP id 5b1f17b1804b1-490c261007dmr306278505e9.28.1780997841037;
        Tue, 09 Jun 2026 02:37:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm63960115f8f.6.2026.06.09.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:37:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/4] Fix kptr dtor deadlock
Date: Tue,  9 Jun 2026 11:37:13 +0200
Message-ID: <20260609093719.2858096-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=memxor@gmail.com; h=from:subject; bh=MCiXQ0dABCaBfrYiWdwHuYpT6QHn7wrzuD9XpbOrLSw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUv93oqiw5d3dS9g2bTCy6BuUuQSkwo5G6mCjxdOfFumb yHZk9/aUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl8qmX4K//KilM3rVv6g0rF bBN2z/s66jN//wg47+b2ZuXnEwvOWTL8M2WoPe+V+DLmv/yuBMlntTX/f1bJX6wOrd92aOn1RZ7 buQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Referenced kptr destruction can run from tracing/NMI contexts through
bpf_obj_drop() and map value update/delete paths, reaching NMI-unsafe
special field teardown and deadlocks. Justin reported the issue and
iterated on fixes in [0]-[2], and also confirmed the bpf_obj_drop()
reproducer in [3].

This series rejects unsafe obj drops from non-iterator tracing programs,
limits map value recycle to NMI-safe field cancellation, and adds
focused selftests for the obj_drop(), NMI delete, and recycle teardown
cases.

See patches for details.

  [0]: https://lore.kernel.org/bpf/20260505150851.3090688-1-utilityemal77@gmail.com
  [1]: https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77@gmail.com
  [2]: https://lore.kernel.org/bpf/20260519011450.1144935-1-utilityemal77@gmail.com
  [3]: https://lore.kernel.org/bpf/agyG3eQwgmoJwmj2@suesslenovo

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260608144841.1732406-1-memxor@gmail.com

 * Drop is_tracing_prog_type() fix due to compat breakage, revisit separately.
 * Rework bpf_obj_drop() fix to additionally reject non-iter tracing progs.

Justin Suess (2):
  bpf: Reject bpf_obj_drop() from tracing progs
  bpf: Cancel special fields on map value recycle

Kumar Kartikeya Dwivedi (2):
  selftests/bpf: Exercise unsafe obj drops from tracing progs
  selftests/bpf: Exercise kptr map update lifetime

 include/linux/bpf.h                           | 30 +++++++
 kernel/bpf/arraymap.c                         |  8 +-
 kernel/bpf/hashtab.c                          | 32 ++++---
 kernel/bpf/syscall.c                          | 27 ++++++
 kernel/bpf/verifier.c                         | 16 ++++
 .../selftests/bpf/prog_tests/htab_update.c    |  4 +-
 .../selftests/bpf/prog_tests/map_kptr.c       | 66 ++++++++++++--
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++-
 .../testing/selftests/bpf/progs/htab_update.c |  4 +-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/task_kfunc_failure.c  | 43 +++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 ++-
 12 files changed, 332 insertions(+), 42 deletions(-)


base-commit: b9452b594fd3aecbfd4aa0a6a1f741330a37dab7
-- 
2.53.0

