Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C02931E1
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762364; cv=none; b=bKhP5MVgleRinWOjjzDkB23f/Xw1clBTA+99mn8+GkKrn0Oj5Db3jJo+XWzeRE/AY5aE6k5d+M/LHy+fLlg+FlR4IVUD2Pp5VXekR5r/DG56QiweKUS8uw7uhl321Mp6uEuA/G+EGCl06Zf65qVY0imVmR2if3KLYEUeuigZ1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762364; c=relaxed/simple;
	bh=o/onkKlRXiOcNw/D04uTclgG7uy+iQCIPxXL5aK/npU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+zLeJMWVtFbixw6gvq9ZcW7hmxXFYL63ATf8nCO28mhmK9LR6k/+zmfIhm+H3KIQVVQ1LpSzOp8tkspVCAaGhqSdKAmadEQNF9HeSk5KIHXK/BP/oEayH/4JDdBS+6EvIUmCgh+j/ulfOGoFySk1AzbZItNWqFDlgVRL5jmIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlnK5OOO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlnK5OOO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647184c73so1062695a91.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762363; x=1791367163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qdxXFgub0WUVqsc27P20GBfO0pyQlvEa2WfrvrVpc6I=;
        b=dlnK5OOO3XLradWzzLj0w+TkMBEa1dIXp2nh6IKMX+fo0jOTYeD0vPiHO92py6Dqt+
         JKLp/y/kdZNHg3A4PjRcTjqt8AiiwmLRfzdW2aReSTbgu48QC1lsomld97GYjDwCHiMj
         xnXZVyQubhp6v+GqXzQFZMvVFB0ZjR7/EgQoBuA5T9L8S4ezghN9br+ZjcHds9wAgTAt
         AD9wd6WKzLGdJd2W4+ETJec7YKzocyApN+Kdk3SAtg+6UPTvtyNesslJuR9hew2fSbBo
         4Z+qLS5+V+Rh4h+fcl5dK+CgWbgf1Nhw1VqOPDK9A9AyGZaawPR9ldFwJn78skbXFs1B
         TYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762363; x=1791367163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdxXFgub0WUVqsc27P20GBfO0pyQlvEa2WfrvrVpc6I=;
        b=zemlZg5MlFSGTO2Yes/7AVB6sLW3qtRDE0CEVGwGPNix+Q1LCYHLE50mNXyNNshmwH
         +vKvLYmN4NbKwXB9B7WYzY43dsb2YJefmUJVUJHdFShZmsjCAebYRo/wVa230Ko0Hcrk
         MlL05BRydGwUsJqa/5N1uykfkCDA9gYPml5zDMGe8syCCPHw6U6VpTeRaKnlqQTIVkBs
         PBPSQMpRQB9xcMw+fCxxRyNZH1gIb5Q/GRzwi9vDD/osoDe10KwF1Dj6RlBVhJV18WlM
         bwgui2+qah2gk+Rc+5APPteNNGr9dLQE3EPy9D6EGg0P/1esEClDkjNLnbDhJ7geCFMH
         Jfww==
X-Gm-Message-State: AFq9FYIOZ4jRPbWAU81FfuCMKOtKn4ifThbpcgklGl1LvNNvHkiFz2wO
	EokQ3Bgbh5E8HgXId7t5NjGREfpO9J/HllROcedJnObkFfPbnOa0UMAOr2saBi5w
X-Gm-Gg: AYBFou35MPVYPfIfIDml8wTfOjePJqZLnJUK/CEGlfRyildsSGsCAcbPtb9ZUmfwoOK
	UTX0KNWsFLZ9XztsoYKaaDvHD90XiiN9On9Q3N+jRN/3apcbh7TLbmamD9+x0d7jF2ueGBVBd41
	l4dE3LzsRWeKdEbXBeyCSyMOhr+B5Tc/gVkcSIyhJ/s7DjFdgZGE+vuaUv1sPnHpR6mobDSV5dE
	FV4Sh9W7cqj87suegQE+TM6ZNffGQ/CWWk0SDTeXwN5JCj7j6qgMsSJGzfUCfbriYuF70qNpJVE
	d4Gzv+zGGvsndLYhOompYp+6q9mz7EplGVJZS6lfTyk5gcZgLRe8T4D7qVsMiNgZk8Y8I3rzQDB
	0OpX2GBjCv+aYyNm9nl2Ja8CbEH+dqz8V2WzNV1aTSRzxns4c1787XgnCWn1AY32cAGfU89rkVL
	9vh2xtq7UOx5vMbEEj+sfAWmIOwO5wh9QbGiKsylwi4hHgFM1rC/8ZB+7GiV3+4xII2FJZ5poMJ
	cZQEsLu6l3tgdT6ipc25IHLUCAvYNMm/wgNQVbC8IGqzsOeRQvgI0JN30FIEaT3whhZ0x2QoHlH
	C7Thina22R3kvkvFJNxawh4Q9rCDhQelt+1tQGIYRMI=
X-Received: by 2002:a17:90b:2885:b0:3a0:efa0:ff3d with SMTP id 98e67ed59e1d1-3a4d0e20859mr563435a91.4.1790762362580;
        Wed, 30 Sep 2026 02:59:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e02c5bf0sm281166a12.25.2026.09.30.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:59:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/3] bpf: Fix objects stuck in free_by_rcu_ttrace
Date: Wed, 30 Sep 2026 09:59:17 +0000
Message-ID: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The objects that bpf_mem_alloc frees while RCU tasks trace GP is in flight
stay in free_by_rcu_ttrace list until the same bpf_mem_cache frees or
allocates in bulk again.

Patch 1 - refactoring. No functional change.
Patch 2 - the fix.
Patch 3 - selftest.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (3):
  bpf: Factor out __do_call_rcu_ttrace()
  bpf: Fix objects stuck in free_by_rcu_ttrace
  selftests/bpf: Add a test for objects stuck in free_by_rcu_ttrace

 kernel/bpf/memalloc.c                         | 57 ++++++++++++++----
 .../selftests/bpf/prog_tests/bpf_ma_ttrace.c  | 60 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_ma_ttrace.c       | 50 ++++++++++++++++
 3 files changed, 157 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c

-- 
2.55.0

