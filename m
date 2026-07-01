Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653263947B0
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931960; cv=none; b=ax+noDr/AtYX1Aq6/4zn2NMiJDLIvBkZwQmUFtRBflAFSOpivEv8e4aHohO1REVPDFGS+G+d5NuLSmaP/qESY1Ok25qO/R/9qtp4iksvmFDR93UXgi8JGSqfENNowtXPHQom46qMsuKbAvFDpS/nlLrvlwrzQUgGMSLGdK2CX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931960; c=relaxed/simple;
	bh=PvXcoxhAH61eM4Y3LvAs6l2sIhpWTthrhMLFPn2Zjmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9Ijdykw4Z4lJPgEF0MgmvsbpPmtjftNgPBgt/BVbsTLyu33U8Gx1l2FlWTCuEKwUMK1vyILgMrkr0YpYTWwvunsyiBmdTwpiReKrU53aJVv2E+o/NX/ALMgTweht1fJ55dtaFYelQGLjC40DNZq1F8McLrvRowd/QwCRpu507w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZM5MpWq2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZM5MpWq2"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9159951f05aso74577885a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931958; x=1783536758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfy/wz4QLm/BQaQQJTGIeAr6B0Q16xkRnLNxb7Rw5bU=;
        b=ZM5MpWq2SW4+SqcQuBB9vGoSM6lMRnT3RmGj8jxVgDztiD3lOsGLTr6J7qNspOaxtg
         Cp07J1v4Dh0JgqBvHpMjHsTIa2dSrtsEx9K/QjoPlWo8Ta+njGpleJxu38WnyYyrSJ1c
         zfqXxy56Np6M2eSDArLXpgreWnqOyxP6GSyETNGqd3kT9dJJm/OGUjt4NHeIa0NgEYrS
         Dwsv5mHC5N/tNnjXSAVxAK+unjlPJWVMvaXniz9pFudl7RhELtA8uFJo//XKbl/rVN/H
         ptKz2R9dvMyXnCrONNzfZvk+zTI5xyEco/qc+DlCTgflK5R9jMQQPA7SWDCqGQ/qN9q9
         Uj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931958; x=1783536758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfy/wz4QLm/BQaQQJTGIeAr6B0Q16xkRnLNxb7Rw5bU=;
        b=Xn7f9zrWRcuZ5x3nw3AFTBRREVRsBTUy552XlkxuP40SqdheyIBgOW4Mv4ybLpISRp
         JT0PJfkMflDLTmG5t6jjtxn7Vm0aK46H7SYHBf7UdWZ55g1Hpju05Jt2JQbYOpl7xWzM
         wXj5CtDKY3V6NOraAjkWqLYjX9qxBQCFbgs/eTr7z9ijb30qy6ogrh3ppnDHeEKcuhGW
         TIGHzXlhfKWgXpIAl3MhZT31QmyTEszDJ+D283BsQSsVUMJq+mkuR/KwhsR5UZytJuKq
         Ygnks5+ocLJkIEq3NER4NLoYzTA6ynfDa82kkyT1lyU2jOlGU0WiQmvG3OGMPJ8Spobx
         TYFg==
X-Gm-Message-State: AOJu0Ywm3eJXhlBBIOQisPaGMVKLOTgoLaUIsKjbvtPv4UAf/zs4RES0
	asyvRJtu8IL9j0z/lnW0F6SRMe/mAgjlk6F2lU74yC5681J9CZjoric2L5vgXngkjjsVVPMBy8a
	Z4b4XtS8=
X-Gm-Gg: AfdE7clESgw3yT1Sy0V5p0xP9i/jJYBvLfBzIQtt/7nxLUm6EMbjv+3AK5SyIpJiUv7
	FQqi92Qido16VLx6jN/ojChdDdswgqdSVlC13IAjDiP06SnRlN8DpqwdQPIcGpcGl2THYt0Ye8f
	kYXFjb5z9hxRF1Mi/Y/UY+LacUEG+66QfeLdQPO5oKs1Qej1/WXUeqCVGykDCTIaqcwB0sitLeh
	B3I0oNAXekAKjKN9Px88H2vHGBNkn1kpHchpk9SpBTQ1evOlveOJPSPVArEFaai9ygdJ8cfWYTw
	X4DinU7h4Yn2tcZYbXeOk1M/hhJKLBDUg7FRw54MbNNyOrvGbJpe20eEqgBYmPA8PR7OWOdc7tV
	sFbdTyEqwzyPohe9VNkaXznh357HVMpb5xlV4zFR3vmOoxXHZG1ohk8pb3eI377WFZYKUXhd6yq
	Y1RpgNgT2aMA9JfpPexB3rpkOigezfk7Hk31XJpg==
X-Received: by 2002:a05:620a:a912:b0:92e:7c7e:9c9a with SMTP id af79cd13be357-92e7c7eae1bmr227877385a.31.1782931958041;
        Wed, 01 Jul 2026 11:52:38 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/5] selftests/bpf: libarena cleanup and bitmap struct
Date: Wed,  1 Jul 2026 14:52:30 -0400
Message-ID: <20260701185235.4516-1-emil@etsalapatis.com>
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


CHANGELOG

v1 -> v2: (https://lore.kernel.org/bpf/20260618085626.19633-1-emil@etsalapatis.com)

- Added acks by Ihor and Eduard
- Fix missing commit message (Ihor)
- Enforce 64 bits per cell with BITS_TO_LONG_LONG (Sashiko)
- Add test for bmp_copy (Ihor)
- Add atomic versions of _set() and _clear() (Ihor) and add a parallel
  selftest for them.


Emil Tsalapatis (5):
  selftests/bpf: libarena: Fix can-loop zero variable definition
  selftests/bpf: libarena: Clean up allocation state before buddy tests
  selftests/bpf: Add arena-based bitmap data structure
  selftests/bpf: libarena: Add bitmap selftets
  selftests/bpf: libarena: Add parallel bitmap selftest

 .../bpf/libarena/include/libarena/bitmap.h    |  34 ++
 .../bpf/libarena/include/libarena/common.h    |   2 +-
 .../libarena/selftests/test_asan_buddy.bpf.c  |   8 +-
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 394 ++++++++++++++++++
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   8 +-
 .../selftests/test_parallel_bitmap.bpf.c      | 191 +++++++++
 .../selftests/test_parallel_spmc.bpf.c        |   9 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 245 +++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |   9 +-
 .../selftests/bpf/prog_tests/libarena.c       |   8 +-
 .../selftests/bpf/prog_tests/libarena_asan.c  |   8 +-
 11 files changed, 900 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

-- 
2.54.0

