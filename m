Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76092512C8
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775319160; cv=none; b=pf/z9ryrrWoRTbSHY39bkXmowhWqbAqZn9rLNo9UGJOvMBjNTQxTl67oYh/mDBDiQQCdRBuzi+zFBic6Wk4Vl8UABaEWomoHsJIi7VYEAe7pPNIScfxRLc1HnjyFgvy2fdtg+kHcatRENbxddlgoS5j/HMr0abaen4m8hTBDh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775319160; c=relaxed/simple;
	bh=ifsPVP/nvIT0V+xZyWyqn4vNzMPSqfXTNSXqgmdVhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuRcnZf3Vvhkjty2t/AlZd4siPkmLFvlsc0C92RsKYjAC+SDlU6v6psly9QU1J+LUlb1c9c4BZ4Q7JMsv2QmVQhvCkpny9VR4E11gGbSmW72bFRn1J5Omzglow307B8sNdPxIyHIh0TkqBj6T9Xs8UiGiAr4eQRiNRTovz/kCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0mFxZEG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0mFxZEG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82ce09b61beso1228726b3a.0
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775319158; x=1775923958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ/JGvWssQchVcCi9iClRwdwzxxko9nnAawFufCcTgo=;
        b=M0mFxZEG1XyXYETFhCv9yMo3R/AGFOix9L9VQ4wQa1ONzcQoij/tbZU4jVuJ+XDoes
         be+di8yuJnUNPkIOfE2VSnkA8ulyYyPjZtcAynU3S/toeZC8WPK+il+cGWkW5UaENGou
         APgoBPvr1oUnCBePsAETpmY3GEwT08YQu8o/6n2VT7D/LG/vrHVweRRcITLjRGYBLbQ2
         gjSkXi0FIuBn/Sp4Gkib5mUQCHaxuf4MgeiHNSSOCUKbNCcVeAse9lO/1rjXHmxLghbl
         j7Qu1yzX/iizrPXQmbPeGxt1l4KnvBcOtvAsm3P2VzGjSt3zme4/kIf3Pe0sd7nuQ9dV
         DRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775319158; x=1775923958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ/JGvWssQchVcCi9iClRwdwzxxko9nnAawFufCcTgo=;
        b=rDFE2AEt7tzLdm3qd31mioQDv1WXj6wcN2adVO+Gsv8cTWtRiVqzDmuEgguotBxxdJ
         +ddW/EvvuhBzXkEyPIOtU8F3Ya6SiUsRVk319uz8y0tR0hC3Lr0gZYwYWl/Xr30ifi1m
         v4JTjHRlQCY0j4C34s1lPwNlGjFHKzpj1R6eJJj+QlTCk/Vhas/wyyOQajq+ycDdtrk9
         0ZK9vQISZDDU7qgQASoDMfAuzXVwEDjXLcZKC5YSzvbHf5JGjl8c95oQbmK0U3S2U4RN
         miGS5EgZ87uFoqVu2fnuOZJvRQ9AIBlNyStPFLpw+Cmdpsv1oho6vc2OUAbcgsta7I4P
         ZEhg==
X-Forwarded-Encrypted: i=1; AJvYcCW+SOv/Ink6McxLPGGzWdLiPLF2L0QU2p6vBC/Gy0eSwJG6eR+5cCchRk+4/7WTaVuIJyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzKFQ0eABewZ220W9aa8dnXzHytJABrqmmhgEq4OTvGTNbrKy
	4FZpIED/c94O/y3lTIQmUD/XBjTeOczrBhYALMIdbJAEqoljrzxFazKn
X-Gm-Gg: AeBDieun4ewCFGlEpuJSF/vBkNch7I3sfLyQh+M1DywrdRyRdvSL6eowxMdu9TYdH6p
	ghTeVWemJ0xnhI5ZlLCZbPIRocFkZZdDDzn8Bg+J5Q6VBoqHxx2TV1bxtb9RLm/a/QZZxky/ON9
	lvesuimGFqVkKh2vTGeAMp+4Sv6OcZFq33mDAfu49dnffdZ/qIzcvKejhz+M5XR7ToU76eastq1
	AZU3T9d95AFqANgKs7L3NjyZIXYmp8ZWFZRTUMn74if0l202Gmpy6Ya7/Md1F3gsGL5OA4+QkpU
	3m3fBiRilMwDmJKJiZe8TLNN3JKoSLZF9wWctieLLNKZeqmjgmAPGAEB/phpjTt1Cowivs9A3ZJ
	ZouN6KkEv0Nx6fXVFQjHK0sLLbPYOnd/b0qHWn7i8AlnXkJfCsS2pR6x/TKf6cs3bjwwDbU8N6H
	RokEx1pI/PkoyDdphXFmBnHjlfWdxEGTEjYRiKYLtRTRCxcw49CFyjeEPAXUo40y7BuL2wm5zvP
	3K6GNBKWgPm
X-Received: by 2002:a05:6a00:414b:b0:823:1d05:1660 with SMTP id d2e1a72fcca58-82d0dbd3061mr6998460b3a.52.1775319158118;
        Sat, 04 Apr 2026 09:12:38 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm8301526b3a.23.2026.04.04.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:12:37 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: reject negative CO-RE accessor indices
Date: Sun,  5 Apr 2026 00:12:19 +0800
Message-ID: <20260404161221.961828-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_core_parse_spec() parses CO-RE accessor strings with sscanf("%d"),
which accepts negative values.  The downstream bounds checks only test
the upper bound, so a negative index like -1 slips through, gets cast
to u32 0xffffffff in btf_member_bit_offset(), and crashes the kernel.

To clarify the kernel-side concern from v2 review:
tools/lib/bpf/relo_core.c is shared code -- the kernel compiles it
directly via kernel/bpf/relo_core.c (#include).  So the fix does
apply in the kernel's BPF_PROG_LOAD -> check_core_relo() ->
bpf_core_apply() -> bpf_core_parse_spec() path.

v3: added selftest (patch 2/2)
v2: fix typo Signed-off-by tag (missing leading 'S')

Weiming Shi (2):
  bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
  selftests/bpf: add test for negative CO-RE accessor index rejection

 tools/lib/bpf/relo_core.c                     |  2 +
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 94 +++++++++++++++++++
 2 files changed, 96 insertions(+)

-- 
2.43.0

