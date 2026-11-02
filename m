Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609496;
	b=cH/qAEjSrHKrpc9M5+OPaNvLLpmi5//g+yIRkf0vXWFd26u24jq8VAGJiBs7dVkl9Hph
	 zkolXSsZW349ZXWCkwmU1Acp46dezO31uS6WzAtY8QpqHnj9zUe5lpYMgpxn/LrHPRGB3
	 20yoXCKvFlI/+ZwqhW7vX4s9KkplRlMmA0UN+vAur4stvz2qXZnBIcNwSf83TCFP4xy76
	 YuOxrBdBCKMly3hP7qs690Y0gNBVOPLJOreAFGE+6q5Iayn9FRIewDIljF3f9ZqK+//Bw
	 cjW8ETcSjufSXCjCL71I/m21yV6lCVNN6SCVoNxryRkYfykZ5/jHYNq2LUEKeDnkuiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609496;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dDprn+GVk/HXWFUpZUf+4qK0Drck94qd63Wb+S4GwuE=;
	b=c+/YLd5qLW/g85tW2pqDqo2mr0krCbY8DrkQ8TEXgcONgyaovksUSTutfgCTxj8RTAok
	 /+9nVC0tOld3dN14eCzeSibzt4d/xpxZc7Xq3wLXavFkTxA9UcvG08z7Fp76EPPVjku5h
	 TdcEfyoWM2Y3RWDMi7nQNkFk/OyWIG1zCsG6CLkuMN5NW0gjsWZ8Y+S85RWBOQJB3H/DX
	 jMUIH+HCdTsUJVCkxZTByM+aSAhNmloEf9CjtjGf5P30XWPevopICsP+NvSaBhPmz6C/G
	 VG8dp7arOedh6htYP7VujtRX5/71hYbQ6Dn2hwNV7umRlFmiILBZj2YV2Gnr8gLubkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="x7tw/7Si";
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE420606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE420606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=x7tw/7Si
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=x7tw/7SiH2Ps26gGestIHsZsVWIiobWimAOC8HVrImNAA44ShcbYbhAvPOwgo89V/LvI6iPSbWUN7
	 QirfAqhpDitgjEA1IY9IRaQrVfd4kG4nAlz83P78A07f64RRHmTRUcb15zREFg7S/OQ0jMFMm5RX10
	 es8TmwohDN+qIeXU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ae84f1437b-27f23;
	Mon, 02 Nov 2026 16:51:32 +0800 (CST)
X-RM-TRANSID:2ee86ae84f1437b-27f23
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76ae84f0de6d-cb943;
	Mon, 02 Nov 2026 16:51:32 +0800 (CST)
X-RM-TRANSID:2ee76ae84f0de6d-cb943
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com
Subject: [PATCH] libbpf: fix missing minus sign in btf_dump struct zero-check
Date: Mon,  2 Nov 2026 16:51:21 +0800
Message-ID: <20261102085122.916-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

btf_dump_type_data_check_zero() returns -ENODATA when a datum is all
zero (nothing to dump). In the BTF_KIND_STRUCT case the per-member
result is compared with ENODATA (no minus sign), unlike every other
branch which uses -ENODATA. The function only ever returns -ENODATA,
so the comparison `err != ENODATA` is always true and the loop bails
out on the first all-zero member: a struct that still has non-zero
members is reported as empty and skipped by the dumper.

Use -ENODATA so non-zero members are handled correctly.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7dedd3975c39..ea9a34db4c00 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2567,7 +2567,7 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 			bit_sz = btf_member_bitfield_size(t, i);
 			err = btf_dump_type_data_check_zero(d, mtype, m->type, data + moffset / 8,
 							    moffset % 8, bit_sz);
-			if (err != ENODATA)
+			if (err != -ENODATA)
 				return err;
 		}
 		return -ENODATA;
-- 
2.55.0.windows.3



