Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A19280309
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475398; cv=none; b=QH02TVoKBy3/n4GefZ6dimWmCEamxCD9ALL0uShmNutYHyE1kxxaj9C/ro84dCjCLozHAjBS4DOsFE6x0wt0JjI9s+s/gsncENHE/VxsJPgX+uCDvLvUPDyd1awgyTYN0Zk+112sy+vbke5VJD8k/2p8du1LcAUt8mY2H5f88l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475398; c=relaxed/simple;
	bh=v+DEtAPrOuoePYqstQ97i9wSorIZp652vDCWUrNJM+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwDN3+6i0nCVTW0DoyCBdwt+BMSKfTONlV64gIG2uxJxupwqXLxJ0x9EhWXWwmg8dIixxNZcSt2XUiBIfmQ8CK5ZA/iP82K9/NsuquGL9dUq69/vyi4QxLh1g7OKkNYn81dB6qs9y8+Pxus0eFLsqEY3OgviPJRrPhW/NbknoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyFXGzaQ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyFXGzaQ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49550ec5b41so676485e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475396; x=1785080196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bi/F1iza2ZUqA7NVgprB//7f0ohEHCdZeDXgNhSBQyA=;
        b=jyFXGzaQpgq3ditoY6xw3F/1EoOjgwXbD7Kryg79hGW8l1fZ31D5gAfcZ1FuCimy7o
         6Jb6ic6uCs5i3D/nIG4On10LUgbFIEB9/RN7sKF8AaNtQ+5DhOYuWZ+O1ksM8I8srPQH
         NjkrQeKs2jXCqnnot4WxA3GIUZxR7tiD/l7P4HDiJoz4twRuyODDBjtt3Cq+zDI33Ar9
         yTBEiIc+HWOhEAwSsSSo8LXHJjexeruZNsEd5Q/fb1reIwBS1p/7oujzATpTULRk/89p
         tID7Ui/xR8wGiTOvAaFOBnwsUY/7TOhrkRrVvBqTpfqfsAOic27pizlOu7ImPSWh0l5H
         uS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475396; x=1785080196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi/F1iza2ZUqA7NVgprB//7f0ohEHCdZeDXgNhSBQyA=;
        b=o0AqQT/H6moFnoiX0v8blQCuKaP/O1Kq84YWxxjPJIAitTN+ibjHg08oWueLdRrOoc
         K5UP7I2KF7pvqHpmSsPxMCmlSgrv2Qjzoqn5jufYOVLS9qcknHJnqPaAQ+cavrV3qPiB
         AK0t301FmQuBBtFf/3un4o81fE/B/X4uKjzw4+nSjMTV52kL03IMljsF4hdQJ66dehG1
         mNz5tqwSpL7SEQufLpIG0Biz6fFrrqvmiYqxeVh5PR48m0kbTqat4msWPIsXgoxUDwHY
         VygSlBLccxh868vo8fE0+ztb8OJ0HU2aAkSlmuAoaJWiJhcSX2lad76gr6V724JQRhZ7
         MabA==
X-Gm-Message-State: AOJu0Yy1nx5Wz27zcxXoBShrfGXRAj/ublvs4lZFYh0DJA+vf2JxcVii
	YNOo2hkXZTivrftOMMCdjqnYjEq2SlDJJwMakCd3F+sj6ldy5RaslsJRnVmOOkl8
X-Gm-Gg: AfdE7cmj/25cvrqTVmHRZGnfF6pqtquFjrMxU1tjHPQff1+S+avwablnHi08QfmpD2S
	8kU7H5y2IXgMHYAAn+O9met4TS7UdurgEvA35jSyGaeGa9aparyTzFWpPQm8779UkrWARWbK+1g
	BBDbrsyIi3+6j7Gvq4VJcBz4N65wW3VqxQsmifdHZM89LexxvlYNC86+lEGrYQ4XSz9PdniBpha
	D1cZpDKJjxvtn8ZSgEBpCueIvbRuFUm4kvrIpXXCmIGNigbADwIRQyV4fqT9GAtNe9aOVqEr4Fg
	YRaSsOdgweMZCv2Ui5/0ouJT/c22T+jBNfF8Gf/7pr9qS89jW6y8WNY/4Uwp4dMPa4bhnNwoJFl
	/mjj9Cv3lTKzwnjv5pZWTLmNKV9ONShwFYYvF0NjlOycMoEhZgWu7TOYmSLkDrB+JkoTwapyklV
	fzLgNce8gwNvEWw4H5aew2JBaXoVe4nyV1D5sPdyQy4TryQo/UW3gtKuQOkdZhdYp9QCU9BLHDz
	qrpmTLck3OehvvLyPjEr1jc2S8jzVRZVp0loHzCCoDQ
X-Received: by 2002:a05:600c:4f09:b0:495:5b32:df72 with SMTP id 5b1f17b1804b1-4955b32e0c7mr27690555e9.35.1784475395290;
        Sun, 19 Jul 2026 08:36:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47de7sm213237225e9.7.2026.07.19.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Fix unique field logic in BTF
Date: Sun, 19 Jul 2026 17:36:27 +0200
Message-ID: <20260719153634.2908692-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=memxor@gmail.com; h=from:subject; bh=v+DEtAPrOuoePYqstQ97i9wSorIZp652vDCWUrNJM+Y=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlTiDqhy7weLvSx4dKnLq6m9tmCUrvLxb/tjrFbnX0 /eIuFzsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZwIZwcQrARBQMGBkOnXp94hqbVsQST/GF zv7N7Humh8efOHfpsWKax/y0m+mfGRmOPNuZsNlZmkm6erX9Ob758yccff7j0fXpB5beuP9h07Y /vAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Fix constraint of certain fields that have to be unique when nested
structs are present, BPF_REFCOUNT which should be marked as unique.
See commit logs for details. While at it, fix improper offset check.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260719142401.2420111-1-memxor@gmail.com

 * Add fix for BPF_REFCOUNT not being unique. (Sashiko)
 * Roll improper offset warning check into series. (Sashiko)

Kumar Kartikeya Dwivedi (5):
  bpf: Fix offset warn check for bpf_res_spin_lock
  bpf: Preserve unique-field state across nested structs
  bpf: Mark bpf_refcount field as unique
  selftests/bpf: Test duplicate unique fields in nested structs
  selftests/bpf: Test duplicate bpf_refcount fields

 kernel/bpf/btf.c                             | 30 ++++++------
 tools/testing/selftests/bpf/prog_tests/btf.c | 48 ++++++++++++++++++++
 2 files changed, 64 insertions(+), 14 deletions(-)


base-commit: ecf11bc5f56abb3a2219a8c75e8a5b54467d1781
-- 
2.53.0

