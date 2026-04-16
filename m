Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF734E75A;
	Thu, 16 Apr 2026 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341083; cv=none; b=svXCzXWqbp7suCe5MTRs3orUWb0jk29Kg8os7hTHji4AxwGm5gIptkKMrpXonRHFiSm9NmW9MoUfi75Cx184XdnSu4+lC090PuKcC2IcRsmPYQhF5KvkkiWgX5HgngyRu7iGwhH0oW9bQPHuCCx7Rvo3ecTplEcGCIl8wu8pBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341083; c=relaxed/simple;
	bh=vZNQNpIw4H7SO1r5j8NSoLxVTOhROOOBFl1MGRPInRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnxiWosurg+eCKbEKXk8pryDG5VIAeRJ576PkBsAWPJs3srIR5ooLUzy4L5Ffa9X+PnIfbQXWxnKKenhXibq6rWZiNq484ySgVlLYFrpYWsr41sqICfTuOiEcZvF+Ub9aiZv8VhSZf17R2X4FO8C+z4/ATzkUtWyA57RQRTAua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AmK0Xfqn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AmK0Xfqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776340959;
	bh=mDM9a3qQvuS6VfQ/YyHNR+fXyCQC+/YdCMpedCf5Qk8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=AmK0XfqneUtYOEOUt7T7+uXNtmkhzaXtHxCZQUxStsf/uXrzs05zrlm+Ty4n0iHd/
	 v28WljjCxz0xsFOSMfwjABUBRsQadM0B5pGFrprWk8pJH/ikhsmUEIXxiV/j31kM1E
	 HdXAQwGKQ6Fwqs6PuI2aXDNA7qIb05WCK2MFgFkw=
X-QQ-mid: zesmtpip3t1776340954t67847af5
X-QQ-Originating-IP: AeRIYq/GtQf3GJPLFbv9aWR3EIAGACME5UHwUvPa9r4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Apr 2026 20:01:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13703673177878313586
EX-QQ-RecipientCnt: 9
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	alan.maguire@oracle.com,
	paul.chaignon@gmail.com,
	linux-kernel@vger.kernel.org,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v3 0/2] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Thu, 16 Apr 2026 20:01:40 +0800
Message-Id: <20260416120142.1420646-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N4i6onhdodx6eptcjDkzw0pwtYj7m7cjpBsL80tcw0FQyFWXaRgxeXdC
	UaBSJ38XeXFgCyO6Wh5/EpD6ELpD/dqiXuaPf88d5F64lj2vowAmg87KKjGtMPCRYP+30v/
	G7UmAOznm1EtEYmRQUIU6nrMy3+4JNiZuyElCkA/pvFK8+6GswADrlkCYTy/XVrwXYTiF+o
	b15QIDnGV/UzcHMQYZp61idgoLGsdDPV6fjdp00FgkoyK6LtmVOWLY+A5CkjRapqbTwVG4g
	jF+VSxyz2b9SWxm2diGslZ9aiUPFmILgzyCmTGjfLjpjA3NNO5NE5jzorm8gBnHYKw5AI6h
	OOk3M7VNAgIEP24Nuf5TXNVfoD5phLI0rO/pBN7vV27U1pCzitioJCRWjX1DnUFSObSzItA
	SweNcuJ9piINaBZl3Jyr8Ii1KNfMubBpnBFA8tqy4pfYS7n5/G3SvYupWJyQ+MPQstI5diL
	AxkSrYWPfc9u0NlhQllGRbhR9rocbRIpgVMXShyBhNWu1Wpe1qqWQp/90E0i7mv7VIGolmv
	Mo1K6vw8hsbG7uh+IjjjQHDDsxKkssfEQK19l07JBFPhzZY8dolpVwYEwY64LKl+NHir4ul
	eXAfql4O17ATCaxt2JzFguuS8zv9oH9ZN5sTS5A0O8cotGJaidJVo6aXvlIh1REugrLSQ5a
	JFdZa1sCXHjicNpa8+tGsNvWZypLb0Wg6bx4HLubUY5jE9bSF9Js9gVxIRPh7WuESb70OKG
	sXEs8hw6pYrhtOhAMTK04cc6Dp8tzAVtYSvaYKHeK03guflcihbTFkmxN8GtDxesdoo/Owe
	YeGoL5aBG2kWKqBpYeSGVnRuOLZ6XTyJs58lCFNtf55Q7HBw7jv1qMMkFkI/3t2Me07eTUR
	cTdW65t8MDLBJQ7AII1QGBkIlWIOXz9ixat1xTc5tWAJ38Z4Vk3HFt1ywvOmW7qel8WSokt
	4mwDCsvwJo8qoR3kfRKY5Kry/RpBSk2qcufjCoteTdiKkorf0UhnSmcwzifTf1CgIkAtrLp
	xm8r6qotcQBqgED3VM
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

bpf_bprintf_prepare() currently rejects any non-ASCII byte in format
strings, so helpers such as bpf_trace_printk() fail to emit UTF-8
literal text even when those bytes are not part of a format specifier.

Keep plain text permissive while continuing to parse '%' sequences as
ASCII-only. Patch 1 updates snprintf_negative() at the same time so the
selftests stay consistent during bisection. Patch 2 then extends
trace_printk coverage for both the valid UTF-8 literal case and the
invalid non-ASCII-after-'%' case.

Changes in v3:
- drop Suggested-by trailers and move review credit into this changelog
- update test_snprintf_negative() in patch 1/2 so plain non-ASCII text is
  accepted while non-ASCII after '%' is still rejected, keeping
  ./test_progs -t snprintf aligned with the new behavior.
- clarify the trace_printk negative case with an explicit invalid format
  string and comment
- address Paul Chaignon's review feedback and keep the negative coverage
  requested earlier by Alan Maguire

Changes in v2:
- split the core change and selftest updates into two patches
- drop unnecessary isspace()/ispunct() casts
- add comments to clarify plain-text vs format-specifier handling
- add a negative selftest for non-ASCII bytes inside '%' sequences

Testing:
- Reproduced on x86_64 without the core fix: ASCII trace output works,
  while UTF-8 literal text in bpf_trace_printk() is rejected and
  produces no trace output
- Verified with tools/testing/selftests/bpf: ./test_progs -t trace_printk
- Verified with tools/testing/selftests/bpf: ./test_progs -t snprintf

Yihan Ding (2):
  bpf: allow UTF-8 literals in bpf_bprintf_prepare()
  selftests/bpf: cover UTF-8 trace_printk output

 kernel/bpf/helpers.c                          | 17 ++++++++++-
 .../selftests/bpf/prog_tests/snprintf.c       |  3 +-
 .../selftests/bpf/prog_tests/trace_printk.c   | 28 +++++++++++++++----
 .../selftests/bpf/progs/trace_printk.c        | 10 +++++++
 4 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.20.1
