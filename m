Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB776421A18
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546792; cv=none; b=L8uBSaqcyJAI5eR60idblZrSI6JQG1KC+gTE3uFa3HPDiZaJEhoKFwoXyR9Vl0QlMH/U5hHdWz1BK/TggrtNbsYGhXZYjV1NLsnT2O++E4Kxl2uR0yDuFmsRpuHOI+JGok0ienVm6j3PW7LtsObHh9Rvy7UnMbnG9MyrxmOyNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546792; c=relaxed/simple;
	bh=3dQPk+HCmkdM4oc1KyWLLiPafQJzm2WPLYeJZdAiHrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3ToHGQ7gfVQroZCSJZZ36sWXL9rVTgO9m6RAprZoud3OQ4GhWmuRBzhZgukeV9yGMuBFNUYu8cMVT6FSpH9mQFrZW+pYQejUk3DXsbkEnoqq4aBoaV5fQM711VGs8BmSpjHAx8IfxU8Qqlko6O4rrNOd0+Dr8QVG/RT9UrpfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjvB1lfm; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjvB1lfm"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c160cb021cso1317204eec.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546789; x=1775151589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuZoC825i2i7aVuOJnrZFmkgAN4i3isjKoSEThwjWu0=;
        b=JjvB1lfmuW8YldoBQXyg5ODOzlUdWAvjPlxtcwp6mxaUucaqeW5gJI7P51EI4tyQsK
         XXO+QWT9h36dILy4EwC23YrPSsjvUHRAnbyEUdU+0BxaVfQXd4fi80giAXCQx6F/0YHn
         O5BQseSt+ExYQN6R+iE4p2JjHQHWU5gNEvTumCQIFGU/O1ltdZ4VNCpC//KKEMjhL0yZ
         0tivObWf3FeOiff0XBwmpch+esT3m6UNacP3DMj9m8xG5+Yp2BhP2lldzhiVHASJCdcV
         /ZIG3DMvNpO7gHiVn0RPonhJiXWH1yMIF6ckW5HYTfhK7AqYNp+QmrlVAoH8juMyBLwc
         3FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546789; x=1775151589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuZoC825i2i7aVuOJnrZFmkgAN4i3isjKoSEThwjWu0=;
        b=LvC/AD45GXGCn9vDfp/kk/zN5Gj0hzcvxra7gdaVAl0xBCDWbvItDbGSoNHQ0NU3i0
         9hz3bie2DXfdu/De31GOHCkAtsWiLfPpyrmTY/C8+dTTymnzZ3vnhSjBbu5a9Z4Lcwwj
         Er+hzaRAV1GtQkFGZYqsz/ra0CuHLI3RcFB/kBwvbYTOJRSEtczYH2maeOdFXcPi5YvR
         9DPwDB5536B2lQbAlIoBOULsRqA9GmrpOyEtoQGMWoPsgKmtWemo1Pk4cmhmP4IiaOmr
         wfE7Xf3NhdorGXQiWxpCuPUce5mGXnhUftZRwVZh4pUnganP2v+1a39udXZ5lRJhJ7sG
         9A7g==
X-Gm-Message-State: AOJu0YxRp0f9mLH/SQoSGHN8971ThKo8x8TMGzW13xmci2rQsfncgMfe
	03Fz9oHYqlynaK7v9xj1jKpHimr05+iJYxMq0/foLAOKOLavDGwB82cNWfqeVSvM
X-Gm-Gg: ATEYQzwXFK6l73BYoxsr0/DZfaNxUP2MXmB+6LQtcOGD71GaT5fIPRBUnCqWA611xuP
	QP5/pdYm2RVHdITeER6MrAwFwoX+coklWzXiDVYTYDmN+yZ65EYBUleHmALzTEd19iZpQvoI8Li
	qdFeRd2TcC6j3axkz9M88WF8MmthwnBDLzNJAo8kM5ShK866oJ4lWhEvNzWkbrdXXG+S0kIJUbH
	l6ckFL1CcduE2BeSGhl0M6bJ8U/ibKQ5KHFZuQ7EjLGd/FoV4QJ4/zpu6VBNFySv4MVCeygnvod
	gx5K9iMeo4mr1OKnguJzF9lOkA+PohAgCIQJzTXbPyZK69eJLY4O9kvpW63wJ7Zqo/i7enojTlZ
	gTP/QSCR+zfbrDgbdgKl9ZqKuycaEd4T9cHEZ+shlHzE4MkpzE+VFebNYIrw0g4/vBzeFBg00SR
	AYLeYTD82OcQjBsXfHYuKaFZmyD6e7C89W5kLm47JKLP5Mxs8EGbilbYzXAbAKiDwrYA8qUWyTw
	qc0hLE=
X-Received: by 2002:a05:7300:ac90:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2c15d432ec0mr4452073eec.20.1774546788551;
        Thu, 26 Mar 2026 10:39:48 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec47293sm3075711eec.9.2026.03.26.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:39:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com
Subject: [PATCH 0/4] selftests/bpf: impose global ordering for test decl_tags
Date: Thu, 26 Mar 2026 10:39:32 -0700
Message-ID: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260326-selftests-global-tags-ordering-8f324323d9c8
Content-Transfer-Encoding: 8bit

Impose global ordering for all decl tags used by test_loader.c based
tests: __success, __failure, __msg, etc. The tags are now sorted by
testing framework to be processed in the same order they appear in the
C source code of the test.

The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
defines the order in which function attributes are consumed.
While Clang tends to preserve tags definition order in the output BTF,
GCC does not. This inconsistency causes BPF tests with multiple __msg
entries to fail when compiled with GCC.

This is based on a patch [1] from Cupertino Miranda (see patch #3) and
includes some additional cleanups for test_loader.c decl tags
declaration and processing (see patches #1, #2, #4).

[1] https://lore.kernel.org/bpf/20260305130035.192080-1-cupertino.miranda@oracle.com/

---
Eduard Zingerman (4):
      selftests/bpf: fix __jited_unpriv tag name
      selftests/bpf: make str_has_pfx return pointer past the prefix
      selftests/bpf: impose global ordering for test decl_tags
      selftests/bpf: inline TEST_TAG constants in test_loader.c

 tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++----
 tools/testing/selftests/bpf/test_loader.c    | 199 +++++++++++++--------------
 2 files changed, 126 insertions(+), 133 deletions(-)
---
base-commit: 400ff899c336c24bf4d34479f98cef2fd2d3482a
change-id: 20260326-selftests-global-tags-ordering-8f324323d9c8
