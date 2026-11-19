Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098498;
	b=V7srNr1Vjonp3FIaOm7EpVlzgy6oDQbtSnGi0FyIc9JKHifWtXxxcGUFmBws573klspj
	 7OLHiG1boowVuqrViZF+Cx8DEXW4iH2H20LdFoHUhLMlat/heaK2Y7vWKW4T5ZEdfpPKq
	 B8EW055FAGJ+4WsUpCoGF7jsnRwLb1SDE6ojGbePacQFM4+ZzbQL4czPP3LZd29ajz9ym
	 +FLpohtj24rR6TWpERInN7Y2+wrYxnfmvKkJFk5QN99nvfsycweEp1mmMo0U611N4BV8c
	 Z4ovA5c7HLkZt9+T6z6SsitOcs3kZZLNxJ9/N/9GqB3UMZrs3iOekCYiCsCGTF7/NdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iRkY59qNDTF6/FtMLA6rulCu43us4mTaTfJoQTFrVSk=;
	b=unvSODavV/l3TenA0lT9C+WKyY1cREH/rBj1aEfmnpFCDwKWxmzlye06zSrhsX0cBurs
	 tmJPz5bwi7QJvHT9nxljLx4BoQhbhiqh9EU5tV91ZEaZ/gr5WpktcyR3+hy4qxtlp4FjN
	 +Pack4ZnS09EvYswDhI2+/rQ8YKOiZQBgrqevgGpRhMDWzoP7/RFJOfchNLgcEb/ZWnNN
	 cRfEuF8lylq/PPkBGs30zfqLByKp6b3Y3Z+1xhDTRP4Hcy9QfRcigYMVnqm5xiaHoJjwJ
	 kBHlKoBBY7wQPU96w8CA0m5gqStQYaBlyyE0Lcg3QVFAuuEk6NYD62d7VbV3CysqYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H2n0DgEX;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F33606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F33606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H2n0DgEX
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so23987545e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098496; x=1795703296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRkY59qNDTF6/FtMLA6rulCu43us4mTaTfJoQTFrVSk=;
        b=H2n0DgEX8aXN207Kv6GfG9g3DcKjBWfKLFbRq9Ii1Cva1YzSqY3C9t42/79ENxkoe7
         FpJ0HCnvWdnvBmQqhwjI/0fxPUFH8y1oyyvrVYo2GEGneYe8MTaLySnJcvkAJTQ5rNWk
         zTqwRbmuUhT/QtK+eVkrIRnXXJastfoKM2oBmkSUz+eorHTFK+5breVqantvePY8E/7d
         CaqlHtG6DlQNjZnyBNNn2ASuLM3ouAJWab8x2RfhvjLQV3SdTKc6InPZDCpvls7mmn6q
         4wlPKxiLVtpt5UbOlx8jS1vDueoreUS/TVHN+LcyUbglw8nPXDlIPIo8pQmKGz4WnboJ
         pPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098496; x=1795703296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRkY59qNDTF6/FtMLA6rulCu43us4mTaTfJoQTFrVSk=;
        b=dnvakPRKjM6iZ3gN67XKrygomA0oeXF59e/NkdNvCxNsmj4A4tnQNksOhL5hl4o8pt
         bWPKwWQjaa3uNrOks6qLWJ3bMiwFSRR2FOf05oNqEjUWppp94nBylZfC0XAFy8THvHt/
         YoXPeEaCXaK7nc0fQpDwUBdKvgEZYQG+Wx4CG2JzoRsho2OJmrtQg16x13b/Wevy8rOG
         qkdo4gxo0xhTd/bEa0WdRy7Vtkg5OMjmhqNAeXM9RjOZql261mkrQkwzHRwgvi63ffHa
         TW/CECe2LFtnKw10fMaBSiDQaKDIO/u5z0dO9TcjOnVwOOiZXdMhXUia714of7oNVP4s
         1guQ==
X-Gm-Message-State: APuU4Z/0UTyPfXQcc6SmW5o0PfbmEYUfLWRU7pPLxozCtSpBvnWy+EH8
	ll4zTrEMV2Ao8szIUh4AOzDZ+TtYOrHgIsJqf7eivorMfGXxZCdka3LvjyxowdHBEBzOv3i48/I
	KjfyhO9Sqao0w
X-Gm-Gg: AYBFou24QMOEC3LNuEIad4jDDQqIi9eCuWgVRsI0kaJLHewjI/tF4IglZI9u/7oyITd
	8c59vz+uRpcN7TW1k+6v+LbLEFyLXYBC2yusRoP07vzXY/6DQoXU7Ej62Pr0mFmvJLOqkujqSAv
	alI41+q8+0iThKqGIrSwrU++kmtED+w2q0SizPF4/98JS8B+cf2k5Ubk6n7qalW3zizuxcfDjpW
	L8OK6W16TbT+wfj65ZSvOuzp9kcRzi+VsORIJmtfRsp/EBGEJ+4Yk0jO2IOthTiNPFwgYg0yoQK
	DgSC5kAKzyi90Fpf9JMwyE9+BRH3IYChCiQSFR+itU/85lFwoVhYHvsB9E2e5FceMqI0vz+GZJy
	mEokrXZWSPXYyjtv8ieJaRwzG7afgMcb3YAoWhhjWWEOYvUGV+QtCMwLX+GE4QkhONkmAXcHSG3
	z2NTSYcXIv/fyDDVp8jccdcWiUgAqWseRi7E/ICda970Tiqbl3mR21K3rzTJJAHHGLZw4Y3y8xZ
	998gpzIYaJg0Fo/yrRlSj8rQzgiAkh4b3vkLCb5pw0EVfmIngPSxwGG+TebonhDdBUWetsNFiei
	D+c9FVuXjlqZvf2IKc70aaJWG1UzFPeaZPRfPIxFKSv4w21iLRo=
X-Received: by 2002:a05:600c:4e44:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4bb7da12957mr117847055e9.9.1795098495962;
        Thu, 19 Nov 2026 06:28:15 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b3a7sm47857185e9.3.2026.11.19.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:13 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/8] bpf: Orphan prefetched sk on skb_do_redirect()
Date: Thu, 19 Nov 2026 16:22:23 +0200
Message-ID: <20261119142231.2612515-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

Ingress bpf_sk_assign() can borrow an RCU-protected listener. Redirecting
to a qdisc or receive backlog can outlive that protection.

Orphan prefetched assignments before potentially queued redirects,
including peer egress. Keep synchronous peer-ingress handoff unchanged.

Fixes: 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: John Fastabend <john.fastabend@gmail.com>
CC: Stanislav Fomichev <sdf@fomichev.me>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Joe Stringer <joe@wand.net.nz>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
CC: netdev@vger.kernel.org

 net/core/filter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a17fce..1ad57a371534 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2558,6 +2558,15 @@ int skb_do_redirect(struct sk_buff *skb)
 	ri->flags = 0;
 	if (unlikely(!dev))
 		goto out_drop;
+
+	/*
+	 * Prefetched sockets may borrow a listener under RCU. Orphan them
+	 * before redirects that can outlive this section. Peer ingress
+	 * stays in the same RCU section.
+	 */
+	if (skb_sk_is_prefetched(skb) &&
+	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
+		skb_orphan(skb);
 	if (flags & BPF_F_PEER) {
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
-- 
2.47.3

