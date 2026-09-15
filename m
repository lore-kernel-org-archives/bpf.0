Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86439237707
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439353; cv=none; b=DwEO3c3fC7yRuFnOmJBEdPn2hDRaEFUH8KX5EhVZ5+cMVQAGjgt5VUzSkmjgY32WTWJpGRWEh4WI2nYWXOl2GmtpBN68zS51Cj2GqhMJcLt3gUUt6TNwT1tX2oMZQ2iAMCBeDAJwk6RQMSdLTeZwZU78J8epmIyi1uw256O9if0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439353; c=relaxed/simple;
	bh=9HTDFgh78Fe2GyC0xWcWnW7NoLWn6ZeHtv+E3f+HaN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTF/N0EtwOqE2cHNczEt/OQI5jFT6IS52PnXx1a2gmTYVbu29up3zFywi49usUPsYfHU6kg0NLSXj8rLemGL5e0BbVsFCvCxur3YrnfK3tE24tLf44sXW28btZRcNVljz33BCeiRbScibNXm7Fgz113MQuEhgxc10AyZfS/FWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4lwo2ef; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4lwo2ef"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e8e70fa02so51958176d6.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789439350; x=1790044150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+JbY0VAboTvC1W+pbgoHzATtoYfEqLTAWX+x7DyMb8=;
        b=E4lwo2efrDzfW7p3Amfmlb7ZM7XPdjo+OW9J4ZHNGZEVCuWOZCNSlWptUFVNPgTnPp
         wrM6Y/DCElHTHdqrJOfZOs+2JZIfpUiNZwNzKHZAeEt+cuGOkctkVVbS72dfYRqcCO/m
         oVd9plYMVnwOc0Z4++QJsR8RFGV3tiE7RelFtKlcBhjKGZGjxxIFc/U4SzRO3H6EOXJV
         h38JdwdHhgf+CKx6xaV+AoQzN4L3e0jSnIp7SbOtXj6mWaoFhTu/nbxez0l1pL1CfbiI
         i4amPK6vLaQTb9GtGxjfGV3PlzRHUzwhmNdVhyryu7ko5LeLxVSYX5W1tH2jMDjAOYaE
         a2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789439350; x=1790044150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+JbY0VAboTvC1W+pbgoHzATtoYfEqLTAWX+x7DyMb8=;
        b=avVmiWh5f9Tl9UP4Lnedta6cK7mUN3jJxUuM7sAU6qqVdt7RvRWI6FSiRSkcQmH+/u
         SGRPJ3XIe1znq6t3Jb4ht3HyMv+jo9T1WyPotM6AjDbTT5J0LaG7qnw+pRhg2snoOxnw
         wPY8rQgyNxb69Bx6zaJzVDVib79H9i2XSEBDzy8yyiEm2zHq93j+NThVNGCIKjhkFQrM
         4ALqAAqIm21fJeCw8JsTfxvCzXlsbyr9u/lcRLjYb1I1H6BSFm17vFMjE3UszNuwq3oq
         rWK+T6nhFrbaO33dUAtoC4BakgnGmD69I93UM6fH4TRbvzV9OsCow84AwhoF6tCY44AA
         y3aA==
X-Forwarded-Encrypted: i=1; AKwUvBy757kW7M5Ams+RZOkQzk5KbscL+VkPs7wpp/I8QIF5bnEUQ8pwPafRkNaKpqV2TjsfAhM=@vger.kernel.org
X-Gm-Message-State: AFuF++nZMYUYDdeTi+c79OcjR1g5z36l/pr1IypoV5RgXPGR/XYqdykX
	FcJAEzlyQ3vycWBtCotOzcqFkhgq1j06FyjWXGivjr2yNLbqnwIk84VC
X-Gm-Gg: AYBFou1d4Fw3jZzbyjbDRkfhZRpFEB6rp5ltDU1O7p0kiFfP/JtWgs7701lQAwQkJ2T
	aqB1tSkpCW5EETy1SvKicefQrrhc7h2efCHN4PmuHKhM7gr9msnR5ygWy5EWfJZVzcgmx5lLu3T
	SyAdqiC4r8YLb61v3XEWQ7Gl2TGrJHlX/YHX4UFxFdyRcxUCo4b2HHJ6CaCmbIB80WLTS2AED7s
	XlWkAVZomEr/Kaji89b226AzzYkp/vQjpfdJJD9pai39MF5rtt62vPiph9tE2jpaULY05Y7Q26o
	hcZTZX1SwBWlmA0ZhGkink9Y52Nt7auxNjRqq3INwT0vih9T0LA4NC0zQ0EtnYEWom6sTj99/0q
	/7OHkz8LdRZs4zJQX4eT3zRKx8VIIZj0hQzMMb8SNCzWxnR0S1rL7y9oTBBDagk0ZMj1+dOYEdM
	Aq8ti8oDjo+4+cWRgAiwO47Zfbfp1JBYaUE2pUnfV22YVCob8sdEXqGFEQF/QhDXLRLw==
X-Received: by 2002:a05:6214:2f10:b0:910:3156:1639 with SMTP id 6a1803df08f44-9122e54f416mr95104606d6.28.1789439350417;
        Mon, 14 Sep 2026 19:29:10 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a4fb3e4sm90358906d6.24.2026.09.14.19.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:29:09 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next v2 0/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc JITs
Date: Mon, 14 Sep 2026 22:29:03 -0400
Message-ID: <20260915022905.1535566-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parisc BPF JITs emit unsigned divide and remainder for signed
BPF_DIV and BPF_MOD (off == 1), so neither implements signed BPF_SDIV
and BPF_SMOD. Negative operands therefore produce unsigned results.

Patch 1 adds signed support to the parisc64 JIT and shared signed
64-bit helpers. Patch 2 adds support to the parisc32 JIT, using those
helpers for ALU64 and the signed millicode routines for ALU32.

The original series was tested with test_bpf under QEMU on both JITs:
the signed division and remainder cases fail before and pass after.
Helge has also tested the series on physical machines and QEMU.
For this rebase, both JITs and test_bpf.o build with W=1. The source
changes are unchanged from v1; no new runtime run is claimed for v2.

Changes in v2:
- Rebase on current bpf-next; no code changes.
- Add Helge's Acked-by and Tested-by to both patches.

v1: https://lore.kernel.org/bpf/20260717190544.257306-1-main.kalliope@gmail.com/

Nicholas Dudar (2):
  bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
  bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT

 arch/parisc/net/bpf_jit.h        |  2 ++
 arch/parisc/net/bpf_jit_comp32.c | 29 +++++++++++++++++---------
 arch/parisc/net/bpf_jit_comp64.c | 35 ++++++++++++++++++++++++--------
 arch/parisc/net/bpf_jit_core.c   | 14 +++++++++++++
 4 files changed, 61 insertions(+), 19 deletions(-)


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
