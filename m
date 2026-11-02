Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604177;
	b=phKsiusAf6HQquubkaps1gIVoDkuOiaMsz7E3o+FnbvZhjSyR2Af9xTSlbYlsTl7jvsP
	 79hWyw7h+Rf4hLBB1QEXJVsUvziu7z9LYDEsDdtzVa1gaxCLnLbaYqB9DJ+uSGP1vNLfi
	 GwQ1Y0JNChgPf0Y6mojsBR+FKrRWM0iwZtpmWgMrJ4qZd2xMEue3EU1uO0E64IrHjwK/j
	 kL6YAD7WMg26gvpprd+UyXrdqLpAQNrCrlQtwUdBZRm83zIMmrvplS81KA4818FNNMelQ
	 uNiooJs9vPj+wuf8YABWN1/4w+l2qBcIYP8EgOr9kMu/CKIsOog5P03YplmNClY153w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
	b=u0IK+upG3Bj0+3VeM/aFm3yryvJvQyxw8UD3RY1Up+fSwP0MFsxKj5em1pSxrrK1ghhA
	 d5rDLjgeRobTJXOwROvcz4Os8DUaznLqPouByC8ibrafKwejVs7uQu4hb3ZFB/NZi/NSo
	 ShI2InLG0k2fov0km2IrAYd3oJAS27hZyTVj7F3t+JuBSylG8MudaJCR1KVT3Ad6Opa38
	 FmZiFhgCc/OcrnDYXfqu9x/vk3JXbW+SBNMB63u/EueBAvoZjP0DTSfa+qDawf8qdgxNi
	 3X6PyH3M/kBQhcmpGxdLsUxYIINQHoRS2uGG+86QmALNP37aVXTm4XdZQMupYXIxBVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p29ySwB2;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584A606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D584A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p29ySwB2
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so1500768a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604176; x=1794208976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=p29ySwB2d4ctEFxg6SPwooqVEVkkzgOMqzljXnH+nlOxcvXt6uutwLiOp58Voj7xRb
         Vz3c2XfDqgIPr0lw3Rkwi6wf1IKmOa7F298eHTNbfmAVh87zI3EsGOV8n+Y5JPBX/zeo
         jUnOWV164lUA3obLn2GM+djz8hk2ALpFmz1GA8Jmy5htkwoJB1Ny0cq7eIsRTs9uoJH/
         UT6+XDVPavyak7cL1xRANvwLUSwRZPU77rpZ8wGpn3Zr0bXUvMVqFgAjP4BHkr3WvhkI
         Fax7RdhEaIX7WH85byPkvjjMJYI/PJ7nCFnFnDitb5rqmak00o8hu1VelV5YCLBaXg7A
         KinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604176; x=1794208976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=tMmXHzvRk9wPYbGsncrQ3DUdNAHCw2kkdaIL557NNAnGGzvCMs2BC5ZxnuFEwQYOsp
         LgaWFkWfUDWDFAR0YIBwiheCZRkdG6yK4vyVHjEtHpvQf6wcij860opqe0zU6Exy89yM
         lGliyVDSzCUuNrflPL2GzyEEqfvkyff1iyhyevLw2+NMxNpEdyG+8+BA/G9E61NqOswk
         boEiGyG5+hwIjwffyAO7TscIKveUk8ea0f8nG4+ApW2T8bWJTT8+Aw/mZVzQ4YRwrgiw
         pvUES0+jKmw1MQox6+gAWBjU0UVqPrXDk5EeVpilmd/bDBYr5S6rZqI8WE4mEiEPFdxN
         YPdQ==
X-Gm-Message-State: APuU4Z/eZMzhlvbbs4QrmBeyfie+xgSNc5NXb8ucA6Ha4ji9HW1ul8TH
	op7AeDBG8r6qV6L/f0+wf0Qz0uhrVipkQhRvayxCbkDd8z5/uOmC6Jwr8VzOwA==
X-Gm-Gg: AYBFou1DWzrPcuYRNFZ8N8sUu5mpX7H4+UYihzZUUi6LrcWFf8r7CD6sCee/wIHfUoz
	HJ/QE95Dkh+SzUCMZAPSdd7/OJceeBa57ZJ5eIw7+NTWqDeMIZsWzUPAJYzuVg3S6q36MBG/BuQ
	6UNtXBkNI6k74F9z0buKgZ9CrZBwfIpBoqUI1jKS4HPgjPZPg03LfRpRtbiIR2I4yvi2AKnC/78
	n3P1RT+Ym3vxYLXFjiC1MTTyDDCYm3v6PTbXYmJku3uiaVfCI5qvEKgeumZsDbfhwouH/ePEtth
	KYe3sGiFmKkCP6JTI3JLIq1MUGkvfPsaz9GFt7RMh8ZuccCDQjz3TH0C3KsAc/TBU8pJABusBhj
	aeB4UtgHRj3D1AQJj1ehB+agXRfH4/Nj/zVTi/9Os6osMArDLJfbXK8WQv2FmAOgbA+gVAGrBkb
	9rujcZSZbQLeS4ye19VGRtfiT1x/ELsqsyX8oYAx7vqAea9kdXdcQ9U9tJa9yk6zn0JL7uG8fgq
	C+d8fl97bFHnli0Fvb8beLMgW7sAxSRrfQm8LN4eWhgGeGbH+wk4jSKgZi78w/CQ60KTDQ9bWzT
	1LAFE5IEn+iiDYqyyROwDiGydetGzYb5mwOlJFireFqD0vNvNuHnts8E1N1a2tBVGq2zo4iBS8m
	C4Dwu/Y67dQ7vd24f6bPM9oSZ84M7U0u8y/xqlqgJ7bADaqfkJcJ6vOYgue7ElwMRWtmKOSnfQA
	==
X-Received: by 2002:a17:90b:5347:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3ae897994b7mr5021140a91.32.1793604176024;
        Sun, 01 Nov 2026 23:22:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm12518065a91.11.2026.11.01.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:54 -0800 (PST)
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
Subject: [PATCH bpf v2 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Mon,  2 Nov 2026 07:21:12 +0000
Message-ID: <20261102072112.4160195-16-alexei.starovoitov@gmail.com>
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
index 50c0cda778db..d68b52150405 100644
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

