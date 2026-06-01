Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848223E315E
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337262; cv=none; b=cyHt9tSA3lurv4ETcap4yRycVwR5ZcFXgZLFhSkwVySbjfM5GInGn535VFrxYyClRzFeKv1hj3Ew3O8qdbkDmR7OJQD02OLI8DgnJwJ4OYKUT54QoqMK3U7QIyvXAxTWXjxyWZ0Jz2AD8poIZIWX+c+3ebyJ4mcS8DDwYr9JAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337262; c=relaxed/simple;
	bh=H7aNs2wN7213ow2RavgerurEBbg+1krK7dr1GtyEYHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3f0j7JVNQ1eLX5w16/+RGPPlyVqvyGkX0CjlRwseWyIE9IocWCypznMzqnu011BkPWmwHz9QtJsopycDVo9/lHM0WoVnUmPB6NsNjYTfoSgk7dICSM8Ykd1tOIElItOQNPIyjEpthunaIIjwVS/lNCajVoq0v22CdQq1h23wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW5F+J+T; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW5F+J+T"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422c327755so938422b3a.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337261; x=1780942061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gQie9R+iM/u9UZvBcBXG8EPU7/7n/2I9ejVDjywMwo=;
        b=jW5F+J+TyrN96HRTzBWrQQyi2zSJboGAl+6aCz+tF8pVGD8gE7C/dqRULuH5bLGu36
         JK+rUN1mndevMSRCPbkSDswq33QPwtWCKBbjSFEZ06U/AyqI2f7k8VpxBMLXCUJPDpSl
         zpBrehEtB03atguovHG2tI6Y/NErn1L7ZZTHngTPLAdVg0jw406PQXGAITUv9crLrsoy
         tGGflFosTTYQex/+4ahvkDqQ5jdlSgnbbMSzz/IweGqZLu+v73qFo3U+Kv6DEGAl634U
         XzFbnMGJHcsMQ1EA6GAG9G8Le+edD+7igJ/P/f4uBIICw+uZjln/lDylVwv7abS+PWCU
         rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337261; x=1780942061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gQie9R+iM/u9UZvBcBXG8EPU7/7n/2I9ejVDjywMwo=;
        b=KIiChPtED+LhtBXbbO+j/E9KrNRS7hwB59QbCRDFzfzgpm6vVeITQtIGPHFX0ZPGKH
         IZExDA3ADZ6NVOhCE+q9Mm6YY7HRr3RTKN1uEZwbjIJ9ai9JOUguDytTDbEQ9AFRSSLN
         fVjLYypSZDvAyeyZR2+ntm6ghd/yzLwCOWgY6eMbnyWSspIE6NKy7ghrRRERXtCyB8st
         HT9lyIqmN8IfNf6ZOlAEV9fN2cUZeVEG/LcqxbMwz+KZDh2OS3tFOJVTmQ2/LEYK+K7E
         zepWdJDCsleBnJu8Y7zm0MfhPOmo5LBfD1IEQck9UFvNctehEy93qv66Uzd/O+YE9Pke
         mOtQ==
X-Gm-Message-State: AOJu0YxIc01G39jRfkhp/XGnBxiXb8rpGwDYLMb2pwVXrQ3Xwuik3++t
	oLRJycuT5U0gwYeo4zrpBfqd1DithwZNDZHILyZ5pD6haL0UjSccZq9k/0icMPDqrKY=
X-Gm-Gg: Acq92OFYlmDxto8JhwbuFZZiw4zeKC898k1TSF9NIH4e9MFjSBHWJJXkBXNdHoGhRKr
	jrXLV4zwL2nFkOj5Lcvef+8RwdziFmlrGPgqfITWrt4wdUAwS8bxl5UOuQ6O3/GEvcZIQmagH7y
	TzCvN9PPJw+ivHupvycZoWQVDd8eQkJoWObqwkbUpLXsmtpPfdfH40RiQ9YvpIhoykmShXkVRqP
	LxeUiQdC1+TOyIJlOOsq3QM6sZ0f3Pcog81qLeVdF/fiIpxuo0fgAGvTrOZz1NurNeRyrYO8tRR
	mw+91RbK5bKsbLobShfUEG9kjdJnlHK/s3mXr64HviRrPrrcPDLVOLsijpBQms0zgVg1x+7P5ao
	E8LZmEUN1cyQ0rQ80RB+SyBANrcdrqWbU/U0gSQzCCs0OiESgZXb32rsUQHnQjenN0oqkhE8QqI
	yMxxvCaafcczZ+sEZPkGUY/u2VipdFQOHyvj3bLL3ByD8=
X-Received: by 2002:a05:6a00:7599:b0:842:3373:f66e with SMTP id d2e1a72fcca58-84233741059mr7935773b3a.28.1780337260635;
        Mon, 01 Jun 2026 11:07:40 -0700 (PDT)
Received: from localhost.localdomain ([212.107.31.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm7389702b3a.22.2026.06.01.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:07:40 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	tamird@kernel.org
Subject: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking fixes
Date: Tue,  2 Jun 2026 02:03:58 +0800
Message-ID: <20260601180400.1381736-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi BPF maintainers,

This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
The series is intended to fix a verifier state-pruning issue where an
impossible scalar path can be kept while the real success path is pruned.

This is a verifier scalar range-tracking issue, not a helper-specific
issue.
The visible failure is that the verifier can prune the real success
continuation, which should not be skipped, and keep only an impossible one.
In the reproducer, the traced function returns 15 at runtime, but the
verifier keeps the path where r7 is treated as 0, hard-wires the opposite
branch, and the program reports the error branch.

The minimized reproducer uses fexit/bpf_get_func_ret only because it
provides a compact way to create the interesting register flow: one scalar
in r0 for the helper status, and another scalar loaded from the stack for
the traced function return value. The issue is not specific to
bpf_get_func_ret itself.
Because bpf_get_func_ret() was added in v5.17, this particular reproducer
directly applies to 6.1.y. I have not built a 5.15.y-compatible reproducer.

The relevant verifier-log bytecode from the reproducer is below. The later
instructions only store r7 into a map so user space can observe which
branch the verifier kept.

  15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
  16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
  17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
  18: (bf) r7 = r0                      ; R0=scalar(id=1) R7=scalar(id=1)
  19: (55) if r0 != 0x0 goto pc+6       ; R0=0
  20: (67) r7 <<= 32                    ; R7_w=0
  21: (77) r7 >>= 32                    ; R7_w=0
  22: (b7) r1 = 1                       ; R1_w=1
  23: (55) if r7 != 0xf goto pc+1

The failure mechanism is:

  1. The program checks "if r0 == 0". The jump target is the success path,
     and the fallthrough path is the failure path and should imply r0 != 0.

  2. On v6.1.91, the verifier does not record that r0 != 0 fact for the
     fallthrough path. The following "r7 = r0" then gives r0 and r7 the
     same scalar id while both are still treated as possibly zero.

  3. At the later "if r0 != 0" check, the verifier still thinks r0 may be
     zero, so it explores the fallthrough path of that JNE. That path means
     r0 == 0, and because r7 shares the same scalar id, r7 is narrowed to
     zero as well. This is an impossible path: it came from the earlier
     failure path that should have implied r0 != 0.

  4. That impossible continuation reaches the return-value comparison with
     r7 == 0 and can make the verifier keep only the wrong branch. When the
     real success path is analyzed later, state pruning considers it safe
     against the earlier cached verifier state, so the real continuation is
     not explored.

The relevant pruning point is that regsafe()/states_equal() accepted the
real success-path state against an earlier cached state where r0 was an
imprecise scalar and r7 constraints were loose enough to cover the current
r7.

After confirming the mechanism, I ran git bisect with this minimized C
reproducer as the test case. The bisect started from the affected 6.7.y
behavior and the fixed v6.8 behavior, and narrowed the fix to the
v6.7..v6.8 window:

  https://gist.github.com/swananan/165cca6008f6c81870a28aa7a445d5ea

The bisect identified the upstream fix as:

  d028f87517d6775dccff4ddbca2740826f9e53f1
  bpf: make the verifier tracks the "not equal" for regs

For 6.1.y, applying d028f87517d6 alone is not sufficient. The older
verifier code also needs the range-preservation semantics from:

  9e314f5d8682e1fe6ac214fb34580a238b6fd3c4
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic

Without that semantic prerequisite, the old range-combining logic can still
discard the refined bounds after the verifier learns them.

The 6.1.y adaptation is split as follows:

  - patch 1 carries the 6.1.y-relevant part of 9e314f5d8682 by removing the
    knowledge-losing __reg_combine_{32,64}_into_{64,32} paths and using
    reg_bounds_sync() after conditional refinement;
  - patch 2 carries d028f87517d6 in the older reg_set_min_max() layout. In
    newer kernels, reg_set_min_max() refines the fallthrough branch through
    rev_opcode(opcode), so the fallthrough branch of BPF_JEQ is handled by
    the BPF_JNE refinement. In 6.1.y that split does not exist, so the same
    not-equal fact is expressed directly on BPF_JEQ's false_reg and
    BPF_JNE's true_reg.

Observed results with that reproducer:

  v6.1.91:               REPRO: BAD  (ran=1 error=1)
  v6.7.12:               REPRO: BAD  (ran=1 error=1)
  v6.8:                  REPRO: GOOD (ran=1 error=0)
  v6.1.91 + this series: REPRO: GOOD (ran=1 error=0)

Because this touches shared verifier scalar range logic, I am sending it as
RFC and would appreciate BPF maintainer guidance on whether this 6.1.y
semantic backport should be carried and whether the split in this series is
reasonable. The same issue should also be relevant to 6.6.y, which still
has the older verifier logic and predates the v6.8 fix, but this RFC only
includes the 6.1.y backport.

Zhenzhong Wu (2):
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  bpf: make the verifier tracks the "not equal" for regs

 kernel/bpf/verifier.c | 92 +++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 52 deletions(-)

base-commit: 228da13e907e2b46b7222cfc35290fbfad920bef
-- 
2.43.0
