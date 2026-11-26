Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655552;
	b=TLkoFfToW2kTkqzWovdA0p1oFBshMQXK6HDGWxt1K5vt3dvCxZkVuUeoJhwQ6ldGW4bb
	 OcDfmWM8zdoA1Lf4JVgPFOAF8KTYaQ3ZvzJVidXB3ZtgflmBeflrZ+mWlERce3y7v+Lqq
	 nspw+bxkH2Npd9qf0OursjSzbpsHg3+DX0SL0dAtv+uIYrOUerFcbDXkpP7tD8tZvDt+M
	 6978fenqK4zMOokrGU+T7i8sGg8JXxvL3F4Eeg64Z86RnWRestzpZTFFFoQKd9OrflQTK
	 jCOD0ZxcirTlJqm3PwjTzZtIji5jsZ0GW/Z/pBe4h2nSBh42DYp+vJxd1cBrGBBjX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l+BrBDucKyUhO3GbRKoc6iODblJyzQZkGIWH+QTSl3U=;
	b=M2P8odhuYHLo0PRU9p0n1/C/+84P3KKD9xx3KQDaYx2SDCWriaW6gIjGrlZJgtGJTYb7
	 rYnmEieRDh7ieI/gap7xh9RETbxTQARqvI0WRjhlwtUAsXEK9bon4fM+Gnat6hFnczE92
	 IVWI0UZCtZeSciybp2msIGkwhc6bcOWIfOLS0idN4vQ1bmFl/reXRxLXvFiQZPmtdc6Cv
	 5J+PdFn0kicc1c6tMu/0dstOXv8CTd8fg119zdZaM9SiMD5vm+m0hEU9mxIQZtbFRd0FB
	 VhjGjxyhp5X282Vlfn/ay3mEJDd3RhazzTNdJZsNTnUk6RIM3Whx+iYNxXb9oABm4Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bUcEum6;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D7606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bUcEum6
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so2318374eec.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655551; x=1796260351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+BrBDucKyUhO3GbRKoc6iODblJyzQZkGIWH+QTSl3U=;
        b=0bUcEum6TpX91hkiHSGg50ndhRxjuDjUtmPpIKSfvsi3SUzKwwmOwch454on/IjdmI
         epdSun1sgfi8SX0NnZ8C/FdfxHDpCDemLsa4ZhEE3cducaib1BpOGIY3o32g9KkNUeqt
         RChS6OGRvE3pO9knubbeqpt6R5LBJw2zqXPma+XEsDOklukjEHYIl+vZ7PFfK2JCXS6T
         629yhNM5UWDhuUSzY2WMN5UZ+i8tb9B7FdWh0UeXC8G+7KJO4t/c7oHLjbkkFAECCr94
         b8+cF5I9uoCqJpFEEKf3jAXZuHISSlDoh6cZ35J6ojm0eWWoYu6d9dychGuspSZuxD+j
         SMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655551; x=1796260351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+BrBDucKyUhO3GbRKoc6iODblJyzQZkGIWH+QTSl3U=;
        b=ayTRmtThAbTd2bmB1D7evIt+9FgbF12J8CGc8usaZW+6o7ZMCrH6jQUWM1ulQBfwru
         p5ym3oEc3iJ0XRubh9CAzppBNMRX8zzlH95NcU4fTsMgpM0/STC8ukOlf8ehYMAt9qRI
         N7hOCouNyLQihoqr+BgiSSbA/3vthaXFAY+9HpOEfANr0PW6F54eBeta7zBkrPUFiJ87
         TsVwcx1a/XjwQybDOIWXeGo00u7hQraYXiHD0VGnbbyJ1Kdl/6uVgpK+YZuhgLIRDb8m
         kPyfFTuLmIKxLy9qf00Nea4Lo2t8VQJIEI/Rrh7STkMevez157nK6u0GVCdzKxUtU5Dy
         4RTw==
X-Forwarded-Encrypted: i=1; AL+hErHA6tE0cLl1wwXPmXxryAQMisnn44OGUs+z2DM56JIoDAouyhcs/4Cj/Je2D2hsNwvwwEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iM6hnPE2rUqXtLE3q5SL3ET/ybSW1FWV59wqHg4yZz6a/pA0x
	6PisZFCtptIyJouhafyMcD+sJUcQpFMk9inxUmmMoGxwt/4UD5SiG8Y2
X-Gm-Gg: AZFdTZd19c41S65TERiSW1xXv1G47nq6/2LeOGFOPoUMGV2Rr29VJBXw7G6xhl8BPS/
	r3nwlDIenLffDA1F4M1LTJRYNDYsWkIq+sfCFr36AIIhCel4MWu24EdaMkc0BqNUxKXNhwcwfg1
	8G+QO2AWJjYmukHD9gHjDDui0xGFwUwO8gcdMd/QyMUnrd2NAC+uzPHupBML2QFT+lBNBFUkxsj
	Cg2wpjefsZZC09y5jmmgOTPpUTpKS4Bm/0l0TdNWKHXnsVfA4EqQiahYw+/JfWvdbDzU7hW5qTE
	qzcZb+ejDU+R7hA+kLluztc24G25cwzbV4Lk3P109+djWSUoKDgO5CnXdpQn+kJIN5M7pkBWfwD
	FBOTfIFAuQYD1OpHNbKBnwMr1fwqukhwiQd4kf0VopI0VaNyfrVu77K//PAtibnYNPIjGyuzxui
	M+lWqFIJjALJYcKKge+QrkE4qZNWdFsxobcbs61F8Qat1iBGYF51U+cqLnuUf1os3xV/RR7kSDr
	jGk0HxOSLYsjn4z5RZAtWWmoxMb27PavKCskKNErXY2ZzqCF/TXrM4ynjoZN4C1FRWZPQA9KR8u
	7nW6Bq6CqMoBYdXPPvM2PcslFaSKh6yLLJt5Q/rqvpXx3/FDQ0Ej/4vT1WQgctMeoEN2U3CoYmG
	CoWNGyLGhYj6w2xO5d/xUnVfp3UlB4tKh7KA2UJr6
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr9211440eec.34.1795655551477;
        Wed, 25 Nov 2026 17:12:31 -0800 (PST)
Received: from localhost.localdomain ([76.33.234.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm55717751eec.15.2026.11.25.17.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:12:31 -0800 (PST)
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
	david.laight.linux@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next v4 0/3] Fix unaligned enum values in btf_dump
Date: Thu, 26 Nov 2026 01:12:19 +0000
Message-ID: <20261126011222.92180-1-dennylin0707@gmail.com>
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
instead, as btf_dump_int_data() does. Patch 2 makes the zero check of
enum bitfields read only the bytes of the bitfield, as Alexei suggested
in the v3 review. Patch 3 adds the tests Alexei posted in the v1 review.

Changes in v4:
- Add patch 2 to fix the zero check of enum bitfields (Alexei).

Changes in v3:
- Do the alignment check before the size check (David).

Changes in v2:
- Describe the undefined shift in the commit log.
- Drop the data_end check, which broke the dump of struct fs_context
  without emit_zeroes.
- Add the selftests from the v1 review.

v3: https://lore.kernel.org/bpf/20261116080151.44860-1-dennylin0707@gmail.com/
v2: https://lore.kernel.org/bpf/20261115084923.53182-1-dennylin0707@gmail.com/
v1: https://lore.kernel.org/bpf/20261113223449.97604-1-dennylin0707@gmail.com/

Hungyu Lin (3):
  libbpf: Fix sign extension of unaligned enums in
    btf_dump_get_enum_value()
  libbpf: Fix zero detection of enum bitfields in BTF dumper
  selftests/bpf: Dump unaligned enums and a zeroed fs_context

 tools/lib/bpf/btf_dump.c                      | 23 ++++++++-----------
 .../selftests/bpf/prog_tests/btf_dump.c       | 10 +++++++-
 2 files changed, 19 insertions(+), 14 deletions(-)


base-commit: 3cbbebf6819b42008e7ef85b6f0a7254c3074c19
-- 
2.43.0

