Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342227;
	b=zXMVU7h1z5F4X1R+MG3TsBhPGOPnkFFKuWJvz2Z2Qq0Oby5XYw9Pwpm1UOCvU8GcYDGq
	 x/Esf04WxY3lx/YrvC/rxBjOdiCLZx0OzGNY78KasIi9i2TIP9p5ZvYbWazs+xNIXrb5L
	 L4Bm0lDXc3H6iowL2O2hru/RCSa8Hibk0bX7MSjUkF/0GpgXoY/uLkhvdr6iwOgfPGvsF
	 Lvb70W8gUkYB41gChUhJMkJK2DrLMj9ym98gLKnwpWV44Na1u0Y/ztqsNTjQpS9U5J97q
	 ebHJm+/mqt8TCmjOwFZkqN3gBl9DsT7j/TvUi3MAKPZqbN/u1/vynfsqOlNbrmtbx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342227;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GRCGW6zun9XgkQRQsjo432+p58mI3EkOvS36OEwLx2k=;
	b=ZM98/l7ylN+KI7436uTqAlR9SmKtZE0CfUyVRkMkgg9feNucedtRbwJOZe2eHxuKd036
	 KT4bVbwFnj4KZv6IvXJwr2qLcpAkW8L7WjvTIEQH7ucBgELcbvhPq99+dnWTmE6ZsIOe9
	 XmDohOTABAE8txK3OMrIum5+p1uofbTxZgd9NJHAxMcTTRWAsWiQMZaNyOURfcMteJ65G
	 2d2fLu+sIueVAOPGV+A9iSwxd/Aim/g4JVMEgJIgRYsqPlKkEAhBb5Gf38gKUOW9Si2Zg
	 cJyuHHgeegczrEOOObpkvTjlswZFUTuBjP4LSNozV6auS7/Rknkn4nANSEK/a1NUbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6I9tjMJv;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45301606A31C;
	Fri, 30 Oct 2026 06:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45301606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6I9tjMJv
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GRCGW6zun9XgkQRQsjo432+p58mI3EkOvS36OEwLx2k=;
	b=6I9tjMJvVzKH+TuaWeFghRnbaH4yCZCly7Ie0vlLjxGK41kc6ogruEU10hnFNtrjq6NO+biXZ
	FOD2U7ZtiCNQGmv347mfUsfVKqvf6M9izgctTEVOpT1CwvjWR3sriSwWAg3G9Eavs0apptl7/UL
	JmNq2PwZbRR0AMTheEHq0ow=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jGBGK4NMcz1K99C;
	Fri, 30 Oct 2026 14:36:57 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5535140565;
	Fri, 30 Oct 2026 14:36:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 30 Oct
 2026 14:36:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <linux@armlinux.org.uk>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <shuah@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <stevenrwalter@gmail.com>, <will@kernel.org>,
	<wade_farnsworth@mentor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <bpf@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/2] ARM: ptrace: Fix seccomp seeing stale syscall arguments
Date: Fri, 30 Oct 2026 14:36:28 +0800
Message-ID: <20261030063630.1218302-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

On arm32 the syscall entry code copies r0 into ARM_ORIG_r0, and seccomp,
the sys_enter tracepoint and the syscall restart path read the first
argument from that copy, while audit and the syscall itself runs
with r0.

If a tracer rewrites r0 before the syscall is dispatched, at a
syscall-entry stop or at a SECCOMP_RET_TRACE stop, leaves ARM_ORIG_r0
stale: seccomp and the tracepoint see the old argument while audit and
the syscall runs with the new one.

arm64 has the same problem with orig_x0 and it is already fixed there in
commit 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
syscall entry").

The fisrt patch fix this issue, and the second add testcases.

Changes since v1:
- Fix the sashiko issues.
- As Linus suggested, expand the explanation content from
  the previous version into the commit message.
- Add the selftests.
- Link to v1: https://lore.kernel.org/all/20260725091452.1875627-1-ruanjinjie@huawei.com/

- Link: https://sashiko.dev/#/patchset/20260725091452.1875627-1-ruanjinjie%40huawei.com

Jinjie Ruan (2):
  ARM: ptrace: Fix seccomp seeing stale syscall arguments
  selftests/seccomp: Add tests for syscall argument rewrite

 arch/arm/kernel/ptrace.c                      |  41 +-
 tools/testing/selftests/seccomp/.gitignore    |   1 +
 tools/testing/selftests/seccomp/Makefile      |   2 +-
 .../selftests/seccomp/seccomp_ptrace_args.c   | 463 ++++++++++++++++++
 4 files changed, 505 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/seccomp/seccomp_ptrace_args.c

-- 
2.34.1

