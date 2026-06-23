Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328772E7386;
	Tue, 23 Jun 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199375; cv=none; b=K9DhjPFV01ZpP/1NkPrm33XR9TmelOLVhsGVFADScfOtCn0Tt7ZrdnBPR2pIwM7It0H4ryr7wFkctFC7Xwq4YoFRmieGWD+GAsUodGPw0LxXL3h+bYRokJOoLuN5Esko+ZoxkojWqZCegSesArrnfUAu5VIQtvuNoMgL1SSJiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199375; c=relaxed/simple;
	bh=DFI1LIBWtd5fn8GPV529SKqsRfA45cuANBurHn+YrvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5V2q2S0DvRTkZv7UpS9uYUB+BepjG1FbuO/CZcIHljfuMPaVZ8ZeNdbxTU/Gklbtyf0Y1uzpzGOD6TZ518l/hoAmWWoUVgtHXmDqRS3xz4aicnx1PzKmFOia9vXxtTNEyTIjA2ZFLoSemvelYpjENWU3cnt4xJn4JCB4hx3Ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LDAm3jx8; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LDAm3jx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782199359;
	bh=6XYu/PJR7RxB+BI3VRi1O7ybpIuejvF13nPF8XntqOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LDAm3jx8HquK4q54F6Lmcb92LQtJM5n1sx+U68Zd68uNAf1dx7E54ag5G88h5R7Ua
	 uOPArWBXkkgnNJkuATKBJ6y+GpMhuiMjavn1lDkscjGvg2YGNRA6sxck1sx8Dg2RQI
	 7WQDvdIeISTl6xoFNSHZonhYIMvN3nGG7yW2prAk=
X-QQ-mid: esmtpgz10t1782199344t49d05063
X-QQ-Originating-IP: Kn1fxbvezAqqA7BWDncHyI2MhQh83tURCyuXRmNA1vQ=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 15:22:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15282953426575488487
EX-QQ-RecipientCnt: 14
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
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v3 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
Date: Tue, 23 Jun 2026 15:22:18 +0800
Message-ID: <1AE44FBA46394038+20260623072220.1421837-1-chenyichong@uniontech.com>
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
X-QQ-XMAILINFO: Mc/7Da/97eYXGkcQPS2iJ1iD9q9OQP9ksyz0jojafvYI+pAefss3wWpU
	6cKo0k43l8gh/HxvD78eOJRpWHHphkcyZUxSPzbzDBqME/IOe2Qvbkq2XVJWlFu2HnkEhEH
	dsptwDlqjxaLSnIuK7QiXzXAOrnalUMQI0vxKwqqvfxLauyml5mwpRUUwy91lsqWuRnTLzB
	NlZhvi7CoO/uMNCtaxSgYjFBpcwfEUwPqhgfuGn5pxVTkLLc1gavw3dLNtutBA/jW4R4E0p
	Q8wvwfRV3Y3dYZddpu3LaB79n4C5K7H+N/16rSByEii+RnZnr71yAT8W+RAGBV2vkZFI1D+
	uDLLJXOvC7aCUV2po70y+2yxRN0bJH2ZURUMoaOYbaRfqbiybFOvbYha94308xEcRwoMwMN
	2N1bEJbtCdI45cNiwQ+VcxoqxPZlULKbRhDPJAX5UwRBjOeoKUXjdkCqROYQdlyIaTXcUtn
	r6eQW9OBFYsuQMtxtErjMKllJ+tf4/bw5q/s90DItdqD0Lw1UzUyy5k3wBEi8+S8QvHBJpv
	W8LC2ctKoalw1n8H7UcocjvvdXG9EWull14pfr8fYt5oisddvEPA40kg0FufN7CdgFDBqrM
	timyIpYr4Fh0v4IvtaJQzn2vWJuYZ2oh5MaIpfvuzsFeA4Cj+XFkQyW4a3q2zUi59XgLyBD
	04PaVy2jQ0imlQaBeMPe8WzxdDLedFUx9HWgkvXBw7JC47+jfmBKeSvrAezkMTc9liBF7Hp
	9GnPtwsKMLMJ46TQLE3WC/geA8lGz8DUpR2ro5TkCHqU+lRS7Gjq/3qcveHUCSa+j498zFV
	IMYDrKy+bALF8aaTYp1pANZkOTuj434VXJzczqdSaptXv8C8qu5FbRgspwpZHJUQ3cGZx14
	wmXG8h9VDlASzdlJsftNB2jtecF8+xOdDjzIOaUJMYPK4KAdkkyjfw84nLrxfoQfTLjr4Nn
	GdkWdtqeiZX95ql9XH/UYmWP68ZHVGw0e9L4PVS1Mh9UoDOlZPmsDye5OF8l8QnMTUEjSEm
	3ZwJ3zhTgdjBeEDfs66KSRy6ZSPGtxovsYqoSA/jAh84g7R3xwAzd3+WBX0Ww=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

This series fixes stale vmlinux BTF state in bpftool batch mode.

Patch 1 resets the map command cached vmlinux BTF pointer when the
command releases it, and avoids freeing the cached object from the
map lookup path.

Patch 2 resets the struct_ops command cached vmlinux BTF pointer and
dependent cached map info state after each struct_ops command.

Changes in v3:
- Add Fixes tags to both patches.

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

