Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD931AAAF
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390909; cv=none; b=FiukA2qteZlL7QbpkzyxE9SYHaO4oawiVzjujLhNqIw6pv7gH9yZizfRZtf12WVZk7dm515sCQWy4J1my08boeVx8cCCNdOLsbRkNvOM/Yg0lqoNariwkormBd4+X6hZunjBrDoGmMh4QDAGbo1/Fz5LKOFdGfPIrEdewzkFnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390909; c=relaxed/simple;
	bh=f2kSPASKVpGleWFrc0xO5xsyxuYP/0eq08GQNxzTz74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p62KaUmc5QtbvXnIyvJj79gW8O/OSpDRkOSshBfMUWb355oI7CnLzWvOk0xj+ScZpM1VLtSKy3Xr4oibT4vij1h4V4OkMx0B8PrSql9QKz7itmADv5nOU2R6R7edi66IOBQhRg9/o719e/IGePPRw7Kz93IBxsFTIe/u1jQveP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=it2tGyYq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="it2tGyYq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso20615255ad.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781390908; x=1781995708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NY2wqsqZ4pNc5w4n8thORvec/7okeYqsyH3VQnt9XM=;
        b=it2tGyYqX1gB9HLMij0KRomOHQ9Ojyr3qqadKjtX4eI4PCMuwP4wntUGvigihsIC/W
         /upv27NLrq5zDgbOgsCTurdBCmhFlj49rORoj59Mt3wR3ydqFzTpfsRqVK/6pdcr+aEL
         M0KU/LPLhGRL6Zlq/Wghs++VfTmlEpx8L+J5Ot0wCO+P7eit7w11BiDk9+9recWxdIsl
         BFwiSH/RfkD2fsxubxu1YK3U70HeiGbvm0y57Ed+gLn85tfa+AF47JtPidAuPAuZ14yq
         ulyHH54W8vf2qDsvPOcGyFIAtIHMpwacC3cpl9famiB8i66et2IscPO/IhKGKCvzVSLB
         Trwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390908; x=1781995708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NY2wqsqZ4pNc5w4n8thORvec/7okeYqsyH3VQnt9XM=;
        b=DKHQcN7okEFlOScs256ReyhxPq5JEqpPm6OptGvx2ywEQgNbEjb9tSmLeBkCYbPnHc
         ue+KWvDUGGxK/PzYlTf0Mf+NpRsc91Oqkr/1WTHLasGmBZ0Yhd7FL46k+1wzQUg3u33A
         AbwcTUIK+stHi4XBMCsmGiDJERYQ08+BP6S+au3Gn+YM8HzK3x9P42zic5G80S5ESiGW
         p3d/U2BjZBn/J9MmPu2WTUfg09xRnXchnZ58weJJkwqiTzZzZpBWfCmmZ/bELQka4GmD
         KBPUPZEpvUk9jYY80AOdPimDaJDmz89YxXheAg1R/yp53X8Azi3z7Jcn18X8NSphKJf7
         3Z1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9EQvixu77gi9rM7/NIhgQScY6urg7nXwcBbB2hRkbcQ+tfIkv0r/UzxtqlhK5ySrdfmao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6E9TSiNKpIHDZ6wXvAF4OEnhK88HG3oxuiU7BoQwrRyc5Kbg
	Yo3LMDrtMZvVH5XmIr+Vw6Lk9acZOC/TY+ukZwrIA5rqrFq8zboa1d9TaO2hWNtDQOVhnu6Ubnw
	TztkfYA==
X-Received: from plbmo13.prod.google.com ([2002:a17:903:a8d:b0:2bf:202c:50cc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acb:b0:2c0:a746:7b16
 with SMTP id d9443c01a7336-2c6641e3058mr52436855ad.22.1781390907653; Sat, 13
 Jun 2026 15:48:27 -0700 (PDT)
Date: Sat, 13 Jun 2026 22:48:05 +0000
In-Reply-To: <20260613224823.2399535-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613224823.2399535-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613224823.2399535-2-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 1/4] bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently bpf_kfunc_set_tcp_reqsk is registered for
BPF_PROG_TYPE_SCHED_CLS.

We will add more kfuncs there, but the name is too specific.

Let's rename it to bpf_kfunc_set_sched_cls.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..823c62481dbf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12498,9 +12498,9 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
-BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
-BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
@@ -12526,9 +12526,9 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 	.set = &bpf_kfunc_check_set_sock_addr,
 };
 
-static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
+static const struct btf_kfunc_id_set bpf_kfunc_set_sched_cls = {
 	.owner = THIS_MODULE,
-	.set = &bpf_kfunc_check_set_tcp_reqsk,
+	.set = &bpf_kfunc_check_set_sched_cls,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
@@ -12556,7 +12556,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_sched_cls);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.54.0.1136.gdb2ca164c4-goog

