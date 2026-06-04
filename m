Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4322D63F8
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610949; cv=none; b=pmAIMgObagg8v4WPYAg2TJqCSEnrvcUZqBTNBXT99C/k+ND9b7MmrsLCY4KywjsFZ2Y1ZVjIjAo2J3hxFF3ia9aUd8t/PdyLDrN1HXm5LJ5LtU75Ev3mXvhzWzO7IrJwX+C5XshIiX4uI4udm4xCuls5tBeBSLSY20gbOaPP064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610949; c=relaxed/simple;
	bh=wl1EgPZ73oLh2FZKrzVhNcIqNN4ssianfunB+skD6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWoVFfbbBvkWAV2KdY4GgbcnODWf3baSA6T0PMsNyrnoa3qVs64sbhMaKqHFrzZdI4w9kg0CBxRnfkNxEP6NMRzEjSMSSvSUx3FuMkbCne3VaFInMSbLUKglgFNDzsdqFFpLJ0pH3VBTwIyusFihr2ypAFTNpNar5Psqqy9w3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOtP1aR8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOtP1aR8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84236f9b638so574085b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610946; x=1781215746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xe4pjIvCbIVOQdn6bIkFT1c3V4LzfoAMSIQAWXY6Goc=;
        b=dOtP1aR8Bu/77/mCettqYp5d1dcU0M5IgKZyI8793+Mg9sIDzisA2ql/x/zNDpArAn
         8xAt+Jn/+YJSAjQ/oUqy85JtA8cPDSa/gmdpNAm6lcXm5OOrtUH3jnBMBnJF18lV/9so
         okihSpOxOpH92Ws51O3tofR8fxwdkUGXeznj5qRtW+em5o6Srbw9u/pCWrnITttygjNw
         j2s1mpr8yIj9w4FRKzypiuGSP+cFm2/3PMGXlk06ef6x/2qf4G0gLIa1GcQ9zIpu+/9E
         IF05NBTqSLspeGo58pLYTzs6clyplnEX2GWdGABaIcWXAKFl38KCkzygtdLwcYL7xkK6
         7cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610946; x=1781215746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe4pjIvCbIVOQdn6bIkFT1c3V4LzfoAMSIQAWXY6Goc=;
        b=XksSIvezW+mHk70PRV8r+HsqAJcP0JYWw6fMhubgd+K1wzD2sw1syypgqIQHfXOcXC
         UQ8d6GLNnFTDpR+2l0j1mStojD0+dOlRayQb8aWOtNSV5XHmJ5kXJF77QL8/0UtJcLg5
         jEA75Gp0PsxaQvWJYgqmNFAtYFTAFh9yretsqhVW9t88vQHcKTxqBCSwno6U0/q47whj
         dcKWNINGXkmLQJLhAbpJWZesVZKQK5APG2Kuvn/9qJ4VEs9k89tGQV/jERHIvyCImOY1
         7D5uaseYapG6GOv7eNxs7WoWfI6OOHBsQNfHR0X19l1MxncG12mFqKc0WkHRmpsMbv7F
         Ov2w==
X-Gm-Message-State: AOJu0YybKi3K90sGzYnrPoFzecEpHV0mfbeTfDGEygRK4AsgZXZgCH92
	X4Snj7mPMPVa7iXvcCcu7XDu9BEPfBLfMbqCENptZiL7Xu3vTV89uNWp4lUcGQ==
X-Gm-Gg: Acq92OEm7DOzEkMe13agic8IHmzdjRbehGjNJ3GsmGWxG5CamvI9hCS4xgaDqCoAyyF
	vvUekPjrtydNjlhtO8H9CogAkI4YOyKRgFhlKI9E/FJ2yzO1qW4quIe4juOMbcJi3aKi6zC7DoF
	kzXwJ9hFMIebJ+7V0HgqR/Rcr4b/iN3rZXWk3QHQZcg5w3fQXxF0maPDPJAMYhtxYWnom2d3dIe
	WCbPFf3q0jjOmk/gvbkHAT5znTpwN8yLf1mWPYa65LQ9FiMByM2rb+oMBIxA2gmP4Hqou2Fjics
	jgk4l07dekVel5oNQZtWjV9wwRN9cAR0GAn2wGsGG56nqjgzWML/EF/CcN43IaTtVOlnMfNUxMm
	jX6d4pRyH/FQhaZqKqh0L2Aa9jWsMjEs+1AmF0xa3EIhPnMjgz1P3t0ySKOu70B+ykh3u6RLBPx
	Y+DIDdU0Etqt+jikvc+65p2JgNEyqICK+KEiw=
X-Received: by 2002:a05:6a00:808f:b0:838:127d:a167 with SMTP id d2e1a72fcca58-842b0e6bb0bmr501247b3a.16.1780610946246;
        Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221059sm6693426b3a.7.2026.06.04.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:05 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Object relationship refactor followup
Date: Thu,  4 Jun 2026 15:09:01 -0700
Message-ID: <20260604220904.1032145-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/


Amery Hung (3):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                                  | 3 +++
 kernel/bpf/verifier.c                                | 3 ++-
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.53.0-Meta

