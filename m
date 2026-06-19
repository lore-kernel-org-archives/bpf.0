Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF23ED5B
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850926; cv=none; b=PA9D0SFFSfazBXSef+737Rq3llo+4DoD9+9iR7yfRL8ShpHV+nTPurzB90y1N+P3bTOHhFQsCpiYkV6xYjXGyt/8QfC7vYAfPawSJ668kYHx2FgnmydlfQJ6WPH6Ty66DP5T5KyBj00grq9DRL+67F+UJqkuX7m4d4CifI7RkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850926; c=relaxed/simple;
	bh=uqmdIK9AB0ejQ4YgwVa1gqqZuSFbqs/u2X+JYe8FEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDBNGsiquYzPmWrBj4AoSfwQWBEckabrZ2fuNUUdLZTOhTWnYaxr2cLm+ebexnhTHyc1GcV7bOfph6Bx0Slpb/n7vvwPNRQPIhyPDgKkkHDWDcO1x0gatzxUqjvIMb8guHL+bQk1N9lEAOQXWyTxfvZisXjHBmF0htqV5hZ79co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPta09RA; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPta09RA"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43d3a0dabb0so1284194fac.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850924; x=1782455724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqhCLTo8zOUq3RYZ3hDPiJBZCranw1aHkbhPxR8m/CQ=;
        b=NPta09RACAduy2S7x+fHcjoUJT8BqapnOXGCM8LMtOCpDaBHmXLgbazD7MYIUhiq1c
         7/VPP6Ak1Ew+AIMgDb/OhzXSrlz2QDqqul6RvXyXkmLJSS1g9QNqZjqKahogBtBuLmHm
         B+5rJpZo+tLb+g6cAbrX02cuTmDEcviASLkIJItslDywrRDbHGpDJFHDQLl5fHky+TA+
         dK9zojxSA3Hn9BhiagUFDys+TxIp2gWBoyrWxPhtxTHhm8YiR6y7Cj+7ohU2WTY3ClrS
         ubMSyzvsEWIJ+GIjU7bZK6w+HiJarep++PFQmAxOPenEd3zzOVbjBgjTLfIBsdAa80xf
         ktYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850924; x=1782455724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqhCLTo8zOUq3RYZ3hDPiJBZCranw1aHkbhPxR8m/CQ=;
        b=UKHEtvehlTPUc8AJAZm9GebQmaWF1cASDz56ERUWAhqH2TQRew0JM7hncCHnAspx/G
         YuoIgEPdCCRtoZyotAJCaqTFPpQKK3YlDOtAsavO920xa7pdqXG2p5MxPVWwu32Cfrz0
         gxE4s1GyRj2ZKw0O1sZD1mGyaa9OCiHaYECgg9zVlo5j1JfDZV44OaWXbsTq85HeTGHr
         6RsB67NO6eTJzoYvzK0MQIeg2KziGSKCHCQs9Y3qFW7DAudqYGvFJjYID/JO9WwpfO7h
         eLI7w3Oiou0avYfSEpPd68FASiRFyLomw8VZL2wJ7AB6Ye0I4Ors/DR1azwEGdG9UsUm
         7duA==
X-Gm-Message-State: AOJu0YyoSPR7YeQDF8ERIn9etg0sGiM5hz6UKvfqyLQ9PDMrxCdRxTMz
	O/5cMLaf3M4gP3Sp9BoJplmCbJHqy5KyHtxzeks5Y0IjZJFGyX+M0B4MBgpZVA==
X-Gm-Gg: AfdE7ckA/m/K+vcb1GZSP30KL98wBidWX2t1h7nFjBqE5OGEeqjuPiTgOUVDhzQZ8LE
	ekH0XaWFI/TUChP6Ff6rbT+BC6rbRdHoyyObHOvHBZWaVK5QJnijEweK4aqooqYYlfo+YQvqgnh
	svpTPSClwf0/dfei3+WFeiw+HpZD0xkliLTeARadDs4KODMQtl6YOJtm56VgQAzRuQECmxI9T0k
	Z+IJIdKUgDEGPBNEigGrs67x7uy5FDmCUbh9gYjGxvYpoS2bKqznJBan7B9OKc65OKe+m4trTwI
	BcUzgNhcs2SEYWgiB4+y7hsjTE7w11V3pSdHJfhOuAQTdVFy4ZQ5MNE+osYaTEH3ja6rAU5B17o
	QHqLJPLf0DeDOsBP3vDx2YaJ8R8E+T/DYFqz8B9AN5oPfA4FzSQFdoJlOB/VMABRCCA82TMpHVz
	wlgBM=
X-Received: by 2002:a05:6870:638c:b0:43d:3790:46c with SMTP id 586e51a60fabf-44707ef2b82mr1966563fac.29.1781850924065;
        Thu, 18 Jun 2026 23:35:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4470a3aaf12sm1431642fac.13.2026.06.18.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:35:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/2] Fix effective prog array indexing with BPF_F_PREORDER
Date: Thu, 18 Jun 2026 23:35:18 -0700
Message-ID: <20260619063520.2690547-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset fixes a cgroup effective-array indexing bug where
replace_effective_prog() and purge_effective_progs() used a linear hlist
position that doesn't match the array layout when BPF_F_PREORDER
programs are present, corrupting the array on link update and risking a
use-after-free in the detach fallback. It computes the slot via a shared
effective_prog_pos() helper and adds a cgroup_preorder selftest. 


Changelog

v1 -> v2:
 - Also fix purge_effective_progs(), in addition to
   replace_effective_prog() (Sashiko).
 - selftest: Set err on bpf_link_create() failure so the failure is
   reported to the caller (Sashiko).

---

Amery Hung (2):
  bpf: Fix effective prog array index with BPF_F_PREORDER
  selftests/bpf: Test cgroup link replace with BPF_F_PREORDER

 kernel/bpf/cgroup.c                           | 108 ++++++++++--------
 .../bpf/prog_tests/cgroup_preorder.c          |  77 +++++++++++++
 2 files changed, 139 insertions(+), 46 deletions(-)

-- 
2.53.0-Meta

