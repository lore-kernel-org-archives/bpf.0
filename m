Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA533D5C38;
	Wed,  5 Aug 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916685; cv=none; b=ciXquILyzHOV6XZTBSnmWel1b+ZaFRPF65iTjD2EIB73LuaGhalXunra199pci6/Dr5UzwQqh2W2TUgnYssxXyPLufg9yZ0MkTNnSUQ6532c+hMwl9o10dD/vP5TRkiQr5fuVdHVWQkC8lGE5qWi6DaMmRtmM0Fn3If2qew4Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916685; c=relaxed/simple;
	bh=IlIpVVDCu2/pBkVBAV+9IjOtvtLRfuxo5io91gQRtsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEaEwbI8MQWHwi6PmAG4/t73LZgqaVjlpAtcdU7sNbzZDtFulYKqinUdX2m3x6MwvdeuEMcELVgQSIPBnIrVjyUl8TIJ2PNvGq1KQ6HBwWY0DUr5GEbuZCtMycXg29kdcAjBIKz+sXVPxd78RcxkYWCsskGC/KQAphpTFw74xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XOcvAYqF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XOcvAYqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785916637;
	bh=uXnfGp795oGSOt+y84mHcpLytElAWA60JD/wU/dd3cs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XOcvAYqFIQ2oRxQlWlCSsJEvHWMsP2FHSoizeFmQeEa2WC6yUjpGyuXzAT7//HK94
	 UhsNqmHWfUVfRp5cZcnMYfA8X6tUzjat46kR1PM0s1LnwmFK6l9fzZ9hJIdCR/PzLu
	 Y7BzS0OUxkyzjdLC1bvJvQxGZXGGyPEt8a8Gxzs0=
X-QQ-mid: esmtpsz18t1785916619t352635b2
X-QQ-Originating-IP: yiRvrg58MR+0yse8xrb2gtoz9/DcdT37SkPfgcFx0X0=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 15:56:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10778487376398331387
EX-QQ-RecipientCnt: 8
From: Yichong Chen <chenyichong@uniontech.com>
To: ebiggers@kernel.org,
	tytso@mit.edu
Cc: ast@kernel.org,
	song@kernel.org,
	fsverity@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] fsverity: reject short BPF digest buffers
Date: Wed,  5 Aug 2026 15:56:55 +0800
Message-Id: <20260805075655.950308-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OXWhkXa0b/rwAtuWqU4FmVlXXEbmGCbDS2w1xII/8C0Pp5S/6stsOJsO
	Wk9dHrcu+n/JUYkJwpZxmZnBTD4xg2sKNZKGxi6h3MCagqjs+sshNAO6oInh/xM9OsjUHT/
	IvL1E62hvHooj9l4khLD6KFmI6cYlFq7PXpfSdcP+N7Z/8yyDsDWVriUoUKI+lELxPy8gIM
	5x51XV5/KDmKh+xS8ZYBktRBJi7JB1ynjwEGeMW7y4gSIX5PGvF5cfv8LtF4ojaqvp3V2Jq
	QD7EBavj9Cr9wb1jPnntOb4nHHvcf+6sVEIx7CQYcvu/GFmGaawNwSAY5oXUeJxyN/XqHWX
	DMwlBMxHBPK+O/7XZjTW6Had87k7Dnu/QVq0dJ2yk58Zul+aspmDnBnVB2xmNezszqutA72
	O7cr+ceeUD64f8C2cisGrq/4/OHCbSgliHgHtg/zki+G93KVV6YpWwE7tGIxopIB+V9xwLP
	r/6z6TbJymKYWHmL5SDh0uqtAJP77n4+KjgVOoRn+53m82v9e5lSnuLivGXtlRPhi1ky0d6
	LCBMJms2qz0rTsiQHZJuGHO7hkvVb8u5lDlCHdlfONfwIpPsWdYdTiT/fK6cr6WwDkPepsV
	ZeJYvqkmD40IkNDOK1bB/gaCy1P9c8o9OXrcQlF9yYqjm2JoATBSCV/TnKY+e1z15RTLrFT
	9k+zI+0Y+A/NUWDPrGLTq92dRNFV6O+lNQVZO10uKPzCQQAyA5Ngf9ddu/MW5YjYosJy6xF
	Yuq0FSGDQfAtr39iMgcTe6pdcrVilDa64I8qXIcCDhRaDEMNhdd4NZ8jH2U3zpFrVYjkPbj
	nBs8NL7FgdFVUxX+iob16DlNv4Bhr0gnJYjdJ/FmK45K/gGebJpRshB+avgvuOhTROgLRav
	q/Fk+qpyw4ivYo3M4+DPiejS/IipsLHIkM3g18WpdnBos5d/Gf/RNo51Bqjig8XTCRTwsDH
	iL3Xw+YFSrhVF0snIEqIbgfV1oaq+PwgN8+Nb8WLq/pEbchEWn/X4X9EYRYGY0iUBtBkpOQ
	3cSyNNEdekNSPcAiMXDczdNSPt8xx1Vo7DB3Q7/FiZSberQjdS
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

bpf_get_fsverity_digest() reports the digest size as the full hash digest
size.  However, when the provided dynptr only has room for part of the
digest, the helper currently copies the truncated digest and still returns
success.

Returning success with a digest_size that is larger than the actual copied
digest is misleading for integrity policy code.  Match the ioctl
measurement path and reject too-small output buffers with -EOVERFLOW.

Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/verity/measure.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index cfe2d5e535f9..4cfadba95488 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -148,9 +148,11 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct bpf_dynp
 	arg->digest_size = hash_alg->digest_size;
 
 	out_digest_sz = dynptr_sz - sizeof(struct fsverity_digest);
+	if (out_digest_sz < hash_alg->digest_size)
+		return -EOVERFLOW;
 
 	/* copy digest */
-	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size, out_digest_sz));
+	memcpy(arg->digest, vi->file_digest, hash_alg->digest_size);
 
 	/* fill the extra buffer with zeros */
 	if (out_digest_sz > hash_alg->digest_size)
-- 
2.51.0

