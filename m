Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E44964F
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923484; cv=none; b=rNpL51aTIVksDAA2To48DVwfQffsJMKmjdpEZu5SoUKBdNoovgkFLKY4E4tCAtOZky0eb2M4JnTqmR5K3M5K8e+Jl8TGx01bstocJQFO6HTXxPZj62ZrniiDshY7h7Md6LVnHUkvNtVeCRvLU1ylCHi1m3D/+JwQmi6oghyj8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923484; c=relaxed/simple;
	bh=m/iiaSixnfb83KYCCVPaoDdsHHEYkoZLQwm1uMN5ZmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghOiInyZBfavzykrkATO32WzZjFiDbmFotbnn1yycyUiZQwC139yRimVJcC7I+uIAa1b9uzcZ3ALIAMuRO4j5wbooFBrOS1tC4b6gIUZtT2LasPwAleqWVJy+ihsOce5Km6pSdlZ4va4MLUsnCpLZuDg0gPbwWsjsfD0lSL2HjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXr0xoqZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXr0xoqZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1047757a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923482; x=1782528282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5XmdnIL5m1N2UxN+NzNP0kc0ABgydLtyGivJ9LKVXo=;
        b=dXr0xoqZG4ZQRF/uDv70mNaSstEMhgyY8UeArvahH5mEp2bXQOKIl3atUrbj0ryY9s
         pnF4R1ZTOmde8mgHe4hwiisOFWcgRYsLXU2XDXW1kbXLvy55PVK6oYhSFpufbWQ3usLN
         qLG/Zd0/ZWOw0QPDZVEZ3GMCJIwbjcC42LIsfvan2IOrDUCXy4QbG9pdeEdu7OMns1L2
         RWXoMDaz87o1wwEu87WWjGcOwZ+X9a0DT4PSmKMf/5pEyzvlblyVJtCpcbB828oN2Sty
         WfP19HxQtC7/6AmJquzuNAvwMprt1p8VBWDe9uWxH54HWLO/euQN3b48azYwUWbZxZZf
         MEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923482; x=1782528282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5XmdnIL5m1N2UxN+NzNP0kc0ABgydLtyGivJ9LKVXo=;
        b=SUHOJFM/f35NchYx0i3vJmZ6q7v/z3fg9AjqjEHg1LRiQF6Wv+rYVmqX1Sp6BybMGk
         OJhVBJHB9RapDZS1/Cc1UOoC/fZeJoH7UbuQiIDyFCRCN3g39+KAo4Hi2UVLH0DvNoU3
         QqC/y8Puged1EQvDcY1pwMruhtelzZj+4epQFZVurwcU0UNr7AfmNl4lREYQc+knMstx
         7X4oLG6iE1GbEwlFn3ROrbR1hys56wQpgEWok1VXBDfgol5OdRzO0+02M0bz2ZcnXImE
         J8+3n93vjyJg5G20/S9LZC4rYz6DcKRaUmdht06qQTzlh+G9LQXCmnyi4myvVBd56WXp
         ysQg==
X-Forwarded-Encrypted: i=1; AFNElJ8NYzsmlQn1HFGfT751+L14nN70fcsze8gxo2hYcrs4DTb9dN/8+MbckgeKbAtp6aSCo1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sTWVqAE5G5nRbkYwkEeHcvfnOAFaWCK+VdZazM0DIu+2rW8T
	T9HAafaZPZQ81Hgweqm60yrgUuf6QmLk9yABu9c+KOhTOwyvSh4TFvtq
X-Gm-Gg: AfdE7ckII4UC1nFf/F6w6Nb6zJPCJZ4B5kcxSdfm8E7Z4WE/MPlYKMzQCEN2b9M706o
	PRurTn9ucBd11+ELsy/tqc90izEzrIvjYbEJiRVUdbfeC7vwhsIGnbJOp1AmEKYTtI5TLs3xkWr
	G38Uceus9pcG8JIM2Jmrgov/CVGFe52M0CdYRB9ImlEPitkxG+kDx1ep/eBgxYvQAPaYeE8ZUYz
	0LGdCqi9UvUYC/tYtf99itzG3ULrhnVR4O31/jhsjCzeNL8knHhrq4qj9s29+5/dwh89RPGtbSR
	rO9VOUwe+Yb+IRWEEfFWvnNfHr9/zh7RAZingFUUJbpZCZkIKSZ2kZCVoaaByn8RtGmf2lD/8tg
	6XAfum1/jNMrGI1iPuEN9noJMx9Uc0bWsrkklUEs59/YX3A7OqpXy0KFGCU+hKZvRM27hJUnpZR
	zCsd41ETNB+S+1VaSBrorvtzNF92mfAay6bf6OW+GzDnvMlkWifrVZKP6tvr6uLw==
X-Received: by 2002:a17:90b:4ad2:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-37d4e8588e2mr1766868a91.22.1781923482074;
        Fri, 19 Jun 2026 19:44:42 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: don't modify the skb in the strparser parser prog
Date: Sat, 20 Jun 2026 02:44:16 +0000
Message-ID: <20260620024423.4141004-2-rhkrqnwk98@gmail.com>
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

sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
the skb: it calls bpf_skb_pull_data() and writes a byte into the packet.
A stream parser runs on strparser's message head and must not modify it.
A resize frees the frag_list segments strparser still tracks, leading to
a use-after-free.

Make the parser read-only. It only needs to return the message length,
which keeps it attaching once packet-modifying parsers are rejected.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c b/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
index c9abfe3a11af..56e9aebf05f2 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
@@ -5,28 +5,6 @@
 SEC("sk_skb1")
 int bpf_prog1(struct __sk_buff *skb)
 {
-	void *data_end = (void *)(long) skb->data_end;
-	void *data = (void *)(long) skb->data;
-	__u8 *d = data;
-	int err;
-
-	if (data + 10 > data_end) {
-		err = bpf_skb_pull_data(skb, 10);
-		if (err)
-			return SK_DROP;
-
-		data_end = (void *)(long)skb->data_end;
-		data = (void *)(long)skb->data;
-		if (data + 10 > data_end)
-			return SK_DROP;
-	}
-
-	/* This write/read is a bit pointless but tests the verifier and
-	 * strparser handler for read/write pkt data and access into sk
-	 * fields.
-	 */
-	d = data;
-	d[7] = 1;
 	return skb->len;
 }
 
-- 
2.43.0

