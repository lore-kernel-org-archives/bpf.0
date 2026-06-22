Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBC3368B6;
	Mon, 22 Jun 2026 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097996; cv=none; b=e+39hlwzTFp5m0dJ6iqTdKPHfOpsDVoKeMGm23v4cgl2C+ZfTGTq8qXd5XxBUxQ4KnX/+alg6I+Q0fVA4r2Vvs9hPt5zwcERfqMOiSUKgb05s5VENWe36FmrGJjoe/Rc0cBDTO3kftC8osC/IROtIOb9CnTW27izaSLZ36ttN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097996; c=relaxed/simple;
	bh=/ZPDUYBCyykfDe/GWG5nPCxfj6v6YGZ/DhiC2J7XtCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkvdHyXj5DA+lY5z66a1NRj7xSmPzuBsMt1TeHxLz2TsmKstWwyp+7uawf0RNj1Y7HDGff3dDbfIjBVGBQF1upLMrLCp7T+Y4+CyLnry+iQYTPvoCajAwyxKzu/YjuvHxNXI2RzjyMR/+nj3p+8qJvpZKPCXTCXDPkjGJd0gQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wyku1RBz; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wyku1RBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782097983;
	bh=tPEowK0ZkHkwOk56ELXAy+PdSCs06XVG9EsK4Wk4bJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wyku1RBz1V8VE2M1pKdjzqKgDWwYPbx5yYiAztGaxoUafMtoEd34UyF/KrPczh8mK
	 xBZcjDXowM3W68hZL2uruOiMXNfchbxd3bqS5q/4EEAXk7b0pHBs01MEfbKpLxOxit
	 A5MdxpuwGTZumVVIBvmvaiqbjWHHOL7GjPcTm0wM=
X-QQ-mid: esmtpgz12t1782097979t783dc95b
X-QQ-Originating-IP: XgxM0bTzdLVfcl1H/SToUVsVa+i7D2eL7+rhhsCt7yA=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 11:12:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9971594127160575059
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v2 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
Date: Mon, 22 Jun 2026 11:12:53 +0800
Message-ID: <51C3B0A22437ACC1+20260622031255.1160657-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MglA7JX7t2v3sXUpAPbysoh2zudoCtU58ATe3n/fl8rbqHB27uvYgcny
	8DguTBYVIbpM4ABfQlcLiVrQQbnA+NbScKHrrfz8QZsmQCXNLkbxZY8g5HtNxHkr4asCTa7
	W72ntCKbheOzmuQZuYVaUy7ap+FkncahvlYZ4Us8nrkqy1RJK3QMdlmUAuPzrZJAbDgebtz
	XGvNzAOFDCnORSN4ptMEpua+/XYQruHVbkBpG9s8tbNVIhIDoG5RgVdLp3T+Zz7WaFjvUz2
	xJzZ+tUYg+iKiQhjTM5wfqxAMyp+iKZQHxKbaagsx22OOnvQUl5Xi8q7yd+vg2VHkZ1r/a8
	zl0KGuRwN8MRWhpe1QTBd1mlWFnN3I8dnf8ljeQXM4yzNvqckXaBzRT3rMyhak0VbWI5J2t
	lfqTEgGyQFifhuTGE1fkl9i249c4rZtYpj7pTPM1cWjmJJbMYDBmWJtovzrrSOTofvxdMb4
	GSKyAsNEtAKbuUu8mD/w2VBJsuJoawfi8CtzqpYMASbIgYsKl7GNLz+KSP6l6MP9Wr+a8xN
	JEB0yPPqpnblNW3UIIusCl9j0XMQoGO6775+lrA2AWqQ0aZRvu+K0yVavmFaOcx968wp8oH
	cnQa8MU1mHQfZt2rgcYc7X49O2ngOdYLZXI1T9OLlAi/F4eRKxN64Mam0HIy+KRQ84/fOAR
	ddRibFLiIDZGdFX9seRGyQKqYwTHV8njXqnFRveTXk6gFmoLpKnK2+wQ4pXzu2jwGwu3ZSt
	flLQlX54Li30X0cFU4UEsLJMq0Ggz36pBFNau9mA1fnQ8vLJuZ2AJmCePyRP9Xo1f3BfpZh
	A3tZmtQzB9YQgBRh97oCWaZQjf8QvFzLzM2Exf1a5XHdjfkppzhNetKmse96Q4rUM1GgmYi
	brScDUmsfpziA/2UDUPYep3vJd5eObAfLC4ZBUBoTUwTWL7ycr5YquyIyB7mVciprnk7Xky
	NDSBZ2eDORCaQC60QsRddJY7eP25WAbstOvofJ+jh+4xeszjuSWH4Mq2RARfByscyL/ZuBm
	aLcrNK2pc7zrbQzfhxCZ7wlqpPoWpddO2hqzSjcZvzVXs/qy9f
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This series fixes stale vmlinux BTF state in bpftool batch mode.

Patch 1 resets the map command cached vmlinux BTF pointer when the
command releases it, and avoids freeing the cached object from the
map lookup path.

Patch 2 resets the struct_ops command cached vmlinux BTF pointer and
dependent cached map info state after each struct_ops command.

Changes in v2:
- Fold the map lookup path fix into patch 1.
- Update patch 1 subject and commit message to cover map commands
  rather than only map dump.

Yichong Chen (2):
  tools/bpf/bpftool: Reset vmlinux BTF after map commands
  tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

 tools/bpf/bpftool/map.c        | 12 +++++++++---
 tools/bpf/bpftool/struct_ops.c | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.51.0

