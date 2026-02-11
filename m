Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07877326D55
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827984; cv=none; b=m2m87+H+JrhiqLPuxF+8mYWvToARBMbf9Id3lGKlqAlzORtPAEGE8ppk5yVw6CPDGMeyLdmnSRNkGwi+k9eAA/tN0RqY91XxS/j2XEO3WG7AnGuevRpNC3lzbWvSEOTa/OJSI5TXwpJ8Q84w3ghKtsIxFsmgfJo6hpYZhspIgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827984; c=relaxed/simple;
	bh=c99n5FB4EvpuLnkmC4JCgHD/YUusRp99beaw2B+tuE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubQGoGeTzmtDk3HJxpzfG44EO+wyPkWAUqvqo2n2yqYr0g/mFJl5oS7VLc/RUu7DOyJIxKiKrftJEavlLNnSUVcrGUeHYgX7psQJU+wawViCzgFe/2Wt/V+VqZ8SCex1GcLdq1+DpLGvxV0zMBnDUvU7HEPAItf5B2bavZnH6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6BBKtST; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6BBKtST"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so19258585e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770827981; x=1771432781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scgmOVDlQn/bcdVPxSM8uVpzIpyvOAbntoDNcnJUfwE=;
        b=U6BBKtSTZLPN3nX5a1BsuMzxCDUaDiAg8dkp49Zk+Bwk0bOM9tTWgZGCTC69VgD1iU
         RJ2rY9QVo2UD8BeZD/o7+4Lg/Wc5rWyKMyDqFmd8Rwge45KWqSdH9v0EvN7jMya4WTnL
         XjCakQu36oLge+Bj3QzmNqPqN7rD7edvsy6PH7XXAYZu+jwHj6MhSCBjZnn7+lsM9K0Y
         kHODmHgf+KnX1vwyyEvhLrTsQBoHcahMAfGErSCS4+XCXVYLHDh8CoR3W8Aysx3l0Lqt
         gjRFVVYRJDMedTNRFp9ru/Tm7CZmIhXjOQWGq5z/esfySxjJm7/IftxecClnGV5t0YUI
         /7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827981; x=1771432781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scgmOVDlQn/bcdVPxSM8uVpzIpyvOAbntoDNcnJUfwE=;
        b=EZMRseJZobbPpDAA22bHF+CJ8l5i4Bz4b6Fuzqhl/j6W/nBwy6QzSZ7mnmahipDIrs
         zAi8lwovlC6rHdgCVPh5FMTAOytFzLcz3e7coUUF5GL3jY3V/Inii3zSDz5PwOMWm3rn
         rw3pE3K7Olbkg3wa0SJWmbrDqJQDrYL4t8xkXbvYw2BtiDZjXWp8PlInZkCOx79GML5I
         NXImqheLIXtdXyzVOEWtJt+JVT2wTBH3o2Cv7mxIqVFfD/fXImd6fktZt1h8srxZ197/
         kckJiw8+Y8EFwTZNsoGDmaXOdGyMkU54IC3p/HTcb5KWHNx93Kl+6Hi6l4Br5CRizkA3
         358g==
X-Gm-Message-State: AOJu0YzTegNWLbif07wPp6IRTVsR8qr7Oa5gTsVwMrQBtTHYEKr+SpU8
	5UcZqb97qvJ1wP0t9gN2Md+znWzulrFT/c6gq0Y/bpP7h9WAN8JUpSO9LSizLg==
X-Gm-Gg: AZuq6aKgDaDM9TH2HWkg0bCC8VEeOXceyvRbkZbyPHV+UIIheAAdzBS0CMzafe2LvMp
	GE+XIwkubx3Rn7mJFbkxHhFoXRqwg1yvJ5AWuT6/jUKatTLvlBJcPlCiwOF96qSC8w02wSr8lwM
	ekoL2uCll4iRa0ck/m+cVvDePQc2uvkryH0OGUKZ5ASkmTsUPwhQdKacUh5K+mrTcOvxBxR1iHx
	ZV+3ainlfzxIKthyZD0hVZ9Nt5EkaUdHKTAQQcebq4/0/2mNuYlWc5x4mODhtab3HVsGhOuCirN
	LeRTdv/Pt7NWzkp1DqR1ISbKneX6WmIOb8G0yB8Qn6cSz2Qub4yLrzWf1Tsj3tgqRFYWUe3GR6J
	3DSeFpoT+E44J3wqb9S/+fJfRlYgAHfO5urtiCSDunzBeuXJZ8sO0Pms8qXL8E9/qpsM7B+XIEm
	VxLcFrDPI=
X-Received: by 2002:a05:600c:8b56:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-483202311acmr233394975e9.22.1770827981214;
        Wed, 11 Feb 2026 08:39:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm147944235e9.3.2026.02.11.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:39:40 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 0/2] bpf: Fix and simplify bpf_task_work_ctx lifetime management
Date: Wed, 11 Feb 2026 16:39:25 +0000
Message-ID: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

bpf_task_work_ctx can be accessed concurrently by both sleepable BPF
programs (which hold rcu_tasks_trace lock) and non-sleepable BPF
programs (which hold RCU lock). The current code frees bpf_task_work_ctx
immediately upon the last refcount_dec, without waiting for either RCU
grace period. This may lead to use after free, as there is a short race
window in bpf_task_work_acquire_ctx() between calls to
bpf_task_work_fetch_ctx() and bpf_task_work_ctx_tryget().

Patch 1 fixes the freeing path by deferring the release through
call_rcu_tasks_trace followed by call_rcu, ensuring both grace periods
have elapsed before the memory is released (similar to bpf_async_cb).
When called from IRQ-disabled context (e.g. NMI from tracing BPF
programs), irq_work is used to defer call_rcu_tasks_trace to a safe
context, since call_rcu_tasks_trace cannot be called with IRQs
disabled.

Patch 2 replaces bpf_mem_alloc/bpf_mem_free with the new
kmalloc_nolock/kfree_nolock API for bpf_task_work_ctx allocation. Now
that kmalloc can be used from NMI context, it is a simpler and more
standard mechanism.

Mykyta Yatsenko (2):
  bpf: Fix use-after-free in bpf_task_work_ctx freeing
  bpf: Use kmalloc_nolock for bpf_task_work_ctx allocation

 kernel/bpf/helpers.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.47.3

