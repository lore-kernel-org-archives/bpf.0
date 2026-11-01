Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560922;
	b=C8WWdg+phJwC7fYz91w3h8BBEun6fd4kuetGPG9NViWopEQ65a7HtdejmpKKzivosH2w
	 F/j+qLMkovzHSm0O4SllkxZruC+dhDAi2cm0mbl71rXU+4rvenQEwdV5C/CiO3eVUXwfP
	 Ydc9UL0DOIhTRKSbtEj+XmA3f8B1K1JW/pX7EFycRfZ3LEF6o2R0L84N1hLIJpCPjl5vI
	 zGIFtaNr5nPuvGA/OTvJMfS2fcw5hVu9a29HoZiqQ4gRzlKhDQb9DHUVo86EmNtA3jT5u
	 hgdQg1FZmstH2Bszyyydf2ijngK4nTXdIJ/lfxzIi/pB9M+e1R4as17DAls/QobyC3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
	b=v93xKTDjWO5Haj2KM7ju8GLf+UYqWLg7vlEso5If6kAtFr6+HHsv62fUVm5h+XN62MSO
	 ajBlgq8773SNlF6LbHbvt8iRnZ4OFgo/mcxIkMVhHEDfWDOYVgzgUltBjrOH6LCp15q/1
	 S42+KdiEj7nArupi6qKh98E1tVJ5KECq0MoVnrA2MNFlnvZeblok0aAUHFP+tzB8OztsI
	 M3IiVYKahPYRXNNkNh7GwlUVh9bVsJVhxPOUqynVYfeXJoSABPumvAA//NZJMJWMcIhYC
	 MniHRBCWakl9ysUEVgMqHQPAPu7UxBmslpyi8AEjB4SZifm9nxlDB/kdgf30SXBejQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RniuFtKT;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2C606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F2C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RniuFtKT
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-886e61fa30fso765032b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560922; x=1794165722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
        b=RniuFtKT7ssagL3Jk341poHqV5zD81WJa/Y+uWZg2wzqG8Wgm4lXIip6mhB6uPk7Te
         FvARWpFp+GFqhltoQW7Tq9nZYmzT0T+/8uK0+9wjz762djOtMMT2f0OLNxdn5DRw/Lvr
         1KU/H0RUdsuFvchBXKfGh9Z4RPZr3naBVw4mJ/dVtkStpccwAg2IazdVuNuNS0e0jakN
         vO72D8Gl5+l89ONUqYMk+EslGorGH3MO+9syQdKBp2uusvY2ZN5tvbdZ7jcH+Hy4QfxF
         RKu0/sPsXbwc1L7BvTz1oCUmD3MMypB1PpkxfAd5Me50gcXjeW/mCyKQj+YW51nGYTVC
         5gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560922; x=1794165722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsgHBoShd1l16ZkCMwetUuA2WCLMhgmDmGz78nTCX+Q=;
        b=KwXjhteGGLpa2CAUSaNG0fyBscCj5xuwhGFBZ4FQhipmgaCh0LkxLgahzgdZ1bJlNe
         UvB2okSgnJ1a7FOmBoDX4QFmrT4lkVnyN3NrKX3uxFdObfE7yrpe0N8ZfY38tmrtWyC4
         TpUPgRa5sxECDKcCrP4JioiHD0tsHiuxLA9rAUJp2L/HatjGc2kH5VJdfPAvcU2dBBD8
         9zem18VUqI44X3yhSDSFdAPF8ROMWqaimVQ1l/2581GhCu9alhCYOaHlyFqWdfR1rDLA
         lnlAZH/EPjIbttQgfGsLM6VpozRMh0OuKdt9ioJQHEAD8mEElfsVLflYwGfHnhqvj7Qy
         JSAw==
X-Gm-Message-State: AFq9FYKPX/nxbwoai2QJKwlEuhtYecxMTA54jclX9v4V3nAIi6Pkp7+y
	Kov3D/dsUZQ640dcvrv2n7Zo14NqKp5h4f3EKzSgbObNrjfVSwGkL60IMWbA8g==
X-Gm-Gg: AYBFou1E0NG0z9pmTF1rsQdhXU3rQZ3JTyB5vi8WFn9Tp72in+7jpoYjzDjF4k2qxMY
	QFClGdF3U/36dsZ2yeEWzGD7uQ9JBfm3XRvLvV+B0thcEW7LJpghiQ37NE9wEjh5KpFmZ+mnxt+
	20DpTI00ld7VOWPHAtEHBwRu9EsqZzxbkTBU424hz0TVBrOoTgNK2Ohbo95+VNM080OSGWU7STB
	ZTHSDYVNGuEijMsD0Q60kMB/6Q+5UIcY5dreBNG0Jy3vSzWGSI2VDyCz/WtMikFrogyebhX66tp
	iD+Zs7LG6/UGeWKZdXbfICvWLx106EPi4cBRwgvd/3hcgiYrDQYm6oV1ebTVrAz9GSbEwhCPq8X
	xRVArTC85Wi6HjlODrSbqiWjhChYwUnHNfOS+GdvpCLrloVA6lkidmHKH9cbl7G339rV8tvPQ8o
	4Ks64CcWR1r2ytyEy7/ZqusoJqRVE95iZb+Pj/NHfy7G50nTZtTjEMhNrEbLi+C56QKggFEYQ+X
	9RIjjhiWO2JvH0IQHozWAmLRXbbFX9ySoieWHIjk6QU8ywiD8sBbBf2hqMN1VSaLmcdO0laLuU7
	X72KYWCaPovmoCnpDyrP/QajtfS5ZmSulTeUcyWGATMCAgw3h7CUYrQmBN1uhDXQjdU3Epui/in
	7l1guHOFJbm8ots9pzEUjt0FV4/pknzfyZgT44PJHWvKsT3ABvKKRZj2GeEf6qjeIyeo/PS8Cj7
	YOnK07iLIGFyAuz9OzG30=
X-Received: by 2002:a05:6a21:487:b0:3dd:a196:30a1 with SMTP id adf61e73a8af0-3e928ad8fd0mr5379597637.81.1793560921776;
        Sun, 01 Nov 2026 11:22:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b8323sm2347314a12.6.2026.11.01.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:01 -0800 (PST)
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
Subject: [PATCH bpf 10/15] bpf, sockmap: Reset the copy position when corking
Date: Sun,  1 Nov 2026 19:20:52 +0000
Message-ID: <20261101192057.2296489-11-alexei.starovoitov@gmail.com>
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
index 303c0c44dc2c..e187e3c27999 100644
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
index 9848c8e5a2cd..d24ebcd7633b 100644
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

