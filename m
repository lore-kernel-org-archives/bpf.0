Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560022;
	b=lJ6/UUzLEp421lhoRuwHDt1xvFwvj1lK+du2UWfCi1q/2Bvlu2DMgCBfg6dQnCjyf50b
	 dBLOhktYXU0AzyUvA5byLRy/n0Eo95wLQ5n4UdgEVsu1+yUqbfOv3IJX+vDZAU5eg2S+L
	 flRdFZOcNCNnB8pB4iYcMxQsFP0jJwYOlgQ0ZXlYV7Yg3DFZz2NH5a/PAPaKUU4FmLZSD
	 VjVJ6CtigOjY6v7qF2sGt6Qc7vC7DOqqKQP2UZLQdP/1/CSxGXATJ+1+9E+/VZbyUlJpt
	 ueyZCbkUXdneWiNK0lXO6XIIdRumA9RAvRlqrgiXHGw8DNpjIe3BwD5uoMOs5xr1mIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dyLl2bdfqfraD3mjemdszQJ72yihqWirD/TyY2NJGmA=;
	b=jJJG0voaTebGs76MTrMLU7AN1tA51wZ04binovR1+hx8aHmluRimF3Gku/XlAvnMqHHZ
	 c+LLRZMUgFBd7nBFa7yyViU4/q4Ryu5t++Jn4IWYgHX9fM9mayH6ZovQNgzavxgfFfyeT
	 FecPAdnApaEH6d9TNVAenH+Lw4NmNn02tqY8StvfQZpnZXg3r7EwTVgg2ZLjQtXjTyp7h
	 Y7CM0SNPYJZG8MVm1C0bK+WHVaYe2WojLJmyOcTFl7O8gx4Z5jxMJ1AStzYzcWRaK9lC3
	 ZgunHwkI9MNo94zolL3F7Ut4AtdO1NSULtbCdX1YQ2pXqyF94fNY8W8j5vTbJqBhdTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COOAoiW9;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76040606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76040606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COOAoiW9
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1314020a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560022; x=1794164822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyLl2bdfqfraD3mjemdszQJ72yihqWirD/TyY2NJGmA=;
        b=COOAoiW9I0TfBv6DH6vOQJOnr1f2G5xiOeHQ5T5lE5tgW1mIphkIUVZR4+T3u5VFi7
         1z7YRaVylWCJOuzUthisVSQT2I1iV0NzAI0tLqsxyQwGqeQTCCVuhBukSnvDYYu215f2
         3fPPuWIrBCBijuIP96K6X2fWE46t99sXe+btJiyyT5v1kQf6iwmZFnEh3PBIMiut0bpE
         akQ0lvzuGus6l98L+Z7hequmu9Y7byBIf+O4yrK78geHAp6IqzPmqrdrMkKvBD6OGp4u
         Yo9PFGcEJCO02JlLWvJ97luFdACIUeZU1q5SxObfAyR1glQgMcQfwIV6RYr5XUTe7cX5
         alGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560022; x=1794164822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyLl2bdfqfraD3mjemdszQJ72yihqWirD/TyY2NJGmA=;
        b=TKgjsil3WWqAHQAeZ8QAZGlBvBQ73d2QPjBsQtHQIMb+emW2JsNcafTtafsDO8fnfu
         B822AV3FPGbR4wcJ8l0PIY0SDrtBmUqJvj2TJV/+hWvbgB4z+uc8v70G/HJRLu+M6/W2
         da+xuWUne+HONjCUbPtrDXxejlTPfF8MRqhiE3KXqL413zQNPnJ4ELilSSBnGMGUWnJr
         0XNXGyf+m/eS0HrJZ7VH0aC0KZbz9O5hIHf8Tqg0JOyr7YDyC0/95QmESXLmObZK2vGz
         QDolKqCVJDGqdDb5qOWgGHTfD1fyEWC8Z5oQgTUjGBmHI1JqGzbAll9YQaaeYQ8oj/0e
         Y1IQ==
X-Gm-Message-State: AFq9FYKBsv9QxMaP/dXbnbGs6McN0UrA58RkKnBZnZO3xkXd12TLwgND
	tmpJe4qLwbv0wuMVO9whhxoxTuWloA7q6ZxVLYjykE8/FbiHoCOZ3isFw25/tQ==
X-Gm-Gg: AYBFou3jkrpzHlUW//agUZxjKHPHol3zF2xVjId/KQArBVrepWzI60S+B1ISLD4AoZP
	VTvoewvLRsYCaW54hMFntKBFFNy11VHzfwb9fTKhmbr8PBZP5LDOe3Hmz74ld5x8T4UxQFPjHxr
	39F2VwYIGjXGZLaOMMug3xyLdskGekWwxzGD+OmKMgdx8Uh+8FAqYu2yMkdg+mukJLbffRzis73
	r9zhTzp8zh6QSPhQSGIssiHWmNXvYqPqL2HhRb/rx2q936oZzl0/H+twuownjDx1M4NaZjhsNGh
	WeogCKwgHtpKh9wHSnvTt8Eqy/9zHeZRJj/QRQvEFpha6m09ByrPK7x5Utlbl/4IUBZuGh/EbO/
	6QCx36g7O5gsnt6AnKZiLQ/EPLb8wuWh84u+uugCjbQAUrka1gIkSKZTyYf8nyjFfyFhT48BW32
	ZIFHCsRtWX55dwJvvtb9cOUPmKTVlBUIrs0Rev7kbpDHEwRKHLeVrGeamioLOYY1RYmDzQSfE2k
	Fxe2gmKcCDqCAzXqOsEpaQtalKGfP8uSgI8Q58Ywblcle8lPtK090Z9AXmfsp0V/ozrOfjk+th5
	kz0Ui7ksnjBwCVNPQc60fo691hm+09Vge415pSGiU+/5/0EtwdZyKR8RM4EsVkLQnFSYKwvi7cu
	/0aDIuYZDic2eFIcKwB8OteCmHRWpe5SNdCtlw8KUnKMiCyBJI5Iu3guvurPY1tLKOCsgvGrWzQ
	==
X-Received: by 2002:a05:6a21:328c:b0:3cc:8344:1213 with SMTP id adf61e73a8af0-3e928646152mr8676454637.8.1793560021574;
        Sun, 01 Nov 2026 11:07:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9c09086sm1119273b3a.23.2026.11.01.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 14/27] bpf, cgroup: Keep the skb network offset signed
Date: Sun,  1 Nov 2026 19:05:22 +0000
Message-ID: <20261101190535.1454146-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

cgroup_skb progs see a packet from its network header. While they run,
__cgroup_bpf_run_filter_skb() moves skb->data there. It assumes that the
network header is not after skb->data. It negates skb_network_offset(skb)
and pushes skb->data by this offset. The offset is an unsigned int.

But ip6mr_cache_report() and bpf_lwt_xmit_reroute() can pass an skb that
has data before the network header. Then the offset wraps. On a 64-bit
kernel skb->data is then far below skb->head.

skb->len has 32 bits and wraps to the correct value, thus only skb->data is
wrong. A read of packet data faults or gets other memory.

Keep the offset in an int. Pull skb->data when the network header is after
it. Otherwise push it, as today.

Fixes: 3007098494be ("cgroup: add support for eBPF programs")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cgroup.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ca681d626c9e..57a785241d42 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1790,7 +1790,7 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 				struct sk_buff *skb,
 				enum cgroup_bpf_attach_type atype)
 {
-	unsigned int offset = -skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
 	struct sock *save_sk;
 	void *saved_data_end;
 	struct cgroup *cgrp;
@@ -1802,7 +1802,15 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	save_sk = skb->sk;
 	skb->sk = sk;
-	__skb_push(skb, offset);
+
+	/*
+	 * The program sees the packet from its network header on, on
+	 * whichever side of skb->data that header lies.
+	 */
+	if (offset > 0)
+		__skb_pull(skb, offset);
+	else
+		__skb_push(skb, -offset);
 
 	/* compute pointers for the bpf prog */
 	bpf_compute_and_save_data_end(skb, &saved_data_end);
@@ -1844,7 +1852,10 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 			ret = -EFAULT;
 	}
 	bpf_restore_data_end(skb, saved_data_end);
-	__skb_pull(skb, offset);
+	if (offset > 0)
+		__skb_push(skb, offset);
+	else
+		__skb_pull(skb, -offset);
 	skb->sk = save_sk;
 
 	return ret;
-- 
2.55.0

