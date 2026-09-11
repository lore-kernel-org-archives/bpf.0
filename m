Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B03E835F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095072; cv=none; b=l+bmSKxtsq8VxTHhJVKXRRewJEGe5XTKkj+WUBZvyN+mbveVviHCsiWbx8xGXsu3R/qCZ+9gCRPGPmaT5I5LlKh4ZkUoc6+nD780oRQu72eLbwFtQmAdpFwO9X18HBmdL5EigWNELUopxkM3z6BBV/dGFijvQhqj0JQ502zE96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095072; c=relaxed/simple;
	bh=/1qRY3m/FPGd4V86Exhepsjs1cVobk91A0esgwxfHOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvdSust72vrxey1/dDyzP63u2OHtxSxBbA7/18c7J4j7dzKAdDfdrefFXyS+dK52ZD8O+tO/WlHU1pvjLIP9PWBisO49x0kH4XI7Wq/UM4/N6NF6xyfAFioq57ddzw7HXRiFIOQ7oWL00WE0yQ9cDCSUDQYdfA1GD2xWg6HtF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHQ2ldoZ; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHQ2ldoZ"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so227854a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095067; x=1789699867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLGO9CaahpWipcWtrC1IVp16amqxGQHf0ZihHnYfAkI=;
        b=aHQ2ldoZNq1zO4R2j0MxVYyDlj5trLpZxh5Uw7TsuiC3rCJbXAWgik4S7BG89ngMy0
         2UFNqgTQaQnmAQSSP9YaeHTJCy4+5wTGVBWLXcJG3kGRYh/eiFENPiGitCkHhCMTK8BL
         xBKPYWOq58BsaurGIj+SMt/W/laVI2etpzB8I9pM4yfMZMJtpG4+KgDI88Khsk5m5Uvs
         7VVPREhfPqkmfTKS/W6A+2/kcxhX33xuqTU0DUXu2F8guSebcYseuc9K+K5kyX39UPKf
         fg6ch7AI9Ffy/Pxuu0mG5LBaxHBN9XIdLrbrfPnB7F8g/sEcFldQWdpx5uqeBQw0dGd6
         reMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095067; x=1789699867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLGO9CaahpWipcWtrC1IVp16amqxGQHf0ZihHnYfAkI=;
        b=rY4c3TFKi1f/feowtAw5Hx1TEQfs8OEAT+5/c5d4ER9M0oaNv0XP5z6rXM7oZNA0QW
         QdwG3vhuxxQ0hJCpqXlkApkpkBQdfQXBfW1U9AAF1y3XaD6prilHRriTb/IgjB6bvpj2
         WGwa5eZD8XRvMcjM/+C0mIEPdBGP79jGkzyaVpNGhYkFNgeHbHJGAy5imhSa/Ml05YUa
         wKlUsru8w/Yax3T7ja6IrmuW8FpplgyXBLXm47VNHxTHfZkCmcc26w+eiparUrVvNwOs
         cT8oKd+wxWno/x37MlEvenGlLTILT7JGQRx3DgMgEO+41kvjHgmephj/j4nT1l48J3C9
         Mi8g==
X-Forwarded-Encrypted: i=1; AKwUvByRFplSNiGWa6i4zCWALKCH6PEN4EiihpK/wOmDwknWKLaMbS4cGooOTBpF+SD+V91E/PY=@vger.kernel.org
X-Gm-Message-State: AFuF++k5OGQllUbysdgjtxyVjf2YiTjRfaa6dAiR7JEiNS+g9zkMNNbp
	pyXVr34ZoJEORYzV4252AGS1SHcRa8wzZAPbQlMf0dNPawguZvJjiUpm
X-Gm-Gg: AYBFou25YUXNSsLI97vNcD01nEhCjT4fCNyvrb5fX7i2UOzZtKnqWFgJMuk14hLB8Vl
	B20D0PtvXNNV7Y3cgePxgWh1h4x5qztrcTtIBDF1JhH+yAmA9Zf46uUVsZGF8RjMTGV3okVmKmQ
	ZQYvuM52C640cUO/hzp8eYLQA2d/V9JY64dCKmaG7soc69U/lnqKoqrGdjh6kGrPUMiqoXPFxyW
	ca66HR/HpW0Z2MybPAaIgUUEMg2v2BxTjodiE0lupd/jDkkVjx14uxD3MwvYuEVooYHL0YAysWJ
	KYVE60QokBCuIL1Qv58XMFtiqZfFQVU/WAob10FtFVjfu/fJ649olSGl7nizdzrrqMMwlFlHVrY
	ur9KSINutdVmIlF+9NERcby42/PzSsgSjeYUwp/zkF3RicE+fvvf/Od92ipkqbxbdIljMSJYkqF
	bz7SkJUuqjCsgEFMdtgh5HgniAEaT0Zpc9LTaQ+fKdtP5kC8sS1+AydLXh/orVYy4pqX5gtWTUW
	EQ=
X-Received: by 2002:a17:90b:5246:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39d9bc67660mr3396866a91.1.1789095066655;
        Thu, 10 Sep 2026 19:51:06 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95095946sm2363350a91.5.2026.09.10.19.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:51:06 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpftool: Add recursive map dumping
Date: Fri, 11 Sep 2026 10:50:58 +0800
Message-ID: <20260911025100.190706-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add -r/--recursive to dump the contents of referenced inner maps after
the selected roots, with deduplication and bounded descriptor use.
The second patch covers output formats, shared and empty maps,
unsupported lookups, and operation under a low descriptor limit.

Changes in v4:
- Clarify that the map-of-maps helper returns whether the map is outer.
- Return -1 consistently after reporting failure to track a root map.
- Explain the descriptor bound and deferred ID lookup in the commit
  description.
- Rebase onto current bpf-next and use Assisted-by: LLM.

The earlier functional review changes, including closing each discovered
inner-map FD after dumping it, are retained.

v3: https://lore.kernel.org/r/178874362960.1415955.17339804697296063298.recursive-v3-1@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/58

The previous version's CI PR expired after repeated "Patch is empty"
reports. The revised series applies cleanly to the current tree and is
sent as a new thread using git format-patch and git send-email.

Validation:
- Built bpftool and its manual pages, and built the focused selftest
  runner with LLVM 20.
- All 12 bpftool_map_dump subtests passed with no skips or failures
  in an x86-64 KVM guest running Linux 7.3.0-rc2 from current bpf/master.
- The four bpftool series were tested together: all 69 subtests passed.
  The cpumask suite (36 subtests) and test_maps also passed with no skips.
- Bash syntax and the existing bpftool synchronization checks passed.

This was a focused run; unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  22 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 131 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 465 ++++++++++++++++++
 6 files changed, 617 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

