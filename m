Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FC347536
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585149; cv=none; b=Z3RfS1wE7VpWg1PXWwP1lBtvU2qLWWWLCV7uNVNkcNce67AgPheN+bO+ex//ddF3b/upYVVlC3T/JRVLxYl69oThMByht8bWVIoQp7oUaKUsZ0RcGLh+Axv/v5QhnQkeCZLtqWx+SI1MIHQ6F1WyY+cIvJlk1BgaO1SnwaT5qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585149; c=relaxed/simple;
	bh=4Q2PJvQcTi1bASa4sGDvzAdyrpe106Q8rOz/UnUFnzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFQe28hFKO+1PHeGmhXHwli+DJGMgERqVAIHD0rs71cn6ocsIXIHE5vBaRB6F6lz4lodzveRcFldbQGO7jq1pKjn1DQWTEIIFVKnmHL39c6tZBh7egiFqLXmvey4Er3+hMxO1DR627O9UIHpu1jNwMLQblNEY9KBhP3Aw7W4GCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC7HGMA5; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC7HGMA5"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso4810475e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585146; x=1789189946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCDp3UzQf08qm1H4hdhdoY4PvZ7gbJyWySls8p2Lw/Y=;
        b=GC7HGMA5q6f3bt/OoFA/PD7sC/WgTjoVO4WLo6DZDZf0Cd1Ez8JkrrUZd/5CikBl9M
         47uFidsuuxT2wkznD6ky6I/986SRIBzFZhKELyZUl+nyEqHAVTjg3PG0Npms9Nvx5Cq/
         1RmLj+C3v4o6LJmbz4rHM1h/DCChP5ug0/XCEgvGXiTCc47krr2jf0KwZHNwAx7g8uBa
         YfvrOQHVjvt7VvHTuw6CD7E43ChT9pwiJ7BLZ4s0qmN6CJ0uhrJTAtVkr7+ICNI1NlIj
         XsPD82TXzge4VHKcGvjWG5VYA+pNxEutr+jX7/sz2tf6LCljHA3UhxMv6c4k9VoLXrDq
         EzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585146; x=1789189946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCDp3UzQf08qm1H4hdhdoY4PvZ7gbJyWySls8p2Lw/Y=;
        b=ClNLrce30iSQ3S0Y18T5V61SfQDxtc5a7DvAzzOJ4RZwTS3nhBNmuWTFIgf9NY0qno
         tILz1266fDK9z9FhzUM0ps5lXvdJo9aohu1Ws3/lW9G1CDyX4UzoRbjqTShGEja4Pwvf
         RDZ6CaZuEpT+mGfyoNWJ7q1RwTPDWA4lD650MQzoJ7ItzYXU2JktzmvtomdTwuQ1AUx0
         Y4OIyXYnyf2guKtkhVKgalcO1zeOAC9PsDnpRvVUE18zzloX/wOBY48oGYx5lPesvf2X
         fCU69S9YuL8g/HV3gRf6VDcXsl7V/pK3tEcYfvB+rYnx8Z9hD9qGe+N+9BCc7FTXE3QY
         e1mw==
X-Gm-Message-State: AFuF++nsGv/K9BKOOsTVIUH4/6FaSa9jxJNjtDLG0w6lkyrz0MVHTuUx
	67GfL2FDtCTF9OYYPCcUvg7hl1UtmiMYwoHeCXyQapc266FOvszqGvDPSucckW5F
X-Gm-Gg: AYBFou1pmcOWKtn5gaDsUiUcryeRZDs5o/D8GE5KcpM+8tU+frWkUE2ylu/c66J8386
	YDrWGDr7FX2SArY6lnSueAicjLMuQ09SfZFo7jqcSeX6E2hgfY/JDRSWC6KIySzwkafpCbBEuRH
	1xvIFr7Hq/xSj5CvD/Uih5bNB55Y6SZQ+U3HFDfQJZNz84BD3mOUYlGox0VFujTjgVo5yEq992I
	nNPxrxcW0uvsMEMAO6jvf5O7s1aJiyBd6MvLCDJcM8NJJnudjV0qOeQN3sXED+QV0hB2ntagLSD
	6anTvkFIkIITm3wA+iUtnEAU4b8U7r8FQI2H5dyXixUEChDwknZtKJzK65okpHlmq16IleWNuwH
	BaYzAIgdT7ONep277QSZboTiHRwgmjiWr0QEnQgMmA9Y6pM9+f8j8QqxDN3U8Yk5XCrsYvamBXL
	XhzJCsWrMeL2j0LLZrJ/qbvq13qI6BSBFfTyLyp7ZhdwFdZUH64aBQUV8di5pAJ6lNZKi0DAW2P
	RNPmG3fa2wdnZZhvO/BXuWJLl6GV6Lm3pMZHhvF5IE9FX+ErURn3RCowCIuCKaepIfEVV/m8k6a
	81x7tcsLLLfuivu2k8dLfpJTOlld
X-Received: by 2002:a05:600c:6211:b0:49c:fa21:1c88 with SMTP id 5b1f17b1804b1-49cfa211d8cmr76353495e9.29.1788585145633;
        Fri, 04 Sep 2026 22:12:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5936a5esm110576755e9.3.2026.09.04.22.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 22:12:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Fix global subprog verification context
Date: Sat,  5 Sep 2026 07:12:20 +0200
Message-ID: <20260905051224.2325381-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=memxor@gmail.com; h=from:subject; bh=4Q2PJvQcTi1bASa4sGDvzAdyrpe106Q8rOz/UnUFnzU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2kqV/GQ2mP1SOrWJ1vLiDey+byezPxhmce6wu8uZy1 2QbF5R2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ7Ahj+R5/5+ij4Xhzjhj17 s1f/sj8pn7h1kY97xNMLrLM+vkpkOM7IcJx9/gdW67yLF8OFXx4tPZdwYjvrprVeX2UFS8PmHPr MxwwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Global subprogs can be invoked in both sleepable and non-sleepable
contexts, but are verified based on context assumptions for the program
type as a whole and not the precise context in which they are invoked.
Nicholas identified that this can violate verifier safety assumptions.
Verify global subprogs once for each observed sleepability context and add
selftests covering workqueue and task-work callbacks.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260905034018.2095649-1-memxor@gmail.com

 * Preserve the harmless global subprog calls in the positive test with
   barrier() so LLVM cannot eliminate the intended coverage.
 * Return zero explicitly from workqueue callbacks after global subprog calls.
 * Document cumulative instruction accounting across verification contexts.
 * Fix BPF multi-line comment formatting.

Kumar Kartikeya Dwivedi (2):
  bpf: Verify global subprogs in each sleepability context
  selftests/bpf: Test global subprog callback contexts

 include/linux/bpf.h                           |   5 +-
 kernel/bpf/verifier.c                         |  77 ++++++----
 .../bpf/progs/verifier_async_cb_context.c     | 132 ++++++++++++++++++
 3 files changed, 182 insertions(+), 32 deletions(-)


base-commit: 3ccdb07813829ba9487273e75d1cb238cfa774c1
-- 
2.53.0

