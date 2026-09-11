Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848F3B0AE2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095038; cv=none; b=L4unDYMG9ZqFobG1PnwSfUqoSaNS+gw4JB2owjdZ1LqfexbfsAO54ef/Htk78pi4NLwg+hvhlrNt+kY9pnh0zyaXH+w3doPb9CCA6Vz7o4AuSVCTDCtHmHGkIVp1LKVBiIAGV0gwdkPlljL3OzBezM7uCglLl6Y4a/2s1eGF+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095038; c=relaxed/simple;
	bh=yS5726x5t8pnV7c+W6X/yFuC965jvDlPCyqtMvcSBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mg5WPxr1j7q8eoEbbnyCZA5VnC++Xlr/FNKivqeBxbrbaCIlVPZivL1vvlSkCst4HUwdXks5D4xW/4USsBzBe8635eBd1bZQNMu+4z+OAN/AK6YyRAPIZtQf95aZKfc8HsdAkbfjT6gnad8/Uq5aW8Ncxs8pbOfqktnvUh/CRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grZl+aTd; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grZl+aTd"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-399213ef56cso163374a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095036; x=1789699836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtD8lzpYXi5mMb12J8/kWQaCmxdz2twCbPBl5zopPpE=;
        b=grZl+aTdBswe56BN0SaWk0tnjC5qCf+F1As1HJHkzDIUWt738Lj+F3kaA0pA/PJO6j
         KKNPX6NQDxl6FuA/piFumU2ugCWJmYMTS79vFIluo7RaIQ2YQN2G8kNFcw59GUGn/cAu
         9Q1WDEuAuBDF8Ir92oDEDGedlMlU3wnN8m+bfhnB+k2iXCbzEpju8CUGxs4igwYLUYvL
         lx06Q/dP+HLBVGSrmGgdyWKIQDi4n2bRiHVRcpjJCeVar5dWtm5PJb4ueKD/CzD1Vb+E
         E8A38w/yBMArLtwwTtPL3slCI21YbjJkMfXNTwF0zOG2nZR3wMnkvzyQTSc6b4ZQib8m
         OuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095036; x=1789699836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtD8lzpYXi5mMb12J8/kWQaCmxdz2twCbPBl5zopPpE=;
        b=qH0y+UJAVgihXLY9FIRMlX6cujanOY5hGaJCOzDFmvUU7Zcj4zW5K4TDhIXh3nEOxO
         qIbXBlefp2AUZz+briWEccbkVRmyZs94Ujw04TqCUZN1oISf1MFPojaiRv12mr6EF3DO
         Lz2ulXLBahxuKhqQu4UX6ApvCeXsnUKCGgA6QE7D0+kfTMZqxiRFcCVZO9erB13aF2ZR
         BJM9m/ApHYtSh6LVr51NBHGaOrpvpyjrRHUciA6sBd26kJjOD2j8hVEHY1SS8YcjRXGR
         uEdxtszSlJPO/kxNqoIym+nFAY03t0ZzZ1g4oarCXyletbETgjyFPEgGuQgHfgqQuV/F
         JzJw==
X-Forwarded-Encrypted: i=1; AKwUvBwHtJBVvLIHQBwv5lcnpdHwd7wUU55xjKUUnAr1tPUDVixUk5PrDZLnghl2BXEA0FRzYNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nq56AatTX3CqVB4uUidecIj32698OOXRKZy/6+4iZUo4ucAD0q
	EXLU2pAVE3eIZOq1cpY4GUREC13NXV8hIhJFijIv11OQBrGcQM3tFWuw
X-Gm-Gg: AYBFou0sK9VnP/xOojGulnj6pequUKvQYr2KCjmcxxzlgt3MsdVrAlCKaq1QtXeXpHm
	fScO7q/dtEPfqsyE2tmGNgV8c3b9TzV+8S9e7/2mtZFoTF3QsxQvtEkXUBQbthNXOiiYL8NkXfF
	q2pZJeMpYwiPA8NA0P2ItdIXViQ5j4P1WpK0Ig+miUoZbatDlNfFXJMVYgt0ZE3EEMFiSNPW2Dv
	Pe2gjGcFYviaY6QQiGisQiIrzlKdEkDu2KvKM3lwBzj3C8CxlHqf2zUIi0dXcmyfqfPlErX4mCz
	8mkmF9gtVFXrMjNBTa+9cB7/QDFDZMcs2XW6Do8kLuPwVhOx7tVqX+FXDVG/Dqmed50S7faXNDd
	MCCYgGNPTUGm/EVI8Ok++NE2C6fXudAZpRcxfCZPS2jfyES4Bu7NwhVSi5dRJI0aVr4+i2uYdy5
	ZvEhKLMr7m75NfPqlTUBXQdQeoxEUn1i1cD0LlZJEqc1NI0SVl103D5xfeeB6MAxd0
X-Received: by 2002:a05:6a00:c586:20b0:86b:b308:b926 with SMTP id d2e1a72fcca58-86bb3183845mr37838b3a.14.1789095036160;
        Thu, 10 Sep 2026 19:50:36 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b28ec45b2sm378270b3a.23.2026.09.10.19.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:50:35 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Cc: memxor@gmail.com,
	void@manifault.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Exercise double release in cpumask failure test
Date: Fri, 11 Sep 2026 10:50:29 +0800
Message-ID: <20260911025029.190453-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

create_cpumask() can return NULL, but test_alloc_double_release does
not check its result before releasing it. The expected NULL-pointer
diagnostic allows the test to pass when the first release is rejected,
without checking the second release at all. Removing the second call
still produces the same expected rejection.

Return when creation fails and expect the release-ownership diagnostic.
This makes the verifier accept the first release and reject the second
use of the invalidated reference.

Fixes: 7b6abcfa15cd ("selftests/bpf: Add selftest suite for cpumask kfuncs")
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Changes in v2:
- Rebase onto current bpf/master; the test logic is unchanged.
- Keep validation details outside the commit description.

Validation: all 36 cpumask subtests passed, including
test_alloc_double_release, in an x86-64 KVM guest running the rebuilt
bpf/master kernel (Linux 7.3.0-rc2), with LLVM 20-built selftests.
There were no skips or failures.

The v1 CI PR expired after repeated "Patch is empty" reports without
conflicting hunks. This patch applies cleanly to the current tree and is
sent in a new thread with git format-patch and git send-email.

v1: https://lore.kernel.org/r/20260906143934.848632-1-hi@tychen.cc

 tools/testing/selftests/bpf/progs/cpumask_failure.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 4628feb53d86..e98493bd5758 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -45,12 +45,14 @@ int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted R1")
+__failure __msg("release kfunc bpf_cpumask_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
 
 	cpumask = create_cpumask();
+	if (!cpumask)
+		return 0;
 
 	/* cpumask is released twice. */
 	bpf_cpumask_release(cpumask);

base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
-- 
2.55.0

