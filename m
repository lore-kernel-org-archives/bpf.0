Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106619;
	b=SR+ZBX/Ntmt3EgLZLfg+rQiI+wlGsdXKhhbp38cLu9xAci6Dlsvc0gG+X62bQFMhATn7
	 8Gyqk3Qb5+9l7brl8sWa/YRBFk9L95KNxswgBJbgF9dIxpBFTPnVRvRjwMpEbJCORaEDr
	 tqfi5wCXNmXP2+YDLNXr3Q655dt5idqkq1152AjhkUT2HkrslMsJtjPR8K23KohgWUXoA
	 wBbRi2FWAd3cdfXTlYEnt4MG84vn6+1aHQmdFYkRewWexgbXasFx0FZ3jZaE2nDLRe0WO
	 QngVSu1HxyQ57ZPDXjnKVKxXBaLy/7ETWLNCCKcntkGVANfpbmaro32rHDRzjoyhRYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E04mLJ5cyGn2rFsBTUMJxpaTlzNgjDYYX4TRN56eccw=;
	b=aTNRVk8+IF/YFnievoYJFDS4wswnHZ14Le9bVxB41JP8gQpK1Ppjk7kPQMqndRe/vB9L
	 wJ7MnHDjDwe8Grx4ST4Jnfsfq0wjwyRFC/k06/k9sk2XXrbNlB7VVpoWdZ0Ul2/0vKALF
	 SjquG6poF4PFq4N5/iweoVZib/teQsh40mLQLCK5WkbO89lEsOKYr90Ha2rQqw5aZUFvd
	 V+Kx/tgol13+tweAxQN39XuZZCFVgUsxunRJadiO6J7Uu8VdFaM3+KrQqhjyQL2mvRrCK
	 DgR7I2hHnU6mGxXk8O8FfGGuvY0GFJB9gNg5TF7IO2NAQjUSOMUTQXY0ua7tvz16qXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8e7WddY;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9E606A31D
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 02:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C9E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8e7WddY
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso103643eec.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 18:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794106618; x=1794711418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E04mLJ5cyGn2rFsBTUMJxpaTlzNgjDYYX4TRN56eccw=;
        b=Q8e7WddYBnWleL3P47dR3Wp7PPUMMoIn1ju+iqiDFeTnRaX40Njq0tIFZtyVpGGg3Y
         TWs8vMZ1MrtKD+HkSkZM+WWm417y3jImr1XnZd/LxS9i6i1pyBydBLNYZUubGacSRTqI
         oJaA//jEzdTCGzPZRd0mcoQh7AMwaYpyVJ2hdNDvfanp5eAy3A8ObebMD9ELGSFnMYah
         QLjj7MxggM8zyQc+6HvxvlgsMif09/xkJ8lrp9LZfLmc1zd4F1IEyRe4CqZ0iCXpEE9k
         ezBmisvubRRtft+FiMHDQvLORK5f7AMqA4YXx5IC7EHU7B6TvmY6MdObhdyPDppAmeL4
         zx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106618; x=1794711418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E04mLJ5cyGn2rFsBTUMJxpaTlzNgjDYYX4TRN56eccw=;
        b=f9DtIlAjVyHou2n6v4iARqCdj55TrNFymOFc1G42PdMZPcyPjO8OWMH8/QYeXtX56d
         H0MfmNm3EaFBKaNdviylm/NpwmU24SUn49q48RT8Ob5vQjvEMQobhov5LsTL9i2yk4a8
         +Khyd3KGNjsquBgcs+1gK9ZHRC2yi29MF9oQGjvALDTj3Qg0kblBpe4KDODV0H47NY2r
         nvQMql9QfSYeYFdJOxQ6qTisNQPPfrqgyY01XE3/yTkmofRgMZ2mDLVPH+9L+5EnlYK3
         LGK3R9FGSqFYHp0ADKkAYXPLRrwHHrtMhH+w7qQ2pMPDc7jh35rzLL3dVUOSd35urSM4
         iZtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMgVB0TxA8meU0jgtWq5KdhTNV0NeheGIsuAYQYl4e1ZNlAT7aCC/iI4Nu5/TMn/5DHFc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gaCd/bd9Y1rAsLCjrx6fT/mGFInYmBreut027SZcqD63kalc4
	Y43sZ7DPxNPGgs2F5iQHmW3Axag1QR1OhiW8/kaDFQZMKrABVwsvF8Xy
X-Gm-Gg: AYBFou2ah63DQwQ/9Vk2bNL6FTj6FcFwwgiFke/mn9rsrfWakNeU/3tMKtfL5OX3xEL
	D5pfIv5xMtBCqMe06ow3jJDSLi04ipfRXL3mHiUfQABMDCib3rpjjyDJK2K4jxiatg6vyqywMkb
	GWeZbw//C/YUCNLen+b9L8RkmgBnyclDVhkxyoPP5HSIKUA0iXnKd3NxPe5rROxfsa2f6p3R022
	OhUTasD1CDTTpjwfReeRFXUok+aPnreU7/OPGMoFFPrGnrC6Jtz8lWY0g7hsb4Y9GEEH1yDeOhy
	vifS4XaSVGwP4wcFkJbccZQHtxGwko5aV/zyaTEp+s77lEJGvL+qc8v7KYiNdKAAwKytwzWS9zg
	wU+qikHxo2B2ex5Vx/VqtIXleJbkjM/VCHSau/pErarVLDPl4gqw6Q/4/tUiS4cxRMDX12ykz2U
	Fz1UCTfekgHQdNIZzMCawiuuVN1Gj1ME0N0rWQf5MXRuHQoZ3xUeLTjgi/QG4I7Lkr85uwqHrn1
	WUDkYRhL8xv5bFL8DYAFRQC1T6GCII2jCqv/dGBmk7dvGq5SVPVhrJgJqjRZO5KUNLLe9z4Q1kL
	ph8BCbo3tPdOBVMzMQgo84sfwqmN1UWPRYIiojqBe4UEpmJ+M5raLQvXxviFa2XPmxz9KU+8lIa
	kUd9olEfHtG8j7e46GHTvc0pe/jppbnNYt1Oefw==
X-Received: by 2002:a05:701b:2812:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1b39fe2dd6cmr598906c88.4.1794106618351;
        Sat, 07 Nov 2026 18:56:58 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm2241202c88.23.2026.11.07.18.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:56:57 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/3] Normalize enum values in libbpf and bpftool
Date: Sun,  8 Nov 2026 02:56:29 +0000
Message-ID: <20261108025632.10799-1-dennylin0707@gmail.com>
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

Changes in v5:
- Keep patches 1 and 2 and the map_extra test unchanged.
- Adopt the bpftool and libbpf tests posted by Alexei in the v4 review.

Tested on arm64 (Linux 6.12.68, GCC 13.3, Clang 18.1). libbpf and
bpftool build with -Werror under both compilers. With patch 3 alone,
the new bpftool_map_dump/enum and map_extra/enum32_high subtests and
the expanded enum_data subtest in btf_dump fail. With the full series,
all 25 subtests pass. The 22 unchanged existing subtests pass in both
cases.

v4: https://lore.kernel.org/bpf/20261107020725.36675-1-dennylin0707@gmail.com/
v3: https://lore.kernel.org/bpf/20261101103221.51534-1-dennylin0707@gmail.com/

Thanks,
Hungyu

Hungyu Lin (3):
  libbpf: Normalize enum values according to signedness
  bpftool: Preserve unsigned enum values in data dumps
  selftests/bpf: Cover enum signedness in data dumps and map fields

 tools/bpf/bpftool/btf_dumper.c                | 23 ++++--
 tools/lib/bpf/btf.h                           |  6 ++
 tools/lib/bpf/btf_dump.c                      |  2 +-
 tools/lib/bpf/libbpf.c                        |  2 +-
 .../bpf/prog_tests/bpftool_map_dump.c         | 76 +++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       | 20 +++++
 .../selftests/bpf/prog_tests/map_extra.c      | 19 +++++
 .../selftests/bpf/progs/test_map_extra.c      | 12 +++
 8 files changed, 150 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_extra.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_extra.c


base-commit: 3e18218484126afb9da722080659c038cb2256ab
-- 
2.43.0

