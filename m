Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191980;
	b=w0bv2g3ydMcqQzCbYjKLcD1xQrpxfcO395eNH+OB/wUfCACHQjKgZSrkkKJZBZ8oqp9D
	 5LqvzHOesibngkfHHb7vLfRmDcL2+6y+JNG+V/omOHxFUvbOQ3ZEQ1rpwGIicttxUBafP
	 lqX7ffeOnklJHrCzoW7a5bVVKNt+fhuZmlaQX0VV3w1hciCRfa15tIgta6TL5Z5aC4N+U
	 CY7Py5ZUsvIAhG0EhGQ3IvzKPVni0HZfXR37WyplwYGP4cI9/KiWwsKmNjCJf7DlG2Hug
	 xZ4Tncw31mkzmB5Q26+9ZI0/EGO08YGRi3loIDNrYChKV8WfFmYs2IEqiyTcKUp34yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191980;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2Si+Sm89MSx63myKBy7gbyefX/vZlVZslVZewpNyUdU=;
	b=r2tTIsDlpMYn2VZuLFBvAlToH75hduDF9oYtu5X7iw3gibpwch+W/PFBC2L4EYEh9eoQ
	 eLHipYQh9NrIVG+o86+ycRSKY2W+Za17/8XozwiwlA+c0U6t6QekTw7rfQOSXKzPcXS80
	 1BjYWsnbhbtFU+NNhKNsIB9gtVQrhgOdnE+9Ke1C/h/+frIP8TH4Ln9oY1T4EYmKxNSj4
	 LY47aZlvYfrt4+RFT5f2pryFzye546L85323KOcMD/SL0JFKxKS6LDz54BFP5sl4nCs1m
	 kMDetw7HloyZfBXS8sFlgSPetBMkSJ+iUGB27AhdYITaO4jlsa1YNmy2Sgb6WU0LJCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dOdF8a+3;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C6606A323;
	Mon,  9 Nov 2026 02:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dOdF8a+3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2S
	i+Sm89MSx63myKBy7gbyefX/vZlVZslVZewpNyUdU=; b=dOdF8a+3x26WSh2tYB
	tb/NoYBxpPuMC+z7i0OmGC2u/aa5hTywL7TtpmpzIucIeh1A4qZGMM9g4g/c9/SC
	sx/T+XRqPi4D+XtE8NY7SBrr1sYZYYUgc/ybIq9xH8+UcBaA5SQ0iXPzbHz1HDmf
	cb770RB/YKgFMlzallK3eoWbs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnFIE_MvFquQguEw--.65376S2;
	Mon, 09 Nov 2026 10:38:55 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v10 0/2] tun: fix re-attaching the socket filter
Date: Mon,  9 Nov 2026 10:38:46 +0800
Message-Id: <20261109023848.59575-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:QCgvCgDnFIE_MvFquQguEw--.65376S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFW8GF1DJF4kXF4fGw4xCrg_yoW7WrW3pa
	yrW345Gr4kW34xWws3uw4xZ34Yyws7GFW5uwnrG34rZa15Wry093ySg34Yv3ZrArZ2gw1j
	yFnFv3ZFg3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjCJQUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4QCzH2rxMkBXogAA3R

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v10 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach,
and fixes the inverted error check in tun_attach(). The two changes are
one patch on purpose: with only the kernel copy every re-attach returns 0
without publishing the queue, and with only the check fixed a re-attach
that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
working and is no longer needed to work around the re-attach bug. The
program is verified with bpf_prog_validate_classic() when it is copied in,
and the copy is committed only after every queue accepted it, so a program
that is refused later, when it is built, does not replace the saved one.
The header is zeroed before it is filled in, so TUNGETFILTER never copies
uninitialized padding to user space.

Patch 2 adds selftests: it re-attaches a queue after the buffer the program
was copied from was made unreadable, attaches a second queue from a fresh
socket to check that the filter is rebuilt from the kernel copy, and checks
that a TUNATTACHFILTER with a bad length or bad instructions keeps the
saved program, plus the ways to attach a queue without a filter.

Thanks to Willem de Bruijn for the reviews, and to the CI reviews for
the comments they raised.

Rongguang Wei (2):
  tun: keep a kernel copy of the socket filter program
  selftests: net: add TAP socket filter attach tests

---
v10:
  - selftest: fix the comment message. no code change is involved
  - add to to CC bpf@
v9:
  - zero the whole sock_fprog header in tun_copy_filter(), so that the
    padding TUNGETFILTER copies is not uninitialized stack
  - https://lore.kernel.org/netdev/20261030060043.94719-1-clementwei90@163.com/
v8:
  - narrow the bpf_prog_validate_classic() contract to the classic
    verifier and note that it can also return -ENOMEM; a program can still
    be refused when it is built, and the commit message now says so
  - commit the new program only after every queue took it, so a late
    failure does not replace the saved one, and filter_attached is left
    alone
  - selftests: check the filter state and a newly attached queue in
    attach_filter_bad_prog_keeps_program() too
  - https://lore.kernel.org/netdev/20261028093235.148649-1-clementwei90@163.com/
v7:
  - verify the instructions in tun_copy_filter() before anything is
    replaced, so an invalid program is rejected even when no queue is
    attached
  - fix the kernel-doc of sk_attach_filter_kern(): drop a reference to a
    function that does not exist and complete the Return section
  - reject a program whose length is out of range before allocating
    memory for it
  - document why the filter is dropped when a later step of tun_attach()
    fails, and why filter_accept[] has three instructions
  - selftests: add a case for a rejected program with valid length and
    bad instructions
  - https://lore.kernel.org/netdev/20261023092239.186665-1-clementwei90@163.com/
v6:
  - add description for return value of sk_attach_filter_kern(); no code
    change is involved
  - https://lore.kernel.org/netdev/20261016070654.170932-1-clementwei90@163.com/
v5:
  - add kernel-doc for sk_attach_filter_kern() describing what the missing
    original program means for SO_GET_FILTER and sock_diag
  - mention in the message that a rejected header now leaves the installed
    filter alone
  - fix the wording of the mprotect() comment and note what the IFF_NOFILTER
    and TUNGETFILTER checks in the re-attach test
  - https://lore.kernel.org/netdev/20261012021113.45939-1-clementwei90@163.com/
v4:
  - merge the kernel copy and the error check into one patch, so that no
    step of the series turns a re-attach into a silent no-op or into a new
    failure
  - charge the kernel copy to the caller's memory cgroup
  - selftests: check that the queue is attached again, and attach a new
    queue to see that the filter was installed from the kernel copy
  - https://lore.kernel.org/netdev/20261003063859.136895-1-clementwei90@163.com/
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check
  - add sk_attach_filter_kern() in the patch that first uses it
  - address the review of the selftests
  - https://lore.kernel.org/netdev/20260930080746.135017-1-clementwei90@163.com/
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel, so that a later attach does
    not depend on the address space of the process that set the filter
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER
  - https://lore.kernel.org/netdev/20260929093712.131096-1-clementwei90@163.com/
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---

 drivers/net/tun.c                 | 127 +++++++++++++--
 include/linux/filter.h            |   2 +
 net/core/filter.c                 |  67 ++++++++
 tools/testing/selftests/net/tun.c | 249 ++++++++++++++++++++++++++++++
 4 files changed, 433 insertions(+), 12 deletions(-)

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

