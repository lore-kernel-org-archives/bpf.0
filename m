Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017255;
	b=SnPZs+bR8yPAlk1KtrQ0PySD8710wn4nOCxZDsvVAGb78G5XcSZJmvJ+QB9eX+ypQc/s
	 gJXql2QMXAwRyQdxEwRRk0KVY4+hyqadUnTLvFhEhnr8np42GstFskzwQ/4AAPNz3hXBM
	 sAxx09+TjBforvO8b/ofvMvTUvUKXEAiNOb9ukpCczb2vDdhmpP4obQ3sdf+lZLzBs5/k
	 dKMFNPRoRrKVXxDC/ZwgqJs2+hP03fAc6Oo5fMY/rySHS7M8tpUKM3SVRh9HHhZgBtACz
	 H2Xy7l+EbcUMQXxo5l/y8Coy1am9UuAGz8ln3FtX2sUEKbh8Cko5H7OZ6MpXUROpsUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uXAs2PZ59auU0l17XbEdgEnM2qhJhw52BVoeNXNAnlg=;
	b=06OnTpGxNCdBQLX57/NFZKib4dYlZ8xseLj8wsrflSsAbKuGbv/B43NuceMAZjwwM9Rk
	 wbrHHPnMs2NJ8G6MI4rr/3TpaO05F+yGQIQv5cHpWowti/B4rM5oQ0TDOJhsLUuYH3j/+
	 QFitNBdAR1ukT4+iQ/Y7ihtoDRWM+YjO/WZHv5hMCvjrAyNEU5wEymBC4w4cYdm3kZbYh
	 4Bh9TYL9qGMUnO34i8WK7dfDqFISSGMSUTlwCY0KOkPXTxbQ4M/r7zIQL1WCDzJEp/n9b
	 7ouMydfVGKX/Mq4JBGTRPz/0hsC5bN1Xrrzi1kTwGD/NbnNPKdNzEn7UVoAixGB5hIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hI74JhRc;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C11606A32E
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C11606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hI74JhRc
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so522965eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017254; x=1794622054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXAs2PZ59auU0l17XbEdgEnM2qhJhw52BVoeNXNAnlg=;
        b=hI74JhRc+ABeO4innCbd2/hKTAiebOQOin2Ez2KNKhPdZau1OzVsRRAgtseleZMrXn
         uL/5ddFLJ7aJ6jPw54WWnXHNI74Ke3L5BoR98U9XWu7CVCiXyWyJ5cVKGcKqWGC353ek
         kO1kJWzHeLQjJzUOY4zQ0PmQe6iNQBvENYmsU2lEG2X+FAf10mhQ7k29DkIt5uu7o0L1
         /SAtErRezrrwUA1t1P4Dj51YTuwNs2CWY4CW2Wxyp03H2vz4IcsJZaHikRQFiOYaGn3x
         1T5pawToanmyl53/fh0H/MHDXAAKff9GTHvZD1YEFz8aIIbYTxQ/vhHkpeqcA1fdO3aB
         37IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017254; x=1794622054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXAs2PZ59auU0l17XbEdgEnM2qhJhw52BVoeNXNAnlg=;
        b=ff5fdopcIyye8BP1n7KzVraMH0b/xHNrbKRBl/KKgm/X0xLosI8DLnCPrMbJuCmKBB
         hdThUeYsmPL53L7MSF66aTwwcyLZUAkxYrVMjuksYRj08KQ7v3Aolrc4D+zd9J53lzN1
         nyyhgAUGJFd6CH8zcvtucWw070IqrJ78DlmE5VnCvB8wLk2DA/yjxNTyiau9UZHMom11
         Qun9kw9WKxXVbppOWEiWXLoVRSHUbgO5VtAuvYaPW7upOSznD3UAqSGub6WgaW161M4H
         8GnWYJmDeQBx3yd3CyY0Su9t9sXsKSiB7SIHJckKdxHAWmc+BoKHi1Ipdkdn+S6/OT7X
         Is8A==
X-Forwarded-Encrypted: i=1; AKwUvBxVyHOen1fFFLa+zW683Rr7rPmetoGXdMDqj6j2uECs8tlHOiZl7Fh6TdpF9UnaoAEi/mI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RI5NEK7hH/iB1xXxanbqrSX0pTsqaIpnGhQEJUv9nnDV+Nts1
	oZrOAMSC97CqYFf/UkCQPPz1lAIRexVTPJkSLTMY8JhIjrKrb3BMlPSj
X-Gm-Gg: AYBFou3nS58pxOrLQ96RgLyi79M9sGnRnqtYZzsgPHWE5Ti4xQ8dXo8Amug61aEg1mm
	ZTuvyWgGj0GtDu9/U1EQQgxzi8gD02QW0qolL4+KaXRlgsztDl8U/Bbf5avnGyumXEqcyzKkfds
	wF/Z3lLX8O+MQjMhcNcVHR7FxHzqxPgBd6YrxOQUewQhbpXS2RxqEKlVIrE19WNWbTUt8dDKVQh
	bctLszsWEJ1AktLbuDo+TvbLfs/pa9eTRYL2bcru9ttLvoaDaZl+Z779Tf0z7NyMCIE3X+K+0cj
	naB/ModV9dzXHN0BWMGBAw3BeZgMT1vS0ExBB6/dDD1JuWnePQiceazWazNOzzAWAj54ZoxvBr0
	RjMHiuMCh64EGjJVFyi9ZWx8WWj/J8SD2YY2deU4I0vd26aBDz0ZZYBw+1F4Jb7FyEoZBEbXQqf
	ZYVGxTge9v0/F222duNaX0XS0a/aUAlGPRArLCVBdZqRlIfJMu/uBe+9XqAwYgexHV/iYkrOMFK
	/Y7KkYfzC3yaiWxq38krqzTPDeu1GUmxSDSr8TqCpJuoWM8VA7dfVuQErtWraHkw+RAaqy5Xkdu
	I+6JLo+efuPb+hpA5hcGcmUypjQa0nZJ3l26NYmY2cN98BTBftyQfV8DbYx3TwH8LFtQQGF4ceq
	cgtumv7LL9x5dBvkC65nR05fqRNMYUG6VT4ei8A==
X-Received: by 2002:a05:701b:2506:b0:1a7:d426:6dd2 with SMTP id a92af1059eb24-1b25d322b55mr4739572c88.26.1794017253925;
        Fri, 06 Nov 2026 18:07:33 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm9338497c88.7.2026.11.06.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:07:33 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v4 0/3] Normalize enum values in libbpf and bpftool
Date: Sat,  7 Nov 2026 02:07:22 +0000
Message-ID: <20261107020725.36675-1-dennylin0707@gmail.com>
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

This series fixes enum signedness in libbpf and bpftool data dumps
using the shared btf_enum_value() helper suggested by Alexei. It also
uses the helper for enum-backed map fields, where sign extension can
change the requested map_extra value.

Ordinary enums are interpreted according to kflag. When kflag is
clear, values are treated as unsigned, including BTF from producers
that did not record signedness.

The helper returns __u64, consistent with btf_enum64_value(). bpftool
casts to __s64 at signed numeric output. CO-RE relocation handling is
left for a separate change.

Changes in v4:
- Return __u64 from btf_enum_value(), as requested by Andrii.
- Rely on kflag for name matching; remove legacy comparisons and
  bpftool's cached match and priority logic, as requested by Andrii.
- Remove the legacy and ambiguous narrow-alias test cases. Keep signed
  controls, unsigned names, numeric output and width-boundary coverage.
- Add an open-only skeleton test for the map_extra parser.
- Drop four libbpf numeric-fallback cases that do not exercise this change.
- Rebase onto bpf-next commit 3e1821848412.

Tested on arm64 (Linux 6.12.68, GCC 13.3, Clang 18.1). libbpf and
bpftool build with -Werror. Without patches 1 and 2, 9 of the 18 new
subtests in btf_dump, bpftool_map_dump and map_extra fail. With the
series, all 18 pass; the 23 existing subtests pass in both cases.

v3: https://lore.kernel.org/bpf/20261101103221.51534-1-dennylin0707@gmail.com/

Thanks,
Hungyu

Hungyu Lin (3):
  libbpf: Normalize enum values according to signedness
  bpftool: Preserve unsigned enum values in data dumps
  selftests/bpf: Cover enum signedness in data dumps and map fields

 tools/bpf/bpftool/btf_dumper.c                |  23 ++-
 tools/lib/bpf/btf.h                           |   6 +
 tools/lib/bpf/btf_dump.c                      |   2 +-
 tools/lib/bpf/libbpf.c                        |   2 +-
 .../bpf/prog_tests/bpftool_map_dump.c         | 162 ++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       |  77 +++++++++
 .../selftests/bpf/prog_tests/map_extra.c      |  19 ++
 .../selftests/bpf/progs/test_map_extra.c      |  12 ++
 8 files changed, 293 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_extra.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_extra.c


base-commit: 3e18218484126afb9da722080659c038cb2256ab
-- 
2.43.0

