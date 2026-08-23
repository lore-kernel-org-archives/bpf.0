Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34A2798F8
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513527; cv=none; b=lajfTJH1jl1i7brcpbut86RsxZGzEJewpansOifZFRBgdQOiYkmjL/HX2gj0I3FNN1Y3mhWID5Yu8L2eTiV9iYQyeIM8WaPKleNmPHjiB7Vl+I9wGmERgealPl/lUWh/kuw5wkZOjUwb/G7ykJXKF5cTc2xgsq1QXp1Ramg2y9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513527; c=relaxed/simple;
	bh=2BQAiSVASeRR/GtF62fvSoiAMeWZ8Y1x3Ksk+zYYOjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxlBikygsO7fjSMKriVjYAK0eJzUm+BzKvB8kAyRlghjbOaYhNIbOB0L3cWuuiBQPlxDaabuShz5p9IkVxui6NbfeoBl+EwR//PJSFm4bBycA18IhBiSfzz8/8xdjIEr6d9TUOfpuqjN1F1tsdbeaCCgmIxjVaxVgPCR2UsaAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2ng+Kwg; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2ng+Kwg"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a403027d38so1533695a12.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787513524; x=1788118324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ju3eFj80WYmEOgzbrpXKKOxYRRYi9g7GPQBFC8E6TTk=;
        b=V2ng+KwgSb2UW3yPUmUZvx/PrHgMOvoTWPQfrpgRvdtF1zn+R32DQVdoRrRM3BfX9O
         fTSpNAw0w0suMeNWgz/eONCAaBTZBGXexDDJ8jVRYi4L4oWVj/d2x8WmYcmuwl21SWgq
         4fLxORLhQqGnXQ1vR00OvcjeiPZSJsbUi3uoZ8xiLRdrs6EKCW+mt32dgiwCmxNzV98O
         SxZavMNnRtMe8Y31VoSU2sSOmDcIjOR/k2lda4PzUPHvlycdk0N+GmWTVROOu1vU+q0s
         8UqwhiOdQvnpkE1qfQn/UzyoBYu9gNQ7ZsTpy836rkO3zuvzdenMUw6VvflSSTDDl7Xx
         KqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787513524; x=1788118324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ju3eFj80WYmEOgzbrpXKKOxYRRYi9g7GPQBFC8E6TTk=;
        b=VKAhFpQXLjSiSFn8T7r5Da+u4taT76FYyy/U/RG+kUcBic9avs067eJZZMi1yfl4/6
         GrDbHqgsZaC4HIWjGi21/JzegCZZfgUTMEyKIRuNYieKO0b68elX+8lrqjEnknhGhzhC
         BpTZONPF/UgN/TYV3wwVSe+3iBQps396NtdAoCQuWtEy1RDib1l4jLnrxjjFiVvNyog3
         /joYhOjB4FSGjj/WfNw/jU4ROJJ9bI6X2WgjXMDoDdNSWsFO8ndmRP8EMcas2Gw1bbxN
         E4Urm0o6Ozbjlk1amptHCWCx2jQoCZax3kkfi1GiBQ430q9Gl9G78UpSi6YiS5RsB2ej
         eeCg==
X-Gm-Message-State: AFuF++kJXPTHyM16Hif3uCMzgnL5kREIEWSSkgKr7ym77I+hLB4sZScq
	O30cByBVG0F5XYLtSdPKYxn+nlAMUbwp2lTETWspfs8yjetgI3TGIEYB24fokSyF
X-Gm-Gg: AR+sD125rIXHTjmCYhVCWCd8KIM88bmO4Hq2HA4dz+Wigji4JWrH2mFWlP3O0hl3GMR
	gXFj146gRh5UaLmjCZKdQ0oJAVyNSkO7CoXcIkEGddHLmqwJMYDqwHDykTFvRldoxdYQaemcFQh
	BNNuJ3tdI0rd+dqULNdKwa9+XChQT/FiB4UscioweJoJKPfaUMcezBFX7dEZtwsJfKmqDhN83n4
	oJ8NwkyKRgCTdGOtpWooWEBaxQBzp65fKLQab4Ou/7zNVmCtfDBUFEB47iRHxdCipSOHDs28YI6
	uf1fjRertptbCapNouqSll8/pC0aPQwfYvW46xjLuDed+b1MrSjg/mlJN1biF+QqvJMOF1pOYol
	g7tOJ+F63UdIYpBA/xdPxXOEvcuKtQSq+acTDhKmOMx+K0GKathI4odf7EGTee7pXTh7uVryfQW
	BJjzL3i9u/Ls4HbqiFAkKci1KscSExUMXJDLyeawqiFGP80P4cLxRfGWD9WmMlg640zJdekEJjo
	TgF0B3cqL92beto1ho8dTGNbOKDytvhYgHhcoyWw3Vbqg9awrdfLT87wnHx1hp0n8h9e3DcSSaB
	QsYD1Rk/TBBDkpyTDkSL6ZuuQ7o=
X-Received: by 2002:a05:6402:21d4:b0:69a:928:9405 with SMTP id 4fb4d7f45d1cf-6a582af8853mr13187481a12.1.1787513523963;
        Sun, 23 Aug 2026 12:32:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00108asm6828537a12.2.2026.08.23.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:32:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Reject oversized stream read buffers
Date: Sun, 23 Aug 2026 21:31:59 +0200
Message-ID: <20260823193202.2389715-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=memxor@gmail.com; h=from:subject; bh=2BQAiSVASeRR/GtF62fvSoiAMeWZ8Y1x3Ksk+zYYOjc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavba370DNMbWRsnVcRzb7w0e8qm6r9rW04msqz0Ppr9u absjsm6jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEyonhr1SIwU+1uoVlzyXm Kd8TYEncyr7dPmQR04RnOQvjp4QXFzAyTHpisYFhU7CF/ZSubKambt0jBnJixX4mKRmrTmZc0lF mBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Reject stream read lengths above INT_MAX before they reach the signed
internal reader, and add regression coverage for the error path. See
commit logs for details.

Kumar Kartikeya Dwivedi (2):
  bpf: Reject oversized stream read buffers
  selftests/bpf: Cover oversized stream read buffers

 include/linux/bpf.h                             | 2 +-
 kernel/bpf/stream.c                             | 4 +++-
 tools/testing/selftests/bpf/prog_tests/stream.c | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)


base-commit: a284ed47ec1fd4aa63d2318d87f457cc421a93b5
-- 
2.53.0

