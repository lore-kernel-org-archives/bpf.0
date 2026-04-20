Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826C3876C8
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673713; cv=none; b=oWfu+gAY2FL9jTyzJPBC4CVlzlCiR0J4vvc/zMWyYcA2mfj89ZWL1/G83u+6X6TVrmn5aKpd0dB9HmwbWEHAnz1NfUzL6DGQEtyvsEqGMSlJ9PeNCaPWmIX+YQOCAhc1xMwrgq/6BcIx6Hk5Fv0A8EiCRaGXHRmppfJq37QnYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673713; c=relaxed/simple;
	bh=JoQ/dtzaAG1Wm70JNPQk2Dc6RgytNEkXxIb9VjggRW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hey1VbHdljAFd5739yhb75OVV4F1nrOqtiUnzY3atE3JK0IZJZH+HtF8WeVeUV3qf1DTknThiBI6JXGLOjBS7XwytTh65v461hUmoEYGHAF6kXF1s7sDZ3C7mb38Hc6OQZ/jHRyMQqZf6Av4vhQiz74013zJl2KjoDifuB9KoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFIjokuX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFIjokuX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso1822658a91.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673711; x=1777278511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRDahej0krcsoJOw6RQ2fK12XeV0DzeNJyhXEkJvsCo=;
        b=lFIjokuXvfBYZu4PHk0gCvNw2iiy/Y1KGLz7beH0jcjg8k+5Wpze7qdwCH0O9B8hNv
         yirMzIbRuBfPWY4VFTW4VmkmQuKohu/uDeBzypihKPLz8K13XqrKz3ODBtmQ0BTrGXoq
         n6fsyq0jBxKL2x+gewiFPDt0Dx/nSOGqJB1flo3kU0NRr8F4NUYpEMzBgGcaDibJGr5O
         nc4dOj7KcnlCMNXrI8GQWFXktDI50mlYQ0YxbVEPOz02WlFtGY0ahDD7ucxx0SDfwhgi
         eItWBDsRpgUx22jYSc5J2D5rWJOl9fIUIRik7ZQ1LCpR9XVBRS6JpsUmUWJ936SUV7E7
         0UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673711; x=1777278511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRDahej0krcsoJOw6RQ2fK12XeV0DzeNJyhXEkJvsCo=;
        b=glv/8Nytt4BPH+p1WJfKj+BMhljlvm0VotoP00xkYrvQoO0zjh7Z/NKX46+u7DVZDb
         TZWwPjziq/4IEwFhfzWMIMj7H8DYFNvhruCqf+mBWuAzBzEPyhhjagih2kMBRCjg47/D
         fJUFZI294W1kdo8z8sY1crgHxTb5dPIZMwd0eN2Tvie0k21ZYQmCrGa2FgST2hhkGgg4
         6DaXSFALpO7nQMbaU5sjbBRY2twJQ7hFSlcyduX36bj05ZFd7K1q5d8kQhUTT/zrJYRT
         ueRFdx7XZsV8Vmv56DVQPcMvQMcxQ9zOt4hUAIiMRWMvSQRoxYBouMFhNpMtBEDnVA4u
         GCJQ==
X-Gm-Message-State: AOJu0YzxBL+i+dXBUFa2AaXJpeDTsii5injtzz+nDknXyTzUmhQtD6gA
	EVScOfN0/vSAW8e7xued3X0sNEaQvwzvK1YRmnZaluiOt4E8sI/QegWN
X-Gm-Gg: AeBDieuoR3mok2QAV/zAbTyI0T1PSVybvTr+82XGaFuxqUR10jO2FFkt30gv4Rc5IUR
	gO0cxkX15H2+nQIS13Oz7bER3e9lTFwrShamDycADM35xCU4+orrzHYhAkSjsLHqNpU4SWwOD65
	N0dzIS1FO+8I0/4mmaCNBQh9AFd5YBVbPgfFt4z/4cHm0mkIk/J53oZi2HoD8Hz7rAdq8GOS+eh
	WrzgXN8x6crglY5aEKkUeV0bnjCEKfaQqTHLBDAxub9J9swLo2K606oYrm5UMLpWi/MbQnWqK+f
	UT/7QYwNufdJjzXMViRAuR5M95NyQUdUjtyE4ovU1VTHZIJ9ssAp8Bjjqm5eL2erJGYxuTazKOQ
	RpyOrbtoD96UUx/kE4SjjfoBJtsbJtn+4+RQmctG9HJo0SpRXuRWD2ZsMpTzfifxUU732BpC0dS
	9JOFcLJltKFU0UZaI3QaQQjyDOa9l0o+HrPbJNYg8T9aRqtlOTTG3heZlDaKVnSBBl6IatbBIB1
	iurx1CC
X-Received: by 2002:a17:90b:3f84:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-36140468c28mr12543900a91.17.1776673711144;
        Mon, 20 Apr 2026 01:28:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Mon, 20 Apr 2026 16:28:00 +0800
Message-Id: <20260420082805.14844-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by adding a !xs->skb check to the condition, ensuring we only free
skbs that were freshly allocated in this call (xs->skb is NULL) and
never free an in-progress multi-buffer skb that the caller still
references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..4fdd1a45a9bd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3

