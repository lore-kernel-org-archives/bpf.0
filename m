Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B30471425
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461324; cv=none; b=XwAjHyENp8mJGcwBa1ipbTRIMm12Y36BIoNp+WNvh8B18r6BTBYhzzb2OOniZNAH4owlhhNb55UvUzOiS2dOYuh81lRvQGmdfipYACnkfLsnZ7PQ1ZIDQOPFlSDqDOhhvSHg1vqBaUCB8BNOOXqedTNj9HLluxNb/h/24nrMvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461324; c=relaxed/simple;
	bh=TgWD/YVe2OdwJw/b6+/AHa8KA5h4kfvtjtxeWy5U0NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruuTPn7EDm4udl2qCuivqN8uZ6P6vRhsyLeLHW9C+UVomiRENigIRH6y8WVkQ/UIye29kMFOWq/sRMuFfHwGJuA3XzfYYWH5O+pIDG6hXGlXNMmWCIxKmoWXJtdcXm+kcTLmNSl0rAHZkxnHTayMb6zMigUmkrLdJLsW5pbu0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MtLc9iu7; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MtLc9iu7"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 89CCF80510;
	Thu, 08 Oct 2026 14:08:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nA7sIDof6KTn; Thu,  8 Oct 2026 14:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791461318; bh=TgWD/YVe2OdwJw/b6+/AHa8KA5h4kfvtjtxeWy5U0NQ=;
	h=From:To:Cc:Subject:Date;
	b=MtLc9iu72bNMpypafHU+uECooPjkwAC8oKLaJUVW5Hm6qxFxeJKfQhtvOxO4/vvFt
	 S+HuyHwc3k7+6J3en7xUZs6XZzHE+JhOsoC+SNXQ/RqM0A+vzwwmSiGxqHqrkkdY7I
	 6J+wUQTnRwc2Qe3AXd+/D0I7NYpszBvtLn5vA4HWS8YR7nb3HSvFsF+uOJJV+Bz3DH
	 LxDfXtd7WlZqdq0/02cJNvCnKy6uBh2dsXRq9/WZ5EEmg5rM75dOX6KVV49y37FUg6
	 pXJgf++MSLxds/QBSB/pifvwR5UZDWj3eREj6pVL6XC3FUf0fEnjh/yNk7yGyaqu9k
	 CQSkuZFaiodRw==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	john.fastabend@gmail.com,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v6 0/3] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Thu,  8 Oct 2026 13:07:31 +0100
Message-ID: <20261008120734.1565972-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
is not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
in some cases.

For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
htab_map_check_update_flags() and check_flags() are not considering
the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
with (BPF_F_CPU, BPF_F_ALL_CPUS) flags. This causes the
(BPF_NOEXIST, BPF_EXIST) flags to lose their effect in some cases.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

This series fixes the bug by adding proper flag validations and checks
and adds regression tests.

V6 changes:
- Improve the style and structure of the selftest

V5 changes: https://lore.kernel.org/bpf/20261006084604.780456-1-maghasi@disroot.org/T/
- Simplify flag validations by introducing new macros in bpf.h
- Add helpers to verify the values after updates in the new tests
- Improve the style and structure of the new tests

V4 changes: https://lore.kernel.org/bpf/20261004111007.3216186-1-maghasi@disroot.org/T/
- Edit selftest to use proper value_sz in the new cgroup map test
- Edit selftest to pin the current pid to the current cpu for LRU map
- Edit commit messages to include user-visible changes

V3 changes: https://lore.kernel.org/bpf/20261003160213.2641506-1-maghasi@disroot.org/T/
- Split the fix into two separate patches for array map and hash maps
- Extend the selftest to cover all percpu map types
- Extend the selftest to cover all applicable flag combinations
- Extend the selftest to cover the unnecessary delete issue of LRU map

V2 changes: https://lore.kernel.org/bpf/20260930135753.1063495-1-maghasi@disroot.org/T/
- Fix a BPF_EXIST flag check in __htab_lru_percpu_map_update_elem()
- Add additional test for BPF_MAP_TYPE_LRU_PERCPU_HASH map
- Add check for BPF_EXIST, BPF_NOEXIST combination in percpu array map

V1: https://lore.kernel.org/bpf/20260928102821.995214-1-maghasi@disroot.org/T/

Masoud Aghasi (3):
  bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
  bpf: Fix incorrect handling of user flags by percpu hash map updates
  selftests/bpf: add tests for percpu map flags combination

 include/linux/bpf.h                           |   3 +
 kernel/bpf/arraymap.c                         |   6 +-
 kernel/bpf/hashtab.c                          |  10 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 254 ++++++++++++++++++
 4 files changed, 266 insertions(+), 7 deletions(-)

-- 
2.47.3

