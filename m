Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782F4A2605
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306644; cv=none; b=ABW0WrfrXg0rFzSC4XJls9aNVmsXqVwAF+lKoctAOa5B8FCojES+OwGdLaO6wCTpfGY9g7B6VgylMgXVse1WJztLstpFCQzQytD6hEbREcmEuhArgllqe1y+Cf/Kcssua40iD9X/nB7Td932QzxuJa7SS0SQQnZ9sv8yja6GnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306644; c=relaxed/simple;
	bh=f/7Qt7bAqqBllp49t2DfPlqJObj6PO7P5VTG+kUcK84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bq7APUJmp8czjL9XilKizPGC0Hq5x0yUxW/34ry+jHyY6hytAkeU+qd2P0HbLTZEiOHWmA1nOmlmXCTitzpXNBJ23dp1pzCqaELg6RCDqst15MYa3vMY7qaVEcDouRCOUd/J1BmE+RJLAuSHmDRLiWC7V64Rio/qT6K9xKeM/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=TLjN6i9U; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="TLjN6i9U"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed3993c1eso194849285a.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306641; x=1791911441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRjfmwgWCioxIdOZz3qjvttDw7Xx8iaB+ROKEnxisvE=;
        b=TLjN6i9UsjwYnH4xKlJo7QyaUaZThOJqABZCVSqASZTZgGxgMqb8dlrg5+Dq6F0iM7
         i89zsQqe1PUTlCbj3gGqmFyLhlTHMl8JOdIDxUGhTNxuS/SZB+5OQvnYvmpneRgcdbsB
         ozs1tgAo3VGdnfu8Fx9WoEA5chPSYwthaaqBA3duTQy8gOlsWEST6N5QeLsVwISBZwR5
         QVZVHbJdL5ipAIdwuCwR5q+QH4TH9LmmALUiiio18umyzCe1+BQUhyAyCoV0Gn5LNLEu
         aNbJSHVHwefOboOGr5Dzb/7JYtISf0g8KB5CVJ/wyozE2MQuFSjcuCdd8V1dZdIhbobD
         pEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306641; x=1791911441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRjfmwgWCioxIdOZz3qjvttDw7Xx8iaB+ROKEnxisvE=;
        b=DeGgggXvFce3k4F1eJwx042WYbvl69n5sI0CRG+619+sj2NdIfcwOmdjwbyFyJALI3
         Zc3lzBHusO/ZpStzCu0nMj4sQRBZOK8CbtbdHQWVoYH7tuPlO5E2KU5BW1z2gdZe4n60
         5m2SRu4y6Mebv+uky5JlCLdpS2mce8bSUqd49rLygquteYfjuIfKIbJ+Tr2zbamgFxnW
         ZhdH3dwuYxSE210C7a9nKhuIHchlav/JGUf21hfR62jQlgHUYUy0/DcYJumwV89aXEDT
         3qbEKcVfCX2LIsLQyK0tK/2TiDvXOylTmUs/PrlKCMPODeitx2kEtPtDrK+yeXmUcfUt
         925g==
X-Forwarded-Encrypted: i=1; AKwUvBy+XpUfliduoVSatBIE9Lt4N2U6CbT8ZLNZDoXyu3RSoOCOxyE2FeRbduI8PshL+vGgphw=@vger.kernel.org
X-Gm-Message-State: AFuF++lBl9RzRzDvGBH/hkmKnFeDmZ/pzKDL67Iyx7GbsKuIpCs3bnn/
	cvMZbmZ0SD20mTFEeUJIFQsquggMfzDiUb+oaEBB318BjyA1xUPozz+MUEP7YzvFtx7a6jS1VSV
	tMlxu
X-Gm-Gg: AYBFou0HRjaRLe3stdThyVQ3v9NuL0xEIEehhKuaW9kOKzoAxNeO2dDVo7gdvMqwdjs
	v5guzdZg31cjU37I9q8qOG8hcemR8srKbFbfe0z33tjoGAIlpJdaakMYxLkJgN5KyjYSWBecJu8
	CTsODk2lki7htGFC7O8uDcJVKHdszBVwMruZGIuriottvPnvKnJ8ME+oihli7OeaYyBJqJEFdFX
	YbCZWRUrqctUeeosNA2rlfH7mEB8fp9ipFQjQwJ1AroLoYcBrHkpP9ogSietQrhAxBBqq1g/U/Y
	eNmLXyJtO5LBWAnB24GdraUr5Y/klYhqdlnvxWQiLgRQqdSJgm7exVAYAAh+4hegi0Y27tXYji+
	lwrf5R9eCGIEzYEfRIcmepdd0XONjkjcGZaGCpPIPY3VlL9ic8N7HoOQSTD9d0k7SP3ahIJz+xA
	ZnHe+OzUlZQLUMnnmqXjcUtKO18C4n+HHHnF0bAUupDf63q4C7GOmP8e9jVXoCSJ7jJecpCBW/F
	CBE0nXqNijQe8s=
X-Received: by 2002:a05:620a:2956:b0:93a:2611:270f with SMTP id af79cd13be357-93e50fd50e8mr1939604285a.13.1791306641376;
        Tue, 06 Oct 2026 10:10:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991583eesm5698285a.24.2026.10.06.10.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:17 +0000
Subject: [PATCH net-next 2/9] net: skbuff: don't BUG() on bad arguments to
 pskb_expand_head()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-2-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=1244;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=f/7Qt7bAqqBllp49t2DfPlqJObj6PO7P5VTG+kUcK84=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIit/penLhirf0bNPQWI3WtNZB67EFqiOJY+szuEawUuRP4mEsvOMnAltCulWiG10mevs0TkoUm
 qj1dY1eh4Cws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

pskb_expand_head() BUG()s if it is handed a negative nhead or a shared
skb.  Both are bugs in the caller, and both keep getting hit: commit
2cbb259ec4f8 ("bpf: Reject negative head_room in __bpf_skb_change_head")
and commit 64e6a754d33d ("llc: do not use skb_get() before
dev_queue_xmit()") each fixed a crash here that took down the whole box.

The function already returns an error that every caller has to handle,
and at this point it hasn't touched the skb.  Warn once and return
-EINVAL instead of crashing.  Anybody running with panic_on_warn, which
includes syzbot, still stops right here.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 512ff9cfa269..5d856948cef9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2303,9 +2303,11 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	u8 *data;
 	int i;
 
-	BUG_ON(nhead < 0);
+	if (WARN_ON_ONCE(nhead < 0))
+		return -EINVAL;
 
-	BUG_ON(skb_shared(skb));
+	if (WARN_ON_ONCE(skb_shared(skb)))
+		return -EINVAL;
 
 	skb_zcopy_downgrade_managed(skb);
 

-- 
2.55.0

