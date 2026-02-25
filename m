Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2226ED3D
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990443; cv=none; b=YflzBAvXTSNR+fkQlhz04ElkmrnV8Yd+iob0c4uuKpLW48HQi0OxPGMbLtcMlFacMO2/b0U5hTc+2uHI2clFq8DHpw8gQIeNsbVf2j18T9IARc71GRXpjkDy0ZyHBb/LNMIRRw5sna2RS8G2P+hS6rovwjcfs7/DIZAPT/xBKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990443; c=relaxed/simple;
	bh=VDOR8HmyUTof1R2cxgjkd07I/jVU2FU/R99l21t8Atc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGBrwOTta3EZu1vPgOpKl57nFlwmQ4HqdcrsWuCwmgh5ogDKTkHDE0GYsNQIEqzjzmcVrIquHRnkTcGiF98Slkv/+myuoexxhmdtMVUu00IGkkb6c7sJ1DAIGQzHThEpNqdQ5hk57leAydSSqeEURXyX3kMe0w4WwRqruBaV6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=pKz50KDM; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="pKz50KDM"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a5cb04f9so19429666d6.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771990439; x=1772595239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqaFH8kvl9LCvtqfPy6LybuZnfpibQS8Hxz4dzwFELA=;
        b=pKz50KDMDxfGdZySRoGhLcckddXEGYjCbOWxFvNs1opJHV4Z8U4B111Unv+mRaVtIL
         u2X6IRjmLLszl5blayQmnRo7l4qY0b8S2pFT56OXTrXqjydZdOF1K1OHPybjGD4JpVuT
         MduMrk50EM6/61IjXK2sSRbBVcKhge9YgG3H7tUfQisMYJ5/byC8IyM12Y+yoKnws8BX
         kKyIM9tlh7Tx1aLXegZce13mC+PGQ3kIQA2lk+M3bMtJ4AdovXvF+/yTy9cOqzdcYPgG
         FNcq7OsPh+Zh70tsywHpI+qViiquEzb/uJ33u2W3JOWl3BwUmcILUVKgweY1Z6klwOY0
         RKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990439; x=1772595239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqaFH8kvl9LCvtqfPy6LybuZnfpibQS8Hxz4dzwFELA=;
        b=P36oN7Jxwst0vOgV44Zme25ISjsi9X0931bHxy3LTn6PTJFcb0a9t9W1rp+wPaHyPT
         Z3/8hn+MFhvykZrsxv63bCBUF6AkS5KekmIyiMvYvcv3GmHwoztzBTJUwnY50EYA+q5k
         AcJ4KKxO/cT6ZKUzW9V8V37T9JZ1aTGy/Gzh8fDjQr7rEnHKgFBgijrzenohZNIM34+7
         CntrwXaNDMWxINZmqFzALnBhGD3km2lUpK705Ad2aCFy3uTEGag6PwKk7388jO4s1v0w
         TZ/M9RmcZG7RVaPgygE5UvY3xket46TD3qXK4vMdyhLEbDwOlS6HwcuXNpWoTa0H+ktw
         3eYw==
X-Gm-Message-State: AOJu0YyqKVcUb70azqG9q9iRXKL/IOu5g/c45ltWIojBpQ934j8HWhgJ
	5j02EgTnQmSAtwLs3cxgCm2QKCglrBA5KDmXHdjYrESZKmW8+P9HNU5fDk+Gpz84dONMKJhrQQD
	QnznDyj8=
X-Gm-Gg: ATEYQzy4u/XevFyfREepg9OjsoTQOvyAVjXQOkefIyF+SjmLNEuGj1qVclFIALQLFmU
	bpU9WD/xcpCDabfsmrSGAfjrNFB6/HoItl4V4dpETyVw58kCOUHBTpataqBvidOAtchaAoQN1BY
	JHCzFtvsxRtRh/l5Z4ys24QlYhtDimtNYVqnTMoxxXTlsAA8pXBLw0jDsjNxDgPiM6ZquezIqqs
	/LyDyhf0lDaD28NX7RcLyRIvyw7mD7J5tPLeJzs0s5JIk/CYBGKvtjtUWknwPamO+8TP3L253h+
	pqviaiifAcWV2wcP7S++S2rubQ+bW7aHUYPjUXJgonXl2sJW19rdRfoXFApu4gG9NJZFcPbkjeQ
	+iOqLKZXBH5jMZ7b2Az9iWdVorohD0VylPyxRpXEWgKYMqcl50ZmVQeH4nbtXLv84bFD3r08BwR
	+2ptDVbG8w2Sg/wD3KOZCbvQ==
X-Received: by 2002:a05:6214:21ae:b0:88a:41d9:23d7 with SMTP id 6a1803df08f44-89979d3609amr217800676d6.39.1771990439588;
        Tue, 24 Feb 2026 19:33:59 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm112207986d6.44.2026.02.24.19.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:33:59 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/4] bpf: Allow void return type for global subprogs
Date: Tue, 24 Feb 2026 22:33:52 -0500
Message-ID: <20260225033356.518313-1-emil@etsalapatis.com>
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

Adding additional logic for void globals significantly complicates
check_return_code(), mainly because of how the new feature interacts
with bpf_throw(). To avoid complicating the code, refactor the return
value range validation logic into two separate functions, one for
program exits through BPF_EXIT and one for program exits through
bpf_throw(). The changes are non-functional.

Also adjust existing selftests that were ensuring that global subprogs
with void return types fail to verify. These tests should now load
successfully.

Patches 1-2 refactor check_return_code into two separate functions, one
for BPF_EXIT and one for bpf_throw(). No functional changes.

Patches 3-4 enable void globals in the verifier and add additional
selftests.

v3 -> v4
(https://lore.kernel.org/bpf/20260223215046.1706110-1-emil@etsalapatis.com/)
- Factor out bpf_throw() return value validation logic into its own
  function (Eduard)
- Validate the range of bpf_throw() return values from void globals (Eduard)
- Move new selftest to verifier_global_subprogs.c (Eduard)
- Remove unnecessary verifier_bug_if() statements (Eduard)
- Add new test to ensure void globals can call bpf_throw

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

Emil Tsalapatis (4):
  bpf: Factor out program return value calculation
  bpf: Separate bpf_throw() and bpf_exit() return value validation
  bpf: Allow void global functions in the verifier
  selftests: bpf: Add tests for void global subprogs

 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/verifier.c                         | 372 ++++++++++++------
 .../selftests/bpf/prog_tests/exceptions.c     |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  24 ++
 .../testing/selftests/bpf/progs/exceptions.c  |  14 +
 .../selftests/bpf/progs/exceptions_fail.c     |  35 +-
 .../bpf/progs/freplace_int_with_void.c        |  14 +
 .../selftests/bpf/progs/freplace_void.c       |  12 +
 .../selftests/bpf/progs/test_global_func7.c   |   2 +-
 .../bpf/progs/verifier_global_subprogs.c      |  19 +
 10 files changed, 381 insertions(+), 119 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c

-- 
2.49.0

