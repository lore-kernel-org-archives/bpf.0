Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890C3264D1
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480076; cv=none; b=ozrD937+pIZ+SKxVqigMot2rNcqvbrsIYhybfGLwhE55KbtoHbURQiayVC+mAYz31M3zIXx1BU2QlyJ7qY/IvB8P5eMj4jcG8S39HD2Cn6giA3i5s75AFTCjX8d5iJJUXPBrFJXSkpSjA0w3BJbvPhzKRv2vUgCTKTpIbdB91XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480076; c=relaxed/simple;
	bh=Lx6YXtUBcxGafUbQwHBxLUwSnMYXRJ9yj3fJU2MQvtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfVjbpRZQz7tZedHDnyqynyodq2pQ6oJCDx4vuRzX8eVFm3taF/CIIy7KRzjGAX/wjAm8WjvdxrXaCszpQpRTAkp6By214NweAR9Yvl9YUiemMZLN/kI0z3Xpm/z7CwUFdZJTQWL4UDLSk74MTTCOabG3pKc85NXvyb0dThi/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXMJjuJc; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXMJjuJc"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so1032195e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 20:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480073; x=1784084873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pD3HPMR7BE9SEVVFayC9pWdneWrfNTpXgXpmU27g5eY=;
        b=QXMJjuJc0i4KrwZfxJ/bBZXPIsdh972WZhFDShTrxm+YmC5SyDOB++aQzQCZLeiKiA
         zR7ghOcjWKe/IV6d08zfD65lSeyf5pi8AA/rHwHEW2EMtZO4inKU6a1VLyAbRDajwslM
         ikSkCLcmGngM1YRBMrG2AfzNPEps9QOXQePxPUjFRPzG9gZeTKVMddkzq9Bz2XuE4hX7
         TWd1t/edd4wokoZwvWn/eblAH4pjf3KKthxN7Vc9GmYksrCNK0edW9aO5vJWOpTnQIzq
         tL7ljMRE/l6b+Otzupa6T/Q4q3wi+vwLuZpdkS35Aq1623IjcjS5r2StYxhJVxbBYdxA
         L6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480073; x=1784084873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pD3HPMR7BE9SEVVFayC9pWdneWrfNTpXgXpmU27g5eY=;
        b=niO7U4PL386NVmIcLbJwBfy5w37OKukwxap9k4Mbdyu7hLieBIyOczOKsGdmuHwh9b
         CpILaEtzZgQbdMRQAuVAqwd12w8MRQCC8mqeqKa3pcFGOXfFlwbvFEVwnD7Gcgi2rB3E
         kjmjdUcDMrLrm5+j4g5nKqE/NYDwfcR/5yc+HeFomRKRN+q2M7OM/Qq9HwPRodJqL4R+
         uNSF/h+b9DoImYlZ3nUlGVAhyeh4L/jE9vZEDOmYPcKuSLIAx+RTo6WCMDl9yXNRakSH
         MHpuGYdqqfvPdBXEoeMWF967D9UE3K0CpOoMBIJMv5rl5DD2RbS7cMl9p4JlI2EAUklU
         Wkfw==
X-Gm-Message-State: AOJu0YyEYnVDwe6E01bB7D0w8oTby8Yn41yfuaORNU4zEsx25GfaG3C+
	hHzdckN526VDXkX4MBUQcEtHakACfo8HajrJI2fFTiLJLMW6yuezBWVz1iIKcQt2
X-Gm-Gg: AfdE7cnHdbKOUiROwDGPEb/3AAQEir57/SPHGbMsfHVj3b9VwvRmi2IbmAUgOr9MCWd
	S0gdPtjR+BNY3/VwGuf/RO6T2JTyKUlKBhNpvxPYk9dRGBb3mZajoSMBOLfepMvki7gMXsxVco9
	wSJz1ezgH1FP/Fj6ZlzTG0LN64q2BgAvdkV+0kHFvcAvIkmpENz4b4gTKuF9fgXXD5w+KRR63ba
	f46G7Auap90XirpP38POkhtgVeszRbVkhBKDGHakp0TPCxQkkzYebjP8qEKRw+++fxr+Kl3N2tM
	syO8r7+1pqZpj/e83RGt02tRKdnFQn+uWbpAdtLfhDGRrSJBZF9DKrOTXLctNH0mez0umDc8JZS
	SVoNwH+7KIHOAPtRPyyhjP215sxEBOwN3od/GBHb0rih8Dvj2sVM5ohN7mmo/GgKjKAGmOS1rn7
	eGOg8Yrq47utjc88EYrjWUrpLWFrtROnpcRxYKFVC17Ze3eNu6i3rYc+Rt5MJzhMWHVBdZu7QSL
	F6Zv+b7OsJUaVK+g9YwJ7G28T0eLuOVRV8jzyeG0omJAFqsv1GH9aQ=
X-Received: by 2002:a05:600c:c84:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493e685fef8mr3721905e9.22.1783480073178;
        Tue, 07 Jul 2026 20:07:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af550sm100902365e9.1.2026.07.07.20.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:07:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Fix for untrusted BTF pointer writes
Date: Wed,  8 Jul 2026 05:07:49 +0200
Message-ID: <20260708030752.2503467-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=memxor@gmail.com; h=from:subject; bh=Lx6YXtUBcxGafUbQwHBxLUwSnMYXRJ9yj3fJU2MQvtM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct3310O7r4DNlYn13vcn3a2ZLlRcXb19+lMLQfOPpV/Y pF67NDZjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwkMIGR4aBvkeH2tjmVmheb Nuxuu//+wDRRqVvL995f7THn+AG57HcM//1PO8YcqONLcJxfOXm9jazTz/NvZGfkW8lsSv+0Rfu BGzMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When using custom btf_struct_access() callbacks, we miss rejecting
unstrusted BTF pointer writes. Fix and add a selftest for coverage.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260707190214.1997705-1-memxor@gmail.com

 * Add missing fixes tag.
 * Add Amery's acks.

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Add untrusted BTF write regression

Nicholas Dudar (1):
  bpf: Reject writes through untrusted BTF pointers

 kernel/bpf/verifier.c                         |  8 ++++--
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
 .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 +++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c


base-commit: e909296d8750c9939ce311925ca1f59acb8944c1
-- 
2.53.0

