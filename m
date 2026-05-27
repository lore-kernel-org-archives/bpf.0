Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF593932C2
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866108; cv=none; b=RTOUmWn1nK7NUMG4MtzF3sl3WlP9y3vknkBxJSWC/dwXPLnkZTITb++nEX25ISU/8radAzUIw3rsHY5kyC7KgWoAy7HY24GRvFjwGX2pr0+lmpMuWhbliySnWIRMpBO3WCxItjij6/SQzWggW1McK9JLDc9aijrY3Azgtt7Q1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866108; c=relaxed/simple;
	bh=8YjoJC7JrFb0O5D4rxCQEdAEpD874yJGV6fKbco8Q/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhgF8HhTiWetcH8m+0XUPjfrngaGaG0LdbpUbv+mb96hwXhDcu6j6+ramPLsrK85lG926w0prpb1dycMbSmvTRyuaCbsHbgPQMCG0ryGZ5jNO4X5WzCpaZU/ir1NMNW1c0g7nDDEgLsWWqCIIdF0+y3t3mKx16yYXMIPbBSNAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GeDzwp6d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GeDzwp6d"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd2c147abaso68919275ad.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866106; x=1780470906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ctTrItPSZCdwCHB8yWox/rtXz0s14p4A28GvxR0tY8=;
        b=GeDzwp6dfON11hz9fGLTsjvIBSaqVEuPjfVWteXiBycLp3gCbfKrCCFrntEwga8RmZ
         W0cUdaJP1KsZ7cgV3DDYGhBTQzVRyB5Dp5AsvpgP+gxdR4K69WQ1b8pKCktPhvv5mFZI
         4GVJKO+nPfEblsU39gKTSARuIt/pSyjBKhcyoNnIoSGXsYC8fqQe0xoHukEewaWTWgj9
         qQ0zHefynRpLIub6wUdWkD4+f4vB0il4oIbKsb+mvr+/FiXaQIeX+9nLO//hHJRQ8k8e
         lISuoEWNlyfTm64EcGyT56iVsqYvaAs8wbi9cUnbBX1AxCaPkWQ+jNTJGNe5yDo4ij0r
         2lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866106; x=1780470906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ctTrItPSZCdwCHB8yWox/rtXz0s14p4A28GvxR0tY8=;
        b=ke6TPMrjXBRznbpIoX5Ag4CWMa3xJcVpNSKaRFzZ0Q7gn8frTl++M3DBtsfNH9FQYE
         G4o41iyciGpBLYKGczdwhsT6P9wDgJFPa5y/yhIXtHLelWlEt8W1lL7lkyxlwAxrGLSm
         Y+1jKOJ/ZtxZs/cNRE4v5ZsQl1j0RKCSFdch/pNQUIqc59NUrL5u5FMs58Qc2x0XTpjr
         zXDKfZPAvslIUn8lGCyL496VUhKWBujNTE4c0Zyy5Hoiwbd7wJ48aUwXpthXpUXoWgau
         OkvshK8HNbPmpqBM1D7Jfm8x5MCZWTG6ajKv7KfrJeMuKk5kbjXJQfEsJnum84Xbrn2k
         5SJg==
X-Gm-Message-State: AOJu0Yyo1GBmfosXhZxzWsvmdoxD3J9orm7sJORd5MQQj1sqtFX5xMMP
	Hc5553PnJIZXEHAKHi6vN739BxnTdCTzu4Mjq4kBZC4dBCNlh9mNG5lcaDYFg1J1PwtV8Bu1ax4
	S6uxDADbOvA==
X-Gm-Gg: Acq92OE5KRiandoLciPseSXO9srEz92s7UjTvaJGJZEJWVPp7JRg70wGmXwdcSftCUf
	jLi1tdpMzVGGO6ec5SkjbTQWIEdvAcKMqoz072AdAu5j4psia6OMgKPZI2mRzd9GyoFen6tNfiZ
	6x5B7yMu9vGNz6bGQyvhGU96e89RMVuDYcm+bMRvf3/f1duSrkBSzqtt4WGxlO3zj4XDOTTg0O9
	q254lLXF0CyFy9w9HAO3ZyO2RqkKbcv+pxiKJC8guDGJdh127d3YvLeH0+Pt1+i1ygjvBQLjj9S
	jYtpVOVn6n8fVjyMQXghUwYsPGV5PGItk+ZWHlK9Jj4n+1BpiWEYYZXYMO9SI45FFLbqeSu0YBA
	625EG8XIRWQZu+0acsR8uNXlMYB0tmSDtu9cawR3C8hd8KLKkP70TLijF0oSOTkN/wPHP7ETtZY
	RmY6gKh5CUE6mfK7XhnQNc6X2j1ddHOvUXw1M=
X-Received: by 2002:a17:902:e88f:b0:2bd:5b1c:f78e with SMTP id d9443c01a7336-2beb05fb117mr240141015ad.28.1779866105934;
        Wed, 27 May 2026 00:15:05 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/5] bpf: Minimize annotations for arena programs
Date: Wed, 27 May 2026 03:14:52 -0400
Message-ID: <20260527071457.4598-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs must currently include code to address two limitations
of function signatures that include arena types. First, arena arguments
must be annotated with __arg_arena in the function signature in addition
to __arena. Second, it is currently not allowed to return an arena pointer
from a subprog, even though it is safe to do so. These limitations require
extra annotations and typecasts respectively, and have proven sources of
confusion to programmers.

The patchset improves arena-related function signatures in two ways.
First, it removes the need for __arg_arena in function signatures.
Second, it allows subprogs to directly return arena pointers to their
caller.

To do this we add a new type tag to the existing __arena annotation.
The annotation is currently an alias for __attribute__((address_space(1))),
which is not discoverable from BTF alone and so cannot be used to
determine whether a pointer variable is an arena pointer during
verification. With the new type tag, we can determine whether
either the arguments and or the return value of a function belong
in an arena.

We test the new code by modifying libarena to take advantage of these
relaxed limitations.

Emil Tsalapatis (5):
  selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
  verifier: parse BTF type tags for function arguments
  selftests/bpf: libarena: make all typedefs pointer-based
  bpf: Allow subprogs to return arena pointers
  selftests/bpf: libarena: Directly return arena pointers

 kernel/bpf/btf.c                              | 170 +++++++++++++-----
 kernel/bpf/verifier.c                         |   6 +-
 .../bpf/libarena/include/bpf_arena_common.h   |   2 +-
 .../bpf/libarena/include/libarena/asan.h      |   8 +-
 .../bpf/libarena/include/libarena/buddy.h     |  20 +--
 .../bpf/libarena/include/libarena/common.h    |   3 +-
 .../libarena/selftests/test_asan_buddy.bpf.c  |   4 +-
 .../bpf/libarena/selftests/test_asan_common.h |   2 +-
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     |  38 ++--
 .../selftests/bpf/libarena/src/buddy.bpf.c    |  97 +++++-----
 .../selftests/bpf/libarena/src/common.bpf.c   |  10 +-
 12 files changed, 221 insertions(+), 141 deletions(-)

-- 
2.54.0

