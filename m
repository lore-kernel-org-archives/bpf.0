Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2469C433EF
	for <bpf@archiver.kernel.org>; Tue, 28 Jun 2022 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiF1A0z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiF1A0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 20:26:55 -0400
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 17:26:42 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8EB11D
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 17:26:42 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 2B277B0038E; Tue, 28 Jun 2022 02:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1656375465; bh=SJXCcMcSxSjIoTWs93tG3LqaSSkxWzvsKdPYXR1oFIA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=erlmz3EGFv6lwFYI7JASIA/c66ORgFEfC/SmBPSlaGqyyFYckpUCCuViXEQwie8YT
         EAdDoLz8ZVmfysezs2Ynpbgf8cp2s4YmxqbOBnBuaIms6tzkgyWyfhIzPUezPUvoWE
         2QTEl5WpxO0NtdFCfBdl+Izt2o/q3RhrnPXw4uaSdd4tszq/D/uv07QH6E4WU88Jme
         J2Y7yhusy7PwCFDkII/YFTXsayAZuxx8hwNkL8Mgpuf+uRLUT+/bz5NHAD66s9zLF3
         XScyAUKN/+UtW02zFB0te6DpnA+fBwxGh2KnK9cG94GU5g+DSN0oQP+CzVBX2nVLej
         9Mm+canqrZtdw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 299D8B002EA;
        Tue, 28 Jun 2022 02:17:45 +0200 (CEST)
Date:   Tue, 28 Jun 2022 02:17:45 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>, daniel@iogearbox.net,
        andrii@kernel.org, tj@kernel.org, kafai@fb.com,
        bpf@vger.kernel.org, kernel-team@fb.com, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
In-Reply-To: <YrlWLLDdvDlH0C6J@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
References: <YrlWLLDdvDlH0C6J@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce any context BPF specific memory allocator.
>
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> Refill this cache asynchronously from irq_work.

GFP_ATOMIC etc is not going to work for you?
