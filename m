Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6D27E1A1;
	Fri, 23 Jan 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186778; cv=none; b=Yy/ApeRxM2zwH/J4JSGLwu9LqI9OHmwXo6iutVbRqD9+XxXxDfGiPnExPjRVRevl4dbdU/m+a9T0ALc/ZV9Fq1jn4Sz6ILShTxCX3p23rGc48evoHg3LwQObF+9IxOW7XFOJpN9KgIcnDAsRErh9Gx9axwq0+inUIcGkuUXTZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186778; c=relaxed/simple;
	bh=D7DusSg+3EYEoYl8YZ/nmXMV4mfCLjzUHKuknJDik3c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDJSTNtmbRSbaI8kf020jfX1zXOyeQgWQqDPqV3lA4rHt2edut8A2fPT72O3qh4MKK2IoheEDfU+3whMmY50+MZpDoFuzSDbPSRAelOTTxYkKcutrrxzIXDDWgGP6Ka+mns2RxpDFFHV8aTfCuMfXYPuOf11dFQZXqJY4Y+Yw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EGhALqbr; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EGhALqbr"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpa-00EzLa-Rf; Fri, 23 Jan 2026 17:16:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=KTh/XQK6cSGpMVHzOHKzAUaChbS+xeNpF2Eln8ERsow=
	; b=EGhALqbrRy0xf+5Ito8zekOUXZxMPS1gHIfhMPlakvDiZtSqowqyp5WQqON1jLimF6PZbCp3v
	COIQrCiT4Rn7p5dOxDryQkrU2wsQ98hqmIT8XBl+gcKK5GuNwNNSUzKSN7ObiX7anu6rSH3py9X9H
	Uxf0uMJlufBqa2acpcVqBD+oBo8b+hoGqziBu9deed+/jJ6EmFqykEtssKFYcxYyscyr2bgUUlNRt
	4Z3aYrX59SQNdtPtai0aZAbr0GsCARM11NMpE7pMvovPk7WXlKk55eZYwbGcRBpdrh2ZghMBtpAPQ
	6uiF+1R93/RltVV2oZUZuxwdKoAAgR/BLb0T9w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpa-0002em-GV; Fri, 23 Jan 2026 17:16:18 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjJpK-003pZ3-0o; Fri, 23 Jan 2026 17:16:02 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next 0/2] selftests/bpf: signal-on-connect() vs sockmap
 update
Date: Fri, 23 Jan 2026 17:15:55 +0100
Message-Id: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnBewlY25Xxk7aExcQFJpigjiv
 1s8vss7wDkrO3yaAzJv6pqsIjwaoP9gM6NO1RDb+AwhvtB5kcJe0HW2YcFkSMmMqaBMUUbpujf
 1BDVYM4vud/6FcRU03gv8zvMCpRuhdXYAAAA=
X-Change-ID: 20251126-selftest-signal-on-connect-fd2fbf338c9c
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Race connect() against sockmap update, while delivering signal. Do it for
different socket families and see what happens.

This is a long-due follow-up to [1], where John Fastabend asked for a more
generic and CI-fitting version of the selftest. Then, more recently in [2]
we've dealt with a af_vsock issue and circled back to the selftest.

Currently selftest exercises only {BPF_MAP_TYPE_SOCKMAP} x {AF_UNIX,
AF_VSOCK}. After reverting commit 002541ef650b ("vsock: Ignore
signal/timeout on connect() if already established") test, as expected,
triggers:

WARNING: net/vmw_vsock/vsock_bpf.c:90 at vsock_bpf_recvmsg+0x530/0x5a0, CPU#15: test_progs/1487
RIP: 0010:vsock_bpf_recvmsg+0x530/0x5a0
Call Trace:
 sock_recvmsg+0xbc/0xc0
 __sys_recvfrom+0xb0/0x140
 __x64_sys_recvfrom+0x20/0x30
 do_syscall_64+0x95/0x510
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Following John's suggestion, I've added support for other protocols.
Torturing af_unix leads to a known null-ptr-deref discussed in [3]:

BUG: kernel NULL pointer dereference, address: 0000000000000080
RIP: 0010:unix_stream_bpf_update_proto+0x9c/0x1c0
Call Trace:
 sock_map_link+0x564/0x8b0
 sock_hash_update_common+0x6b/0x3c0
 sock_map_update_elem_sys+0xd0/0x200
 map_update_elem+0x235/0x570
 __sys_bpf+0x150a/0x27e0
 __x64_sys_bpf+0x1d/0x30
 do_syscall_64+0x95/0x510
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

[1]: https://lore.kernel.org/netdev/20250311155601.eui5j2lta3q46i6u@gmail.com/
[2]: https://lore.kernel.org/netdev/pstj7youxwwrpj3bl2a76kh2t62by2vdakv5elqvueobw3o4pj@tnknzlqdt344/
[3]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      selftests/bpf: Add xpthread_cancel() to sockmap_helpers
      selftests/bpf: Add test for connect() racing sockmap update and signal

 .../selftests/bpf/prog_tests/sockmap_helpers.h     |   9 +
 .../bpf/prog_tests/sockmap_interrupted_connect.c   | 200 +++++++++++++++++++++
 2 files changed, 209 insertions(+)
---
base-commit: b015ba089d6bacacefd9daa247f8862795ba0467
change-id: 20251126-selftest-signal-on-connect-fd2fbf338c9c

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>

