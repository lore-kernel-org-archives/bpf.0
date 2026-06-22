Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19613959D;
	Mon, 22 Jun 2026 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095650; cv=none; b=sOx1X7DmfsmkuaP5RnNYkf01A7k5QiYimJopX45eIW6OdhWdVVO6HCMX7XIMxln2IxSGfMG7FBdbV5OZxUdCDN+P0hjJfm2YmtXmlxUJ2a0RiAELEdyOQSFhqnn+OAZzkThIj3AiJg10CoMptJjNZnywSSH8iM6IvcO2uTEitoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095650; c=relaxed/simple;
	bh=khwZ5JIVwSZ1NhSaXNTpAEZRhO3RlW9N+c91rw43mcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruRn+ZrGWvmBSNi8LvT60NApbrTqCJua0IBClsaoy8OWcEn8kT43+TNx0NF/v78yfZ36SeFreCRF6/Itn7yxNjWUp54bNwgyqUAR4PbupQUblanq6vDb+qiZ3y7sG/7/6UNiKrLiD23dAuZAf0nLq1tOr8079xQkMOyITjywulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=foIQIR4W; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="foIQIR4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782095637;
	bh=zkM0mwQWLdUt/61QVoY/hI0CiONAuMSGZCXf3yiwhDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=foIQIR4WFGYtl4VUPw3UoNoERabNZlDkH73tHstio3o/xgnpWx75s0E2conDBJ/9A
	 Xg6gwgc0/61ppf2whdNyeArrI0Wepc346jxLUfFGG3tGH9U/kFnY/vNbLp6gY+Fic2
	 3rsMjHQRTe3u9dCV61j4/T0kCghOex2VrtsDRicE=
X-QQ-mid: zesmtpgz6t1782095633t102d5d30
X-QQ-Originating-IP: qj9Yfxg5kewaT7b/9Q8nt9t1lWwE4M0mLzWI4aFHoFo=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 10:33:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5565921049161856003
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
Subject: [PATCH 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
Date: Mon, 22 Jun 2026 10:33:43 +0800
Message-ID: <10C16C29BFC7DEC3+20260622023345.1135373-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEAatei6DLTN2UgvYbvNILNLFAabN84UC8wprUTOuRukCjtosDDgWWP7
	jyjCNagrR5xp9Y+ZuFfZnzeVugMVY8fOW13k1HHTUx13UIWNRDBGx7sIAhzU9azun5IsX3x
	8zqNuj4XdGrxr0RvCeydtMbA7Pnd0/echRMSjybEKnTmpM5Rg/EvB9cwlCO/3ewsWpEBzv7
	WTQqHMnXJz491DQnEILcq39OnWYDAqowpN53rXThp6VNgBJuVAdEODjo9DaU21BIm+iNKvI
	CdQFsNSGzAbIKtquZjNnkG684NHsDYNU+GQ4Y4R9NwmW5rgFhHu1J4NjUuxF082kqi76yyG
	ixxZqjTdxqYyd0FnHJpe0dJ5sbrpk7HyFATcyKO4GPu6iAgjzLtQCIemrkL7ogat6lF8Mgd
	ubF7mZZTgITyJxWI3KQpuimp4+LJ0ZccDEtIFGsHLhm5vqsVIal7wx0lFWYMpUutAKj2H0h
	zclG2omlZEgq0U+auHUkXEuGUaznEdJi8KYhl+uROmxKDI/wd1a8YcP0gdD4YJ0ORyengVj
	M6NeCx48zqrrt1/QforlETZAZ2mz1CZSHWqmfycXzCo3tqZ2N9weNa8DXoG12vkfhvshKEK
	LQOv+dnWyRjtTOKN6esDfSiFXu6/ZyNwN0ZSzD4KPrSpicFyJAl2oTYSGt8VQ7azMORqHlq
	DjfduBc4Ow+gzcxd1mG54YV4mcfqznQFwKKgI5adNA++DiYoRHldlJOm1dzqRzdU8WzOIJW
	4DQd6nECVxQ5lv36GTW7f/vHTBC7ILlo3a2A33HwULqlc/bd371lU1kV1BXAPb9+wz9h3/i
	kWQlwYVRGKDUgEwrMpD/tWxAnSW5XWMMbj+bfqZI4mBatl1frxGQEEfm07RxD7yp6128Yls
	ARh9yWaM9fnGQ2BOOqmB2dIkreXV/8qzHMnJTK0hUafR94NdhJyiP414riiaHh99WS1Ua6Y
	ng3eDiEM4jo7zQ96pIG+8N5yMyOmyD0agDtyZyZmpd40rSBd5w5tEJq7eNe309iDs9wUx3E
	YXcQOXMMdoiANZqOrnWSXijLBDvvE=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

This series follows up on the bpftool cgroup vmlinux BTF leak fix.

map.c and struct_ops.c also free the global vmlinux BTF object
without resetting the global pointer. In batch mode, later commands can
see stale non-NULL state and reuse freed memory instead of loading
vmlinux BTF again.

Patch 1 resets the map dump vmlinux BTF pointer after freeing it.
Patch 2 resets the struct_ops vmlinux BTF pointer and the cached
bpf_map_info state derived from it.

Build tested with:

  make -C tools/bpf/bpftool

Yichong Chen (2):
  tools/bpf/bpftool: Reset vmlinux BTF after map dump
  tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

 tools/bpf/bpftool/map.c        |  8 +++++++-
 tools/bpf/bpftool/struct_ops.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.51.0


