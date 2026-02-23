Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F7A31690A
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883478; cv=none; b=u6KqP2v8NTiRzSCo1rvBz2uqoqLrMNRIiSy59IWdM6ge3hKpB+k4Gau3VCB2b0oJE2iElErpAPmwmzgwg1VJN/oWHnCUROPdstxQt8fYFQI8/mPvQNkn5WE7FjqYMH+OLPqQnFy1+ddECPSUOw1Cd0+frEQYCKOwG/pAcYmp098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883478; c=relaxed/simple;
	bh=beLCAHk1w8XJEaq+MkxN2I07sKvLtLTtqWq1gy/m+Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN+bC/3UWY4z3ncd+NXh43Nn6btBHzfwyVzUKyTuACsmDfIEiuh/MMBwEj3iZu44F1J+J6tLtza53w1SqVBkX4z4SQhmdOd8/ZICzPfNPepGYjQGahzDSoXbrd2gUrwKEMAJCDUdx7fmejRlHiSsr2Morm++aJeBLH1tlLC/Jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=2WkPLk14; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="2WkPLk14"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb3fb47559so456684385a.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771883476; x=1772488276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/ZVbvSJtQi0fzSPx1I6FN0DvHhGCjRqX9t7C7ErxaA=;
        b=2WkPLk14Q7ZBeaGt1Z/Pe32U5FiNhjdImFa5h8ROoKaCTlfKneA270HuGN5AfDxqXj
         T0Okmdc572k37OUb9xGcYDOoObsRFJ7rLrQymyDKpHNAAUYDCKI9zt8BDXQQEWM/UVI3
         A/ZpjCuRctxDwNMPjhKP1nvhYuunPBTLVqG23pml1JSCQkRtoltCU7ZL//j0D6dv6Q5t
         1dM+bajzDipAQUYeA6aLkOXF4jrUC1A/wg+w7vFjvKC1fM2P8VgGr7GCfUP6Ag8gZ1qO
         H4anc31Sh7qliXnDANu6A3KrcVWxS+KYdA3w8otSZ/C1FPQxUEXdv+iCIrZITBOozvhY
         9Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883476; x=1772488276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/ZVbvSJtQi0fzSPx1I6FN0DvHhGCjRqX9t7C7ErxaA=;
        b=mkS1I7SCXmK5Y65oxvI2fO7nBuQc0YC4kKjAWQHBBNUFOqn33YbSYxe7wLrQBzXQ/d
         q+y4WVFgok82sM9iUu4KGAr4BDB+/4RsuXifmYz0drV46QlH34KZydZywXBlqscion2O
         U4V2Zn3ejAFw0prxxeV4UWSZomHLThT+MrKJacVsdfduRti8qaPQFx2Tmp0VmE9WJKyI
         TNOT9e74c5UzbWJJc57yAdqXHBO5rpcWgxmkQFdvbetyIw2UhQig2qttEZqYoxGlWPVa
         YDou2BV9qSb0M4rOFQghGnA/249n0dGyqTzQfyn8mudnTkiwYRVWiDPwRG2tdolvYaNm
         3Dtw==
X-Gm-Message-State: AOJu0Yx/Nc+WTpS2HIMumzj4CLKcIPUDgDmGq37mrqJ2nmCXO/+JMnqa
	/47VXGgPlDDrHzBk9IreHNyQKZZre4ydvOk/YIWG+w75oU8B/Hg4abZZH5O8OYdp4WdPaMPWrhu
	DFfhtEl8=
X-Gm-Gg: AZuq6aL/jNdaklUsN+juhSWDFIkuTHbAZlIxatnVHs7kcwFRfv+qb5NYs1Q8KhI+oAf
	BhSlBxWw42w3F3LjRgxWVFHqqEpduGkKuWn4IqTmbafIDCD4Thda4Ii6fdebuju+Pe2VNppRUnc
	p4fPnwtc4SIVONp+dOci8GPtWb6+cb5r/7YaIuv5ERR60BLqvLzdgY0GoJWlunGjIbrmCGLPwYH
	EE1xQfMexmh5z7MHHga84gGWEfIL+B0BWLcPH98vyMGBYLAy+AW32aSoLdyDW/M5s6BLJky+5VX
	a/tf8HXfvly5N0X8kXhv1oEovv5Pbyy+QoUozbZxmw/m5fhfvBsxlxFn/41hKCQ5Q1GUyCGlpKe
	rY262up9GvPY6qj3c3qWFyPQg/3b7kGrLudjcLmpb57PvBlNoVz4nWSsvYEZr/r1CvhfvQpNGBt
	isYwppbo7YuhP54iDfQ6CMxw==
X-Received: by 2002:a05:620a:40c4:b0:8c5:1f9a:6b52 with SMTP id af79cd13be357-8cb8ca0dc99mr1181155485a.28.1771883475937;
        Mon, 23 Feb 2026 13:51:15 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d100c18sm815115485a.38.2026.02.23.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:51:15 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Allow void return type for global subprogs
Date: Mon, 23 Feb 2026 16:50:44 -0500
Message-ID: <20260223215046.1706110-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.
Exception callbacks are excluded from this change, and still require
a scalar return type.

Also adjust existing selftests that were ensuring that global subprogs
with void return types fail to verify. These tests should now load
successfully.

v2 -> v3
(https://lore.kernel.org/bpf/20260210183257.217285-1-emil@etsalapatis.com/)
- Allow freplace for global programs that return void and add selftests (Kumar)

v1 -> v2
(https://lore.kernel.org/bpf/20260127231414.359283-1-emil@etsalapatis.com/)

- Only mark R0 as valid for non-void global functions (AI)
- Rename subprog_is_void to subprog_returns_void (Kumar)
- Add test that R0 is invalid after calling a void global (Alexei)
- Add check to ensure exception callbacks do not return void
and associated selftest

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Emil Tsalapatis (2):
  bpf: Allow void global functions in the verifier
  selftests: bpf: Add tests for void global subprogs

 kernel/bpf/btf.c                              |  7 ++-
 kernel/bpf/verifier.c                         | 59 +++++++++++++++++--
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 24 ++++++++
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/exceptions_fail.c     | 19 +++++-
 .../bpf/progs/freplace_int_with_void.c        | 14 +++++
 .../selftests/bpf/progs/freplace_void.c       | 14 +++++
 .../selftests/bpf/progs/test_global_func18.c  | 23 ++++++++
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 9 files changed, 151 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.c

-- 
2.49.0

