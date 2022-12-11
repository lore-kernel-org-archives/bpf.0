Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A9C4332F
	for <bpf@archiver.kernel.org>; Sun, 11 Dec 2022 22:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLKWd5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 11 Dec 2022 17:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiLKWdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 17:33:55 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF52BF58;
        Sun, 11 Dec 2022 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xKv8eN80SE3N/mAMUDX3qpnzmr8mwGvufEWjp+a7v5k=;
  b=mw1UiK3x/O5DaWjglFSJv4R7grcPOjULKmh2OMf005v0cU1h+w5/oHWo
   QnvcxlvTL+e/P1TPk3keoXTRmzZzMpXGhH8ypVEJnP1mLRJeluSJYf3+9
   xtUs6nDLGQge6VmL/Mbz+aLrxewblPA+vATiO3OGz+n9YOzXwOymzEV91
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,237,1665439200"; 
   d="scan'208";a="82838892"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:33:50 +0100
Date:   Sun, 11 Dec 2022 23:33:50 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tejun Heo <tj@kernel.org>
cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler
 class
In-Reply-To: <20221130082313.3241517-15-tj@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2212112331150.29296@hadrien>
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-15-tj@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> new file mode 100644
> index 000000000000..f42464d66de4
> --- /dev/null
> +++ b/kernel/sched/ext.c
> @@ -0,0 +1,2780 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> + * Copyright (c) 2022 David Vernet <dvernet@meta.com>
> + */
> +#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> +
> +enum scx_internal_consts {
> +	SCX_NR_ONLINE_OPS	 = SCX_OP_IDX(init),
> +	SCX_DSP_DFL_MAX_BATCH	 = 32,

This definition of SCX_DSP_DFL_MAX_BATCH makes the dispatch queue have size
32.  The example central policy thus aborts if more than 32 tasks are woken
up at once.

julia
