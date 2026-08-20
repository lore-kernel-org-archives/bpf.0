Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF2449B31
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231916; cv=none; b=Ba3BbS14GKrru1BYB3oqtthxFLGHQKzm6M9MpxaqGhRX98nqf1mkkPBQvW2h9piLpq5zLUyUtvyepLE6lmufUyl5LVqKtdIWuyWGT+UzY6DWUc4+cncK10psRjaFwjZ2vKUOKgjCPtLRPc5CCGS+pOT0CmqpZYrH2HAR5WY5hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231916; c=relaxed/simple;
	bh=oDIHiRJWd8jowEdKmYue6RE09apAxh+g+fTha5bcIKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fV60o6rIsIPmwScXD0Tc40oiNDQlRf9fG+gyclYyBJd3UNGZjqSB5W05DKrRWXWD2lCVQoWWb7FUObfmyXbECsfSdXmiWhxbmUqPCpuJeesOCwqGOIRyShlWHU281ZZfeE9smsY7q2k/fPwexCJMnoxMfRvdlnFUmgjy/w04wZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRsPvWYn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRsPvWYn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso16258145e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231913; x=1787836713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=apFi4Q/ckwbxAw8rS1lyMwC3AIg4V0MFK9+reDX/DIo=;
        b=rRsPvWYndjOhBuX8i2aRrpmU1Fw1xixsk4kzpKuLBvukPcwRKdn2bgfgCtyevCOJHV
         Kv19tJlNIctGJZqQvrnYI6E3i9tQs1Rrk2wPm9tERDLNl6RvxRLanif9e4kDaiUk6gZc
         +DslE8NKIyLR5uxmrdMhJ7buF7f7512uoq0qPmIfZ4pEKZUinKjXAhTJRFO63PXXVN9h
         ++hk0F4zzCSzllxbkVN7GeVJEGfV+w0H2r24BW8Ysm+47xMhrgtfbNlmZ3UAzyIANBgd
         Jk5n1YK3QilR2R3LW4hxpPtZZJZaVtB/o6xihMKTI6XH3UONMWIBzJbfeebu4nllXx5B
         9xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231913; x=1787836713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=apFi4Q/ckwbxAw8rS1lyMwC3AIg4V0MFK9+reDX/DIo=;
        b=r7pehHxyDmKkDrON0zXd+h0Z/9cIhkyKmsbXt55XdTSZ6m751NMFiXzuXZi3x3sZ8O
         ZrXOOi2rd11WZ23ZFR20LISsqJChRy19jgoNNH9TQBW7NPFa/GMUqK07bdfqhOGc9nmL
         0brP/juEOs82LudSjjhk6JbO6IuPLhrb3XMbTu7hhcy8f0soXqkxLCTEtq5jJQsI2Lqe
         biWicRqsYO8MnM2HjOFN28CElP6aSfUvSIFseQ19ohklD5otbCjg06NiMfSDa+IoyXGa
         MmmbRaX0k1w/P49/Gm7PlMrhpq5/vVasnaVpOv4IZB5zk3ttPZ6NibJBtGEfQcXPd7V6
         H5hA==
X-Gm-Message-State: AOJu0YzdQ9Tjzdbd80r5M1eiZp9XAvPrETOH1rVcRjUz0gElpdcxJE+e
	035rNlY8jltuGjRvwLMpLw7t/KFnpVLpL5B1xbGjdtrgaJZOsn5dKP1TwLfQrK52VWI=
X-Gm-Gg: AR+sD12Mug+6u65rH35KX0cevbTlCgjvi+LRoH6G+xoMq/2OZjiNH1C8Yd5m7r1gqDF
	itFjOxDlEy52oTFjaq1lG1GiE2qg/Xck+PJPU2SgBLs15hcvYEF8dlbAnauOw4Tx+P9kzh9RLQr
	Rnp9yse3GjXj2Kiurv5qUIVF5OTMQfp/o5Z00++t7YwP9Zj4oeKFhYV8v2FXRuynlkzrf0VwdAe
	NO4Gy2rpZaQmieiYukBS04yn4WsRvAGoe1sL5w1ON/s6ZsMeLQnRnBgWZv+1hjLQb5aUTwPdYz1
	hJsoO/GXwLu0Xkmf3/QtIjmq8/Eyd0AJBmnzHGpVNhkx6T/DQUqxRbEMh7Rv3DmINSS8/upqYbq
	Dp+tqlIz18jYvevH71ZbW6DxiWkM0yzfReY7OYPPSXp3u/uqzvaaSi/jplNV4K5pcaUw2I2DM/b
	g62XBtrU9ZjD96JTBHUWmXlWFiTOXIyvFWqkdGcrpKBVn+Yi2cTXvMqers9x1vI8Y3fmxjrWyhu
	1J4
X-Received: by 2002:a05:600c:6610:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-499b4020c41mr41967885e9.3.1787231912946;
        Thu, 20 Aug 2026 06:18:32 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0e473dsm136027275e9.15.2026.08.20.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:32 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v2 0/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Thu, 20 Aug 2026 16:17:58 +0300
Message-ID: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During exec, argument and environment strings are copied into the new
address space held by struct linux_binprm before that address space is
installed on the task_struct. Existing eBPF user memory helpers only
support reading from the old address space (i.e. current process)
and for this reason programs cannot access these strings from the
bprm_check_security LSM hook.

This series adds two sleepable BPF kfuncs for copying bytes or
NUL-terminated strings from the address space held by struct linux_binprm.
This allows BPF LSM programs to inspect exec arguments before allowing
the exec to continue.

The series also adds selftests covering both kfuncs when reading argument
and environment strings.

Changes in v2:
- Register the kfuncs on NOMMU systems and return -EOPNOTSUPP when called,
  as suggested by Justin Suess.
- Add selftest coverage for reading environment strings, as suggested by
  Justin Suess.
- Clarify that copy_remote_mm_str() leaves the destination untouched when
  called with a zero-length buffer.
- Use sizeof() instead of hardcoded argument lengths in the selftests.
- Use ~0ULL for invalid-flags checks in the selftests.

v1:
https://lore.kernel.org/bpf/20260812111140.7762-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (3):
  mm: Add copy_remote_mm_str()
  bpf: Add user memory access kfuncs for linux_binprm
  selftests/bpf: Test linux_binprm user memory kfuncs

 fs/bpf_fs_kfuncs.c                            | 128 ++++++++++++++++++
 include/linux/mm.h                            |   2 +
 mm/memory.c                                   |  26 +++-
 mm/nommu.c                                    |  26 +++-
 .../bpf/prog_tests/copy_from_user_bprm.c      |  62 +++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 115 ++++++++++++++++
 6 files changed, 357 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: f79066c784022fda83f5936559a1af414e41b603
-- 
2.55.0

