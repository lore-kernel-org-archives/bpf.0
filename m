Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDE46982B
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402425; cv=none; b=ihQwUyYyFdD2e9UacnjQVAahGo5wpmLZDAM3gqMrzOSDN8wBiVxFXfWPbdzDFd4OoNbD2xnxz6mbQhuenmSg3OxKTT8asc8r+j3I4B0p5gShwhiFcpv+5iKetk3161pSoyPfRehJsicGYYsviR4ppvrerLyVf+zi3P+1N8J13wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402425; c=relaxed/simple;
	bh=hMoEfY2BIEcbibDUuD6d6nt7No643LmOmkOmYKpsS1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LikgRf99oS+ZWAsTQp2R4h2bAja6QfwBNtr8Jjsn/PBFTx8mt0UKYW6moH2TIV6+YvRvyLzXlWdxVYJO8W9V55582YwHBO+/J3OEs5CvYM34TgSkZB0KdcGzb2ugLh81L/S4a5W43DxNcvVCBOgpRbAWNq7A+VEMwkavybzzHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfjidIOe; arc=none smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfjidIOe"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c254403ada6so166886466b.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789402422; x=1790007222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=moeydUW16lU8fzBpXcAhcKzktOEFbq1DmESaJ0JfKe4=;
        b=HfjidIOesQ+np7dsNKcCkh6DdhHEvbz6ALH16hutgy6VQYzMO+X7pLDLNL+qumy2Ei
         o4gmRsnb+O4TqVi4AFL0A46UwFLsgwczh+hpDG+v5qrfQLRPYFJ1bk6AHoRpvym6S43w
         qcJqGmRTJP+zkg5L8fRQq/LFSye6sLx+SuWYverzpG5NGOo6uR5qDtB/DJZGCWScT0bd
         I/FxxsOvjP2DGlsTIkBlilg3WlFJKdGjE/Gj7EloAy91fR7LGieejYWy7rgJUT4eizWT
         Ku7+63fLaLJx4lQCdZG6CmmDXP/oB4yo94J0ufCLWe6sqGjk0tscI91VMuAvNc3cCIyD
         cgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789402422; x=1790007222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=moeydUW16lU8fzBpXcAhcKzktOEFbq1DmESaJ0JfKe4=;
        b=QIhSzkE73OEDeBDb8c1QtgZfyycQA3qHPluLIF2w2sETvs6eMjSkNvcma+sUYSNf1M
         YJlq+5KE25uU4rQuiHppPYvRtaLyuSX5bGpy/SHFXrk4ucs2pW/BD/gc/TtuEzC2qgaR
         1GC6vtR++kRVEmS/yRhavSnX2VL7fWH198C3x3vryhun/nW5C728lg6E7pY10CoF4LCm
         Tjn2I6HD9d801FtOUmsQOQlsaCupZiTpQSVDwUap2whnzJt7l0/VM62sNhrZgGvJfFVt
         U7ZeuLIr2ZF1TFlLz1JhRR0zkxqBtzp2nauCeOzFt8Dfi2eGQA36QAajlVbqEiWTxwb3
         sApw==
X-Gm-Message-State: AFuF++k4IN0jWzv1X/tp+47Uxca2MJv7nty9cZVfz2f5/s3cLpV6b8hp
	um5Um/qAQxaRBuRnCmSo0Iy8EvfYH9BYzWvOaq65u3rqISuW9BeykOwaLwiYODOo
X-Gm-Gg: AYBFou17m+BryZ6d+4Zvgq2snX1GsPL5IjfsSIt3tz4WEh6amzRaegPlejkJGV6cyfS
	2wK/SeEDi/imt4HV3sv5++vgkG6g9JQxBnmegYVAbCfwBuhDmw+ax12QWzA4In1i4LcYFZ/Hy/s
	i8PtCHHayRF8v8UqFvClxFju6C7SpuahsgdhPmUz/fFVkAaQ7IpkUjZJM2TOw8WSnW/W8qoevbg
	eJATWPdVGiqPe5W1U0vWy1nprsl20uMSGffdeT1BPEd34ZboBiFvhLcOX/q9NnFeOOdG4yCGm44
	48sjxZRDmxsZQMT1LoIbKi92Dv0sXHZJaBDikngudbGC0IWNP/avap5H8SkTLfW5bJbItdphDgc
	byWVk747YtgTnjUeeJniZ8uJzSAqV3hDoLmbbGSNOD29BcPTzLRHcx1wrnJwU5PKoNCTM1/1BEE
	2zslEdqBAgwwDsuqBVnUaPr0/LzmI+ziyywIZf8N8G43Cm8a1Ia2M68tPXOntpH470EQIDt9cGu
	7lluz9gO4u8Ce+IGU4qyT70V31cyxdRgjXHbBT9hlGvx4pAm8/bV3n0iA17jsoRR5QJyAVtCfQo
	ohvmS0EzJekPfJEoGNSp8K6t9QcdzXPwDtKMBg==
X-Received: by 2002:a17:907:8b91:b0:c29:52dd:317b with SMTP id a640c23a62f3a-c29b86f5e2emr192490266b.29.1789402421917;
        Mon, 14 Sep 2026 09:13:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966066b75sm460332866b.29.2026.09.14.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:13:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] bpf: Compare stack frames in exact register states
Date: Mon, 14 Sep 2026 18:13:36 +0200
Message-ID: <20260914161340.3419141-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=memxor@gmail.com; h=from:subject; bh=hMoEfY2BIEcbibDUuD6d6nt7No643LmOmkOmYKpsS1g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuFyD/lzetYZ1aXODwyVdgkbHY06Kz0f0nPnxtmcquky D5pninRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkYPGFkeH06dMJb1emPc5lf FN0wuvzR937xgfcHviTsiIw6abLzXigjw3vtRR81JjcVq8SWHa2SshHt2LHkKMM1td0nOjVczff pcQEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares the value-bearing portion of bpf_reg_state and its
IDs, but excludes frameno. regsafe() compensates for that omission in its
PTR_TO_STACK case. An EXACT comparison returns through regs_exact() before
reaching that case, however, so infinite-loop detection can equate pointers
to the same offset in different stack frames.

A finite loop can expose the problem by first reading zero from fp-8 in its
caller, then changing its pointer to fp-8 in the callee, where the slot holds
one. The current verifier reports an infinite loop at the second visit even
though the next load makes the loop exit. A spilled pointer has the same
problem.

Include frameno in regs_exact() so every caller observes it. Keep precise
excluded: a precision mark records whether pruning may
ignore scalar ranges, while exact comparison already compares those ranges
unconditionally. Precision marks can also change through backtracking while
an ancestor state is still active.

The second patch adds register and spill variants of the finite loop. Both
are rejected with "infinite loop detected" before the fix and pass after it.

Kumar Kartikeya Dwivedi (2):
  bpf: Compare stack frames in regs_exact()
  selftests/bpf: Cover frame changes in bounded loops

 kernel/bpf/states.c                           |  8 +--
 .../selftests/bpf/progs/verifier_loops1.c     | 66 +++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)


base-commit: ee363e055895364039bf28348ff13c615afad4ba
-- 
2.53.0

