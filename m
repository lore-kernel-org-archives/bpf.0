Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E41F5EA
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454528; cv=none; b=Djuzd/JHPFag5lZeTUzSU2YmImugLTv0P/p6Yjun6A0tTX/GGdVoxyJQ+9Bk829H4eAWMrEfL/HwcvDQgAPwdJhKz3EJdPIQNMvGBByXRaqYLfGXYMlmd/kL9O7MF+RV9F/9IctWNGutttTpcHUAnWi00iTmkkkbvDyBzZU2fKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454528; c=relaxed/simple;
	bh=PdPWygi1N/a81FlK3KdNV5GsBORyPmHBUzJBD6hWH6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyAOOrVY6uiug5Mdp8Pa00dHEpjBmxndY64joPWKifCGPuD9h69ZwOOt5mE8ng/KDbqj2Hx8qaZKLwZOvPpSgsBR0RChk095L6DiXMJNag217fLfjUChpjF/uFKWlRb/Dy7o5Gyel+OEO8OXpkSKlktAvjHHR1HJfYvrY5tAsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATlbGx6I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATlbGx6I"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b042533de1so1658545ad.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773454527; x=1774059327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJpMaFVwCLUehTOD6Fc4C6jdIQA4mNXcsx/lQxwsZH8=;
        b=ATlbGx6ILVxwriK7XRGtue4NX3c4J5zteSO68b79UPGKWvwmssO2B8Tn9mifyNxCav
         GSMnfHVlNyvW2jbrQW3orODOyp7QVkiG2eBil1+UZOnmgUDQoZh1QQDaYXQYSUIGUrCf
         Xc4A/nJL/E/FQTaRVPSzFUoQoGVDd0k/atwkE3qEsEwTyjAB86M07oI25RAafj79ber3
         /5Kipy5oeTdAxwyA0jSe1OqSR8viihOuJyA3zBE0907+vJhx/pRbqdomCjtI1M0da7Ck
         1nLkkHAwa0x5v9eRLpdkEPbvfoTqm86le/nvy+30mQ86LW2/CkFSBzhbk5fF62uJ9ebr
         PJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454527; x=1774059327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJpMaFVwCLUehTOD6Fc4C6jdIQA4mNXcsx/lQxwsZH8=;
        b=r7wJgqJntict7W8HepW3dl95HxG0FyBEeT9d76v55Mfti36/49wUFTEkgVTO0VZ3U6
         NS2pfqf7gKoolvSJol/s3jrlZ0e6pMnwtNqfKoBlfwfYYuD/w1QqYSHm7VkurkaNt4Bg
         EXWQ6mgpEI8NJxDuIC/OkBrajVNWEPvDuU/NrR86YTYx9pih0MkIH3t/xdlBD0vAADh9
         Znldv2BrdiWoCrcqN8FxeDL2CauWQfnCnhvjSsH482ND5cMzrf6ZiW4rieMGWY70cpwz
         CT597i1JUormcU22Pziq6E8ZR4uB3z+EU9HZCEYJkXQ8mLRRquTPN+laDZpwbfaGZIcW
         Nbww==
X-Gm-Message-State: AOJu0YzMvrK0K/WIAGQ0Py6WPOrRO+MHgq7Sl93V92VLxXNxaPuuJ3y0
	0X8lPEUY9qzkBHT4ooYI3J+AjFqP/JS1wrH/1YzoqrcAeRH1oaSTKEyNPPwSWQ5s4c8=
X-Gm-Gg: ATEYQzyPDl2ME6OtT2xqhrasDhi/moTyosaMsHhq0sfkqtxrtH5jO7WkI4O5WeKhqIf
	h+2hrmb3RMXOuHscJkM3oiJt37mqMdVkvG15DFF7M1w8aXfnZwbX/zmdTFzxzKuMTnfQVjo1fT2
	vUn5Lv59hVojWOFbJOyBCKb0yaZUPSitKcM63ubMYRvtz/GtwW9RAnPRXX/j2iCEZb+iAC1OdaM
	7UgARROXMHVBdJQ3OxKCv7S2dJXEpKPD0MLfSLzq6aEEdUxZz1iThdQ9rO62iSPVoM19F4dFutV
	cN+ElTDa/Rp5pa9Dh1ZKWej1f5VN3L4GM/nYBfUIl83asLqBM0K76wEHQfIFQVT2VMswazU4CJe
	2AqaW6j6imzYpBl6owXldmdjIqMwYn1U8/QqIK1u8Wzg+szI7wTgUwHVUrtbdENo5ggJXz0+Bgd
	B8hwlNiwSUbY1b5QxsAh7uafaQnDVZXvuJby5XEKHt88+dPWO6RNEb+mgtsDkdHwb3VJITnbhMP
	8xUFO7J6g==
X-Received: by 2002:a17:903:fae:b0:2ae:471b:e55 with SMTP id d9443c01a7336-2aecaace9cdmr49677455ad.30.1773454526533;
        Fri, 13 Mar 2026 19:15:26 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece627683sm33450305ad.32.2026.03.13.19.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 19:15:26 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	danjwade95@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: Fix unsound scalar forking for BPF_OR
Date: Sat, 14 Mar 2026 13:15:19 +1100
Message-ID: <20260314021521.128361-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() unconditionally sets the pushed path dst register
to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K == 0),
but for OR it is wrong (0 | K == K, not 0).  This causes the verifier to
track an incorrect value on the pushed path, leading to a verifier/runtime
divergence that allows out-of-bounds map value access.

v4: Use block comment style for multi-line comments in selftests (Amery Hung)
    Add Reviewed-by/Acked-by tags
v3: Use single-line comment style in selftests (Alexei Starovoitov)
v2: Use push_stack(env, env->insn_idx, ...) to re-execute the insn
    on the pushed path (Eduard Zingerman)

Daniel Wade (2):
  bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
  selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling

 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 94 +++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

-- 
2.43.0

