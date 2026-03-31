Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841F1917F0
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918841; cv=none; b=RZJDCUVd0XQKH9rjbNVGtuUm0pfG3Ww8J4EivRbtD30wn8IYgZcYbQTKI/yW9h5Kx2WCnwl7OkDrCJf7iKCeqMF5vu3yeoPFz7gywIRI+AxuhEEw6uzVcpjGz49PEFZ9XMRiNM8N0/omkOMXKQ+yqCO/uUjGv//OxYAOILu42C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918841; c=relaxed/simple;
	bh=SawlFV/36D1JqQ/y0RUlch+39uFiQY0ebUeyp5bgoX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sBjphHqVgyUHc4Y4js/Dwcsigd8ydSywsGnY/wyKU4yKpxAAybPL9b9B5evxQ7ghWA8sHVmzHnK09BdaAaw9BjCz3ZXs9RVOMTuQqZhAfm9FCZCy9wD9qcim4PmmtKHjnYFK9xPumEU4EMb2Oui2ifQ1sxolrHRyKenwiWHmuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBcT8wcg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBcT8wcg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab46931cf1so44335885ad.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918839; x=1775523639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGiNmeiXRNBFwa+/3IrMEZ7pBA4tm8B5bHx0Wb0ZeIg=;
        b=oBcT8wcgCXebtRPksmdUwaQ52KFmObMJMQJsjljzhZYWCeAK/69uCfxLayhQ8XEM7r
         Ya3ZpgiYp9mv14/FZ51YKMbUZ7uJzMNHGZkHlySoJsflUx8SelF/Z9liId8ulpP0UQbt
         p0NKaSwfPAd8K9cngZqpnWoTQXJ5DapL1QTxEw9W+0yW5o1C3Ix7bAUNXCPId/XWniNQ
         nt74xnM47/FXUaBMo/RvcpRA28Ik3AqyqtDsJFNEprWL7Qz0hC3Tz4nVr36zoCh9hy54
         gQXnhaGVoy4E/1z+8gI5j2aUcvHYcykqSGdplqmBA8J2qZB8S+HIAqrYLbO8JdKvZveF
         Tw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918839; x=1775523639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGiNmeiXRNBFwa+/3IrMEZ7pBA4tm8B5bHx0Wb0ZeIg=;
        b=pSZZW1j8hyu9jfXDGY/GGSurP0QMEpYPXc2DmLOjVXRZ0pZGdaihLkat58a3Ildjic
         nUn6owGrSmURmcA20Nw2hSEdv0OurY3y9IUIwA60a+2CN0efNW+0TStvlzMQOh3dbBm3
         ChoLOangsOGHFYe6sLtzF+1b3GVwq11RyaZyTW35F7my6VJ4No7Al3LywZNlHVYBAUtf
         AmN1d6uXuQImbFHKbJ6+ffsdtNNs41+yQpMMz39tpJW0iDAQCHZHP73VVMVXqMxNSmZI
         IzCcTvLfDQCFPlrSsPq5MY/rnO9Fh6+iu1QxgB/Bt8b8EI7w+O7peue15Ql8YdBe4Sp4
         a/1g==
X-Gm-Message-State: AOJu0YySY9MNbnm+xApwiuLMgvreR1JaLFaXyn5VmudMKbQS4qReIf4d
	XXIvEayFxZ4qYIrGiOQlQZbPTOswPhbQWyMGAT5tyrRaYDK2AAj8dZLze2piiQ==
X-Gm-Gg: ATEYQzxUbMpt1kEjg4W+iVHJNyitmgjAaqA2+/oJ9gtYAy595w76+sRFZ7W8mu/y285
	LgkQUOpWWsZ2yic8EY6W163XpK/xXYFaiwawh2G8flfadS8RVAabqRobjQliEx1+CIs5/PiSHPO
	MkhCPDi64cuZeCqCgv4mkF7DJccnDhIcYZR3V776iNIkZeLB+19ITG87XAxzI95P8bbzdaRdJcs
	jYQ5hRl15sqkBWBfrQRk1IPW8HNJXFaol9Gw3wtBC8I80+NhIAXtYY+QNO6eJ0qFVXECyDX7sIE
	ph9DOihyoVlYKnzaOOlB/686bi6CXoblhIFPsweGrt27DLGa+jbJup/rSOU1+GKUtJla3WI/axm
	EGq3zOvc0qE2gfbRHKSAZqq/kexbZMibuaO9fj3xstpNc+XYjXCfiledvC7OBzRDHCgomjwYw/L
	byGyjOMb+0UAx7h0aWZfRuB6T2z3Vx7jToxg7FvLNZ8dsg1DGx
X-Received: by 2002:a17:903:1a2e:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b25ee90436mr12940455ad.2.1774918839039;
        Mon, 30 Mar 2026 18:00:39 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm125226405ad.67.2026.03.30.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:00:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: impose global ordering for test decl_tags
Date: Mon, 30 Mar 2026 17:59:23 -0700
Message-ID: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260326-selftests-global-tags-ordering-8f324323d9c8
Content-Transfer-Encoding: 8bit

Impose global ordering for all decl tags used by test_loader.c based
tests: __success, __failure, __msg, etc. The tags are now sorted by
testing framework to be processed in the same order they appear in the
C source code of the test.

The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
defines the order in which function attributes are consumed.
While Clang tends to preserve tags definition order in the output BTF,
GCC does not. This inconsistency causes BPF tests with multiple __msg
entries to fail when compiled with GCC.

This is based on a patch [1] from Cupertino Miranda (see patch #3) and
includes some additional cleanups for test_loader.c decl tags
declaration and processing (see patches #1, #2, #4).

[1] https://lore.kernel.org/bpf/20260305130035.192080-1-cupertino.miranda@oracle.com/

Changelog:
v1 -> v2:
- updated remaining str_has_pfx() usages (Puranjay)
- removed realloc_or_free() (Andrii)
- fixed qsort(NULL, ...) usage (Puranjay)
- skip_decl_tag_pfx() returns NULL if tag does not start from
  "comment:" (Puranjay)

v1: https://lore.kernel.org/bpf/20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com/
---
Eduard Zingerman (4):
      selftests/bpf: fix __jited_unpriv tag name
      selftests/bpf: make str_has_pfx return pointer past the prefix
      selftests/bpf: impose global ordering for test decl_tags
      selftests/bpf: inline TEST_TAG constants in test_loader.c

 tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++----
 tools/testing/selftests/bpf/test_loader.c    | 202 +++++++++++++--------------
 2 files changed, 125 insertions(+), 137 deletions(-)
---
base-commit: b6b5e0ebd429d66ce37ae5af649a74ea1f041d92
change-id: 20260326-selftests-global-tags-ordering-8f324323d9c8
