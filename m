Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164D43F09A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152857; cv=none; b=uvosiTWF3QO60EMYlLAs/t8HBu1ssCNJI6aLh2yxo9dEjemY7WTOa3bbdBjms6bmyy8d49+9CnyegJD0zia9qRmbCPhMOXBzYmyRnd9JQm7U69NC8ihd336ZyP1cnDSix5Vbkxn5sMrVSPkHy8FuUybSrRTTcWBAQTUUUpKDZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152857; c=relaxed/simple;
	bh=26CozGQMtf2YSlDdfqRWBYMtkvrbXKWW4fTm+25ETy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0S/aBsazLiTyytbT3BcQHLVOCFWCK3/vIjGdW1YTBRHRVVW7LdMJTjADNF1+ZReyoq3ux1O2vNBqmWHDtJFaEwBQzS6DBtXgqzHP2X+etHRYROmuGwS09qtos0uI8OUtd2tE+hHWQuDtgrKPo/ewgAo7qbZe262kIs4HP3rdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCVVC39d; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCVVC39d"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4731c03ab71so1727219f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152854; x=1784757654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHgCLyWrfWVLv3Peeuqv1y/vIJgcsRMO0bUbFIK6fzE=;
        b=WCVVC39dqY04MxRYWAyFa8u9WdJ3ti1MuWq5iWUoKoR76c8cF714u/8mGSQ24SPEJr
         3kYrXwN23eNPkpbRvDePDjORgQy1tYhcPFU1XsZnwWIYSw78e09i4c9KCAEAu+EhvYy0
         Xo9Oo/r5HtZ1r29qoCrsLvx0Vjobo2bqJoKV/Bp6m6fTt22i0kS6Cy9xS7wWbO8Fkyce
         0qkN1WbvpG+7xGrFolglBBKogp6PmC4zx4Lb4Wy1/+CrxVdeUe/ZZguefyITUZFERjda
         38s6qXmzJ9gDOeVHgipZK147XDD8Dwx5EOBn7T/dSSyWlO2OpOZTtho5z+Lk3fsIU1tY
         AEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152854; x=1784757654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHgCLyWrfWVLv3Peeuqv1y/vIJgcsRMO0bUbFIK6fzE=;
        b=SGAaVJBFVzE+rUUJkLq97vfAcCde8GCZ1w8ecuCj+/bdw54faVz7/fOQG03isHKpC7
         zpb8cpgfOXI7tnPE8qy7Xd8uabmt9EnaykBt0bSgkBNlTMrfUj67dEt/gsUXg+KWPEu7
         4u/Htpr59eDipeDA4+Myl0i9qo81Xo6K0y3DZwnODumat8BirwQjh6FR4SAP5A4X0fd6
         KIKPwkK/dZ0T4OjQ6eLLyBpSxBY0wDENffZhFZD/9Fai5oeVscrbH+90UjtrODtRzJVw
         RuTxOLytEzCxR1qQKQQ9qNOkA8ibMkICYKSEvFgHu9s/2YOg6SXHc8rzxXDuY97ggYff
         uOjw==
X-Gm-Message-State: AOJu0YzPKCQ7erREyvTNb4sOzE78ACpEZ2gk6eXofMeQA16IvFEoefjR
	prc4CzRlZovL+mrDEygwCESPchcX76Ok//wIVokAghzXLCrd0fj9pjpi90boOd8/
X-Gm-Gg: AfdE7cnxmev2h2IHm3w0t1FBwnZ4Cu71sYCbhVpXkdgtUng+IlrckAjdejvV5Jp70mG
	vLDNsy03C5ac82hR1FIeZJBQsKSCPWnztknoylpbmKRb2PBJ2Vp5jqY4T5IXsPyGJdDY5ktmL7C
	cS+Y+9FtPLN/KaLB8GTP+lhq5iZSbyepih35j27ZH27JPwDJZVGUAWJ10FL3Q+VAvwJ5h7KW/Lo
	NYtmL18ZjkIvIqKqE1UQXorjlhuVgjKN6FgDQR/QYwA/ZAD9bFr8kIXVpHxHo62f2IOiRAzKpeW
	YwxDrQyw5tga64n6HlFmC7ZlF8pEaEcxsfEbRb70SIqNhnlLiP3uPWPYFDUWn6FAwfv5uHaVOKh
	+piTPDXh5G5mrfK3alEmmA5L3sNWtLgP0XmMVH6P0KcXTZ2StcjmSqnKaHE7lBPLewo14tTqUTy
	5KvKm0/9wx4zN/EzlyF5rTceZ/ifCO5fwjuxJJNEKI0dyvV44vMqA66tesN8Dw3BXOMpXm0is+v
	iEygbQSXm2n/PWoYBQ8A+8CFV8JHjKYtRybPKgRFJHa
X-Received: by 2002:a5d:64e7:0:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-47f488b75famr9724580f8f.54.1784152853697;
        Wed, 15 Jul 2026 15:00:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a5d7sm19000525f8f.10.2026.07.15.15.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/9] Add arena argument support to kfuncs and struct_ops
Date: Thu, 16 Jul 2026 00:00:40 +0200
Message-ID: <20260715220052.1590783-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=memxor@gmail.com; h=from:subject; bh=26CozGQMtf2YSlDdfqRWBYMtkvrbXKWW4fTm+25ETy8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6ZZQ0LlpomtM3irfm7bpVvbVD0IZWody+eWK9um90 zly71FFRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACby5A0jw+nsWSdkDh59xSPN Gnfj9eK2vjRW399vZrbdlnWfXLPq4FRGhqt/LUKW5MhNetHandGWd/jigvPFO4rdnx693Mc5Z6p JPyMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

This is a continuation of patches in [0], with mostly minor changes and
reordering. The motivation is covered in that link. A major change is
moving to two tags (__arena and __arena_nullable) and moving the changes
to JIT to emit more optimized sequences.

Please see commit logs for details.

  [0]: https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org

Tejun Heo (9):
  bpf: Support __arena and __arena_nullable kfunc argument suffixes
  bpf: Support __arena and __arena_nullable on struct_ops stub arguments
  bpf, x86: JIT __arena kfunc argument rebasing
  bpf, x86: Convert struct_ops arena arguments in the trampoline
  selftests/bpf: Add kfunc __arena and __arena_nullable argument tests
  selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
  selftests/bpf: Add struct_ops __arena and __arena_nullable argument
    tests
  bpf, x86: Fix stack-passed arguments for indirect trampolines
  selftests/bpf: Test stack-passed struct_ops arena arguments

 Documentation/bpf/kfuncs.rst                  |  39 +++
 arch/x86/net/bpf_jit_comp.c                   | 128 ++++++++-
 include/linux/bpf.h                           |  28 ++
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  34 ++-
 kernel/bpf/btf.c                              |  10 +-
 kernel/bpf/core.c                             |  18 ++
 kernel/bpf/trampoline.c                       |  64 +++++
 kernel/bpf/verifier.c                         |  65 ++++-
 .../selftests/bpf/prog_tests/arena_kfunc.c    |  15 ++
 .../bpf/prog_tests/arena_kfunc_jit.c          |  13 +
 .../bpf/prog_tests/test_struct_ops_arena.c    |  72 +++++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 250 ++++++++++++++++++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  96 +++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 115 ++++++++
 .../bpf/progs/struct_ops_arena_fail.c         |  20 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  95 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 +
 20 files changed, 1055 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c


base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
-- 
2.53.0

