Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D42E7389;
	Tue, 23 Jun 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210778; cv=none; b=ICkDWjddGzYkwglBkNwWhHqO0J/BRrsq9f9l+OsYkpT5Q4yIBpPVXzzudo1QZoH39UgPHrX7xSPcx9KheJhTijD79ryQ6DLX6HESsI+rI43U0tdnFKleIgNzG6GCeufKv5NPOvho+hyvh2FQSzFYYOv0Y12rIfgxsl36euDuRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210778; c=relaxed/simple;
	bh=92VbNPJTkjdEBtbdvlNU+3BxeLMswukvLPMH/Wxhr7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pczcaKWcZhoTYDlUpVaf6UA5XVhFszPCXzFRGqccWS8lqv8JJoTA6DMwPDxpcQqCUdudQSudbUeRHiAcilXIFVWKGh0pDeTfOfovXFMZdhmv/Nf4KhLaJ78Sj6bBndyg2yiULXizUseFq/Y5185GgbmVZAddyWrmrBYmxHiMbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=mRQA1o9q; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="mRQA1o9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	To:Cc; bh=d9d0le26UbuID8At9QM8NwqEIEAx0X81rJCUP5FPzYA=; b=mRQA1o
	9q6mCQKCeBfc0yvmSRZexyXsKsJmjL95JhhsWeTXZFJK0JtBCxKS0YSMGICCUIvo
	bZptNVex97qmAM2gyWJ7IebLMqrNAHDOH8Fopq7o8MpLZollxUibWUcaPtjDWJ91
	SzP07yOk2Fg5nNGIZKMZDYxzy56Y32GaIfarw=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQBHWJ3AYDpqOMt3Ag--.50276S2;
	Tue, 23 Jun 2026 18:32:32 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 23 Jun 2026 18:32:31 +0800
Subject: [PATCH net v2] seg6: validate SRH length before reading fixed
 fields
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
X-B4-Tracking: v=1; b=H4sIAL5gOmoC/22NwQ6CMBBEf4Xs2ZK2CKgn/8NwoGULa7CYLhAN4
 d8tcPU4LzPzFmAMhAy3ZIGAMzENPgZ9SsB2tW9RUBMzaKkLWaircFIJVQrGthAcOtGjF/Uld1l
 +1iVKA3H5Dujos78+wOMI1QF5Mk+04/a31TricQjf3T2rvXxotPyrmSMSWWGN0VertFP3V009p
 yOTb7upTrGZUuuhWtf1B7r5cnPZAAAA
X-Change-ID: 20260619-f01-17-seg6-srh-len-a85f35427e0b
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 Mathieu Xhonneux <m.xhonneux@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Lebrun <dlebrun@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782210753; l=2240;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=92VbNPJTkjdEBtbdvlNU+3BxeLMswukvLPMH/Wxhr7U=;
 b=dh6mR3KdjJPZ52OQuPdFNWGIGvtdFm2uuulipqIRfslz1/Ucql/ca3QUpbNC/tWn43yteNtSk
 aVDl2zlmwTyDBj1wI1U7S+mg7CnTEgtUCY58eMz3iEJGkkvhwxspfbZ
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQBHWJ3AYDpqOMt3Ag--.50276S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7Zryfuw4kXw1DAF4rGrg_yoW8tw1Dp3
	WrGr4aqFWkGF97Zrn7K3Wjya4Du398GF1rXr95Aas5Crn0q3WxWr409w4YgFWYy398GF4a
	y3y0qrWaq34DZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Gw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0kWrtUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQHA2o6M-xrbwAAsa

seg6_validate_srh() reads fixed SRH fields such as srh->type and
srh->hdrlen before checking that the supplied length covers the fixed
struct ipv6_sr_hdr fields.

The BPF SEG6 encap path reaches this with a BPF program-supplied pointer
and length: bpf_lwt_push_encap() and the SEG6 local BPF END_B6 and
END_B6_ENCAP actions call bpf_push_seg6_encap(), which forwards the
length to seg6_validate_srh() with no minimum-size guard.  A 2-byte SEG6
encap header can therefore make the validator read srh->type at offset 2
beyond the caller-supplied buffer.

Reject lengths shorter than the fixed SRH at the top of
seg6_validate_srh(), before any field is read.  This fixes the BPF helper
path and keeps the common validator robust.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Changes in v2:
- Narrowed the commit message to the BPF encap callers that can supply a
  too-short SRH length.
- Dropped the unnecessary cast in the minimum SRH length check.
- Link to v1: https://patch.msgid.link/20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn

To: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Mathieu Xhonneux <m.xhonneux@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
To: David Lebrun <dlebrun@google.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
---
 net/ipv6/seg6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 1c3ad25700c4c..62a7eb7792026 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
 	int max_last_entry;
 	int trailing;
 
+	if (len < sizeof(*srh))
+		return false;
+
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 

---
base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
change-id: 20260619-f01-17-seg6-srh-len-a85f35427e0b

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

