Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA051361654;
	Wed, 21 Jan 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027477; cv=none; b=bdUWUtF/LX71ld2PjgR6vYKrdms66Jdp9lMZwizU0V6dI/AIPGKMPNA7BxsYB471T0bT9tM8sApij7VUs2YxKmr05w8ESsyYsrmFNT0TQOCjoTRcMI9p9sbyCj3++Y+MkzpxJqbd3241aT28yfiXUpspQDP+Xjp10ANF54pUkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027477; c=relaxed/simple;
	bh=fI0Q/nkXEePuICms0LOOfxmvqma5MP0vLFIrNW/1G2I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P3LE59BGG0rsacYeWni/PWy7SZJZFCP0KrItq+eOO13pIcVt9vMX3HUsWmLjgHs7KoCsFxF8Z7+QnvlL41vOxP/nS3m12n5YOR2is8c6uwmLgwM/DN2xj2GGAFlTmkG3UiXNzqsnpQVdfCZg5xbhhaKgrbbPumV2MslWQDg2QMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X/aFkhOM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/aFkhOM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6CA1C21A90;
	Wed, 21 Jan 2026 20:30:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E26786070A;
	Wed, 21 Jan 2026 20:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73528119B1D54;
	Wed, 21 Jan 2026 21:31:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769027470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RA6hOyH7QpmC+wWjwp4m6KR8PRu+ECGfS7H9BhCcy40=;
	b=X/aFkhOM5EM6eFl5ZmM6c4m6Ftyy03IQXC2Yg41S6/UASgi7T6NHf8kMrlu+pmeYE+J9Cq
	L5YZrMGYefPD9oHvaQxnkHxiVn/ZFD8BKDgjBs8qvcoLy+3iLbL0M+wiKXD2rhDQJZVqNt
	XNdtX3lTcwWX2Z6UopoF3s47GVK3uSqcHNLs7kqVZ41Q3PBl3VG9RRkaWwyATWAMGRa/c6
	vkEAfCa9KPtGg9n7tDLcJLayxnaQQ8mcIYfdwBt4+C14IeQmkGCb0AM7tEKUwcNVtMgEue
	xDlX2bG31TIuulvzhqWyqbr2l9cBkVcvz9NBf6TkHG2cTJoWnaOB7MCRGsziDg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: migrate a few bpftool
 testing scripts
Date: Wed, 21 Jan 2026 21:30:59 +0100
Message-Id: <20260121-bpftool-tests-v3-0-368632f377e5@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBREr9KwFtOPtFpX3sO44NOPJanQACE1T
 e8uYaUuJzPvzcYiBUuRXZuNBco2Wu9KOB0apiflnsTtWDITrehAgOC4mOT9zBPFFDki9J2WWhN
 eWGGWQMau1XdnZcodrYk9SjPZmHx416MMtS/OvgWQf84MvOXaKAStByRlbuh9mq07av+qriy+e
 AH/vCh8L2lEeaYBFP3y+75/AMIVYtL2AAAA
X-Change-ID: 20251212-bpftool-tests-bb165c4cceb8
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is the v3 for some bpftool tests conversion. The new tests are
being integrated in test_progs so that they can be executed on each CI
run.

- First commit introduces a few dedicated helpers to execute bpftool
  commands, with or without retrieving the generated stdout output
- Second commit integrates test_bpftool_metadata.sh into test_progs
- Third commit integrates test_bpftool_map.sh into test_progs

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- Drop commit reordering objects in Makefile
- Rebased series on ci/bpf-next_base to fix conflict
- Link to v2: https://lore.kernel.org/r/20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com

Changes in v2:
- drop standalone runner in favor of test_progs
- Link to v1: https://lore.kernel.org/r/20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (3):
      bpf/selftests: add a few helpers for bpftool testing
      selftests/bpf: convert test_bpftool_metadata.sh into test_progs framework
      selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework

 tools/testing/selftests/bpf/Makefile               |   5 +-
 tools/testing/selftests/bpf/bpftool_helpers.c      |  74 ++++
 tools/testing/selftests/bpf/bpftool_helpers.h      |  11 +
 .../selftests/bpf/prog_tests/bpftool_maps_access.c | 371 +++++++++++++++++++
 .../selftests/bpf/prog_tests/bpftool_metadata.c    | 134 +++++++
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
 7 files changed, 592 insertions(+), 486 deletions(-)
---
base-commit: a1726111c973a6b6f9a46d79db80bcce89cdda7c
change-id: 20251212-bpftool-tests-bb165c4cceb8

Best regards,
-- 
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

