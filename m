Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966484A2073
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306650; cv=none; b=QCKQes99he4sSHyMMm62urUoodC4FVJajI0izH4Q0KsCIY/5PubT/AEzg5bISk8UfjttSxWsezWeAQU44whS0QLPdzvmSIY35DrfPRm9/kVUWYvdbX7/wHXKHejWFbuBWze6Qda19K4FZrInhfBEXLnNIH/bXa7SWoX5E3MB5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306650; c=relaxed/simple;
	bh=c2DXueOvnxQOsHHClwC5VBZmmOZVnVP+LYPem99wBrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEockP+gXZ8Bhz8E2w/c/Gjgppy47MiHWidmbAh8finsPleL6eMgD6434HeMTqbVXKLEkW5vSKz0xQF4bBhSoFqbhss5Ksl3NwfuTA5EopfvgWvQ8s5FyNgY/mGikdtg0XKN9hFJU2jztD+zxv0fvO+YhgoRB1BO/UZLgPFsRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=rnxR47+K; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="rnxR47+K"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a64f28d0so12378006d6.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306647; x=1791911447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTOhcHb/kxdWkr2Y/Gin1Za9mLNJZrz8G1jRLFvpamk=;
        b=rnxR47+Kw9vpX/z79CxexbBgY/g1atnxhKJ/ReS1EVImN8zFx0NWvAFsMSyuATTltX
         +Uw2jqn9yYm02KN/xbgJv4F2s+AivHuYL8SGF5QYt7FTA0YtjHgKFDOfjCDkAYSBNQex
         MUkq4Z6+i294p5/gctwYuBQhb/9bd4ICurLmcVSBcfLHAoiPSk2F68SDDDpeyd8+GsWg
         tQRmt6VvPrKn6f31+pkNX/tc7sEY7448XDplrisdLO+r1NVlF1RD41ik+L45raa98c0M
         MlK6rwVA+lsCPEKbLdqF4JeILDTnJeFvzXs28gkOTqRu1U1nuUyIarxI+bSpbE62FLBY
         y/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306647; x=1791911447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTOhcHb/kxdWkr2Y/Gin1Za9mLNJZrz8G1jRLFvpamk=;
        b=ddmbGluZWK8w2Hq5P907azjpS8BLAjPgKVdJtLa6Qm1cqE5cyAMPtPhap2eKds98Uw
         ijZtowtMmfCqiSrV1uHFACoJ+29fXPJJ090nsaEfsFaAsHEWcqDBzIJ7bzAG25Qqm4xQ
         mulyCmn94SvMi7z+Fmadj5ClU1DIYHJmk9+IPgwjzunY+V5IOs7N/A1ulTCwYPSe5qwM
         e5lc4RnPHQ/fUw1VKrFWK4PKnPaj8+kLjYlbSMww+TtQewPH8r1DMl0W7kVqGpww8P/l
         Kw+CJ/eHKmL4XjggZN0iLiMqulx0GVQJPftgc0uSV1gXG9cpc8o1TxvBYFRMNVd3u/Xl
         +QEA==
X-Forwarded-Encrypted: i=1; AKwUvBw1PxyeW4x5kAl0+fSupWZ1OKhLRo+8mFY23cybVDoMvUylxs3/ne3jUYi8lV+uuK+yoRc=@vger.kernel.org
X-Gm-Message-State: AFuF++nTyVTfxrHe6e6e9wlz415IYSDhQou1AdKA/+94EXe6aFbteofK
	oMpluuW/cGldx4bYnif6QPWppdHpZJmGLESxZlqYV7dD0ePfGCvR5pfk20db5M4ghCRYSEzFfaT
	Qt9Zc
X-Gm-Gg: AYBFou32ZwgGWcoWdlqUNEL/D3spCEfhr8+IxspN1MR0lY1ja+deg1QSl3M87t1s+wZ
	Rai0Tf41NHe3ODU62G17q5IEH2BcuA77ywrxypHUYSUdQYsCxxTgV9zi80uF0/JvVC89f+TNr0N
	4PF7j7LuWkGcQHsb4Id1dz2I+CbzD0gMfW6xLGx+BqeVK0VXXB5bHU0k5F8eAbDCqeUHQIfnVAI
	aPBuiGdslxM2ReOzQRdN5fjEzM5Oa/RZXDXEei84lr0+kmv+0S11i3I6RTX3TFj+YXZho6/a+Q0
	alhOlhVonVahFpzZTSnp4We/7iiy+HgwyPDNGwxJiYiY5gtXcx4wba33rp4DoFCB3ocu+frq+Vn
	X1JhHvM1EDfi/FnbR4AM8vB8cJQUGi1Qp5FaIq26PcsAu74xFk7beUvO9wed/655nZWHx1MlovO
	3qSvFx3Y3hWfXrC1Z5yPrE8kCCfbkvy9/xkFuBiH9ndPOhFqkhysZmsEsKEovWnE210r37eAszf
	/Zd6mB2Ir/mzqs=
X-Received: by 2002:a05:620a:711c:b0:93e:5de7:fd45 with SMTP id af79cd13be357-93e8605d700mr635211185a.18.1791306647374;
        Tue, 06 Oct 2026 10:10:47 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991eeb5asm4481185a.41.2026.10.06.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:20 +0000
Subject: [PATCH net-next 5/9] net: skbuff: don't BUG() on leftover length
 in skb_checksum() and friends
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-5-1b4434c5357c@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=1904;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=c2DXueOvnxQOsHHClwC5VBZmmOZVnVP+LYPem99wBrk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEqlrDfWghaFGjbS7yIpT3Zc7jsn/L8pCuu/9CYFrXjA65hisX7rOw2OHlFS3rpFnf07Cbl/76w
 EuG7K7koHJQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_checksum(), skb_crc32c() and __skb_to_sgvec() walk the head, frags
and frag_list and BUG() if they run out of skb before they run out of
@len.  By then nothing has been read past the end of the skb.  The walk
stopped at the end of the data, and the check only tells us the caller
asked for a range the skb doesn't have.  commit 06a0afcfe2f5 ("xfrm: do
pskb_pull properly in __xfrm_transport_prep") fixed one such caller that
crashed in __skb_to_sgvec().

Warn once and return what each function already returns when it can't
do the work:

 - __skb_to_sgvec() returns -EINVAL.  Every skb_to_sgvec() caller has
   checked for a negative return since it learned to return -EMSGSIZE.
 - skb_checksum() and skb_crc32c() return 0, as they already do for
   unreadable frags.  The resulting checksum is wrong, so the packet
   fails verification on receive or goes out with a bad checksum on
   transmit, rather than taking the machine down.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6cd7135e0dce..4070e0c25f63 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3613,7 +3613,8 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (WARN_ON_ONCE(len))
+		return 0;
 
 	return csum;
 }
@@ -3778,7 +3779,8 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (WARN_ON_ONCE(len))
+		return 0;
 
 	return crc;
 }
@@ -5333,7 +5335,8 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
 		}
 		start = end;
 	}
-	BUG_ON(len);
+	if (WARN_ON_ONCE(len))
+		return -EINVAL;
 	return elt;
 }
 

-- 
2.55.0

