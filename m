Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461147;
	b=A5PFogFTZhJ33t/BSDm3S43FkAVv0WNXY8J956WJcvVK0fszO55J8GpKZKTgAPXTSzQW
	 tph0VmqAL+E9VimzMfwSkzsoegAUYR0hnVUIgQA5cVaAspICC1cE4v5EyyMtsPPKItrdf
	 l26sw8XlG+SDVt1NJDkrsas219AaBpItXJHEJtEiOMtUbqkAXP/1c07AFTVdn2p/SVmlK
	 lJbpEobGY9KdgZ73X3q8OIB5t4sGgry5Lhh/mA9tlVIYvAIhdK2Fd5VcE9nl0odxLSAI4
	 a1/mnhdN2Tl4TE+SLxwVYTMk3BuJAoJ8Shlvk7zTe5hrBUvykjHb8b7YV12UUq2dZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461147;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bbprv+Je2nyZy16YZRyYE5YlhC59XEZojYyJo2JRLNw=;
	b=YBMLGDd00GCkLYf1WJFVVyD612ae47KJcCqUgDdfJXlcwBVAg9AW9H+CZW/q5S2Bo54i
	 qAw2jRdDEasboy4hYER3VKn7pFYdbosSVFgwLl1UaQ7nW52xbzQCHmJVvinPG+u8BUUC1
	 7SZsdJQi27sGVju+QFJ/wx+pkU73sCsrESgttmS61oHknt4LW2LVnlbZwOgswjxt/Pf60
	 H9bFZSRqbqBI90Tv0+mwJQX29jgyk/e+qMvBruIaByzzaCp8LbZkHixIhD9LFD7fL45WI
	 BJcKfFRhrPlH2WAE50rObS0IPYDS9P7L8suQL1ANHF9wyb/+tx8Yj3eyLICaAUFvdJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=z52qlunk;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C73606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 05:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C73606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=z52qlunk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794461141;
	bh=bbprv+Je2nyZy16YZRyYE5YlhC59XEZojYyJo2JRLNw=;
	h=From:To:Cc:Subject:Date;
	b=z52qlunkmRofjZ2HHN2bU6B/WtGh/A5r7BiPLrm0iCXZH7deNduumIn+PAlFSTyVs
	 dTD31HAZDW0yBtJOSnVm1yxtnjtLLxj8vvlgS/t+yBGm+ijuvHkmuwmtLiiw0dX780
	 qruEO0jsMMc+PpOg71U/oER39WaW7U2ZAD2G1h04=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.247])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 66622653; Thu, 12 Nov 2026 13:25:38 +0800
X-QQ-mid: xmsmtpt1794461138t1rdwgsh5
Message-ID: <tencent_F9B284A9B4D4533798FEAAFF2ACBAFB75E09@qq.com>
X-QQ-XMAILINFO: NZcTxHzy+2XTby1lSWJS2BQB0RYAAa4CaubF+w76fkrnxhO7kUVmz5Wm0g8WM5
	 V1dI3BGyXFVT77qpD+nM6s9kztqJcMFJbERkbRibeiD/zfQ0+8pmez7HIVUVBFeXTJfFMaB+NCyg
	 awDDYCvj8nbVfR6qCkL0C/gzq3PAn1Ge/McHGGLITJ0oWEYpK0+y0vBdCvorltuyc3pPm3SJKBkC
	 mb8niKpfKjyxUPO+bnf9TKVTipdOkwquXfl6+m9Q78izVyvCY7LV0y7MVw0ekJt/CCCMDxLjVpjN
	 MIURmnIsIW6oJSXiDumyoWIFeRQhPJYEV1wgL8O5T43XUvy28G4jehfXohJ0NK+hyd0628LSWvvf
	 C9RTh4BpRbC8DR+gew0OmG2TiWllVfNV1XxUSofAdrQUONEsu6Wz0n98b4iWtzkOjc2CMF+y3Wbc
	 ffBj/DhSRBykHgLiZJynPJXWaN+2f4ttRt6AIgQWtgwZfuaXFSJpm4JpBdlvs8S6DrrcDrWqxyrh
	 6JYKNZ36xJSQPEIn68saUyel0eQPhu+HHLCr7qMPlu8yXnp26Za49UA2I7fL5+Ra/+a+tVNwW3il
	 QlXFeRiwgl45drphcWV4reuxbs0s0xiFT/0dUdhX8SU6sTZSrKz8yJAIGA6B47NSfEr7ZB7k9m0Z
	 hnwZhHLyVRlhOFOl6HV6sDIkqZ3KjQtb9hXEd74r2pVRzXmSL+RUKNtovwPJwxbLDILeSpiyNqfx
	 KDKQjfZ+jT5+ksIKckbCfwQWXCtl87r51dvAZbXgi9Zu1PBsEgS3ExruxBZlS3yA02iCu5W+i4ZR
	 WyCI3oWsPprlnlPlVN1StneqHpXhHoDLhaw99dVsCKL1tNUu9DaU/GzIVFe5bbPdzML7w6iHDUIM
	 dooRLSj096/qD91XVJBYjovLv8ewJ+sRrJLEgiHOtVkGDF6vd0TG23xWYCi5GjCr4krEEvn2V4OD
	 GHcxVcaT5KycEcFXujb3i6BSpJbjuUTasE6JBWZEOZXkGvEwi5ANCifFp4hi271dHIXbs8fDP2yd
	 jVqIEwT4p/s0Pqgtp8iAT+xasTpeuG+a5bZKTomRHV4oJ4cYvLkm9zjSBo+2mD8CTYNwQ9YNz8dZ
	 PDitAoxSrQhyMNkKXC0BW3ZKauZu+CoFxjX0UP8BRs6yS3dzk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: bo cao <treebacker@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	gregkh@linuxfoundation.org,
	Bo Cao <treebacker@foxmail.com>
Subject: [PATCH bpf v2] bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
Date: Thu, 12 Nov 2026 13:25:34 +0800
X-OQ-MSGID: <20261112052534.18289-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Bo Cao <treebacker@foxmail.com>

A push at msg->size on a full ring reads the length of the free slot.
It is 0, so nothing is copied and sg.end moves onto sg.start.
The ring looks empty and the next push overwrites live elements.
The prog needs CAP_BPF and CAP_NET_ADMIN.

Fixes: 15ab0548e310 ("bpf, sockmap: Several fixes to bpf_msg_push_data")
Signed-off-by: Bo Cao <treebacker@foxmail.com>
---
v1 review: https://lore.kernel.org/bpf/DMSXZO5WWV0C.392TVOFZNS4OI@gmail.com

Changes since v1, per the review:
- adopted the minimal diff suggested in the review
- Fixes: corrected to 15ab0548e310, the commit that introduced
  the append path
- commit message reduced to the essentials

 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1f81a3dd6a5c..a742a4731a4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2883,6 +2883,10 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (start > offset + l)
 		return -EINVAL;
 
+	/* A push at the end of the msg works on the last element */
+	if (i == msg->sg.end && start != offset)
+		sk_msg_iter_var_prev(i);
+
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
 
 	/* If no space available will fallback to copy, we need at
@@ -2908,8 +2912,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		raw = page_address(page);
 
-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		front = start - offset;
 		back = psge->length - front;
@@ -2931,8 +2933,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	}
 
 	if (start - offset) {
-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
 		rsge_copy = sk_msg_elem_is_copy(msg, i);
-- 
2.39.5 (Apple Git-154)

