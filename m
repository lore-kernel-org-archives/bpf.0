Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E812CD8B
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176499; cv=none; b=X3lh30OBcDIMcih2wQtzPUw0t03O8GCBTdA/OQo0u1Bt2x722c622LEHPLnnoc4WOkc9+TnnZRuNtqEWhtCab0u2MaDaR61uTyOTg161ONCKpH7nCRjdo0GSYvT/singIHDhyKtRu5FXvlQZH4Dxwahsglso/N9cqZufE6F9HeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176499; c=relaxed/simple;
	bh=QNAQw2G5uSZMB3UdXk+m7g5P+qou0erbRWKDb0jPHzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq6nmJMhlKuxSxVgf57np9ocR4ouwrFMFpOZMcnW/KQUYBwiekNSFPDQfYVym8Tnm7j9dCiez0LpjL0jbBv0fAMYh2CubURm29z7QiTduRV9+G3nyQSMDIOhVZ38i10Zym3SnREYeX6y+If+AuHTa2QmD0zBgk/GxHOMoY04gG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ74EnTf; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ74EnTf"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651c5d525f6so1317016d50.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176497; x=1778781297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfZjMTowy/oSgRJwl+6XAFdVzDcn17aOTLYndZlTHn4=;
        b=UJ74EnTfO+xkZdI/GqTyYyaytaAggkS2nbfMxvoYb8U8avxYN5nav8tFdcVzeqc/fE
         vlYXWTMKwONdffYVV+1MY1NcagsrEe50LJVucAn3HEXisEZEamx76wR+lO8LKDEorKe0
         PFA5L1myV72j9OkT0YVgkV8HSBeXmVdNtWY4tRrxCQnWJWChOzQUsA6SUy8Dir4HQa0a
         9/vqpNz5EkOhgxNZ/8jKfq9cTXKdY5f6PdpCO/a/KAmxXpl7Q4kPlmUQnuwKhaY9SaQr
         gtHoJvuCAThw5h8I0WLXlXIqjV8imAMrSVFEcec5IuckRBDcB1YHGMk5tiYpTqpOWae3
         PIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176497; x=1778781297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfZjMTowy/oSgRJwl+6XAFdVzDcn17aOTLYndZlTHn4=;
        b=V1BEtBpz/YVoEcNEDWTPf3JkzJ830JO35Kfyg5Kb9ME7OIMxRJATwOpDu345gklwsi
         YIwdhi+wCsMwuLjM4hxDMK5mf+ztZQb4E63b7ShsfLpfChXNaoEKRctsmfA6Rt37vPzR
         DN98VBFyUVTIuFHgaw2eN+F/HYTduK9ZVKUDb/UEFLiDAvJnLzRepDTwy8n86jcQvqLU
         52+O8oJGc/g+Ac5siuUVKpTRUKTjOOnC0j0KDZJhxbXujrMa1WDEyA7sICwm0gsmgW1h
         fbh2E+gjUN3RZbY2Q5T7O56uIdE/xQDir3l6paNWCVFwH7i3c322fsIwOySlWn8JFarx
         cfZg==
X-Forwarded-Encrypted: i=1; AFNElJ9WZKz8Lg/V6HpGkixD6yi10xWvWSxZzBNUz+DKJZDsMwLjxNYG8+iJBqgC6RhweDxu3ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWxHJ5VLquCMzLnwzy72QjdEaHp8oKNGiiZCsEH/GOy1lw/n3
	lFNHu/sYO5veYqU1cgGED46gIfs1ftVjVNedCfM5YrLrjCUZBG1WJIYT
X-Gm-Gg: Acq92OH4imR/9dPZlkVIS/M5cu+531R0zNQ0RTq+6XUyM7XTCEnLCs3MSGV7PJ/gOp+
	Z+a7k2RTSab5gLhfNinkZtiPJVpkButMzGMOn0qIDv8Fv70d5RAqUB7Es9AamMI2j6rObvjW80X
	3PZEYoSAnPSMV0rytO/wsqlSvRbTYn9ppk9AsPfqjSoIdqnhvhkRGUeoGCXp70m1O/FFQl27qNF
	/g+mLbKEQLN/VASAoeMl/dn4C/tPPrnbCL12dPO7knHrxpsQ5LBsgCN97nt0Bf0azpx/5h6kmrd
	zZ63YCV7CsQhHRkDsajcxcU1kB8Z2b/pos9q0ps1FTKphc9HP+4ETBPUm7eGKOmVll015Hf6aY5
	OgHKwLg+DZrPxr02NablAYLuuej/F1wHmDGNDGGm3kr7zx2q8GMjwjT8ONFllDvYvegkd/NhVbv
	vvjhzgP23CheaK+cS7KWtvOyPNKjdoysyAk8VsmmWRUuQxUHQMwrni7+bxLA8zLMsDjeMDPz4wz
	NIS1hInGw==
X-Received: by 2002:a05:690e:b8b:b0:651:e0cd:5877 with SMTP id 956f58d0204a3-65c79c929c0mr9558167d50.18.1778176496532;
        Thu, 07 May 2026 10:54:56 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:491:bfe9:4001:a4da])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d933410e8sm2246d50.1.2026.05.07.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:54:56 -0700 (PDT)
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
	Justin Suess <utilityemal77@gmail.com>
Subject: [bpf-next v3 0/2] bpf: Fix deadlock in kptr dtor in nmi
Date: Thu,  7 May 2026 13:54:51 -0400
Message-ID: <20260507175453.1140400-1-utilityemal77@gmail.com>
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

This is v3 of the series.

Changes since v2:

The previous version of the series used three atomics and had an ABA race
condition. This version of the series moves both the idle and active job
queues to pcpu_freelists, which are designed for the push/pop operations
and better handle NMI.

The number of atomics was reduced from 3 -> 1, using a counter that tracks
only demand, reducing complexity significantly.

See the patch one commit message for the full details on the new surplus
accounting mechanism.

The verifier changes were fixed as well to account for a case found by
Sashiko; because we are now only inlining in the non-dtor case, there
was a bug (introduced by the patch) where an xchg call insn could be
polymorphic with respect to referenced and unreferenced kptrs. This is
fixed with a new verifier check.

Finally, the selftests had some small adjustments. The counters were
moved to u64 atomics from u32 non-atomics to decrease potential test
flakiness. There was a small change on when kern_sync_rcu is called.

1. bpf: Offload kptr destructors that run from NMI
2. selftests/bpf: Add kptr destructor NMI exerciser

Kind regards,
Justin Suess

[1] https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/afYLJAT9brXkWxz2@zenbox/
[3] https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

v2: https://lore.kernel.org/bpf/20260505150851.3090688-1-utilityemal77@gmail.com/
v1: https://lore.kernel.org/bpf/20260428201422.1518903-1-utilityemal77@gmail.com/

Justin Suess (2):
  bpf: Offload kptr destructors that run from NMI
  selftests/bpf: Add kptr destructor NMI exerciser

 include/linux/bpf.h                           |  16 +
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/fixups.c                           |  33 +-
 kernel/bpf/helpers.c                          |  24 +-
 kernel/bpf/syscall.c                          | 159 +++++++
 kernel/bpf/verifier.c                         |  13 +
 .../selftests/bpf/prog_tests/kptr_dtor_nmi.c  | 258 +++++++++++
 .../selftests/bpf/progs/kptr_dtor_nmi.c       | 412 ++++++++++++++++++
 8 files changed, 902 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_dtor_nmi.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_dtor_nmi.c


base-commit: 2ca6723a5f7b68c739dba47b2639e3eaa7884b09
-- 
2.53.0

