Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098505;
	b=Bt8+fKlRoB78/a4ZMdLYZ43rzJV+yq0nQIS7SfmGn5alCnJl+C05c/Fk6mF/7AUPhCtp
	 1X5QqbY+9ptdhExgftfwvfo06IpbZdcT9yXbCJbbtYtRWuYzBJ7mnkjjZqILwP3hWdhRQ
	 Yc0h/6O4X9z6TK8jwGpaI423UyNUTNK031kQxZvnx1NrzDWio4jIIPRlLSjQZtP+JGLN3
	 +NacR5Kg/ziCOy1pBTyG+w0M+akHnP28VLxe3aHKLbvGCsOAjjzo2rVqqmmPZi+sKOpNC
	 aM6LNmDfbW/MGo7mPUu6DylYgJP6pfMMz6uUXhXAMMsiq4I4YAGPHgMGoeCAXAediDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MN15rtynJucizsmELauHmdt1P7lrQUtZFL6V1R2zVCE=;
	b=wYeO4pf3xA5HGKNqzA3PIVk62W8KxRwgkW9BQ+IEbLuDmwvE8m+2KMKrDe4Rh9JaphFZ
	 iGOFCvm3ld+3z1qJDj9m3Bw6AURUPPjGH2yRGjV+h5+AmxRnBFtsCeoeMWzpw5WUHxwtD
	 DadUnnJpr3aJICpN0rs5ODWmR/kNe+bEys+4q0BdxmyZxOj8Aue3GmIkDXLqKSP+r7iHq
	 nB/8Iln/E8KXZHsW5e3DVin4rPdEVBIUkMfc1XMnqL29PD6iZwRQkAQVsn9JKl2hKfvmr
	 KTJ23XmZL1XBdvGrQJ+7YdiqS+t+UioMRh1MFcbWV29Rw+8Bura5omTyHJWyLka4FaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b="HaTu+e//";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9708606A336
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9708606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=HaTu+e//
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so21345985e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098503; x=1795703303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MN15rtynJucizsmELauHmdt1P7lrQUtZFL6V1R2zVCE=;
        b=HaTu+e//x8trcNFE+8n3X+Rj5wqLN+MlpnqqCfC6tfIs4fL+CSzuvcvGAAH6MaFGxU
         7NF0RaBZGSklI4k9eQJHpB8j1rErNuqOft5KQoVAkg7+0M00LiLbboR+d00sCSaS2Py3
         34d1bzrYRDa5icaRMgZvD0mo28x2nsWvf0z8PFEq+LZsYdPI9d15cPt40uR/AkVpKvJ2
         FeCV7qy1r9l4WTcukQsacvJCs02UM+G5b6lWXX+9gvFfKC0PB8yVglqr47hYV1oEaiJ7
         9VU002/Df5fs9IrR3FmkLKDThgg8I2nkl6OZ2xZVHK1SjEpRkWmRe7bQEdsTQXlYVBdM
         1zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098503; x=1795703303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MN15rtynJucizsmELauHmdt1P7lrQUtZFL6V1R2zVCE=;
        b=Td9ToMEJjtdCSJJQ5V4aznvWnPOSlr+6E8AVXRAYMyb4k9pJUNsSMtFoETRYhRYqLP
         /7oUZ5V8sKZMAkINr8E9udmtIS0LPlwjH01BEVjNpWIzHZPOvZcTwbp1qG7OFfr4orY7
         BoaIJIWNJAMWK86DVTtw7syKF3ZNg5DsKjap3yw+Uj7+xX03c/Sw43pvFKM+wHYOpHNg
         ejzmmiwkzD7z1ic/hwna4Nz7NHKfHSF70rB2rBJZ/jXXCTzwXX+GkyzzhXkefhnjscvf
         VG3H19jIOUy5za3DvT5+jDgNFhNXy7QNckKd08EyebxQt7hmE+G/74Lw0BEk+FEOhXLt
         IBAQ==
X-Gm-Message-State: APuU4Z9wzqaeCYUyqy08+nt6C8vqVxoV6ATGACAN7PyalMvOxB9trQJe
	+OI+6VaQ+jdxR+bKoV30DqqcE7tX1sgMQcaGOSHLZTAWSqmkBeVb2w+L6ee9HoSk1bLenTlOd70
	y9TsAGYrdRjKt
X-Gm-Gg: AYBFou33fgrBseINK7cyJXPRjLgb90nu1PAu6W1AUr0XO1JHZ4bWR+LmmaPwVFXrs4Y
	Pvla+SYgEhfrQbxrTpduQea7j0e7SakIvtg4vHX5fU1ZTCNWFne/lnC6I4XYHPdy53ztqPUS3f1
	XiKTcl+SVnV70akEgbP8r7T0ZclHMfv3hXvZcKsmrkXBItd6vHVMhAsHeHUIyIrJGunFNWfyk+L
	C4e5Vug0zPb4I9Mcwd2UE9PadCfDvgq29OzqywQpAcFuZqBFr1gJ3Vrfy4ysKK1t3Yq9IZ7Vono
	D0juL+MGiqE8VdxZnPZ2v3BADCfmevA8f3/CrAC4/ocIS5IxRES2rjusnZ0jIxwFuSN/il99jfv
	HWAFVKDbDMrpQLGw+7V3vazo7BQ21Kf6uTjEg29BDxl/BsPoGYJlOdFsec+bwXB67B05UF/PPpZ
	GnYupVZi03zn3fUrOuSAeZGUnIj8jlPG2dCqn2vSOHnW529xqX/VSv15fyBfar48pKQ1QrvMLnb
	Gm8PQkad6jFKiOK+59A/J+5yRB0fMB8+Ft+8MBgWaqY+IDLmX5Z8U8lWkRtXUfOvjMSbjwCOwrD
	NbVIfkkyamGrgIUnu8BGzWvTxJGRgH+CLE0TWJGuYIYwZ/YV30k=
X-Received: by 2002:a05:600c:3ac5:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb7da0f906mr124307595e9.9.1795098503293;
        Thu, 19 Nov 2026 06:28:23 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab4ff7073asm176516f8f.8.2026.11.19.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:22 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 4/8] bpf: support SOCK_RCU_FREE sockets in bpf_sk_assign on egress
Date: Thu, 19 Nov 2026 16:22:26 +0200
Message-ID: <20261119142231.2612515-5-razor@blackwall.org>
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

Accept full SOCK_RCU_FREE sockets, including listeners, on TC egress,
taking an skb-owned reference. Request and time-wait sockets remain
unsupported. The BPF TPROXY use case needs to assign a listening socket
(e.g. Envoy proxy) to an skb from tc egress. With netkit, the BPF program
runs on the container's egress side and returns NETKIT_PASS, which delivers
the skb to the host via __netif_rx -> backlog.

The fq qdisc discards listener assignments; ordinary loopback also drops
egress assignments. Both can miss the selected proxy even without GSO.

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
CC: Kuniyuki Iwashima <kuniyu@google.com>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
CC: netdev@vger.kernel.org

 include/uapi/linux/bpf.h       | 5 +++--
 net/core/filter.c              | 3 +--
 tools/include/uapi/linux/bpf.h | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 45e3018fb2ae..e8a7ebee305c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4612,7 +4612,8 @@ union bpf_attr {
  *		interfere with successful delivery to the socket.
  *
  *		This operation is valid from TC ingress and egress paths.
- *		On egress, only full refcounted sockets are accepted.
+ *		On egress, only full sockets are accepted. Assignment takes an
+ *		skb-owned reference and releases any previous send-side owner.
  *		Software GSO segmentation after assignment is unsupported.
  *
  *		The *flags* argument must be zero.
@@ -4626,7 +4627,7 @@ union bpf_attr {
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
  *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
- *		a non-full or non-refcounted socket or a decrypted packet.
+ *		a non-full socket or a decrypted packet.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
diff --git a/net/core/filter.c b/net/core/filter.c
index feeb752f7a00..4dea2cc84712 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8123,8 +8123,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 
 	if (!sk || flags != 0)
 		return -EINVAL;
-	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
-		       skb_is_decrypted(skb)))
+	if (egress && (!sk_fullsock(sk) || skb_is_decrypted(skb)))
 		return -EOPNOTSUPP;
 	refcounted = egress || sk_is_refcounted(sk);
 	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 45e3018fb2ae..e8a7ebee305c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4612,7 +4612,8 @@ union bpf_attr {
  *		interfere with successful delivery to the socket.
  *
  *		This operation is valid from TC ingress and egress paths.
- *		On egress, only full refcounted sockets are accepted.
+ *		On egress, only full sockets are accepted. Assignment takes an
+ *		skb-owned reference and releases any previous send-side owner.
  *		Software GSO segmentation after assignment is unsupported.
  *
  *		The *flags* argument must be zero.
@@ -4626,7 +4627,7 @@ union bpf_attr {
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
  *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
- *		a non-full or non-refcounted socket or a decrypted packet.
+ *		a non-full socket or a decrypted packet.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
-- 
2.47.3

