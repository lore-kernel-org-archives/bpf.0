Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577646;
	b=L5bcak8pvTIFSJ1evE/AJR6A3cmWo4CGY37mdT80wIVwcNaLV6jx5o6kHmvq3/SEIcEp
	 LpYHamaf0mAm4lxxZXt3i7ZyRoSutFqQPQqLPketMYBbPQ3iu9jZyU2FgYsvsO+5d6TjL
	 co7FIZMtLTonkTMTIsVJYj6YP8E0+GyMc6xoRgY1cNAX43yPQZElBxpryq/qDCVnv8aDm
	 +IapGJd92IicDueTIpIQy5Te2A9DNynC8UR8/Owt3eir8EUxbzlnZR5sUpvo81IDyx6IH
	 m5pv90JRJdX4Pxkpf+MnD+DwKNbx6ckDGyRReG8Kxrln7tlrbJUBuDtAl5+2L6R/YyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1zcodIsOsWvRz0EdhH18XfWhfm5oRn7Zc1+7JApbH0I=;
	b=vv5Sj5u6Jxrcu9S1l+OB6t6NwgWYaOgif7c6nFXId4zopQA3/LD+IqVG8kLy5/YxITOK
	 RfXx/bcdK/u0seHyYiGLccvTaCqxrRF3WRRRbgmfRtIVpAmIphhrtpJHujHOYmSAsm0dr
	 v8w1ZwkjUNagh3mBQLFq99EIjxT+wFHiIlE/U+/anpi8Q+IwQ4Gg4bQ5XXC+EhLlyke3L
	 tUjKmXiBZEI6sLEMUUFEyxSUO48uySHCzjgW0JRqAgwdlQz60fGSu8MeKlGl2FtfL5QKc
	 7o1nLsw0b83GBnscCeobinQlAMUEOBnJ01+rRo6WxjfSg5jCIJg4D0e0mBsOLxEZD2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZQq2AgN;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E99606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E99606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZQq2AgN
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so4123186b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577645; x=1796182445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zcodIsOsWvRz0EdhH18XfWhfm5oRn7Zc1+7JApbH0I=;
        b=tZQq2AgNFQ/RzJm4jUSO/3Uke5KP6v5Fc1bXnCVV0VpqV9EbcFatN8O+afykYfyX6V
         b+Dq7rX/WdOX12E9RQd+GWgJvmR5EU9CBkmpVF0seQL3ANr07gkFt91aXNciILJ0cSz1
         IX4y78XH3bK8gjDgqltG9oVSY2z1RYMEOFVeG02u7b0eflzYMTq0S3cUturYcdsfQPed
         5qUmaIdI6MU544oOV8lIDi1yPTpL4VchkBHRMPTwcqA1lWzlNGEuR45qxJvyjn0+ZlSg
         FgEPfLjB4GjwYX1/U8sVMpwGJIFs0f9XtvMQa7E4KiQzCOxzPiEuTzqBbGQrblH6CdzF
         oESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577645; x=1796182445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1zcodIsOsWvRz0EdhH18XfWhfm5oRn7Zc1+7JApbH0I=;
        b=RERZVXHNyvDuEz6OQIhMrzBlPKPL7/qA8/+EQfXxMQv2CePa+7BvBRuvIZdKRsA0px
         +SLVcDJonHAb/xe0sbNQNmOfhCkXXwlkJEVeL3LKzVUbRNuae2dB4W9UHCZXaPKpk7VM
         xkIrVK2lvcWpgJuApo770TM2GWPiW2Sg9BptQWzGGD1YpsRWA5c2xZtt6ikVo3nP1sLP
         FAqRJQOM1I+F83jR8/r/JkKKipcRrG/MmLhOqnlHVmSWFFv7CZiR1zqsIJ0cdAwz3JhJ
         tCs+76qnvA9q76d+818vKVh1iduEf+rNkPaiC0WxWXF2jqc8/OD2armg+99BBLj+12TV
         DIbw==
X-Gm-Message-State: APuU4Z/+s4yCfhZmhGMf/gWeajyc5jqJc3uaFf4QJSWEAep4n+1DYuvl
	98XI631xfIpS/nVkZHkFHG0ogJOixvYGeSd5gUDZtVCCsu7hp2iQHU82YuEOyIuT
X-Gm-Gg: AZFdTZd9CtbwVYdS05ePUXafW9+KKMizh1WuNiM2353hEkcOrnY08C9VIAo4GUgeuYx
	8h6cXIvGK7YyctYV65a4jAXfiKGonrXtz+w3HRIBse/MG1wkt2oUEB7K+xpiCNmywNj0sSb5oj0
	ywg7cMaHTYQxDLlzb8r7E1g+ALES62LPJuttzP3H3bYnsUbUX1y+YA67ZAe6t9lVe6VVkJ6YLf7
	yI0G9LfchhU7Ng8ERcLjdIfK4KwDi5Wk0pisvKZD7KMYyOjUqMciMGD2jECgDeKzfAqHTYFNgEq
	TA7+LaiBRb6t/g0/6VTALwFi0St4kcNBNsw9tp8KnJnHqDmS5Olmoh1bu3GILNKnfhRutrz7abZ
	dARxjVbj0/+JTf4IQzPhmtUYrdMxmMQnBg2ndNNXFdx8yuEb3Kr2UEHOuKZJ57Nty2Cen2rtrmB
	eyZUdoFDzZZxgQrNZ+HCxfl5JDZT1mdgWJDAVlojyBKNl3SdCODnUZ8LuO3+QllOKFq0svP1jZ4
	by/WG6kXMZvySQBE1WSR6OZJbP2b0NZmT9Usw/UWdGoCp8EyqRTLxqasBqEgdX6fI3Jtbi5gSDf
	RmV0GQvW0A2+GcHlT79S/YLnb5Xh+dTdepRDskBh3o8pS+uItJaN6IKtN99kfKtUswBlPbHdNjH
	sgWhQLVwCRqkfSI2rDKUWa7RpskyqooB6pXVqOcv8y86DeIpm9mV84mcgWdAB3jCye+3tNUvJkQ
	==
X-Received: by 2002:a05:6a00:4f89:b0:89e:3ccd:b3c7 with SMTP id d2e1a72fcca58-8c87c8657cfmr13816717b3a.33.1795577645234;
        Tue, 24 Nov 2026 19:34:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm7938071b3a.26.2026.11.24.19.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:34:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 45/47] bpf, sockmap: Hold the psock of the work in sk_psock_backlog()
Date: Wed, 25 Nov 2026 03:29:36 +0000
Message-ID: <20261125032938.670542-46-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The socket can leave its map and come back after the test of
SK_PSOCK_TX_ENABLED. sk_psock_get() takes a reference to the new psock
then, and the work puts the old one that has none left. The new one and
its socket are never freed.

Take the reference that is put.

Fixes: 8259eb0e06d8 ("bpf, sockmap: Avoid using sk_socket after free when sending")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 1a0029f276e2..005e09121f00 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -694,7 +694,7 @@ static void sk_psock_backlog(struct work_struct *work)
 	 * before sk_socket freed. If refcnt increment fails, it indicates
 	 * sock_map_close() completed with sk_socket potentially already freed.
 	 */
-	if (!sk_psock_get(psock->sk))
+	if (!refcount_inc_not_zero(&psock->refcnt))
 		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
-- 
2.55.0

