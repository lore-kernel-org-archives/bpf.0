Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCB394496
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782140; cv=none; b=HXZJadAblJDR9oZEqy6EZQ+anGmVG1ohbdPlPqAsGakN/a5NHInTM5HsKR8wzEGTcbDmkC0PbD25LmJ4RjOPPPNH1hVsu7NQ3toYdB8JbicqS7jTCNBUIn2instU3Y+fVOGc/KCJWtHyxiEHLjS2aJa07Ptxcy2pouYEAyfVsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782140; c=relaxed/simple;
	bh=YW79MvK91y2tqUThc+7Bc+OXx/PEjg3nEURhXk77eP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpA75pB5v6x+f+ewHeNy9gxsaEQWcFyVNnCdvk3MMI0q/3YAbDqgyMQSLF0K5xpWk7LvAu181YjjLf/BeD//OZ5JTs0MnXTZ8I46zYGU90HvjslWkXcphxMIAscmUugXKq4z78uceWqlEEfPTF7wlHI6ZwZkng3+jjJvN73uIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbnCYjyJ; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbnCYjyJ"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso2924905e9.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789782134; x=1790386934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJZvTfByBskdCOs+JgiFBMPYHweGVQSh7s5DnWjWxa4=;
        b=AbnCYjyJ6xmUYrbIwzn27qBAS7N4wUiHk0YTGjPJUr/iUanyfraD7AQJ7KbpAYYyzS
         plj9tXwb7zShg9WqE/vH0pE1+qvdPEJ5nJsu/OquYLJY2e/qFqSopea3gVtppOTTPtxa
         VvR3VCSRoSNFoeZWsydARyc//Eluwnd7ni+0UWDQGbtEjkUqzyxZ8Snok5kGlSXmRnAq
         BkUhq1uOPhHB1rjE9B50KN06mMWIllKYNOc+Ke6UdVUlw0kfq1sook+Y3Xf1pHPTbooX
         rCdfH5XGbBRqryWSK+ZBiSxt/0d5PvcvAzIqm2qhgNjvjs0yz5GPD3OwHp8TkEit5sn4
         ik0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782134; x=1790386934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJZvTfByBskdCOs+JgiFBMPYHweGVQSh7s5DnWjWxa4=;
        b=Ihob0m5SAZwpyx72cM/TeOba2a9aS1MA9YgisL9FSV3EqcRZwTnZEnqd+D4saWyu6i
         h36G1DsAy89QawnZo4Z78PLF5FMhU0PucLaF/Txqg2+v+L0SNeuye1a6PbiMOL7MG8Fv
         o2W+J2KwUheVXeybkNzQkhO5YDm5NgVrziGq5NaZpiQPvHs7MY+fzA42Ny/8Gg67PifT
         W+gwX31KmUjE1wzS0lxEr82vlCJdLhhz++qvvf4KdA5FzhX+qH6H23guXDKfvT7xgui9
         zDmci6zRUOjuCJPT9aNSJNMrs2pD2A1OqRlBqOqupVYTcolMZva0w2z8fZbYQ14t0f8/
         wu3Q==
X-Gm-Message-State: AFuF++mUhRMbeT68BHH3cEVBUjGjq365oJLo+p0YtZri+llUGZLrqlM7
	CRMKnL3TJgljjpCZxiwjAFTyxXbL7M773Yxs0/cfZMHD7q2ucV03NCTWhsksj3t4
X-Gm-Gg: AYBFou27QDRocdqzWAwc+QRmTQMPKz/E0MsbU6nnRNExsSTO8/dzcYJJLAfY1uJmdmE
	FPEFMqIxxD3Le1jVautbWvmnf8U1IDobj1EwZgaUm+t09y08uhPm83/Bi38Iaa3UuQPjEc+ea8j
	aaW8OFtVUI3gteoSrLGWl1UL4rBtPE0VWHNfFGuKpBo03cVXoEI/nnLR9XO22wEjyKQBCr7Kk87
	6IQI9G6lUdJHNZgp95WOXcXAeuW8A2coJwwVNa4ZlsDgV2xFSV6jXL9Wiymh8xxFLLs9Z38PW6B
	C1lij0nNa0YSo5G+mVPyahq71fUOQobXAJsK/+bwNKIHpGB5eqJShC5Q6HI8/XCX9Cccrj7mrU6
	Rl8fjQaDKds2FuTGcbh0uNP0r9ID2YYFWSjjUAM6IDeAicugOI58P7AKqzF/mY+Qkb0xfEZCQJB
	La/mNOLtzhd2W6vni0WTN0FkVxh4aE9bFC8tFE2WjTuCL+KggngLElB12aNzmQ60WIMR2c+7U6y
	Y/2vtCLWJc9kCw1Zj4oMbot3pfFSFVsxNnibrvTwd0Uotuw5TuiA7Ld69Z6I+Re/ukZiVFXWkrD
	H9F1cay9ltMmN9ZmOOD7MoIaWMfVQyEjazW3JeJcmn8TLX7Q
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fc585e9edmr55441745e9.33.1789782134364;
        Fri, 18 Sep 2026 18:42:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cba562sm67078755e9.2.2026.09.18.18.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:42:13 -0700 (PDT)
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
Subject: [PATCH bpf v4 0/2] Compare stack frames in exact register states
Date: Sat, 19 Sep 2026 03:42:09 +0200
Message-ID: <20260919014213.1840880-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534; i=memxor@gmail.com; h=from:subject; bh=YW79MvK91y2tqUThc+7Bc+OXx/PEjg3nEURhXk77eP4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvtsxMfKhZfyXxynuXh/+T7DKs37956rP6qzDXWaWzZV w/7Lfe42lHKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJaP1j+B+5wOHh7tzth59F MX22jJntwCQ7f0lMS8cWdu87tjsWP09h+GfybmPSyr+vI4p3qlqyGZw5WH9Fev+2bQ6myqKcxwX Wc/ADAA==
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
states_maybe_looping() comparison boundary for the new layout. Since
frameno now aliases other pointer metadata, bpf_func() returns NULL for
registers that are not stack pointers; the callers that look up the frame
before checking the register type dereference it only afterwards.

The selftest keeps a stack pointer live in a register across a loop
whose only change at the header is the pointer's frame number. On the
unfixed tree, the program is rejected with "infinite loop detected". With
the fix, it loads and returns the expected value.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260919004327.1403382-1-memxor@gmail.com

 * Return NULL from bpf_func() for non-stack registers, since frameno now
   aliases other pointer metadata and some callers look up the frame before
   checking the register type. (Sashiko)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260918011313.3053497-1-memxor@gmail.com

 * Rebase on bpf/master.
 * Drop the redundant spilled-pointer test, since existing tests already
   cover the stacksafe() -> regsafe() path. (Eduard)
 * Place asm labels on their own line in the selftest. (Eduard)
 * Collect Acked-by and Tested-by tags.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260914161340.3419141-1-memxor@gmail.com

 * Rebase on bpf/master.
 * Move frameno into the type-specific metadata union so regs_exact()'s
   existing prefix comparison covers it without growing bpf_reg_state.

Kumar Kartikeya Dwivedi (2):
  bpf: Compare stack frames in regs_exact()
  selftests/bpf: Cover frame changes in bounded loops

 include/linux/bpf_verifier.h                  | 23 +++++++-----
 kernel/bpf/states.c                           |  7 ++--
 .../selftests/bpf/progs/verifier_loops1.c     | 36 +++++++++++++++++++
 3 files changed, 53 insertions(+), 13 deletions(-)


base-commit: b4e875d397da451fb4e9c573ff4b86db53caba05
-- 
2.53.0

