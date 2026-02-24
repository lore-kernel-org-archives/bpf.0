Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84C18C933
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924947; cv=none; b=Mk5gX9CzqdM7xULoTQa+dgzWCLrjG53LXF6i5TTlAHYrHdEWAX9A5ApVvP3gjOAUd+bZ1WpS2KKKyOWj2O2gIHgD7971b0g1sKCmWkYRGz/4sYu8xXqMRQxcEJOUqvoMHKAwa1yB4F52QG7nKxMk1kYLg8ntBR5vMi/X8/CbxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924947; c=relaxed/simple;
	bh=VlROADzLBdvADEC6gprBeewTzGs6dd+rHVjt/NXRkHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Boq//GH0+Ig38K4IrfEoxYMLIeay+xo/qWY/3s9vLM7n1WAMFIgPWVZ7hw7RVitOglUtig9bSuU7DX2yrNKR+Eub0JxSW1W+zgQ3+/nq3Yq/AnPZMlQvLdeuKr+rjzv1AWT2+G6SRpzjeUAOG0jwfKDIjLO/dOKUZswpm52+m5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHY5sumw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHY5sumw"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ad617d5b80so32934605ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924946; x=1772529746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mIPlGUglrjJyYi2dqgFCL83ozadlbrMVQN9MvZE08o=;
        b=lHY5sumw+YZpQcS5ZT+jUHv73U8JaK6yQbUGhdvLfo/obYRewMRe1r0VtNYm9k2BcB
         FbDC2m9PXLrtFj6hpMg3zt5RFCUSha/uuPOMYhgWgY1RGD91fQupml5GD1JDcqlfWHy+
         /bv38U13irbDpMPCXNrZTowd5+5GJCKjt8yzVT5iEOazQiwKO7yhAIgDV1kXXUm26seM
         opjbtkRycu5PnVo9Bc0ag3jB5Wv/LtyPws08EXOqYyRm8JAvIzuZlc8HLQao6BiUFE2x
         TJyhsUo6yTUgRq1bmz2yF5335Noa/2kUhGz7pU4N7d5xCCUxNiP+DYQBzP5ULU23SKsk
         m5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924946; x=1772529746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mIPlGUglrjJyYi2dqgFCL83ozadlbrMVQN9MvZE08o=;
        b=LwRyIpr6CzRNYs90H8XvoRrLN3G7nSkjP9Ag+lBbWlokTbUkyudyjnmCocq4TCOODO
         8QK+MiZp+VXJO7FoXF/RpCxE0yHWEz+bG4oO/rdjWDxucWpiZYi62pS0L5eIFKk3qWtE
         jQ1mrCTws2MuRViYN6Bxb1KKdEaEBjMYRV2+WMe4QUauk00WQXGwOJzFDgwn7LuGk3e+
         ZTCz9LFuw0Nw6ygfqtpepl75L7CbO3+mL+erjpDqjj/acKXr3xjfZ6LC7v2GnPjmMdoD
         y9914DxxubmUiiu5vAC2nfR9rtmzPBXnMsUa4KtuUgG1ttC9QhN+lqPLnUgP/iU9evtJ
         2Abg==
X-Forwarded-Encrypted: i=1; AJvYcCXZJG/6AR9GVVykAooVKsQP3DgaL+FcPMea4ShvFHvSnjI5RzNwllrv7AqOtIIAt++sc14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsaEeZVeuSAyBBqPKTJSxhMvLEKZOtYewNjtK86xRrS59SQjEd
	u8hLoe1Tj0EIosmzi343eTBXJOa2+4gnCDBWlXFIsUdrWWtFl/NlBvEi
X-Gm-Gg: ATEYQzw2jodNtAS/lg1/nbfXTamC7/8axwugfF/ERbF1Dm21EVVmbVI2tzrxauTrAPW
	UmoFSEuQg4GC1oOayTURZoS1hkbw+AmRXXkeN1VngIo7Z6VCHpahY/x+GhL9D8wUETMZ2jwuYOc
	c7JVd+oxBIMD+bpjPHt04z/kkHooE1mk/ttclWqrIp+Z7PNoynqWrLNSeaf0DneukR7bLdTBd1q
	5mHM8z7xNPVR0IhxMUXKLJGED5NYa+70G7R8GtOwbDbKQoYPPyrhwQyoUE5wvLFdBCPLr9t8c2M
	k/01FBRqe3gtpz6PcMJ6OaoWDKALq0M3cKpIPRZ6ANtRw2ABi6hetsMlg/Cms5y40j9hA3Zopq+
	Sork2GFvrEJ4gSd6tbN6tKULZJfs23ggiGdMK4tNSjS/FlN2wamQIWD6vqv3ovgcQVcDClwZ2cA
	Zj9ui8jWpeloWjVqutOXFy
X-Received: by 2002:a17:902:ecc6:b0:2aa:d7a7:8084 with SMTP id d9443c01a7336-2ad74419486mr113804165ad.6.1771924945667;
        Tue, 24 Feb 2026 01:22:25 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf: fsession support for s390
Date: Tue, 24 Feb 2026 17:22:05 +0800
Message-ID: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the s390 architecture.

Changes v2 -> v1:
* keep LGHI as it was in the 1st patch
* fix up the comment style
* remove the unnecessary checking of fentry->nr_links and fexit->nr_links
  in the 2nd patch
* v1: https://lore.kernel.org/bpf/20260223084022.653186-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf,s390: introduce emit_store_stack_imm64() for trampoline
  bpf,s390: add fsession support for trampolines
  selftests/bpf: factor out get_func_* tests for fsession

 arch/s390/net/bpf_jit_comp.c                  | 95 ++++++++++++++-----
 .../bpf/prog_tests/get_func_args_test.c       | 25 ++++-
 .../bpf/prog_tests/get_func_ip_test.c         | 28 +++++-
 .../bpf/progs/get_func_args_fsession_test.c   | 37 ++++++++
 .../selftests/bpf/progs/get_func_args_test.c  | 38 --------
 .../bpf/progs/get_func_ip_fsession_test.c     | 21 ++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 -----
 7 files changed, 178 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c

-- 
2.53.0

