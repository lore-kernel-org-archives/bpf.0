Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B5368D5E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347287; cv=none; b=b8uqaIyQEtPeYRlPWEq9ukMVSFVm740lncTkwgrTWmddacne8cejUY24TVd3sdo6UBuspr1reKGWGmHVTF8CfduBg4f0bpMXIblknj6tit/7FRDOqQFxES4sltlyTOUnbxnftW7J3OvkrSzDsGa/8+D6u0PdTw3H/mTE7/sZZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347287; c=relaxed/simple;
	bh=8fzgysSDo3+E3DGTT1w3zXPfFv84F3+DEkiOZRwt6p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbHN9agtDkEQvfJfm9G8NPmlPZSLZAWTz2Ttt07rXZZVLUSM5h9jomkPgOsXa5+F2fj/vGp4E85jytVRl8TiOk9ek+oAKFV+Wsr25DkP2R6wqAy3QFE8mEJEgB2A1g8vye6t7YORliBIkVJ1tmzO3OAeooG1FCuSHb5oV7/qEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oHpNslq5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oHpNslq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4r
	pw63pixJnbqCbKmEUkXOPagWdJOpU/WD3WtWfR32Y=; b=oHpNslq5uVR370wKCp
	8ByjyVKrr2fnPIMrZ92sdPVGkxCWdhfGQl/jYJorwKoSJpRV41KeVBLlbeNGjdKG
	W+0Knz2VLiDsjpB9ODEU429kYtR4h+3VrBoUEW+k3Eq7PLW8VUJVvumUt6rjSf/C
	g3UYAXjhCtgcyjf2DdeZsIvaw=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnDk_mfnlqA1WHOw--.8184S2;
	Mon, 10 Aug 2026 15:33:59 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 0/3] bpftool: fix batch file handling issues
Date: Mon, 10 Aug 2026 15:33:45 +0800
Message-ID: <20260810073348.2586225-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDk_mfnlqA1WHOw--.8184S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xry8Jr4rWw4xKF4ktF47Jwb_yoW8JF48pr
	Z8K3yFq3yDG3WfuF97CrsxXFyrWrs3Ja4DKr15KrWDuas8GFyS9r4xK3W5X34UZrWfA3Wj
	v3Way34fWw1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFeHDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQfRj2p5fudC+QAA3p

From: Yuan Chen <chenyuan@kylinos.cn>

This series fixes three issues in bpftool's batch file handling:

 1. map dump closes the map fd twice (introduced by the map-by-name
    dump refactor).
 2. do_batch() reports a spurious read failure because a stale errno
    from a previously executed command is used instead of checking the
    FILE stream state.
 3. (new in v3) a line longer than the batch buffer that contains a '#'
    within the buffered prefix bypasses the line length check: the
    comment stripping truncates the buffer before the length is
    checked, so the unread remainder of the line is parsed and executed
    as a separate command on the next loop iteration.

Changes in v3:
  - Add patch 3 fixing the pre-existing comment-stripping bypass of the
    batch line length check, as pointed out in review of v2.

Changes in v2:
  - Patch 2 now uses ferror() to detect read failures and tracks an
    overlong line explicitly instead of relying on errno; Fixes tag
    corrected to 71bb428fe2c1.

Yuan Chen (3):
  bpftool: fix double close in map dump
  bpftool: fix spurious batch file read error
  bpftool: Fix bypass of the batch line length check by comments

 tools/bpf/bpftool/main.c | 12 +++++++++---
 tools/bpf/bpftool/map.c  |  1 -
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.54.0

