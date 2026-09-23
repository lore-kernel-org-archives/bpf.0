Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059643F8B8
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144078; cv=none; b=OzUZYVbyx6E4+vCJzdYJNVXleuCgiHcC2t73NeWLX+7I3P9hzbQ8gnti+rpOWZlSH4Y1Co01hivgv5mXByk9ZtUQsSQNjYM5NusdX52RjxzsGrjmsjcbYK5NLjQ9Zi7gGks2cJ+DNY6O90xDErNQXfBptJwaesX3k3IlAo8kWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144078; c=relaxed/simple;
	bh=agAqNNUBYNg7b1wljCSqAF+tugBm7+/YdsW/rlGnqis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6OTZ1wq5yCwsLyoBqzSqB0GIRV9SbWisSgxNSwqwiK45RBKBDTwYAwhSlhXnkHFcVJCO8EdE+dFLo0neuVCtF2XNveivaqbGdd7BJfE5XJK7Az74o7CavSNaHpt4NhzpvECMFVEavy5PiQb8WZkb9GZ8S5EGjYFFRLWKOVYMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vJR3gEFm; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vJR3gEFm"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50d1b048eso433415a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144068; x=1790748868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLRKfby84+NJ1ZT9HYzhPYGPFrhk3GmlXO1Tpatk72U=;
        b=vJR3gEFmrMrNCoTYE2uCAGwp8FYG0B2Jlxb0CnXdCGHSaTDc4LibWk6CtoEPfp7VTr
         NOpCwemI8U7XDJsiJsLibLC6M+/lNh5Sk5lJXeDBWAZES4r82EdzMa6t7+qVtPsgj46E
         6P6OAl9aJIuYNbubP0sgnKTkeVe9qCqlTR9o1Tiu+EW0+4YHw3OqUkRqS2nameqtD5NM
         TIQBgxSmzqXjuR4JFyfoLwbfOjIYc6c2M4EukZfk3qapa2vPvd1VBAwp1evUarRxgilw
         dK0DSz3yhkkYBmVINIf981PfUMKHNescUdY+KVfzTbGcG83lMJ03DCniK9QI2t+tayVP
         p8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144068; x=1790748868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLRKfby84+NJ1ZT9HYzhPYGPFrhk3GmlXO1Tpatk72U=;
        b=QvELw4FFFBqmfEWm2jImkJl8PAaOcdx3x/MFy15rZLbB3IRRFq7tmrKWtm5futKGX6
         1HeSDTeJfwJVwZ00xnBV5lkN+Ir/zWdU3aNgXrkFd+tvv2XzBDj+plYwSBI9oyNq5sXG
         w/7mPFziDswkoVdli12Xn+s/kGWke64I2gq80nSiIHg0MWp9VpkzTl0e+RjEUXyrYKZA
         Itsm2oq3P1LqKfKR5OPPLkI8e9fsJDPLtAC2NRTHBu5VizizsMl1yOj986B79DLNid6v
         goZ9iKITw10b8pTocxjqhZRSQ2wn17etCjaS862QXD3vREGzOdbqJRmOYyspgvYHsZeU
         shDw==
X-Gm-Message-State: AFuF++njZyU4NIFcVlSJNV2Y8BLNtJVTtMvWe9kQ/99Fjy8qpgn9DM1p
	48UqtY7xvBvea+98mQvPM5BPql7uL3w5tncAve3JkDH93NdCKWxGyuXcruteJEOB/a+mcZvOwPm
	oQbefTB9e3A==
X-Gm-Gg: AYBFou3oxzVUp0CARJI//KGjhlyjs6zfUjIPNWW9AKnvSSQnEVJChVDMSNJ343+IaGz
	DkasJcM8qVolvGa6Di4+dAuZdu0cF5WrGOpIz8FU+hb7L2wgNMEKjZJVGtahAP40OxChFxMez6f
	EB/6ZNDSC/1KkXjRLn7XK/4gQXYnAkLnWFAWTpGc1+0MH59wyHOYWxDWB57fI9dP/B0zroxu6+R
	MkU5lIYrkNrHz8TTfRCIf+lNNkfm4uAhxE9L+9/RBQh3phP8ARDE9y2bpfMXjz95U5uJnz/if/M
	H/oRPv/hIjIHN0O1e3LOSJsvon59vJ0BYWzQdNUB9daiPpsyLHOC+59Zs0RotKhC2w3LfWOLa1N
	q4g6ZvH0FkmBHyRYlF/lR4x9XFhcmvQnMA1r9XN9TzwsAIlfI3/9XtAqA/9LWA9lRmltvgoEhwV
	D8Jw8oVQgPEKq+Z9xqmRpux/JSeDBr0eHXm5TImKnhNLfI5UN7Nh0ZNcdA2kgqvdKgI873ZXTlr
	7F12LruRXSZDK3xBpRH4q+ew7+Iury/3/H18r8xv4+7F6C/qn6t
X-Received: by 2002:a17:90b:1e0c:b0:39d:ec43:df74 with SMTP id 98e67ed59e1d1-3a07e4a253emr1503184a91.12.1790144067859;
        Tue, 22 Sep 2026 23:14:27 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:27 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 0/7] bpf: Fix arena memory incoherence
Date: Wed, 23 Sep 2026 06:14:18 +0000
Message-ID: <20260923061425.7045-1-emil@etsalapatis.com>
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

v1 -> v2 (https://lore.kernel.org/bpf/20260902070239.16968-1-emil@etsalapatis.com/)

- Use __range_iter_next() in is_range_tree_set() (bot-ci)
- Move -EAGAIN handling to the patch where the errno is introduced (bot-ci)
- Add refactoring patch for (Puranjay)
- Avoid leaking unavailable range tree nodes with atomic mark_available
  operation()
- Avoid retries on res spinlock locking for -EDEADLK (Puranjay)

---

Emil Tsalapatis (7):
  bpf: Update is_range_tree_set to work for consecutive ranges
  bpf: Track availability information for ranges in range tree
  bpf: Fix arena race between page free and alloc leading to incoherency
  bpf: Add explicit state machine for arena free spans
  bpf: Atomically update PTE and range tree in arena VM fault handler
  bpf: Avoid unavailable range leakage during arena_free_pages()
  selftests/bpf: Add arena allocation race tests

 kernel/bpf/arena.c                            | 223 +++++++++++++--
 kernel/bpf/range_tree.c                       | 237 ++++++++++++---
 kernel/bpf/range_tree.h                       |   8 +-
 .../selftests/bpf/prog_tests/arena_race.c     | 270 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 159 +++++++++++
 5 files changed, 839 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

 ---

 NOTE: This version has two additional patches, one NFC one a fix for an
 issue introduced in this series while fixing another. For the former, I
 think we should keep it as a separate patch to make it more clear what
 each change does. The latter is murkier - we can avoid the temporary
 regression by spreading Patch 6 into Patches 2 and 3 if need be.

-- 
2.54.0

