Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C6345EAE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192425; cv=none; b=A2J0nn//adbDWFf7RdHt4so6fW4KLaKUvQzycqMOlyeW3xe6UNKPqRwjX1NiCC+rvmnjgUIzP+oieJohYt3/kOGCPthX2yYB0Jm1OsQUBK5YQWC8W9Rbu9KILpmH2Ily4/SAEVKmSYhF+Bg1cObqgjUJ6hEsMslg2dwW3+DN6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192425; c=relaxed/simple;
	bh=rRj4t3hq0uzv2GINZgytEUUPotRfc6WgQKxYdue+iKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0Iw5ZtzTFPuTCuVmiSa3ocQ+yWKqHN9/xDpYj08Dd5Ag6JvekzLeO3bJcr8Q18KieLf01H589H79lcrK4obxbTxASFDU9ut0VLKuHQc9mFQA9r0VxJGOeqFgILeMDjiLQv8xLPAOD68G6bm3c/YRwO29okLzK+KJPjEllovyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBa1gKXg; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBa1gKXg"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so485953f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192422; x=1787797222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=78tzQYKsOBUwWMYCYVJMnvL/iS7fUExR1nee8AfMFF0=;
        b=bBa1gKXgK9LEY6y3SU9Xzvsb5yirRpzR1spuWrvIYKh7n/RcdWvsIYiy89jOlGuqQx
         l86gnBF0VpHMBkFG1Uv7RT9SdidKEgs7ZEoiB74Rul1Df8L1aKWygmCYgaFGhk9i9bWN
         NZap7YuoP07R744rggb+KVNA1RVfu8iFuJ6kcsbF5gYGfGEdpqV77d65twsApsPiLtHn
         KT0XMq+GDVFufSDMYgo6DQVtt+/10t18bwNlpEg6Cz+soGIEBDT3bIQ9pjBBH9aEpR7L
         n/iiWmEELC/pBE31FcSpnFg00UG9W5lh/x68MIQGo3ysjILyQULnvlX2dB7KsJ21VSXK
         /qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192422; x=1787797222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78tzQYKsOBUwWMYCYVJMnvL/iS7fUExR1nee8AfMFF0=;
        b=dEqQAGlotZbfb3vn9e0JpMWTp0PbgS9fCgCJlIVclQHVHOVuRGMavz8cQh4Imv8YRv
         JjjfFimepZ283sft7NtzPnILrzbXq2LVudpW7WOGwHQFF+SHfi0xZGUdPZ4AeaegJS8V
         nWzgKyabGcU9zJgyDvngIiq6Xf9UVYfE0PuTYRRgrSQtmkP25td/LpQi9H5fgvLc2RFl
         x3eHfMZcwh0P44WhgM85+WcBkpRmzau+7orY5tQlJF3Wq+6AW+rn1fVBosloAHhjKITP
         nFX+wwdirRhiFTjtteiEPm1BHWtPTefvOOfkDTfNuz3LyZqAwxIAFSlCRrpwjqVo7feI
         uHIg==
X-Gm-Message-State: AFuF++mfdX9IgeN4lchuE8adWeIYaHtNuAUtzpFC3uybkS00aVrUgMky
	EH/T2GLvjSQyBTaETblXQ2ZOZPCw6TUf6RE5oQ05OMFP+UUtnYh8X6P9wTyJ2pmo
X-Gm-Gg: AR+sD11SQbsHAwXfgzCgKkCsDQq4cNx6Yq6s+7A1SUYq64UvAphs7T47uYuoet9Hfp/
	hxsOA6cvhx9e363FjIseGlAUFSgj1q6wZZC1UVl5J2I0pZaD8TGww3QD/n8poiOE5WH72lUePLq
	RFDVmLqpBY9FGvATKTVSo0q1g9RG5VReb/UICWacvqVpG/pTuJc2Dk1F6kRXNXQl28y1GFSkpa7
	k/fKje3lvTwMpursqcE/TFhpxhuIrCIw/JUUy7QrRj44njTUnA0kpZrButE9Tz0Tf1ESTQnC01J
	ZTuXJUTVyZ5aInunCPSfm1uq1TUzbXBJGPmRxpntJeqGHr0JKLKvZBaoF3tk6iuu6HjFPZUVBcY
	oktckgOIZ69K+iV2vfNRxzMiz56VSKaU3RLcHmNStvN2CVxJ170uvdoAtXO2IoaU8VgwGxD6+1K
	A+/Gpg0lY+dQWma17ZgWFfjEA2BY7vZvIsXYcSALfa7Xy2o3HiVTXq9M+TJEkRYmylA6A+HsPdc
	DP9z2dqP7Hb05BMd2gbKDv8v+awFiEozjNGE1IFppsxlSep0ZybHKS4vK5uzNC2jex40vlFTWwu
	vPm82bCMlLKn2EzM/c3Y+/hKduc=
X-Received: by 2002:a05:6000:420e:b0:481:568e:11b5 with SMTP id ffacd0b85a97d-482b1e876admr14304431f8f.5.1787192422354;
        Wed, 19 Aug 2026 19:20:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441748sm9752546f8f.8.2026.08.19.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:20:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Reject invalid LDSX instruction in disassembler
Date: Thu, 20 Aug 2026 04:20:17 +0200
Message-ID: <20260820022020.3450479-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=memxor@gmail.com; h=from:subject; bh=rRj4t3hq0uzv2GINZgytEUUPotRfc6WgQKxYdue+iKc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIastRXNzUesal4lek3Y1pP29t1TtQXy9zNbZKQJv+/7u/ LJ6632+jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyk+AIjw4Kk7/pv3H7MX9K/ dX2AywPOW46ijNys4VGPXcxP+kWwPWb4Z3Pg/7a/1/nXCp2r0Ttyw7F69sfa2Stq3HUn1ywqOPb qJycA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Reject invalid LDSX insn encoding in print_bpf_insn. This was reported
by syzbot in [0]. See commit logs for details.

  [0]: https://lore.kernel.org/bpf/6a86596a.ae6ddae5.3da009.0015.GAE@google.com

Kumar Kartikeya Dwivedi (2):
  bpf: Reject invalid LDSX instruction in disassembly
  selftests/bpf: Test invalid DW LDSX diagnostics

 kernel/bpf/disasm.c                              |  3 ++-
 tools/testing/selftests/bpf/progs/verifier_cfg.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)


base-commit: f79066c784022fda83f5936559a1af414e41b603
-- 
2.53.0

