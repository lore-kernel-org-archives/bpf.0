Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B7199EAD
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157027; cv=none; b=Gu7Z4nhOZjkV4VL6k88W9BP2DIgHLyCyVtWWylOyRksetxiCQQxnJ1/1MYbdKNd0LOd7uu4IWbRAgtfzlzkrOEtq2Aec6WGN4oKpPg0tBJfiSosFhiHT6AV2baZUXglJNa6VWKpNpCS61GuNRi2Ax3GgJEI1fUAlm64t050jzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157027; c=relaxed/simple;
	bh=sFvHpjPthyGm0JtTNd0MBTNFK0v9x1MQCg4mzS9XO/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B0XTfJT3ypSCVDHrkh/ljAO/XnLeFoFF7JGfBaJJWyJTt9+P3vZW1kVCzgtE9n6TTzWv73CZfxIyCUYFBcONXx+elifiBjqpSVcEgMREBJby0ff6a3guqTNcYYAKbiaS5wQ3bq5qQ6MmhKAsZ2ZwVI9JWe0AcbqJNbIOKZQm9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wwTuKWuq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wwTuKWuq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 70887C21AB9;
	Fri, 23 Jan 2026 08:30:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23CC36070A;
	Fri, 23 Jan 2026 08:30:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EEB6119A8790;
	Fri, 23 Jan 2026 09:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769157021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aFUkavDXKGlzPVd2VawjHI2EJjqyfxrLlALkjdsobK0=;
	b=wwTuKWuqTAevxhmBLRJZAQ1KAUakhSj+JafVIcX7RiwF5DSp6aBw4lwv2TWgJEUyXW1ppZ
	4IBZ/QW0Jtjtv2eTGp7G+0V9CMOy+FgLbLC2Rnbsw6ZnltMYNFB7U5M6nUmp1yrvwFf5c7
	mxVi2/xgf7L5Wx2TLP8rJr1eZD6qcbUUulRA5u2qXuRW7XBtQdFse1rgXrNfPVhfDwKFtC
	nIKbiyXs7sO4sUtHA3PIVdYed9QIUDo5s/NSZivzCzy7MsmrjM6anIFCwsQCs9Ps07UJBs
	BXOMjk/4v+++W/zJtKGpA7rVRlaE2iqhIl6ueudqbnGmWsOwaIQTXcN85p/leA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v4 0/3] selftests/bpf: migrate a few bpftool
 testing scripts
Date: Fri, 23 Jan 2026 09:30:07 +0100
Message-Id: <20260123-bpftool-tests-v4-0-a6653a7f28e7@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6DIBAF0KsY1qVxAFG76j2aLgCHSmLFCDE2x
 ruXsGpt0uXPn/dnIwFnh4Fcio3MuLjg/JiCOBXE9Gp8IHVdyoSVrAIGjOrJRu8HGjHEQLUGWRl
 hDOqGJDPNaN2a924kndIR10juqeldiH5+5UcL5D5tyhJAHDYXoCU1VmkwptWo7FV7Hwc3no1/5
 q2FfXgGR8+SlwI7LWpsQeGv5389T57LRnJmeV1j9e33fX8DoqJxUzYBAAA=
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
this is the v4 for some bpftool tests conversion. The new tests are
being integrated in test_progs so that they can be executed on each CI
run.

- First commit introduces a few dedicated helpers to execute bpftool
  commands, with or without retrieving the generated stdout output
- Second commit integrates test_bpftool_metadata.sh into test_progs
- Third commit integrates test_bpftool_map.sh into test_progs

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v4:
- Port missing map access test in bpftool_metadata
- Link to v3: https://lore.kernel.org/r/20260121-bpftool-tests-v3-0-368632f377e5@bootlin.com

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
 .../selftests/bpf/prog_tests/bpftool_metadata.c    | 144 ++++++++
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
 7 files changed, 602 insertions(+), 486 deletions(-)
---
base-commit: 5f0eb131037251b80c9a92af28c6be8f65d063d2
change-id: 20251212-bpftool-tests-bb165c4cceb8

Best regards,
-- 
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

