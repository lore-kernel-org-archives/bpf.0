Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28F360EF0
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112270; cv=none; b=brU2O+CU92gOtVswogSYCZmFk1hRrYz8y5B1IkIbJg0BGfelqeaejHnT7B/+wK0PjvA4CYQ/mMepKur7NZxBj1FRlx/psPrcTjmweYMD4xpp7qamkw4CRGrQo0F89DHro7rIanfNu8xsnbl1dkEO3eqwERChA+2qxiqWnFMG1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112270; c=relaxed/simple;
	bh=U+oXcYrJjbhqWpBJNNHoxXk443kUstivdLP5EKd9vuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXZr/rzNlj8Kob+mzIkh+EOWhoEesRGXHLYXh8Hgd8IgJw3Sfy1M2OkpZpWv+0Fif0GiW8mdg5YpFN/kD9LvSo6KcPB8El6l3eOMRtL9rQGfnuB1+y5liUTKOUpFN8HJHE91n5g9fX9mgbhiyrSaM173nmbwtztye+9+mYyV9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TAHTGCkq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TAHTGCkq"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D732282B54;
	Sun, 04 Oct 2026 13:10:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SL09NiG0HrrP; Sun,  4 Oct 2026 13:10:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791112258; bh=U+oXcYrJjbhqWpBJNNHoxXk443kUstivdLP5EKd9vuA=;
	h=From:To:Cc:Subject:Date;
	b=TAHTGCkqVWQiJsUShJfkQ8vOYhyqjyZW5x4FXcRietf0svPvj2Voa1KjRKE4bk3kg
	 4053FJvo9n7ybil2rbW0zpxMbu/doVYALkOXFPYQO5kNZ5yAH0sIkdUh1IzedJ7RG3
	 AcVDvlr2MztQEvfjOtcrcwvsdmpJphhYwt1C25xbfaemy4PPvEienJlAsSKWSTjrKR
	 zz4YTNsYK5ROmdKv6s8G2Sun6pm80jFpkVBHoh+uFaFdIOGF4pXDbh+6Y0lmAx8HZ+
	 /THR37peEIZdS6s5qX554vq12brqxzz6jjdy749NEAIKPnqw39UK30Amp0DrfgXanp
	 f584TCGf0jglw==
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
Subject: [PATCH bpf v4 0/3] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Sun,  4 Oct 2026 12:10:03 +0100
Message-ID: <20261004111007.3216186-1-maghasi@disroot.org>
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

V4 changes:
- Edit selftest to use proper value_sz in the new cgroup map test
- Edit selftest to pin the current pid to the current cpu for LRU map
- Edit commit messages to include user-visible changes

V3 changes:
- Split the fix into two separate patches for array map and hash maps
- Extend the selftest to cover all percpu map types
- Extend the selftest to cover all applicable flag combinations
- Extend the selftest to cover the unnecessary delete issue of LRU map

V2 changes:
- Fix a BPF_EXIST flag check in __htab_lru_percpu_map_update_elem()
- Add additional test for BPF_MAP_TYPE_LRU_PERCPU_HASH map
- Add check for BPF_EXIST, BPF_NOEXIST combination in percpu array map

Masoud Aghasi (3):
  bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
  bpf: Fix incorrect handling of user flags by percpu hash map updates
  selftests/bpf: add tests for percpu map flags combination

 kernel/bpf/arraymap.c                         |   5 +-
 kernel/bpf/hashtab.c                          |  11 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 200 ++++++++++++++++++
 3 files changed, 210 insertions(+), 6 deletions(-)

-- 
2.47.3

