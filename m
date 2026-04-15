Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A291DE894
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213025; cv=none; b=Y19czULmR5RyyaYnIsrlApL7AEWzMAWnkWJ5u96PQ/Tg3oZfqO4zqqKO0jksnTyHDmmqNCdMQKEJmIgzjqLIlkwjU5kATY57CZE55XKf2udsOyKCRORtbZGQqlFNww8cTt5obqRPMsl+JLP+NEDrJ9J5TFj+CXhsToGoWvZwcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213025; c=relaxed/simple;
	bh=71BkGzywyHGSdnulblu4uAkXM6xsoxZaPBjMX5uYO2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVTTDh8sVC1OfW6Vu1pvlHMxWIWI+ibFBV9lMNb1Qw0xh5GI4XatFLZC+K8DZYABuOmp0Ufd7zr1mKhux5V4W9n0nqFJSCLfekP7+XGYO6dA2NL4vgWZrYb11xZ/ElTctaT7K8vJJqv4CPtvgBNbpJR9WKabL1QA8B6gQ/5GKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRC6YHKq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRC6YHKq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso1444203eec.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776213024; x=1776817824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4NO8OW5mSnDPuUW+y9hkBF4Lo7uRFc/tbYLE32Zz+4=;
        b=dRC6YHKq7kspmktS50E7XdaUQm/VpWcLedTIIU9Hqxkgy+J1RuFhFzhpLEDmyk1aC6
         QDcaLmEGhTHcb1xisQ9WcsiJMqJLRC/GcSREVV4AYs8PJ87tM4Ve1cUPtVpd8MCZ3Zu5
         Ry5+gSFDgi4r5/KhTpUT6dTi+OfOLPqg/jH4lJ/f65csuYn/c4Cc8PDjOhAn6IoI4sCU
         nPaqo0txttr6dD326aQEMnQrny8Nl0kX4+HnBV5rup+A+HkDtGPVN9a37wXoQDSPtDoh
         4URePklyXXA0qGBy/epJ5FqJBpsPdKOXvGDb65tNbbUaPoBO8csYF98h3yEVm+R2rQzW
         bHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776213024; x=1776817824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4NO8OW5mSnDPuUW+y9hkBF4Lo7uRFc/tbYLE32Zz+4=;
        b=GuNs163Q2NHbKBDtpc/rvT7uKOKbIgTYygSbnQZorLg4UdRGiWgv6qdC/XWM9pERrv
         yb2gms2aZSo1wfOKrtr17bsmFNLh0ve2sCmmGiQnMAAQrHtX3SO1VzwevoHiXneDXiPs
         b9ZH7d9cenDamU26+66rzGvZp/QD90WE4SI0OvtgDylyvXidT/Y7BTgpZ26HHoDgDuUd
         jeo2Rq/+xlPRNZRTXorlyHOZwJNc5TX3x9H9JRCrObnGojWFRXNUhvqfG0voiTT0yjPu
         FlwUYL6qSqnzLkjzEHBDijXISBvx7v96+VIFOUdriiMv9Gar48glzw+K1WpHgupbSjM5
         D/bw==
X-Gm-Message-State: AOJu0YwF9dg1kLNX3mzUklg7v/sgwiQOiz1mGG7+cPufvDorBBH1JNC9
	5QndeZwUlhsJ/TB850ey7Z2XyXXEq7IpEO3PfnoAn3UJqv4s7yX0KGyVu/um2ceU
X-Gm-Gg: AeBDiesgYCnP8ClT3PmiuUKxR0eIEijBYSQMHhm1N5jQLE9Lal3h9BL30Qb8Jm/HZF+
	lJCd5JHoDpO3VWVW3L9mq+pLij1ldbg8JHiorJLMkyQyluflQ0aXaNQAKqvYvrAGmmnE09EA4F/
	1gQo+LW2vLo1WG7nahhTrypS40tSumqjCMflztfQqWmqFRE/qlGzwjOS1CyyDEiuMml4vS2Ehzd
	YBWiDDKJxsQUzACx1GSC1X324VFby9kbu/kVQ3VYxcnkyqQ3FFyVarKVOjfubDqDXGTph6Nee6q
	DE+CFZanhC6UUwCae5o73+asHq73T6qf2nc31JYMTzojMMC0rBEEIZGwqe82DuGx/Jangg9+WVt
	X/n+o43TFFgyszNzSWlMyek8Cw1tp6Zv6rNh6SS1Jqm4sgpV279lfCJ/LjKKksnFUYGRgEzk+pz
	IuuksGo0j0/Re8Pj5iUod+Lm1evNZJnKoijWMvlPgI2aDWnbb75qfAGGWOePPezdqDL5IXNxN/H
	1zy
X-Received: by 2002:a05:7300:2d05:b0:2d8:4dee:6ad0 with SMTP id 5a478bee46e88-2d84dee722fmr5298906eec.16.1776213023512;
        Tue, 14 Apr 2026 17:30:23 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm299140eec.18.2026.04.14.17.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:30:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v2 0/2] bpf: copy BPF token from main program to subprograms
Date: Tue, 14 Apr 2026 17:30:11 -0700
Message-ID: <20260414-subprog-token-fix-v2-0-59146c31f6f1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260414-subprog-token-fix-96c29ffa7e12
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() omits aux->token when it creates a struct
bpf_prog_aux instances for a subprograms.
This means that for programs loaded via BPF token (i.e., from a
non-init user namespace), subprograms fail the bpf_token_capable()
check in bpf_prog_kallsyms_add() and don't appear in /proc/kallsyms.
Which in-turn makes it impossible to freplace such subprograms.

Changelog:
v1 -> v2:
- target bpf-next tree (fixups.c) instead of bpf tree (verifier.c).

v1: https://lore.kernel.org/bpf/20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com/T/
---
Eduard Zingerman (2):
      bpf: copy BPF token from main program to subprograms
      selftests/bpf: verify kallsyms entries for token-loaded subprograms

 kernel/bpf/fixups.c                                |  1 +
 tools/testing/selftests/bpf/Makefile               |  1 +
 tools/testing/selftests/bpf/prog_tests/token.c     | 81 +++++++++++++++++++++-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 21 +-----
 tools/testing/selftests/bpf/progs/token_kallsyms.c | 19 +++++
 tools/testing/selftests/bpf/sysctl_helpers.c       | 26 +++++++
 tools/testing/selftests/bpf/sysctl_helpers.h       |  7 ++
 7 files changed, 134 insertions(+), 22 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260414-subprog-token-fix-96c29ffa7e12
