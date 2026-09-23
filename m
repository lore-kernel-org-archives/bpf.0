Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022A53A8A3
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190698; cv=none; b=Jvknh7fbpO/1rDDSFQ41x/JiVFJJ04lLoAJHflYUR/2Q/MxamMAphDKrCpSI8nG0+CJRSJb6JCt2w/TbhTbntLhz3elRnet5p6I/z8IfsSMmuhb2G8Wo+b6A5nsFWb3ezvNBSKWENKgJeOS5Cml+5EDzHYUUZXb6P4+AyYUhjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190698; c=relaxed/simple;
	bh=AED7TQkYd7F3HlwM7eBkonFJ1DMJ4CHbS5RM4Nstyuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJzh4MzmwO3ek+zu9f2HB4UF7GS5Oq412GH4LvOoTheIZ7GLcDtTaYdDV18TQzrLM/vm7FWXbhcyHkFL+K8wMuxO/e84A91xoNlvsDViUpfWJEwQVdg60kTTuy1UKxJNe5XFp0OsEWyil5eRVnEF+h13MUftFvAv9P4dts0y17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HnTAw94M; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HnTAw94M"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so7123915e9.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190694; x=1790795494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PPF47FSTm2EY3Qtc6BZU+R5yzsUTfFlDkZH0SEQwZvs=;
        b=HnTAw94MOBRGMi/Sx/aqamY2DbQeo0UQkuuR6OWNvMspYdAZRGL7B4v72DgE3K6MD5
         pzPfcs8oHTh0OsZ7WRJKSVbLz/zWoND53f6dOExe+xpqU6XncrLuueSw64nZqaX/BD+S
         c/FHq2ElrdSnaL9KaxTKU8Mo5nKQ8FNPTBcKs45Ef1we1x+6E7wn/WMCE/tcLAB8sv59
         P461tfNbJ1a/i0uZFaLMyCqVAaug8IFlE4ZAeMd8kxHazpVOjGclo23H4A6ok5khS2Y5
         1Xw3XPqKcJvQJYV9qX15egzXDHwV/IiHvj60phy6BJ8dCCSy9kciXYzSFXfZhMse4VsM
         Xhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190694; x=1790795494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PPF47FSTm2EY3Qtc6BZU+R5yzsUTfFlDkZH0SEQwZvs=;
        b=BaTHVg+ZGcRPvq94k2RtB3KP284YMTU2LcODAmGD5J1QybPRvCruAp/zZtgg8jzzy+
         ZH5OBHyvUmfS66tcLe2VxVG/qdnaJuKR3JQ/E3oguMWcgu/zMA8ycp07bVB7obOvlWZI
         yMgipjvub10Bw6vdWW+TeoOP7+Y54r1fV/ei1AAETLQyyuioyYoPc4VldOewBIolFxGi
         ZkpWw7PCVNR5B1keyrfbtJh/3Ycq9K2IapY+Dwf3ly7Hh9wrf6uDI1U8KQKpMiu4/3Bx
         XYMJa1BO/tvjP+CrO4FSuXx9m2v3BgPP0bQvyoAcaDO/sn9ooYHvw8hwf+2V8iJHtdsW
         4Qag==
X-Gm-Message-State: AFuF++n9PQzi/07tzB4ao7ObECYSgVmqTqOdquGu0rCqwLPAMNhEeedF
	o/vY01ROFrWF3w3qSmuQwjQBxrhtIvKG26ocEW2Dk9T3dzIifn/JzTsoFk+NmLhidgVwwphhUC7
	ofVifEtFnDA==
X-Gm-Gg: AYBFou286ebRY2OqmqxYU6ZXTzF6HOlMTWkVFllz0qdChSd1+CCuArE7oODo8d0GsaL
	G7I/s2+xD4dWQcX/6Mh+NFQxR8VUxe/XtbQnFIHg3+vQYJvOKQYC3qm2dVPeUvny8xU7Ogs7vuc
	iUzuaVDpnKVxjrhSvY6wyWlAY8DglZf+yoAauFmGGJVvOiMYdurKYbEo4TWtaDNydS7aiXhva4g
	SAb4B5T/cPqUN3qAgDwQEIi8wUrDOxfQgH6kqE4JOdkAL5QPQiyvy0QOvG/5Q1WqOA3/h9nrq/7
	cl71MVOKDrSzLWCbm1g+o+V9xzAz4R4VPZYGj04hHDMYg989oOhsnxAH2TZTK+ryqNANdB3cyO/
	mWdF1r/oY/YXEu7QNtpNYdOngHgvajOnrtatqoIZois91PMp0A/cCq/8WLuK5qoFVggF3ZJBbgT
	tbOWks1DBDCMA/U/cnrSzsaDfLaRY3wIqyHcBb2wMNMSnVf7RRNwwYTwRw20I=
X-Received: by 2002:a05:600c:1987:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49fe66d81e3mr2843095e9.15.1790190693494;
        Wed, 23 Sep 2026 12:11:33 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v3 0/6] bpf: Fix arena memory incoherence
Date: Wed, 23 Sep 2026 19:11:19 +0000
Message-ID: <20260923191125.5311-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting up arena memory for a task currently requires two operations:
Adjusting its range tree, used for tracking which memory is allocated;
and adjusting its page tables/flushing its TLB state. These operations
cannot happen atomically because their critical sections do not nest.
This lack of atomicity is the source of two bugs that can lead to
incoherence between different users of the same arena, wherein they
observe different pages for the same address.

Address the problem by more finely tracking the state of each address.
Expand the range tree used for address state tracking with a third
state, used to denote whether an address range is unavailable, either
because it is being freed or because it is being populated by a VM
fault. Use this extra state in the arena page freeing/fault logic
to ensure that operations on a single address properly serialize.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Puranjay Mohan <puranjay@kernel.org>

v2 -> v3 (https://lore.kernel.org/bpf/20260923061425.7045-1-emil@etsalapatis.com/)

- Rebase on bpf-next and resolve conflicts
- Fold in the atomic mark_available range tree operation into initial
  fix patches

v1 -> v2 (https://lore.kernel.org/bpf/20260902070239.16968-1-emil@etsalapatis.com/)

- Use __range_iter_next() in is_range_tree_set() (bot-ci)
- Move -EAGAIN handling to the patch where the errno is introduced (bot-ci)
- Add refactoring patch for (Puranjay)
- Avoid leaking unavailable range tree nodes with atomic mark_available
  operation()
- Avoid retries on res spinlock locking for -EDEADLK (Puranjay)


Emil Tsalapatis (6):
  bpf: Update is_range_tree_set to work for consecutive ranges
  bpf: Track availability information for ranges in range tree
  bpf: Fix arena race between page free and alloc leading to incoherency
  bpf: Add explicit state machine for arena free spans
  bpf: Atomically update PTE and range tree in arena VM fault handler
  selftests/bpf: Add arena allocation race tests

 kernel/bpf/arena.c                            | 240 ++++++++++++++--
 kernel/bpf/range_tree.c                       | 237 ++++++++++++---
 kernel/bpf/range_tree.h                       |   8 +-
 .../selftests/bpf/prog_tests/arena_race.c     | 270 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 159 +++++++++++
 5 files changed, 851 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

-- 
2.52.0

