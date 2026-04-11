Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD478F4F
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938141; cv=none; b=aqjzdI+5s8xBh8idoGeEZUVzNjnwkdRBMmmFFIvutBO1urP0AOAlGzbVnlmSaNl8SW7htUxfjt1kTWfwFl4Bh/lb6izQHyVB0RiWWl8nm7v5oAkczqVnoeAJnVPlAxClaQJHtJD3Qa0vV6kFd1+cA0+QF92UumZfqUP5PJ9hPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938141; c=relaxed/simple;
	bh=8xhVsNEovXBIqkd8ZyL4/mEXPIUZR9D+ivZVkO1UW68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smu/YaQtCKjhHdCkw5bb8go+VUCHqeVjsnrAbVc2+hkaXywvuQlLf+ewjMlVRXke2hSFBkERvKWiWrTFC0WSeEgpq9SQ198RBWb4iYd9ZB3KNEKnoFOf21/g3dVspsznVbnMkhn53Zj6vsmNvPrCNYZN8EqkePMjLuTZXZyIcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Eue6Ql; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Eue6Ql"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732165d1eso12774217c88.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775938139; x=1776542939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zel3kbV3nN+yCvqWZ9R+6Oy31tKSfaLXtfM04C0iSeM=;
        b=C/Eue6Ql9GIux804mvPyZ8bGM9Y/4gN2p0G7CzUscA5KgfG0PM61/1ywnEtOPLBgXX
         8SthdvxqI0ac0gBmH3lwMMw8VQHtvx2z4+koSZzsUr4WUd7jn6DV75Z4yKGepPZyoAQv
         cKorPLnPKhXGektGvihvCnaMBceXcIfnrFzPezh2RIDEuIpQYcvyGzzuBrHjwHKdNA/I
         vSkx3N0K/kuNxS1cMKpXTqmiutZfOJN/5NitmYVLaELML1Yl7AEFEwoOlOR1bGFlbNFE
         +ZZxCfUfW07HkdJAzgH+vMGR5DWCugWOubBM2UiKJHe5d7KuZb7g7zJG4FsnGURNfZs7
         WHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775938139; x=1776542939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zel3kbV3nN+yCvqWZ9R+6Oy31tKSfaLXtfM04C0iSeM=;
        b=exGzWitsJYwoCzs4GCVpoFu51zOPdm45LZroLvYiDo1dhO+fe5WXa6Cjm0GdpHBsvh
         zJwGKtrJGlgCURBZhUFZukZSpSKQ7KYcC8CAZW8j/xf8aBdDiwaGs0qoY0ABe8SjnEfK
         3DR8ivmlALph4YS9AtzvrjepynC8WwiOfrgf8It6NO6ZYzTGQ4jBTYKeld4UpATJ4CzU
         TrvPDHyRNyaOOwN3X7Xc8mJT5CcqE7EKjx7raumLTZSfcjjlwHYmRfrlCrSPtBEjJL8d
         qthtEmF7hFmzpjYPnuCSq6M+g+1d7UCcEbya2+WEiJGbHgF5NUtMf5rExccklS0qeTd0
         z6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhSHfH8NJ4wVY3luQu0cn+328byKVuantMax09i9xuSRTHTRUqzihMtQNnaVT+IA4PFho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjreO6xcMIcez2RspBF8IDHLuwfaSWOiwnvROyygEyDOqnxB18
	cD5Wfgp7qkey3gBDBInCE4STn009Rv2JDwbndGm2JheA+/x1q7ErrTmM
X-Gm-Gg: AeBDievqVeJTzU91IWcsHo3o4DxB26/DaungOoUVWPRX7gMDcf97BkTotlzKcEB65L6
	1IoU/YvkYGKo6wqlMIeHSM5ryvR0OJ+t9UR9E612lMSBwPq9zQ0tZpB7DZJgXkXEHFRcWHGJp2D
	qtvAJkevD8xgxa3IKwzNpWhjfPMlMNqxVqG4Kmu15h/jKaYsw3F8vsnA3usLzkOGHrCn71TsYRW
	M1wi5KpB47c0347XPm1TQZ8l6cYrf3ULWrMauvyRWVtYlKkGN9pfXrPHrcPyJpNTTnCqW06/bC0
	Iucq76w463bxRZEOWlOfH6lb8/aZ4AwgvUzUI3Xj1kgujoUDk3XQsGVkDslPimNVBjoovgY9xA+
	d332skUTnJdgEJiIfTtI2EGK9QGUkAc4JV1x2zpw8sa6K/2S7UKGXHyfbQAyOXzGIjXVMQZnd2f
	4x+FnsMtFhBYTPurvb43SKGnDrIGf6j6he6HfMxtaQxRO2wYtizDHTf6qCykt1icQnuAFIX6cNi
	+h4RmxcYuVA2wp8xrDw
X-Received: by 2002:a05:7022:6183:b0:11d:c22e:a131 with SMTP id a92af1059eb24-12c34e37b04mr4480315c88.3.1775938139070;
        Sat, 11 Apr 2026 13:08:59 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm8078325c88.3.2026.04.11.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 13:08:58 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix arena VMA use-after-free on fork
Date: Sat, 11 Apr 2026 13:08:39 -0700
Message-ID: <20260411200840.1793567-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA. After fork + parent munmap, vml->vma
becomes a dangling pointer. bpf_arena_free_pages -> zap_pages then
dereferences it, causing a slab-use-after-free in zap_page_range_single.

Patch 1 fixes the bug by tracking each child VMA separately in
arena_vm_open, and adds arena_vm_may_split() to prevent VMA splitting.
Patch 2 adds a selftest that reproduces the issue (requires KASAN to
detect the UAF).

v3:
- Added arena_vm_may_split() to prevent VMA splitting
- Reuse remember_vma() in arena_vm_open(), removed HugeTLB references
- selftests: fixed copyright, trimmed comments, use sysconf()

v2:
- Added missing Reported-by tag

Weiming Shi (2):
  bpf: Fix use-after-free of arena VMA on fork
  selftests/bpf: Add test for arena VMA use-after-free on fork

 kernel/bpf/arena.c                            | 23 ++++--
 .../selftests/bpf/prog_tests/arena_fork.c     | 80 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fork.c  | 41 ++++++++++
 3 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c

-- 
2.43.0

