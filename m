Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A3314B9A;
	Wed, 15 Apr 2026 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223372; cv=none; b=iOinphL7oQVhK1+f4Jc9bNoJ36ZDrUXgBZqD740h+lNkZ5CES2CwhDHznjCw72BuBGsC9GYlAVpa4YX7Gypf22V4I4pTe4Q67zmivxIceDRb02hof+Oou0I9JOnTV14wHS/qOrBNB5bBwntb2mm4duuU5qBITS5ZalrrdfE+aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223372; c=relaxed/simple;
	bh=pBAvKrjns/Axo5ceFYD/aQv5TnGYVr27iIEO46ZGJXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+CJLSlY9QWDKxqzSQzrzpiyLErWOe8xtCnPHz7Dr6/bEE/Kcf+9mxF1vSl9uhFhSTXOBUyhDYjslI695Tr+8Di2VeIaIVxspTwz+RZOdSaGGSv50L/sX6SXz2ZMZE3sCjM+RT+IjN6loiJY3ZLYgEMst1d3A7RH08Ryg0Kjrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dtkaDLHK; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dtkaDLHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776223305;
	bh=7Q/bNUTr7Undg4sbUXiYVFibGM5GckgNLQ+IrrLRbM0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dtkaDLHKQB6Df6r9HYGCgg7c3XR+PkpHP/K3aX8e9+Nq8PXpIhzn4QUbX/D/E+aO8
	 U9LRudHu1NGCyycm2kPN6N9WSxphOJHgHLA5NZexQEqPey86Uik0aeZh0qAfi6iPp/
	 ySEo2FuPTdUMjKzith8p41r34vjHHRTuDitvebBs=
X-QQ-mid: zesmtpip4t1776223298t05808512
X-QQ-Originating-IP: lFugxt8XLSNjQ0M6410ZIjLkj2o19alX1P90p5h9huQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Apr 2026 11:21:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8791305521629641831
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	alan.maguire@oracle.com,
	kernel@uniontech.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v2 0/2] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Wed, 15 Apr 2026 11:21:24 +0800
Message-Id: <20260415032126.1096299-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: MDqtQ4jGWXAGyeu7S9Gt5sQofeniFH5CEM/L454SCriDtsg4CTfaqjVu
	UzSMxPD3qJt1p2if0RZGSTqbxOsVkWjR4hsGKdh5Un9ePahLTLDmvNS4XlrBJpgG/kJjZzj
	KcaEGCyYqklPBEGuMz4Adw5kO2o/VlE6GV10qwkinLfWMJUhO1E3idXmElQ0VifnWsjtv3O
	h2VNzCU9zF3yZ5ogJQmyvCRDxyCAla/AF4xLtm4hH4Jsdegkp9XbJF6oLYRrr/ggBNSQWle
	R+Fx6G8RU/1nkAD9FM5adkI6br8GltrXp2McslZp8qtVjDtmG/XM6nTzE8xBE3Fg7p/zMYN
	f2bXMdhGOfWXTo/vB5Dj7cse1n79cb+6cwoQ3WDC6X2P/KKkF9pZ3v5sSAxk6l8roqV7siw
	n72Am2BiEBnhVOfEybviqtpmIi5pt7mJMcbAD8WnQWyiHJMos7BLCk/xbHzxLJxeQ+aQ2YG
	Q03hlq6OveVNxf6k8Rqt88jDZSctP8xjtZKMvgFwaNUu01n4Ru7ffgqQhZyPEpPeLKfQZGb
	wC8tuI5VywFS/Motr1REQyR9J3p5+E2uXI5vZs77KxVXNM3d12/mYD4p25stU3caHPlFrv3
	kgHhYKvka9PSfRBXpgcY27BUx8hHwmm0b9sRNgb69eeZ4NkpySSwiS2QSM6iEAigrA+thac
	J1MFp1F8I1vV78WM89uOx3iOvldGwMzMS9pUNyYSIeP7Ut35v8brJbHPYGv/8D3ENnOEpAU
	60CZp9hEM6VNe2D52owypyeT9nmdYz0xT0JSxMF5xpRx8FrV8SSvR/C69NMgu9wJytU4P57
	igSnMCEaGNLOXvYhuP61iHw3lz+ReTh/EQF7CHrHQJQSrXrnYKtbJXgXxZZ3Y8H5uNR/yIs
	THPr/NkCeQk/42ao6t5Il/qFQ32TstjDwlaZsJpl97ZDcGhSfnAuzBcTaO/hCin998zoQa4
	F40xtfsP5/Hz/6D2juSaeiqSmR/QVVwVotd4JRvNdeM20HDka5x0tqNhFIjtQsz1SLj+ohw
	PfFQKsbJsP/grmH637
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

bpf_bprintf_prepare() currently rejects any non-ASCII byte in format
strings, so helpers such as bpf_trace_printk() fail to emit UTF-8
literal text even when those bytes are not part of a format specifier.

Keep plain text permissive while continuing to parse '%' sequences as
ASCII-only, then extend trace_printk selftests to cover both the valid
UTF-8 literal case and the invalid non-ASCII-after-'%' case.

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

Yihan Ding (2):
  bpf: allow UTF-8 literals in bpf_bprintf_prepare()
  selftests/bpf: cover UTF-8 trace_printk output

 kernel/bpf/helpers.c                          | 16 +++++++++++-
 .../selftests/bpf/prog_tests/trace_printk.c   | 26 +++++++++++++++----
 .../selftests/bpf/progs/trace_printk.c        |  9 +++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.20.1
