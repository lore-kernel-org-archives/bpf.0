Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEF259CBD
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155090; cv=none; b=QlhzlCMeTzaMfMXOca8xTib2tJbkCIssF3qYUS+p6tgrelHPsYxypkV0gtcLFhz7eKMHWgiLdpzHw9z3dcctJWRIWdYLR4pd/ZGyeMOi0KuKicKDZcprZliTB+tFpm49xWEIMU44GYL1LCR5f8B98+W/M6w7Peset59pKixNerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155090; c=relaxed/simple;
	bh=Cxk4KUYeVas/2zeF0b/EskGd7HnwVHQH3HPiBQ/wiKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANy1a13pbOP9oVVgMyWpCSYzyYtCMzb5QuwgjfJVOP35IwwmPIjAPFPchjAhd81fw6FT5WSZEtM913U0sJOI38GeyXD5WRBNgREZG5jK3310DcAD1jvMMRIj/dmpiWINVtN0K1srPH1OC7MZe0PUWNfsuPPeuKWqK+vrUnlECYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OagOhczh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OagOhczh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4888375f735so10232945e9.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775155088; x=1775759888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbPErdKfRSu3072+96tBBYfolsdbi7mY/2jqPDWMzuo=;
        b=OagOhczhwggtiHWLpf0EHxxEpgxkGVhtjaG1M6rHnH2kmnnrWuK+fsvJYWq4UY7sqj
         VAp9G7tMaNUruflsXzru7V9MfVOHboExevpWYXVHOkeTHMaemAv7j3MhAqbrxOLeaQob
         x0eMOzt+wC3BvqgeHO3sDXa0/rTvZYF5YqLsdn8e1vYQZ1yJ9YBuph/FYY/1pMjf6e4q
         2gbAU0ULStmkb9LsTNeR12OzoxoIHXyQalPY0Je4XVNiPfii8+KvW0ExQfavVdS8zPMq
         Dea3sDALiW+OkmqwvSZRbC2ui4BwaiFdmE4JEe3AOpyzYWVUGvrl+EXGmT+zNUFsmYf4
         daPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155088; x=1775759888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbPErdKfRSu3072+96tBBYfolsdbi7mY/2jqPDWMzuo=;
        b=M/LNZOvx5/MdW3TNij+FcLQpyJIZLPAYvrBJtL2sKB8ektxoMwfP2kq8b+yPBZhyOB
         0Bo+HRcxs5s+JyMzUS6V+fbs8Qm4YMu96Z/ULI+ASrRWNy/wsH/GnF955r2XBWjf+Oqd
         WoLvHzqZUNzNHgg21qevHc7fmGzps38A+LIVRTDO7sQcLGLvzM7OEEiYgC4V//SzR03p
         /QDmCLKrtn/iXo8SKD+L0A0HwDqa7HgWJ26Xd2DQ7bbHtoxfp2t7kojt8TBJltcQ5Q/S
         dOzxh7YmK90uq3vLqm8KF5KF6HexGzM3hlA3LtjDRQy3ihLX8OgipS8QOvDgEyPHM3Jb
         8TSA==
X-Gm-Message-State: AOJu0YyTqzsmD7Z0a90HhqMqbRmnTz2rUl5VnPsY1XmLiYa2CSzmZb4/
	5V25k+uQfOzULVo6HrLufbUhfVtAo1ekmPmhIwFqlfhALnuUBhtDvgYpKfPsDw==
X-Gm-Gg: ATEYQzxlCYaCzhAzJXrlOuUEYHF26UzjL6zXYwXcGJqdZ6ymZOtEEtd+N/dLGo5HV2a
	WL7QnGwQHsp1jZgkI9hg5d2RQ/NUAle73dQ41XofCzTgHcdW6eC69OZmFkLCOJ0+o4LJOriS1iQ
	a1T/bEqhvL5dwiA4kx8NqXorHZqB50BiDxILMu6Oe/d20wsueCdW/q/SpHiQr1nXdM4RVEcs4kd
	93MAIu8PRULTt4Wek3LNPQ/FdGgJuhlf6vAP1ocDdt3Yk8pTLK9uzmwVyHVsux574OOyIXxOMat
	emNYBOzfN6xQCx8J7x31fAYns5hMDJtrCeKTrBkl/UvI9zDMWxt/wUNhgY4XDuMzSBcRjZbLDw6
	j6KWiWP08vTHpeWc82own9Ig3I9G8/gZhnWBdK6G61YlPJQxl+S/UkbdzWmtbcyTbrlfZGLbw+L
	Kz71KesYXx6D9ZvZCGglgwq+7ZfoHteXILeep7J5N7vQ==
X-Received: by 2002:a05:600c:4f11:b0:486:f9aa:2b57 with SMTP id 5b1f17b1804b1-488997b3aa5mr1422765e9.16.1775155087380;
        Thu, 02 Apr 2026 11:38:07 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5594sm2215815e9.3.2026.04.02.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:38:06 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] Properly load values from insn_arays with non-zero offsets
Date: Thu,  2 Apr 2026 18:46:45 +0000
Message-Id: <20260402184647.988132-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTR_TO_INSN is always loaded via BPF_LDX_MEM instruction.
However, the verifier doesn't properly verify such loads when the
offset is not zero. Fix this and extend selftests with more scenarios.

v1 -> v2:
  * u32 -> int in selftests (Mykyta)
  * do not add offset if it equals to zero

v1: https://lore.kernel.org/bpf/20260401161529.681755-1-a.s.protopopov@gmail.com

Anton Protopopov (2):
  bpf: Do not ignore offsets for loads from insn_arrays
  selftests/bpf: Add more tests for loading insn arrays with offsets

 kernel/bpf/verifier.c                         |  20 +++
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 114 +++++++++++-------
 2 files changed, 93 insertions(+), 41 deletions(-)

-- 
2.34.1

