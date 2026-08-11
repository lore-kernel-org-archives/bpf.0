Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327C448BB6
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457956; cv=none; b=eX6B6zByM3wiBExZX+yDOGN6RYp8LaF6bZXCNNAR+j5C6HgXinqZOPTDf6K0Q7HMkbnwW45B3dWe2FNSAVUVHVu1/6sOtJYksEVCeourIBsC5F+Qg9ckUNI0eS2Ofm5T3LBTbfrIoovXy8otMO1FK9ixKCL57idIaCTlnGnszTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457956; c=relaxed/simple;
	bh=UK8Gbb4rglh4FaymSjNbOeD1SzoLlYvu+K2etj4vcb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcNAggTHSPWWJTkCfEehLWMjmnu3gQYp/E0pahM6stzeXCnne9LcSTVqhSJCpf0+ZzZppgeE0OMhcCbrDexzFA+aBiSHG+yLuTOxn41CMu+w9p74jmXULjtUmhPJ9QXyZx1awhbMjqAToFwGEVDTj/50bJrw47nf0nGspMzTOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn65hAzb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn65hAzb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so4103426a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457955; x=1787062755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kMGAmgL2sHoPiISlJphA2bmnreOOIlXDYBkioBYhB4=;
        b=nn65hAzbLxWYPtNwXX2BiaPUgFiu8SX9Pg69szjvldzSjKOkJX6eRIXyvR65Lqif6v
         Gj/x4VNfMBkZCCsUjHaixahrUqOe2w3IoMda5/pJqRsvtzrInmC41KWbju8dJXZ2SfGF
         umeExrfruLZvz580OXIfDHtGVyvbUeo2d6JBWn4t1TxvHV4NanA3UniYxwPKz31wBozr
         9y2RXN87VjGOmtMo9DxetDTHKobMSeQqAWLLxh3ljs3gohmboTbarHmbzMcsl82ylHxb
         HuGOLzJo26MZk1zrCdW/vqRLk6ti4OVF0HuiK4sNBdtout63nS2IR1ZTEHbnmbn1UiRz
         PK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457955; x=1787062755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kMGAmgL2sHoPiISlJphA2bmnreOOIlXDYBkioBYhB4=;
        b=St7FVqMoQxxDqzDmIC3hePubbp4ykJ4QWiaGmh5Ta6VssX+VOQcOzSW2vcs1oU5c4z
         PpJ3JJF9BQUgS0sByv8gSBWoTgb0vARb6SiS5f9BFACBFwYVcvzq6YMlCGo1mvYs8/qK
         AozQnXbt17H1l5tTCJYQMATw0cm3ZzdNH2gISKMPPn5/VyP0yUhhRVUAO23n9eQPnK/Q
         sUaJyGSvf0jKQzMdExo2Hfcp4mGQopFhtJMuM2K1RX5qFoizqUu393Ly2xZ0UNIqpDZL
         //Yx9bA3QlWTjgZ6/U87mMrscFibokgEuGvuHH+rNGUidacHJNQmpLit0s/k6JDZGaQ0
         Xd+g==
X-Forwarded-Encrypted: i=1; AHgh+RqNMH/b2BhPdoSRWCE6/Mro0nuqXOaF/qntNdLUiw6Ht/fsPzkNG983slhFcNhoghot5bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4fTekfvuGYrWW0BUCcrrDWXRLEWQ7AvbaGQCWr44dMiGbnfX
	jQnax7AXGWOqxdS52x8OIGeHg45YEKBRiiiwITReiGbXhCLZzJ0Eettg
X-Gm-Gg: AR+sD13DhM5u+Gxh6glKDc+9X2rdHXxpT/foI5c65UjGQ+qBjsqceLZe99BsildE5Fq
	szGO2XW9KCiSO3B1q/jAw5InrZ75tDGUsuIkLXqOPwvWGUb7zYQh29q/Vb7F4fSySfsggxw5I7Q
	pqjdujZ+Zr9Sry1Dz4GhVAUT3bw7SXRyHXNwgbDSO2J7S8V0UxnYcvCWIX0MKGaICVnYDR2s/A7
	zqcDJiX/rkcGhRG0TS6SW/hvSJHS9LKX5H8l7rqDWaxE5vDFjdF7HJFma6FNc3l0MxxzYh15oTm
	4wNZZH/fBBa/7F5ZhzyDMaivFb8QTzDVHaO8VY3kxnUZcLixZmEiumgdFVmJ5RaVr99YIKtJUW/
	Zb1v0XjyhOFznaIEU8CwdVx47K4/tb7rDvPIuBIQqvMHsm7VPzkUjvOr8QjvZA0bmXQyLAEI/kH
	kkWPBnW5GGMvW9DfKnF/sW6x/+mBIfme81pvFToBT6CGNrdz5bBdVw7QI=
X-Received: by 2002:a17:90b:4d8f:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-392ec5a78b8mr3597233a91.17.1786457954421;
        Tue, 11 Aug 2026 07:19:14 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534bfc9sm4028489a91.10.2026.08.11.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:19:13 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Reject negative optlen in cgroup getsockopt hook
Date: Tue, 11 Aug 2026 23:19:06 +0900
Message-ID: <cover.1786448307.git.zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cgroup getsockopt BPF program can set a negative optlen after the
kernel getsockopt handler has run. For TCP_ZEROCOPY_RECEIVE, the
kernel-buffer hook did not validate the lower bound and the negative
value could reach copy_to_sockptr() as a size_t.

Patch 1 rejects negative optlen values in the kernel-buffer hook.
Patch 2 adds a test_progs selftest that reproduces the issue through
TCP_ZEROCOPY_RECEIVE.

For patch 2, the userspace-visible errno is EFAULT on both fixed and
unfixed kernels, so the broken behavior cannot be detected from the
getsockopt() return value alone. The selftest exercises the problematic
path and can be used to reproduce the hardened usercopy warning on
unpatched kernels.

Changelog:
v1 -> v2:
- Add the selftest for negative optlen.
- Add Emil's Reviewed-by tag.
- Add Reported-by tag.

v1: https://lore.kernel.org/bpf/20260726070122.2407344-1-zirajs7@gmail.com/T/

Junseo Lim (2):
  bpf: Reject negative optlen in cgroup getsockopt hook
  selftests/bpf: Exercise negative optlen in cgroup getsockopt hook


 kernel/bpf/cgroup.c                           |  2 +-
 .../selftests/bpf/prog_tests/sockopt.c        | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.55.0
