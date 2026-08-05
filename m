Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB87361950
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973272; cv=none; b=ZI5A1SJxS1mZ8AmPT/E+0PeYwwThsBpamVv5KbaOU7zqmrZG0jzm7wLF+EmmEoRfTM26kWHfY457yLuKGjWzxWBrq1mduUaMxOizgIqYtg24q1L+qaCrybHjEjFNpTZ6fqVF93XGYNwY5ftH1bUYnBgw/FkfQWM7PYFVxwjFdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973272; c=relaxed/simple;
	bh=GB+qW5hu0hemj6jSDfdJ5ys79tBYXm9mdSIfmAXMaQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekq1/RHpqKn+YZZZuYbWaAzwEL4OR8k8u42m2yTegHQwVw2vsoKmLO17WlNl4QNY36C2R5VVOlJ83g42OjRMMVhYnEnJFRgUg5P0+1XZsopQNp/umOHqn8xdVLt1XWIcQMWSBlKRbOBt9Dr6y6g73MkA5/40AyeA3YZgY28Q2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk5uPlOj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk5uPlOj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e507b079dso1033096b3a.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785973270; x=1786578070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECOBkbiexvlKnu0u4FymDsA/eL+Ydow91DmCNOq8a6A=;
        b=jk5uPlOjZKREQQCAVn6y39BLpW1TQrm9bJRru3ZIGdOWa96U5IyCu1ycCLuB+Ut4Dx
         IakQk07oPfhfLKXAHenBNfymwDYMN6oGlBnwb0AEhSVZrzFGCZTITP+39/0zWZCqmUmD
         LZJzIlXxJETrNlLbGp9jhbIZEHn5JylmpbVZ9at+US8gLztVJwV0ydcRXRbrs7XScrWd
         l5C39+UKK3XKwKM3hPWJGs7dt9XUSJVji7HASHVjgc6M6kyW5tANVFOLs/uYFe/ZgjtN
         WBVMA7HP4MPCwuVSdzLG4llkk/nt0ywVPupisdhwLdKS8QryoAip1+f52VlXL8QfZESC
         f2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785973270; x=1786578070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECOBkbiexvlKnu0u4FymDsA/eL+Ydow91DmCNOq8a6A=;
        b=baY5c0RJXX10um4I+Gtqviw0F5vEehxLjsjveLje3jtoT29S6IP2s/jDOnBxJ+5zhB
         4zQ7CtAFrbX/mZtys2Lf59PlltAD7221aVgbdnVPjLj9Rmp6ErxRVI9U4mBAivVP2U98
         Eghl+061uG9aXIko9pd8IpcTbnkHM/9EI9cejMMrs5areCuSWEE08ywTtix/pRqAe3xW
         KH57E7wMSHgmKSz/T1P86iM2yZym00JPgoP9mdUEINxHC/dLUwmpjoy37qnxRiAdwLes
         vyvPvgmAXd/KNmlCFu1MIsywQkQt4UxOBt1mCCCBVv9zd9PkXupPe7pUwiJYP3Ysp6nH
         67sQ==
X-Gm-Message-State: AOJu0YytUBYGmTVDD9+RJ1l6kdLe77WXVPVGHohBV92nruEAqWkdzGio
	axKSFC43ArpjGKPlFwrultO2ITi7dDjQz2Wnq4hhrmdbH9yA3FLsO7M0Nbcflw==
X-Gm-Gg: AR+sD102VhO/6/Cqo5mwspJrryeAPyCVSV9kLw0L1RfMTwYYnbaZ+Pt47IRwLztiZG7
	LGEW3igvVzAxCSQYjH9fVZ/iCY1nyD78aRM4hGw02Jwk5+E/gbtY/NTmpr144XYU23NKZiXiRdw
	YvwMA3rtYPTh9EvelvFu6IY9Hitz2h3GmNx+i0LzSYv/aGXO6JbfaV7hF6dAt0J261pp1fRXB35
	n+dC7xILC3nx3ZfOtU9PwqS2uiiwASlsvttRxwseVZhrIAQc/oravsjS6W8PiTQkqo9xcikc3EN
	GR/fnA2sw5KpIPzIm62/zNakoj/b7QqhFWlgFqCqiPzCqvZ9U/eoy4tXG5QF36s+dFaAVP7ZdPs
	asa6KWe8e5+qxQhM/X5yl9Ozj1PjpvkgjUfvZtJDT46ZdCVOF3bDRh+89UKD+eHQ5N7Bbd6dMoe
	8G0r3eSnQGmGLbBwA1LRzGrjt0N3X64WR6x5XgD7bjbKBGTVGVPMZUYreqqMWNTvkC+pR8dlgvU
	azOyD7TqzrDfbjf
X-Received: by 2002:a05:6a00:1a90:b0:845:e7ee:eae7 with SMTP id d2e1a72fcca58-84f2e031774mr9441850b3a.5.1785973270270;
        Wed, 05 Aug 2026 16:41:10 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc5696sm139516b3a.53.2026.08.05.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 16:41:09 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	puranjay@kernel.org,
	paulmck@kernel.org,
	Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Track overlapping RCU protection
Date: Wed,  5 Aug 2026 16:39:32 -0700
Message-ID: <20260805233940.3966981-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preemption-disabled and IRQ-disabled regions provide RCU protection, but
the verifier does not account for them. Current implementation can invalidate 
a task kptr while another RCU source remains active, or keep it valid 
after the final source ends.

Track these regions and invalidate RCU-protected pointers only after the
last protection ends. Add task kptr tests for overlapping protection and
final-exit rejection.

This follows review of the applied spin-unlock fix series [1].

Tested in QEMU/KVM:
  ./test_progs -t task_kfunc
  ./test_progs -t preempt_lock
  ./test_progs -t irq

[1] https://lore.kernel.org/r/20260803112615.3362122-1-dingning04@gmail.com

Ning Ding (2):
  bpf: Account for preempt and IRQ state in RCU protection
  selftests/bpf: Test overlapping RCU protection

 kernel/bpf/verifier.c                         |  13 +-
 .../selftests/bpf/prog_tests/task_kfunc.c     |   6 +
 .../selftests/bpf/progs/task_kfunc_common.h   |   2 +
 .../selftests/bpf/progs/task_kfunc_failure.c  |  49 ++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 147 ++++++++++++++++++
 5 files changed, 214 insertions(+), 3 deletions(-)


base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e
-- 
2.43.0
