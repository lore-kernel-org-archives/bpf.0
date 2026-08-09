Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E733ADAE
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265524; cv=none; b=N1vPre80kjwtrmGK+gIFA60fUw/01SvkbGjbp6AfHBSjguDDj7CyQxpYu3Kb01dRjhrc3cc3ggNqDqE7Tk0ozUdOuf8QfyQTohqdZL7WB0dUnNNqQWJE9lJ3nXvJPTUOje6L9+GTT0BD38TJXkMTRxfxPH3zJsoIG2kGw67yFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265524; c=relaxed/simple;
	bh=wSiNwpTh86bs+rcsEnUoA/f4kXBTJ3+K2hlsDc/PIhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mvav3hcWTQdh7kanBv9VMvp5fAsuhTfLHiWmxeYFuCbKeervNqli96y1h+MZucKQFg9eC0SxKCOv4dLo4+VMb2xiYi8I1C83tC6No9/Sndqp46FNHvLXkw1hI2zJqG6Bh2QuT+i4ll5cefT7roJQAxBu0WiXjWOwMINPjMCUEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWsoX+K0; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWsoX+K0"
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-451fd21113cso888481fac.1
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786265519; x=1786870319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=70Clan1dmzaUmh4E+Q1mw6tQK/DdeoHmmby5KQRpJKY=;
        b=gWsoX+K0mF9avBMzD92zummUiO+NMeKXdNX1YhDJIQkRfbRpKZ5kCdWsL6G/uGLN77
         ZOHnKpy7MEkXwGrpdtQcY7PXIcRcUIWoK7DcPEzPc8idO+VDvdwxahUNcc2V906PtNf8
         1Nn0jQn/FMzI8mQu90VgQp1w16vEPYxRfCyl1t/Ilu9sr/Y/xWX6Wkim7a+mzzlY+ZLR
         FO8pg2pLRpL0D16zGomPt/L0VbN6ooGMuxnwQritD+p+n/igf7+bJhlukJ+FN9Wy1PK+
         tmuxF4x6SInlPPClMTeS4wu0gqJ4eQTMD8utylteDA4oYYGOoH/bYz0K5Y+W1j7vOGEH
         HF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786265519; x=1786870319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70Clan1dmzaUmh4E+Q1mw6tQK/DdeoHmmby5KQRpJKY=;
        b=ZaKu2xb9Q0GoU7R5l3AlbCpW99YyOc0w5bDeSU5sRH9shtw6inX3srYeqV382UKoJ8
         51sTEJtWzfDNbsXhS/SZSPfFNgevrU9hLZm9WGRnU4yyEG5tBbxmhmv2xdDTv5e6kYL0
         Nq/CfzD+7BPo1a3HAhXEJnYrwEThdJoHKdYv1AiAykjwqrbK+ZJWLMQMvSby42p4MUBr
         IQww4v6MDrlyZY9k4uyjsgtsBUO6+2U6DsEL5tTHwaGTTfkmigYuRetKmIVABMHSoyt/
         7Dn0DmMAYq/e9D6d9wDMWPHhm67EnryVehJ/s1h0lJATjzfj2fRYTAXbmmCHf3KFhe/s
         tUDQ==
X-Gm-Message-State: AOJu0YzZmDTYShr5hpatggu5pNA447WPbFZd/I2hqz4L/AvQTyS73ZMD
	aitIy2ybcg2jVdnWZaT6J1V/TFsDk2zSpqSJUqJKsMkHPsSFO/UsSphj/jdSRlMk
X-Gm-Gg: AR+sD11LsKIPPYx+bW0B+zb1h40FCYx2jrVvQv62qOWPr1zySFjs1Myj3TqB+3srBKd
	aMDXP9sjQBiKVJz7feqmiq1sL566vEC9gcZI2VwbNhBsS3IL1WQ/XUMW6CLzGgg6cm4YoF2Kufe
	wp0kNlqr6hjk72/4U68i+/gMxFHJ6oyilGWaS7tyAbxQEIlEn0CarjnHwHXUrv1n9PByygaFtJN
	Pz45jtJu0nXx7CzLt71V2aLboUmw8+hlEbZROrZ5tgLNeQlJA6DqgK9BTdbInh44Z7k9nKCWjMR
	kMHWD31zX9cvG3WH3D1/1P/zlTiyrK0MHV+6dJ76CK7z/Oh3ouYm2EYA9v+YlvTyqZjyqbrWGS5
	j6MY2tBTU34IXMOM3hAl/n0OH/ce03k5DZOChTW8Ei6mnm4ERr1djZe58WVjvv7jRzpoaQQnEuO
	VKzrE9lYjuLt6Y+/oYgfrogAGlxPQxKd7x76QhsOT0CaolCqns/Py90mOGcTCVRRHaW/TPkLEPO
	NLs1AICn2D+JzXDXvQqyeGfIjb3T8FQWgqo4ZNs0SaeMbm/M+gyls+17uODKCQZh7EIzQ==
X-Received: by 2002:a05:6870:3c8b:b0:451:fbeb:e9a6 with SMTP id 586e51a60fabf-45a15758165mr5699549fac.0.1786265518731;
        Sun, 09 Aug 2026 01:51:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a88ef6sm5740534fac.8.2026.08.09.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:51:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Add resolve_btfids support for __arena kfunc suffix
Date: Sun,  9 Aug 2026 10:51:52 +0200
Message-ID: <20260809085155.3305519-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=630; h=from:subject; bh=wSiNwpTh86bs+rcsEnUoA/f4kXBTJ3+K2hlsDc/PIhY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavCfnbxnOXCch2mp2fsDmuI9YguTmNg36rmET1V+oTiraDn SZwdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIizF8P/DAvDsNJTT1VKT2ewxD56+E tzfcr521k+Pn1XjnsuE2Veyshw4rbHQaW6kyW/iqM4WliXBb6dt3bX7qggVoawqggmZk9OAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Use __arena/__arena__nullable suffixes to emit address_space(1)
annotations on kfunc definitions in vmlinux.h. See commits for details.

Kumar Kartikeya Dwivedi (2):
  resolve_btfids: Emit arena attributes from kfunc parameter suffixes
  selftests/bpf: Test resolve_btfids arena argument suffixes

 tools/bpf/resolve_btfids/main.c               | 62 ++++++++++++++++---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 35 ++++++-----
 tools/testing/selftests/bpf/progs/btf_data.c  |  9 +++
 3 files changed, 82 insertions(+), 24 deletions(-)


base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
-- 
2.53.0-Meta

