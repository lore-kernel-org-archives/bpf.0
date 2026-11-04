Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788670;
	b=l/fkgy2+ta443Ia25x8/BaYkXgdEo8LGxxK6euntb+g158uaHOBBbA8wkIUQPGNfhXw3
	 7ik42ioiwlmEbeo4fec1ZCbfv5hIPMiLTtgYuezD+sAAhkyfgY93l+4zFzFxOjwCMF9t+
	 79nlJRkCjkaMt5EQDpR8xjY2+j83y5eiB7o/UExvFldY7SSCT626wqGbFy6faQMDGuv2D
	 6hOpGVGVO18vMiwmyj66Ahc79X63gXCNmMMfA8vD1MbOmwsOphVYmlvaxZYGkk4eBUWQv
	 MspARrqH061XW3e2OICQnLPsB+XH7kL+VSKCHdHIbCNhE86gy1FzConLS0KrlJdLkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1dkLsXb9/bTYDqyZhGVg0eEZjhAqz/Od70PIDf4k4fc=;
	b=IxDzmQIimuj6pQvWVJaZx5/xpj7VhvblubSMVjiHz/Io5kqCcqQWSe66MGg8IcKAKqqm
	 /t4bBE/r4Gy64+Dh1te9YTo7b/CcG1ihlTOEVlE3Qsvl/QYirgDmW2ZV6dUPerVxAXKN5
	 0RcCycOideJRfa+sl/S+SyYCxNhqMCDL77u5E7ZRtcguViGPrkE1pn4JGPdsFhvd+kfYs
	 uODMP3rXxXTJ+Nsp5GcnBGmpknXI3nKp2zPIlqDs0LaVqIOdzHPKq+DI1yj6fKHjr8R4j
	 +vLyY3p3zjyymwSl6FsVD6xVO9BHw3XS7Im8BhlhdJa3AA1V8lRSg4SLgzKcFqtpoBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zn4rPmWa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86055606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 10:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86055606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zn4rPmWa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so5468795e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793788668; x=1794393468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dkLsXb9/bTYDqyZhGVg0eEZjhAqz/Od70PIDf4k4fc=;
        b=zn4rPmWaJ3a++hiLo7Xe3RVBG+PeT0bEuPCVcAY+8QPdo50paPEhhqtYcxONPUreWY
         PTSi5rKZBSU+UfM2I4p6WT3/ITMxuAymkUkGT8IJHI9u77NwNIJdSGO4UiSMOYnsxqBi
         mZ0JHuPeqeYvfugiG1VaiRh49iD5NIzkygnQHSlFf/ZI1ExufTef1Ry/Ps1rgGKgm6AX
         GYnRZI3UrKforOJokHSRElmQp0VRHHU56egQHw/9RXEMu2jN3JbF+9s5GmxZCzV8NTgp
         JiAk7mjeb8DyW6wgDIXKYP3/DMzg5hX8VpUTEn5Z1QV3TT9NY6wZBqtRICzqHkHlBAti
         1G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788668; x=1794393468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dkLsXb9/bTYDqyZhGVg0eEZjhAqz/Od70PIDf4k4fc=;
        b=DbpjfFoMew0uTwEBEZ5XgjxIVg9ivTZ85g3zhDvpHXFdMr1SAvAGWMDGlyCV6q5hR3
         1fXcENqbHdVM9dgJuf1MCl08AVVgzLLkToCWOLf9vT1bc/bK2Uz+qFmc8KAzVJ2MwRYK
         /VKqtONYKzF+vsZLFehxZMYZGz4IO0noZi5WIi0emuq2Cb8vqu2DXGpZk23BZD/1xliK
         ahtuNb4Mm7SZ1bv014QkdN1+CdC1dCUwrOS+NSb1fe7ozhtYYpn52RFWEUcYA7luofxg
         hEcQ4nkmduIPfIVUs0LN7mtyaCgh5xsjbgd4pICWCoEKzWDl1syXBUUf0LKST2NLvgCU
         A4Zw==
X-Forwarded-Encrypted: i=1; AKwUvByPYwriPX/ru44UwfOrJl6byzGkIfWT8sr2tONWLsGs3X4qu7Nj+/IDxCoCwAmfizntzac=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sh4HdL0hCvUCxoFiBURgCrvHPBSdR6r1tkqD4RD1l8TrnW2+j
	vS8HC3R9RdhkIh82+z59OV2zxr7s3+sNkJ1QmwKfUkywFeIhNPkSmA03
X-Gm-Gg: AYBFou22wSIlPqOIKexLJNa5vBoJRZKa13OG06F1Vx5M8fvbSvSDRpdJqt/XVBCvuPi
	DWKyE06zz1NGFZ0MrQrBhN9/f85Ncg9GeQHTgsHXZudq7IXyHh+4Wvka8W9SPrTz+mffrml8hM4
	MpP5u25PL/wVutc3qZXlldiHLDGal+11z7GNDoizx7HjKd1xLfNx5zD3ZVW4z3PyM6r5JSWQ8xZ
	r8mQ5/Bn6pxA9AXSOm/uX9L2VqFbFQYVhDPno5TGESsyztzbBa9T/RWCO4TGNms1qxuwj9f9fpU
	6yIYIxHPPcWAcWUTv8Kuxqhp57EWFS4nhFRLtTconu+yE3dM+RhBMxNRPYNpSJSpeu1TVnMzNay
	nWhJF9meF1gVQDm4Y0/msaPFwkLj7uzy1xtAfFTVYUFnVkz9yL5e7QXQ1oZnhRc5SNvB6WGqNC9
	Tc3FOa3EgXDh8myi66mmYE6xXWwcsjix6fQ/fxRpnoPInBI/3yZ1NgE6ovmYB0PBUOnmg15VzsA
	9BQ7NKGOxzgvPzViCfaxnmyv45BvJLXXHI4dh+tbLVT+dZsEMyW/SbTMgNg6hliXilWKd1450A0
	M8XAs5LQ4khKJUdmEK+iGXZYYLLm4bYwTKG5BXVHLvBspK7LcnxhfYpMUKOlprVc5uTVI+En3a9
	KJPojViLwMQj3/9FJzTscqQ==
X-Received: by 2002:a05:600c:698d:b0:4a2:994:575c with SMTP id 5b1f17b1804b1-4ac185bcc4emr358335545e9.34.1793788667829;
        Wed, 04 Nov 2026 02:37:47 -0800 (PST)
Received: from andreayoga.wind3.hub ([151.76.4.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b40ff10f88sm36342995e9.0.2026.11.04.02.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:37:47 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Rodrigo Campos <rodrigo@kinvolk.io>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Sargun Dhillon <sargun@sargun.me>,
	Hui Peng <benquike@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Cong Wang <cwang@multikernel.io>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/4] seccomp: fix user-notification state transitions
Date: Wed,  4 Nov 2026 11:37:30 +0100
Message-ID: <20261104103736.71956-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An atomic SECCOMP_IOCTL_NOTIF_ADDFD request moves a notification from
SENT to REPLIED, so the listener stops reporting EPOLLOUT for it.  Two
paths move it back to SENT without waking poll waiters, so a supervisor
waiting for EPOLLOUT, with edge- or level-triggered epoll, poll() or
select(), can remain asleep, leaving the target blocked in the trapped
syscall.

Patch 1 fixes the failed descriptor install, present since commit
0ae71c7720e3a ("seccomp: Support atomic "addfd + send reply"").  Patch 2
fixes the restore on signal interruption, added by
commit 832b9b176be06 ("seccomp: restore knotif->state when
SECCOMP_ADDFD_FLAG_SEND is interrupted").  Patch 3 moves the state change
and the wakeup into one helper, with no functional change.

SECCOMP_IOCTL_NOTIF_RECV marks a notification SENT before copying it to
userspace.  Unless SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV is also set, a
signal during the copy makes the target return EINTR, even with
SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV, while the supervisor can receive
a withdrawn ID.  With it, the signal is held back as if the notification
had already been received.  Patch 4 adds a RECEIVING state and marks the
notification SENT only after the copy.

Patch 4 affects all filters, not only those using RESTART_BEFORE_RECV:
RECV now fails with ENOENT if the target withdraws the notification during
the copy.  It clears the buffer first, and
Documentation/userspace-api/seccomp_filter.rst already asks supervisors to
retry on ENOENT.

All four patches concern transitions into SENT; patch 4 takes its
post-copy transition through the helper added by patch 3.

Tested in vng on x86_64 with the full seccomp_bpf suite, using the seccomp
selftest config plus CHECKPOINT_RESTORE: 146 passed, 0 failed, 0 skipped.
Reverting the kernel/seccomp.c changes of the whole series makes
user_notification_addfd_rlimit and user_notification_addfd_send_interrupted
time out on their second epoll_wait() and all four during_receive variants
fail; reverting only those of patch 4 makes just the during_receive
variants fail.

The bugs were found and the patches were written with the help of an LLM.

---
Reviewer notes: 832b9b176be06 and f7952251ecc3, fixed by patches 2 and 4,
are in v7.4-rc1.  Patches 3 and 4 only need backporting to 7.4.x:
f7952251ecc3 adds a new flag that is not tagged for stable itself,
unlike 832b9b176be06, and patch 3 is tagged only because patch 4 needs
it.

Patches 1 and 2 do not depend on patches 3 and 4 and can be applied
first.

The series conflicts with Cong Wang's RFC "seccomp: report the result of
continued system calls" [1], which is based on v7.3.  After patch 4, a
task killed while its held notification is being received is in
RECEIVING, so the "killed unseen" check in seccomp_hold_result() would
need to become n.state <= SECCOMP_NOTIFY_RECEIVING for the result to
still be queued.

[1] https://lore.kernel.org/all/20261020001124.974063-1-xiyou.wangcong@gmail.com/

Andrea Parri (4):
  seccomp: wake poll waiters after failed addfd send
  seccomp: wake poll waiters after interrupted addfd send
  seccomp: add a helper to move a notification to SENT
  seccomp: publish user notifications after copying them to userspace

 kernel/seccomp.c                              |  79 +++++----
 tools/testing/selftests/seccomp/config        |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 +++++++++++++++++-
 3 files changed, 204 insertions(+), 38 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

