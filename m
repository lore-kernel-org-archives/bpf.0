Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE0335BB4
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693998; cv=none; b=oLxw0fMCG1F5A30QBcQB42emIuffO7MC0wjEMHtAYOHa0zPXjXrjXUwoRAQbIyOON24l4ku8WNiUT8YOf0CyMqCoADXG9bjNYODBOLinAvCOSNwr2j1HlXiGf9EJJr8cMqIwzerTy3kUeO4uiUa/A7BYBk9TdNg2eBHPEVY223E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693998; c=relaxed/simple;
	bh=OYTiBdOtUL5iwxXAOp9bVn4tWYto0o4lJpubEDgqRlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoxQIWcZXSjnAa8L/D87FW6I9CPAtYGqhqVDNdd5m8HzmpDZJK83XQcs/Ff+KpARLIP970ETotnDUZO0pn3uCsFZv3ZU4l5Mac6qCqIko++ga+TyPSlbpF7PFvHxiFPE/TZnSTPUShWKApxKBle10rfIF3qm4vsKBT1FoPx2okM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewQuKUWF; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewQuKUWF"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so500185e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789693994; x=1790298794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WDTI78Wei8UGN9ztVmmEuT0GswQ/sM5vnWCZ/DQXVCQ=;
        b=ewQuKUWFeXhj2CbJ7Bm3s6ChITMjhQpOzMYVt6Ww87SFuz74txyS+B8XeSWLlz7AJE
         kSc5mUl7i7rmpd2J0QN8iH7kiS6f6KRcwGr9Orr5+BQAlkWtKF2JP4Oo2zxn+uR4kuWu
         Fw0HWNSMR7OTUCv7yyQnFCLRoPjWo4hDzP9sTda3zaK2wmHKWkYYGKvlWOsv3Fdb0XDR
         NQo0R15x4Ucn9gLTw62rHoFIv/wFyg1y3YkkCeGN+YybKH4IXQ6nLG0W89HANiGaUsX9
         Z+7xrljDvthOtaog7sEEcu8rIP9kaptHmwIWH/qTzwCenapRVTyGew9ispNa20dXfUNl
         VhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693994; x=1790298794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDTI78Wei8UGN9ztVmmEuT0GswQ/sM5vnWCZ/DQXVCQ=;
        b=ESaFsEm3dLQ+2espqzXoYWwjeEyqnc3dcMdL0G7bv1tt6kwBIjrKt741exUv//u0kd
         q6c1tK6+AMT5UlFYC99gZRvVy3Rry4mAvxGcmoMexDAvUYS8XL7hMuWcusXsOjwhNQNu
         S0Wm44FptjLJwC/ofTPhqflcJaCuwAu7VZ4A3JFrv15wMmlnCRYeZ0RP01wFCxGcnyV7
         Q7DKj42N9NaZ2D1CuuF3zEdZv/narxrZc7kF7z+zedh2Iy4fAxzflvsAX6Bd40mmW1l4
         Mb8eGkLQZlVgrMigfAEsx/EnuEzJSoYzubY6/bSu64y5n253I0FqeBCzHONeQdEPg2K9
         wfUw==
X-Gm-Message-State: AFuF++mnzcsNMPzYOmSSp02V04uGzq8AdWtmbkslFPHKS1sk3AtO5rUo
	06lkPBU9kYqPsBVUpvNxKqUa/nJECPlNHK7hGOwmMYlWwHBomDpDpkv+8GPJWzEG
X-Gm-Gg: AYBFou2wJveXW8Dyy7HlhFUmI0OQlGBOobRjjcmDYVE1U+n8+6bhJ9dvQsEdNDpteMg
	vZNZCFhoZVK1dksj5gzE9TPr6fu8Wi/ZyLS5KNPBgFHbDu4zynyaiexmyYIOLzh3ZQq9t/k4c2Q
	G/Vw7PH8JbWMt46AM0jFcFYNMZc9a6EGchSJoqsVrglVx6Ti0uxds4Ln64ydI+WeozU74N1tOIf
	CNeeOoU2uRwl8qO1Z7RSxqwVFQlxfOks4G5iB6nWQCQpjRgfyiFc3kHs6rCbF/YeFC/R6rqCAzZ
	Cf8HRqPl9voR3JgKTB1xlnmHJDnSwqyPU4iHWEJhk9iFAhxPH8rHFXG99PbJC6qZyHQP9tF99wn
	OVZab+6/FhRszEXyuNCo7yOi39TsYD++hFbTiOsfir1a385/UK1Sb21OsW+YSu/B9904XvaiLNS
	JTGu7EKNbCX+nHUABrVXMQzwVeV+XTmKKHDDxErAEXjjcCqVCAFwL53FW8sJ7PVzHhzRhEExn2V
	1gqDKjSfs97ZRPGFgLYAfWdlfyD0IhtjFs2SemXqE/7lyUsZ5ymqiSkKiOHn+6isT/sC9QZQ3s+
	EaG1J9dU9L3AjDPFyTH6wOtxILdMYxrRMP5iDw==
X-Received: by 2002:a05:600c:4505:b0:49e:69e3:884d with SMTP id 5b1f17b1804b1-49fc56dba00mr6981005e9.4.1789693994250;
        Thu, 17 Sep 2026 18:13:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm11888505e9.2.2026.09.17.18.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:13:13 -0700 (PDT)
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
Subject: [PATCH bpf v2 0/2] Compare stack frames in exact register states
Date: Fri, 18 Sep 2026 03:13:09 +0200
Message-ID: <20260918011313.3053497-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=memxor@gmail.com; h=from:subject; bh=OYTiBdOtUL5iwxXAOp9bVn4tWYto0o4lJpubEDgqRlU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvNBNnjxbVydgdDnbp5Qpc+CskKu558WLYthkXrqs1Cm 7vnFII6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGhGIb/JWvSJohcsTV9/GnC DuFv7+Ss6hpDmTe4XmlL/9GyeNHZ/YwMZyOzZzw9av1t7Rr51pBz165+Kjv40n1W/JZ5q1ONNao 0GQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares register values and their ID relationships, but it
does not compare frameno. regsafe() checks frameno for ordinary
PTR_TO_STACK comparisons, while its EXACT path returns through regs_exact()
before reaching that check. Infinite-loop detection can therefore mistake
pointers to the same offset in different stack frames for the same pointer
and reject a finite loop.

Move frameno into bpf_reg_state's type-specific metadata union so the
existing regs_exact() prefix comparison covers it. This avoids a separate
PTR_TO_STACK case and keeps the structure at 80 bytes. Adjust the
states_maybe_looping() comparison boundary for the new layout.

The selftests cover both a live register and a spilled stack pointer. On
the unfixed tree, both programs are rejected with "infinite loop detected".
With the fix, both load and return the expected value.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260914161340.3419141-1-memxor@gmail.com

 * Rebase on bpf/master.
 * Move frameno into the type-specific metadata union so regs_exact()'s
   existing prefix comparison covers it without growing bpf_reg_state.

Kumar Kartikeya Dwivedi (2):
  bpf: Compare stack frames in regs_exact()
  selftests/bpf: Cover frame changes in bounded loops

 include/linux/bpf_verifier.h                  | 16 ++---
 kernel/bpf/states.c                           |  7 +-
 .../selftests/bpf/progs/verifier_loops1.c     | 70 +++++++++++++++++++
 3 files changed, 80 insertions(+), 13 deletions(-)


base-commit: 3b8e5d9f2ed7abf18ebe63b7a6a4a64e1a9c2203
-- 
2.53.0

