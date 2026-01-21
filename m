Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EED313E3A;
	Wed, 21 Jan 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008723; cv=none; b=BiCP6AasVvcX4CaRxsknmWae3b97spF0GoB6dSHTe0sq8A9PzZrHBYZBwG58rGQfEJKSEybizBNKG/u/PTG3I0lUUW4lV4glqB4nOOY92WdTFoMlQgfJ6Bb03bOtXZDAuDxSPmVN1iz8UHsx6ucvm/v9rbCisWhJ/HMYJPx/4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008723; c=relaxed/simple;
	bh=RZCLtjgUrKfQYhHSBjFz127iEBsMdSjQVFrFfHCifvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oxV/XYcUeFz45kMvfZVhzmf4y3iP/eVN6kKeqQDEqSCIN6tFb8iKzmrfdxXEaZTBJu9FrmN6QtfFRo5MF3VC89YrXkF7kNRhY6OwuQRv8K9aiTNFy7VNepXalTiJtQD+lTWr+a+Uhzx+GpSexZtU5OythJJcH1MrTIEKyAEK+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x4Xs9VxX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x4Xs9VxX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 45EA41A29A8;
	Wed, 21 Jan 2026 15:18:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF4536070A;
	Wed, 21 Jan 2026 15:18:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FE43119B1696;
	Wed, 21 Jan 2026 16:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769008716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IejE9iCDMWcSL6DATLN3PAAwL5QqkOl8mWRYKlkYiGs=;
	b=x4Xs9VxXcUcpsISc3awHLu9uMrdHX9w1XbKp2CgatwFNInSu7FmJ3nD1BL9yJYTCJBkbWd
	V6kHKec5xrOjO0bjT/IAi9fgqN2b1tnX8ktV9eDu7Jw9eDPBwXtKz2rdd79KpoxQMqAG9N
	IvfJ+uQyOfYnLHaWbCNbwO68c+Iu7W2U2f84fLrgTqVXat+rNb7YSFNapILznXUiTQ4ts7
	q7vD1kfpxmRJZGLI25UY6cIkzsckxzIPUEjXFthplmzNq0K3/3YDjlsie9sasY6tviNPi7
	Vzw4urVgTZ8R6ADXfE212WtSFlNTtFr+/bq9oY5ylRnO6ISnw7coPt83KvD6dg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: migrate a few bpftool
 testing scripts
Date: Wed, 21 Jan 2026 16:18:13 +0100
Message-Id: <20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQqDMBBEf0X23BQ3qLQ99T/Eg7vd1AWbSBLEI
 v57g8cehzfzZockUSXBo9ohyqpJgy/BXirgafRvMfoqGWxtW7RoDS0uhzCbLCknQ4Rdyw2z0A3
 KZonidDt9PZSq8bJlGAqZNOUQv+fRiicvzq5GbP6cK5rasBsJme8ko3tSCHlWf+XwgeE4jh83X
 XEktgAAAA==
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
this is the v2 for some bpftool tests conversion. This new version drops
a large part of the previous version, as it eventually integrates the
converted tests into test_progs rather than into a new dedicated runner.
The new tests however are almost identical to those in v1, as the
dropped test_bpftool runner was exposing the same kind of features as
those in test_progs.

- First commit is just a small cleanup, reordering files in the
  selftests Makefile
- Second commit introduces a few dedicated helpers to execute bpftool
  commands, with or without retrieving the generated stdout output
- Third commit integrates test_bpftool_metadata.sh into test_progs
- Fourth commit integrates test_bpftool_map.sh into test_progs

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- drop standalone runner in favor of test_progs
- Link to v1: https://lore.kernel.org/r/20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: reorder test_progs sources alphabetically
      bpf/selftests: add a few helpers for bpftool testing
      selftests/bpf: convert test_bpftool_metadata.sh into test_progs framework
      selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework

 tools/testing/selftests/bpf/Makefile               |  39 +-
 tools/testing/selftests/bpf/bpftool_helpers.c      |  74 ++++
 tools/testing/selftests/bpf/bpftool_helpers.h      |  11 +
 .../selftests/bpf/prog_tests/bpftool_maps_access.c | 371 +++++++++++++++++++
 .../selftests/bpf/prog_tests/bpftool_metadata.c    | 134 +++++++
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
 7 files changed, 609 insertions(+), 503 deletions(-)
---
base-commit: cb353e9f65bd5eb7025211f36bdab6c43d27f6f4
change-id: 20251212-bpftool-tests-bb165c4cceb8

Best regards,
-- 
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

