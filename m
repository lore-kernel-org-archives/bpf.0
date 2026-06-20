Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417E1A9FAB
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923491; cv=none; b=SDZnhdRG4tWcU5lKsWfizpfrUaWiqKDtNbBJTSoAvNkPeXiQdO7+anDQzbQNXrE/CDqBJn4sEskfRUqfOT6kuPyaOgK7YaLEeEBR2FVgyB/djUgUWM6qdLmDPGafHWnPpIdtav5ESU9cxQ5DVtqKxsiBjO1WqpFXZH+R4FJI9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923491; c=relaxed/simple;
	bh=ICe0YCbrGI7sBHtFtcCp34hkMsz3q51a3eQfk8LvR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=org+q85MqmALKc3FQ13PZO9gGSlK7cIotvWjbugVHutQKeE2xb6xwQArCSV8rMzAISJ9Btr8p6i5+ke6lnlpk6LTOJ37bdqv8H3SKC62wJhaNqajmWfzgYxt2Dt8lqeVGQxLS1CvsUZ5rIkHQTajxiZ2J16HSJsEMnFxaU21WNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smtYZSy8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smtYZSy8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37d4ab2e7c5so392134a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923489; x=1782528289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVKLDOFeXyaay66vBGJwQRzoXktAX8oCClhBBafjj4U=;
        b=smtYZSy8B6A+UYgyHNHhKK1EJoH4ncCC3svmMDL52YUZtyYU4fWKN2AOwP34C6Mw6f
         9coFClJm8BHXRG5ABuKPUBHH4xG9vnhY9dOQlf1qy9Lktqvoldt85mfhmLPcWA+3MKaq
         /GeJvVL5yts+c5gveXosxDwu4zr/aK9sJzypbfOMACNEPhAZbMA5fNbxMCAw3F0jdNzh
         ZShnL0TI543DWVDVUotT9IvNhxe5bdsdzGsc8cN/p2ipz1iRnLnDWJAuNruZsuNjfqGE
         L/WoxTe9tjwSJEHftDnXQNosEXcKeBaTe4gtw46dzMGb3h65edb+rxvDDK6hXVqF8tSB
         l1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923489; x=1782528289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVKLDOFeXyaay66vBGJwQRzoXktAX8oCClhBBafjj4U=;
        b=rsfsm9Ekw+7kOhPF6uMIEh0qBTCKbXCm8NYf2L3+OoWvssZixzE2D8YjoJp24Z0hns
         oM3NOoCkKYjei1cLmj64pJrqOcT0aOuela3A6VgBZgmEA9PiDendZva3xe5qaAUzE3Lv
         iIogLhVYafoaqwIdRp47W8yOmHU3eGsrh789NXgktRBEDQoIC9/GrdxuDj+iJZPzEH81
         NI+vf8a+Z+o26UFCepfCbHCQ+uhYh4EZz5FXhQzvaZiU3jtPYIVJ6j6WgG/+Mag2JbWa
         ycoz5N48dc3vL+qwg9A0Pr9G3xFC3ui9DDnEjCE70AeQz/nTY6q3VDIWg1/l6OphwXxD
         e9Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+rIzIiSeUTjIL0WuF/u+74O7fs9mXhhaRuyjRH+GxsqrnWr/P/IIKBEG6h+asOKLIQUmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZzM74rAqWvzU88VSvj1E2yigQduqs12hZWQOBw0M3NlAuaDK
	KMDmNan4BnNhaNqt+XEqJnHkVIoQXtqVRf+21il7nEa0hG11CQtQJX+l
X-Gm-Gg: AfdE7ckK/QpZfb14c/neye+j6fbw3JdCylj7Z8qCpUkv7HvYyDn1CSegPISpxYnIVNZ
	8gQUrAhsGlorLAthMaXbsxE6uvcskU5LULT3FzdDzmmDtt5GWRspccHDYExzk/BnZ3IJ8Jixwyj
	Th8TT0YNqhHc86MauxjM6iHFRNG4sAzKWgdo5DPWjSBYyd4ZrPznO4vLduD3NMpGAcpsXCuPvKl
	oXR3tFCEQCOTWW8OpUH4oP2GJZE38lLJJN/nSCPnWevVdtGvU85BcFaorm5wCJTTHxXE1wY/n2E
	97pXHtsjpGK6cJK8jfz1giBKBCYP+xQIp3OjYaNsVTgv102I9lX7J5jcqIq0EGsZaJ9R3kSKmm6
	Go1J7dvXE/sCE8bc79U8XFuLrqUniGOk+oTPAsT2tl7a/ygKDI1nDHgbjmQSNOURuvqsl1KFpoL
	D04eopm/BLvQMukMsraOd1+53X/lW0VcLllXvKp1OsgUhDLKU8ZRY=
X-Received: by 2002:a17:90a:d644:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-37d15dc1067mr6028692a91.1.1781923489162;
        Fri, 19 Jun 2026 19:44:49 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:48 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 2/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Sat, 20 Jun 2026 02:44:17 +0000
Message-ID: <20260620024423.4141004-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp:

	*strp->skb_nextp = skb;
	strp->skb_nextp = &skb->next;

and then calls the parser on the head:

	len = (*strp->cb.parse_msg)(strp, head);

The parser is only meant to inspect the skb, but the program may call
bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
Once the head carries a frag_list these go

	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail

and __pskb_pull_tail() frees the frag_list skbs that strparser still
tracks through skb_nextp:

	while ((list = skb_shinfo(skb)->frag_list) != insp) {
		skb_shinfo(skb)->frag_list = list->next;
		consume_skb(list);
	}

strp->skb_nextp now points into a freed sk_buff. The next segment of
the same message arrives in __strp_recv(), which links it with
*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
and the write happen in different __strp_recv() calls, so the message
has to span at least three segments before it triggers.

  BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
  Write of size 8 at addr ffff88810db86140 by task repro/349

  Call Trace:
   <IRQ>
   __strp_recv+0x447/0xda0
   __tcp_read_sock+0x13d/0x590
   tcp_bpf_strp_read_sock+0x195/0x320
   strp_data_ready+0x267/0x340
   sk_psock_strp_data_ready+0x1ce/0x350
   tcp_data_queue+0x1364/0x2fd0
   tcp_rcv_established+0xe07/0x1640
   [...]

  Allocated by task 349:
   skb_clone+0x17b/0x210
   __strp_recv+0x2c3/0xda0
   __tcp_read_sock+0x13d/0x590
   [...]

  Freed by task 349:
   kmem_cache_free+0x150/0x570
   __pskb_pull_tail+0x57b/0xc20
   skb_ensure_writable+0x236/0x260
   __bpf_skb_change_tail+0x1d4/0x590
   sk_skb_change_tail+0x2a/0x40
   bpf_prog_1b285dcd6c41373e+0x27/0x30
   bpf_prog_run_pin_on_cpu+0xf3/0x260
   sk_psock_strp_parse+0x118/0x1e0
   __strp_recv+0x4f6/0xda0
   [...]

The same resize also leaves the head's length inconsistent with its
frags, so a later __pskb_pull_tail() can instead hit the
BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.

A stream parser is only meant to measure the next message, not to modify
the packet. Reject a parser whose program can change packet data
(prog->aux->changes_pkt_data) at attach time. The check is shared by
sock_map_prog_update() and sock_map_link_update_prog(), which between them
cover prog attach, link create and link update. Verdict programs are
unaffected and may still modify the skb.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/sock_map.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99e3789492a0..c60ba6d292f9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***ppr
 	return 0;
 }
 
+static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
+				      struct bpf_prog *prog)
+{
+	/* A stream parser must not modify the skb, only measure it. */
+	if (prog && attach_type == BPF_SK_SKB_STREAM_PARSER &&
+	    prog->aux->changes_pkt_data)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* Handle the following four cases:
  * prog_attach: prog != NULL, old == NULL, link == NULL
  * prog_detach: prog == NULL, old != NULL, link == NULL
@@ -1533,6 +1544,10 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	if (ret)
 		return ret;
 
+	ret = sock_map_prog_attach_check(which, prog);
+	if (ret)
+		return ret;
+
 	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
 	 * exists for that prog.
 	 */
@@ -1776,6 +1791,11 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 		ret = -EINVAL;
 		goto out;
 	}
+
+	ret = sock_map_prog_attach_check(link->attach_type, prog);
+	if (ret)
+		goto out;
+
 	if (!sockmap_link->map) {
 		ret = -ENOLINK;
 		goto out;
-- 
2.43.0

