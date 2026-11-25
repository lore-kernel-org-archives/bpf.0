Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608216;
	b=tg0iR97GguWtA1xQ9WBD5JgXNYxpQ/bzfJzMhMdMB7xDCIGCLsA8VXw6LVZh/Q9zdLBG
	 1Rxih9bABuL6Qt/velM3G4djfiH5A9yOCAYCmT2SOxacxGN2RrfvBs9IeOx+KsY04otiF
	 gcA7w3If+bTxZMqlC2Uyhbt1zghU1Qhf32qCJwkqsyuxgEtGS6SX1UFborspp+MOlTCuE
	 AusOToFC16Cb+7jqZ81AJ2ToUXWoobXeXb3upLijSeJ8BRcDUAMLUBnhnM1e6zNkomnDC
	 bCwdHDRKAXQiVgfBTJRohuj2cqKMP0Q3yz1llcVkBEXIG4uEOm3Z00on9CA3CKZaoog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
	b=KfGC4ryAAep7TbF3EJ8NRXQt1VJYRak29M7xJQxQtWDgwax4l1Y/qGASIKui39CTmS55
	 +H6ECMpNS+HnzIxh/3M1kHyQQlsetRRkLXJzm65BinnsfhPrSXNNRM8s2um/C63vdzTKS
	 WP/5sa/Whahtu1rcajbO0ezo7zbmYWdUaZvTiETRsW7ZdieTLdUJqqHR7e7yP5L3Fw35O
	 fzPvUNRE07w9uC0LRXfzpEkc6wY9vP1uc9ZK4zAx/fQ38dJ7y/yj2L35+JMOvL+uVxgSK
	 V3JGW+HtlFbIJnE8bGLB/KgxDQmQ+2O0J2xDYnVPyNKicYfUv3BIgpu9Phadsv5Jeuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b="Vs6Ga95/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D7606A33D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613D7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Vs6Ga95/
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3f9cbafecso765193a91.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608216; cv=none;
        d=google.com; s=arc-20260327;
        b=QyqN1fviIGefRwj6Yf0qpChOveQ7LNhu/otqkh61mIkSM0nC5Dn5ElK+Kgp2/xdQK3
         YF/ORWyIu3NkIyUDgixlCjmWl9Bz0CJv12mT4n0w5rLJM/7iR3FnfKwxG0wlQIhOlzkJ
         GKawLa3yrXnmNDMPp1MsN2M+a1AxRFIZnE+hpsIEZQmDDlC2qynREAOGN4cjDLL+iPre
         jO0KYykKTIZf/Zwf/G36wgukAoxff0IpLKDkVa+NBeNf9/Ewam6lC17P+K9632jNvMJ/
         jwv0SzyAKIjLf7PlmEP3m+ywAJoPqS5xFEEkrrxoDnEq8bMgJYwNcFnPpRfbCqLipypa
         bKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        fh=mf5EVZun5581mPQ3B6XU/k1UuOq1dtpbkLbT0av5AvQ=;
        b=IkZ/AbdAoBagjojvTkCKfPPLticPJrS5PbeSBCtAiA5KDAAFPXkzM7bmrDpJ6x+WTQ
         2UXJWz71CsP2lk0YKhGWOItUX66Apr3Gxp6MFlL7vd8qJNFLzTbsJ8VTcflLyqThscxZ
         Sp7aD61F6RLg0GKGIsMblO8+Jhjfh4nSl+bSwq26MiduIuUlwzl2EvsrXIPTLrCqOU0j
         nslss1VRNisb+LQQAY28P9mMDly8qLPkGiTzheDeSPb6Kwv3s1zA7IE33wuFkS1GEu5f
         rcUcKTI6SroBG5h02oGN0sX/IZ2p7Xevmw9uZXiWHLlh4DRcTtErVK4I6JJwmflTt+aG
         vp9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795608216; x=1796213016; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        b=Vs6Ga95/mRaUREGKXZ9E4vdoMP0K1u9J5ZpXSDocWX2J/AeqvLDgfwj209rKQRafb1
         p7Seom0kCONOkXHyUXxIOsSFwZ1qfTJxeAhYpEamQvZwu5PW8C3lKiMG3FjLgBoAmfrs
         A7E5+JIuzjNhhWEm+MRBVT/DvhQ1+uzse5Po9d8OXJ+D1ivxlOQMIk7y0hB4Gif2fLBD
         GS/uTRxI57SYIJj6HSKCfeJpH2jzpzvyyLwi1eeS5DX91EWIT92HC2J+HL8OBbXrNbIH
         oTys+Rzp14daPGst8Cc5CAkfolTWfg/wAy7f25XrKdYcDwKGF+2u2m6JC2/AkZLvM7fk
         3cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608216; x=1796213016;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        b=0kFVWK4ONb/ihnkT/dMDSr5pByISnWfF/q35iNMOXsjXXLLRQZt2FcN43NF2GwZx7W
         yKtrab2je06vkqDfzuBVu+4PnEQSqrV4Bw0k1zu8vRj8mgvTGbvUXR6dOg4fCVqM4JXG
         xZvHQgTBDJ6PH9QyMPNLOGQ7/iUbGlQz/+OgOCV8XawTHLi9bzSu59GbWfFFFWLQPSnr
         XRH53HLSq6xB7aWjlSPrLkYGdlhBQug5rjGNq5K4MDd5nTA/p172ZcR3aWDoVCE9CrPm
         K8CtBAcHw+o8oZWHYXLrHl43hCO0N+PSjMHoncsczxgXXQiwprvjRzwMputj3tn7HF5Y
         NuXw==
X-Gm-Message-State: APuU4Z8tyhpMwE7+RPvX687n0D9oFShNRI391nVU2rdk0TKW8Ao0IIy7
	/0rtU0VprlPIQc9FmEhNyNPrEOz9CFznvBzf0uSDVMAyJCB1oDtkFTb03PhGKw6db9gZjZ0U39A
	FrAVcpuioM2Y/TlLj+gsLEpMQK4RnVR/9MO9w7MY5eyPBKSPgBfwXZ+OZn/fr
X-Gm-Gg: AZFdTZdYrakfsPRPgyi3dvQiZL/s7vecNiVH/L3ccVzp9vtneL48a/NTQkYWIgLNNzA
	hSN2texxa4p23N+yO8EDtIXynOdPEmvC/n7izzNBDauNAwh+3FNbPCw8GuEvk308aLmOFVrOzsA
	+ir2UEMBNQC8tyHC2pmEtdD2jokHzwLEvymMmazSip6iA2Af4WZ93gM7H565d1NWm1qebnKUY1q
	rYhEtWIEfmuykCBZRi3LHAvFSqaAj7Th/UDzOLO6/PXwPfok6/EvMdv+tFj7xH0iImNcRD+3UOV
	h6lrS6hnwvneKC3YpgUaYgpyXWIN6FmlVLriFMwfFQiZbc+67g8havUKlKBKp0pCQjOT/RzYCYk
	swoMvZJHoqEJgEp4PEf01BlUJPJoKtbwbFPo=
X-Received: by 2002:a17:90a:c10e:b0:3b3:c92e:f523 with SMTP id
 98e67ed59e1d1-3b41c917320mr29094246a91.3.1795608215341; Wed, 25 Nov 2026
 04:03:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
 <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
In-Reply-To: <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Wed, 25 Nov 2026 14:03:38 +0200
X-Gm-Features: Aa3M54oy1asy-clEA0aiBgUJI2wZjpNvBPoFr8M2_NvkO6W7Ay5C4UmmNBOTtyg
Message-ID: <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 08:26 PM Alexei Starovoitov wrote:
> Keep count and timestamp per-cpu. Call bpf_timed_may_goto_save() in
> bpf_prog_enter_run_ctx() and bpf_timed_may_goto_restore() in
> bpf_prog_exit_run_ctx(), like bpf_timer_cb() does.
> Then the preempted run gets its count and timestamp back.

i tried it, it works when the run that preempts finishes first, as
with bpf_timer_cb(). With preemption it can be preempted too, and the
preempted run can go on before it ends:

  task A, cpu 0                  task B, cpu 0
  loops, preempted
                                 save: A's budget into B's stack,
                                 fresh one in the per-cpu struct
                                 loops, preempted
  goes on with B's fresh budget
  exits: owner is B's, no restore
                                 goes on, exits: restores A's,
                                 which nobody uses any more

A fentry prog spins in a can_loop loop, 3 SCHED_OTHER tasks on one
CPU, 4 runs each:

  kernel              runs  dropped  longest   over 500 ms
  bpf-next            4     8        250 ms    0
  save/restore        12    0        1253 ms   7 of 12
  save/restore        12    0        1752 ms   9 of 12
  save/restore (*)    24    0        2263 ms   22 of 24

  (*) 6 tasks instead of 3

You can see it in the run times: they land near multiples of 250 ms,
one extra 250 ms for every fresh budget a run picked up from another.

An lsm prog has no prog->active, so the same test gives the same
result on plain bpf-next: 1253 ms, 8 of 12 over 500 ms. The overwrite
already exists for all progs that can be preempted (lsm, cgroup,
struct_ops, uprobe, iter, sk_msg, syscall).

A fix for all of them has to change how may_goto keeps its budget:
lsm, cgroup and sk_msg progs never go through bpf_prog_enter_run_ctx().
I'd rather split it out of this series: v4 takes may_goto out of the
mark, so tracing progs behave like lsm ones today, and a separate
series fixes the budget for all prog types. Does that work for you?

Thanks,
Mike
