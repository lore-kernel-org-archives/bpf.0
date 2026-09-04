Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154EB36494F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503815; cv=none; b=a1xMTVWQ9oL4XZWzc4ZRFL5wYpj8iQK4lnXGEFiM+uiQIMoau6PHJ/NSlnoG8M+aamWwH2EukH4RY6fTPX2++EQYWNoEpcYdY2/WHnOQes2teCrupMeoim6puvXYkhm4UFxfpaX6PfVyUL2bqcfVxRJuuWVh2xkJk+BMaUnOfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503815; c=relaxed/simple;
	bh=AKY+H99Pt5E0FvPmT6Ql0leYwG9CW+UlTWYIi/NDof4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpD2Cb/c5AKK0md3qrTGU2qklushj1HeiX1/6mcT/WV5Gu/9RRzr9fxvydZmwgkDxstfWlEbvPGFICNPeLkwjx1as9dLXHIMftpFXoMXezDTDpoRa24uFQrJ9hMxx7BkNick5P7NtZOtVgRFuL/+4avVaQDbl0tT5gDIuN9ZYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtXZJ4YU; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtXZJ4YU"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so224522f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503812; x=1789108612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZrHNkHjYkPGX7CqsHn+BkcbXq8exU6WdaWM6xnR1F4=;
        b=GtXZJ4YU21TS24hSxb7pVLtUjOZaqe1lPxeP7sF55kwg7uvRUjv7ke0SG3+y9JwbgV
         9eLU8TS8AVyWeixA0tuTkjdii48wCJ5EvqfJT86AVeTRBtDY3U5aFs/ZBo/ek88XcouU
         IAto//a7DRUnNZ/GwWLt8cJ0s1DQqeC5mR7VDlRdqQ36i4go3I7jH8NTRuFb4DysWf32
         m7OjG6AHtqJc6bIhRF3Etkiq7SSUBIqwDnkwnxTrki8cKqUB9qCjLKVUaYQ8NRWyzbjv
         kOvYZCV87HlPqwKgI02d4mke5qtHg8F7aIDavL7R5YRndSAf81gz/uKWjEZ4gpeNa5sP
         RTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503812; x=1789108612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZrHNkHjYkPGX7CqsHn+BkcbXq8exU6WdaWM6xnR1F4=;
        b=IFozVRuCGpubuVOLZdfcAWhFCC+u6+gg4WQTepnVQIgmkIbK9GbZ0zG430Aj7GDYS/
         qeLqvTwibKO/zfzxdO83PRJ4xUw5vRpl/H7mKov3THYWGov4H0GhRUGSz676hX89aN6S
         KmPn+el2OWhR4AmTgSWb3UUAtQBvYlMYMxIKSl4uzmwt0QSUt35BRYPYK1lR+4+npfBz
         EDDPAhSuTEDJIP41yJMVbc+eh4BoMvxRIVWWPhSIagq/1JBttBYZLkrqNM4WOnIvGnmX
         p6Z0SrWh2yUviT6hyUvIBPkbU4nerDau/89X+HifNXx1lJ0wb1llorw63yz/4rux99MU
         OH7Q==
X-Gm-Message-State: AFuF++kRNOYZ8Yz/aauWNggyMNq/LPcWjqPa3qzWhnGRbs6M7AJuwMX9
	xCte4bPYG4c3MKUMW3sCMaY1xU1MRKR2o1XrIftVEcXaNmHIfAFhjPRNkKOyuOoX
X-Gm-Gg: AYBFou2jGDDUueAv9ILxZEX3e+LaGGg29masWV3/UnCdqIeHpv1pvkZSbqPs9uYlyix
	Yxhxeje4mRtnqnDDMOtt0Z8A+bJeenyoclvxVKMiSADC1oJarkvooxHu74+DFnaHFnjH9DJ9OIT
	OOI30eTykKC2rQEws8JD3mv73bFrc5txQtfOl3vy/nkrnbCN0HAxxSE3fdXcyfii7rszYQKWCq9
	3HUQfmHssY1eaUNajWxwJTAvbs7YrKhSGMYojtnl7za0h8vELVKu5UG5cwKamnqutbJx4IiYb/0
	UywdPX4weTQcEN7NOGa8xOHw4MqalUdeBvZ0OUcIHpDCIuxP1ffaJvkgR+1URX00qKxmY7VbQh/
	tC9Kh0s/TDMyKVh7Ix/wyAFVsYk9Zo88db4Fjg7T+JSdqFhyr9/r62FuDGMSmhOHWU2/gvuUIFo
	7Yt/ddo1z8W/r05MoQahpObc/oi5Wd/dal3dtCAXudOIOBpJF196Rs64SPOZl2RST2wBdRXPv1I
	yy/3tQhxsQDcM2+AkAkbKik0tbJ9yQ09lpSSVjWqrMG+qt85X5odkwP3UP9En64c3kyUJExhcWS
	lQBaFuLC3d9IjlFHcgQL2LVCeDo=
X-Received: by 2002:a05:6000:260d:b0:482:ea99:6166 with SMTP id ffacd0b85a97d-48587284922mr5465739f8f.7.1788503812044;
        Thu, 03 Sep 2026 23:36:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm1648107f8f.6.2026.09.03.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:51 -0700 (PDT)
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
Subject: [PATCH bpf v1 0/8] Misc bug fixes - part 3
Date: Fri,  4 Sep 2026 08:36:38 +0200
Message-ID: <20260904063650.3877826-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=memxor@gmail.com; h=from:subject; bh=AKY+H99Pt5E0FvPmT6Ql0leYwG9CW+UlTWYIi/NDof4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2sWya0/TtSc8+fzufZuJl8HSawFNl34yX/H8XvQzt D/kzq6vHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIfwXDf5fUY52z3gj3Bl1m 3fTLRVjns2bs5IZHSyJdZdeed6r/XMvIsEwuJ6j7pde6tMDoDXvfn5vmraR4bdVpgwT5KZHblV/ HsAMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas, batched
together again. See commit logs for details. Some of this was caught and
posted by Ning before, but AI raised some concerns, so I'm resolving
those issues and commandeering their patches now.

Kumar Kartikeya Dwivedi (4):
  bpf: Require MEM_PERCPU for percpu kptr stores
  selftests/bpf: Reject non-percpu values in percpu kptr fields
  bpf: Clear NON_OWN_REF after RCU protection ends
  selftests/bpf: Reject graph kptr use after RCU unlock

Ning Ding (4):
  bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
  selftests/bpf: Test borrowed refcount acquisition nullability
  bpf: Reject untrusted allocated-object pointers
  selftests/bpf: Reject refcount acquisition after RCU unlock

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         |  27 +++-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |  59 +++++++
 .../selftests/bpf/progs/rcu_read_lock.c       |   6 +-
 .../selftests/bpf/progs/refcounted_kptr.c     |  61 ++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 148 ++++++++++++++++++
 6 files changed, 296 insertions(+), 9 deletions(-)


base-commit: 254c881fe0554c5efb16d355c273702a27a32a20
-- 
2.53.0

