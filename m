Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732575;
	b=tnwZNJmjLDzklrUPa9rupChK0E5/d0ciN7OknstSfTXX0XeKWAK2/ZJCZ/htJqTXJnqV
	 eFgBS8dkHGJokYU6NTZsoyrGM9wcZV27WI1GcTU8+wYTFnvQ4pjvOLXk7K+yoc1QN0AE+
	 sw9/bpZUPJETRvmLFdb2VRLZcinIXRlJBAKLzixB1KfuRv84LthhhKPDu8md7ApkZ43eL
	 wqcADvQDSQg/2dOGTp7G++VUMWpzDYNiyqXY8DRgYSqQv9k+/M2CWJ0bAE1C4kc/piIs+
	 bjARZ+sRUHD+1pOAc8x+aYlnbBrLGcJXmffe0oAQTKiUzknOKu1qTpmnJ/BlKkpS6WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5+DlzZ54z+gqYS2j5LWpmlloxzsta3AIypG5vjV0hKY=;
	b=QZHSrhKaMjuxdPj2wNFERMEQXAxnGofeD0JGVtwCnqBsYL/tDO0ZCM/mT7I+yAKuJxIr
	 uUU2Lk+fZEXMTCUT3gDgvl6BPj/m/JL2S7YjTB1ZjxvD7XVmFa9yr/Lrg1zBAaszJaiWj
	 hMqm+drv6CrxR7m/4aKOIftSgeVz/+29+nQOVEZygdUlVak8/NkFsGF05a9Pkqo5AU+Ok
	 k3DrrHTfTZJW4YEFzcV2NRicJ6zgI+/ag02zzvC676iHGmt6HyIWnv+lgNeHygyKwiu/W
	 /pSaKfmBj4TE9/Ez7ODB8vAB9x6P7RC2RLeHKHIpAc6055ZA0lvBJCCojJkpl7Z0NsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OCuvD+/Z";
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEF606A31D
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 08:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FEF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCuvD+/Z
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1062894eec.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794732574; x=1795337374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+DlzZ54z+gqYS2j5LWpmlloxzsta3AIypG5vjV0hKY=;
        b=OCuvD+/ZYUyJBwtcZ9SiBfGB0R3m8CJJ7uqWGLa/nM4vATgtMPx+ctTwj7DOFy/WSy
         xYM9s7AIC71gtafU34SjUfbP42VHORHeDHCgT/rxFrQm27TQZuWF8oxNkE4n70r9XOqO
         LBER5aF0bszPgv3x4eLobOwaI5Zb7garF+Vx6tN4kfj6yIKL7yslnHPCgo99qdkuBz1m
         XGR13Qcev8Cv8rQqXmAIVPC3l0malD4Nrx9xckR6EA4PqvZYdQhzOZg6v0V9CVZ4Uvo8
         APkxqimHzKZCWFVghVvRp9+5q/bcR0GIoqiJ43qR+OogwZmegVnsi2ThhqlNyiLLplL/
         iQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732574; x=1795337374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+DlzZ54z+gqYS2j5LWpmlloxzsta3AIypG5vjV0hKY=;
        b=upFnqq/P7ESj0qX7wuLSpgHVV60W87obKCHQT9YHLmkouCe3dA4ADqAseCr/pMbCHN
         V2xx+sNKkunz1w9c5FExCCu3l957SqEWDiOgIoodHEgJ2p+HsAGuN571gN//ZGXEkebu
         hPapRcilehUcdlWZjrVVBdnB87xtt3vQqADcha9CSJGTrq7U9i+JEOt7ECVMWFZK3t09
         1C/VSleC0j94DyP5/r66QH5Ux41GDcivnPDtmRBXMBz7TjTYs/DjcTpyZcVyTsAqXaeW
         y9Q8NnDtZjR7jaTVNA8XmV22I1wA88wvbgNFzBIWeY3KYtkNndHPfJlNr8OJNuswdAQk
         v+Tw==
X-Forwarded-Encrypted: i=1; AL+hErEDsAb+Koe1k4kUUnMSq+eoO+gmKXGWhaGjg+oEEBLUu3BKkfvpUO/RQ7JjkXmvcxuC5c4=@vger.kernel.org
X-Gm-Message-State: APuU4Z96GVTDlbFgrUHIoV2XiIDt3l3Q9qMDDX2JQEeJyvCWBnofTwD7
	QmrEFiTHrHe7AQHaVcfBStMkHTwkI1RC5tdp7OgzeQ5crKPL1Ul1Viu1
X-Gm-Gg: AYBFou1Bnxbx5CSjW872AJjMq0/46tIvNbEfQYNwIr9ZDirzhjBKS60fvqN/Rt4z6d7
	0iafBa9Ruv4WfFPBwIpqrV7rBzgZZsldUQAVNce6rQ8Ja8l2RG7pltj/HuEWoQseruMTACcd+Yo
	7KbSGkPBTlmXdDQ9K1Nl5/f2w/ez2B2IWEc0dRLmOC57IMgRf44+VeujWzUkcgtkTh2DkVOCM1D
	v2tnS6WB3Yot16My66DhHasSUcnJrlZoGDW10KOgO+lGyRoFS272cMc9blhBrb3g0K3yqXxWSIp
	hn4tw9UEQOgM+tYNNnrb9StSMsYqvvoACJV7ijMkgLoNT7dSvp/W9hLpqy7nwIugqek3dUa/8Ry
	TMehX14Idt1EWddy1mO8gymqg20pDuHRXc0PiqYrbylsFeMS8I4Fi/RSxB6nCM8NW1BGgpI+D5m
	VlowIub5GZd29BXKHgF9RfIYvXHYQ6ng2lDoa+Cnv+iYCDarKOgZvX4MClvOrtjwagh9CVRo5zr
	h4/gBx6MXcaYbtLDHzEINndW98ODcweK2mcMMJLG5VR0QK/R60bGWH0/+E4U0ZUjzf0IzMIVlZ4
	iMkSS0chd2spRtJXtC9x4buxejvuFZC7vvaty8hHQtiyE0ysmUfgvrd33l7XQhLGb9OSLHF7AYx
	Ll2wzG4MmV9cTmqhBI+xTNI7X+wGAoQy5dHLg+g==
X-Received: by 2002:a05:7301:5518:b0:379:d02f:dfe8 with SMTP id 5a478bee46e88-379d02fe0b9mr6019030eec.14.1794732573612;
        Sun, 15 Nov 2026 00:49:33 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm25221051eec.23.2026.11.15.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:49:33 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: andrii@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	alan.maguire@oracle.com,
	shuah@kernel.org,
	alexis.lothore@bootlin.com,
	luisflavieira@gmail.com,
	ameryhung@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next v2 0/2] Fix unaligned enum values in btf_dump
Date: Sun, 15 Nov 2026 08:49:21 +0000
Message-ID: <20261115084923.53182-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

btf_dump_get_enum_value() reads unaligned enum values through
btf_dump_get_bitfield_value() with a zero bit size, which shifts a
__u64 by 64. Patch 1 copies unaligned enum data into an aligned buffer
instead, as btf_dump_int_data() does. Patch 2 adds the tests Alexei
posted in the v1 review.

Changes in v2:
- Describe the undefined shift in the commit log.
- Drop the data_end check, which broke the dump of struct fs_context
  without emit_zeroes.
- Add the selftests from the v1 review.

v1: https://lore.kernel.org/bpf/20261113223449.97604-1-dennylin0707@gmail.com/

Hungyu Lin (2):
  libbpf: Fix sign extension of unaligned enums in
    btf_dump_get_enum_value()
  selftests/bpf: Dump unaligned enums and a zeroed fs_context

 tools/lib/bpf/btf_dump.c                          | 13 ++++---------
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)


base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
-- 
2.43.0

