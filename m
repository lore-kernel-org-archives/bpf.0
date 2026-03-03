Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8E3803D6
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524143; cv=none; b=ACEzLbktnkHp4VpTFMgkLVydpypUaWfQ7QRfOzGo0BOluK5foKHTpe924DS/l+1E8GwuNL9DlAiP2iEdyud4B0mYWuhL0CuNj/+JmE53OYQjSuJp0L3YV35V4By0/Ji/4TXZLYYQAG+hy8sEA0jtEp6LjAQVrjIowZUwS7OYfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524143; c=relaxed/simple;
	bh=/EwBHS+MulbJHdk14Rvjdo5dRfJFU8A5WHKgAg3MG3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d2mfnf1Em9JaWDZ5J6cshfzhOwSIIZROgYxqktKvDYoyAvr32XwxLln5bXGVPA/OsGcPxRfSO83PMoFcIer2Pmx5UkitV2ud07tf+b+nY5AyNyaN8hNq3Feh3PIFVj/h2DFyeB3AHtOawSczJc5jsxUTr0IYUIy9KdDDKpqxW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV4mZsgC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV4mZsgC"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e3e4e7388so2121165a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772524140; x=1773128940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB1o9BGlkqLq/oNw4ApXQsql6klhqpWH7aXO0uKuMWk=;
        b=QV4mZsgCQdV46iKkv1BlcLaK/yjp4NrlUHot2tFGC6OorwWR9zecipTBUVSx/K3aut
         NpUo27OwOOgCsy+G/C8/Z9KzOe3bUAGPEQhVDY4epzN/ZGoOY70wdnFsQomDgmVW3ZjF
         BfP4mg9xloQ5lWEMJW0jnYNIntEs18GWyoZm79T6BdtWHfVnLnaS3K3JJ5XzpOIuhCT4
         FymccYK1GOpjbgHHa/iiP+T009Vp/lOjDEbpAkVibvoxbHzUfp1CH9csotTUL2tN48k8
         mJVskD2y6o6DcfyzjgT1lMX/oob2lyCgAvJUvOCThGffBSCyBeIAjzA1KaeCLYrdaGTT
         VIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524140; x=1773128940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB1o9BGlkqLq/oNw4ApXQsql6klhqpWH7aXO0uKuMWk=;
        b=YoaIqh1vZ/yJusHM20/pYWZdhKsdnk7j8zBFdQfk42DAtHAbt+WR7sL5QtITOouPFN
         OWsVvWHEPxxhlSqV+zkSl5jf2zlSnwJPTe0YPXBPIgCM6QAz8ZpHeC8rpLbreWF2orJ2
         k9n9/J/W9ITt0Qum0y6LRmGw/kTXEdNvainY/RYR7ZpvWyExF0cVyoeH/gfK/qyhqXko
         /psvUTob4S0G2KWqZjzwX3zU3bF3O/mJHcezUBsy7Sg8A/whyVIJROqaxQWMeY+QcPUW
         9AP4y7BTRcKPTBL5F3sad+a5dcNyJfZDIU4RsqkQ2j4qhGNtXtgIrSgas8nYwgtyjq2v
         Sy3g==
X-Forwarded-Encrypted: i=1; AJvYcCVE7Q6kg7LrVmbMG8JaonwRjyBNbIy4KHozEWXXeh39V0o+moXkM8qwd3EZ8zeOpdw3hd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5u13eW+0RKRA8dfcntwuaikukKMjKqORPgE1sk2eeVRUnT1E
	5MPkqbwgxYHd9KS80lwuYmEZqqWnv/euBYsnHtkE+WhY6Ivob+L6tgMH
X-Gm-Gg: ATEYQzwx2UMtUFzkF65YlZcMG5wEJt8G4oG6C1+rGxRuueT10ueMMkU8oB5TCTK3htJ
	INSRorWffVS0ZQ7EQgVbKjauEXHdp5wxbeHJiCAMN2NKhp1IR+3PO1eB6k1SyJZBrXPJFhSOZbq
	5iS+FDTm87v5aAU/pQbMnpSLIFZcnvjNrc7rMYLLgGkbS/VEOJFtD4jZyYItuc9fgP031xdx3k+
	as9uf+Odd6X/Aa6gwFV+X2eON3w4RHCGy//R98O10GmxMpTf4l3ydncBgGFaJuMEYFclsL0JyeR
	apGViDsVUli45COI7e0asPhV70HofUchtOOc0zQVTLacGwVV8sKkLiWWPgnnELHHPyfEPSQMo1f
	pRf42ovPMYg73DwCe9em+RBgRgyR0gY0DZ2Yedm7P4pnVmO6u42mtia51wXJ59szFJK2Yt0WkD3
	o9IpkrIN2gXLj1SYesAYwtmxYGAzX3V+5KvbaTVqaBgIxNHf9znk/Azw0/3PDdVTIqFvSGnRotE
	O8RH2hxZ7HO
X-Received: by 2002:a05:6a21:1bc3:b0:38d:efcb:2e99 with SMTP id adf61e73a8af0-395c3a4a2a8mr14271672637.22.1772524140121;
        Mon, 02 Mar 2026 23:49:00 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm13731037a12.16.2026.03.02.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:48:59 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next] tcp: replace per-packet memset in __tcp_transmit_skb()
Date: Tue,  3 Mar 2026 16:48:47 +0900
Message-Id: <20260303074847.2814835-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace memset(&opts, 0, sizeof(opts)) with targeted initialization of
only the three fields read unconditionally by tcp_options_write() and
bpf_skops_write_hdr_opt(): mss, num_sack_blocks, and bpf_opt_len.

struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
CONFIG_MPTCP=y (typical distro config). Every remaining field is either
assigned before first use by tcp_established_options()/tcp_syn_options(),
or gated behind its OPTION_* flag in tcp_options_write(). This memset
runs on every transmitted TCP packet, so removing it reduces per-packet
overhead on the hot path.

Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=n):

  Before: 5 store instructions zeroing 40 bytes
  After:  3 store instructions zeroing 4 bytes

With CONFIG_MPTCP=y the savings are larger: 12 stores (96 bytes) become
3 stores (4 bytes).

A BUILD_BUG_ON guards against future field additions: if the struct size
changes, the assertion fires and forces the developer to audit whether
the new field needs explicit zeroing.

Also add opts->options = 0 at the top of tcp_syn_options(), which
already used |= without a prior clear. tcp_established_options() already
clears opts->options at its top.

Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 16 ++++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d..ae04c697dbacc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -965,6 +965,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
 	bool timestamps;

+	opts->options = 0;
+
 	/* Better than switch (key.type) as it has static branches */
 	if (tcp_key_is_md5(key)) {
 		timestamps = false;
@@ -1549,7 +1551,20 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,

 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts, 0, sizeof(opts));
+	/* Only zero fields read unconditionally by tcp_options_write()
+	 * or bpf_skops_write_hdr_opt(). Other fields are set by
+	 * tcp_established_options()/tcp_syn_options() before use, or
+	 * gated behind their OPTION_* flag.
+	 *
+	 * If you add a field to tcp_out_options, this will fire —
+	 * audit whether the new field needs zeroing here.
+	 */
+	BUILD_BUG_ON(sizeof(opts) !=
+		     sizeof(struct mptcp_out_options) + 40);
+	opts.mss = 0;
+	opts.num_sack_blocks = 0;
+	opts.bpf_opt_len = 0;

 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {


base-commit: 7dff99b354601e04378b4490e1b1b5765a3c3a88
--
2.43.0
