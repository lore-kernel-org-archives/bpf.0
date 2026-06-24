Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF301704;
	Wed, 24 Jun 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269489; cv=none; b=sVOHGu0w4r8QMTIiKZITM3NmNXg9yP5ZpEhgFIvcnRrXZ7JlHKEolId6xM17urD94mAyVCcRMbEs2+NbpSb/mtKXmo+8mRypFM4sbpXWARPSeOO7oOQbYofGTvNNvD+cJs6uIXAZfbZCryGe12Ndq+MeBkPBOIAFSu4Gxbmi5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269489; c=relaxed/simple;
	bh=YuQBgLGrwbt5NNoK2TXmxbbRe+g0od69APdfoxypd00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSm7brmN/mZKTyWP5lZHe3s/FrhlJMqTVPSQIAQkheZ2PFeut4Xwxh6HslvSXKc1abKHmrCBS+83hR22R4fnNXyrLHkJGdiBHZdZjcceL6WxvOIY/nxIlIAMbisqwcK8ER8NUM/lX9wWQTPNwyVftPbOtGYh+y/Z+1SMj+SVWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oCG29XjO; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oCG29XjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782269477;
	bh=8NInJpv0Z8RquFijf09Q/SEffYTUfzHVXU/Cv1tWaYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oCG29XjOuKVkXdISkAwfytG9z2pdbWRtYrYl2wIWgCNkolBq75TNpaphW82UruVW9
	 FkxTNelntFZWts7p4qRrx0LM39I4PbMnsXZClEu0Us6mGcZzrMuvzCi+aci9AvtDrE
	 9biSGBJbE6GlmKdsA+Jxyx+OvluLHs0XWrhRN4+U=
X-QQ-mid: zesmtpsz7t1782269460t4de4c060
X-QQ-Originating-IP: sWVUMBflyXRMWaj25iJXY4fXP6QKPyR7u/cQONtP1aU=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 10:50:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12875591471964563957
EX-QQ-RecipientCnt: 15
From: Yichong Chen <chenyichong@uniontech.com>
To: emil@etsalapatis.com,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: chenyichong@uniontech.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
Date: Wed, 24 Jun 2026 10:50:53 +0800
Message-ID: <12A35C14DA710D2E+20260624025055.1574875-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MXqQCeYgv6iWDTzphdTGrXuSd6UJqE2dG8r5TPx0ixU+8PS67HRGsn4a
	LTZPZNHu1iELBSf1uJbB549GSAFToa8/cahUecLRFkcojj8/xwAMsmQgVEqa3ITfgmsrqR6
	ZwAzsbOx01jKYHgiTTWxJG0bE49LdwoUBSEaxl0JW7zxnnBe3WAEAfpOcUK/3DDNZC8oXJ/
	CK8/EGHQDyLZOvdurb+sF8R4tkO0FBFUCaPxak5hDYat0CtR0cc9/p8lq/H9eGW4DvU8scK
	yANgNP9inp6ApBZxVKMxdMqawCxeXXQwwZkM+zdr0drnrG4AASHzit5XYjpeei1xy9Ys5pY
	SrZIkwcin1gIKoex4ptdzxPU+hsfeXBL5BUiDFSA2Zc0ruGQRystAP6byn4Cig3ZVkHNnkF
	r2tLahpLi7R1Q8h9LxcDFWpMIpQ8QXjn6K6nq7WrmTMeygjBsHszX7tvTeuukGGAQb16Mgq
	4UMsDSTkrKP8krGU+cXmrn08+fUncpjprB6/t4SI83Xxp80P052+MBYHmsf9SdDPxOhhIvv
	IODXusxhRZ6d8PNEP65HW0ATNJKvihmnbEd93znUUlPC7jHzVGJ726+GiKWXB7KfMai6YXT
	v4rYqZMem25PKG2aRBkdRX0xAdyJ3Rw2qHPFj86LaASVmkMqAMyaZX68198jWLgUVnQJCh7
	vC9cOf4WtIovnzg+r0Oe6ygn7QqeQwruv3GEYODYDWgcAsKcUas5pn/P6V4w99X3+/Jqdyh
	1d/ZObz4M4Czulfczj5SwNd/CYcZ+5TldsvsKsYYM8lWZr0AAxRs8dbb/jAxpha3NmtwKH9
	xkoUp8zC9lSsuW4sC5lqOOjEl+dg3UyeLRx8SD5z3SzgFHelY6ITalyfqiw6hAgvG56EUuo
	KLzt3W6vqtqqYz1zsllSXTWG65hKPhml6a3Cks/K89xz3+EiFfqkiXkYfMutC2toEpguzhv
	4gPiZBszb6gThikuI+gi2M7ptq4EXM4JRWw1zP5JaC8BEXumuSA2eAfa25z8P1F834MsL4Y
	QMKDz3JA9DnBM2IM3dK5xSv2uXS4b08lih+gpekmxwitajOeRr8grHTw8Av1uLDuL3KbHaY
	RsydPXZapD5P2b+EBXOzME=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This series fixes stale vmlinux BTF state in bpftool batch mode.

Patch 1 resets the map command cached vmlinux BTF pointer when the
command releases it, and avoids freeing the cached object from the
map lookup path.

Patch 2 resets the struct_ops command cached vmlinux BTF pointer and
dependent cached map info state after each struct_ops command.

Changes in v4:
- Add Emil's Reviewed-by tag to patch 1.
- Inline the struct_ops cleanup instead of adding a helper.

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
 tools/bpf/bpftool/struct_ops.c |  4 ++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.51.0

