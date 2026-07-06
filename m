Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90183B14C9
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358388; cv=none; b=popRPTnHNxiw8C0NfsLBON7ko6wnXpO7jL4mklm/UdEmXbMsu2pumogDASFUwT5Sw5XBgyEP+om8m8bIS4dhpiGcIElC0jbRxFfto5A8O+emQ5oRS1gO0ya37SS0DP9i29GCNbQSjzmcCQJTJFnQeedLjfy7vyqY12bF5LlHuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358388; c=relaxed/simple;
	bh=XwQfRbXfrNuIcQEj0+OhqhxLBV6AQPlwF5ItObbRv+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv8jL/OZ0SudhqikjIGxt4Bl+lZCl7t0YkF1OboECMNQth0s1mmbZOCVGSDcUepIQR2o6okGUPijGhevtsTxiiXyzrsQrCt4wKRT56gtLG9TTm2m0OAmCbj1sEJaSPN7lG8d8p75fcs5OT7RO/mU6YrCibV/Isc99Um8NKLgNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG5WTcgv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG5WTcgv"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a324d200c2so1894855eaf.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358385; x=1783963185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu+3c0HyaSf1ZVjVmWnlGizQs+nvFxxTW9EelDXDZ/4=;
        b=DG5WTcgvPhY5nTNhyiepqlO/1jpASDSTMHCd75x3l6gGk3EQ1TDO9VWvsER2YKXqMM
         Qkl2EfdAWhJtCQeCNDyptLq3BSNFF6AU3UnxdZwDrZfCep3EvpXwEVZQqcCFjyMoeJKR
         uczZ9euSfBuVHjf5Xdawi2x+e74pICXHlNz/GLpNW6yB/L6SmYfjH0Fx/G3zPsrf8zjv
         Rbz7n70lD2aN3hZbLdhnPMMQriAzJ+QO3mFaOiSams/vXzAnLBFBiNkClJHI162azfqI
         2/sabnMBk4MoG8pW9RjffB4WKFlyBiKFart/0IJ77mVwHt/BWwlbRUCOZR0fHNcOXawa
         QnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358385; x=1783963185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pu+3c0HyaSf1ZVjVmWnlGizQs+nvFxxTW9EelDXDZ/4=;
        b=PYRPId5R60zWcyAF/6AdMAHGE8Ym6IDDsZrzfJFR+f4xc+VcULb7gjmPSc3L8WFis4
         FXdsglmxGpAx4wvt8id6xqQUQmt8ZRlgq9agcDBoZIs/0zcvIDTndVEKDbJsL5cWgHD+
         +NVgBJRsb3abs3rAQcFzy/+b499wCRvyVt2EMWPADBu1EgjlKcgjUijwSk0UhgRi4Th7
         zAmCPyE1jGFv+PGJ9+rTkRE20Z0ONtcB3rOUVMr0z6XS0zvVFpXZM6uYvdFQRVsHrvXX
         rcVYad9JFysrqqhmfXgukovSoeuo6pYn70lubqXOn0XF6Xbpjm4FQRGrVTzXH8Dd5fSR
         v3AA==
X-Gm-Message-State: AOJu0YxapMMcRVUxi17torknzEbjDRIpaxNGOvGuMgNDoVUHCrrcOT2a
	xCiyhoO0Th0lGdd0fBNBQFdmY/nqxoVaQJfW/ZQLqLDDuR33NSDV5N3cJKpyXw==
X-Gm-Gg: AfdE7ckSuHpOm1gDiyo/mWbAEAsbl/dSaMddV6d+NY26sqKiITVrQVnLuvQVsAorJrF
	7Gl5UbBl2DyjQHHXJn/K4HnxF+TguiGTGu3nXXX8TnJ8LCOo/A6a4iR3vPOWd9HkSjSTy7OH/J9
	kTSE/k+kFSMuRWucDoDigHuaVS6Xehc3z/9WoQD5bacey2aux1aSEDc8JZHoTf/Ld0fMu+vP+lS
	PpTLTHduCUNUFq+OSOUxQ4vKCzhIKJxJXUahY9vmXgtx894IlwWH8vHHrBd73I1+CkQppzKvxtu
	EzidA8lWhJf62wRVLlJP4J7rhLjLrcV7O+mbw14EI5byxmq2+SBliZqDsT4MkuuX9kfQdNHQe0v
	zmDC45f3Q3+OkTmMNtZAjLpPRdi3O1Jg489ASGiE9En5pVcVdPG2sAlwL48QYxVakTdqyjOPGuN
	sOTWg=
X-Received: by 2002:a05:6820:1356:b0:6a1:8496:b12a with SMTP id 006d021491bc7-6a355289755mr1081428eaf.23.1783358384474;
        Mon, 06 Jul 2026 10:19:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310003927sm8478620eaf.6.2026.07.06.10.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
Date: Mon,  6 Jul 2026 10:19:12 -0700
Message-ID: <20260706171918.317102-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
options of an skb through a dynptr.

All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
available to bpf_tcp_ops and any future struct_ops.

With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
only constrains kfuncs listed in qdisc_kfunc_ids, so removing
bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
it fall through the filter unchanged, and bpf_qdisc keeps access via the
generic struct_ops registration.

Widening the registration is safe: a struct_ops that does not receive an
skb in its context has nothing to pass to the helper.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c     | 1 +
 net/sched/bpf_qdisc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f5cbcac3e78..05f492c215e0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12635,6 +12635,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..5691c13781a8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
@@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
 BTF_SET_START(qdisc_common_kfunc_set)
 BTF_ID(func, bpf_skb_get_hash)
 BTF_ID(func, bpf_kfree_skb)
-BTF_ID(func, bpf_dynptr_from_skb)
 BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
-- 
2.52.0

