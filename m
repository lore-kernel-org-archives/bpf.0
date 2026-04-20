Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AC275B1A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717256; cv=none; b=XGKH9HrDJwGfjlULuwsUacvKiyQGzgIDlC9DLKtDZLTQ8lUK6RayJ7hW8IjTUsS65JRkXAOV+/aa7bdyJAtW/oWHNHDHRgXyJ6wlmBU8NbqLZQ86qxcS7K9TxE4UKj+/YRnfGzP16JPk1CvZWh1teLotnJGYz3l3PIGhzyIEWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717256; c=relaxed/simple;
	bh=PDqeiom2m+MSqld0lQIyBc5Sao/iUUWTvj2TcJ7JiOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY4tGdFtpoR+EaZ9jjWng2sg4lUss/lXu7rRYzCL6tFaYudslocItrS7YEC1WTj1L1PFFXvxCDPk6s2IBdtX+D5KxW7cqTOUqgdf22+tHsGIXebv4vUMxnOeWuQXqYr6hY5uyOaNcMMO8LHcCSGd4FRbnyxubmPDZaiNu7BdzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ0duuNA; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ0duuNA"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65075c2ba66so2203384d50.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717254; x=1777322054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDx3Ks3i/24PrFwCTkn8aAiTFZamVdc9q4/U3VM8mfw=;
        b=UQ0duuNACshfiEDlq1Zn82TfTtPWqNezP/0p1VwYXhXA3XrV6IRbJ/sLnNHE+KzCvH
         zVqivXlBh+fwc/U17sxZkHpiq586DfgSRMJf2ICQcRf6nSCh/8RQjD0waOg32BlKO38B
         10LIP6a8OeiBlbLpPsWBdGybDz4HPtKUdIS+nM3C4PKT5bhVo2OiAr/x6T0z0U0v/yIo
         RTtIYki1ohXLjzyq625VuRjsMl6SXXGvw3bEU87q4plt4uAByIpADuWjmI5eUHvSSdtp
         6wjfRxRYeuf3BZM5yYQUbqTNPNSUHA3rpOCjHpoJC4iR/PaGZJWGQ1/vFOfz9ljix47G
         htJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717254; x=1777322054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDx3Ks3i/24PrFwCTkn8aAiTFZamVdc9q4/U3VM8mfw=;
        b=ba1jXfwaQpbmhgrs2XtPYmToLpgun+EI/uyl97JmKPxMif3ckrDU0AUzl/OZTazmSA
         i4kLlsKkdisIuliIZ8vNKVt/XeomyfsUKhzxlgUOazDc3hVA0r6md6BCP3+LjUUiRhS2
         50q1RKTrLlzW8zrWMll4I69uVLB2M1nrCVSMyUMsiAirkJmPxWLYuaWxEqtdPOpDXr2z
         cGqsI23NnNN9MZYOXyDv4+yOkuPcJC1MThkDwUylbK+pmlYVe1Wg6EYHIHqT4wv+wDaB
         wr+vkFoWSyoG/k/RZASha2ikfdox2yvkLG/tR3vHKyh2ZqyPZ1rqPEtl8eBdJn8fwe4o
         w0rw==
X-Forwarded-Encrypted: i=1; AFNElJ8xJUYOGhYTMyDTF4CPexzdgIcG6R0CcKOzBhVweGVg78+lrZqv1xnhm3Rjykznhs1dOtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rYKU5xRGwSeFbY1X9o/Sk5+gst1qBIKuYwk+HzTUNdPA7P4n
	KB2tfd11hpbIkIS0N7oeBwaRlt7+UISS4w9d7dDEwt1luh+vO2U/Jqqb
X-Gm-Gg: AeBDieuAcEhKZkWUNi9kG3PotnvKKZdWvH2HTNsDrJM5Cr0679KvYtiCFiUGzkXThHK
	1JX5gzSh0TcZJmVK01/MwPpnZIcptf8Ld039yfr+b6IWELENakCA6sOuEdGiOtj+lrnR6tIzBoR
	MpjOg693e3YrodAxYyn//hzkK+B0jDKFvRIj93l4WWDonwGlkGge3HrWCmgfx7w+7Y6AzmkK8Oj
	MF2NHkaEpXxDYimMDe5gcsJlgwS2LsmlS4x/B+B5m6cSiOqyg9XrF3fCqxlH/WHEcpwZaklAI/q
	nq4CQPHnncsFV/9eDcjK1Usoz25LMHu0CvHrO427IIKiEi/HenAk8Rz+PnhJNuZYxLRKXbyw/s6
	ggfm1NH3Fo6hOB3NqvHk8Et4GX/dvSQkWQrY3zJ9faHmJRDijKTQDX0jXTj0WdDbe4k7cGOllun
	mFpU21zuSMCwJk79gJpic/LteyqBDMHCYEZqpItkTtBHjzUhPYIfntrvoyebEFKKNnL02y7Ioyt
	xKU3R5KOVI=
X-Received: by 2002:a05:690e:484e:b0:653:f75:b7aa with SMTP id 956f58d0204a3-653107e2044mr9666234d50.13.1776717254224;
        Mon, 20 Apr 2026 13:34:14 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:adde:1cbf:87f2:a99c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e81399sm5702955d50.14.2026.04.20.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:34:13 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] Allow storing referenced struct file kptrs in BPF maps
Date: Mon, 20 Apr 2026 16:33:04 -0400
Message-ID: <20260420203306.3107246-1-utilityemal77@gmail.com>
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
unreferenced pointers.

Justin Suess (2):
  bpf: Implement dtor for struct file BTF ID
  selftests/bpf: Add test for map-stored struct file kptrs

 kernel/bpf/helpers.c                          |  16 +-
 .../bpf/prog_tests/refcounted_kptr_file.c     | 246 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_file.c          | 152 +++++++++++
 .../bpf/progs/refcounted_kptr_file_fail.c     |  35 +++
 4 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c

-- 
2.53.0

