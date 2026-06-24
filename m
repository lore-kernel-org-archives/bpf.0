Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89713A16A1
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293833; cv=none; b=YKF9ndaVzqUGYiiYyNEt4F5QRjUQEtAJ+p5/c88YAyetb7WobkDUGc/MEFZWebrca7Ydmia2YIGd6ojgpZYtUzfTaOx6liEhVlfpIGnqmxFsy+QlGB2s8/DgQqQLi56IoViEIpIksmUqnLIXOeKLY3nJJ5krIhEKIT/qKmGiPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293833; c=relaxed/simple;
	bh=m07ANvOv6RJFPVh7AtPWK+sHH7x3qzmVjBo6drP7oj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BIQpYTsrq0tX6MoqDLQLmDMqVS43R7sQ1MrFR+wtVs+QTcPcuxnXPYWKsbLqeuRgLstdLH+IvVGaBzsGxCwOucj9+ljZoBD0qwCXP+g1tifbfKRco+BX1di6s5hNJnXMKEP704L8PyQBg6Um32S82/drK3zVREMITKaUIfLNId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W1ItBUvS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W1ItBUvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Q+Apns7BSvKvOiH7KiEkU5IWLz3zXxOqWVB1x3L3/eM=;
	b=W1ItBUvSiSt2SihrJm6KxEVxkFH1sQuq3HkxLtZ3fOMTD8V/2noti4wcd6tQBK
	imVWzUXSy4tH86TDiuYk+vV3LdegzvU12E3w9OZmD7lrGVuRPhay1LjRc3byBQW/
	fFgBJPVotUnOLeabXDmiyb4FC83UF3QYXo9pMooujmWjA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3lwonpTtqwoMPFQ--.6915S2;
	Wed, 24 Jun 2026 17:36:39 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next v2 0/5] bpf: add bpf_memcmp and bpf_strpbrk kfuncs
Date: Wed, 24 Jun 2026 17:36:33 +0800
Message-Id: <20260624093638.117062-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lwonpTtqwoMPFQ--.6915S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1kGrW7Kw13ArW7Cr1Dtrb_yoW5Xr4kpF
	WfCw15Krs7JF47Kwn3ua1xua45Wws5Aw45K3yUK34Fywn0gFy0qw4fKr15J343JrWDG3Wj
	v34kKr9xKa15ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR3EfUUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QfbCmo7pSf-LgAA3p

From: Longjun Tang <tanglongjun@kylinos.cn>

This series adds two new BPF kfuncs to kernel/bpf/helpers.c.

=== bpf_memcmp() ===

BPF programs frequently need to compare raw binary buffers, such as:
- MAC addresses (6 bytes) in XDP/TC for L2 filtering and forwarding;
- UUIDs (16 bytes) and hash digests for allowlist/denylist policies;

Currently there is no safe way to do this — bpf_strncmp (helper) stops
at null bytes which corrupts binary data, and hand-rolled loops are
fragile with the verifier (as evidenced by the local_memcmp() workaround
in selftests/bpf/progs/dynptr_success.c). __builtin_memcmp may work in
some cases but is not verifier-safe for arbitrary kernel memory.

bpf_memcmp() compares two memory regions byte by byte, does not treat
null bytes as terminators, and returns the standard memcmp-style -1/0/1.

=== bpf_strpbrk() ===

BPF programs parsing kernel strings need to locate delimiter characters
to split tokens. Common use cases include:
- Parsing comma-separated mount options (fscrypt,noatime);
- Tokenizing space-separated /proc entries (/proc/mounts);
- Splitting colon-separated xattr values into individual entries.

The existing strspn/strcspn kfuncs can approximate this but require two
separate calls — strcspn to find the span before a delimiter, then
strspn to skip past it. bpf_strpbrk provides the missing primitive:
locate the delimiter position directly in one call. Together, strspn +
strcspn + strpbrk cover the complete set of character-set search
operations.


=== Changelog ===

v1 -> v2:
- Fixed bpf_memcmp to use unsigned char for correct comparison of
  bytes >= 0x80 (sashiko-bot)
- Improved commit messages explaining use cases and motivation
  (Alexei Starovoitov, bot+bpf-ci)
- Removed duplicated kernel-doc block in bpf_strpbrk commit
  (sashiko-bot)
- Fixed test_strpbrk_found_multiple to test with "l" (3 occurrences
  in "hello world") instead of "w" (single occurrence) (sashiko-bot)
- Added -E2BIG too-long-string tests for bpf_strpbrk (sashiko-bot)

Longjun Tang (5):
  bpf: add bpf_memcmp kfunc
  selftests/bpf: rename local bpf_memcmp to avoid conflict
  selftests/bpf: add tests for bpf_memcmp
  bpf: add bpf_strpbrk kfunc
  selftests/bpf: add tests for bpf_strpbrk

 kernel/bpf/helpers.c                          | 88 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../selftests/bpf/progs/dynptr_success.c      | 30 +++----
 .../bpf/progs/string_kfuncs_failure1.c        | 16 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         | 25 ++++++
 6 files changed, 148 insertions(+), 15 deletions(-)

-- 
2.25.1

