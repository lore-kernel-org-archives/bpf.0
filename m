Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197B41A794
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276438; cv=none; b=M7sd2Gwfo2HFfIguI+7xLa71mLCKbarKKjIqzEiufFzSBvgkYpapT6vhrzNP/REmHH5R6JhNvVXr4ENakALLr8V/zpTqT7E376t9yl7VjTrsWMYyXc9kQJ23X7ishq8oLjzUuyD9jBgKUxI9ylqrcN950WTlCMvRJ/irgZ4ONIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276438; c=relaxed/simple;
	bh=GjNxk0AeALHHWoiii/KFIeT9bYeY17SP6MHvcQJcWIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EneVhYWTldFlGZ40kzPlLtjU/MymezbsG8CKtTLoCbfcbxW0Scjo/HIfFCVteUkLMCVJqEgAvoduq7UGnYtpEQ3TNCkzmNgzU7jSJvhxet2R0fjVdNA+2endFAddY4gphIWXy3K9hvDdqAVDfisPKffpqpvGFsRmBlBtV6lLqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZnBSlmg1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZnBSlmg1"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1145782A47;
	Tue, 06 Oct 2026 10:47:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctoJuRL-Fpnq; Tue,  6 Oct 2026 10:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791276431; bh=GjNxk0AeALHHWoiii/KFIeT9bYeY17SP6MHvcQJcWIw=;
	h=From:To:Cc:Subject:Date;
	b=ZnBSlmg1M4AcIuZY3SSlR3Z1qc1SaqaVhva01ZcrlnIikUUiUdouNATLFkT7Bw3of
	 WewppA+hZ31EGPXetxPNXONDkgeVV/i4sPebf/W2LHc0mRm5YzYXnG2lSJRXpec8bN
	 uZ+4yQFFRxwpgKADxFKd2iD5a4NrqV3Fcpf/Vi3pdohhBbhrtQrCnCH7WLdtmRD8Jq
	 G9dm6WKtgA0pr0xn8FE/u74hmcM1SDt4OoZjUG94xbicbC35WI7yLysE5LGTxwkpLC
	 G+2+F0yJcIZlYWJ64fiYLIvP64Z4w6N83xBbsZXamoK6rfMtBaaIIAsfMxquD0MpUY
	 ZnnwF/QE8Tbaw==
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
Subject: [PATCH bpf v5 0/3] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Tue,  6 Oct 2026 09:46:01 +0100
Message-ID: <20261006084604.780456-1-maghasi@disroot.org>
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

V5 changes:
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
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 249 ++++++++++++++++++
 4 files changed, 261 insertions(+), 7 deletions(-)

-- 
2.47.3

