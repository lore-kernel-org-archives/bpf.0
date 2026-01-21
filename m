Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF443D2FED
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970642; cv=none; b=ftaY0+3tICVuhEwNvI7e3XWnLJeLmcaiyrPasKEHWmfAt5xx2MYDgiLQAWQg/htgx8JB4viMdSK8AI36wVbXfo5aXkgFE5kmehORKSfW1Lf4GoEwJZPmS4Guiuq+pPrJUKvNYxadNVmdaeoI85bitJK4W2E8Yvnu5EUTnnOOPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970642; c=relaxed/simple;
	bh=FhC8RW2prkqyszPdQGspTuPQvjqHT3cnRjk7WqnWHUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLc7hS+udQdjsTPIKYQmTdWoWAVSbwO7hNmGIsWXRu1QxpnTJar4HpHrPgU58ZP2o9qULMRH4x/FspNwI2utA8UglTmRbqkXP58Rx+R4LOUR96KnohkN0Ki6BMWPElY6yrHb2331ZM0dkpquOeOLAIjlAyp72V297ie8Cbi/EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWT7qKPc; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWT7qKPc"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a12ebe4b74so58330835ad.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970640; x=1769575440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNRRtAkD4CMLbrIwXeb2fCZrWubFbnyI5Z4ZT4ZtQP4=;
        b=IWT7qKPcH8ddSwu19c5PvA/cqk5sdtgK6oSaKrLQb5d421ppQpaEAPbBMznNaFqXFJ
         xg7VtoCq32HQbGXswCQEaKg6ch6kHMnL1rGo6MSmUlPAS80aDhzYNtMUf67ULL3L/Jxm
         GTbupBkVG3s+h38OO9YLZfEouaylKope7oLTPld8U11cOgptKLMJDUY8hC7onqVy//gy
         hVWsS4mhBfqXhdqmKovqn0wuAze9R2q8mrv70U0bEHDULRfG1Ziru+v6dBY7nlktHEjM
         6E4wsngKjHtwAOr901AXRVv2/7lZSNJZY5F+2id1g6ds9x/oOZ5TkGjhDoyvfPhmo2XQ
         VQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970640; x=1769575440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNRRtAkD4CMLbrIwXeb2fCZrWubFbnyI5Z4ZT4ZtQP4=;
        b=T1QwpaVlYbFnArJtGFs3p9OgQnPh+QKqYwrTwHgutI1XsqPbL9xr7bBl9Tpsbch30h
         xik1hVoovirtuQR429bKU1qdTjESg33urpQz/3zX0LiyY0RbRs5O13AGQZLTV1cQh8gV
         95oMTAdv91Pp6stgL8vhHta7+d/JoHtl9xTKQkEDA497ooa53S4lodrQvnsh56ci3Z5j
         FkLFabucvmOEOshJGk6g3+5tmBSSUsvwaQ0tFtsV+cq7JRu1EJtzvRwjwZ4WzVAMs/BS
         yz1xlMY1tyaweYfGSWh33TEnqHYyf0dXunNfT98q3Ub0wtRgYpStNRjzkZ+mC/Bh4ebb
         qeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCNQE3xiN158fHWJfK43JM5vV80IAHO9WAxzHmMhcS16VbaRqUHwnECLO0Qv9jnxyLyYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD46ScBUZpejypjf/kgjiTBfzykv8HvdvFtHOIMKGxr9KCrAmr
	h1dyFlQGsT8vzn9zAf4aq6aI/40yWqwCN85mBBVvF1mcswEC2bPBRcYa
X-Gm-Gg: AZuq6aKaiUYyFRak4oDF7/3ChTd49I5oMgr9TGzq/WdXCcHE88jnvmxZhsuO/v/Ev2m
	fTu7U+wY9fv0qW8pNMj4COFAqmsUVWmD0hB7haFli5/HRsWJIqjqJnlemLoHC9XCVs5SdL21Ek0
	PNpTN/J52xOZHa5mNzju7OSnL6cQ49bD7lzCg53Vsp2Mgk4FnL8EaTNH4dbrbxiUG1c+MX6HwhO
	Ly5tKGVFCS5FcyBc3ByD9zRCINkup75C5r0IKadvNZn1td3YF+w+PmzdmUoqCzBrKHWAzA8m6oP
	uUt0aA18yK9rYEV8H3hY5VosBJ2TGM4einAbzqp9eV7ufaHfOZ7dJQSDCZbAt/rVEsu3Yk43Mwz
	UUlZOypav2Ftq0lyfbvCvwlyGInpIhgar5eoAU+hVGNm0nMaGN9oW0zmfkvU+9oEphs6Yhi4i7c
	DHHxjnbFJN
X-Received: by 2002:a17:902:d48f:b0:2a7:6474:6e48 with SMTP id d9443c01a7336-2a76b169662mr31309745ad.51.1768970640170;
        Tue, 20 Jan 2026 20:44:00 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm139754815ad.58.2026.01.20.20.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:43:59 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Wed, 21 Jan 2026 12:43:46 +0800
Message-ID: <20260121044348.113201-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
argument count from "prog->aux->attach_func_proto" during verifier inline.

Changes v5 -> v4:
* some format adjustment in the 1st patch
* v4: https://lore.kernel.org/bpf/20260120073046.324342-1-dongml2@chinatelecom.cn/

Changes v4 -> v3:
* fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
* v3: https://lore.kernel.org/bpf/20260119023732.130642-1-dongml2@chinatelecom.cn/

Changes v3 -> v2:
* remove unnecessary NULL checking for prog->aux->attach_func_proto
* v2: https://lore.kernel.org/bpf/20260116071739.121182-1-dongml2@chinatelecom.cn/

Changes v2 -> v1:
* for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
* check the result4 and result5 in the selftests
* v1: https://lore.kernel.org/bpf/20260116035024.98214-1-dongml2@chinatelecom.cn/

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 22 ++++++++--
 kernel/trace/bpf_trace.c                      | 10 ++++-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 87 insertions(+), 6 deletions(-)

-- 
2.52.0

