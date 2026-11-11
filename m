Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381569;
	b=EmCEkcZ1Tw5ndyay+3pQixmSZHDgJR5RUmbbYjL8MyLrzagID5zs+snoq4Ah5vdjqINj
	 rvEAcuSnDvEcOh7jtCBJEPVPTryU/5olmzfI45ygGqVJ8UYW26/RWMyERnRtOCT1MSWdr
	 b2PuWdPcAKZVk6QSt0RtOL+HmkSpHHXmVp0hXrvk8zygCn+bKLZIxKhtp7E7eD1EFw741
	 7yWSluvLDM/QVfOEtmTmPHSHBZRBIZ7HRmmBVzBjMjF7i3pZIHGIM7uJPQPxJOcJf6GLt
	 WrArQYgPvTHSHrgvGiEY8T2I1ojm/2dTZCnuFiHJDFRzpA3rFr/HWNzuHD/kdhMDrpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381569;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=+QL4OQsLb5HU0qDdnbeVb1z/fCiXZxiBAN45RxlTd70=;
	b=YBKMwj/NWV1Mfiups1lefTA4G/2vffKYhgyY/9dUP30gcTrcUbxzFLDgbbidX9uvTb/N
	 VTbMzYploin28XZR1tnq7lyyrpCnfgaw3OhZX++L6U5vInqOia/xrhANE+s16Royljn7F
	 cBFKISS5YSVOabmoMidAnhoDKQ6EDGtvbDviY60loT2wNfHQ58LfsyjsSnF57UrbrIdnh
	 wl6+o1Celfgi1fZLj2VUaNn/zmP6hoWJWblMXv3wDH++yoenByqkKcRLgbVeV9dI2y67R
	 Hctx0kQOe5nAt9DmyvgfSZqqP/MhmhcKiXIPXe1Y+1m4xgl38871EHw/zRx/tv4XhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=H1vTB9RW;
	arc=none smtp.remote-ip=198.54.127.78
Received: from out-zbxj-a78.jellyfish.systems (out-zbxj-a78.jellyfish.systems [198.54.127.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C69606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C69606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=H1vTB9RW
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZdQ33qnz8sWQ;
	Wed, 11 Nov 2026 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381549;
	bh=+QL4OQsLb5HU0qDdnbeVb1z/fCiXZxiBAN45RxlTd70=;
	h=From:To:Cc:Subject:Date:From;
	b=H1vTB9RWXmL8OfctDQeeTsxZXEbPYwEcsyozoFLdZ+mKtgR3vJ+fOnZK13r6BYEVK
	 zb5xxA252ADxOQBBDsdGtPWLwwbFxw7+rzIO8NOb48sR3qp2Ol07Yuk0jg7pYTVq7I
	 iaqrcj8x8sUFoYMU8xLCwj3zc69nW/QmNDKhjHIM4ptjYVQsDTghW414YGzLuXX99J
	 zOMhnzHNaGtqQzr11CvDNKcXYcti2YG3gc/O2goz3PhOzJhyN8OlH1Lf2BuomJsVb1
	 c5CDRUdJg4ZviwI+hHbF9VTuThosPxEP/pJSLrwc7QVqnqN8WYX7F423JvCMOyVAKV
	 A3XbFBWooQRUQ==
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
	qmo@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v10 0/2] bpftool: Use batch lookups for map dumps
Date: Wed, 11 Nov 2026 16:18:54 +0900
Message-ID: <cover.1794380384.git.hi@tychen.cc>
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

Use bounded batch lookups for map dumps, falling back to individual
lookups after the last printed key on a batch error.

RHASH concurrent-delete correctness requires "bpf: Fix RHASH batch
cursor loss" v2 [1]. Please take that kernel fix first.

Changes in v10:
- Document the non-zero key/value size precondition.
- Rename the tests to bpftool_map_dump_batch, drop duplicate LRU cases
  and use small per-CPU maps. Reserve JSON checks for representative
  raw, BTF, per-CPU and multi-batch paths.
- Carry Quentin's Acked-by tags.

The 14 batch subtests pass in x86-64 KVM. Combined with recursive v12,
all 33 dump/access subtests pass with both 2 and 128 possible CPUs
(2 CPUs online), without skips.

[1] https://lore.kernel.org/r/cover.1794379108.git.hi@tychen.cc

v9: https://lore.kernel.org/r/cover.1793821981.git.hi@tychen.cc

Tianyi Chen (2):
  bpftool: Use batch lookups for map dumps
  selftests/bpf: Check bpftool batch map dumps

 tools/bpf/bpftool/map.c                       |  98 ++++++--
 .../bpf/prog_tests/bpftool_map_dump_batch.c   | 229 ++++++++++++++++++
 .../bpf/progs/bpftool_map_dump_batch.c        |  42 ++++
 3 files changed, 354 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_dump_batch.c


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.56.0

