Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F193481641
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993741; cv=none; b=JqkHy2Odd4KD0lsctUL7cKUaSruud5o7jqzTyNOcEyfcffc/yRisjlqr2MMFjEg0AHZYpOrTg/6aAD7g5t3YkJI9GpRsfsRZnZcx3dFitHdaq3BTUtLMQcabUGnXyzyumxxBWQv2908klCagWe6oTe8GpWbqbw2k0vs4FNbnb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993741; c=relaxed/simple;
	bh=ZC53DySwaxNxos0KBspofY8J0bMlu7Ke+z7JIev3reI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUD1gq3j5f4HqZ2RNZrjHhNrD5UJNiV1ALEtPy+y+Om7HOlN5lpYe+AQsVozPIXofVV3+KjlnWcOkUBR7oC7DXjRjHSQuoYd6UlGxpfonpQc/MBI09zcpB9JnijIjxxsTQHXyVAbnDdx5j+tHwxmliEXq+qeZMsvn0EP02zEhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5hFn7ME; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5hFn7ME"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7991db3dc98so56789557b3.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993740; x=1778598540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxDQRgSzgD4cT5D6+LrkYNQC6yKdhWlfrWk5j0mdxGc=;
        b=i5hFn7MEbOravMYt+FykyYZEKPeKCePD13Y35QSnalf2uywpeMNs0UkC/wc5pNeb6A
         ve8TuIFGIscms3GxAtBZwcWqgNE96dvQXP+T+2yC2Y4EQ3UGw7QdNzSANRjl76qgwj6N
         +RIfJROjIa34dBZXyEvTn94NpuG9iheksXzHKLpgnwWbIduujzfjipe5ZnsnrQuPlqOv
         qlU9l6BI4vWzENGYb+4+URqBLqvylroMhXKcDv/ggophoP65tZDXewBMJR4CGoEG4uYL
         hnz3PiAeXbuKioDl19itYai4NWyXeC5PQtnboXrgBf9qG3wVTCkMtYIbTUsUwjP4Miip
         HqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993740; x=1778598540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxDQRgSzgD4cT5D6+LrkYNQC6yKdhWlfrWk5j0mdxGc=;
        b=L2K3gBc2GEPKsfQvqjRXTwIB8gYyV7stz1X2G6BpPe/wOuTJhFuFQOxThkY/pfkOd+
         dGxsx9cH7n+3QaKUIWYJuptH0k0D+ofybaBYjXV3sLyj7r/2YNPAJM/cVd97ss0olmIB
         BS+xJn055HoGWVKiIkEk3mO2xGrXFlvX6x8M3fQ6DXO4ciVfcv21BRlTv3En7tjt/fAM
         QT+If/W2USm3xIBRS6WQ31Xx7R1BJejAanAPDFNceHH4b9Xfm61FcUVfbfJQ9xZG46dV
         HYfVLaiLABeVgkrGJmbHNfxB6KbC9zZvLxe0wJWY3qzk3TqA5hIftph1hfl2PZl9Tkzi
         bsNw==
X-Forwarded-Encrypted: i=1; AFNElJ+W6griLdM8PrPBXba5mGQlcvpDsK4n0z4BMpizmybgIecqiAWVsyIdfXWpxd9F0+WRZSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfKdaL6C2Nw4fAPzLH+9XAUA1bKq+UquCsKYGNlZ2z6CJ1m+T
	2/TVqonFN30oUGDV3SVG+HDFhKxW9uHGgZXW3XB/AxDIc7OmPnjmmM9y
X-Gm-Gg: AeBDietM5Q4StJ/suawxqiYdYwGJejtQ89XUUTgXFpQS+EwxdYfHSjwvrxHXUWO5ZnL
	2R1V7y/EthwLsUmCb65+CZgifwxG43yeZz13DOHdg66GFtAsQ7VvwehRKADKAJlqfeni5RLbs5b
	Zc6qaOhs+n0y+4aEelqLMb8/rzkUQmQYa30bmOFFlsIw8BU0if7U3rF5wSXXRH8AWi7rsj9Q3zz
	IYiR/2ej6ZUY6mTWH9HLHkpziBY1uAb+lLQBxUIkLIGlC4JMt2T6dfTQsBiYbmcRve4HgQuJFQF
	SRJ70zykdX61LMp7g5wol5NF1R729TbYWb0Q+KViaL5SLBr8XrMvMIeuZWdUovJe2iCKgC+Y17Q
	AsnyU1LpboISNDqRQWFWNttdWU9Wmk6CVXpzt9440ngVF28leUw6ZnaczlrdrfiyjiFpyz0954z
	YrFedAEGuUUo68cGMpPWgH3pujib5gwZclgzuG5wpQPzisRo278bwZYrcl8t0E9cKo+ALc2zUfL
	GIXfhEd33c=
X-Received: by 2002:a05:690c:260f:b0:7bd:6129:f255 with SMTP id 00721157ae682-7bd76f7e251mr159851227b3.4.1777993739588;
        Tue, 05 May 2026 08:08:59 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:2fd9:17ad:6991:cb6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6688d16fsm65061117b3.42.2026.05.05.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:08:59 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [bpf-next v2 0/2] bpf: Fix deadlock in kptr dtor in nmi
Date: Tue,  5 May 2026 11:08:49 -0400
Message-ID: <20260505150851.3090688-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While following up on a Sashiko report [1], I found that referenced kptr
destructors can run from NMI context. One way to trigger this is from a
tracing program attached to tp_btf/nmi_handler while a map element is
being torn down.

That is problematic because referenced kptr destructor paths are not
universally NMI-safe. In particular, they may rely on operations such as
call_rcu(), which can deadlock when reached from NMI context.

This is v2 of the series. The approach from v1 was effectively discarded:
instead of teaching the broader teardown path about deferred destruction,
this revision fixes the problem at the referenced-kptr exchange and
teardown points directly.

This revision is also different from the problematic solution I proposed
in [2]. The freelist hijacking approach was too brittle and touched
allocator internals in an unsafe way.

This revision uses a global (percpu) irq work queue and llist.

The core change is to offload destructor execution that originates from
NMI context. It preallocates offload jobs from the global BPF memory
allocator, tracks the number of live destructor-backed references so the
pool stays ahead of NMI frees, and runs the actual destructor from
irq_work after NMI exits. Non-destructor kptr exchanges keep the fast
path, while referenced kptr exchanges pay the extra bookkeeping needed to
guarantee that teardown can be deferred safely.

The second patch adds a dedicated selftest based on the reproducer from
the report [3]. This utilizes the cpumask bpf kptr instead, to simplify
the test harness. It exercises both hash and array map cases by creating
cpumask kptrs and dropping them from an NMI handler, then verifies that
objects queued from NMI do get their destructors run.

1. bpf: Offload kptr destructors that run from NMI
2. selftests/bpf: Add kptr destructor NMI exerciser

Kind regards,
Justin Suess

[1] https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/afYLJAT9brXkWxz2@zenbox/
[3] https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

Justin Suess (2):
  bpf: Offload kptr destructors that run from NMI
  selftests/bpf: Add kptr destructor NMI exerciser

 include/linux/bpf.h                           |  16 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/fixups.c                           |  33 +-
 kernel/bpf/helpers.c                          |  24 +-
 kernel/bpf/syscall.c                          | 181 ++++++++
 kernel/bpf/verifier.c                         |   2 +
 .../selftests/bpf/prog_tests/kptr_dtor_nmi.c  | 259 +++++++++++
 .../selftests/bpf/progs/kptr_dtor_nmi.c       | 414 ++++++++++++++++++
 8 files changed, 915 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c


base-commit: 2ca6723a5f7b68c739dba47b2639e3eaa7884b09
-- 
2.53.0

