Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F7156F45
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775960852; cv=none; b=lFlfQYyQsY24FKePE7XeXTFM0ieL6obmXom3k+PpebcrHLLBFDOar3YNhnODZXGmdWk1v1CGtiwtr0hjtohm4OWzNYmanGlsenp1ZLBrZhTA1/YZLDI+GAnadrEPUiJJ+OouB5yt0Jsqon2mNCu3QCuh2Q7g8N1/SC1nHWRtEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775960852; c=relaxed/simple;
	bh=Dvwz5fL/chaWZYVSXrWRlSnf621Pe1UHp04zkvuWHN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pz0ULxva0A7qZwIZA93YiSAoyoSFplPcP12pu/KPtpI93W8EeJR69ledAOvse9z7raQLzZB/YRn8hGBf50QvW8MMBz9Bz9K4f01xpJIlbMVhXjGfAlXO4I6p+i1uCpWq+gyeiMrqaX54z+/3F4ZfVa9l6qEj/KZio6TY3gSW6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG5Ibzfa; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG5Ibzfa"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d832f2f44cso295390eec.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775960851; x=1776565651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ3S7jqHTcsrcGk0N1ROb2rw4SjQyHDlqeAL3db1GAQ=;
        b=rG5Ibzfahmq2wX6BU/a+5DG+4Eyt6okri/+mMAVnxtYAVqg/NaVmoR+uF2e107xGaQ
         FV1cHy8IARK2Jdw7Yi6Ektf+VKUNTqCkrrw4OEVlqRJ7LDaKSJvexLIr13WQl1CavPA8
         HA6qu5EXvADwBPyzig52SZQjbOd1Azg69B5HmW2DXFXLiS0aWFazEa/A7Fs7eXyClLbz
         cJgApLbSe0f+trj2SdASRJDfpF5UNs7tmmdBjSDeF76lRhKKL8605FvE8YugU8QqIgmv
         0txtou8JloGazXpK4turPCyEjtKPRT/xNVfzl+AgHIZ8hPiqsQxhVrL+7UrJqsBW0J87
         J3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775960851; x=1776565651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ3S7jqHTcsrcGk0N1ROb2rw4SjQyHDlqeAL3db1GAQ=;
        b=fode4+sRVn/zTar4yRF8XTbxgDmdpZea2tE+XlpfuM8ggLkZiPUruYuQop/Rv7c+4M
         ONgHXpxbEVm5qKGmka767tLihsDt3RjfgX1oYHMfzKIjuBuSrRmR5fKIJ3tYolwgvrG9
         c1CPG7bNpPkgozG+7NGF9liEHSIWbs9Mwd+61oPEQ2QbJYRWcvjy/DIFomtyuKn2HtXj
         JJ5VsbTR4KDV7mwevK30otkMcdoCPmr4qf9HcwH1gYKg07iCpHxlIEUMnNqwb0v9aUIJ
         D2JaYlMcg6ZA5SdbT2z26HWZGLx7y4ZytxE8BZFpjhBAvI+AMPvWdLqVGuXrYBXC6Lvt
         b/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnWiwd+/kQN8H13YbPH1ckfX9au3gPK+wY4DkMMl0dnn55nzSw5O/2V3LLindEkup/jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzznGxkQULYy8EExN1HQN+4daEo8W20XuDwA9KnGubenu+CWKgO
	kM8Fgj8EekhXusItL1fcCFiYIQktb+RNDw/gU3OCvaHPKTZoXah5oaJA
X-Gm-Gg: AeBDiettXs5cYfPhbeqL3q92MAlHrO3YR9x4vGIM6Tl6KfCOAdkPP+j+bgFg9Jjn9zf
	aiMXly+Mxo0kddd9Bw6NMkfMVy6OAdfsOITeTe6nzKnjizyiwMF44SDgAqTY40hxhkVtu8OGwx0
	980s8ZdAADNDkV1pxsZErjvBCBmpiOb1X86oEzVEdYtwWQqLy+GRenvi1xF4SBjim6sB+7hMK4K
	pyJtP7mcEQSzww9deu3pKSKF6mP8T+E3EJeIPVt3cZJJDRkdQDN4e7cqPYYLJIprlU4AXgX04np
	rP60VnJdjJNVDplG0l5q1XS2EnxBm7gY6nV7mweVhPp0bSMvVkPaXA+Gi5R53ZFMbqFg7yq062O
	5jXspS29TPY0I2APcAEwGW8AuBCRlxwXBwEtkm2l3pAYk5EEApUjXSW7f5f5AVg7rXdsw0F5/t9
	+9O19rA6057vPVVpw0vsxZkfmjM9yK5OduFBRHDenvYBZ/B3fWkBz6cVHQZbdHwwWmqnr+Z7VN1
	+VtyDg+HQ==
X-Received: by 2002:a05:7022:eac7:b0:122:2f4:b251 with SMTP id a92af1059eb24-12c34edee1dmr4492561c88.21.1775960850542;
        Sat, 11 Apr 2026 19:27:30 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm8757860c88.0.2026.04.11.19.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 19:27:29 -0700 (PDT)
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: Fix arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 19:27:13 -0700
Message-ID: <20260412022714.1955495-2-bestswngs@gmail.com>
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

Patch 1 fixes the bug by tracking each child VMA separately in
arena_vm_open, and adds arena_vm_may_split() to prevent VMA splitting.
Patch 2 adds a selftest that reproduces the issue (requires KASAN to
detect the UAF).

v4:
- Fixed commit message: OOM case description, may_split rationale

v3:
- Added arena_vm_may_split() to prevent VMA splitting
- Reuse remember_vma() in arena_vm_open(), removed HugeTLB references
- selftests: fixed copyright, trimmed comments, use sysconf()

v2:
- Added missing Reported-by tag

Weiming Shi (2):
  bpf: Fix use-after-free of arena VMA on fork
  selftests/bpf: Add test for arena VMA use-after-free on fork

 kernel/bpf/arena.c                            | 23 ++++--
 .../selftests/bpf/prog_tests/arena_fork.c     | 80 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fork.c  | 41 ++++++++++
 3 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c

-- 
2.43.0

