Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530716;
	b=lEpuhRcXX3cFIAIMPYIMLXWs7gQQE40eLHWEje41/qMpW+Uy+mUxIECFJw/iOevsBmqa
	 qRhAt+PjcNcuTZDOZxfhIPL7CghNvmwKrTn3yK/T0mzUNslo/mpdCcWFzRUzcnxj63cez
	 0iYkA2+90XgxqTSqgeAsigviNBR5M5PvR99Y3pULT2awwUQvnEihIdhDGQbnu55To3YkW
	 FBXZLnxe4fphFpU92ZDIK3Vuf7HZE2avXwYtAgPPiRz952/zzLnrDS1qYyoRtLMfK8ceq
	 hVvouASG8BOCPeuisZdJf89Qf1h7dq8qMdrf9G8klBokytGCbK2Jt4JqWPcO2GrC93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
	b=3kh/Hi+X/5wTGJH/sZPc2g8uBd9YC8tBYPyK1nR0dyWoiKyKGXxD39ubgdew8cfFVP1n
	 0y608AXJwsCwJD+1Wlav+IPqglclvytTX7HGrWuKZKKYQLEjnqBxrTsUlWpcSM94n6jqP
	 drPuo0aBU4mTRZzg8JgfBemFEWek7WB4bgl2BggCJ/crhy8AVoW8HRkKKYhghFGcUZyfp
	 kWSb7LYMDb7vbkl+Jy8lba5d6AjhMUdIk0tf59pIILFQcnsegX/YfcNgrzG6VJkHss8I4
	 opqb9y38sNMP0+Bz6by2Y5H4WuDRhO1Ko+p2JZ9YKKuQ8CloyD9Tko/7C/ncdi/SKDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZFPSpwn;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471A606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3471A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZFPSpwn
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso3181996a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530714; x=1796135514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
        b=eZFPSpwn+EWv3WI7oq8FlcFGbwsio7In32Q9BXJj5JT7LzvUi+kuUNm1OptvAjCIym
         aF8gEZ7GN0JzTzjRlSQ3RzWTQdd1+ELxeIAcrsblcQ1cDQsbrRnXpt+qp6NBBwMlAAlI
         8dmX7Soe+UgAiA/D0pjjKxJ71j8a3BiSOsVHvYDirhOXjv2CCz65FPRAx2J+gZxPH3X/
         Wfji9sW+KxmqfmoK0xns6FC+klWB+WlypOLzUqUiwa+utnziBtEUEndtzhsyOeCrhJMH
         CUAU99cpqBKX1trCjELPtos3AEXJ5UWjnA8HDPZIaR5qYjzl/vWzUSFJR2woUvkguqGi
         L9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530714; x=1796135514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
        b=z61Tk8s34Yp94A67WnLouAC+zzvnrqxnP1UzLJPHbNaRVNR9sQUEltKkK+0S3Ds1q4
         XzX0RKtnpEMOElIMc3tz4n8+CnEwIir7E0EkPw6zcke2uriPyYKtjJiz+tN65wUl7UId
         BgoBMVVUczZU8sWZVlzVe3dgiPXEf8LMXf1DEqBKIpSUQJK76GVwknLd8wPIE0H/t5Zb
         pRBZpLgt05wbyYo0/6l2pGZXZ/LNvUZfLMik8XoLvDNJsl/xSb+QSPdFWD2Kbvs7sX4j
         UNhGqSgMfNAFZm93aaAM2BY/KBtHlRPQ/7AagOwXojwEDVcjYix31Ou3EdXSpozPCEf6
         9v8w==
X-Forwarded-Encrypted: i=1; AL+hErFnHX8JZZgTKYeC9VnAYs0ZuminfRs7bHG7OzsDsOrl4BpIR8nrGW7cYmMSY2mQCfzRC7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t4kkDYyPxFYP+/KsFDr5mukodrgCt4JlI8vhjHutSYXtF1XUG
	C9h0jwAWDDIUsMuDrM5kxN1fatbxT/zavFIf+5QzEvEwSPFB5q1cd4ld
X-Gm-Gg: AZFdTZf5l5fPIAyCa/jUtGB4s5J4JXPSWi6UfRTCfofymWRmyKCgOJ/fg/e24UCwCH9
	xA2rXKAeJgXbWA6gQe65PJIu1Owqs+t7QLzuRMY7p2pxBKtLKFqSGYL/i5VKSp2B90pTI7WyaG0
	6N+T8/fUEgOEOOndT8eUIflGK1jfyeNxuWw+XScRpXKKhjMz+HSUkeXItHeSL5K77lEsaGEVegr
	IY/KbFgNQOxZcK9wlGL7vKQO0rbnqfy20Io1JoSKryWosdz2yq/8v38C6oZGKs9W9BjnarY1MWj
	dNqRFEQN6+fpOqQINnB2hogOXHtsVB1bkQClY2akLXqmAWEvgMgU0Hk/U/WX8B3q+AFc1UxBTeg
	L7adGeUJMYUmb011Tn02YSCttmgdL8VpVA9ADRYm+dPOuzR38VeiIizgWP/nKYRWesqAO3zj0Pe
	hpA/bfkstCC4VDHKynHHiAaMlCiyiPdBrRsJrjFu8PR4iX5ibxbNQ2Gf1aJHZCZS6bS2F5OpTYE
	29lIH6fs6IMF0FUB5/9vwYIkoe9BzZhK1fRHwTmTc91YxIcA1iv0mn7qVQ069rbq0/BOwLa/n40
	g43rcFIX4bPeUakijyrqTvoWnBd4PtvNgqk9HA2D9Zo+PXXZI7EM9wRd60LyJdMC
X-Received: by 2002:a17:90b:4ad2:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3b41c99525fmr14250279a91.58.1795530714346;
        Tue, 24 Nov 2026 06:31:54 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:31:53 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH bpf 2/3] bpf: net_sched: Reject sleepable programs in bpf qdisc
Date: Tue, 24 Nov 2026 14:31:14 +0000
Message-ID: <20261124143123.1182108-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
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

A bpf qdisc program can be loaded with BPF_F_SLEEPABLE, but enqueue and
dequeue run with the qdisc root lock held and BH disabled.

bpf_Qdisc_ops has no check_member, so nothing rejects such a program.
Add one that rejects sleepable programs.

Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..3dbe52a04fa2 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -356,6 +356,16 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
+static int bpf_qdisc_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_qdisc_init_member(const struct btf_type *t,
 				 const struct btf_member *member,
 				 void *kdata, const void *udata)
@@ -446,6 +456,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.reg = bpf_qdisc_reg,
 	.unreg = bpf_qdisc_unreg,
 	.validate = bpf_qdisc_validate,
+	.check_member = bpf_qdisc_check_member,
 	.init_member = bpf_qdisc_init_member,
 	.init = bpf_qdisc_init,
 	.name = "Qdisc_ops",
-- 
2.56.1

