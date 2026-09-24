Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3A439331
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242196; cv=none; b=c2XzLYqw15kwpzYQF9aryeYrZohOgVjhXd5dMZ70Jvmi+wWuL2Wmc5jNLdDPa/xgXt6pgbqDjFT8f7/Ebg6y7M1erieWBaUjWVeWgGwezIe9DGAzI/zJueQe6GUObIw8KN0ats6jkPMrKcxhW6KnlPWm3+ZGiR5uHaWwbyV6QSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242196; c=relaxed/simple;
	bh=NhlHw8/KmsZBDW2rgeMsMJZbUcS7zcHgwpTBFbHNFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUXjW0CKaEdavu/KiIkOxPBx+A2a1oTaFtkjM1Oq7pLRh56dEUzZIrWRbyABYlBZnzrvzU3l5nYVB+WRuqomzapHiCqZgEfUnKOEA7A4vZZwmhNnFlEHs5eagBTsJrJvRg9TT8/AjUL+qzA+prWNm9UxNZz17TH/lcvTZR2GPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBMnCjWv; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBMnCjWv"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso7274765e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242192; x=1790846992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6doM8jy3a1x4EW/XleKbWc4iYyEpszSF9MzKzfFDbds=;
        b=NBMnCjWvpgQ8nuPZGTXYDGAkpMOr5fDl2nk3KWWt2cDmHa6b0IkHcI3m2d8PuswwJ4
         rOrVXkUXeUt4ngzbO6eHSX+dZnwZXF6uXEbEcEyf0yfnMF678H8Z/y8IKlgj5NwggzpO
         Y6McCZNcAIYeLzDaic//nxsEXzP0nM4cl54vgYGmXccwdatH4PGhCx8yyXIwwNbho1FR
         7yPrSf2sIufIul2J7v+u5woKLIXgc4jcvrj+RsyF53B5GmcykUMjA0QIirAw/lsi4ema
         DOiqPUFNt/Gsdw5tuwAKyOOkG2ZpJKckApBa2pHtDvZPPNR6aCZ3U5MA0JbHUqmm3fZo
         QpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242192; x=1790846992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6doM8jy3a1x4EW/XleKbWc4iYyEpszSF9MzKzfFDbds=;
        b=SVu9NhRiJ1HjX5+k+i67CECXBLnFMnqbrswrrQaojPX2uMfUyEMw3nYeVscwjBfRrF
         vnILXuf5dNzJh8p0zvfk5UjZ7gySeQbsSVuQJgBDNlfKr1YIbN1SGvTAUSxZNWho9PDt
         5YIw11/PRan8kiTfdRm4rkibXbHM5fYEYNQjlVnIti10ZVDw8oMDIe+kH7i/O6CJ6HPi
         uAYJyIT1JC7YxGy6pbW0G3VylPth+Zj42gGvDMBfTbD7PL6/tJlXhW8eMCIkOZj6DbKo
         Y++y1EUreSha9urrlH5nuBRzhxq7D7Syu5CF2LDri+6MNWaWhOB8w9nJPnFy3ZwLLvyd
         XGdg==
X-Gm-Message-State: AFuF++m7y0SBh6rf8FVpyHhHmE4zVW4FOLbciMp1iVfkTi50d+JDB0N0
	MrsemNUr4lNRR1tZXmAu1Ifms+Am6m/QHxIb0JuSjN4c44FQD/aRSiVT2BbOhJkb
X-Gm-Gg: AYBFou1vo42+ICQZTD8n9ACSn+gN2jkWnw4q8adpHv62Q//f8FZ7aE0OP4wMAtuDYlB
	wno84VlbT7IKDEB1CmYSFOvnvun0PlIttzNvGaDtFn5Ke1koaWt7pARfYn9i+eIOZPpb2UjWdqb
	UlKYudMwUvyfDq/n2cvMwrg4WBlwaS1YMypMHQe/9qYYgNdJmKSzTLs0GjtKdY5quhzCIrmL5bj
	CUoLBHSQ09I7pBA9NOdwrOO/N14n3HTOhoE7oZM5e/pTt+WdVFXa5RrDnEw1E2Yt4uFDbC0wj4Q
	3TT/98+ekuxqYga+szyifx7x0PNXYAoiubnvo3eMdQVjyCGzaSME20YpFVpzpFDhCwQD7UdbWw1
	fF5YqVx+d/0+yX1OssaykXBGjpraoRCMDJ+uustHfChKNtzhjPTp22qly7CjohnlqKSD7+rEZwp
	pWv1Le6fgX7fEHO6uDnBOvSnIVLXz/EqdlfkIhHWlI5IR8j03gFYBdyl40eH38/odzW0JhjoZqA
	26qa8v1c8I0KxO5T7f0QLCXDyDagv7zYE24GYMIRenxXEfiqQuf9tylDpWLP810us2ESr8gVPij
	0sIdh4V6+IE3cPBTi31vM44FBxkPyrbUp5F6D84=
X-Received: by 2002:a05:600c:4ed2:b0:49f:e3f2:f5a3 with SMTP id 5b1f17b1804b1-49fe6685393mr32236355e9.0.1790242192074;
        Thu, 24 Sep 2026 02:29:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4271sm82035215e9.5.2026.09.24.02.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: Test non-sleepable kfunc context
Date: Thu, 24 Sep 2026 11:29:34 +0200
Message-ID: <20260924092941.3174809-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=memxor@gmail.com; h=from:subject; bh=NhlHw8/KmsZBDW2rgeMsMJZbUcS7zcHgwpTBFbHNFg8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL25xluhnbIiLeLb/WbKnkcDDn0ZfsM7tPHih+/eDtE cVFZj+yO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRXw4M/6N4g/XWPilRM1r5 bB2LsmMGx7eHWqIvy07KpfU/uregUZWR4Zhl2TR/lY9HVc04t7zcu4j9F2+v3AqDCcvXtrs63Vk Qyw4A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A sleepable kfunc call can be rejected because the program itself is
not sleepable or because a sleepable program is inside an active
critical section.

Exercise the two causes separately. Call a sleepable kfunc directly
from a non-sleepable tracing program, then call it from a sleepable
tracing program inside an RCU read-side critical section. Assert both
the legacy verifier messages and the structured reasons.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/preempt_lock.c        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 81c459435680..955391da326a 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,6 +6,8 @@
 #include "bpf_experimental.h"
 
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?tc")
 __failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
@@ -179,6 +181,30 @@ int preempt_sleepable_kfunc(void *ctx)
 	return 0;
 }
 
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_copy_from_user_str")
+__msg("cannot be used in non-sleepable program")
+int non_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within rcu_read_lock region")
+__msg("cannot be used in RCU read lock region")
+int sleepable_kfunc_in_rcu(void *ctx)
+{
+	u32 data;
+
+	bpf_rcu_read_lock();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.53.0

