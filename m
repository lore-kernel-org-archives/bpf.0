Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581939DBE1
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149720; cv=none; b=A2lVQ6JPMSLnFccd56pSVRmW5U3fKau0aoavcc4NEyx6M4C7O1Mw+5y4bNYPefSOMjduK/PLvCaAebRJ0/nEsq7DmFcvuuKrI60wDnWpsx3XZqjBLzHPNa3f/rkX/rB8zdDfW8iQM2vUTUlvTmWP3DxhwycMgsPq0ZBtLqDllWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149720; c=relaxed/simple;
	bh=zNCpcIiJvs9IFHWwwcNw2lOg68h5UjJaEMg6sqsapzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMbtDZIaSITSJhApUmo4hIcdxussu5al7ITFkycjZkivkdKNFEU7PWHGB7NVJ1d5MbVa6hAGHqV+9VuKbI16xRkofJVPwkXwNgZsMzwlQy0u81L9uKiltRlGWuFOPj3sf9e5wGnYLF+8FyVirfBhATnuJ2nms7rxP5uYAyUaruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEK1N6d6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEK1N6d6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae505619baso56698325ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149719; x=1773754519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mzdOqMk7ZFlnl2HDWHGND5bq1G9c92FRZbDcIF+6X4=;
        b=EEK1N6d6+r+P5A4kh7yk5n9MwRR3Gpm0sy5RYTXmOhOp+iHcM4+6G/acW/R5//YtaZ
         c8prMIskmNOT0oag+/ceT1nSJmmG2pTjTGvXVRzylh0KmtTMc4/mZZMAEOu6+AOUteqk
         FiAiXOY9T9+dw/ZZb1vLF0Moh3/f3enzuGU7T/IB7FX4+HRxwBAd3Aik53sFGtJ14Ano
         n02vzB59KobyT9n8Qd5ckS6/wXLJNaGvP4W4V3IKlH3w4dbGOB7tYTV3tmKAByWKRLZ+
         0zjSyb7jP1BJzOHwe0i2vTepJMMDcxH3oXKM2bqV2kfOC9ftA5+SxKdSklZ1iLoB77Gd
         Xsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149719; x=1773754519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mzdOqMk7ZFlnl2HDWHGND5bq1G9c92FRZbDcIF+6X4=;
        b=iNCKpfWENw7QvCIIBoM6fUc4GxZ9CoaPS/daZDIXAepnk1Qqe8ol0p8DTrICPTQmPB
         FOYZ5qk/F8nvJG+DKrX95/qrnni6xIwpyz0SkdF/D7t8GTyovVzFTwtEMJx71f1UGgVu
         f62hzIC5fhlxs6jnghztNPNMJNZmuxShx8FO5f9BzoLmxqCMpV3tKnU6MyFzk1JjlyVb
         0qaNY92RAiz8M3ayVSwyspt1n2iP4fARU2j+i1bvfwyzrwI0K+zhy47kwRCCoJWR6klf
         xOANpya6bSPSfVJvOBFbEdCl2Eqso0qouolwrNMXZwux+vXPM4S86HvFENv6SasjAxZZ
         XvGw==
X-Gm-Message-State: AOJu0YyPfZwD6VXP57fsv5hQgrB5HkGeDyxHpSat0Ei3uzfIQCAlY+yw
	sgIk2L+Chjlq63TSXEV5QKww/bWd5BC27fGTjrM/reSWWzGRCO3hZwZGzgpylVatlhU=
X-Gm-Gg: ATEYQzyQXu1Fps7bxhm6bu8TPHwt3Tz5xiW0U+oL0xsRJ/we+HdSmK2qc+P3bjtnBsh
	DLSmthR6+3+AdlCuxMRuCnREX83y9ULo0SkLXifGQj2FXYM4vRRIPvb5G1wO97NNnuszoQCy92y
	oApg1U4TIWEBvaN1ZFoPYuBuGNFatpUG2DOPPN6gv0ErTkrQs5Ox+iB6mkXeIkkluOkT9mApHin
	00pLUiLN9x2IKxOTjlNaQOM+tmK0lWWK4J0Fjr8DC0Mec6NJ/N0JJzT8ZoRIDqQMLtLE8URcw52
	bB62dOBK6Y6nNz5e/Wgo4k2P+13uy0zNOr/LC4dJEYJGMO54Pe5VaTnQ4MLrLUeIN7WAetYzvoj
	n6+1OX6We6k9bDGFihYcz5AUU3Nha6NizDFyrwuvR5ohWL6382RrZJu/YDcCLApVb2dniOORuNN
	0JXw8LgxXz4Uqp5DqVkrJNejze76l9LYSKQ+DnkdpHsDaomcfnbrkD/XIgVWnmC/lUhnt5zM95R
	7rqWnD7Og==
X-Received: by 2002:a17:902:e80b:b0:2ad:ba80:df62 with SMTP id d9443c01a7336-2ae824dd08bmr157104205ad.37.1773149718716;
        Tue, 10 Mar 2026 06:35:18 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f6csm203111285ad.23.2026.03.10.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:35:18 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf 0/2] bpf: Fix unsound scalar forking for BPF_OR
Date: Wed, 11 Mar 2026 00:35:02 +1100
Message-ID: <20260310133504.94871-1-danjwade95@gmail.com>
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

Patch 1 fixes the bug by passing the opcode into maybe_fork_scalars() so
it sets the pushed value to K for BPF_OR, and 0 for BPF_AND.

Patch 2 adds three selftests to verifier_bounds.c exercising the fix.

Daniel Wade (2):
  bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
  selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling

 kernel/bpf/verifier.c                         |  15 ++-
 .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
 2 files changed, 112 insertions(+), 5 deletions(-)

-- 
2.43.0

