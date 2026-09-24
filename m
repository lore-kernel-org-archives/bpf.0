Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6792413789
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236439; cv=none; b=elCICPUJQcbtdmZeRB977uNtrhKlVAks82iNKG+u8K5FODKP60U6t3S/ti9IFWQUwKv/1opKRhNyvbEepGr/3Y66rfQVw5jUHyFVByTyHFqc/06AY9ETNo9JOZSHE/dND+xoVB24D6+liR80NlR8rim1zeEkWBBmDodM6A3jiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236439; c=relaxed/simple;
	bh=StkFi5tu0TWhQw83mflsWzE6rd7j3Dr5YHUtWci6wEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4LWwsgrQ/YfBYwXZbTtI6SvZr0hJRs4BOBTivnGLWw8qAfpC2gNByffNf7/SqzD6TsjfEEPYYKXOzeH70tARQtsWVqru2y1wnKHJv1DHvHP6RVGPe9YR/JGv8o6CjTAwF5yNZOmDFEL0JzX4nkCvpWO71GAgN3yqt/DbJWuC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZhgUlMT; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZhgUlMT"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so2739735e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236434; x=1790841234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98lKZ5j8Do1HmaMCm8F3v9cW+qx+5YV3pRrKHyAEYAA=;
        b=ZZhgUlMTAySSCAeuDxN7zggKebpzUPY8rWxbYxzO+ZyAXFQYiIOnd2AZL4D6334oNo
         AmWkz+R7v3gqPkuAgVoywMLi666QKtHqZHeYtOdOjULdFtpLo79wVAJErJcYhrr+mCUw
         8VXtY5OAJ+cSxBhWUg5MK+nyr4StS/gJO78TZrpkKVycyDFGwhta186RiRqhEPdvOYYR
         QywADpWI3M3UFNDY4LRjTQtl3nmPmVdy6fbDYC7dmBWtUpNB3JLaeSBPSjG+AGYyIXQr
         Z9jgbmCxG6HG5JiJSYInznNaR9T1/QzMLj1rCJKWnNwUZ9P0lt5ORzBuMSM9HphBzXjW
         J5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236434; x=1790841234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98lKZ5j8Do1HmaMCm8F3v9cW+qx+5YV3pRrKHyAEYAA=;
        b=EDSrLlHDvUPQkse+nx0026Vzz6ASOroIZVuKxmzvy4Bqcr/kJ9N7H12tvXMZ+wg2lb
         B0+uM4odb45hX1DG/QrCrX3ihWkHGFReXuiyylJVgzy1atsSPCYXgew3cDllTCjPjNW/
         8cECuEqOZSbO89MzlFxnt1HvoAG2c1n2Yl6c/uLy3RRoindx1ZPhNQuzFyPEjgErznsE
         u55HAusEUG6IsXw7BbfJgJJknsvamPEic812WDc/vP03tE4Xyh5a+K4YXgEkUFmODpQ8
         g3dVab4ioVSZRsu11xwMKqt1IGSOgDs/qtcEsUR7UKSwrpHu31oemfzl6nhBpgEvd0Z2
         dWLA==
X-Gm-Message-State: AFuF++nLg07GycwUe5mLDlqMaBShNUN1FPXBK25PS8dOuUobQnOFdF4g
	Sr+I1ZeUcC1er+hqVL2MTNdONfekPJpJnuMwCLzXzOQyz6hFufSY/TkLlUMmOVDY
X-Gm-Gg: AYBFou0PF1/FsMzL9AXDDbY4dPaPVDRktFVGyWwSqkyEUgz/h4NTk5tNblUGUxyyLOc
	t9r8FowQ1js3eIA0eqP9tgb8sU/wjbxDvUiYJT6MvA7/MKYIbIRAzfSMQ3Q7jEy63rrPWi7T3kx
	TjgNX48TFwI7kasG/FSa9v9b/OclpQjWcMp11Pc9A5MjXMfca5URHLu91QCgr1erkTReKWkaH3B
	bAuSgEyI4AfNa5HW4yDY2pl14ipJVKMyo42a+2iEgAkl5QfX6XnmdMzc+qEg/nnEXenGTL8vfyk
	hMfn9UvdzfpPr3vJezDUY9D8aWOu5zGUJA4rdWnkwai6EFGPD59qXGed/WVAYxhaxfCZSrci09t
	DdZP0WaToNBlKzr+MmIYgwD7ELR1LBCXcp5fCP3bnX+LpQsyNBaA6DwKY9Gh8QIkHMb92sRETR8
	JMU0gm43ys3siNHmciwNWvy+DDRqMYc9p5m+tYEIw84kAENkidPYTPqPONrLhxfJqMSzfJv5SZj
	IxRyek82sH8POVxx5KGLnA2WQotLxH4c8ZMDAtqh03vpHL3Rk2Eu62ja0v/cbrANhVMT1xZ4mWj
	v63Y3ahjxrlAf7qau0KZy3k+j8w/XpKA4naxnw==
X-Received: by 2002:a05:600c:548e:b0:49f:ddc0:6e8f with SMTP id 5b1f17b1804b1-49fe66c86a2mr24006565e9.5.1790236433977;
        Thu, 24 Sep 2026 00:53:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889337sm12932680f8f.34.2026.09.24.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:53:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Fix fastcall rewrite with indirect stack accesses
Date: Thu, 24 Sep 2026 09:53:48 +0200
Message-ID: <20260924075352.2343553-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=memxor@gmail.com; h=from:subject; bh=StkFi5tu0TWhQw83mflsWzE6rd7j3Dr5YHUtWci6wEc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLtXM/FzP4Mnpb75UOULlsaLt04/sji69Xzm/6ZS6iG 3/zxZXDHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIygRGhifBRs/KPt3fvtxw ei5b3hPB0JjLK286dm0+apLC7LmqMIvhv5tVtLZ2/lQ2Lqb2aUVXHbRFPU/f3zfxq1guY0Xb3qV PmAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When a bpf_fastcall call is inlined, the verifier removes the spill/fill
pairs around it and shrinks the stack frame to exclude their slots. Two
kinds of stack access skip the check that must disable this rewrite, so
the program can then access kernel stack outside its frame: stack
buffers passed to helpers and kfuncs, which BPF CI reported after commit
5da4a9f26fca ("bpf: Preserve stack initialization for generic output
buffers"), and a callee's load from its caller's stack, which checked
the callee's frame instead of the caller's.

Patch 1 moves the check into check_stack_access_within_bounds(), which
every stack access goes through with the frame that owns the slots, and
drops the calls from the stack read and write paths. Patch 2 adds tests.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260923084201.2437625-1-memxor@gmail.com

 * Check the contract once in check_stack_access_within_bounds() and drop
   the calls in the stack read and write paths, which also fixes the frame
   check_stack_read_fixed_off() checked; fold v1 patch 2 into patch 1.
   (Alexei)
 * Scope the test comment to the output buffer tests and describe the
   remaining tests individually. (BPF CI)

Kumar Kartikeya Dwivedi (2):
  bpf: Check fastcall stack contract once for all stack accesses
  selftests/bpf: Test fastcall rewrite with indirect stack accesses

 kernel/bpf/verifier.c                         |  13 +-
 .../bpf/progs/verifier_bpf_fastcall.c         | 169 ++++++++++++++++++
 2 files changed, 178 insertions(+), 4 deletions(-)


base-commit: 24629aac43d2884109ae47a993fd51b504e2b09b
-- 
2.53.0

