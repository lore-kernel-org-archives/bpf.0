Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECB2BDC3F
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283447; cv=none; b=dCHmTAWR+zTeB1tkFnrsF/508mDICzdSb3oVfpDz7YIDcubOZhRpocMJoVYcgkhXxsbqxpckQpgFCMYDFr615rZzjkX0gqV1zfIIFbudc5RAkhv44GUJxRS3cXqIAi+f8p2+F0n1AbBrFgKNVzDH1jj9x/67bIwgPSC5aJ7Cq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283447; c=relaxed/simple;
	bh=2WI2BdTwalczZWHvA8hyF7AEdJKJN+UBWccprafsFxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Da8ytJ5936yupyNZ4+OlwfdFgTxprHpZU0rpJYCvhXA5vL/egz4UBrVigKuiqLHUEpWB2vzHAuzoJTpwzKX5nov0uWzMlCYOSAJIAJZWO/2HI/Q+F6AYRhFxvN0wHWWLiTwno3XLsFLbjP03HS7yOM3WtLUa0asr5+bkc4SRPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiCzvkDx; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiCzvkDx"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so6456035eec.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776283445; x=1776888245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qod7PqjI7roRANaNNOsy5/Ew/HuaCLYtUp2A3OMivYw=;
        b=WiCzvkDx3NTLFGTg6+3ILulLdbKUcJGAe36fJbiO7mrYTJx309e2eDmD/cl+6SnAjd
         W6qgcml8inoxaO5fuKjhOfG6FYh3RN9pU8vpsfhJE8hv9v40UyE7yHU1yrHHtvMhFePr
         dpKO/4G4Bkh9qK6a7VeYDQVhPvRnG9XhPCPbSKVDnxidBIDzE47FgWvQHCRSMRC0OaCZ
         IJPygcBSVhLUEMZpQTM4jMB880yFXyiwV45b6ekkkrYbDmQDH82EUJWSNJf4B1c1y4Kv
         yIQmUCnPFBPZBMtX4y063fMfT3GKdXq/VxyLUiLASi0Vyu55fgMRAbATsRqIBZYkc1vk
         NX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283445; x=1776888245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qod7PqjI7roRANaNNOsy5/Ew/HuaCLYtUp2A3OMivYw=;
        b=XeD6sEQ1+Lj7I1hucKXwyYp633CZRJLSe/LLWYkmOc3HNUWqwtYeJq/8PeC7aYBDPt
         koVLP/CHU0s5yDNbvZJP5017GOpRr/c9cd1oO8+9WLgkR5nf22s1Amju+WyhMMPEbw/R
         MVvO2+y4lDqYY+P8iQl7KNJws1Zl2WKwikOczn8XjKCy0YWbmxKTTa0F/kBgrRIJEuL3
         tVegLkF19CR9s0Iv/d7lZDYS6hvKF73RopxBlUd3RMQzU9E9qqJkIJUM9y47d1mR7ny2
         HyNeR0Du1ccJc1QCjpxv6d5qpq7VMbCEclQRG7TEfqtQEu9QFKywpOXIua2ltbetqMuR
         T9HQ==
X-Gm-Message-State: AOJu0Yxr+3zuSPkmDUUbjqseovTHHjLQoJLLCdL0HXyhOE7e2QXJC5BN
	g0g1lD1hdLksclJIVLGcumIMYpO0jcroU8Z9hjfXVPCLsK4khXPINa+2eQc6iYSn
X-Gm-Gg: AeBDieukVw/pIZyHoKRysHG1lor0f34G/Fj8O58Wj7b7XRJWtpiickDlKQfBv47hKOC
	9IDA8QtZP436gJuUtVbIs/+gwtrQqVI8w3SQR7p1gqbU9aDpHwe+vVWXolP5l8XyN3qywFYsx5n
	RNEhsC/McVXIDHwfM3XQNpDBAaF+JSJEBLAOVjjflm3y3QF+Kuw8SNFAJXB7pHorqV9f0LN+340
	H1RmAgp0+xlDuHUEa/E9DUkxUNDMPX15zaRPZJ3oLYdABt7YY1eDk7br6axNlmCdNLR4wFmuuN2
	fWpdtvhfThT/U95GM7PLt4eKIZvGWXyW85OT0fuBl1I3V7up4QvmzN3Nilj5qtsZvALRSskpL3z
	9aOw7vLVma4lML1A5OxVbepLjdEHlckH0u12Qj8ENYWx504/zyYs8U+lt2mPnkEb3qVEBZsqZy+
	Duk89aHyFRrWfb1azFVXW/+ePifxMSlXaVpqp8+ot8cf0aGaDwTV/3HKQXk4CLPx34RHfWoVLWl
	xE+oMHfSxHeggo=
X-Received: by 2002:a05:7300:e2cc:b0:2c1:27c:7598 with SMTP id 5a478bee46e88-2d5898a56a7mr12963279eec.30.1776283445296;
        Wed, 15 Apr 2026 13:04:05 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605851sm4163518eec.9.2026.04.15.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:04:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/2] bpf: copy BPF token from main program to subprograms
Date: Wed, 15 Apr 2026 13:03:54 -0700
Message-ID: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
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
v3 -> v4:
- check sysctl_set calls for errors (sashiko).
v2 -> v3:
- mark selftest as serial (sashiko).
v1 -> v2:
- target bpf-next tree (fixups.c) instead of bpf tree (verifier.c).

v1: https://lore.kernel.org/bpf/20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260414-subprog-token-fix-v2-0-59146c31f6f1@gmail.com/T/
v3: https://lore.kernel.org/bpf/20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com/T/
---
Eduard Zingerman (2):
      bpf: copy BPF token from main program to subprograms
      selftests/bpf: verify kallsyms entries for token-loaded subprograms

 kernel/bpf/fixups.c                                |  1 +
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 86 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 37 ++++++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  8 ++
 7 files changed, 150 insertions(+), 23 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260414-subprog-token-fix-96c29ffa7e12
