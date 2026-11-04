Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818500;
	b=dTJLLOQNwvnrKwcFv77NwGwnbWhUGzkT5ihLxQVZsAdh9JwEwsEFbfV4FePxYU9y1T1F
	 ZSK+0HZ9eGxjs09SjLKnfsf39fhhkobKA0Mj1Hksh4A/+Uj7xPfr1MIkgf0+rCqidP8Mm
	 Y7heja5RDQ2IK8WJ+Z9v3K61zJKwgPMIIlLf2nL3PWH8LU/+NrTjMvJI/PfGtVX9ouIdz
	 5/Of168UnAUDub4dHbkOZzXnRcndnjovEvc5XqqFG49gVYj1Z7/WwhM3QlDCYOI7ZQM7D
	 iREbamc5o5aYBhrxKJjzSkE0paxH2Urtq0ijpgp5P0KWgdOKB/gCaBIO0FP7CghaWdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818500;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=DhE9pS/R2JT9liAZOqJWys/743Fnb42sj7FCB68RT3A=;
	b=wA0ZjeDdcv3wlBDnI8czZBctLm1DL84XcCEC8ivpS2q90PtfRs6WPzvYDDqQ48wB6QI6
	 jJUstH3HVpTov4CqgoS4zVcNYz0fRkWM8RH2zXtdEGnp0s21ANeUO5KkUG1hLijyO8lIA
	 goGJduDFiHTnNp50A7YdUZD6jWOz1dMIdGUwlI2QJIRNMSbGFgz+phoq6sde1xJT1zCto
	 QW9XiCz59gJGp2vzZRaboL/cERWObvfq1IS6vkQ7OkoeMw+a9CRGRW0WluXeoKiF6xBFL
	 ZfseuB+KqEPUMwbJXx0DrSGyrWmML4W4l7uP5AuTB6yAZ+rtLMvXquLpP/CMpkGUosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=GoUJQhyn;
	arc=none smtp.remote-ip=63.250.43.106
Received: from out-2uec-a106.jellyfish.systems (out-2uec-a106.jellyfish.systems [63.250.43.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF415606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF415606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=GoUJQhyn
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKZPN5Rpsz8sWS;
	Wed, 04 Nov 2026 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793818491;
	bh=DhE9pS/R2JT9liAZOqJWys/743Fnb42sj7FCB68RT3A=;
	h=From:To:Cc:Subject:Date:From;
	b=GoUJQhynFrGakBujM2PEYzpIKqCp2r2OqsIFJPC+OJDNt7mfiuVuf05oTW8276R7T
	 KRZxPteUHCp6SXkKcLzAEk3iqLQpnPEqPULWmHoe54IRwGbMzi3vNBAeYB/OifATBK
	 ZprmsQhVmFrKsc47HeAlKkrG5pZ8mgfuxTARn8+qfPELCB5oUX7sVhr675UE+fu97Z
	 0yhBvToeDy8JRm2EzUtV3QJNtAVE+l/UrLjvXkpYGqLoIYzTroE4dOztU11pSfXjrV
	 O7/oH3L3wxlpAX2Lmbrm5mjyqDj0IKzpw5dZDnWoN81+f/w3e1UbokYNy4TvJR304d
	 OaXqfIAAhWEzw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	skokovmaksimevg@gmail.com
Subject: [PATCH bpf-next v11 0/3] bpftool: Add recursive map dumping
Date: Thu,  5 Nov 2026 03:54:36 +0900
Message-ID: <cover.1793818386.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Dump each inner map in the entry that references it. Open it by ID, dump
it and close it immediately; a missing inner map is an error only in
that entry, and shared inner maps are printed in every referring entry.

Changes in v11:
- Drop the queue, deduplication and second pass, as Alexei suggested.
- Drop the ineffective map-info test. Keep the map-info clearing fix
  for bpftool running on kernels without the kernel-side fix.
- Rewrite the recursive tests and drop Quentin's Acked-by on the
  rewritten patch.

Tested in an x86-64 VM, including shared and missing inner maps, BTF,
multiple roots, and the combination with the batch series.

v10: https://lore.kernel.org/r/cover.1793732336.git.hi@tychen.cc

Tianyi Chen (3):
  bpftool: Reset map info before each query in show and dump loops
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |   9 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       |  67 +++-
 .../prog_tests/bpftool_map_dump_recursive.c   | 375 ++++++++++++++++++
 .../bpf/progs/bpftool_map_dump_recursive.c    |  17 +
 5 files changed, 465 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c


base-commit: 8fb43ffc3327d12d57d3fbe6f4820b5a522de0d1
-- 
2.56.0

