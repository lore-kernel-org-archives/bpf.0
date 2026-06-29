Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A613C456D
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728535; cv=none; b=eETGgRwRJ+jG9Z8bE6fo0ds+vOido0Sft8hBnxOAR+4ACEMHA3acZ27vgq5VyLXAUw7VmoGh4tZIsdCgsrtXB+ly0aXdb9OqzSrlBLi8LT+nQ72kx/c8gJVggjexq7WmZsdMCCMhvpSd9HUr2PfPKCbOOcxhkQSWFKBh46PRyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728535; c=relaxed/simple;
	bh=jwLgLR3nYwBK3/BuT+gD2ATqKLN7xJeOS1tgrZOALpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eI3rlA91BKJ9ar7ZJfLVaxH/9YiXpFoVTvHJv5FP0djeXmv6auP1AGcnAhDr2fbDUdtHtk5SFaOZkvp4WyQJYteWwPChPHeG3CqGsxyG41Do0yuHKiHA3GyYsroghbTSwXGqhgaTIMl4p5dDOcgSY7kuKgYErM0sJTO5e2/gvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ggLBy4V1; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ggLBy4V1"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c9211d2so30066785a.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728532; x=1783333332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=ggLBy4V1W0LbmCKi/2CazVXEZUlnFpJGI7IpQ8C6hf43LMGWg/y7xDO/AhVIeGzdo1
         dzRfWThPGyMVVqXzjBzn3MXV6fAAhGbtBNGSrW857aOqnM/vmGhwBQGTVuz78M5HnBVE
         NmOVH3a8r94j03HImkuz6qObCE09I1qRiuT+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728532; x=1783333332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=kGovZBAxAD4b6VoXC98mIxCpXA1rSqevjm3AcWHgeh2HUUPhLoGX4XxUe0WG975qW0
         5jruilH0ABmLZjI2PoDdOA0APLOUbLtQzeaR1gJ2Y0enSNLTQjxgP01OsK8blg1zGNiE
         JEVv7Qi9ilV06BosJgm/jel/2a1vA4v9SJ/j8rAe7Ye/l8AxRizO8x855g369uyir0xC
         2PPshs3UkpcYLlYoFdz5cPN3p3HLjaWJXo58STALNH5lTjzbcFRkg1psZGPpkck2K7ZG
         bKyGresDLr3LqNexxoneiiaRdWhOJ53GthjsNeiInWHmB/1DbHQxZ5iUmoIztnuONGU5
         1YRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rog8N1CY3HgNQo7k4MMQRmcpRcQRckJXtt1lobza25M2229kX/ghkFT6tMcGN6os4nwwQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DRKg+0eih65Ds3KrmDrt6+7UC8Ecd73M9PZPcmfDp/48aAwI
	T6u1PXCeS9OUYwccfibuxELgKSJgAHMyXNWTrKE+XcJwsIe7/Kp1Y65pmlkRQEzy+g==
X-Gm-Gg: AfdE7ckumXcXssTTPD9UheI3Ks//cuT6rlyZvvs3Tr/F8GuC1aM3lGT5JzZGrg/yPHp
	T2k5oxm2SPZE34vTOjbuPBIXkKJwyeu0WuLRMJc5mFkMHeRZYAQhQ3v0s8jyaHLdzLi6fZsvH8t
	UzwFQnvBWz7e/qlrsiDQC8hAfrfbpTtGvj5wmToRi28957ejFJvKuQGHDYTfiJ8N246LItYHX6G
	xLgZVfvsAXAFCI7RZcWzHOsPtP6Eut4ufDNBOO0nObdycdlJKzYniGuJPnK5DxuRUXjJvnmpMPy
	aVbhUkbZojhtBYX4oWfDMctdjiJloKdwUE1Pk2YXnGRoe1tz6YoNif8UwD6pVKJ5ifCnLbBwDTk
	fhIaAFWoQRDbjGjW4zcNACwE0FzVxa7xnT/8mxhu/wmAYVuagiNozHc1xEexW/PYZEg5xMYZqRF
	i7g3ts2g==
X-Received: by 2002:a05:6214:194c:b0:8ee:df58:e5c5 with SMTP id 6a1803df08f44-8eedf58e938mr95782096d6.20.1782728532334;
        Mon, 29 Jun 2026 03:22:12 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3 v2] Fix broken TC_ACT_REDIRECT
Date: Mon, 29 Jun 2026 06:21:54 -0400
Message-Id: <20260629102157.737306-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.


[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

---
Changes since v1 (address 3 sashiko comments):
1)Patch 1: Address pre-existing issue to cover asynchronous qdisc enqueue
  operations in particular if bpf_redirect() is invoked from an attached
   ebpf program (the helper invokes bpf_net_ctx_get_ri())
https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

2)Patch 2: Explain in the commit message that it is actually design intent to
  remove TC_ACT_REDIRECT from tcf_qevent_handle().
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=2

3) Patch 3: be explicit with $EBPFDIR
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=3
---
 net/core/dev.c                                  | 31 +++++++++++++++----
 include/net/pkt_cls.h                            | 13 +++++++
 net/sched/cls_api.c                              |  6 +---
 net/sched/sch_cake.c                             |  2 +-
 net/sched/sch_drr.c                              |  2 +-
 net/sched/sch_dualpi2.c                          |  2 +-
 net/sched/sch_ets.c                              |  2 +-
 net/sched/sch_fq_codel.c                         |  2 +-
 net/sched/sch_fq_pie.c                           |  2 +-
 net/sched/sch_hfsc.c                             |  2 +-
 net/sched/sch_htb.c                              |  2 +-
 net/sched/sch_multiq.c                           |  2 +-
 net/sched/sch_prio.c                             |  2 +-
 net/sched/sch_qfq.c                              |  2 +-
 net/sched/sch_sfb.c                              |  2 +-
 net/sched/sch_sfq.c                              |  2 +-
 tools/testing/selftests/tc-testing/action-ebpf   | Bin 856 -> 9072 bytes
 tools/testing/selftests/tc-testing/action.c      |   5 +++
 .../tc-testing/tc-tests/infra/qdiscs.json        |  32 ++++++++++++++
 19 files changed, 87 insertions(+), 26 deletions(-)

