Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7538409DF0;
	Thu, 23 Jul 2026 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796713; cv=none; b=rrGwPaSQ8kdTPSsBdZd4YF8TWfQofdsn7o6rAoUpYYODvKCWZ7udtJKdbZC0YqXqVd/h32UaTPHgheyovPYnr4iqc7DNeSANwpoBh70g2sJasP6g0gpScGJd7yI7i8rk9soCe9pneY+UAJ0Er4AsIYvKe6b4NukSiv+2uGZ5Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796713; c=relaxed/simple;
	bh=aJptxY4Lm0N2ewqmCkGLaeW6I/cqUrvfT4/D6g/FxwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvJNcDySuJZgqtzc6FCik8W7idMM+zqbjYBC7zmdvI44iIc+xoB7hyYM5vZSuCWpmy3jU+KHBu4D4sepjrTDaVnXU91tHlhLfTl/CYycuPyhT03R5a5GLLj9RSAirsCSTCfGIs2C1BM0SypoUMw+e5ursGvFL2hCUVY0FGANXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eb0fC5IU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eb0fC5IU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mg
	I9z/RLO9ZueeZuR8HIyHeHEM+h0oRK6kkAa4VuuxA=; b=eb0fC5IUvYMETHhiOZ
	NB4MZ+3mHCi5USrM8O+TFl+xyDB7HtxmlhhFi/r8/2IsszwTPRkbp7kc8N67PD3C
	xHuYoi6k57G/DmKz9WYdBh+RN0MvVbFVzbjyS3KaTz4k9Cb+M442428YLpby6pl5
	C+et6ibf6ijIcqRtZ1PLq4dko=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S2;
	Thu, 23 Jul 2026 16:51:01 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 0/5] selftests/bpf: Fix several issues in test_progs.c
Date: Thu, 23 Jul 2026 16:50:55 +0800
Message-Id: <20260723085100.482147-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4rXr4DZF4xtr1Utw1UZFb_yoWDXrc_ur
	WUXFykJFW5AFy5Ga4kK3WxJrW8K3y5try0qF1qyFy7Xa43ZF9rXF4vgrs5Zas5W39xXrya
	vFs3AFykKanF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jhF3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RWlHmph1fUxUwAA3W

From: Feng Yang <yangfeng@kylinos.cn>

Fix several issues in test_progs.c

v3: Add fix incorrect error checking for pthread_create patch
    Memory allocation null checks for the worker logic are relatively complex;
    remove them for now and submit them separately in a follow-up patch.

v2: Fix several issues raised by sashiko-bot
    https://lore.kernel.org/all/20260722074748.674080-1-yangfeng59949@163.com/

v1: https://lore.kernel.org/all/20260721094404.593127-1-yangfeng59949@163.com/

Feng Yang (5):
  selftests/bpf: Fix double free of subtest_state->name
  selftests/bpf: Fix incorrect error checking for pthread_create
  selftests/bpf: Fix missing allocation null checks in test_progs.c
  selftests/bpf: Use calloc to allocate subtest_states
  selftests/bpf: Fix memory leak on subtest_states reallocation

 tools/testing/selftests/bpf/test_progs.c | 27 ++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.43.0

