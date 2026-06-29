Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97673D6CD4
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747686; cv=none; b=sOx/JjWt8uLtfA03mX/kkI66Zl3f1zxbePjCVbWwVRz9nKXVUsql29fz4KP7JM6rjLLyciCNIJhk7UYVDrIwgJzDwoXAwlIUW8NRZhwdVnvGDUHtK7BBm4mgiXOTRQijgzITJmA7oJvLj99d1sSukYN6T3TPrSTGF4yZWMCkuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747686; c=relaxed/simple;
	bh=Dkt4xyF9DYeMcPtu8Ou/ovRcY3msWhNc1z9UbNdyt48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABrtOlm3dG1R8qnjIG7/SQ7yJERY5i880RQmrAYR9MiHJ622kzybQa1xA492hWxrPP/JAYip7vKX6CQAEWkzJuOhC9n+QjOdDXeeqvkyQTdummOeFaO3DpOE6GKcpPE8vwAErWMPnREGRFAaq2mkznETIUI6uXDJAXjA5P4qi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Serf3lh9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Serf3lh9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c9e8a1d256so13698965ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747684; x=1783352484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YIeSNB3QalYM3yBkSuJQ+f9h4G1uu1ooOSnkLkitYM=;
        b=Serf3lh9RB79Iy7hxZmlXGxKsFKH0fnigf1JBqGEAWPfaK20UCoZP9mY5LuttX2bS4
         R+B50Au7V32dPlTdKs8uMBAWg0nC5De2Kt2+HIKPsdPTCGhwb8zr9p8do7xtmp+XzsJ8
         lZVu6qkEPRDpmZt+HgzP6QEbg4T4IxdyrVnGfvYcirAaU447HpC5amzqk9JvqAJ5TxlS
         aX7/bq9AR4KG9g3wKFwiJLzPpgKp1kqpEN2fPqMksZZU7Nf1qDDBekzs6DBykfjNrhIx
         HlpXYmiYbXx1Dv/HQnxHwSRfo8dHKmpT/8ijF+ZnDubwRY5AI5mLmYPpdnVFbqSiz5zD
         tCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747684; x=1783352484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YIeSNB3QalYM3yBkSuJQ+f9h4G1uu1ooOSnkLkitYM=;
        b=UIdK3lza2Gsjf/0hYowfNbKTAK2QxcDeW0JClT8zWZ90V2LgoKAhxDFvrPswctJCDX
         VvZKv+j4kw+UpKPZVFrpbr3Gychh3dzhdnq48bHSopO4s7zi+W4dqbtnLy1dkcg2DtAG
         bHbzQn1r+9lPHSbGXE8r1RCJ2RRVN2nx4BWaHtaERql/PKN05GeBcCivP0Qe5Qv4Apgm
         1q7VdGqUrZaP6H7nII9SiKVzJ8UhMHYieReBSJyxk4g1Z15Bvhy5F4ozKZrq9n4zjZz7
         DWOTY9YjYt4JHJbyWoG3vGhJImggndM/05oRiqlXKksFHBSz1RW1a4M2lkwxnq45v1d6
         eLeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxTDM1NkPhfKhyEoqE86r6kzyqXn718VLXvpd5pugdZ0IOSpBGqDYxm3fxTAFgpjTfcrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PX7srOpPb+KkcCrafzo1ukwKrWBBwvAgSESbOTOFTJAoh2C/
	uPBQhJv8DPcnNN23DpN8z1kpZ5pkhMDGRNN6b3QGfjcfZq9FV8viKAWA
X-Gm-Gg: AfdE7cnvTmPSXMRwcOV4Nqm5IfBLGh1go2udklOVEGV/zgSlWdEy/zi29dKSoOZ/L5S
	M8HoVpP0DSi5jISZQu3wLtg3jnpnSVjUVl+QQcayaFy9JyefdpfEuHzo4xXEkOlUIopjZHwaxN6
	THKkyw3sgtwo3z0EIb+Ip8eHS5qnocEDH+2cL6RaFOeyJyP/DkPXrogGzbCh823GTCLy7fQlFBx
	oLU8SuYatH6JWxLjfyFZ9+sbVPFzczLQ5/sFlXTcKB0o3XV0f4MxA8cK2xcB+GtlNtnczKi/kTm
	evTLWeK1QOtztlpI/nzGhddNd4uRrGTRnoU5j9mxJAdTpxraDFVAOS2M/fEljnVTcvADa4u6+mY
	VXepRoDwb2gt9P72giz4vQ7+B37gZSjTwStvQOsGefEULNe3qYS2aINK4PNksXpAZSxIysN6RQf
	AJS57Bfn6uaQjddqrzyGTAnvTELtH9jXeT5/etgVQAFWXEXV8JDT5rbX0g3EbTCQ==
X-Received: by 2002:a17:902:e545:b0:2c9:f0c5:98d6 with SMTP id d9443c01a7336-2c9f0c59ccfmr38873085ad.6.1782747683960;
        Mon, 29 Jun 2026 08:41:23 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9d886668esm37040605ad.58.2026.06.29.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:41:23 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: act_bpf: use rcu_dereference_bh() to read the filter
Date: Mon, 29 Jun 2026 15:41:06 +0000
Message-ID: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_bpf_act() can run from the tc egress path, which holds only
rcu_read_lock_bh(), but reads prog->filter with rcu_dereference() and
trips lockdep:

  WARNING: suspicious RCU usage
  net/sched/act_bpf.c:47 suspicious rcu_dereference_check() usage!
  1 lock held by syz.2.1588/12756:
   #0: (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit net/core/dev.c:4792
   tcf_bpf_act+0x6ae/0x940 net/sched/act_bpf.c:47
   tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
   sch_handle_egress net/core/dev.c:4545 [inline]
   __dev_queue_xmit+0x2185/0x2c00 net/core/dev.c:4808
   packet_sendmsg+0x3dfa/0x5120 net/packet/af_packet.c:3114

The other tc actions and cls_bpf already use rcu_dereference_bh() here.
Do the same.

Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/sched/act_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 58a074651176..09d46e195e33 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -44,7 +44,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	tcf_lastuse_update(&prog->tcf_tm);
 	bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
 
-	filter = rcu_dereference(prog->filter);
+	filter = rcu_dereference_bh(prog->filter);
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
 		filter_res = bpf_prog_run_data_pointers(filter, skb);
-- 
2.43.0

