Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB032E743
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906484; cv=none; b=AfMoICODLhFedNoGb68wBw+lZYr1gdFFwbQvz3mxM0IpQl13gAFLtChsMEqK4HNlro0THAGYmkwFVwR2FjjWwWLwHwESvd3DihS7yBGOA6LWVauwSg12itt3RH5h1o89MOYlYrn9rWzVcs7+7//7wOfTG2TWAcLnRHjvUUpWNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906484; c=relaxed/simple;
	bh=QQ1L22Wvfp4TF/Wc10ZxkSgTMXrBIFR8TmwA+TpbEBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npjxAcKqoHXynWqzRB38YyKmxYS9mgOhPyinUSa5TVmGf2e0cU8nNT4jEAhhHaY3N1xwE7Vo8ZOCyow5otEDR+ceMXOkSc+CDY07D36t6cVzT6mAUdHhwFxREbRcuc9oZyxDfGqJwJnx310aoWzZnKU9Sv1k4cLb/hlaFw4j9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXz/Hf2p; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXz/Hf2p"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ce102afb0aso3784327eec.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906482; x=1776511282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N106WXZEbWbm+mkMjfNRlJHCBH/oaKGWtZxKOVnjw0g=;
        b=PXz/Hf2pd//EXCKl74wF9AkwoWRm2GtwjtCrJl00jRsJ3M78Zzczng/Y9xnCv1QJz4
         cPhRDDOaJ3cTqna/ZW59Tcpb+pEfS2TpFeqqpazoPM4JR6BRJpTmwk+0tkTbgLMWdWGK
         Xt6CinptBGucNSjJaqOeQfRc5zJ0HCPeK2R/aBqcktrxILyXolV4o05sHvHPcS650mZI
         lfOE8kpWKKnKoB1PoOtdFcj0ZFfaV3ZADgtW5xnFNbA7USldSZ4AK6I6FwNI2vrbQ9pR
         MvqJcg5fOs1yxpq3o6KCwc0JGesFppHYdtEmpnzoUkMyRNJcUHEK7MEjoHQMyADtbCFh
         BehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906482; x=1776511282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N106WXZEbWbm+mkMjfNRlJHCBH/oaKGWtZxKOVnjw0g=;
        b=MPJLXhFX7bIKN4jZVDWYCl+ze3AyJiS3uAL5wWjNH7GO42cK1qZw9dsnqn0O2sRUmW
         v4Uf/UhFwmrJzwHQFQPxUBglyvSwnEVjPwymquvQkNamJ1uIEkBWFxTgaOXHtvleuAG4
         x4fgAsPNHxbuyNzQEhg2i6f7a9ZNMAe34+uzygL+mzB61Qrzp2rqE+6Yhdh4VKrmHQnJ
         zcE40MBwdnqFF4vCpO9hqn40KOmuRaPhcUB85ouVY7b+rUkUIa5+Jr2tm9ZJOUTFEaRZ
         gwvD0WVdJ8aSrnYyZq18taxeslUJp0gdJYpqxt+PdkMvBzLcSvouPBiJW46flX41SSKH
         t8dg==
X-Forwarded-Encrypted: i=1; AJvYcCWGz5AIh8kZzev4YGuVkDVX1uHDwqpjSbDkL0KbwzCLC737B7q881T5wSGDVz6YeWeoCIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCJdoNC1eBa9w2OEXpxROITs4SvNuB6ixX6eXM8uo/WT821Li
	0kAejV2FUaRkJ80aF6xFLewkiDHn6EnIlb04Zs7ikrWNRmYJNSOttLrS
X-Gm-Gg: AeBDietWPfif6MOWh+Nhj3B8YhVkbovrKfnKlNEx+xnNc+twczLQMhGmQvUwQLxASJf
	3Nc8+rfdhGciK7NSnjucmAxxNl/hrjPOpII0YAcBMYJOIC8uWj3lQQ4wfX3oxeIBOKC0xfjTMBE
	IAOoxRY47mK2CdORn0Q3JkARU75Hol1V7OS6apNf0spPiyzTrQvBrvRE4uHgIEZaFk8BWOKJ88W
	KXAppHRxJle8MrGbNjs/UtEahvJQuszcscieUGonbY2Nvy/YXMaNMrjA7FqwUg53paRdmWEhwCC
	XT1wm3sP69f6le+voKky+0iIjOacxXi8h6svXmRPZLMlY0msgzFfhggnXvZW63zHr64gACc4cZ+
	la69mgSS0kVy/vr7hu6mwsShBPwKtrYk7kZqgClV5HETLmML7mJm0Om8c6JLGUT55FNSu7A+VFZ
	EYkeZBCwZTidU5wo5h9oOLGEADWwWHhg6okLDIqzNg6CAGh52Rgw4FHHKpf2XL+hr7edrztQgpY
	cKf12lKVw==
X-Received: by 2002:a05:7300:4347:b0:2c8:717:7ec7 with SMTP id 5a478bee46e88-2d58945dd66mr3786627eec.20.1775906481985;
        Sat, 11 Apr 2026 04:21:21 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm8224984eec.27.2026.04.11.04.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:21:21 -0700 (PDT)
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
Subject: [PATCH bpf 0/2] bpf: Fix arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 04:20:49 -0700
Message-ID: <20260411112050.1454548-2-bestswngs@gmail.com>
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

