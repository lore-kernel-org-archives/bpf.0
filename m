Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB16374721
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563669; cv=none; b=ZiSBdTX9vr+EO5tWFcyjxRljyrCdDhLlPJ7MaXEB1lf1pQfYVOWUTgdzlNem1EPAGRGLDdtM5xpJ+Bfa6hQXUWzn8cFaPD5/sEvL0zZm2cz6ag5lDiTfpGigr94fA5NsKBLGwa7GSqoGCdtxBy0Fcije/xhzlXVdzvJiMIj4l9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563669; c=relaxed/simple;
	bh=r4Y9sJqSRnQYpiqvRV8MBgwTL1O+2j74uzWB4E+sECA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liMing8ZsdKDW9ibyl/hEjvWy8e4bauz99OS978n5x7J6abDBVlYkJeYtjVUthDUheb61onJ2fVC0aHMwHkGlHQeljOdIdx5XYRxVKKGS9Dp9YWUMiD0/ho5ERTY/3/9VSC0yrKopyOD5g1zt5oMHZXzPhI4kEbZAQD0fxzAR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EyzYuWhC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EyzYuWhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ab
	QYpaai+6OKsptPJeEo1FgxlNj8gSzxSkynTkXI8c0=; b=EyzYuWhCItmZFZDc7Q
	k7A6H4yMtbSZLBDAMuXXCsjTCIgRwwS3uYBzMjfOifTtoX8Uo4o6bP+/yhJky7dk
	yfjvOR8kg3Xr1BSe98djNNwSjpPUIKFZ0SEwCluhbObaGk8nJMBn7a3SGI4muuOa
	yOSpdrjzZDgJJCV+NFMzRNd5w=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3Kd9sDoxq8J3wNw--.45458S2;
	Mon, 24 Aug 2026 17:27:09 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yuan Chen <chenyuan_fl@163.com>
Subject: [PATCH bpf-next v6 0/2] bpftool: fix batch file handling issues
Date: Mon, 24 Aug 2026 17:26:55 +0800
Message-ID: <20260824092657.1789956-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810142224.2907373-1-chenyuan_fl@163.com>
References: <20260810142224.2907373-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3Kd9sDoxq8J3wNw--.45458S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8ArWUXF1kAFy5XrWrZrb_yoW8AF45pF
	W3Kw1aqr4kWr43Cr1xCrs5XFyrCws3J3WUCF1fG3s5ZF15GFySkFW2gF1rZ34rW34fAw12
	vr13tFZ7GrWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piW89tUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQ1cGmqMDm1SXQAA3A

This series fixes two remaining issues in bpftool's batch file handling
(the double-close fix from v5 has been applied upstream and is no
longer part of this series):

 1. do_batch() reports a spurious read failure because a stale errno
    left by a previously executed command is checked after the read
    loop instead of the outcome of the last fgets() call.
 2. a line longer than the batch buffer that contains a '#' within the
    buffered prefix bypasses the line length check: the comment
    stripping truncates the buffer before the length is checked, so the
    unread remainder of the line is parsed and executed as a separate
    command on the next loop iteration. Continuation lines are affected
    the same way, bypassing the "command is too long" check.

Many thanks to Andrii Nakryiko for the review: patch 1 now clears errno
before each fgets() call instead of tracking the too-long-line case
with an explicit flag, and patch 2 moves the line-length checks before
the comment stripping instead of detecting truncated reads with
memchr()/feof().

Changes in v6:
  - drop the double-close patch, which has been applied upstream; the
    series is now two patches
  - "fix spurious batch file read error": clear errno before each
    fgets() call, and drop the explicit line_too_long flag and the
    ferror() check (reviewer feedback)
  - "Fix bypass of the batch line length check by comments": move the
    line-length checks before the comment stripping, dropping the
    memchr()/feof() truncation detection (reviewer feedback)

Yuan Chen (2):
  bpftool: fix spurious batch file read error
  bpftool: Fix bypass of the batch line length check by comments

 tools/bpf/bpftool/main.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

