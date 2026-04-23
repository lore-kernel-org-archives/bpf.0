Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE193090D5
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957773; cv=none; b=tDTLM/gHBDGnIRNThzK1QBR+klW00ed2d3NO72awKzK9Yl97YdWlDqLhHPXibYChXy+24BbngdyN/BO5DAbgowS9685/CJs9Bwhf62SYlBXJt2B69BFrJuDXrriJyRE95Z51H7bO8whw5++BfKIw/Yj0qYBExU4nonkbfsaudfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957773; c=relaxed/simple;
	bh=B0WPFNaDNOtaJglYGHK6WWwSD/xWS+BRv32WuY1BDrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccaWeDW2z0Ug0Kb6I6CxwB6++rgQOotOQ/tYjdKoJwf+iHCvoyaEz+InyHvU3U/PN2Vmdy8Px2wLMZLjqEUfXgJws5ipRmdIqGEp2bSt/fhjvUeJBO+CWc8HGF0j1maWo6Qmq3B4wi+6LOWiEEQeIojFyrMsiRCnCe4o3sGlGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpMZkczE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpMZkczE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7da9so67782377b3.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957771; x=1777562571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geSsAu1Tbm5ANAQDjNMyLpAhvqt9o5k1zjJmYmOq/T4=;
        b=LpMZkczEgHFEYdKs10S86KE+Uz+UED2WmjkLKhxdlZiZEE+kqq+T+FCqD8cmkS7CDA
         yJ3yz9qgRNcUlGsLV8etDBYBBvi2oKjp9oBpSO5VzjKj/1h8/Q3pNnuqNiuaBbCxg/74
         iJrodV54CBQzns3vwySYbCapk8te7VxhQsJBY/NPNDrdy3GiuYk4b8ZsnGaqvUYyS+si
         RyjPQm1K0D1Rcm5TiRAZwClcyjIMQsxjuJNovjfouP0/NK6ztJDAFn7FZPA/1kUB6kqN
         sqCwLCOsP4yhJsedm+cCZFmtORaPAFHMOB6lKb4yggL/zmDaCYpxT4/8GuK5BvfwojIL
         OQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957771; x=1777562571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geSsAu1Tbm5ANAQDjNMyLpAhvqt9o5k1zjJmYmOq/T4=;
        b=QJtjK7H1pgapAvtHl6CvXAdTv7fCN0FWdXEFergrGDU0c6CcA1x18GRuAwIFNEmEWy
         VALmfWdGO8Qtj3weq8a4G7xD9qdM7T+KgFUhbP/74DtA+/AzgVvz2eUksLBxVjqjEd4f
         vQQA1mfhUDBqD7m5fsUsW5NP+MZ7t8W+4ootQLHAwRDrYBClB4NOa6FkvQ7QsG7xIsNp
         ADc4nAUuKhuTvP2JTBBjKKrJH3UiPNbi7galYHfwTHfYaEGrfA4gz8e+jTnKv6Ec6pRq
         stRV8ILxQkfBSI6uS5sg/oCN/cNWPzl/w0CwzxeFmIOVt8xlnr1d6Ha2m7CyPfOaY0aZ
         zmOw==
X-Forwarded-Encrypted: i=1; AFNElJ+MRmegz4VOFd683brcJPO7z574BAW28REQufercU7rHA5xHwWBl1zEW6oeatgMZhK/iHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pVQrvM1vUL0b/zyiPocdOwlW3162LVGZm5cmqB8+LzcZzGzx
	AKKcNsSlFzJeda4nTSgSCSg8f33mabNxXxSIo7AodR1I2znnz5giWRPd+Xky1A==
X-Gm-Gg: AeBDies+BPGB11E1GxLijzgR6Vtsb1dlyf9yz6tiWGYO3BVoAbz/LJQK3XXH4sRmzBP
	zRof43akMWCEC4el90zL0PNKHXPVpeJ1rNSWqSKK4b/rupE0f+NFd4KYdhAUY9/zPFodW1VBeF7
	w5rFU9bw0ugdG+TPrvzuLA516YFrq+9+EmMjDkrpUzkweeHQfL9V6xhM+tcyjANnegjZZTGVcT+
	8pSx3fzj9fIDcX92Pv+Y4zdHUVqWgW3ubyFCQLS5YlkY06uoG7hfJP6Ia0+n3gwNbXLv83OjyYm
	a++dD5ftpBRRdBd5/baXHQemoS3uoceOToeI5DCoieZT7Gmnq6iLJXjTork7xf+MN2LiHasQAvW
	gBv9VXzksncX1pLgIzM99cqYa/gdXap8onzprS3Q1WA8DfynegKqH3SGiS9CT7YTuMDHdz/InUC
	AvuZ93XbDt9hb+QVgz7m8PWPA8vDfrIp3vXaNBBM/GutEq0Hq5Z85O2mFJpJMB8dSNFIZnfrfql
	Q/naww1pFw=
X-Received: by 2002:a05:690c:660e:b0:7ba:f584:2800 with SMTP id 00721157ae682-7baf58429f6mr165404537b3.21.1776957771047;
        Thu, 23 Apr 2026 08:22:51 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:b41c:424e:7501:d0c7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89b88bsm84293957b3.9.2026.04.23.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:22:50 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Allow storing referenced struct file kptrs in BPF maps
Date: Thu, 23 Apr 2026 11:22:37 -0400
Message-ID: <20260423152239.4140627-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds a destructor for struct file, enabling it to be used as a
referenced kptr in BPF maps.

v1: https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/

The destructor mirrors bpf_put_file() semantics and releases the reference
via fput(). This allows pointers returned from kfuncs such as
bpf_get_task_exe_file() to be safely stored and later reused with helpers
and kfuncs that operate on struct file.

This fills a gap compared to bpf_dynptr_from_file(), where the resulting
dynptr can be stored in a map, but cannot be passed to kfuncs expecting
a struct file *.

Use cases include caching file references across events and deferring
processing while keeping the underlying file alive.

Patch 1 adds the struct file kptr destructor and wires it into the BTF
kfunc sets.

Patch 2 adds selftests covering successful use and verifier rejection of
unreferenced pointers and success cases.

Changes for v2:

- Fix comment formatting based on sashiko feedback.
- Fix typo in commit based on sashiko feedback.
- Remove close_fd helper based on Song Liu's feedback.
- Expand selftests to include success and failure verifier tests.

Note on NMI safety:

An existing bug in NMI safety after further investigation from this
sashiko report [1] was found and reported here, with reproducer. [2]

Basically it is possible to invoke map dtors from within an nmi context
by attaching to specific tracepoints. Because the existing dtors rely on
rcu and/or locks, you can cause deadlocks. The fput added by this patch
is unsafe in nmi context and affected by this bug.

However, the solution requires deeper investigation into verifier safety
in NMI contexts, and is outside the scope of this patch.

[1] : https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] : https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

Justin Suess (2):
  bpf: Implement dtor for struct file BTF ID
  selftests/bpf: Add test for map-stored struct file kptrs

 kernel/bpf/helpers.c                          |  16 +-
 .../bpf/prog_tests/refcounted_kptr_file.c     | 249 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_file.c          | 158 +++++++++++
 .../bpf/progs/refcounted_kptr_file_fail.c     | 141 ++++++++++
 .../bpf/progs/refcounted_kptr_file_success.c  |  61 +++++
 5 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c

-- 
2.53.0

