Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D73A7F70
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352751; cv=none; b=Nw+fEoVX8A/pLxkkCD/knrQ8x/ObrFAkBLIDGTTSfcu/8MCfpmUmVEHV4u7uUKKpfraTzwBYmHu+ng72XcutRZr0KE0JDrB6frabOgBBT+vC++e+FfqOWN3QkPWUJWBnI4mMhXipUpjXOiko/cHcHmtbfrZUXVIdn/j0fytjZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352751; c=relaxed/simple;
	bh=Zy+vXHULIiHQriySmY5PaOa824owsZw35oInqCSXECE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tO0VRXM4a3vJo+Kp7sJb7Zydgl8hyc52+wqPD7wbV8u78FsL8fu+xH63bYW3FnOVZ+UQbzv/OKBrrIVNjIbORBuI85R8ke+JHX8lWY0UiYe/pwH4HijgIJJMHVnDWzT9F5gWp7Fj9GNU76PPi7tSld+R7F4bPkIT/c0bpyqXI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xor7Xmb3; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xor7Xmb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cr
	AZKsbc/cVmz/kxmfhXtcJDp+HWUzUxpzCgL6fz2io=; b=Xor7Xmb36N0hQe/eQy
	el/6OWacbiBWoz7Hkkzif5KFLUY8+zre0YSg5ph723cZL5Gx9ysw35kzOaSkaG/j
	SxDf5bfjxus22TxNVaVnsxeBSWllzSvyE42RldKw2DPUb5hxlWNzKm59o5ythWRT
	uHGo8tCF6A5/OIzEE6+Bj89q0=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3fphFlHlq933IOQ--.8396S2;
	Mon, 10 Aug 2026 17:05:10 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v4 0/3] bpftool: fix batch file handling issues
Date: Mon, 10 Aug 2026 17:04:56 +0800
Message-ID: <20260810090459.2666243-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3fphFlHlq933IOQ--.8396S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF18Cr17WrWkKr48Zr4Utwb_yoW8Wr1rpF
	W3K34Sqw4DWwnruFn3CFW5XFyrGws3Aas8Gr13GrykuF98GFyF9r4xKFyrX345XryfZw1U
	tanIqrn3Ww18CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFeHDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gcv7Gp5lEdRrwAA3c

From: Yuan Chen <chenyuan@kylinos.cn>

This series fixes three issues in bpftool's batch file handling:

 1. map dump closes the map fd twice (introduced by the map-by-name
    dump refactor).
 2. do_batch() reports a spurious read failure because a stale errno
    from a previously executed command is used instead of checking the
    FILE stream state.
 3. a line longer than the batch buffer that contains a '#' within the
    buffered prefix bypasses the line length check: the comment
    stripping truncates the buffer before the length is checked, so the
    unread remainder of the line is parsed and executed as a separate
    command on the next loop iteration. Continuation lines are affected
    the same way, bypassing the "command is too long" check.

Changes in v4:
  - Extend patch 3 to also cover continuation lines, whose comment
    stripping bypasses the "command is too long" check the same way, as
    pointed out in review.
  - Drop the USE_LIBCAP errno reset in main(), which existed only to
    keep errno clean for the batch mode and is no longer needed now
    that do_batch() detects read failures with ferror(), as pointed out
    in review.

Changes in v3:
  - Add patch 3 fixing the pre-existing comment-stripping bypass of the
    batch line length check, as pointed out in review.

Yuan Chen (3):
  bpftool: fix double close in map dump
  bpftool: fix spurious batch file read error
  bpftool: Fix bypass of the batch line length check by comments

 tools/bpf/bpftool/main.c | 29 +++++++++++++++--------------
 tools/bpf/bpftool/map.c  |  1 -
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.54.0

