Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BF21CA0D
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819538; cv=none; b=KCiOjH1ll1SHTj13lOt2hQc9efzpP/Z0A98Oo7rwxf5tOUQuiSG+93xZXiBptUv/jNpDvG9wkS7EAFmGSydqhOGYgQZQvpCTd481Ts8496KdsgxVrRn5H/ZkSXIwUoYwTjPinzsyEiuHjKDxnX2++/yC/25UtffUzmvY2DJ8GZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819538; c=relaxed/simple;
	bh=S3/3gBJZ2h6FxiVPQhAy84nUWcUR6o02YrFnTV33i8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDrHHJer1yZWm2c41swfUcUnjCxY6xlGMHPwOYb9hKse9Du6zShJ53Sr+ZhpY+NZ/PwVRyRE7VCf1I/W+8toK8pQzotBA2y29N3NBoY1Hwyom4rz/0GEN2cFNRnua6Wzvr9rXF7AJiRlecxs796jRCDWkqxx9X5vtxsfpwVldTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aofhjWV9; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aofhjWV9"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-662efd1bdd4so2201750eaf.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774819535; x=1775424335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aocmb4iOjN/9JNT9RoJxLadghsYK5qiExVd5fdGv1YE=;
        b=aofhjWV9OM28O0YUop0sMGlXPHJtRWPS99/79HNoXwMM5aLvxSfhiduIVGsATaBXRL
         jw+FV4SfgxxbQcJpdKgTXmBDcKkRja+Iftxd4uoYm9/0gPBnmUGo9qwwY/gHGtKQmD2D
         ZdwY993L1tQyqhWXqb5CiszlgRLEDQuo5y+1hSm6Yd1FDdOCqYdufGCZR7ykNuWEXWSs
         pyRoRo08K8ctv9oUDXpDpGQJCRwWKzKqNHqgP4yMTX/MG2DXy2GsUz1oG4yYw8Mo6pqs
         lLxW452gfaz1beik310PE0Wi1gpDvgZWGDQqhBvwdXVqvySLGlqB1UMusGiposxvLJf1
         mJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774819535; x=1775424335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aocmb4iOjN/9JNT9RoJxLadghsYK5qiExVd5fdGv1YE=;
        b=PlbTQrcAQqRB7BjrFcvU6f9vfeuHlrgqyOylTCTIGOKySfb/qrXn9Q2n7bZZQ/tx1K
         7S/q86i8+O11fcW0+ocL91WIEroPh3xTYt3sdZYBWDWHXs1al++NaMBEVSrOCliSsFPI
         JCt+oM5YOsrVh1NTcaM+/iBcv2DEANnNokPrwbH/hDUeGWydt7wh7h+Ds8AtOA2/+85D
         mKo0XGrqOyDJpszDhZDNMFEy40UuBZuovIlzDnj0SP9kxdNLVVFpNAjXeWoMtMDBD39t
         Dr7GFFPad/Ulbncl4u/OSQQteiAIOsz0YBu88BhmZ22LyafTXC6+psLdzFefcSygTReT
         nLlQ==
X-Gm-Message-State: AOJu0Yxkt2XJqwAx4hsU+oVzO/brVC+hS9GAQ6caQ7FSuFWmc/41nAJH
	Jmr/S0a2wtjHI+NXVw3AI7bqIQZEy3sT9ZnvTxgnPRfYhcqqLYW0HVkqSbkM5o7yEUQ=
X-Gm-Gg: ATEYQzxpKIrSF5Oj/Az2aN9BbwZ1qbJDkk/QQGJycCKfbLdfSzfxeRi6Rc8LE2nzT7D
	UY0rJIdSZwvcFRxCFlNYAK1hfmqR3E82b05VnCc+1qi37GKxrAF9N8cbAbRwymFEcLrsGRmgY6y
	7l8+VjhIMkO87p6H35twJoJUcc0smLXM94CfZA7eCNMYcb32yF1q3+msa4pCXbsZI6f+EEQDZHE
	tv4JK2ZHXR185G21FY5mYH+agajYmyiR1s1Am/t+gfRbCHv/DAexfarPYSRGjzWtXjp6pQE3Hmw
	cBliikVfzySM/PK4qqHbqjky41pcK21xtZ0o2QedrTvFNlOkkXFb3LIQKT0ZA1u3ZGdI4f8Arqs
	lP9eODDn796JKYRAe9ZBIQtVglnZJwSeEpFdcMUcwtYBZL0B+Ew+vzbM0sDgJZm9fAu9iu75iHF
	bk0R3wpgt4z0rkfapSCz3+SyHDiGIjBtxlXc2ILuIeEw8o
X-Received: by 2002:a4a:e916:0:b0:67e:16d8:8107 with SMTP id 006d021491bc7-67e195e42f0mr3978045eaf.26.1774819535248;
        Sun, 29 Mar 2026 14:25:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04cf9ceesm3903482fac.15.2026.03.29.14.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:25:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Add support to emit verifier warnings
Date: Sun, 29 Mar 2026 23:25:30 +0200
Message-ID: <20260329212534.3270005-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; h=from:subject; bh=S3/3gBJZ2h6FxiVPQhAy84nUWcUR6o02YrFnTV33i8w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkdFWJqYHXpooks91q3tnGt2P+/GNz+ueJ1+9c7VYSdcCs O5Gho5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNJcWRkmP+LXzdQa98R362TohxjZv I0v77tuW7bos5HCxcVlYVcu8vwV06qmPe38YbHi95GVrUU7G+89X73cg6jU142eziYzijs5gUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, there are only two ways of communicating information to the user
when a program is verified, success or failure with a verbose verifier log.
Some information is meant to be more discretionary, e.g. warning about use of
kfuncs that are deprecated, and may be removed in future kernel releases.

For this purpose, we can make use of the program's stderr stream. Until the
program is finished loading and actually attached somewhere, it cannot write to
its own stream. This means that there is a point where all collected verifier
warnings can be flushed and displayed to the user.

An example is shown below.

$ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
...
libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': VERIFIER WARNINGS:
WARNING: kfunc_implicit_args.c:40 calls deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
WARNING: Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(bpf_kfunc_implicit_arg_legacy).
...

Once GCC BTF tags are available this can be done by annotating kfuncs with
appropriate tags containing the deprecation message, until then we put it in
the verifier for _impl suffixed kfuncs that have been replaced with
KF_IMPLICIT_ARGS variants.

Kumar Kartikeya Dwivedi (3):
  bpf: Extract bpf_get_linfo_file_line
  bpf: Emit verifier warnings through prog stderr
  libbpf: Wire up verifier warning display logic

 include/linux/bpf.h          | 11 ++++++++
 include/linux/bpf_verifier.h |  3 +-
 kernel/bpf/core.c            | 32 ++++++++++++++++------
 kernel/bpf/log.c             |  6 ++--
 kernel/bpf/verifier.c        | 53 ++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c       | 23 ++++++++++++++++
 6 files changed, 115 insertions(+), 13 deletions(-)


base-commit: b6b5e0ebd429d66ce37ae5af649a74ea1f041d92
-- 
2.52.0

