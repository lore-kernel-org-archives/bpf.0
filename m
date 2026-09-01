Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB338F92F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262842; cv=none; b=JyijjYDo1HB/NcHOgVejXOk6VykIiXw5fNDdKd1qaEjjU7oXfk+P5upFl8K0oK4Q4UoAYv1QldPitVq6L06rsCicGKZb4hE/3m11NQrrmbkHwXc9W/MmGUS/zgOm/p1jVjjtlC9hLmtBTNwdt+6asTf3AZuTuUyLkF8qWdDj6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262842; c=relaxed/simple;
	bh=P3hdtakuwRs8sGgX8SbTRg535OO9QDcChPnINsMgxSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxfF0hEzVWxcta8KRuXYr6+DRql8HMSSRV6PWVffLKSBa1p8/e2EulROcdZB+XtGX77pLWP0qjqH2n1KMDhbv/n+/4KPnL/Hqy1WZkfzr8L05q3/DU/bnm55VaHTHLhDHWMp3VjTiCXWLJbuMBurOmlu7hS6JZjVm6ksInYfK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7t5Zjwn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7t5Zjwn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso8330185ad.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262839; x=1788867639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbJYqMSdfBVb+Q8QcPC8voCv5rVOzcHLGQSLMYKXoJs=;
        b=Q7t5ZjwnMTl4U8MTQFe9FeEEbQfxsNXumEVXieQjXQVV+LMhjiPc8ZgZu4iqx1EzQ0
         QqSaEB884GtaVuF/QAwB7qA4SjV+qRR6/mhP5DAUeU+WSN08HV8tPf+CAu9K1CWGNNh6
         7qEGAxECy/VV1SFXATiCL5BB/6JR95IcOc8L3HeVzQt1DAdTcrHMP5i4mksng1rN75pw
         2/lKQAFdVH8bC9PlooAFIOVDKp9IjU+zEIkNclJJR1FCGewyI88To4fEr3nV/dyH9AvD
         KpxI0PiZECpY+3q2JLMi6mTJ4FHTHYwpb3PbcUPS9G4thtIiGpYKJt6eEN7go0yepQzL
         WuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262839; x=1788867639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbJYqMSdfBVb+Q8QcPC8voCv5rVOzcHLGQSLMYKXoJs=;
        b=HtHUPI56DZiA4uo2HZwvok75aTYq0//Q/a+ujAqbhaITpJE0DwYdXuWruYa/oPHLVm
         IihuYiUrDiKa1YT3028mryi6kJi2MuS3v3QottLf+eFFip2ySC6m6jeqiDOvCWAhx0He
         biMNuDBaPrwKWXtNmnNev+P+oApHpjUyPBdqnQNemzru+pOHmE9P/Bx/cHRl3FNhwcIz
         PrhEfqZtTUBzl428wmVcokisUpokfjrm87H/p0aY/56JNtvrYZFgyus4iYUkBBrGOLYb
         UX6v78wuuSIELjrc3TpMJwvtgFS7dMZzC78YlUrbhsB+miZP2/ehT+ThE+Cqki0yIQ5a
         zzZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro92rxQkJ/xaEcIHCM6B86aPclZ5kGNEqBSUUrt9gMozMWu6GIIP7e/hVDcVdff3RXiOfA=@vger.kernel.org
X-Gm-Message-State: AFuF++k25QIxh0jX0IezX6Rjg24UnzWPqUw7Usc0NqZ+Po4mJPePco7e
	IL3yaBHJSJjyYem0/WaTvvBzSGMnQKDtrR5/1LZDoT5QXIXiHlFRz3CU
X-Gm-Gg: AYBFou0jTptwlVlFvGWmvvTMs4BWT0NlajX63HLcji59C6glV8LAdnvp9ea1fIL5JCu
	kmpMjVrkBAscrKU7ExksxsECEr6iFm8wwoW4g0VHtP0DBWuW5RN/8owp1TD2nSBCti0X1XwYoJr
	+34wV9/FUcd23R2mPU3C9B4S/5lIAVT/F4H8mf5zRmf3RPLeCttkKTffUvK6u6iqbM7AYVN3Dit
	YrpDW1MXY8F0Yo1gXL5X/2dTWgxtkEqQ1sYHajZabzbjTWvbdTiZOcbv6dYiXhSJN1xFTL/v0l9
	K/cmu7svb74Cd7zradNhu6n+aqZHIwU1UDjxLpdnWmOl/+ks3c55QvQ71Bk69FdMRMfwyYvDAI4
	zrYMGe4XRrs/wsFljefOY6ZO4cxNo0XhVZ9c9+I49xruZZyk/vm+1M913xPmX9znqA2CBfewgE5
	ZSZPHqfbvvMZprBRZ6QXCPDRo3YN/W3jH5Pq+7ewpq1Sq/O6Cy3BMUhYnge5e3sPZ5ukD4iynjX
	V5gIwuo0GfjQJLvNCHjbfq0atChp9GdlFkDzrRf/Kbu
X-Received: by 2002:a17:903:42cc:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d74e1386bcmr327790875ad.14.1788262838570;
        Tue, 01 Sep 2026 04:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100:1e0::500e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b6c7sm49316075ad.60.2026.09.01.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:40:38 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	tasos.papagiannnis@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf-next] exec: Drop bprm loader before closing bprm->file
Date: Tue,  1 Sep 2026 04:40:11 -0700
Message-ID: <20260901114011.112375-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_bprm() currently drops what may be the final reference to
bprm->file before calling bprm_drop_loader(). Since
bprm_drop_loader() is attachable via BPF fentry and bprm->file is
exposed as a BTF_TYPE_SAFE_TRUSTED pointer, the file can be observed
after its reference has been released.

Move bprm_drop_loader() before do_close_execat(bprm->file), keeping
the file reference held while the hook runs. This preserves the
existing trusted BTF contract without changing verifier behavior.

The loader file and bprm->file have independent references, so this
reordering does not change their required teardown ordering.

Link: https://sashiko.dev/#/patchset/20260831092305.42062-1-tasos.papagiannnis@gmail.com?part=3
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a14f28b15607..263b1f67f1f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1469,9 +1469,9 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* exec swapped the mm but failed before setup_new_exec() freed it */
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
-	do_close_execat(bprm->file);
 	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
 	bprm_drop_loader(bprm);
+	do_close_execat(bprm->file);
 	do_close_execat(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)

base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.43.0

