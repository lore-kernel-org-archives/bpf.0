Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412574;
	b=OR2gV34gsgpWGwyTVWwbHCgFLXaejftuJI2Ef+cksEzeA6b94Mcd8qqgG5CRIOgNaKmg
	 FstYBzdyGAKjliHDliiniAiHARrTAJtlK4b9dxcL1KtfV7znFUacCZoloRoBSwXHhDTj5
	 fObYJ/JQhEDWAlSyEX30ocir1FrR/YnTDF2HD584wbU93Aw3XA3gMCvX6wp07yONhYbbq
	 fS2+HJ0ol7fn71d9KmNrk9JR7cEgkHM+uTwvWsgsjgodxQ9FJ7Zanbu0+BqbBiy+Azbmz
	 t8UYmSMHpCNeFfXEciPe7H4/TA6/mKDd4ZM5mjoQHmiZH52TySc3BpgbpWtcg1RlKJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412574;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=H8JwR7B+7ndWtT3MP8NnXDucTckP4zsTxZorbc3F8PY=;
	b=SF74R9tN0g0ZWkUhquPDEie5Auz/SDSeWipL1FeWAGkY0/fK1AqpxTmXJW8fasAeA98s
	 HmdpRgSTJc5Ko8cQknp+PtFkW26B3pbeqOgNgkTon6/gCq3mEoVRS0lTXfQEjreRith/0
	 Y0W3UnVSuS+I8qkYgWPu7WNEzoWtCMlN0h2Z9AJlCqv+u5SyD2xpo5bcJu5aNln1pBMTN
	 bZ1ux3A3pqsXN5wMsJ1SjuRRLTACBXtJ3FvPLYq1vQABbVR24s/e58HhzBNhBeJSsQ/Ur
	 F1ddpE5Zn43F/UwXFGFUQIM+Om0AIdeJ8FLJ1DhOkDeNx6Jd+FNeimG01C0ihFcBcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="opMt/z35";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56733606A330;
	Mon, 23 Nov 2026 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56733606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=opMt/z35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H8
	JwR7B+7ndWtT3MP8NnXDucTckP4zsTxZorbc3F8PY=; b=opMt/z352qWOs9qMoD
	LmEGxBHptIxlk1itiymmC70dXvV6Y+N/4ZFWSPSoxiL6bEqJmYgd2AZqv2MFQHSs
	prsQbXfaL5Zwx1N/8s7IlunlcCoPKMw6xC+7+PMxgfW2ycueMEoS4/1A4GSBo0n0
	tE5BFA3abKNaliair3jkxWlNk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL9ky0gNrZC+QIw--.65118S2;
	Mon, 23 Nov 2026 13:42:12 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v12 0/2] tun: fix re-attaching the socket filter
Date: Mon, 23 Nov 2026 13:42:07 +0800
Message-Id: <20261123054209.89946-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDnL9ky0gNrZC+QIw--.65118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWktw4kZF1rAr15Gw1rZwb_yoWrWr15pa
	yrWw15Gr4kW3yxWw4fua1xAw15Xw1kGF13uwnxG34ruFWYgry8C3yI93yYv3Z0yryvgr4r
	JFnavFnFg3WDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hRdyGsD0jTDLgAA3c

From: Rongguang Wei <weirongguang@kylinos.cn>

This series fixes attaching a queue to a TAP device, which re-installs the
socket filter of a persistent device.

TUNATTACHFILTER keeps only the sock_fprog header, so the instructions are
read from user space again for every queue that is attached later. Keep
the program on the device instead, run it from tun_net_xmit(), and record
IFF_NOFILTER per queue. Patch 1 does that. Also removes the exports of
sk_attach_filter() and sk_detach_filter() because no caller in a module.

Patch 2 adds selftests for the re-attach, for bad programs with and without
queues, and for the IFF_NOFILTER paths.

Thanks to Willem de Bruijn and Alexei Starovoitov for the reviews.

---                                                                             
v12:
  - drop the EXPORT_SYMBOL_GPL() of sk_attach_filter() and
    sk_detach_filter(), as Alexei asked.  It is a cleanup on its own, so it
    goes in a separate patch and the stable backport of the fix does not
    carry it
v11:
  - keep one program on the device instead of a copy per queue, as Alexei
    suggested; sk_attach_filter_kern() and bpf_prog_validate_classic() are
    gone with it
  - TUNDETACHFILTER now applies to queues detached with IFF_DETACH_QUEUE too
  - selftests: cover the zero-queue and detached-queue paths
  - https://lore.kernel.org/netdev/20261119032242.71919-1-clementwei90@163.com/
v10:
  - add bpf@vger.kernel.org and the BPF maintainers to Cc
  - selftests: fix the queue numbering and add a zero-queue case
  - https://lore.kernel.org/netdev/20261109023848.59575-1-clementwei90@163.com/
v9:
  - zero the whole sock_fprog header, so that the padding TUNGETFILTER
    copies is not uninitialized stack
  - https://lore.kernel.org/netdev/20261030060043.94719-1-clementwei90@163.com/
v8:
  - narrow the bpf_prog_validate_classic() contract to the classic
    verifier and note that it can also return -ENOMEM
  - commit the new program only after every queue took it
  - https://lore.kernel.org/netdev/20261028093235.148649-1-clementwei90@163.com/
v7:
  - verify the instructions before anything is replaced
  - fix the kernel-doc of sk_attach_filter_kern()
  - reject a program whose length is out of range before allocating memory
  - selftests: add a case for a rejected program with valid length and bad
    instructions
  - https://lore.kernel.org/netdev/20261023092239.186665-1-clementwei90@163.com/
v6:
  - add description for return value of sk_attach_filter_kern()
  - https://lore.kernel.org/netdev/20261016070654.170932-1-clementwei90@163.com/
v5:
  - add kernel-doc for sk_attach_filter_kern()
  - fix the wording of the mprotect() comment
  - https://lore.kernel.org/netdev/20261012021113.45939-1-clementwei90@163.com/
v4:
  - merge the kernel copy and the error check into one patch
  - charge the kernel copy to the caller's memory cgroup
  - https://lore.kernel.org/netdev/20261003063859.136895-1-clementwei90@163.com/
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check
  - add sk_attach_filter_kern() in the patch that first uses it
  - https://lore.kernel.org/netdev/20260930080746.135017-1-clementwei90@163.com/
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER
  - https://lore.kernel.org/netdev/20260929093712.131096-1-clementwei90@163.com/
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/

Rongguang Wei (2):
  tun: run the socket filter from tun_net_xmit()
  selftests: net: add TAP socket filter attach tests

 drivers/net/tun.c                 |  93 ++++----
 net/core/filter.c                 |   2 -
 tools/testing/selftests/net/tun.c | 358 ++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+), 52 deletions(-)

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

