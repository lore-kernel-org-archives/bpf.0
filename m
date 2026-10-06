Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2364A498D
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306653; cv=none; b=JA+Wm6cauMNOQY4gUWOm/f3vsWvXg9jp9nzZmzUENWCj6/R9Hf3IqWE+4jlCx1HlPtR6LFR5CXCzy1obAPD1KXPCxPw2wsRBkH2pRUSw6B1YgKTpsCwlUBZjtgeYR2fciIByVdhapHa+YsZXqzqx4nz3nVtFSs0wJ9U3BqWPQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306653; c=relaxed/simple;
	bh=uvN1C0vl3dSVIs1iVQhbn02KdyyiW4th9BR3bo6Ylnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCct2PEUBk1eS7VfCGqEylEcgH747SHfs5PNKujRf+GTv7h1TFJPeGF5iVGYORagaa2eveyzWvqGol2LJZASGzeueuVJMQbmiMbFGoMsF6Zb3oG9ivzXeqWoQZRspMcedvHC0JYgvQ2ituqKy/IH4bEOiHuT/M5CSKRSTdPmrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ecIYNh7n; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ecIYNh7n"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac9d666d4eso32003907b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306650; x=1791911450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF5W/CgBDkR5DAePUtl6HH4zpNbinPrc5x7yajxhkbg=;
        b=ecIYNh7na2sZcDXl53HXG1zGeiYjusCqzSDRhQrLGn5ar8ol3hiX0jUREzOGC2fNzn
         tuTfnSuORPZ0JyzpO7FPj00wL9/xOzXf1lfe+YqbsncXh5EX2XZP9Gon1EqSu+KFCv5O
         Q65bi8KjT8/lRmzqzh8cTQ/4z9Bq24P9uvtsVTpMW/nPq+nJYcsprHVYk8Tzt206ktHT
         TAzmSeYTAFDGKTPO04Ax4SGKv/Xej654qT5Tj9zI+k810JzK4jUOaC6Bnkt1TfKCVgyv
         SNH53pXoGgSEP3TeT5fJKNJfsTHn6D5Ko4bYH+AYzRBG5pVRsoXu08+9LCHoYy3TtROQ
         Krhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306650; x=1791911450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EF5W/CgBDkR5DAePUtl6HH4zpNbinPrc5x7yajxhkbg=;
        b=UAY4bKJCLg4PRb5UilKv9KXQdMW5GquUkjDWbyQhIJj6M8A68o1m0LPF8XpGZhOrQq
         acU5/2NqzM9TTN+LYXlEN2MrTBO66PVryqxUOpX2tyOrdLfmfWN9vMUaJIIcG07myL7n
         u1kgsSo/Cab70ZwrIaa/AH3/mUYvD6nPZfIg1sgnUdncmEPwukEU9mape9MXpKSzi6Ce
         h2QY74d9rVa+0GGY7ZPmrO181DkPlHxEyypuwQ23X+XqBN1NO4M1nWCcuBjUEk8+nVWJ
         4i/1nqZ1r3G/FY/C6K0E87+3LKnv+lfRv5NIrAj15QE2X8CJ506TIU/aI11ggVoJFK5r
         vXeA==
X-Forwarded-Encrypted: i=1; AKwUvBwdBZdx4kfvigcfop/TAnD4CCZMdTkD1UD8gyR/WsZCuX5/TDOQiqD9tHU+m7Vm20T20k0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyRWOSC9dXR2y17CJRMNRfGctRUtvDu5niq2lOAGm1blnewQ8w
	Y8eXP1UYQhA8F4V0SorMMuTj3xuNShkrLL1JyLJbJAUqCcLdj3PjJPk+jBcsmuYyAgnorMzMMqQ
	Vh3Rv
X-Gm-Gg: AYBFou0X13ACp/B/LrlAk9PfFgVd3PSNy1lhpF06MWBxaW3spfMokH9QbXqThAz2sx7
	Uvam0CZa8hBlxfvXzybUBERUG4RHD5THvCWvUgDdks3Km1OIuaUdL2hmZCd+O+envlgpGKi6m5v
	e9i8fvwqggbFZMqBxh8s0N8rEsPu4y5mPRTHTMmSJxx+/6PSxBhx/stAZLOhF8a2TTAHd8xT0Xu
	fUPX5I3R09/T9plmT/JoNFnE7YMYcRqOXMzIcRV9+YnNgLIHCOU/rBH0Dhj8Ch9c00xOvUgXs5W
	gpK0g9ATy5dN7W3cg8cGZWCLUshsv30I6ZhUjGFlpIwvz+6oaWJJN4VWEZ9yAWXysHyjSOzD2MF
	7tjO74qFkyNFquZB/T3a+lrZZFxriiDkXv+YxqYxADSzrUn7QYvtSqxz9ElPJs2HVLgyzUYWUbf
	NVJJeWkyTxzFbossRHF3XeN53lddbGNvkpbt7+6B0K9SbOYT7Sb+YMEPcxtZTvV21KzWmJkgnVP
	8+J6l/Efq9Qun4L4Uz/vlqsVQ==
X-Received: by 2002:a05:690c:f05:b0:8a8:8d90:a66a with SMTP id 00721157ae682-8b04f495f3emr9471697b3.87.1791306649564;
        Tue, 06 Oct 2026 10:10:49 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d5939b0dsm117891826d6.7.2026.10.06.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:21 +0000
Subject: [PATCH net-next 6/9] net: skbuff: don't BUG() on a bad csum_start
 in skb_copy_and_csum_dev()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-6-1b4434c5357c@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=2018;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uvN1C0vl3dSVIs1iVQhbn02KdyyiW4th9BR3bo6Ylnw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJx0cclC2yF6V9J1KDgoqeECxDdIYejM+npbtG+FaX56+lEPcPaCCu5FYvZ0KpAY2fgmAAowcsU
 TAoeLv3l/GAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_dev() copies everything up to the checksum start out
of the linear area, and BUG()s if the checksum start is past the end of
the linear area.  It misses the other direction: a CHECKSUM_PARTIAL skb
that has been pulled past its csum_start gives a negative offset, which
gets past the check and becomes a ~4GB copy.  It also trusts
csum_offset when it stores the folded checksum.  So far
skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
but once it returns instead, a bad csum_offset would write past the end
of the caller's buffer.

The function returns void and its callers are drivers copying a frame
into a bounce buffer just before handing it to the hardware.  There's
nothing for them to back out of, so check both ends of csum_start and
that the checksum field fits in the frame, warn once and copy the whole
frame with skb_copy_bits() without filling in the checksum.  The frame
goes out with a bad checksum and is dropped by the receiver.  If even
that copy fails, zero the buffer so the driver doesn't send stale bytes.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4070e0c25f63..c8c2c0319b87 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3971,7 +3971,17 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
-	BUG_ON(csstart > skb_headlen(skb));
+	if (WARN_ON_ONCE(csstart < 0 || csstart > skb_headlen(skb) ||
+			 (skb->ip_summed == CHECKSUM_PARTIAL &&
+			  csstart + skb->csum_offset + sizeof(__sum16) >
+			  skb->len))) {
+		/* Send the frame without the checksum filled in, or send
+		 * zeroes if we can't even copy it.
+		 */
+		if (skb_copy_bits(skb, 0, to, skb->len))
+			memset(to, 0, skb->len);
+		return;
+	}
 
 	skb_copy_from_linear_data(skb, to, csstart);
 

-- 
2.55.0

