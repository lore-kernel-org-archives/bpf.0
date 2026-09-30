Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C094B8287
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776739; cv=none; b=JJ5Duu1cjUYbwJEPgxh+irO5rAAWbIv+cFnocsRpUXlAjqdDRT/QvCNlPJccij6n3MDQ6IiEDFV6XATVfxUeBakYlm7pYQwzJyAKnLZiELvIX94dVWNUZnZIgVaHqbv1DDBiBtPbdMPxmbFSCe2ngRtgE/1sCLfqVSpNHnI4LHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776739; c=relaxed/simple;
	bh=JntZr9pmSOUg+ZaUxc7V4XN8+L3zHH3SeYEq4iA34Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR+ZpaIniwZXi9wAsdf1yMDOtI7zNgRvW70YSnnQdAXPhQaTnTOLuKV0Ku8TfywdqHL8iabWhBVKpmLe3jURYBAWit8/flTiwsLskFrPpR+ZezBRxoN4v9pRKAzG10Y9P0ubG3VAvWjuqx+3wzkHEZ7mcj1ZfpLr4zDZ0em+dSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WARGEQS2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WARGEQS2"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 240CB80A0C;
	Wed, 30 Sep 2026 15:58:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BBAE46HBwV2; Wed, 30 Sep 2026 15:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790776729; bh=JntZr9pmSOUg+ZaUxc7V4XN8+L3zHH3SeYEq4iA34Kc=;
	h=From:To:Cc:Subject:Date;
	b=WARGEQS2CY1JkUKUe4b1uxhrQR3BbeWAIDWi6Z/JBM1StxAjC1nlpVJ2wK8IuXTbE
	 jnERLp3VZl8boxkcdITMqjeMrJKhr5DN+VpkqPIg/Kvj7+js4uovDsm4LaAtkWchrR
	 VpzHeCrYdirc1p/EsLbxVdHKIWGkGhbusOHOfR96IHUA62I16fpTcOdTUC/b7qtS5z
	 qV0CmyvFDssw/UtSQYCvPQrVrnfUnDvp6TlpbUL257cUv/Z99H3o0gfOmv0Ar5okpx
	 sNWOX8GuVCwBjCv4qvCtjba/GRAE8FoA78cHAHEmQMFRQNmjb7TsaL/uCrYW5zL5eW
	 p1uuEUppoaFxA==
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
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH v2 0/2] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Wed, 30 Sep 2026 14:57:51 +0100
Message-ID: <20260930135753.1063495-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_HASH map, htab_map_check_update_flags() and
check_flags() are not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

Also for BPF_MAP_TYPE_PERCPU_ARRAY map, using the (BPF_F_ALL_CPUS |
BPF_EXIST) flag combination with bpf_map_update_elem() results in an
incorrect EINVAL error response, even though the flag combination is
valid. 

This series fixes the bug by adding proper flag validations and checks
and adds regression tests.

Changes since v1:
- Fix a BPF_EXIST flag check in __htab_lru_percpu_map_update_elem()
- Add additional test for BPF_MAP_TYPE_LRU_PERCPU_HASH map
- Add check for BPF_EXIST, BPF_NOEXIST combination in percpu array map

Masoud Aghasi (2):
  bpf: Fix incorrect handling of user flags by percpu map updates
  selftests/bpf: add test for percpu map flags combination

 kernel/bpf/arraymap.c                         |  5 +--
 kernel/bpf/hashtab.c                          | 11 ++++---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 32 +++++++++++++++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.47.3

