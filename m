Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40B2F7EF1
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034453; cv=none; b=SRddJpZJQEOnl7AkYYv4LqCGyGcuwPYK6KCketQtOzRZzrbSQtfLBA2y7llQA8NKjJPGagJqmQeENuQtlhKgSkRMq0UCA0FZDocVfkco2NvoiQSqb1QJ8LodN5cGdKNejkEbs4iOTyqg2Ah4g1sclG+K7orAQjhgwhNcVSOBPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034453; c=relaxed/simple;
	bh=PQ0w1kLf2aFAaMTEex7GTcAATPDsmBGdbtsq/95WUAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sg0/5kF6IAnBFPgXsjV3qs4tvH44oKooGFKc4K2VynCcXswvzsaJ5HCAKYccuxktcsJtNl3VDG2voZBE/z7nhS8yA9XZGT9DxDQ78mdgyNI0WUgJc7YmqU4waDQn8BPQTUW3rFggsJRcfnZ/UdswA/e9ITqE4j6g8SYaVFCeEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoqrYpV9; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoqrYpV9"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-4489b7aa0e7so501032fac.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786034451; x=1786639251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qm/y2FBEXbaeypSHSj23LmFRksLVnCdRFhLZzuIMTGg=;
        b=WoqrYpV9JMFxpxnNXndsEBeUkaHWRtHRoF+DceXEJdOLD3z/+rSR2bVW/jFwyB2NuD
         tcH4IqD7zdXziszU2dWMKpX5FnyNFkXDHIvYXdoSJqhS79l+mFBeOFYugmRQb+b4ZQJx
         Tmu2aEYCJ8OCKTCAVPQCakj0u4suVr2yoS6jKfeI39361r/6HpCkYaLkDVUnS9zG1UbE
         SerhOR7CIZc6DySedaVwGWHVbPjDI6Hz0jMAGIT1a0t6YQ0RI8/YEK3rst8rWefwV8NM
         5/4l2yHcUFkmnsSJH0nvOpRVV/4bYFcsfe6kO02hxs78PhjwUQR3nE9yluMAbAl1ty0Y
         r10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034451; x=1786639251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qm/y2FBEXbaeypSHSj23LmFRksLVnCdRFhLZzuIMTGg=;
        b=XScBuTSCjSRZRFrAsT90ffc7mqcHBSkX9awW/tEGnsAXeGkqNMhWIc5bs49Xoc8uJZ
         dTeqfTf7vw+t/efZNdfftLNOCY64zApDWtPrMUZJXhiOtoVeqdFc2Rgfv0EfI/vDSFjJ
         7Ha/d8agmF3IQK1liXsLR7KkkcLdPZLC7dLFG6hhp1L63CY7e9PJXuC9lptESkuMX6CY
         KKXLgcdE3f0qHB4EnU3Aoc+vT2Zv2ClBH9dWUt/n8GYjiP0yzHGvNBDCx4PyKRllibyq
         CbxAkpwb74XZjVVsCLWXKPoA+hwbI4E3v/2Tj9/DC+jqWwiZMx/buiTIFiRsYG2oUn3F
         EWJg==
X-Gm-Message-State: AOJu0Yyzuue+CZlDhjolB2KK+qGQdQUE2D81+xKSy7mM/AWiNNC4YA4b
	8LuNbW5rah6TzRR099YCd2qYrPrqlu0Eo+5fZt39L5UQICCRdSGS12HPiCvxPMJY
X-Gm-Gg: AR+sD1375wO9lRmCknSdLEJgyZ71l5fFbsO+pKKUNTZ5LaNuiZgewS++LFtP4sQQaLs
	1aeKXl9QH3j/AytriYyMyYD+kOxVvsMxBEF+2xtRkB/2qLlUCpu9nGv31Fl2PgVbu3nuDkBPGfK
	pJBpypjiUD5hUEo1lvy0nGujOlkkUp8JaBU8zcpCxfOjClrTD8baok/GN13H/y9otpW0M75fY9z
	SE9aEoMcH42q7kvcdAjuKvLwj9gcryEBALzDpnJYJbg+PpQCuliGvdUDZ3LuCLFS/MjSJ2mrlbC
	uok4q9vyfEoPKbc3qslTTgcTKLHL57SIMiMf1CJkHqArPagcu5D7XP4lxF4o+IRWUWsxWLlAfOa
	mJIOJ8KuGK22d7axmgqarQTjFDghQL5pTZU242/ryFMrFo+x/aUx9BrkLR3RMygxIRQcvr/8dYA
	3sdNvcAcoZzb8YQNjoku2PgfYd8nDVH/6FlLfwEjjg8UDP2T1V7tiUNbWrW+86K7ZCPAt7CVHeD
	VqxxleJXdzpTNQXLPM04o0HPjqcK/NmG09Zek7/Sz6S5HrnbZhQoXH7TP2b3cihYbh3IuI=
X-Received: by 2002:a05:6870:3213:b0:456:f700:dd75 with SMTP id 586e51a60fabf-4599ed84d2fmr8222787fac.7.1786034451136;
        Thu, 06 Aug 2026 09:40:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e24dfa6sm5968908fac.6.2026.08.06.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:40:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix sleepable context checks in verifier
Date: Thu,  6 Aug 2026 18:40:47 +0200
Message-ID: <20260806164049.3158887-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; h=from:subject; bh=PQ0w1kLf2aFAaMTEex7GTcAATPDsmBGdbtsq/95WUAw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatkx0/FZ/f2vHyUcS3dIe671J95tdfL7PNyN3pes+VeuDya w/BJRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYyU5bhf2iAUZOrWdWEvSxLXN2Tek 7uunjPhvPirWdOakLe658ZWjL805s8P9+mSHz14iJtQeatMYZqy3cteVDWISBXyNkoeWs5PwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Fix insufficient in_sleepable() checks that allowed sleepable iterators and
kfuncs in non-sleepable contexts (e.g., inside bpf_rcu_read_lock()). Remove
in_sleepable() helper and enforce in_sleepable_context() everywhere, with
direct env->cur_state->in_sleepable checks where needed. Add selftests that
fail before the fix and pass after the fix.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix sleepable context checks and remove in_sleepable helper
  selftests/bpf: Test sleepable context distinctions

 kernel/bpf/verifier.c                         |  13 +-
 .../selftests/bpf/progs/iters_task_failure.c  | 153 ++++++++++++++++++
 2 files changed, 157 insertions(+), 9 deletions(-)


base-commit: 8c7f55d60aa3512fd3da7e9cf313723460e487b4
-- 
2.53.0-Meta

