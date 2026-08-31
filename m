Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C73C9890
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173944; cv=none; b=SGQ75alQ7L75E1UtUzsXfezFSzdEKY9gOe5ex/OfKG585QGJfYc4Z3Y4D2V5GmmbujoKeLftafeXTcvYmcvOQHetbD9+DzXg0obY6She0yZht/1E5BTt80fZ5x/qqlOC6nq3ENp2VwiHpEFgl9oWm66mt+GEseLv35pZdspRlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173944; c=relaxed/simple;
	bh=ihE3IbQjryxAsZoD44/tDnIUtcAmNLPV+p6V9WhATdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J32DIHhnYya9TUcXNtr13muL0C7oYYPqJlmXB4jGmZ6TG+OLONS0dYpJMiQUUITH2ay12mFdIC9jPARlLjmNyZzrSMAZSRScndgPeJ7otQ6J372lg6yQJkUckGIGdc0on35JnLBbqO3isTJFYkI9dC0+PtFFSZUTLaWEMB13SIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr1eXMBm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr1eXMBm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843c41f35bso501096f8f.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173940; x=1788778740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6D44vT98lo4GhN0bPflWOJiXkBCMziJukOHdW6nL4ro=;
        b=lr1eXMBmHceppSgkIYk6ncWF+qaWahe4uXtzC4nKdqyg2csJU+FMvz7IWpAIzBqnX3
         GVGZD+3U2IbPNvQIp3M7fZj0Exmm4jB/CykqL40iTPp9JhEk9pdoqZ73o19/s+Nf0DPg
         QCgbk7xSjhwm37Z70WgNSQAX+QE7JjmukM8PItFDTaK2sfIkYsqTMCUBpaiuu+3SGSWR
         OmnoR+hbUKPyq927/7DG3zJGqE8j9T7OxuyCFlIa+RfU1vLLmt98F/Z6/GIMA/fxpFPi
         OG0ykybTgwqWCtkXT2nKzn8Y1OVSngUwAjagY5D3y8KaWbUCmb2wLoZtJMIFuSrHGh+K
         GUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173940; x=1788778740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6D44vT98lo4GhN0bPflWOJiXkBCMziJukOHdW6nL4ro=;
        b=Dev3D1lQmG8LGjvSiySxs71/96hDR4rH85NTWBsB5zUm75MRGvSHITlFaPxW52JKEH
         ZJdU8mReCKaJ6WCZITvyBhij5GWWjpWQQTx/u7QzRKsq6NIqAPGBoWAnPeHlI90autjR
         8C6nU3XB3EKmZFCqEkTJnH+tMQdlRU9Nsz8EtFCtdwp1OZy6OmpzqEMMsR4xcqi7GElO
         GRw5IXhm51WGjvzhvUVawuUbqGw2E6f35SmodyZcGMW9saLz/btPxvKoaSn04zCFc46z
         1sqQyuxdNtbOOzfymeEws2xoiyktwURyiXAu4z2xkSMZE+pJFf6XP83rKu2Os6il4UGC
         B1Vg==
X-Gm-Message-State: AFuF++np7mNR1jIbLNGlzYbnV29M5rgZH5QCYg9e94PiCxNoEEFua9zN
	/o/ut3T3vbDt2x9OKFX8ypenInMl3YHDRXkVVmNovOtVP4TtPf5hRxSTrdVDOQ==
X-Gm-Gg: AYBFou20jcDGVvaxdNXXydRMJo4NmlRnpnmoMZUjwzAMCDiMgdA2xeKMPigdBbfPvSR
	IrS1Y+48VZT59wUZCgKtRzi82kUrmMTObmbGDCPIzkc7q/22zvLB+oVWFjgStJI32+uNIYx3cFL
	BsQB+0jwCV9gmEpLQpYftigKEDvwldDB14jgmJhEGMSjKTWgQVF+M+xx3aDhOrTUWd7RxaW5AjC
	nNY6abZKdyE0e2uDTmTQUPj/QqMs1mWEOfTb3lMhbgUKs/MSOmQCWAbH+2gtn+Jan+73rSTcEMj
	BazrY5QUbXkIK18E0ZxE9txpBrWYzZ0td29A6IFVBDQHJcqe5gZMT6Ky2w0FEC/OjXj1njq/Yxh
	Vv9m9PAi2PWAdHQ4sITQF9foEL7sSn+KO9Nox2x8DLDTbuELzahbRGAuAiklCOFBYht7gdbdsii
	JVT+Q5NkYgqT4YiuBBjhvJsVb2Lxd/Jo+Eb0+m8AaVovZqs1xbrmlOabT+dwtfQnhNvZQJK1Q7K
	fJwjQ==
X-Received: by 2002:a05:6000:60e:b0:475:da0e:744d with SMTP id ffacd0b85a97d-484397a0a67mr13565071f8f.8.1788173940131;
        Mon, 31 Aug 2026 03:59:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:58:59 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Date: Mon, 31 Aug 2026 11:09:25 +0000
Message-ID: <20260831110934.241898-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF LSM programs are allowed to attach to LSM hooks. This enables
operators to mitigate known bugs without a need to reboot or livepatch
machines.  BPF has shown very useful to create such runtime policies.
However, many APIs and parts of kernel aren't covered by existing LSM
hooks and this would be beneficial to extend the coverage.

To simplify the process of adding new hooks this patch series enables
BPF to attach policy programs to hooks defined outside of the
official LSM list.

One of the reasons to add a new mechanism is that in order to add a
new LSM hook an implementation, at least one in-kernel LSM must be
added, such as SELinux or AppArmor, and BPF is specifically not
considered as a reference implementation [1].  This is, however, not
feasible for the use cases and capabilities covered by BPF LSMs,
which are not directly comparable to those of traditional LSMs.

This series introduces several initial hooks as a starting point for
adding further networking and non-networking hooks. The selection of
these hooks is guided by clusters of CVEs published by the kernel
numbering authority.

The series consists of the following patches:

  Patch 1 adds a new mechanism to add hooks. (It is deliberately
  made as simple as possible.)

  Patch 2 adds a new BPF hook for generic netlink.

  Patch 3 adds new BPF hooks for the ethtool APIs: generic netlink
  family and ioctl.

  The rest of patches add corresponding selftests.

(The series applies to bpf-next. Two net-next-related patches adding
actual hooks are accompanied by BPF selftests, so it looks like
bpf-next also might be the right destination.)

Links:

  [1] Linux Security Module Subsystem Readme,
      https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README.md

Anton Protopopov (7):
  bpf: Allow BPF LSM programs to attach to more hooks
  net, bpf: Add a generic netlink hook on msg_rcv
  net, bpf: Add bpf hooks for ethtool control path
  selftests/bpf: Extract some helpers from tests to the netlink library
  selftests/bpf: Add netdevsim helper library
  selftests/bpf: Add tests for the generic netlink BPF hook
  selftests/bpf: Add tests for BPF ethtool hooks

 MAINTAINERS                                   |   1 +
 include/linux/bpf_lsm.h                       |  14 +
 include/linux/bpf_lsm_hook_defs.h             |  18 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 net/ethtool/cabletest.c                       |   6 +
 net/ethtool/features.c                        |   3 +
 net/ethtool/ioctl.c                           |   5 +
 net/ethtool/module.c                          |   3 +
 net/ethtool/netlink.c                         |  17 +-
 net/ethtool/netlink.h                         |  25 ++
 net/ethtool/rss.c                             |  10 +
 net/ethtool/tsinfo.c                          |  13 +
 net/ethtool/tunnels.c                         |  14 +
 net/netlink/genetlink.c                       |   6 +
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/netdevsim_helpers.c | 176 ++++++++++
 .../testing/selftests/bpf/netdevsim_helpers.h |   9 +
 tools/testing/selftests/bpf/netlink_helpers.c | 176 ++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  12 +
 .../selftests/bpf/prog_tests/ethtool_lsm.c    | 330 ++++++++++++++++++
 .../selftests/bpf/prog_tests/genl_lsm.c       | 242 +++++++++++++
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 160 ++-------
 .../testing/selftests/bpf/progs/ethtool_lsm.c | 168 +++++++++
 tools/testing/selftests/bpf/progs/genl_lsm.c  |  58 +++
 25 files changed, 1345 insertions(+), 125 deletions(-)
 create mode 100644 include/linux/bpf_lsm_hook_defs.h
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/genl_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ethtool_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/genl_lsm.c

-- 
2.43.0

