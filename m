Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC13C9EF1
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407273; cv=none; b=jYwymhr3ZpViJ0V1duZ4h2uwVewlF3uu1LgXDSqWGySNU4WzgTydKSECk1AjYDEjLKFh9J883XFROEyIXc+QWtkQ+JJ5vYFvUh67zNNJHxz9WbB3CumYf5swFa5C28h93oGo16SClfzQqpZ71oOieLPyS+kvRpYFrEy7YugTcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407273; c=relaxed/simple;
	bh=PTYSt6LTtpDKEjXc+xsG7lbQZ/x9EFgAt7hJkMFeNWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMZXSXj5nZiZyuI1c16LQW7wM63rxSg1sNfd8g2N+W7/SVCIyIB6wsByfmpoHjh4DwJujE7L9bWJOQzKw//pwJQuENsQezTdyH2SEg+t5XJimshRqvqxXI5QVOAkpcDAkA49qME6i+TjMhGOlc5hiOqfSpq/a0L02QyxEA0UVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7JUfFXr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7JUfFXr"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a46260385so137243477b3.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407271; x=1778012071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AB3nH45aYVyYLVUwzuInsRk61sTEKAIQt21hO1sr2kA=;
        b=m7JUfFXraZ1R9XMtoBlxfen7IEdQAvKN11tK83hlj7uPel9CmNaSmP/f0rEbG5JmDA
         0MVC6N11IObqSTMNaRsA1Qr86+4Rsuk67GGJGvsb93dTT1cmWjRnl3HO0rUUBVONSYO0
         o9pLpZGAUzaQ4UzTb16rRKS3eqfPgHDNdzjDsgwKksXGxgyNLcdYF2lbWg1q+7aghasL
         VLzKXVbtKLT6qgDgcj6sLB9gYku3QcU2DrMYS/u7yp1RhzIqGJZ/wbbhmYpq4Z+3gPrZ
         qBhP8/nYvXQgoOPDEbCGSHVZMuJFvd4dWqW2lVyqUudTJovgTHb/q0H/s8VrIdmXr+kt
         0ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407271; x=1778012071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB3nH45aYVyYLVUwzuInsRk61sTEKAIQt21hO1sr2kA=;
        b=copiVf3V9yQjGCWIVqvHu4TWio+5UcBlxaB0yGgbnwMeKAU86b4NOJ2Oc/UMAg5E9h
         NV6hnVm0xF/p/cfU01IpC0FZPsoI71b5GnHormLMtrhE7FkqfoOU++bLmRq922Tz9Flq
         rIe83VjmAf10zmZQ0uJbRBmNaRkClEIHfBwvRj2Cj+F1sTKOtGxSXDHUp3qvBP8LdOEh
         33BsJ1B0bhyou+QE/y7nIMpO+I8FMf3JzAHjicuZdY8mlZtC7hmAr60ChVmFSlzQu66G
         hNvvNaX8miNv1BQNDTN8vOUXUvraffBaBNj9PR9GP4ytTXIA5OJaK8IQ96mtRI7BwEnk
         a8cg==
X-Forwarded-Encrypted: i=1; AFNElJ+EvuHwmhbOvdnAzL3eAp+hyrI8i0CAoSW/vzttBFbJ5nJ7gIvgtJ7KMz0sL117THTzQQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZz9h7QMctwYrZ/Zz8nyos/aQRs/30ie4sUXYgR/2OZ6vYB+2z
	ZuDatxQnv3SL6fLWYGnPzI+6F6m5d2eo4rOBBN9CsUDTgHsSSIsv5nz+
X-Gm-Gg: AeBDiev9dQCI1HEplzSRihQvZAonCqvskgsuPAHauxltjee2wliKZirJluU9b1Ohhad
	pvE0pSrXzdOprG4vRA9ClLhpUdfLBXtoOpwEwMrW30P2hv5Q1D0ofRUeu23fRN7TLs2SEaB6qmz
	62khib237dcCgo9PjQt+qsFXPCS/+i0eKLFj9i7/aWlGTLKfvzlDebKCTwP/CQTx0rvw7JmsfEU
	3153uAwIacjBBm4uS+QnF0mMv2Sf/RMvLAee9KXygR+27tuCIj8v5r4xSESN3rMTKhI2vfVeMsu
	i/ornlM3GltXop+gxSTMwibt59ynVldrW7v2jj5+OPXmzx4eOS7dInVl5TvtzHE6nPJ5G64uJg2
	GqHMJcBQgo67KlG/e9r40p8ftADYnCn5HYVIdBqYKvEzfWSNPWJjvw48/iSq78trFKif8ZGYfHY
	civZUpHbzAWs5ueon6QT1dJBhIUYJLFa2OLJ6sNc10ulnfTp+yjpFXio+je/hr8iDlpO2GIs1Nj
	mAUx9VGRtV+OpY9QlYuyQ==
X-Received: by 2002:a05:690c:660c:b0:7ba:f129:3770 with SMTP id 00721157ae682-7bd1d36f0c7mr12558697b3.5.1777407271132;
        Tue, 28 Apr 2026 13:14:31 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4c60:c627:eabb:73c3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25af5385sm1392077b3.48.2026.04.28.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:14:30 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/4] bpf: Fix NMI deadlock in referenced kptr destructors
Date: Tue, 28 Apr 2026 16:14:18 -0400
Message-ID: <20260428201422.1518903-1-utilityemal77@gmail.com>
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

This series fixes that by deferring referenced kptr destruction out of
NMI context. The core change adds auxiliary per-kptr metadata so NMI-side
teardown can queue pending destructions on a lockless list and schedule
irq_work to drain that list from a safe context.

Because BTF teardown now needs to synchronize that deferred work, the
series first switches final BTF freeing from a plain RCU callback to
rcu_work. There is also a small preparatory cleanup to make
btf_record_equal() compare only the record fields that should participate
in equality checks, which avoids treating the new auxiliary data as part
of the logical record contents.

The last patch adds a selftest based on the reproducer from the report
[2]. It exercises task kptr destruction from NMI context for both array
and htab maps. The deadlock itself is timing-dependent and easier to hit
with CONFIG_RCU_NOCB_CPU, but the test validates that the fixed path
completes without hanging.

I confirmed that under the conditions in the reproducer in [2] that the
kernel will deadlock, and after this series the same reproducer passes
without the kernel complaining.

Kind regards,
Justin Suess

[1] https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

Justin Suess (4):
  bpf: Limit fields used in btf_record_equal comparisons
  bpf: Use rcu_work in BTF teardown
  bpf: Fix deadlock in kptr dtor in nmi
  selftests/bpf: Add kptr nmi deadlock reproducer

 include/linux/bpf.h                           |  69 ++++
 kernel/bpf/arraymap.c                         |  36 ++-
 kernel/bpf/bpf_local_storage.c                |  13 +-
 kernel/bpf/btf.c                              |  22 +-
 kernel/bpf/hashtab.c                          | 181 +++++++++--
 kernel/bpf/syscall.c                          | 210 +++++++++++-
 .../prog_tests/task_kptr_nmi_deadlock_repro.c | 305 ++++++++++++++++++
 .../bpf/progs/task_kptr_nmi_deadlock_repro.c  | 217 +++++++++++++
 8 files changed, 1006 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kptr_nmi_deadlock_repro.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kptr_nmi_deadlock_repro.c


base-commit: 9f5b3ffc3f1dac7204e32eeeff84bc5cc55c393e
-- 
2.53.0

