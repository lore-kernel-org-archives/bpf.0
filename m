Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42B3939DA
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036752; cv=none; b=h5dQhpckUyS2n+xg/AwY97MMHwsqBvB7WJ+YjuzbbaJcPppp2yCPUd5qt8v+F+G+irFBCakxqSiYk2APafeUngbufOMIRp2J3k6+YqDY2u6eys57e8a6ms0/kQRratQ/H0162My8OOojMQOdj4nQgwfNSEsg+sXxtxnYwKMScbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036752; c=relaxed/simple;
	bh=pE57AZIv8StEXNnNoTc7avwcH1V5LswkC87aOD2fEpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NofD0bn2Jdu1InTstEo2rZ+XBoHVSSVoA98aFvo8qi6FFMwfWHdMyt/WT88DNGpJbRn1Bkg/dvuYSUjhKfNVDBgl3PX0klYvnKwnVT9SNH1uvTP/6JaAcntrvlGEyQoPvg+H/k38rcIjFkvwp07B+j+SwgsA7n9VwBZketkckaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKPP15lE; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKPP15lE"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef29c5561so3234423f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036750; x=1781641550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr+SU3sus1bvEp8jC99qtI2zm8iD9CvR4tXETMhNRMY=;
        b=gKPP15lEhh+DvpREku0bt8JJkw+QM5KxjpJaonCX16Phdoxa1HOWnkpJZcwT9KkMdu
         x1ZRs56g1VBAH30YLxyKnNbLegtu0BzB7HJU2QoYtQtEpKwr8eN0I2YoL0HJUdbhUwGG
         YAh+CgY5669ik8OeLKPMkB+QlRlAJTZ+zRZ+8b0XVABRtCsclDWL4pSyeMIJB5S3yCE5
         tiAUqH+IBQsas/sScpbR/avXjVfgEO+2RoCmHwlDOk/6UF5xT/+a/o5Mrb2UcqJ3+zd+
         6rfrXuP+BRrqjI0zhBYYkXn89seKAVJI+Obxieps4LkDGeTnvZLim0/w0p4cyrHql61G
         3Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036750; x=1781641550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr+SU3sus1bvEp8jC99qtI2zm8iD9CvR4tXETMhNRMY=;
        b=a8QJHdEX3c4e/IfDTmvSf5X2oUoZZohkZPcS7qtmGcnvX7dDjx4HxC28OcqBYt6HB0
         do9WA9Wqajpd9Nc06q4ncIvfbkNz55vkePmatM6iqYoJARPBcf4ApRBuXL+l8D5Eae9W
         DjmDtabP/4TpaBrXKcNd5SkTtDM1E0g5TFqXAN6WAebOsLqXfrdNc0+Y9zmAST+VfVyW
         qQs3CAcIL7xSs+x8JAX0anZtEFi+wQkaKQ12pJBoAJ1SEfh7zHVUHM9DI3Zz+y7q/mkX
         CN8seWZAyUJNzKMA7vIPLIhDQBW9ZvmW+D+2xVSicxxF19bVYCK8wOaB82XtYDLjLVxp
         LiWg==
X-Gm-Message-State: AOJu0Yz0VLgKsue9y/2fJmUXhOVDOTfHJjjNSR9Fcx4yx1wSTbtEEYFD
	tzXtdR5R2L7GU2TdgJHvMgfhXstNvx+wSXHdIPgavpQyh2pS4BkJFiksOLGKuuw9
X-Gm-Gg: Acq92OFivuQohcSGhrbCHiLtkIsD1bGemUEYjpJ9OIydCOfpwqvcXybKNoo/qZ7Atiu
	bZliydaJJqnEWPitcJTFgG+DbGRYLjUDDDku35c2wyaPfFo7+uPqhh5oWVJDOdjuf7iE94MW2Xw
	dzAhWy9XFU7xfhSG5UNz34JCrYneFDy3aUGEPHFJ3+EBZuqDIxRAYHKCeFj2T09MzZnicYWGkeM
	tOmJPMK1e8mkeTJO8wShun5YzZNog1Jhlu5oVd/qqju4J4X0J7p7mfpzbcDLE52FH4Idz0X5XZI
	BC9K/JqkQCRkG7rkBu0TZjrsQvrzUK4DyIw1q7GbqkD7sguYiE0CHg0ZhP/EEl4uc2LOjpOabVI
	jyrourVcMgXGnrkC0emVz64gkhOOxswVqF/NcYziAdxxBQEBN6C7mXqa3xB3tc7gKfpQqTP8juu
	4ZmnS8qRL2ms0zBz4TCvZsDw+qHFsvyZd4JQEICbg6mQ8scQypVenRo1HLLRu3iF1/xNbvcI/0y
	hOv+bRZeSuizo3I8QYkKuH+qmrwv30c6OAU9T4y+eJ9Vta+qqIGLDyvrie7NnB8T+knP3+yMjPt
X-Received: by 2002:a05:6000:1211:b0:45e:f073:d2fc with SMTP id ffacd0b85a97d-460302e445dmr23277516f8f.11.1781036749750;
        Tue, 09 Jun 2026 13:25:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm71442116f8f.5.2026.06.09.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:25:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/4] Fix kptr dtor deadlock
Date: Tue,  9 Jun 2026 22:25:42 +0200
Message-ID: <20260609202548.3571690-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; i=memxor@gmail.com; h=from:subject; bh=pE57AZIv8StEXNnNoTc7avwcH1V5LswkC87aOD2fEpI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUujLJZxE8Nny4shV4rTFRduba7OnsA3U0Wz/av0zZh7z 6Q7rt7qKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQuf2T4KzvXcK5085rGE42n b39TN39Wvf1a8H19rm1v4t5dtdm8KZ/hn/6k+PuZP1+mljZnrTu5QkpvOV9r0vGlR/Y5GJ133vl qARMA
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
v2 -> v3
v2: https://lore.kernel.org/bpf/20260609093719.2858096-1-memxor@gmail.com

 * Replace bpf_obj_cancel_fields() to use bpf_map_free_internal_structs(). (Mykyta)
 * Fix CI failures.

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
 kernel/bpf/syscall.c                          |  5 ++
 kernel/bpf/verifier.c                         | 17 ++++
 .../selftests/bpf/prog_tests/htab_update.c    |  4 +-
 .../selftests/bpf/prog_tests/linked_list.c    | 33 +++----
 .../selftests/bpf/prog_tests/map_kptr.c       | 66 ++++++++++++--
 .../bpf/prog_tests/refcounted_kptr.c          |  8 +-
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++-
 .../testing/selftests/bpf/progs/htab_update.c |  4 +-
 .../testing/selftests/bpf/progs/linked_list.c | 71 +++++++++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 20 ++++-
 .../selftests/bpf/progs/task_kfunc_failure.c  | 40 +++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 ++-
 16 files changed, 421 insertions(+), 61 deletions(-)


base-commit: c15261b1bba0bb7921552cdd86c8b0202697a8f9
-- 
2.53.0

