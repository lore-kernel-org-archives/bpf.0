Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CCCC28D13
	for <bpf@archiver.kernel.org>; Mon, 22 Aug 2022 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiHVPbJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiHVPaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 11:30:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5859B1ADBB
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 08:30:21 -0700 (PDT)
Date:   Mon, 22 Aug 2022 17:30:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661182219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyqnkzshOYjT/SN0T0H1ey9h7WSnLWq3P15e48ayVMM=;
        b=zlqnHYTHA1g9RpBtRfGtYr18CtAUCAGc0WG3zupRpzkuW5ht/XtQL6saesSr0w7+gB4PkA
        zCKbYHOHw8n4qPk6R2a+r/prnZY80B/djy2ABpcXDdu6lat89NPIdFF9AkqGv7djHotHi4
        JmAxIh+IjwPnmBX18U72z7ym3CrFXT0tMrwrJkJ7WFKaYr2CzPraI6+5X9IySa0z4I+cB5
        PP0RJO+e7F7qn3Z1celF8pirFBCGLoVK+H9RsVkAk8GcGcTHRIQQS8aLm/pXiZC2U0fDKZ
        go1Dsg1Jdp5HamARIlKM3rhK3nxgJ3iFXIUbQzJ7TroFaa8AnXUU4qC+QHDJAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661182219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyqnkzshOYjT/SN0T0H1ey9h7WSnLWq3P15e48ayVMM=;
        b=AGuph7QhlFILWshZh/v6T5Aco/pbYxjPFGEugj8jY3TIO3ytsQJA+XWdQCr8ezOFWrCwep
        nFm5GXYkdbrEpADA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
Message-ID: <YwOhCnLfpJLj0JH3@linutronix.de>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <YwM6l7MxTe47fzFZ@linutronix.de>
 <28f33042-2c86-87e9-bfdb-5bc312f06f71@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28f33042-2c86-87e9-bfdb-5bc312f06f71@huaweicloud.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022-08-22 20:09:47 [+0800], Hou Tao wrote:
> Hi,
Hi,

> > But isn't the RT case still affected by the very same problem?
> As said in patch 0, the CONFIG_PREEMPT_RT && non-preallocated case is fixed in
> patch 2.

ups, sorry.

Sebastian
