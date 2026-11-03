Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676394;
	b=PoPgaIzEHWxgo2hVOHYYC1M9ZAAM67vxgJrO/JaWJ1W0AC8loklp7E4Pa3+lnJxAmGC5
	 fdUcbSz749OvR+SNLLeF4wJY6jZFTC5tPlI+/D4fvG0mtujO9A8PTRHl8TwT19C5EPPsR
	 NiMc/zisLzUiiRsJn4MHM40sGC4aaopTceNkgmdjkaSlYGLnh2Uz7UX/kC1OOnEzrXvg4
	 ej16gBuicUisTIFQVf+1FgNK3WN9WLCvHoxGTfenrujW+SfJswMOjpcxNpqBAdsdLOf9Y
	 hnlcZ+Phy/DmW/Kej/6hPgiRAERGOLztttGhql6QtTabP4h58Ra51PcpvYb/d/xBp9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676394;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HMtKL/cxIoP/sRo9iVHMxA0f7hhSpZjyaXH5lifPfBc=;
	b=pd5B+kNPf7revfn/Fhdbc41pO3SlTV0Ah/YbNMbpIklcm4fYXRHGSFYbDqySKqoOUJxH
	 A2pKbh+OTGga+nb9GEfkdk+zsDfHJ1lusysiYtQq4qn6CDrL0WNIQ42Dc138n//0ICKWg
	 zzclFd79RDp5gzhYa4tNrw8slMIIcXCyuMWdwuMIWnkouNLxQ9WnsYFOdZSYT2MnKJhf3
	 mKzvtXRQz8Qrto6yLKSlWwNJqUAV6EU0+J4aFoFQI6GSyTGZ8gLJwLZFzowlcoUa9eYvh
	 9dV77imZzfwxMEg724+P7anH4cf9G3grP4J7PdmVBak8dSa3o9qTePkQTdmQk/H9d0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oedGgSsu;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF1F606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oedGgSsu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=oedGgSsunzg9MKvELelIBB6UO5wlORv0wqEEx4FIKJ56RkCGOjgV+YFf3vgS9puzSyuUHz4i2khyz
	 iJk8FpF/GIWluyeytYT6VrcO+R4YTQe5oX2ILEJ1Ov5Qz07F9swjjV18ejBHAw4++Z1eLK0+UVLv22
	 s3UlyU50JQ6qaVvI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26ae95465718-cb008;
	Tue, 03 Nov 2026 11:26:29 +0800 (CST)
X-RM-TRANSID:2ee26ae95465718-cb008
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae9545dbf2-e8c5d;
	Tue, 03 Nov 2026 11:26:29 +0800 (CST)
X-RM-TRANSID:2ee56ae9545dbf2-e8c5d
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v3 0/2] Fix OOB read in BTF dumper zero-scan
Date: Tue,  3 Nov 2026 11:26:14 +0800
Message-ID: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
References: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 fixed two issues: the missing minus sign in the struct/union
ENODATA comparison, and the unbounded zero-scan.  As Alexei pointed
out, the sign fix has since landed as commit ab332ec8953d ("libbpf:
Fix struct and union zero detection in BTF dumper"), so this respin
is rebased on top of it and covers the OOB only.

The overflow check now runs once at the top of
btf_dump_type_data_check_zero(), as suggested, instead of in both
member/element loops, and the direct *(char *)data == 0 test in the
array branch is dropped in favour of the bounds-checked element-0
recursion.

Patch 2 adds the requested selftest: an all-zero
union bpf_iter_link_info with sizeof() - 1 must return -E2BIG.

Gu Bin (2):
  libbpf: Fix OOB read in BTF dumper zero-scan
  selftests/bpf: Add overflow test for BTF dump zero-scan

 tools/lib/bpf/btf_dump.c                          | 9 ++++++---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 7 +++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.55.0.windows.3



