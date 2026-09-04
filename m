Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1C47CA8C
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519471; cv=none; b=MHbo+eiAbLoCBxSMV12hcI74X6Uc2dhiOD/yVgC2v6s3O+kUjUDrbW6NxnIiaWjdoOxaCKDaruVM3qbpaTDk3xCksuDTAhs6DtnNzjuQ8REj3vvfznpOXKP1kRuqwusH3/lfP/N42SACV/jpAxbfkbb3kHa5nJSNCWOsXAcHXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519471; c=relaxed/simple;
	bh=I/ptyJ/YxB171w9gZqDl4SamLak1DZrkayz6Na0f37s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7fxYIzwRhmHdVo5uoSO8QvCEmERcH/SWS/p5RYj9r9oP6ytB1SSb4H/5Lv7inZFmuXhnuu9xnNhORxtmyIEIX3NMOScuQRDm5nfj97I++GCUY1uuJfQmDaMyq1XP1hDfM+ZZPAf2VJTVW1iogvB/DlG2ZpyLCpn3ag3QpHoN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es23tAe1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es23tAe1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db18e5cb56so5050945ad.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519469; x=1789124269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSICyMswvhjSa9kIiRAEFAE0EJcTXK8dXdxSnZUf4pA=;
        b=Es23tAe1v6uiPuZ1W2/tcdkIlsV+jHo1u531niOlAqNLXpqaUtfTK/cB6NRa+Cn6rU
         h/QEy+AOT6vykaYdW4FZz7+e+2XVgbcQ1Y7Bq7EFCrP5aixCmVILEd691uPy2lHalEC1
         0VtL9T5eAd545Y5BGEMIe8pfZSl/JtlOA3JhlfU25mm2vQj/tl1HLoTyoj5SmYWpQTha
         uZK1WkIjz9OIIyyuVZ/ouGzFP31iJ7zRG7NMCos4Uriv7u3zm92bn2rIA1nAhNmEqXyM
         sDTOFqnSAjtdRK+P6osu4s5voriAkGnIdyPFiQWrpOBkiRl96+5JFdKcHtejt4xNoi3O
         jj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519469; x=1789124269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSICyMswvhjSa9kIiRAEFAE0EJcTXK8dXdxSnZUf4pA=;
        b=BwxFd2vOOfUszuJ9Hu56qLM62QQ6rGQ4HFxT/OPeoGs9OEapbmbm/x0pjXjWbl8Ucf
         z1/JqobmU8V3gihwvrjDx58966XyYqVtPIC5l7JfBx9k9PJTCxDx+HZr1PIT5cnDeesI
         embigiHKgTCss9xVnu7zq5MzCc69Ftn0JrVxCFdvdj6fVIOWPZ3V67QZ2iVaTYRUX6Gc
         hGIDY5WjrTpeV9T3qdVMZO0ny8g4vT9JzX/+JBjWA44SMmb5URkJNh5IN0dDJnel/Dz2
         BCiGdEg4edWOvqRwFRXrbotcHt6VbFaZOd75G/Nx/psaNAFyh0XZHVvNap/hKiv66a8b
         thPA==
X-Forwarded-Encrypted: i=1; AKwUvBwr4r/3zmHgP+YankdONn+eXIKN3Lxo5WhWsmWzV5eZL0817xU3x+6l/3KUjFcBu3721TQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k90OF+FmRxky+MKQVfu73PjeQTSAyQyTWvkwb0h+gQO6YD9mrR
	tdjahTCWQRcHKPR62rvFiNDVvO8ybqEsfP8PnhbH4RSbmSP2w3GzEYnl
X-Gm-Gg: AYBFou2dljyP5cKjum4pXiu01aXJ9EkiVXF0fpY3ihSp2O0elyxxOuf6kOF/j6Le8/l
	QAxjsUvqFY6jTpqJBGW8UfBqcTBdvEjRK5rgpdJnolJgF6sEWknugnWhk2JpNWCkUD1wTMfIkRl
	mSEAHMCIcrFiSLsnPxuq4aVJNkZaWA79f5pcAtZdbZNxaqUELN3vJfxTcUkXJ5OstFhiNIkBSlp
	qcr4TuP29utJLcV6lQ0pnRRFBrsByhQPr9vA3vrgtoeR1fKfS+Uz1NqB2TKKDWlMTh1Z9p0Rhb7
	3oqiOTPKXhwWNIdEJgAlvjAVjf6ErMHY8EAqeFOA/NyINrtYHRknEKkeNOtj0Tm1CKhO4NwccDp
	HVTRYWOAHMLKPSk4a1HK1nHN1B2rpEH+1tWA2LfHuO3PiXz+RRE/E1zm85uHNJprZLji3xFC2zs
	GS9Z6mzQYtyduPdIYmhSwM3pDBgzJNO3Bk+XFWK0+y1Xv4+nZsbtS33VtTnrhHUbDwhv7D1Y6Mo
	pbsQP2B3JO3CkWcQlPENlR/yWA=
X-Received: by 2002:a17:90a:d646:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39b26214798mr8379476a91.20.1788519467893;
        Fri, 04 Sep 2026 03:57:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:57:47 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/7] selftests: fix typos and repeated words in comments
Date: Fri,  4 Sep 2026 16:27:30 +0530
Message-ID: <20260904105743.39799-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 7 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (7):
  ARM: net: fix typo "arithmatic" in comment
  bpf: fix typos in comments
  powerpc: net: fix typo "upto" in comments
  selftests: bpf: fix typos in comments
  sparc: net: fix typo "evalute" in comment
  tools/lib: fix typos in comments
  selftests: bpf: fix repeated words in comments

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 kernel/bpf/stream.c                                          | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.48.1

