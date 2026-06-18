Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E13264E7
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772997; cv=none; b=lmkT+3vCfcylmv9Ies9RFBNz7awXF2OVodo5q0sIZFnfjwAZPkOmNhQHQGfjMj+633pNR8xedzvLObBx02jeUiUs478ql0NEKMH4lsqiD6qtMMuP6Pkpkoqgqf15TITKFcH6aveqgXuLXFDQIIIA7buqcxkQ7wZgJq0ulXZt6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772997; c=relaxed/simple;
	bh=D+TRfqNC/wX0+3TWUzbIx4JHivaUuQU4Umra9lIXR6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hz7b1fvBFrz2XqEo2/rmkd8QIjJSiNCmI91zS1GsVIVYNPW80W4WxhyT1eMDPpEtQhoS5qn07HutkPq5w72ad4UUslf9Y3RnQGLc+9cyzQSCWY5S6mQWo88BBhNkl7stVzvYs+rwii406ano+P+DopkISkt3NhLsUoUsmaDOds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qEPXzd9q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qEPXzd9q"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37cb36ca63bso343817a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772995; x=1782377795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tYsJeDISEnHkpCo03I/9U3UkBZ0dT7/QJpkAWkdrLI=;
        b=qEPXzd9qJBD+j3CvRC9eWrrWiDD1xa1BDbmke0BDSIVz1g430oWPw9SqWQKwGIdprn
         6M6LLkrtiUViiM0FX/uS7zUHMdGyeitnRVG/dAR19vLGdQAwRGYEAZiuEPaZVoUq76eg
         OuaGP6goL5SN/89XvjCX7Uov+8/1gopwLHeJHKFbCzQQCAfwb8Y6I9DJ/iO4u3aU1Wu+
         YqiBL7F/TVKEwSnmGDoQaji13trTyBrudWo/c0c1zUAn3J95HC58n4y/9Gr36Mwb1vcI
         T2H3GRHgjDH5lOOAE6jXM8OkkmL2jKNeajEIHjWMWvpLQQZuAklf+dYu3a72wGhDU4yX
         8bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772995; x=1782377795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tYsJeDISEnHkpCo03I/9U3UkBZ0dT7/QJpkAWkdrLI=;
        b=pRFEgxppqC522Aj1b7Ala0I544yIq3zL5dyfkiHfoDt3PfTLyrhIboZvlRNe97OxsU
         9I8RxdudYW+J9JMEwMa1X4RjMIWDMpzShFjagt5vwgAqHhy3lvVvIIcjFFNTrfhg4OZv
         02DXjJuaXwEr44zc/+Cz4Sn1TkRY3GityBTZezuE2UMIlykPBaX3oV227CzSsua0dP6/
         DMCJ2mnLq1d2nb6w5TLFW/6QUkWsBXxwXWUVwNEi1zzuJ8ZWDMr/X4mvgikYoD6+zCu+
         Fu5Inzh5moW14j/mgsmQUmBor+70vRJzJLHg5HvMMvN5JUsdIpRIgbW6ZMwtkJKm3jnm
         /RHQ==
X-Gm-Message-State: AOJu0Yy/6G2tM3kIZ8RvsZ4VBzzL/lDz0/jbkLY4bONH2So3pB2TVk7U
	rp52G6sTD9uqN20L9kKYso8su6qvhOgWcPbyDNUZO+ubDiFWYmTO8Khy8YSdphqLrsQ6M2GLSZu
	aME2mvsqL1w==
X-Gm-Gg: AfdE7ckGP0hyZ+Z9widnZOPWG/43amzaQ5Ab9LUuKrZycFrZXJbND91EmawieE7+HO4
	WW5nVFMNh/LYWF+QWnRz+HXGc6Vm3H/sNtjpZNFxNj7hgrTEpIdTfkNr+PqLUR49Lm9jquJHAT7
	lYVM1JjrJn63rO2uzvCfcst+2xfaizo7iTcAuN8BKcmY2ocbVgvhkraYEwAkV+CmI7yJYbz+/i9
	b3Ah74VcjFfCVAa9CZI9z6ArKREPPH4Ebo29KbZw18xBT5ma3FKtry7CMW4qvnuWU7PWHYHzd+O
	WMzZRYRWm81ghZSgpmV+SIBoFF25/IMgQ5SYdt4wbmlLgGzeTYAIEGRwgSMiktK04ZWRY3Jdj45
	iocm4ZwtqFC5VjU4zElc/O4nfZ6ENmMdLsZjrdyS9BjIDGq7F/JadXMnvHqwp4jcWZSaZ+ILt1D
	qSvPsTXqaKOmu3t/Qd52PTzad+tQ7if4dpOE6xbXlpbm7UCmMfog==
X-Received: by 2002:a17:90a:fc4e:b0:36d:b680:3036 with SMTP id 98e67ed59e1d1-37ce44ea15bmr2786398a91.4.1781772994894;
        Thu, 18 Jun 2026 01:56:34 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/5] selftests/bpf: libarena cleanup and bitmap struct
Date: Thu, 18 Jun 2026 04:56:21 -0400
Message-ID: <20260618085626.19633-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup patches for libarena, along with a new bitmap data type that is
in use by sched-ext. Patch 1 is an NFC that properly renames the buddy
selftests for consistency. Patch 2 fixes the zero variable used in
libarena for can_loop based looping, and afterwrds removes all bpf_for()
instances from the code. Patch 3 fixes an (untriggered) edge case that 
could cause spurious selftest failures. Finally, patches 4 and 5
introduce the bitmap data structure along with selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (5):
  libarena/selftests: Replace leftover st_ prefix with test_
  selftests/bpf: libarena: Fix can-loop zero variable definition
  selftests/bpf: libarena: Clean up allocation state before buddy tests
  selftests/bpf: Add arena-based bitmap data structure
  selftests/bpf: libarena: Add bitmap selftets

 .../bpf/libarena/include/libarena/bitmap.h    |  31 ++
 .../bpf/libarena/include/libarena/common.h    |   2 +-
 ...asan_buddy.bpf.c => test_asan_buddy.bpf.c} |  10 +-
 .../{st_asan_common.h => test_asan_common.h}  |   0
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 314 ++++++++++++++++++
 .../{st_buddy.bpf.c => test_buddy.bpf.c}      |   8 +-
 .../selftests/test_parallel_spmc.bpf.c        |   9 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 191 +++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |   9 +-
 .../selftests/bpf/prog_tests/libarena.c       |   8 +-
 .../selftests/bpf/prog_tests/libarena_asan.c  |   8 +-
 11 files changed, 573 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} (98%)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h => test_asan_common.h} (100%)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
 rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} (97%)
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

-- 
2.54.0

