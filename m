Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875C27281D
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906995; cv=none; b=C9WpUl/wtaCa9nB8KqCG7aSlD2/8+wQ1FcutejtXoEpSNnHfInVBYr/RrT+j/T+ShG1QTbXI7ngukC/32gGWJq6SkCrUunz+fwrOOuX4MlcsCYYzb2/dm9s2a2A+DhSjEx9K3eSf9VlQV1DU42Dtsy9jIaJqwGp7ZgQHY7Bm7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906995; c=relaxed/simple;
	bh=zbLX9oF55Y2Thn7cThQdG2WaenZcAMJuQrFC+8dIYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrlAALiEm/yl4K9wz2vFRgUOkj6TRA625D59gHeSvbbdTbwfVOvNcSdWl/Ycv+Av1l2rw9oFrzsK5N8sPVv+HOJwL0AALYmZtDdO/VZE1qTAqPZsER/cSAmRt8K70xMw3gjmc1OBScD9OjRW6jmqnMdCcunky1RDtf9ko9ZEW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU0CXLoV; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU0CXLoV"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732165d1eso12534164c88.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906993; x=1776511793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXLgg+Ko56n/7l1+PxozJxz8G/OQjLxROq9f1VnpOG8=;
        b=eU0CXLoVVWGWY7uWzQieg+j76DtQCXlBVgSi0Z74UiarXqpv0kTpvXjeFXkGsavRoI
         ivys0/wqHOR5raxKPk0a7VX6eBoEoMSa8lqw/Uo/vw/nYNMNR+b2tI31NkynR4MP0t3s
         sZmjcNB/v3Q/Sb0lTr6fdAdSDff94bB0Jm+Zg1kzuKaq+GawVxlTHP1UH/T8a8iKDvET
         qEf/GySh/RScQMoIoz+fmgCwJHN06l0LLSxdkO42nuRdwG2Y8GniMB8k0r+k/7ZwQhk/
         jr60DR7PfIDVORpHssjG1jdD9fvdAOxC9hSHv1kdUauiZtdZS+xrF7XMvfSItpQJvX7M
         VSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906993; x=1776511793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXLgg+Ko56n/7l1+PxozJxz8G/OQjLxROq9f1VnpOG8=;
        b=nB6dEoBczmQa/nFNwlwojSJa2W1ZpKneldfUy8aOvGp7Xz8Wamlf1GEszUu0FiAggG
         0rXINg/JGEAcYjFXexOUiWuwAUv8+5i1IH8plhcbEYJnfYDiFtsx+rgaO2qwHOyOAaPf
         0/S6Wg2xr45u+9QMfvz+bzY7scD4rtHKCuba6eceYFoES47oDG0NqsHCWFjr1Ri7Blq/
         7VG9tIXvL71iOO6vjNHo0+Mr7htw1XnG39QgKw8VBhNb+2jc40T70ystNiz6IifHi+2n
         r8/WRkPLAVvOKIvs8GYHU2qq2OlyQ0OAGamIWlCpl57o0h5z6oVwnns1UGUZe+orU2d0
         sThg==
X-Forwarded-Encrypted: i=1; AJvYcCWSXHUEZm1C5EqGOFuZeh4pkdT0GFbSMX4Gt3txxru53WAAkNNc2jru6fIhMmWiUbkKkC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9B2g0KbShIIbnAISYmQMfqnW6jMVPhSqkFRXj+20Ew+tZoak8
	SyIUnYfFToyjvp89gEwMSDdj//gPMesDbMrK9L0Gwi4KMWUhMz/HKk5r
X-Gm-Gg: AeBDietmMNzTJllTcdpQVdeZbssvweV4YL2F+hBgCjYz2wjtGXbxNwfTzyjwBtC/tzg
	WiZIuyvneYmn004TXPVosq/0GrAcC3Th/vxLBWi+q6RY7tFcjcTvjlmZT4BNW0VCXdejQt5VY8X
	yhORUrD2Jyl8NORdM66gcs8xn52wVG6BLBdoVSnjKhm2iedW0sJmfLCTnP2fADMj8kPTqRxmmF3
	me2hjMK/kUZLCtlVHHbihRmVBNHNDDhE51SR1e8+2aHHOK5Dq8LPDlEOLezHmM7gVGF3VtV/4Ic
	dkfg1G38TlGFtLQFgxXhIxIIRGRJbiE1SMvaGfv7BrVnfJBqqkHrIGo63e5cL55gU9DL3/EKtIW
	hujwDO47HVygEr1Q76aM8INF648r436N2ya1Q7VdXAWmWTkeZn1G0BMN8GVW4xXdLnOYRIlZ/NO
	tfzSb9W0MXK4lWCRochNQH08KezGOKdXTs/Y2GaxvuPsdHjFxxIRW7PLrgwQgFzzsyWrxh84lAM
	oRxUGpGFA==
X-Received: by 2002:a05:7022:6b8d:b0:122:2f4:b285 with SMTP id a92af1059eb24-12c34edd852mr3655499c88.25.1775906993406;
        Sat, 11 Apr 2026 04:29:53 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm6379097c88.7.2026.04.11.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:29:52 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Fix arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 04:29:42 -0700
Message-ID: <20260411112944.1455470-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA. After fork + parent munmap, vml->vma
becomes a dangling pointer. bpf_arena_free_pages -> zap_pages then
dereferences it, causing a slab-use-after-free in zap_page_range_single.

Patch 1 fixes the bug by giving each VMA its own vma_list entry,
following the HugeTLB vma_lock pattern (hugetlb_vm_op_open).
Patch 2 adds a selftest that reproduces the issue.

Changes since v1:
- Added missing Reported-by tag

Weiming Shi (2):
  bpf: Fix use-after-free of arena VMA on fork
  selftests/bpf: Add test for arena VMA use-after-free on fork

 kernel/bpf/arena.c                            | 26 ++++--
 .../selftests/bpf/prog_tests/arena_fork.c     | 86 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fork.c  | 41 +++++++++
 3 files changed, 148 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c

-- 
2.43.0

