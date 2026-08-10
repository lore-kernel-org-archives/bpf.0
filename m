Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FA3F20E3
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371799; cv=none; b=BDFePMQ3+mdvyTM49e+lxs7aVKJYacSnUNnE6sFNligPdqasKWpLt0Z0/lRZgselyllxKOrvkcxT7dfEDOEny3nxXS9MqoTfx4itH1mXwbaZL5P+zwCr0DTGGdpBEkt0yWH/kLrdE6ihoh248xlHPY16qecpXTBPlmrPIwcXMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371799; c=relaxed/simple;
	bh=EfMX2pLZel5BpswDcEWxvfUW0iDIu1VEobdaFcmEnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiYw36HoC0aeJAk56aB6xssWnlEBQecr6iQQtJxr6dddddzmSyuDEbBz5hj47iFcRF8R4SXL9SvMGMgB3yk7xdO0/edeJ71PVFX4WKaaNe5ECxcxd6GhcQCjOlo/wbjWfUuPZ3rgw4g6dPSISzho25QWdWW9JJzEd/P/Ew5F2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W+jFwUeU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W+jFwUeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hx
	92AFS1PJdwQzBWbwyl4GordaF2BMrh5Zedd3x9fkc=; b=W+jFwUeUMUqjhXRYBF
	KhEzZ7JCo0yXesKhjuXU47mowW33A6wgqLC3halwMG5aiELICZXq381h+vExjoQi
	T6E5HqxOWTeIRl4J+dUzW/V9/TTAo81HmoaxgrAsYCGW8jgbdllr6uUquIoVPMcE
	E0jHiIxynB19jciw4hh3Tr6zY=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n9ip3nlq3APzNA--.8292S2;
	Mon, 10 Aug 2026 22:22:36 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 0/3] bpftool: fix batch file handling issues
Date: Mon, 10 Aug 2026 22:22:21 +0800
Message-ID: <20260810142224.2907373-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9ip3nlq3APzNA--.8292S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1UCw48uF1xXFyUCF43trb_yoW8ur13pF
	W5Kw1Sqw4DGr9ruFn3uF45XFyfGws3AF1UGr13Kr1kZFn8GFyS9r4xKFyrW345ZryfZw1D
	tanIvwn5Gw1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF2NtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgzbmWp53qwGwQAA3q

From: Yuan Chen <chenyuan@kylinos.cn>

This series fixes three issues in bpftool's batch file handling:

 1. map dump closes the map fd twice (introduced by the map-by-name
    dump refactor); do_show_subset() has the same double close.
 2. do_batch() reports a spurious read failure because a stale errno
    from a previously executed command is used instead of checking the
    FILE stream state.
 3. a line longer than the batch buffer that contains a '#' within the
    buffered prefix bypasses the line length check: the comment
    stripping truncates the buffer before the length is checked, so the
    unread remainder of the line is parsed and executed as a separate
    command on the next loop iteration. Continuation lines are affected
    the same way, bypassing the "command is too long" check.

Changes in v5:
  - Patch 1 also fixes the double close in do_show_subset() and
    propagates the error when bpf_map_get_info_by_fd() fails on a
    subsequent map in do_dump(), as pointed out in review.
  - Patch 3 detects the truncated read with memchr() for a newline plus
    feof() instead of strlen(), which is also fooled by an embedded NUL
    byte; a line that fills the buffer exactly is no longer rejected,
    as pointed out in review.

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

 tools/bpf/bpftool/main.c | 44 +++++++++++++++++++++++++++-------------
 tools/bpf/bpftool/map.c  |  4 +---
 2 files changed, 31 insertions(+), 17 deletions(-)

-- 
2.54.0

