Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560953;
	b=CJrbKRyej1ZmcDNwcQTV1b2BbXamfLgSVLIYdoqXqqoeWYj83nKn1vDgUl3ZZPn2imOD
	 gb9esyNVG/CmsQHtYs2VywrUzQ1RBDxd4wXA+cfUDaDSvRpONnhipXca0cnbHoHU2+9ki
	 JFmd9J9gq36bAjt9AaA+J2jOab+OqSIG+YxhTgXnrTLw8qf/35LbcNHZGAYLw2e2MQhOd
	 lNWZpie4+9xkkhJ7hJN9usJgljg2H0Jia0S7NfOELPjY0kVh+KqHs7HCrf/kxfg/kasWR
	 iOVgXSY5kOyKeCNRkx7fofEVxrTh54M0E+vaM1ikh7ArNVW2K11NjSb5YJSbMAcg1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
	b=eLNCIM6jVSXtt12pEAATO2TGOE6cXiRerHT8uxgZievaqcXmpyWF5qHU5QUJ3Gy3Ggc9
	 53zMOkEWw2QcTSCHHvE1Md0vW4bO2/boPfC+IwyeYuYxo9jxgk9Jbd9tiMaaRUAvmZqyY
	 dvG2ZtfnJfz909If9V7973MBP65rcvG0xpzVo01+q0VPIhlzmysQzbz54ktoTjU5deMS5
	 6luTnahrbyteUIi28PN/6DZM1gQqWtY/Wm3Jg33xPbgQTGTgS95A++t7St1VGB63FW07Y
	 2XDEJxm66uxoSAl0z35tKCiDbAh9WX/7SUPIwplZBYlpo5DozjzCoKZ6oTTwojAQa3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyCU49Os;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119C60A2616
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E119C60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyCU49Os
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1419414a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560952; x=1794165752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=LyCU49OsXXghrC1HRlyul7GdfItx/Hp8Jh2It9Y7ylMBJ6qBOpIvVsfk/Nbvsw+SkE
         Qba8vYChTaNVtDg9TuvrX+qUH3q8BT0JBZzybomIHnTnHDSFHXq/vys2PmPN8tffa5rC
         kGxQMzVsqHj8fINaHEfeSyytrZ/TVbOzR3I6apPPVGOQf9lhUnsI4kXeknQH7hoLjcVY
         ylWfrNIiJLJO+jInVnJDxKf2hQqVP3DEMKvQ2UOQDAkiAnqvLLS98FD0JA+gGY7URN7Y
         c0gdpiztz5OA7LCj47CBGVwRfpRXA8Yt7UoFM8nfViPbKx4sdk4zlITWtKtM/6DDbM8Z
         LC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560952; x=1794165752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=AuOv1CSAIceFMhqOv/E+YL/6tLU1mwaU9FtSqfYqd/IuT+iGB5U3orF3ywtu5EMkpG
         B3A4tLNyQvofZOgFSIk9tF6kfZKHwK7nZjAdMXuadI4qdGtLMO4YkQlPYrv8cNftYvDe
         FNb2cnvHgnB3ME9erWdn59KZVAxZGIunFNr3Qbu4lPttxXGj03ATifL0BPTZl4Y6mg8Q
         SLtGjeI8A4zfhH0dECMoB62M2LOSxQFgE24cbndNSCxrUUa4k0e0GpDk2nUdfkUABYmV
         5sX9gw4loGyoW+iLhyUou2vWQQpb4tqWUOyEptk7vZPk0LOlSvalRCvEU3YolYE5I7/T
         F4vw==
X-Gm-Message-State: APuU4Z+igTeOSZEHlL5iYzWz9IcZ5xGRlXLRp+8EKToLPVysFzLVzlb3
	AXQL3D5ouEVMsvYzFig8lVTXZk1g/mIFzVP5GrLtUTt2EHKI8kJ1b9hn+YIunA==
X-Gm-Gg: AYBFou1Y8bV+kO6f/NgM4cT4fnHWReFk7E1I1VILadM9+CIZ+o81DQRtB1yatFenD6M
	A6AjMzrFF5yk0KuUU+4hivugRgZIWWmzkMaNLn3Mi+wXj29DWfTPfriA+npvgzHGNjKFV9CIIk5
	InCDtmlOgByX9CES6NTcNXb5/gpNhOTdUfbNhI0tTsbK/7yR3gn9KnTnDu4NDpEdKbuWKLQ28Hj
	Wr2gQN6S/uMeF5WDq1H6kFD2scBy8V/KvK95peBbJoySV3+ywUNFUhf+5oWW7KVKojWRscmsCUT
	3pm3NCiZGDG2etqQPsDXlkoPjxre44Wq7Bs93y/jCOrULdUUh6DgCu6BXkUugFKOxEVcjQYKDf/
	YsSsVSDR459blFKkLeK34vZ8fTswsoHql72/5G4v4Z4wWPMdG8Ctx7TsxYixb52Qf2W7k3WnGu0
	W3K3tB7Whp1BACHFwPLoH+8PY+Cbh31n7E2NOGw82f2pQW33vPI52T1ddi0zwRWlY0uYnnWBQPv
	vc2CvxMp9qsSMndUpaGkg85AprhAeA9ja3x4sKlf+F3K1BPizzNumVYkVsZ8CGzzeXZAe4mRnr1
	Z8qFceTr/iVDuju5uIHHtrFZwFcb/hHoS5dgYuuPoBMkjS63M2//G8TpfUbwG8Cfy+JoEwH5VBO
	A8yqoC6RXulV2kISG3kTcSrsT8IbGnQrm7sw23V9+6GR15jk+07iy+FBt2K/AOd5pGeHDX+aTig
	==
X-Received: by 2002:a17:90b:58e3:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3ae897cc9f0mr6175910a91.15.1793560952122;
        Sun, 01 Nov 2026 11:22:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15652012a91.7.2026.11.01.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:31 -0800 (PST)
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
Subject: [PATCH bpf 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Sun,  1 Nov 2026 19:20:57 +0000
Message-ID: <20261101192057.2296489-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The elements of an sk_msg are in a ring of scatterlist slots. A free slot
can have the end mark, because sk_msg_init() marks the last slot of the
ring. Also, sg_init_table() in tcp_bpf_push() marks each emptied slot. Thus
sk_msg_alloc() and sk_msg_page_add() clear the mark of a new element.

bpf_msg_push_data() and bpf_msg_pop_data() fill a free slot with
sg_set_page(), which keeps the mark. Then the sk_msg can have an end mark
before its last element. bpf_tcp_ingress() copies the mark. Since the
commit below, __sk_msg_recvmsg() stops at the mark and frees the sk_msg.
The data after the mark is lost, and its pages and memory charge leak.

Clear the mark after the two sg_set_page() calls that can fill a free slot.
A free slot keeps its mark, as today. tcp_bpf_push() does not read the
mark, thus SK_PASS and egress redirect do not change.

Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e187e3c27999..d7b364e43b4f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2995,6 +2995,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	msg->sg.size += len;
 	sk_msg_clear_elem_copy(msg, new);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
+	/* A free slot can have the end mark */
+	sg_unmark_end(&msg->sg.data[new]);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
@@ -3128,6 +3130,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				sg_unmark_end(nsge);
 				sk_msg_set_elem_copy(msg, i, sge_copy);
 			} else {
 				struct page *page, *orig;
-- 
2.55.0

