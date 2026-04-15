Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA652D8378
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278126; cv=none; b=SL5whSQacYdhNUeHY/+R7ddKE0YImIqorpyFS2Vc3eTQRnSi5fQHgSmv0dXzBNL1xXqfbPwZEYvGscqYF1vNE8vQbQfvcUAN+HampKlFEB0MvMA0+YKNPpiomVxy4qelYZ378Qcan1tV5XNIsolTO8+2PkUwgtRbxK1+P1Y1F7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278126; c=relaxed/simple;
	bh=yCVW6eScshi9RXR+8C6wG5A03xlBEwImUVoyMevRMAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VistUcKmGxpEofwFMYH36HZTckj4nc7kStHPvv687X6BzQcqUcA4jLYod8T49x0bPso6RUaC38AoEndV1b8+d46t2XIkwir8gzBNA2iIbYaJF7TF/RXejfCg6APhZfeKEv5MFmsiJiGkibQtOL586rC2/OW/pDWBMWaRn2FX9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTAR/jRV; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTAR/jRV"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d868d014a5so3904113eec.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278124; x=1776882924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uuh1nNhS1ta8Fw5/0Uv3sjzvEClViiEOTc/3Z5sER3A=;
        b=YTAR/jRV/3al9qJ0p/VS4uttb0vrqSqGz0YakCjth9NSRyrPNXglRH4skOhv7Q7LGA
         BWqIMlPn/ZgekEuYwMKXQ5ZI8+wx/rEJCqdHBGstPsxRz2ycvUoPkFLLPFSlj69iHE6k
         LMmwjr2eid7+H4AaG6zisBXiXBcTMPa8epTGW65tpmwZuBIgL1eiK7sBBQUrrULHhqfF
         IZ64UY9kKAJQMhrSyqjfY3Fzx+EmXj9NP4Sx7yyH2s9huDJ10LPC8t3wvqd04BUHxY6l
         AY+nVWfJU5n2aZCy4Nsy4i3FXJ5BpzbJPZsdpwtIhSH2GlGG2e6twW5FII7N0KdCUWNG
         Ic4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278124; x=1776882924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uuh1nNhS1ta8Fw5/0Uv3sjzvEClViiEOTc/3Z5sER3A=;
        b=iaLRHc2mbrlfRrzOsU1Uw9BQ8W1HHtkW6W4PHmV1W19A16w+LAkDLTy/wCoQ4c/zwZ
         pfjyAY7ESDsDwDW47Vz8xSH+pJTqwsJcvtaO57XYaO5Bc57rEwnRP2Pr4R6pXcts/d77
         0u+FdafDvCm1H0kXdcYFyE3Z6p2cG+lzE9ljj3Ap3YZdCAPC3GUmk7uhcH/53ondX/HO
         xk5YPvYysERFBS5TLJxtKXOUpFonRFDLnbLvVnoND0bkmXS+CC7Iq/G8ypeH8ceN5jMh
         TxyEiXUzXejrEMif8dPhR+IWow5VeYBOgnxn1ShhT+WyTtWjkHTlamZL0eXRbjq8yCVB
         ImdA==
X-Gm-Message-State: AOJu0Yzsd67XtgztKuCK+5WGUnu26DMc595q04a2hqyQO3U/B6BTWncl
	OaqMqkzCm8Dy5tCCXBFrcpP/sCCO32C1oXRQeLF8rGY0txfE5Q899B/4JbEB5lzL
X-Gm-Gg: AeBDievJTCDVg8CCTXlObmBmz0+/T5y8K0mtfBQ23hKGD3zO7QhwbXqZeyAdLcvv4yU
	DVMxGHqlo5/1PwKBdCOJTmCiOV7so+JVlPHvsHjOHBDVXC9Gq0PhhRKsiyYdf5Je3zIdWHwLFVR
	tWrYM7W9w/GiPqkefupKPJEPPLp7Dm18Mkxvtce9SqDCJmY9alBKQl7ECkCIWwHz09g7Nf3fxcP
	wWmagnqOV3Zt+oTJ5DV/T2yYxydnxzYwuczBnzuFPnDbxFHafsE3qzwVY9Tj37Iu+h4pYZ7sqtt
	CM4BH/Rg5rH2QdgpDLHXwLQaHZHV/z+P2WvIJnwTn/WNDlWY26XtpZlsgHR/gmDDDq7zQKljvaP
	8sa/DIyKxo9fA08Fk+tXwBvYy77FUcth9oLHy3Hk+24xmIayI+RG2HCImXVK1sNNyC06usVq5nL
	EQlPYhIMk7yhoaPD1Smeo+ngvr1JpobxyF4fK42AZZlWfInOvGyu6yRvYArRo2ATGZQ/JHkk0IR
	Agh
X-Received: by 2002:a05:7300:dc11:b0:2da:2a30:35f6 with SMTP id 5a478bee46e88-2da2a3039fdmr6284276eec.31.1776278123701;
        Wed, 15 Apr 2026 11:35:23 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f960dd1sm3759720eec.25.2026.04.15.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:35:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v3 0/2] bpf: copy BPF token from main program to subprograms
Date: Wed, 15 Apr 2026 11:35:12 -0700
Message-ID: <20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260414-subprog-token-fix-96c29ffa7e12
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() omits aux->token when it creates a struct
bpf_prog_aux instances for a subprograms.
This means that for programs loaded via BPF token (i.e., from a
non-init user namespace), subprograms fail the bpf_token_capable()
check in bpf_prog_kallsyms_add() and don't appear in /proc/kallsyms.
Which in-turn makes it impossible to freplace such subprograms.

Changelog:
v2 -> v3:
- mark selftest as serial (sashiko).
v1 -> v2:
- target bpf-next tree (fixups.c) instead of bpf tree (verifier.c).

v1: https://lore.kernel.org/bpf/20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260414-subprog-token-fix-v2-0-59146c31f6f1@gmail.com/T/
---
Eduard Zingerman (2):
      bpf: copy BPF token from main program to subprograms
      selftests/bpf: verify kallsyms entries for token-loaded subprograms

 kernel/bpf/fixups.c                                |  1 +
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 83 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 26 +++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  7 ++
 7 files changed, 135 insertions(+), 23 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260414-subprog-token-fix-96c29ffa7e12
