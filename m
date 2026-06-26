Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBC37F75E
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492726; cv=none; b=hBQ830O90EiUQiYOZavkrE7XYCZELPB0RcAuE1hNOa2ZupWC+MCuJxwh0vday8wtJCV9DEonyHQ8cPMKKhWtSPsqJuX+KCjlstN06qyHBQXd9z10XfAOxNU8MVrQ1xsuEUGZg68FwH9Ieuteoj3ktX6d3GrsmwkDVNTsBVsgtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492726; c=relaxed/simple;
	bh=S9nB4VMlAriZcGaoGUogPPb4VsgQmS8LzwAdJsq/Umc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2oCcExTBJY7VxH5aOVXtH7h++VnpM/fjk65NkBrCqwowaGsFhJ9JAqtPsevk1k9yjRZahu6HS/tkFJJxk9Bi6r5w5z2wRP1gmYK1lPoFVWjQKQZyWZbS6XUihvOEIkhmBE2nmv387sqV3VAofhgpfBCS3usLQwRRsoIgZ5LGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JHtgD3Hf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JHtgD3Hf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91563abd6a9so61681085a.3
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492724; x=1783097524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQzfEj3d+U9QMkss37KHvB67s0TH/WA+OjBfTOeWvrU=;
        b=JHtgD3HfNgNAZDWulKmid2PEnsMbFpE7Ef/yfCmFKJwLKcMPRpmw2peaADT3wzwLPg
         4jzhXQh4QbQuo5N/BqNdpfFNs8kFnaMiV2ItxXCWtN24Ko2GBieFwd16+2l0ekoHrKZN
         3PKWeFPZNLasHuHLeDmbBKs9+iJ24G7/9K62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492724; x=1783097524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQzfEj3d+U9QMkss37KHvB67s0TH/WA+OjBfTOeWvrU=;
        b=C6wClghluOCNFQFIhdF4xcR/ggSZphWvSiSG27kIiUJnJyysA/R2Fm/bqD+yELfdm7
         lfHORL1w5t0HyHEL0xNYpwu1g448jGFw1GPHc4jYCGYmuwiVPUl3INAMBmdI+xcBExWC
         vAUbYt8QYYdb0fG8h+GxKerx3JgvS+LM3QGw650GulRGqCY+H6+enzw3BdcR4MIJUTRV
         W8K3Ey3DhRz9936nf64kkbhXxFH0OJ0CHZmd0xHRtCo7a/kYGZyd3mwFgHkmfrsr1y3z
         pDvx/Fb46n8zbMVXs/5qqI6P6hS2av+4II1zpEtpVDAZlwntlz7ep5BLK2JF1MwkB7c4
         6BQw==
X-Forwarded-Encrypted: i=1; AFNElJ/bNBl3MXUrkfyvDwhtyyeYBG3Mik1hgOED+Qd2YsVboQfSMs6DrLUGGzCaat94xKOTla4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMEC+KXQqM+t0nq99ef3MN0fjQf7d1KI6rlxQHqJ3t5FIi5Mt
	5SfgbNtLQ2oQw6B74fGC2AnJfvEx7va+B8a4UYxISm6K+ZEc3xtPgdw0Yh1Ed3EzTw==
X-Gm-Gg: AfdE7claNtfg2EhUQUh0vq5tV1//zApy1neqnw8mWoGBmq/yi472hZe7sz+SpQlly0d
	tAlQE4L1t9Ftu5AAl1r6o9g5/1k+2RPL69zHChHQUmvEuJbVmqTS/HUfBQGK+ZSEMDFlUypbYYL
	Qxm+0Z0+Z4uzk3xB7I/4jlElg7EOdtq9BENR1TePcluiTr2Y43XWRr9OSKUFpcd8FpRbnAagLmW
	ecQblWhYXGijJ5xhUddlWq3Z2uTekBRxUM7CSnDrKaku3gE/OvoRZl/ZCW4CADbI4GbnE8hzsM3
	sx29B7jpV92tN0QZAdM1h7bE/kclnemT9/TzhKxnjT1OuMkzyC7QaEja6WF+Hie6BJR/NDDgd6S
	UfcU8Dpi7ReWT8aRQRLi7/UBijkQtPnOBNqg73cCBIoPZs46wJ0VhXxZ9KLhHB6Gvb+i5JoCNwM
	w1K0NSYg==
X-Received: by 2002:a05:620a:43a8:b0:920:bbbc:fd01 with SMTP id af79cd13be357-9293bf2a5b5mr1220351485a.23.1782492723701;
        Fri, 26 Jun 2026 09:52:03 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:03 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3] Fix broken TC_ACT_REDIRECT
Date: Fri, 26 Jun 2026 12:51:53 -0400
Message-Id: <20260626165156.169012-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.

[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

