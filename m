Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CD2BB1D
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212259; cv=none; b=Tr4beEq16RO19ugDBmPA5EPPvxBu3Cqr7OUjSock+BSWntTpeRGBiwBuXycPEW2dBCXq/kDEGOXC/hckoyBQ5zNsrKjgxzrofCc3maVffTrlkp0a4UDqb8WBeuz66+zZMiCIFBZzbglapPZI6XJvuh3KdLJkJ04hrx+Tt9wo5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212259; c=relaxed/simple;
	bh=huCVb3gat/P1RYcGhiJviedK+8Rqfi8p1+3zZygMuTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZfV/QqLzhDmdbj6NpcN6+NjX7uJG4ZJgVX82pz94DJdWhoEZKNRoVJKtLa2+tDAyE36zLusYwWsh9Mgxs+N88WFe78qw23o84zPBg4ca+N8YLVH0y9AQnIUTIWKEl/kzZBdH95zormZy0eiAPFNkgNg2GdW2NF+hwTuaRuwROrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3xYhRVS; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3xYhRVS"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1274204434bso3744208c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212257; x=1776817057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kLRBj+c9hUmdI6CBLB5xIZOg+ilvR5/S2Cn4ZlOfWQ=;
        b=a3xYhRVSckp3cqvDKDxWCXRjSOa5ASV3Tsu3tIytUKQnyOzNIVYioGVKeSm8lTDgVj
         uJmHnXC7gGZ29ss3BGtTzeq1PaJRMPHqNmkH3DjkyCcgJ2uGMeBYhkEs+Z/MGQ4S3XdD
         kUfVnaQ5OuyP+Cra4NqFMeNcQZ8WTy9wqH9RaPP7f1+U4EZx3HeI2wpShhUnfddedw+e
         LkXG/ek71y2v/LcZiH6vDH1yaFb+H2miLTtHVP1euMAvZvORH1L05UdYtYSEZqSP9PUZ
         AqKYj/6gbdsSf/ZeBaE1WZ99D1jGKxZbrsi1s91zvNqC8OBTads+nEYKcBbd3zF/uK0D
         HPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212258; x=1776817058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kLRBj+c9hUmdI6CBLB5xIZOg+ilvR5/S2Cn4ZlOfWQ=;
        b=itoTPVmZXnlQCaciZRPK63EWMNp7mA46PqQ+0opU+WV5ZOHxgywnsUjWhvn9Z1GD9g
         cYjmahdAIv4wAVwCqURu7p+1uLW36Wo9ZE7z7MKimmU/3r2fH5T1IjTXceRtqkLItyyw
         ckYDfj3J//IB2Vvh/i24XG5y+BcqzsJQo202DhD3P5og0JTkOrPWLLjKThhLSvrH5AwX
         TJYMWhhy7t96HaBMxjK7sh1EgPWjlRO8A2JQv/ir6dJ1MgxPX7kjSZ/F3+0llqW9UlUI
         wNGI1KTF00KEWUZpFAdlTg2HbAUhDW0K+x2YWDK0pVUVlhQYxeY5cojtJ47hj9BBTjC1
         sUzw==
X-Gm-Message-State: AOJu0Ywry7deZZXbmasfIEvV+Nyn3ERgAaisF2OQJZSYAt6n9Z8yW6V4
	1RuBUIbvym4DFXr+Tq/AkZDvtcSWXbSLz1RmNTDfjDd3XYibeqhREFNfFyn5eDfI
X-Gm-Gg: AeBDiet3Eq5yIbiZfCZ/tswVA3n2fF/PMyPlCr6rdl4oiCp1ZD2eegX4KWE8q0GjxW5
	rt3226zTNILKwg024mX+/tnf1Wk74PvEx1zdk25kQT3aLdv4R2b12J89ujTsYFfIY8KOz0mA+KZ
	Oyzyp3SWmu8A5qs5Dli0/4id7r6GTOFnf9BPujvVDmiDpusuLQPqLNMC6Ix9n9Rpl+pcFhURvVP
	z1LW+eTnXcOfw2CywlNUM7Bzbvebs+MMTr1z+q1R7h2ubfzKsagdIGDUoi3eJBwZXQNn+NrOplS
	8p1pw3djfgy3l8+loxGH3ZAeci/43RLBeYqsKEsN1SAqtb5b9+YGa9yNXMzDuTc0d1JlS6NxEcy
	6ppQ+h79AgI+Gq7ZuExycNBW2gF0SJqEim2bb2znkNbUl2NQkSfKEJzTA+Cm2FLEZkj/f5dVJZd
	SyX9Nl4ZT7/DKwe/036GUORj1k3ywmncWgHwRODN6DDmGvZubQiEztzgLADF3HiNjOtMWW060sM
	4Hz
X-Received: by 2002:a05:7022:384:b0:123:2f12:60b4 with SMTP id a92af1059eb24-12c28c315aemr11368237c88.20.1776212257470;
        Tue, 14 Apr 2026 17:17:37 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm20171978c88.15.2026.04.14.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:17:37 -0700 (PDT)
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
Subject: [PATCH bpf 0/2] bpf: copy BPF token from main program to subprograms
Date: Tue, 14 Apr 2026 17:17:25 -0700
Message-ID: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
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
bpf_prog_aux instances for subprograms.
This means that for programs loaded via BPF token (i.e., from a
non-init user namespace), subprograms fail the bpf_token_capable()
check in bpf_prog_kallsyms_add() and don't appear in /proc/kallsyms.
Which in-turn makes it impossible to freplace such subprograms.

---
Eduard Zingerman (2):
      bpf: copy BPF token from main program to subprograms
      selftests/bpf: verify kallsyms entries for token-loaded subprograms

 kernel/bpf/verifier.c                              |  1 +
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 81 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 26 +++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  7 ++
 7 files changed, 134 insertions(+), 22 deletions(-)
---
base-commit: 0f00132132937ca01a99feaf8985109a9087c9ff
change-id: 20260414-subprog-token-fix-96c29ffa7e12
