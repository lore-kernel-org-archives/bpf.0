Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF3360ECE
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481411; cv=none; b=Eu8RB+l9OgEWgrbrseZ/rcb3iuH1BXp4w4GYQezLeHW49WfZ471qsC5P/h4fBVSf/r90d+kPGfKgnJmq30nkm3kkjwQDh65T+22dOLBM8pSSv3lBM0mdyXndQSiPBTtfcfZZdFpJlIX6KLZMf2gD8F5sEYHoiIokVSExB7AjX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481411; c=relaxed/simple;
	bh=SrVuWB/vTq6USm3SpsJiG4BlNQtr4nXLavPzcP4AFWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbD28UjQet2RSLVcK1Zuf9634fW29MP0jTZat2bm5Vacb3C3aBNO/WWMmnN/PfQWHotr4F5vnlrgzwzUmv5m+clJfOwpq2UwnlNjQIWI+p39TLVSF81Qg1fnQKxeUT9W9DFwJl8JermPszMClcYVxUdP+mWUpnWUuDiDMTuk6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf6nmejN; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf6nmejN"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48436370540so1466485f8f.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481407; x=1790086207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJnfE+yL0Tf1XdYmanO5Q7oYxmb2mZsAYt1Cj4w2NQ0=;
        b=Sf6nmejN1WE60KM66LPUlUsN/3C4kiTs4lwXRyWuTdeSf0WxxFfO0Qsq5+QgmThxXn
         fjllZpIFTtiu9jjLKDV+yF6X/3CYrWOYdhGv3cElLCSVfNoT1WFp2XdVkoiCWF3+ZyRu
         JWrSM0JblQsgMpNfIpa4P5hnltk8J/1if/7ooW/WJ7Adv5FbZweSk4lZImEqqSGNuRln
         /P1PkZhqNpQn90uzhoPkQU9piY3UhW4dto69a18nOXSFelDI8urKgKArbjovtMrs+VvW
         eMTMPxr0iqINZ06FBlVQcYoap2pvNeq8RSEMWTteN6ZohbbOfdZYLQkXfGg5+lRFmMz9
         5ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481407; x=1790086207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJnfE+yL0Tf1XdYmanO5Q7oYxmb2mZsAYt1Cj4w2NQ0=;
        b=e3xkbQzXnOA0VDZ9SLL3DWEFQ4SZXiuVVOAzj3Ro4GfEpRi0VVvkClhKweYPf+YHlg
         U6ISotXjMIIDn0Y1xf/sfshpXtek67ngX4R68Q3Grgi0nN4z+A4yjByKkmjTgE6/uhq9
         AtlMIrFC28GYkgacQVhk2MDRPwx6J27hG7knO1y2/6nEA//Pq415aht9oy0GnOE9Ffpx
         QUH613Tx8zl+ECEKRALEG/ukxoenFf2uqiMirSWbycuWqzAEzmWC9BvD4fIHwP84j9mG
         8tZkCGpN6EISwrj1QkngWDCXLboVIFFdsnQDchikIz0Y6sq/Mz+EDnmZz5t2bbeLU46e
         H/jA==
X-Gm-Message-State: AFuF++mA1UXmnPYRFmZCKJoEChdIyWcyYFxl3M6unL+H49PbhP8ULbn8
	ENqeH1j8BxICtaMZ4rcFXpYlfwBvFMgy2TdulUXq3ryR6SRzmjQZBWUWEHvvxzUxmS4=
X-Gm-Gg: AYBFou0vU97LcLSeQCKP+9rZ5eQm3tOVFK49d7vyCVTjYX6B/G3hExWzT4tqnsZcQ69
	Ns/J4ntMAGh9X9rYNw/gVX+G8DGPCq9Td8JmNAJvioe2CK4sgAU7Gb7BYA07LKrgJvvETmFGH6g
	eRYNEIxu0AUPo3pf4vwmeXmhu2YneYCuXUVGEzHH5R3B9a3oOJ5jWui0/TVeSyxjTTbb/N6pHRg
	mgriDR8p6daJQQfyNi8L5jK4tF9OTDpeTqwPUEMtvJQZJ0sYYbyiB8YbemhADf6meeYjLg+APmK
	GVRFfbPUXppHP++59XeMbVruETVdQ1gtct5resO+pZJ3sWb4vG+MgZbvjP8IgmHfimzqMVTtB8q
	IiPHwnLru92Z3ViQWOO8vqb643YhsrSEGt10rvghvkrUl+vmTgzg63gewEC+aWM2Qjc5FbwVuXR
	MMQkfNCkxhYGDVF4JTFlXaTsLCOj/NSSttow6vL8vvz9H/MG7f9yiTSYNrAYPzmakBZ0+mSQvSL
	KrgThBcUNqpz5wxd/x1ibUx8pTFd2tcc7+rJmhIPtT8Nt296mD+JCv8DyUZLjvxLebF1e+jyx4B
	pTy4TyHVXa1tV8t7PmccxqcH9QupV4HVgfmv1mPv5v/Ly02s
X-Received: by 2002:a05:6000:46d0:b0:485:8c16:5ef3 with SMTP id ffacd0b85a97d-4870a9fd073mr786596f8f.45.1789481406221;
        Tue, 15 Sep 2026 07:10:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870b3de950sm281483f8f.1.2026.09.15.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:10:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Fix generic __uninit kfunc output buffers
Date: Tue, 15 Sep 2026 16:10:00 +0200
Message-ID: <20260915141004.1196460-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=memxor@gmail.com; h=from:subject; bh=SrVuWB/vTq6USm3SpsJiG4BlNQtr4nXLavPzcP4AFWE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtlYOcZ02uBqbs235PS5HrYfTLXvtfR8smZv3Pntn3N2 BIb/Wx6RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbS6cvI8GVVXen9Wstao4dz xR5zFost4NscLa28pOuR3BPOpewbTjL8FX/1T7ZxQ/mRmRc27OPh1RUJrdwUceZUs/CExp0LLbk SuQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Generic __uninit kfunc arguments are output buffers. Their stack
liveness already treats them as writes, but argument checking still
requires readable contents and does not record definite initialization
after the call.  Check these arguments as write-only and reuse helper
output-buffer tracking, with one entry per argument slot.

Kumar Kartikeya Dwivedi (3):
  bpf: Fix generic __uninit kfunc output buffers
  selftests/bpf: Allow privileged preparation for capability tests
  selftests/bpf: Cover generic __uninit kfunc output buffers

 Documentation/bpf/kfuncs.rst                  |  27 +-
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         |  70 ++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../bpf/progs/verifier_kfunc_uninit.c         | 399 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  56 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   9 +
 tools/testing/selftests/bpf/test_loader.c     |  41 +-
 9 files changed, 577 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.53.0

