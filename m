Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604085;
	b=mZejJCEfJQqlM1gAXxxnj3t0KHDaglKLnq+6XUTBRR8NrZIvBtup+25xc4SZ4PDqXqUh
	 TpCxxYCjGlw4AL2ln8j1GW6gkU/ruQZxOYDveKLR47bHV3FF6I0c+2JEUgbhw1bRYDjzp
	 Eka04WQNrQAhnvddDqGYmRu4DVq3kVFMhBpa3fatD57x95DE/trPVOI8EOGJs/penC9ia
	 jTFwk4znxPUfHLHlL5CBpM3+tSU4xr0M9lyhGw0jqQCAY/15JDmDZ5e3Ee726DGqzk0hB
	 PzRTsFHsWYAePgoaohPOqKmXG+XYFDcfEaPbfTVqjDyNL8rKNO+wE8+kFK/GFNIqrBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=wSiEkzXR8uJXPKsaI/QZmjURxrz3vMPA5g4H6Bg6zQzULPBH2XaCtn/SCuZAEpBIWGEG
	 vkvrRvn+8PqP4EITcsdMy6aA8x2XmdlsWHamfFEbNZ289XH2piKqacaYZSaxn+YQupaT+
	 8r8tkZ+eTDw2pQ5XYFPeVvGI7LVdb5GfCYpqoRQl3I4Ah6dpJD/ZRpV/Epf+LY6HSNEMI
	 cytbrNzKwCEaEPU88Z+duB1KVmZRsYJ/qwIOwwCML4gWnDe+pkD+wEzXc9jzrkCR2fmuF
	 ck+gz5ayTjTpzVp6kVtLqu8ngMr5WBGZwBlOHM/F+POF9GZ5WVqCPr/XJmo2YcTZV2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJSyx7TR;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D9606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 641D9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJSyx7TR
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2075297a91.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604084; x=1794208884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=eJSyx7TRNJ+iKyP0JOkLH3MqYgNU8rRheJ7RoNPil0uheKPeT3rFg7jDgqGDxqARI8
         NUc79/B8R/5mXmaOrdUBb+JMbawAycIXZPV/MjQ8cZetEddKzKIc8+D9GUi+xnloWq/j
         GGudAmMviC6J3XieznA3NFiheP9KeBICvW2kPk8EeddVv3XmwA/26DtzEIttvJVVLV4m
         3hRQGqOmd4iIZ8wManSIGzvo+gQ0IcqJtf/KsmkC/y0v3GRqppCD64IaJYnMviSzGUDG
         mZXXRz6VwhZOX9ziK65RMhucePYFGaus8dd1qtXtsgmbOTyrkXhf9zCNhrDu4u6tCuoX
         uC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604084; x=1794208884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=IC2JAIM5vC/97c9/4q6h3hqydVswiPx+yBGrauYxWDXtDlvbYH1t8U1IZWCxYWJgvM
         zOxHq6tETyPEPjUxk1Sf2/ak0/ZKbHScoKfOOiXQNC5MPko8v/l++OqBhltg7Kt4WdoE
         vU5PS06IQstuOWtVOmlLoNIsUHn1RbgKhhoztyjY1isDzJQhKiIuz1kWgCWek98VJB+I
         U4GgxXdPntY/XIw/4NWTQtezGRLOtggrhquAQsTRrBJIbAMk++VdPiaoDda5T8nVmYAB
         lfa64x/4sZ8NadcKXYIujJNJaVGpfR/kPg+X52JuimxtMNAuqP+BEx/7S8SOM/1+Gaye
         /Yjg==
X-Gm-Message-State: APuU4Z/UQLw3v8Y2iWTPj0JadaIdiTJrGIusPwP79JP2UIcuPmfCfyB2
	oZjp8/LSkeig47fcyukUR0x4BouMxYF2gcy/T3bHLIrbvh1TqByFfhomHiMMJw==
X-Gm-Gg: AYBFou2XM6skS0ML120hp2eFBBZSgQ4WJacWIpGi/Qh1jB/hCR8h9Iijjw7P9z0Bykf
	DoaIkhHZzmP+bIYJmbfX+ok36qtlr7UtlbByjt4WCz4vMhII+QA5rxK3SWdhUkcyU5C/wh1iuFk
	+mnJXeIlJ3eik7SiX74t0I3GqafdGcZP2tM9ZKPtDYlrBa4N1/ntrJQaVAuakoD//MvH3AIfS3Z
	m/WeW7NC3GDfMrU8snvcYd7NnOYKrezFTUeSmUB4x1W5UlhNAIJM4dpWzswagmaQTLo4OI3WylN
	g5Wq+6szARf7lHSObN5jIxozL8Jyor+t5UOEi34DZXXrQ6wBs65k70NcKisFqjYk1nb44tHTxB2
	K+jcXITDEJVH341y89E8x5FBXklCCpwLTpCDfqJRVV2wD7QLtapOwmFn5XOtgWaHyltXjky99JA
	LquYazmyrYvJBKFIrzcEM8mrUMa/G1V45RaRIFFU6whAoFltgo6rUKQqeYDp0HurtWYW1mahUXu
	AQB21Yq3bkfOKMN+DVvnyOpyDcKkd+G9Ap3hVwPnZB+oY0fmeI46AyBjVefGXJf2uozINYdv0XE
	8TkiZ6JXfRUOXW6vU2A8aPlMJSduVZS6WyDpdBoXkb70RIIckiOTWWtJaYhawF2Cz85TXsaMkzw
	Jd7xhpx13dHXBg8u1pwAVtyEFs6l8vx1aQ1SgZybLd4jRdkeks86cf0/HIiEqMRKkq1d2lPkt3c
	g=
X-Received: by 2002:a17:90b:53ce:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae89817b01mr7725554a91.41.1793604083734;
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm17877536a91.7.2026.11.01.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Mon,  2 Nov 2026 07:20:58 +0000
Message-ID: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

__sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
sg.start. After a full copy of an element it calls put_page(), unless an
skb owns the page. It handles 0 copied bytes as a fault. It writes the new
sg.start after the loop, but not when copy_page_to_iter() faults.

  element    0: length 0, put_page()   1: fault here   2: not copied
  sg.start   ^ today                   ^ this patch

Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
user cannot read the rest of the data. sk_msg_free() starts at sg.start
too. It calls put_page() for element 0 again and can free a page in use.

Write sg.start in the fault path too. The commit in the Fixes tag removed
this write. Do not write it for MSG_PEEK, which changes no element.

Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f03519468ad1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -443,6 +443,9 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copy)
 				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
+				/* The elements in front of i are used up */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
-- 
2.55.0

