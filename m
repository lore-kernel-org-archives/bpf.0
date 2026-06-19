Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7827874F
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850657; cv=none; b=k1CW9vdyevSXVD1r8P0yxvWe4viVKHlnmFk+CZxe6CgpEYGqhJUj2im8PEW/zibaeQtPLb8gEufkk0UNwCw+eT30SGHLT3CSoLI33jup64ewf3JGiUyTBDVVcflNOTbmUSp4i+5v0s0pSMQf1LPmZknEzlTRdjxFVWem2P2QfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850657; c=relaxed/simple;
	bh=7jNRGL9wLLf/n8BacQ6MdJ5odGHwhYnnHCg2eGttY8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDvGPVDbXcqiSRjp9UHAEnZQ8iq/l32YedS2BqZgySw0af/9lRUXK7H4wGZdlC2jlCpUq2d6XXjq+F+RP0uLgPbGLkrvPa2BDvfzIQACs33XcEFhatcdxAth9LVT7NdcE1vchz/OckO75MNi6ai8m69WroCqgbY32kPjCbF0V6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv1uLapq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv1uLapq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8453f568e84so1628212b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850656; x=1782455456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a9K7WnQpx0xR5fjHURf+lcE2o2CPd+Qu05sU/3h0S4=;
        b=Zv1uLapqcQMNvR0x2XJdA90YNABwafKQHsMje5QJdxcuiQYbtK+GIRe8e1kpR9fq9c
         kco7AsncrfR1T8sdCUHmHnO2FzVQEL9LKAjlR5N1W3o9S0aYT6RhN0EOwE9BVoeI2ia3
         mR91EBxNu664M6HTRMIpDLk20/eAKFhQ0GraG9XsCETztwf0ylKWpbec5+fBwI3Dc0X+
         sST6fDpFuWMmaisHIzTqEzlR06e/40ZtVjE1SVZMsEiXQYyeBlxg1RHbT2ZoYjsaGYqM
         zUCAcO/HDVRhy+tkQ+kttJQCDrkA6zFi6UdMdi9aZ2w+Wt+0A7B9fJ/+EcIC8fCdpg5h
         Z5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850656; x=1782455456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/a9K7WnQpx0xR5fjHURf+lcE2o2CPd+Qu05sU/3h0S4=;
        b=XnWwLFo9ECXRs4vqkXuHnq6yQhEKWSxSX5voeJr/ruOv1mm5ztb3hQ2E6TC7A3dS65
         rNPORQn2Oi3IPihAMJLdyYXv0p6R/PmEYa28/+yEXSHv7Sdy7ml29us0sM6JtxrhavQh
         E/L8pNx310HKfjB32exCMHqLfIxHoI/jcm1v9PmyFh+BmJ8aCjocCH0CiP+i/0de+/wy
         G0EE1OMEAWVPMuyLlyp/CtH5TLCl7Gc1uSnBa+Ryf4E9IqMKub0OI+DHs6PWR5v9T8dl
         44kckOUeSa9n8j0VYY89qxdt7dtR+05qWW6yYSiQMK7gLakzqdMvhSbYnk4qja4/gNsV
         pieQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ywkjhvj8NAhFDd6dE0PiuecvGzDn8OakRmomOIaCkg44olFLSYT4LSuu/ZyrKTuNDwUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXsOWe56k4mvtYofnhAHu+yvziOv8MPXExTJAN6orSB9CIQ9M
	C4X7hpQUKTw0zYMoLmIC3rhF+k2/qyefkLPrhIrhVbfnn4cZLAjF9RJQ
X-Gm-Gg: AfdE7cl30KKxZ0eaVjHABAPS35OGRVUubQ55Wc4DRSmtnXyZy/QZ2ETGTyEe8hpkWrr
	2Nb+UGierDwjl+vpr61TEcZchZB1nyUUWAHPlHtDjqelSgHRJORPVRhHj+PZAwHRdL99PL9hvoc
	L3uxO/2D1RQW/GQY3TsFnzqP/MinbkgiuWwk0/6xVjzviSGwaW4zdNhrDtSKc2ogbAQAsx7UTIQ
	9VrvSsk7WYKd4X06f5/sE2oOk2HB2GyUjXo0+Wi/xr5jwY7Tc222fo8Eao8hV5vqGkx58yRAap0
	pBSNKt0CyB6CmUeO0QITUHAlLX4rzV1YK3bdFTweeXPUyeiqHf44QDGXWFlTaT/mgsTq3HSvLCM
	ZcyfD3CosKQUC1dd3mTnuuGaJ0x++AZ5P9a0AqMnJJpAGXQ8Ut0v3A28TOOawWt5CpgUA9AMe7o
	GhfShu9ZZIEyxSCAN7GTrk0hMKhT8sFlr24s+ZoEndEInhumCzXxQ=
X-Received: by 2002:aa7:9062:0:b0:842:4982:81c with SMTP id d2e1a72fcca58-845560b04d0mr1600983b3a.20.1781850655672;
        Thu, 18 Jun 2026 23:30:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:30:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 2/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Fri, 19 Jun 2026 06:29:51 +0000
Message-ID: <20260619062959.3277612-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
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

