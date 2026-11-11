Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381535;
	b=bL4KrxfSAmLEG8OxOqOwuWC2QFJ13z0vk6DGkJurQn95CP3w73SMj8YmA1hIOqzHewll
	 9b95H2AdDExteEEJIUzDaDVUOCb/IQgMv8UfSFjNMxiWYqEEI4EIkHF1VjdwORq2qsFKH
	 2PrAalv0visE6nVQLiB6NSdWkxV9ts0Vn8uUBz522dk0A+cRaPFv1glFRdq2UzO/qPO0j
	 YCwG1Uvs6IG4icaVjjvAQwKTEKFMHn4+NSujvdNN6aEYxbft2AONmbDxmftg90Kx9GtMz
	 1og/WIWnWROrAFUQt6oGyGhtRvBiHKxddxfrU8u9yoPdjMcqWP/LEQcAEbUvO3ibQXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381535;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=FDVYx8yy52ErHGioH23BNSxBVVZYdOQuntf0S9ipsa0=;
	b=dqPNO2WMOv4KfQbVJZYBiQNhRHjI51nayDDM4FewP9s8mQ/p1UmxjiXHe+nZ8+yEdyn7
	 oZIkXz/f1zpVExkrWgHz+aWCzBlbWmKTNiIXvGlDRyKesZPsbPH6AJZUxfDJ/A2wZpLME
	 42wCiQQ7nYCdMN1Y+CVxbWkQXlNvG58wRHFXpgWnCWzSfDg3m9hZtbZSiNZRffqo++7dM
	 zgCGIl/owPqR4gmLTipE/hGrjCa4dN/ERkBGz9IaRF9RrhnivbdopOo1omFb+8Uig1GVr
	 hfJQYrKBf5vTQhr0zw10nItvsS0iLG5ip5n8TBtIKpnMOTnY1WxXmBMnF2gaO3521JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=kXQVO9cc;
	arc=none smtp.remote-ip=63.250.43.97
Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA941606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA941606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=kXQVO9cc
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZcm1bzTz6tkL;
	Wed, 11 Nov 2026 07:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381515;
	bh=FDVYx8yy52ErHGioH23BNSxBVVZYdOQuntf0S9ipsa0=;
	h=From:To:Cc:Subject:Date:From;
	b=kXQVO9ccHYWViACQPDpmlLFRWVPV5tx3Wzp1wFQE8lvUGe/Fky8pccpFlySaMwebZ
	 OOaHF2QabfKCa4jDKyjmPtJ+wLt6J5UjX7/5UXlpsLxuRvmzXZgWIokKpnDVLtL7Kk
	 Z/GgZwv3U2DRaoQd3VS/16JDypMjGxVqDhYtgEu5KZXzt+gZJocZ9v3EmZGuwj97TV
	 VN4N2Ts6u4yn92BnAuVu8dX/RKqSkRrKA19q2DTPcuGet+OxMCT+Fv+Q6jJsSVxuOw
	 CIn6hintx5fDEaMhzrax8MvVQdsbxmcaNjTzZ7UaOk5jWCr+8hvuR6gLu3X6JfQJTU
	 Y0uyj2IRM9XQQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	yatsenko@meta.com
Subject: [PATCH bpf v2 0/2] bpf: Fix RHASH batch cursor loss
Date: Wed, 11 Nov 2026 16:18:22 +0900
Message-ID: <cover.1794379108.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
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
X-Envelope-From: hi@tychen.cc

Report a lost RHASH traversal key as -EAGAIN rather than end-of-iteration.
The kernel change is unchanged from v1.

Changes in v2:
- Add the batch subtests to the existing rhash.c suite.
- Carry Mykyta's Acked-by on the fix.

All 17 RHASH subtests pass in x86-64 KVM, with five further successful
runs of the five batch subtests. The concurrent-delete test still fails
on the unpatched kernel.

v1: https://lore.kernel.org/r/cover.1794056839.git.hi@tychen.cc

Tianyi Chen (2):
  bpf: Report lost RHASH batch traversal keys as EAGAIN
  selftests/bpf: Cover RHASH batch cursor loss

 kernel/bpf/hashtab.c                          |  13 +-
 .../testing/selftests/bpf/prog_tests/rhash.c  | 177 ++++++++++++++++++
 2 files changed, 184 insertions(+), 6 deletions(-)


base-commit: 475a0cfd02f14d764023e926ac01fc7597134229
-- 
2.56.0

