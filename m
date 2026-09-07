Received: from out-zbxj-a90.jellyfish.systems (out-zbxj-a90.jellyfish.systems [198.54.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDF27E07E
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744063; cv=none; b=ExuLeLOs/RSdBoM+0It205LFUTLXMw+URW1iIBnkZR+kCo2wKpiGtGi4tvAYOcIkuvf3yTnwTV7scgh1vxFzoxQkQrXnxXWVZD1fTw7b7n0WcwdRElC3jvsjZ1liG0kiKS86lG4wmopgPUol2I/tBdDPHcyK90/5XwyxC5Rq8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744063; c=relaxed/simple;
	bh=6l8uLUt6bU8KLBUACoUOGsgIC4WgCcRjH0GFVb4xNCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvyG4jOWJxl99zrxDZBV8Lq6Oi6nC3VwaCzUkybz8SOsqRzkec9y9Wjb0ZjoA+1kNEnq+G+73CbLUK+ytQgg5Q1cjh3Chm3qJon1uqGbCy6xZdQmvtoQB7ACdADK5E02xhGJxMr1o3HeH5lbdKuBTmSUs/ZJqtO+/C/sNeXJBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=FLBkev/C; arc=none smtp.client-ip=198.54.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="FLBkev/C"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTm61tc0z8sYS;
	Mon, 07 Sep 2026 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744055;
	bh=+fxT8GAaNVtOXP/vz0yqRqkKjkOxys+3Ayv2BKCt7s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLBkev/Ccsa3/2ZxNsyTvU9gQ5eidZJS6mJGBcB66URSSrtA4pOTMNdVPovKsr0Mi
	 kbWRwJjPrmb500tm5et6ZzpnUfncnzjIBpKeGtDpyCNmiYnZmuJfWhFSwq0n+ccvzG
	 oyUJgjkG69JO5icMOZDD5gmOlitXEJ2F37y6a+UpYQeXzp5+Mn3RUqoom0sXnbT1eI
	 +ylpmo6XZ+Dpo962fe6FDwO4F5O0YB3lLvXF0C/+mqeOpt1zf8V04uEOPYxQTYKCQu
	 xl2XOPUOeC7tyGQgZhBM1ZK9P0vlV/XEiW3LipnCx4BsHuNPSVA8H3xZr6JMnPsPSl
	 YxicUephmtDBQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpftool: Support symbolic map creation flags
Date: Mon,  7 Sep 2026 09:20:49 +0800
Message-ID: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170715.1212085-1-hi@tychen.cc>
References: <20260906170715.1212085-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Add comma-separated BPF_F_* names to map create flags while retaining
base-0 numeric input, with matching documentation, completion and tests.

Changes in v2:
- Complete list elements without adding a trailing space, so the user
  can immediately append another comma-separated flag.

Validation:
- Real Bash readline completion checked with default COMP_WORDBREAKS
  and with comma included: unique first and second flags stay in one
  argument; after an explicit space, entries completion adds its normal
  trailing space. Bash syntax and diff checks passed.
- All 29 map_flags subtests passed in the integration run described below.

v1: https://lore.kernel.org/r/20260906170715.1212085-1-hi@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/57

Integration validation: the flags, ring-buffer and batch v2 series plus
recursive dump v3 built together with LLVM 20. All 69 focused BPF subtests
passed in an x86-64 KVM guest running Linux 7.3.0-rc1, with no skips or
failures. The bpftool-map man page also built successfully. This is a
focused run, not the full BPF selftest suite.


Tianyi Chen (2):
  bpftool: Accept symbolic map creation flags
  selftests/bpf: Cover symbolic bpftool map creation flags

 .../bpf/bpftool/Documentation/bpftool-map.rst | 13 ++-
 tools/bpf/bpftool/bash-completion/bpftool     | 26 ++++-
 tools/bpf/bpftool/map.c                       | 77 ++++++++++++++-
 .../bpf/prog_tests/bpftool_map_flags.c        | 99 +++++++++++++++++++
 4 files changed, 209 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c

-- 
2.55.0

