Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529156;
	b=a4cu7S8HtmIPAEBDBHcpxEw0YrF9cCAuRaX27p2cC1HpegXrvdouZ+VBDbzhUWtKhSJZ
	 9RTXmyPf4suPJjpEgJRzCfCYOORFMO5ZFd+kQdudlnzROe5xZfIlc2W1/pSUO5SFzOhIk
	 UA/wbknv++oadziAT67LElivV+ZfygG8MDuP95NECwi89xWcykRJih1x3M9N483Qoj/Hk
	 41YxvKV2nRAnIWDyE6HK2HJ2r3Vj7NOasDybXtt3lv7hqZdGaX4G4kqp/SLSsmzLBptEZ
	 rTugz/w6F22Pp+thJc+szLXqwXPWwe5hq61Go4dMwogCPnsZ7mPxFKzEmTucLqIm+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u/zxI4CzMoBvyHkNRptWT2GXXsMEz4m1n2MgjkQARrA=;
	b=ErKqudW6IuiO6Nz91SoXlm4mYdUtpYMC8XI37uhF+PRMOv7mH3gDrcPvrTuOgskMO9+q
	 M6ivOExzcDCiiY747S8N2cQvrLevHSRKtQ1HxENUE9BCEoQQmnCTSlb9y0faBJpYidagU
	 TwGbowCoPHrjhtLaWn4fglMLXOZQZk8M6MPsef9WeBkzz778Jy3veF4fhGrbKqqSW7dZ7
	 VO6IsF9/ysvKARJaGbZA5E6qBWffukL0K6zv+dlxVIrgEZRRW5fBzt/xtZN/A0Sgcu8pP
	 JIZrWg0KDqbRTG/ZVOOJmpZZBdsOFcsJjjum+tp6/zUXK5FiTYLPJGIkOI7LmI579+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udrTcaAh;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA0606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 10:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DA0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udrTcaAh
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-368c26de2e0so654856eec.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793529155; x=1794133955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/zxI4CzMoBvyHkNRptWT2GXXsMEz4m1n2MgjkQARrA=;
        b=udrTcaAhR6lTPvX6nytrMjhk3DuWqeWdJyxirvGnilvZJ6Po7seTbDjGHZSb+tTGV8
         lRA7hBsky7Yi4F8BdF8VSbpuo4XOFddA0ePcJc5p7crrbKkktIXPbo10Wbt5Qh8a1AOG
         IlvkjfxsaiwF7JjASnxoQhxDgLJkF1Mu8jiSrY8bz2wGuMkEyVSG/tIlfSl7ubyxpheI
         e91DXqljQQIbTTHvzuszzdztRClpLuqpZ7/vgZC/YsGXHjYZxQrt9cGJVASw8b3vFx7D
         XIEUDOi0sUhTkxObCds0b33AIPGsRsYCUM+NMPIs3GajcyhcnUMCsagg8FLLoJ3LkJjY
         rVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793529155; x=1794133955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/zxI4CzMoBvyHkNRptWT2GXXsMEz4m1n2MgjkQARrA=;
        b=GdXm6VljNc1V/Q42dO0evxdjRuUQ+/YFPEAcC/ngcdGnpHG8xNbfbpebuO9BTznBQI
         dLWO7IVaJYLUZRcfupg18NvuwOhC2bJo0bpscBTX6e2Rrg5S8oTtDNM7TPuOk1fnv2t7
         CCOu0JHF58ykd8WyWZcxw10jjp/HX2ybtfYnCjcL9WlVFgGEAtNTcV+4Dan9nRq0fwVa
         pbuhNpspTHOPAtip3aJlaF/7wMjWrzfkMKM+PxxLxiT6ID3crkOwJ3cKTL4JF/VtOx9k
         7TiQEbyGVgXnep3+IWCrODDDXYjD/1Blu76cYF1DL0biK36U0chgKnF4me6egIuQfkOu
         GsAw==
X-Forwarded-Encrypted: i=1; AKwUvBwj1iYHoipoBjiIanFg7UF9Gu1bL4zA7hb4IoDQ8YqjTrw95efiGra5DVYXhu/33/Lovmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wiQKl/5SFOyWsNrCt895jB7TVxBTXMn0bJ2lRmy3mZ9i6pJt1
	tu02VR2WvX8pdHGZcjmajNXMWm0mOKwtSb1VwGCP/2C5VH/klh7nyx2f
X-Gm-Gg: AYBFou1xqxAJ8vAYOXzSaFQVA4/qn6D1YVg7lJ1KFKUqgZSYPfsrpL54xSNvTdazXND
	cGgakY1qp2CE3v5An58XwuTzLOVBjogQnnGP/UuR/P5PpUWwf/wqOLQj8KfenjGj6kYfzC803Ui
	EnYtakSyn9YuFhhCJ5ruq8Mlk1iLLodzvST3aT6jFa3RYGLVdsjV8k08ht2nmHj0cHpU2RWz62t
	ilRhKzPorh/Ch6VFwwtHJ9MK1aXkzJ6qYsncrLcEIJLm+k0l2wndZwbxDfUKgOssW9cJw4iYbGU
	L2p9LheAXzQzuP/GRMfCGZjwJrB6K/iisXD4XW+AEMjFXqEHwdeccDWU+DQwBAJFxCyhOaPWm3q
	ZgXAGTPvVFqER33DHxtRfd2UwfSQTR5K7Sixzz8Uh8X4UMr9QDjkFYZQkNEe2KUX03iMJwpUmnL
	wKnpnM/7rq9mDnWC8GIOLFolKWs2w5pgkGhJ9lr3XlUCIXAbX+z4Xj42zgsXMR+8IC+cZHlqZpu
	hY2k3YvqyWfBSqWYnxg3PqGG1pK5Nj950/AtaNOHvLX9w3XC6djs7jP1GP9lT7mHQ66vx0WPCqA
	rFgmshSCBEgZ8nZHeytxu/A2IRgwn4MJUd02n518dDWKBEqvMhXki3b3
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id 5a478bee46e88-36a423f54a1mr10402589eec.19.1793529155071;
        Sun, 01 Nov 2026 02:32:35 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm25242506eec.6.2026.11.01.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:32:34 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/3] Normalize enum values in libbpf and bpftool
Date: Sun,  1 Nov 2026 10:32:18 +0000
Message-ID: <20261101103221.51534-1-dennylin0707@gmail.com>
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

This series fixes enum signedness problems in libbpf and bpftool data
dumps using the shared btf_enum_value() helper suggested by Alexei.
It also uses the helper when parsing enum-backed map fields, where sign
extension can change the requested map_extra value.

Keep existing enum name matches before considering normalized values.
This matters for eight-byte BTF_KIND_ENUM values in both dumpers and
narrow negative enums in bpftool. libbpf already zero-extends narrow
data without kflag; that behavior is unchanged. bpftool preserves the
original name's priority in one scan, even if another enumerator matches
the normalized value.

For an eight-byte ordinary enum with kflag clear, a stored negative
enumerator can match both its sign- and zero-extended values. This is
a compatibility choice: identical metadata can describe either a legacy
signed enum or an unsigned enum.

Unknown bpftool values follow kflag. With kflag clear, numeric output is
unsigned, including BTF sanitized by libbpf for kernels without enum64
support. This changes unknown negative values whose original signedness
is no longer recorded. libbpf's numeric fallback is unchanged.

CO-RE is left unchanged. Clang 14 and 18 emit a zero-extended immediate
for 0x80000000U, which the current sign-extended orig_val rejects. But
using the helper directly would reject negative enum immediates from
Clang 14 objects without kflag, and would zero-extend negative values
from target BTF without kflag. Those compatibility issues need a
separate change.

This supersedes the pending libbpf patch [1] and bpftool data-dump v2 [2],
as requested in [3]. The already applied bpftool type-JSON fix,
eaae576c34d7, is in the base and is not resubmitted.

Changes in v3:
- Combine libbpf, bpftool and regression tests into one series.
- Add btf_enum_value() and use it for enum-backed map fields and data
  name matching.
- Preserve existing legacy names, including eight-byte ordinary enums
  and ambiguous narrow names, addressing the review of bpftool v2.
- Add libbpf data-dump tests and kernel-backed bpftool map-dump tests.

Validation on ARM64, GCC 13.3.0, Clang 18.1.3, Linux 6.12.68:
- Complete libbpf and bpftool builds pass, including the libbpf ABI
  checks and bpftool built with -Werror.
- With the new tests on the baseline: 38 subtests pass, 8 fail.
- With the fixes: all 46 subtests pass, none fail or skip.
  These are the btf_dump and bpftool_map_dump test groups. The bpftool
  cases load BTF and maps into the kernel and check both CLI formats.
  Run these groups with ./test_progs -t btf_dump,bpftool_map_dump.
- map_extra parsing was checked with a separate local object-open
  harness; this series does not include a selftest for that path.
  Arena allocation and mmap were not tested.

[1] https://lore.kernel.org/bpf/20261031233219.9362-1-dennylin0707@gmail.com/
[2] https://lore.kernel.org/bpf/20261101001024.9994-1-dennylin0707@gmail.com/
[3] https://lore.kernel.org/bpf/DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com/

Thanks,
Hungyu

Hungyu Lin (3):
  libbpf: Normalize enum values according to signedness
  bpftool: Preserve unsigned enum values in data dumps
  selftests/bpf: Cover enum signedness and legacy name matching

 tools/bpf/bpftool/btf_dumper.c                |  42 ++--
 tools/lib/bpf/btf.h                           |   6 +
 tools/lib/bpf/btf_dump.c                      |   3 +-
 tools/lib/bpf/libbpf.c                        |   2 +-
 .../bpf/prog_tests/bpftool_map_dump.c         | 180 ++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       |  84 ++++++++
 6 files changed, 302 insertions(+), 15 deletions(-)


base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
-- 
2.43.0

