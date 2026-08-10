Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49643192B75
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786326788; cv=none; b=KBOKDqkTO8oXTXblvkZuyxGTjWpZpTh1FRxQZjLm0Vy2HB6T9W2g+UMnL4z6GXFGon8oO2GlnTvtap8BzhwjvnNRqNtUPDXKAzfLyw6jEuQYZGCdERQ9E4fxP6DBg/jwZbLGicYWQZg0wF3g5nURsH3kBCoinDBCwzoY7n/cbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786326788; c=relaxed/simple;
	bh=4u3hrnNBBGA2VXI1cqRurhwBHeVi9kcvbyoEdxCFhs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZw7tnAjUZ0sr4xy5Ixonu00chZWM+hq0R2EUZGQqMVSzXC4hOi8wuGjYE7hhOBv/GJF6U3uLEMdLgH0Sj6u1nCGQUPiZeDj4JYfi/C17UDzWOc2OR2EyckJDCsBL9McreZsdICEtut1FN4WauSmVRA9JcxYF/JGhiVY73Nudtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hwpnGA/j; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hwpnGA/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RT
	J65HNlcc4STDODyP0RS6mqSlOokS5fuu7pJzaZUd4=; b=hwpnGA/j7jD5nEEG1F
	yDcsbOpqeU9PZrmiYEsgLT7ptABex24+DnITbjVDIYMras55ZXDv89YupgIacCS3
	NHYr0b5fOYc0WMctCFQ5A8wK4K3++qgkqMg9bQ2P6M4BriesVp75I4SaOjT5WhTM
	MD/L5NpA/68LEKffAZGCBZtSI=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHJhfZLnlqp3VjOA--.14579S2;
	Mon, 10 Aug 2026 09:52:26 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 0/2] bpftool: fix double close in map dump and batch file error handling
Date: Mon, 10 Aug 2026 09:52:14 +0800
Message-ID: <20260810015216.2369940-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHJhfZLnlqp3VjOA--.14579S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWfWFyrGFykAF1fZF18Zrb_yoWkWFb_ua
	40g3WkG3WFvrW7JF4fWFy5ZrWjgFZrWa48Ary0gr1UJrWrJFZ8Cr4qyryYqFy5KFZFyr1D
	CFZ5XF4aq3W3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8A9N7UUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARq6eGp5LtoYewAA3d

From: Yuan Chen <chenyuan@kylinos.cn>

bpftool's map dump closes the map fd twice: map_dump() closes it on both
its success and error paths, and do_dump() closes the same fd again.
This leaves errno set to EBADF after a dump.

The batch subcommand then misinterprets that stale errno: do_batch()
checks errno after reading the batch file to detect I/O failures, but
fgets() does not clear errno on success, so a leftover EBADF makes
bpftool report a spurious "reading batch file failed" error and exit
non-zero even though every command succeeded.

Patch 1 makes do_dump() the sole owner of the map fd by removing the
close from map_dump(), eliminating the double close and the EBADF source.
Patch 2 makes do_batch() use ferror() to detect genuine read failures
and tracks the too-long-line case explicitly, so stale errno can no
longer trigger a spurious error from any other source either.

Yuan Chen (2):
  bpftool: fix double close in map dump
  bpftool: fix spurious batch file read error

 tools/bpf/bpftool/main.c | 8 ++++++--
 tools/bpf/bpftool/map.c  | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.54.0

