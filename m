Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D09384235
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315640; cv=none; b=KJqnVT6DO19Ssu2vs3QsQnpxsqFGg14/7ZQ+IW/tvkZ38E4KAv4I+hIWMPXKvgysexMeBGdpspGaaYNmHkzsUQwE0QdmXB/uOpgGLQJlMwz8spmrvK7qhi1MluQaKuKSpruzxD+u6c9wR3+gqcvhsKcQLV80YivCz7z4Vo0uQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315640; c=relaxed/simple;
	bh=Bav59aMnY/AAGrYJbnVTrHSS0Gv5MMu96bpay/is0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNZHGd6hNENLy2GKgUrdgevc7N2BdoS4Lh0zPq7bSKMbKP201YRykcl14ZNDGJz1wPWGAj3ddjuG3muQgxSwBLtd57urBf8JThmmsB1WGX1bpGA4X16nQtnRACchZIwq8kR4JCkc09Vs1VeoDZLj3A3jelt1sLHlJLz+N5yUlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS0gwkvE; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS0gwkvE"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so5485365e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315637; x=1784920437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhcBKr3KKSv1VpEyWF2pz+FyXEXKWi11Sru8AI0VzcA=;
        b=CS0gwkvEarhasThZ/wF/TVTa1UDmWP2EgelLrsJ9AJALbpJcRNbyJUEQQckYrpocvm
         /LJmfjefFwXBGaAUQmQBoK4ZBS/IfNF5ZXprk3F8396WhnPX4UV3ldb5y9BOy4YmW50n
         WkzDrWfcCQwePj5KZT0QMXwBB5zZWh7RW9vWUOuCN8hWVntASX2k0d7xd8f6VttbqT7k
         YaH9W4DOWCc4YWpRln0qtMT88uugmnmi1SOSoU2/JFb6QfLbD6jpRkYvdXxEwYrkvHJ3
         RZR4Fg2rMc2sT0Uh/GiQhfKhVKF2+K3bcmKpVS6/n0CFUeYWLBgAnW+PaOLa02Gb0GB+
         3rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315637; x=1784920437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhcBKr3KKSv1VpEyWF2pz+FyXEXKWi11Sru8AI0VzcA=;
        b=UKBJBdu7ZO2mvV5Z1emxlJJI5BR3hFIi93cGcHfRNtY8RX6M/j8nTdxA7GnuD3XEKZ
         J3WZvKo2/n74H4K3st5/GuYQbA+ebRLY23AwK7f8foSP1VfGXA/lxhVWZA5mYJYnsOqE
         +4P8GOZpPE8UmNPfRyXsKPM/XnqK1rx0UfRJAP7slUZalKSNogJMab0/NJrmer/t3k/z
         wJH9LspTl74oz7HLOd/8oHQTKM0urG2Vv0fB5+R8lgyM1QMEuPeTB9wAzB1pjYTEi9TX
         KRAz9K/6hki0nh4Fgt60mz0+wVQmBUFzXLamjSmdP7HqWc7ksa+9XxTVzDySPUagLpY+
         FI6w==
X-Gm-Message-State: AOJu0Yw/8cc4//sJMq/NiNeq/GH1tZNUw/bzuBuQ4o/FPh6lxpvVuIvC
	2M3k+7+5BcQ3XUdIZzbI6Bp6m53icrV+VPITp1RfGt5sKxXUWz5YZj4v
X-Gm-Gg: AfdE7ckLFma44hM5Bd8aqV3p+WVypVt1SNQUewkaOlDWxSxoM7m1q8csVIV1uYBdcaG
	6oDVt1siFZcqcMeHee1IhW82aygHMLzHSpq/QumpbEWg/MqbvpH6OCpxzogoJByTgSIA83n8q4Z
	xTo9ZKM33o7OHKzZLK7qQDGRfwqgwS1OM4mSi/tYhI1fFiXJh4uC7ScFrfilfUPV69Sbrr7VcLT
	PPkhGEoTVQ7xbFkjuPPpvupRtJ0RSYkyjKz+TYzDP5IyMpAr4sPVXxOkyBdpuOJVewERonbk54u
	XFYjkavILz5A8pxZ6e6/5kF2rF/5wSVBalx7TxOMrbomADjmoDWKIOSj28WIOWKdhlMpVd9IdwA
	C6RR+zkofZmAU6FGrGZlbsu6jUIvkNGRwU8tR9MgHAvUckRZ53lQ4eb5kTlE5kwRe2ZTPmoZaG1
	5og1462FuFPPuKyeLgMfN+xbvuixoTRir4WUMw3b4X9IeH7m03ePiLPz46347pMgbj0pO3gRZa3
	ihfyEMwMNMQItvGprZ+PRhJb9eaazUdEGEamy+pQjDD
X-Received: by 2002:a05:600c:a42:b0:493:eed4:7210 with SMTP id 5b1f17b1804b1-4954a3ef700mr43223095e9.11.1784315637234;
        Fri, 17 Jul 2026 12:13:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm32837235e9.1.2026.07.17.12.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:13:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.2-rc4
Date: Fri, 17 Jul 2026 21:13:56 +0200
Message-ID: <20260717191356.3513879-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 2c7c88a412aa6d09cd04b414211b4ef8553b5309:

  Merge tag 'net-7.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-09 08:26:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 3d84d674e3a5a33ce5eaa14b92bc839c3821a348:

  Merge branch 'bpf-fix-tracing-of-kfuncs-with-implicit-args' (2026-07-16 16:11:30 -0700)

----------------------------------------------------------------
BPF fixes:

- Fix a UAF in socket clone early bailout paths (Matt Bobrowski)

- Reject unhashed UDP sockets on sockmap update to prevent refcount leaks
  (Michal Luczaj)

- Account for receive queue data in FIONREAD on sockmap sockets without a
  verdict program (Mattia Meleleo)

- Reject negative constant offsets for verifier buffer pointers (Sun Jian)

- Fix for tracing of kfuncs with implicit arguments (Ihor Solodrai)

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
----------------------------------------------------------------
Eduard Zingerman (2):
      Merge branch 'bpf-reject-negative-const-offsets-for-buffer-pointers'
      Merge branch 'bpf-fix-tracing-of-kfuncs-with-implicit-args'

Ihor Solodrai (1):
      bpf: Fix tracing of kfuncs with implicit args

Kumar Kartikeya Dwivedi (3):
      Merge branch 'bpf-sockmap-fix-sockmap-leaking-udp-socks'
      Merge branch 'bpf-sockmap-fix-fionread-for-sockets-without-a-verdict-program'
      selftests/bpf: Cover tracing implicit kfunc args

Matt Bobrowski (1):
      bpf: Fix UAF in sock clone early bailouts

Mattia Meleleo (2):
      bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
      selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program

Michal Luczaj (4):
      selftests/bpf: Ensure UDP sockets are bound
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

Sun Jian (2):
      bpf: Reject negative const offsets for buffer pointers
      selftests/bpf: Cover negative buffer pointer offsets

 include/linux/btf.h                                                         |  1 +
 include/linux/skmsg.h                                                       | 14 -----------
 kernel/bpf/btf.c                                                            | 29 +++++++++++++++++++++++
 kernel/bpf/verifier.c                                                       | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 net/core/bpf_sk_storage.c                                                   |  2 --
 net/core/sock.c                                                             |  3 +++
 net/core/sock_map.c                                                         |  2 ++
 net/ipv4/tcp_bpf.c                                                          | 17 +++++++++++++-
 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c        | 36 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_bad_access.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c | 43 ----------------------------------
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c                      | 45 ++++++++++++++++++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c                     | 21 +++++++++--------
 tools/testing/selftests/bpf/prog_tests/verifier.c                           |  2 ++
 tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c             | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_ptr_to_buf.c                     | 27 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c                | 16 +++++++++++++
 tools/testing/selftests/bpf/test_maps.c                                     | 13 +++++------
 18 files changed, 397 insertions(+), 105 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_bad_access.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ptr_to_buf.c
