Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604143;
	b=XjBhTYZNHDTEq2HZNxKpoGsLBNASf1tnAiENW0rRCI/a0hWCQ2dt9037UfyJch8AMHoi
	 oIJPM/Uq/xeVKvJCL1YZisq70HQt2iUaOTNUVXQuFnBrqblRth0SBE2KnRk9M5sp9KuCz
	 kXdQp/eMeUhQq12oGITaFGCc1+xtgZXANlhEvFuUkuxGqkWnTEillsRfYxqz42fEeWS//
	 mRy9yIu9sSZJjjv/Qy/SkzENq2K6/yk9kTsZqj2FyBs3AGFWROwdc1R0yaNNwuKRKgHEG
	 6NaH6rUA+ZPlhwV0PIVd5wCt808RWuG0AsL4IM/rtUj4Q/l4zZ76YeCknDbT+OHLwEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
	b=hEmlcRBDBPX9Qk1naf+U6yTptEN3k2x6+xT7yIaGRTuelsyln0A6W04FXlbt7c+CK1M/
	 f+7a9yOz0w5X32VeRMRrvIKrNAc9KGZREujNpmIVNlnR4hFvFh4mYX5JnoJxKLDZyiQJw
	 zA9ZVOOnSeAsEjubk8gYG1KOpAbUpufSNtjfiQJ7H/f/PApXeCRzGIEHaAJ5t2gUduVJJ
	 aiWiuaD98oBbr+6aWJ539+qo5m3OIvxSMlh+06gXC68qToOg58TsbkQPgtnSryG1bO3Gd
	 Ao/zQUppaXBc0NJf0azjCcnADB/frSAfzkZV918ttQkibtyiyEsuUNUT/+CSvFVmbzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEa2+q7B;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6A606A32F
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D6A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEa2+q7B
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1064485a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604142; x=1794208942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=cEa2+q7BHmYZLs9Dym7mrKX74T/THo0PnIG9tTN+NwJ53QgDy6Jd9kRHf2jzQeEqEJ
         vYizGvnaMj4AoUwTmCuZh+1TaMDXYS4Czrdl5Yz5pkLhYZoW0v/sDftaOaEEPGdzfUrT
         y2BSaFao+6BPo8oTHBRkzWmzXiHQ+7aFncAxZB5R6/r0P4KuD+WEj7NkvbRJmcd2XKxh
         BRtIXcccnz/sEzolmXLGHskKp0Twbaq9NsbxumWXxlq9iLbJw8ktBT7tvgZOJFLA2Gea
         R+X1qPxuXPOUW7FPxnlE1uhrr4lUEwNwrJ6yJ4vsqvBZ91eFTW6LfxNme2Mj7JvimIbH
         RZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604142; x=1794208942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=m8lF/0yoiPamnEedyZ5Wae6TEHWWx2ZLHYmyvCE4lcDN2UtVXmhncBfx92YOuR5d3m
         QqYFYiBMrEiWRauCHXPgtXibWRdae38EF0TOheLArY2y74gqGA7UdvKLHu9zN16V8sG6
         ornz4TIIuNM1POVjUJiOBfBkjMbgznfkRyvRvaA15umGetfCn+kOvnBqMagF6Ql5qAB7
         lNjxv5eLu8ZfaAlP/C4cKpWdE6IZX9YlF3Ak94BcUyBIh6OECY7uL1jznzZ1xigKJ8zl
         87mR0EY4hM2nZt07R/zbPh+4LztgU/eJovI3BO7alvPYTeNL5nKuJLrn7henBC+df7g4
         iKMQ==
X-Gm-Message-State: AFq9FYJhp1P3JxBnomeo4JE8wNvpHN2mh4k0uLXZcE0VASZUnuYXjvBn
	iZf6y6lwBF65hcJixeEy/b7wxKerCoRq0xQ9DZ5qUHRtcPvjv2TyxFLZTESQbg==
X-Gm-Gg: AYBFou10Ef+21USiJQ5kggcfMTtPAH6vGbA4pmLyD4D4f2bDpI0pgtcJOoHTfOSa5Qs
	c6qdMXY33Yb08/2xXC3z3/lkkXKxgc46uLkKjpeHQEdsfvGnAtmaCdSQzUV1jnYKdyj4+ayVvpk
	xpa65hJAAOL3Q5gXptpQ7IAwdYgFXUFrZhM9Lc45vRUjsidfU6rmcAVraIQ1YJ18gZwcahSLPwY
	HmMdm0M69Z9vqwOjReSlepGXvBxXtRV4Tqh4+vc3dkIwT6EISYALEBlOkmr5Pue2fZpdFzexSoW
	rzxVUU5f0hmWSloFGX1Fu33IFtpR5NU/2YdNFr/P/FaLChzulDaXW0KIUUzxQgrov3ZUZQ3wG/w
	/Tgi35vfwfcZQkC9B9NhTRQH3ZjGqZnkemjXXDyEhI+pEvJODNeZUbiyQlc17G58i2vlmmLEnWe
	qwrJkFGOe1d4M+anIEDblIzMBJ/0PeP/GXY2LeHIjGreevZ4me7ruktGO7WXF522QZ/nW9S/bJY
	TIykWV82+/LSXEVvLY2opdQmxBbyhdq9LvKDCdrKKy9XSjely0/gM+9sjk4xQRd6x0bVghRZBW8
	jM5bGejqoGI1l7nvtO9lTTbwtMmZsxvPBL1itcl7utfYTm4/lU7xasE8xNjP+cdc/VXLLK+vFRv
	5McG9ElWbdq484unStOxAFmBuqj4vd11NymXjdpWtapVvM18bY1hlke6W7Eu4N7C9lnn7fuoPvA
	==
X-Received: by 2002:a05:6a21:1644:b0:3e2:4350:152c with SMTP id adf61e73a8af0-3e928b8ad69mr8141975637.4.1793604142251;
        Sun, 01 Nov 2026 23:22:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b4bcdsm2756194a12.5.2026.11.01.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:21 -0800 (PST)
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
Subject: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when corking
Date: Mon,  2 Nov 2026 07:21:07 +0000
Message-ID: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
remove bytes from the front of an element. They increase its offset, but
they do not change sg.copybreak when the element is sg.curr.

tcp_bpf_send_verdict() can send a part of a message and keep the rest as
the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
extends element sg.curr, the peer can get memory that nobody wrote:

  old offset    offset    end of data     offset + sg.copybreak
  | removed     | rest    | not written   | new data

Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
becomes the cork, as the helpers that change a message do. It sets the copy
position to the end of the data. Without removed bytes it changes nothing.

Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/skmsg.h | 19 +++++++++++++++++++
 net/core/filter.c     | 14 --------------
 net/ipv4/tcp_bpf.c    |  5 +++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d5e35f24738d..f0e27b4b929f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -196,6 +196,25 @@ static inline void sk_msg_init(struct sk_msg *msg)
 	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
 }
 
+/*
+ * sk_msg_memcopy_from_iter() writes to byte sg.copybreak of element sg.curr,
+ * counted from the offset of that element. Point both past the last byte of
+ * the message, after something other than a copy has changed its elements.
+ */
+static inline void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	if (!msg->sg.size) {
+		msg->sg.curr = msg->sg.start;
+		msg->sg.copybreak = 0;
+	} else {
+		u32 i = msg->sg.end;
+
+		sk_msg_iter_var_prev(i);
+		msg->sg.curr = i;
+		msg->sg.copybreak = msg->sg.data[i].length;
+	}
+}
+
 static inline void sk_msg_xfer(struct sk_msg *dst, struct sk_msg *src,
 			       int which, u32 size)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..50c0cda778db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2677,20 +2677,6 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
-static void sk_msg_reset_curr(struct sk_msg *msg)
-{
-	if (!msg->sg.size) {
-		msg->sg.curr = msg->sg.start;
-		msg->sg.copybreak = 0;
-	} else {
-		u32 i = msg->sg.end;
-
-		sk_msg_iter_var_prev(i);
-		msg->sg.curr = i;
-		msg->sg.copybreak = msg->sg.data[i].length;
-	}
-}
-
 static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
 {
 	return test_bit(i, msg->sg.copy);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 3d703f1517d8..d534974c33f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -469,6 +469,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				return -ENOMEM;
 			}
 		}
+		/*
+		 * A push or a redirect may have taken bytes off the front of
+		 * element sg.curr. The next sendmsg() appends to the cork.
+		 */
+		sk_msg_reset_curr(msg);
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
 	}
-- 
2.55.0

