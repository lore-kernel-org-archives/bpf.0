Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032F3438B5
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779591553; cv=none; b=ixlM8OKMOTD+Xif5qQv9NrdPpZQRf4Y47N3xjkKh1C0SO0s+MvDOHuxcfwk9/DRW5DcUEZMy2h8tHA2R/2ks/pBXicZs9fvj316JORad1zrdIqr1L0JqhQnYkEHteQngi6BhHn9u42b8RWIbZpbHBYN4//7D1UiWqIKL03u8+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779591553; c=relaxed/simple;
	bh=UbgCFgvmWaN3PxrtD/I70PhR4vT5giki3jZ1lSQlgl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFnjV+wMO/a0MWlVRc3StzLolJInn2bNmghi4LgelgTvlkpoWuok4Pe0cOLOHBi2dM330ZiRd/+wc4P+NPdQguqTEuvVgsNHpJeX0zonrjN2tW+SCAQM+WdOSm8yPEL/oOqLFbbaM2Q1xFGz6F85BeS1on/Ca+8CC1mdX4zvw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL99RfpL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL99RfpL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4583f0a1aso59486995ad.3
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779591550; x=1780196350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYwNNVyWKj7ua+gpS+KEFegejp3wiD0Ae6Di3tktjdI=;
        b=rL99RfpLUyFCIcILAomGuyLHN/+3tqWIwETNEP9f78Gcl7XtyfCu4Nnu5la0Njssyd
         o9CjCXDrJAp7HOxkMbbPMYAyD+7sX4PyGxNILxQR5fz3YNlKS8wUlP+ccBwEh2mMJJ7d
         bzjwSA6s2NfAledFfrtjuNOWHnpVbaAE0ZBWZvUDNc1L+CnXfAgZqFgHerb9MCyyhiBr
         6VLTW9PzvgN9CxCL3iRFWGe9TDondjfUpaWd76PXwny1WIJdbXdSlAs+jRR5jubtYtGo
         cp6Pw/5xIi01BDTBgNM4e1M3TNwilos50+FZJiGb+SFID6/ZPmyNF8wn5LdcSbuxLhCM
         F1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779591550; x=1780196350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYwNNVyWKj7ua+gpS+KEFegejp3wiD0Ae6Di3tktjdI=;
        b=mZMmyu7L9LDdxElfz5Lc37HUpj2MKfX2cMOmMkHec0JhtxP4FXju4r43jDEvTD+Zty
         mFW8H22ArTssJY7wkNqGfnr/nzy2P2K6asgZGE8lsgGrWfS6QyyEKcWhQpsVbK8hH7FL
         quDs115mrQmL+eKOt/ercfvEPBe1BgQvY9W7+E7oofY2sEUu7kBVNH3BbubhCG+eYsAt
         xkbmwxP6huTJ3ooCrB8TIp8WIMDvbDcxPHFKRY6E8MDA6/Ar2E5l5y//Rov1uolPVgvy
         cUu4uNdzSSdV9uetwHr67Im95VwHmqToeTbyed/qkf+O2PgIwSa1kZox1Pr2Warz0I/O
         9NJA==
X-Forwarded-Encrypted: i=1; AFNElJ+AD/wfzlontMKuZQ9rZbbl+38z3Vrx7RYpy6Ir6iYzu9Hc4R2eZLCYCHvMKT2u02cqmME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8bMFNZuCgAXiqILPo+B/xUJRUZotg8JxJ0OTnLo4+nqU9cQf
	CGPlG2YKHhKGpboo4kZTU0WuNdoEbQpBEYBnaMWK0upVLyRY1CcjjhHj
X-Gm-Gg: Acq92OEpGIYjWGr4s9bgdoRjDIc538eCEOuZPlRBJ0ZH41ZPQPEJbBYSWwWxNXaNv7x
	6/J8huo+hIl13HfuXXnU+L8AJ6DIvzOE0Nfo106rGX+HJ+8ES3jrrm4r0sSq/aCzfkDuOK/WgtU
	j/c6ZF+s7JGNjUNswBvvAu207V/Ilg+/hm+chsO5trnM5w0H9qSKHhlLlxtirQVTW+w5n5SiOXD
	cJi2rlwHaQhh8KLiWlVH20OkZ3rU9XetByLQhQwlDfzRRQuI6pIgQ4DlipQeAjB4bEHbKdkJYG5
	HbE0eydIE5i56G9i+9EMW3YjtWderxFsCuttI/odzmtjLTj9rA8OSDN7Y5dj2uXywJaZmeA/tBJ
	r6W6cQAcvtT+dVt1mySMu0pnj5TDiF5oiUhCFpGhMxL/sdJ84YwiUo8U2qw3nA3uNZVoEiqK9Kk
	Kk0V9mWy6W9B1U7T3y1Gt00ijmZJ6bsbE=
X-Received: by 2002:a17:903:2450:b0:2be:3626:dd49 with SMTP id d9443c01a7336-2beb06eaa4bmr100475355ad.8.1779591550322;
        Sat, 23 May 2026 19:59:10 -0700 (PDT)
Received: from archlinux ([205.254.163.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b386esm62212935ad.44.2026.05.23.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:59:09 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v2] bpf: replace pop/push emptiness check with bpf_list_empty()
Date: Sun, 24 May 2026 08:28:53 +0530
Message-ID: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify fq_flows_is_empty() by replacing the pop/push based emptiness
check with a direct call to bpf_list_empty().
This avoids unnecessary list mutation and simplifies the code while
preserving correctness.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Changes since v1:
- Removed unused variable node
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
index 1a3233a275c7..8107f5934d2d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -196,18 +196,13 @@ fq_flows_remove_front(struct bpf_list_head *head, struct bpf_spin_lock *lock,
 static bool
 fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
 {
-	struct bpf_list_node *node;
+	bool empty;
 
 	bpf_spin_lock(lock);
-	node = bpf_list_pop_front(head);
-	if (node) {
-		bpf_list_push_front(head, node);
-		bpf_spin_unlock(lock);
-		return false;
-	}
+	empty = bpf_list_empty(head);
 	bpf_spin_unlock(lock);
 
-	return true;
+	return empty;
 }
 
 /* flow->age is used to denote the state of the flow (not-detached, detached, throttled)
-- 
2.54.0

