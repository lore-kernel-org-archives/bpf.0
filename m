Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734431;
	b=C17mqakYiQV/ai7MTeIoifsQHyjvLcQsdmesLG9bT2KBjB683mNTIbuyIklpQdlHlnll
	 zGiFa7uyJZfiLNmnw/5rwWc6F/ijaLAM8Xb/3RM+mFLjLP0fD5N+oD1wczheW3/JCEsml
	 4dnHIjWff8DfOAeoudXPSsmKst2iB+Fr1uw9XVVIIVRD8pvramGccUPb6bdUVKb1R+kbo
	 4flBxeq8n50OlXaiOCsSeJe/iRqilterJYcPGL48HOhCme/YOI6LrnnZPrTcCHWg42qnG
	 4Y+WyHBPnNslYafgkohyjnw2DT+aWcN0Q5JDMIJDW9VUuVF0mQW4Alzc+mUa6vMmcRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
	b=31toDecABse3kdYq3s1/xP1UcKPONMjowB//7ZqMMhVWMC0cSP9e5DT/QyiqM/wjSUaL
	 P5USxWOV9nSE4N+T+5casrTWehMPhRiWz0uZfwhIPvTvNe/vcwL8fZ5kGKQhM9SdpZ2Nr
	 mjg3YmQlFWqttyILR/4PufY741A4dBB20CAiUXnKYZxMfnIea2VCm1A1ig3C7lmYBuaOA
	 DZwBB5uMJzfbltd6t+D9Bp8jq+6zeZmkxDvnnPtpaO8p73yvE+std+RXutBWUFy+Whlb0
	 DJTTb4TcyvMyDHeFWWqMIkna6NUbhuCErVyTPV0lVFL7ry1Amwwcz38WUCpxrKHlQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=SqcTJpkv;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B43606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 05:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B43606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=SqcTJpkv
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-354ba08cfd1so948455eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792734430; x=1793339230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
        b=SqcTJpkv5HBcy02byuM51R5rcoaGFMIlIsZJwtzs481Cp4yB6I5HyYbdcMJVT1zb77
         LoZvi9frKtcCXDK0tKiWS01H7Dul3iLsEtaPVwjFAIknlQe0k+GopSCriyb0oaSxTtNa
         2PGOGsMd7ZC2UN3ge3h2b7MQqf/XSgzQ178W5K0r+H2iTHFvOEehNTedcMLzeWpzj81x
         bkaIuv2/8GeYx4efM689sJJv7qgrwqueagJsN3amIfm8EPI+UA+gppztg70YprUY2vMM
         5dk1sovlAwrgwSApZehpf9bGPU7YLa+r6gs24gFCTkCvhtJyvanY4BeJ9NrLBhxshucA
         hXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734430; x=1793339230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
        b=gklvA0rivyGCcw/1tTBUH0Z/92BGhRz7iovQmwGJUx/f4RSfp2XW7Nlp76EQAo3gpk
         jeojHjHnyB29ml9M0J6Gb/eP7arO4DmXpGgNP6ddBjNjracX/YE78hN2LoE7uOBzvnoZ
         wVi0thJOLH+WI12d2eXKmOSrhaQokyiZq+o5UmxOR1l4SlIuU0xjjEvxn//4XxaiejKx
         r27jnwV7aA64adPaFfJzQrGldwvN0GRnY4CAu2OFKMXp/yzWfsF1kwIzNpu6iOtEetqD
         erU5AOxvlJQOcjgKMN3e6NeYlpCb8R92JgSWhUFguzlVvWBDB4XHnqH/z+dDv6vaU3Xo
         aaVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuQfw/u5VHhiZ4ifCbfd04Q9Wq0CEI1gvl2fZReNxXGnsT/B4cAsqKcZvzQuktwcmXPpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKit7indNCjokgChFZesDxAJIf+r2cx/0PoGoKSP1Xl7Y2cc5O3
	IQ/kZ1wLZK6wYwfz08FiHYr0sj3mAwn94LQlh+H+xr+0IaZ8MtP206SJAHYtod3CDBwg
X-Gm-Gg: AYBFou0Jv4FgJkjg3QP7qo/5wG642/kJdXO6TdRltvnjHj/i0A4DBzNg4D/0/4u4hjU
	HdtF+9GfulFhEVQ6owtu/PyvvjDvyZqV/lw35jlsg8MNoftVnwjQQcDMpf0LdRXuk+3fHgZILh7
	cQAWn7hO5QzBGkP9UuUqpnCws5+ILoVP2Quab513Ywqz2dEGxaGF6aou9SIyFZhCNFqu4Pdr82Q
	jHEAWHjvRiWb7Iqlbu10Mz1HxU9O1m+BF/28R7qnNu83R8RucCyyYxbLrVnclO9FT3r2EvtT0lH
	9hcKNkIwZSblHVtss1lzl+L7Ju39ztX1rblzAL/T7WVdX+2oHDVuM1YgxugGLF0dNUJpoC9eszW
	+viqU33qBuWSMJmlqDgbW1y2h5hGXgXr34NlzVMB2c8y1N7Znfr134uhryFKWZp6yXtIWlsGCs8
	JkUd+IJUgEthKposfjg7VTH9k/OzemzWyosFR2OE4PSf4XSyBTaA75hZDuH3lIbssVc0LREbfTL
	vF7k221vgTwIaBVJjSd10q8cG02/Za8Db1k2JYQMp9JA2CNTmhoPobjMzJRFJLktXVk9f7wHa40
	7m1S869CT4s2hzRhlw==
X-Received: by 2002:a05:693c:6383:20b0:369:5583:bf48 with SMTP id 5a478bee46e88-369d975b14fmr1517647eec.24.1792734430266;
        Thu, 22 Oct 2026 22:47:10 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d8978csm6252135eec.13.2026.10.22.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:47:09 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] tcp_bpf: sync copied_seq after pre-accept data
Date: Fri, 23 Oct 2026 13:46:51 +0800
Message-ID: <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792733621.git.zhilinz@nebusec.ai>
References: <cover.1792733621.git.zhilinz@nebusec.ai>
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

In tcp_bpf_recvmsg_parser(), copied_seq is saved before tcp_data_ready()
processes data queued before accept(). The sockmap verdict path can
consume, drop, or redirect that data and advance tcp->copied_seq. The
parser later writes back a value based on its stale snapshot, rewinding
the sequence past data no longer present in the receive queue.

Refresh the local sequence from tcp->copied_seq after tcp_data_ready()
processes the pre-accept queue. This preserves progress made by the
sockmap path, including when the receive queue could not be fully drained.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/tcp_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 0ce583f68d3b7..383ee167eb300 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -252,6 +252,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	 */
 	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
 		tcp_data_ready(sk);
+		/* tcp_data_ready() may have consumed or redirected data and
+		 * advanced copied_seq.
+		 */
+		seq = tcp->copied_seq;
 		/* This handles the ENOMEM errors if we both receive data
 		 * pre accept and are already under memory pressure. At least
 		 * let user know to retry.
-- 
2.55.0

