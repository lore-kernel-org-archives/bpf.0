Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4DA3793D0
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563527; cv=none; b=X/1ncatImuwuLu2ihX/wTZQa+Z3TvhfpXSt53QGIpcfrPFv/yYSADjOzaWa0M3iRkNIp7rZ/d6G/C+yy+aU7iYroGEnlMoNyRgv+/Pg7VkSzcYHi5qnxSnvQa6QRRZ6pWe8e3KevitMkT8zDpHY82jAsQruLR5Sovmdj8gR/sEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563527; c=relaxed/simple;
	bh=9TxroXg74b8J/zK/7dji8h6Q1Gz3KTI4mD8hlyVK958=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbUgSfPRggU9itXQRGiwbK42466tgGSCwiBv8RDEpPr07YQefKNKCv3k+pXFhQcltBe7odFKn3pMTlF85GT6nbOFpHD84XTCfi+1Su9zdcCqU6Y6w+hufcPrHpyQtxAo5sVblkCmdUcy2NFF72kyxWD0uI6lTLTWvDDF9UJn37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHRQPMEO; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHRQPMEO"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so560682f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563524; x=1787168324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFjqv1qU3XzSv0YE3geuy7y8xQ7tw8tmFoDns+pcsoI=;
        b=bHRQPMEOEL+cJnABHdi+0zli+NNEseBOPpFvkAl+cWmxuD/MzXZkqaRqKx4d9cuVgZ
         2w/Hyvk4EF7ixWyDabk10DtI+7IuMmMuE75a9F3LVhNLmtQThERrxLKK6RwjlxXO9xt3
         K28M19xHnWXO1097Q/7cjlpXWKAfPWXeb1Ewxa0aM3FEGcHmdtVHIJGfWMLbABmVrKPB
         om/Gy2P/OgMTIcbEEXyNDZvNvcteDHL8cdgtYCKWlueehVpfBoewWPIfvk1HrkjlDn2e
         4C8NWj1ww+fqxmkF0wsUv0UBmSBvyf/K1TSIvEv6ORc0kJ+tjO3slFqfoufIyOstuqIE
         RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563524; x=1787168324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFjqv1qU3XzSv0YE3geuy7y8xQ7tw8tmFoDns+pcsoI=;
        b=dEvvP7QvZhfNAuu4njDNSBMijyxJKRmZE0UzJ1cL7eW0cp4bfkhYFQc+DtHTKf5GHq
         YXuZllMzvAjYcRzQEyQfFkohYHPr1YGE8WR5h7VG2quDoeiAITMkSxNM2CbDiP5dgxJm
         MYMaL1uQ5+jrM4gT9wEyRomdGH7s7+vZmvJnCpKxl+YHE9AvHP9p4UTjBCXAmijirEdl
         waiiRntjD+TeYt1zeb0bj5rja3BmuF+7TcCyoCtGWdFfgKtZGgcEWPImj0kYeWOI+mHO
         MpeSWyNuXJqy11dGLJD/leI+emS43DC3UB2Lc8jmTc4KI+E3hw8HmrXlqzEcDI0jxxY0
         +Hxw==
X-Gm-Message-State: AOJu0YwAoTxFZdepMX5IZL49da0if7O2o2S81iZ/s5D2kNGAYEhDkko5
	QBv7uSToT5HtSqVGsjNOmzZR8z3wxskGdZtHN1Qs4kI2iSa5UGWqwft7u8j9676J
X-Gm-Gg: AR+sD10w/sLqPAvOp+6/tCAJ5qhG3zRDv1ZobEa02M/qtB/z/QtRXCH8OxyOaT5bbbC
	vQO6xSN/Qpu7yYYNkU+zBgot6HYbMIArRYIjMO3g/wdH96Dn+T980tN20UTrenaIiZjD+KYaGlB
	fDgsnW7DTCE5QRuHN5aal8milTJbLuD7owh+mYdgXwOMNicBD6gcAPBYtXyxVwPv2FLpajczJ/F
	A+J3B/qvRF5kzLImrOElvL5hLJx5pMApAMXyP0jbYRl+lujo65Hq5HT7RkPS5SZCdvlW1zfBhZm
	qp6dV6CJ3op2H+USEcJWq1yQEtktI0XMFvSp4yKxsZCEfB3ha1tSkh47Ll37obkbzXyk9kGdplS
	ZsFE88Y6h4q8N8Dk0pFYO4a2RYDguT7Kuv9OsVZXDI3Wy3eXS3ZEix85+R2GZae7nO156oZe+XG
	Y6rz1IXm2C7lGx1WnugPl+2DUW274BkZjXM2nek5RhqQ5WaYFmQjKL/QVi0N0gTKyszoCy8yjWE
	ZrR3vUCV55nozGfRgFTdQpAe0wDqh5zaGEfhcKiHzIGFWpP5Ia1fnlfbd2tAOvyZ697PfpdzsjE
	RZ/3d+q+w0pNrVP2cmMaaEKKw4A=
X-Received: by 2002:a05:6000:1846:b0:47f:8f8f:db74 with SMTP id ffacd0b85a97d-48159ec13d3mr793898f8f.12.1786563523938;
        Wed, 12 Aug 2026 12:38:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d72232sm9840899f8f.37.2026.08.12.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:38:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/2] Add resolve_btfids support for __arena kfunc suffix
Date: Wed, 12 Aug 2026 21:38:39 +0200
Message-ID: <20260812193842.2879226-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=memxor@gmail.com; h=from:subject; bh=9TxroXg74b8J/zK/7dji8h6Q1Gz3KTI4mD8hlyVK958=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmtCLrk53uP3el73j7J2XDlqB7QdbHp5qs+NlRqn35q ZrYGeeNHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjImmUMf7gb1VbWLdC/dCSa t2qJjoDOhiCnlGnxXNej8ozSVMQEeRj+p1Tbi2WGvBBsaJ+17n/km+uH6ztqiwPFfucVmcRJPmj lAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Use __arena/__arena__nullable suffixes to emit address_space(1)
annotations on kfunc definitions in vmlinux.h. See commits for details.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260809085155.3305519-1-memxor@gmail.com

 * Avoid enumerating all the ways resolve_btfids can emit the
   "address_space(1)" attribute in its header comment and in kfuncs.rst.
   (Ihor)
 * Drop the kfunc_has_arena_arg() helper: add_arena_tagged_proto()
   returns the original prototype when nothing needs tagging, so it can
   be invoked unconditionally for every kfunc. (Ihor)
 * Add resolve_btfids selftest cases with mixed tagged and untagged
   arguments, and a kfunc that combines the KF_ARENA_RET flag with
   suffixed arena arguments. (Ihor)

Kumar Kartikeya Dwivedi (2):
  resolve_btfids: Emit arena attributes from kfunc parameter suffixes
  selftests/bpf: Test resolve_btfids arena argument suffixes

 Documentation/bpf/kfuncs.rst                  |  4 +-
 tools/bpf/resolve_btfids/main.c               | 72 +++++++++++++------
 .../selftests/bpf/prog_tests/resolve_btfids.c | 41 ++++++-----
 tools/testing/selftests/bpf/progs/btf_data.c  | 20 ++++++
 4 files changed, 99 insertions(+), 38 deletions(-)


base-commit: 3a59f11e0f989bdd637c87151992605a6559a7cb
-- 
2.53.0

