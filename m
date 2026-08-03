Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77982AD3C
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726901; cv=none; b=kqTA1bMsqk3dgN6W8dyTz3WmEGn/hkQCu9BrfQyh7niBWTOn2JApSOaGG+69+prU+FAFOt1mo0smWltTLTH8jOATL1JnkHy+Sc7lscFfxFpN1Wc+V/JN2NxizBbAIC3ZIab++bP3gVRWNWmPuT5742vsGClSrcb0k7dOSaMzNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726901; c=relaxed/simple;
	bh=vpJIGXu0nzrV/bpHaq9mbTPX9L+mvyrvG2X3T8VGG78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhfZ+0m6Ie48YGotPhZ14GrE/GGNM9XS3Rd2hbnOjEAoP6dLGMMYp/GZae2yRaLBkOJQs11+Sn0PEPxJpkKBFWYATJHtPvYbSk3Sb0gUXlw2SndoCH5Nzup/5E63lWxSE9ZA0YlQBbBPdhA6OF/ug5PqP7WUcOpUcEBPIg37L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0QFpbND; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0QFpbND"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so1460481f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785726898; x=1786331698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hna1dmBx6znS9FIWRPUvRRLQzTARisbvU5IyeP1LGLo=;
        b=i0QFpbNDLkffiJbCGZlDCpz8jFee+Tb5ma3eW0bXkNdxNiEKx55tuXPgkMpMRU3z36
         uqrYql+rg8Y71v2GaabJZ/Xm4mYP4tfa9h0Cfx174MfzyrW/3GjlgstfDPIfFfiV9tvt
         ip4SpGC1Gqdx/Hol/23ZXziPNznO9zsLh7kn558rujCGrUQOxmjJn+IePoR4bPcDa4e7
         ppCLXHLvr6fRp8vkjhHBhBPMUdRTetfOUOW8aHAoONI+6153BgvI7YIHt2hBJkQzdkou
         HckmEuUCYPItXFIl6jZmY5m0EWI/5o/ZOhJ3/23/uQTLLs+pBRdPraucGc3tTYhqRJ64
         Xw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726898; x=1786331698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hna1dmBx6znS9FIWRPUvRRLQzTARisbvU5IyeP1LGLo=;
        b=etmV9i6jPQ399TF1nYN33T3/4U9mQMAM59p/K9Hklgm+z3RBDJDmC1uPHHgOIC+2Wx
         AFSb9HWQMDyf8vaNVfhcB30rqEstmeympH4YOSuY19BWSlskbG2iIkTlOC8upHZHtbIp
         dDKGj/om+/Fv4pga8Q3VefB/iH+vQ3ty/AgIvkGUM7Tdar1KelEdRE/5dM/oIbRz0amv
         UInUbBWNr4C6yD8UyiYYKCShtjMqysk3EhKgRvSlxh9pVB3D7bJruOAUeqq35NafueYi
         aM3Vddo2wdQJuTHqyM9wZATmlySeHdi+JWTwIpRljSaNjVSPSrUQ27qJvAtE1G8MyroS
         i5aw==
X-Gm-Message-State: AOJu0Yzgsj15qnzYPFxsxL2XghtlRoy2UVrgTpZIzwMOgZrNEJqgzdIU
	R3KTLFNOIfPCtwBVOw86AfEYDdNzi/HzbXkaSPm2q4JQArDzpIvP/NHaWqICBfeU
X-Gm-Gg: AR+sD12vkvodW74F3CxXARfmQcmNEhxSnHXsVt0nVVTg/v1PsLrZsGDxUxkOcnshAbM
	dQ7GBc9dIoL7sQwBG9JIibbj0CfO3rFCDjyYGKv6zBu1NQKZNtK9RpipaLfcGJkeCLTHL35MgbP
	5rZPUwOkbyE2SCDHUToAz0LNaKI+qV3meFRKMwNwfo6AZgXkyGJseBqealG+lGaQEROvm99TpQP
	ZXnKgkGEXv/gJ1ROjWMeEwLVeRVbQgxB5JFjucWhgPaeYd2bh5IwLbej1Dpou3wjqbgod+2hSTY
	ABiyO1JzENdQraTDq7yaq7GNOaMsTxQ/FvURUoofxu+5e44PBZ4cg8bZeqrpJ+GX1JCNZlBBs1x
	tETGESuxVqu1LyDyArdcJXRsYUZdS3aXO0E4t1GhXIq6yWWfv5ap3QdTERQIH1bYEuwmrpvQ44W
	A6labEOBXvPid6DFq0os9wf/oaNEIPan5fcAbnQVviQkiUuYn5wpb316+TGrt3d6E3oBfccsRMh
	c3s4jH274v0mwNTkMlt5CNQ6d6fz5r9RDfvNkR2M1qdFAUeZp+aS4lSeceN8ZbYRBdR1nDsL8xd
	c1BPHBH6VBgpX139ukJo/cyPUpc=
X-Received: by 2002:a05:600c:917:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-4980c65c487mr122254995e9.14.1785726898098;
        Sun, 02 Aug 2026 20:14:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b9441csm179644845e9.4.2026.08.02.20.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:14:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/3] Improve stack depth verification stats output
Date: Mon,  3 Aug 2026 05:14:52 +0200
Message-ID: <20260803031457.3115812-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=memxor@gmail.com; h=from:subject; bh=vpJIGXu0nzrV/bpHaq9mbTPX9L+mvyrvG2X3T8VGG78=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauAfbqfeOqHZYER5uIyUdGWb+SSTxb4WikUrWEOL1m04 G0Gy92OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATMR7LsM/fYGcJX/mqbNJ27dt KSqx2PV2tvNVE9HJiTNuWT18cUEhmZHhUExaw807HzMEN3F+YajSsWMUV9pzZDWDmpb3/vkGsS8 ZAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260802225209.2511758-1-memxor@gmail.com

 * Reuse subprog_name() to fetch subprogram names. (BPF CI Bot)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com

 * Use multi-line format. (Eduard)
 * Adjust veristat to work with old and new format.
 * Adjust selftest log_level without new option. (Eduard)

Kumar Kartikeya Dwivedi (3):
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names

 kernel/bpf/verifier.c                         | 13 +++++++----
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  6 ++++-
 tools/testing/selftests/bpf/veristat.c        | 16 +++++++++----
 8 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 8f876c773b79ed66dadc9507f50dbff39c6a9ec7
-- 
2.53.0

