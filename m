Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D4C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 04:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3397820C01
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 04:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2dGcBiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfB0EFa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:05:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41148 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfB0EFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 23:05:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id y5so7308328plk.8;
        Tue, 26 Feb 2019 20:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1pVped1bfCGDy2SMd23AsCIKcj6l1Sp7ofyBMj+iOs=;
        b=f2dGcBiT2F/qxMblw1COoHn22zB/yXg8IQ4o4dmKPCwRAy+fSv25+B2t+v8k4oJ6SY
         ayJOb/gjfUVMV0VZC7x60fVrOSxdJAImXyobTiAL3nlgIstHsR6OJtpJsPyulRkRuj97
         TTXzerCfX/UwzqjnOxknPI7Csy88Dsu5G5DRMAy0z0N1dB4XU68PJ/N5WdmPeeRojUk+
         pM4zMgQ22i0oRWiRuxad72LvgZ32RWbQ0ZzTPvZ7+c9QTCNeD16RZ+0OVPQlCjMUDzmP
         elo0EOZlDxNJCHcb/7G/pO8GFPn053O9qPS7uZLgZl7ddVVVd6Zl1FMVf64X6+T4S0VH
         GnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1pVped1bfCGDy2SMd23AsCIKcj6l1Sp7ofyBMj+iOs=;
        b=iKJffdBpuyaLfTscCsbumzns7+fHzs8R2a/iwOsbEnq0NpANLhRnEg66CrHOUTGs3E
         b0Yc6NBKymRQApti5vecIfNqkNtMIIrmlW8Tx9iX5spq0kSE4Z3kTYVwLpLSAAY0t/zD
         Hy1aFMXT0932MEoSlbKegV6aJhNNcjeuby9kpONChEfoOkl7Jh9jEAKBP6ViNrDGgqHN
         9tZ/dGoJa6UdNAo+7CubNebAvR/4CXtkOBKRWgw1y9EhKbDUfHgcl8ckr6c9Xmqs8KsO
         vYNDCpl5xG1/Hs7EqGxBNPCqpsnqZYJEHk33dYB/bpxMhkWmf6CBZneedUTQIzj5teB7
         bBZA==
X-Gm-Message-State: AHQUAuYOy9RpyE8B1I6bJHn8QHqdmy2hFDsFpAtRoN/HZD7rMKBEZoy8
        6KcE5ZegG1IRMRNv1xCckqvbos+m
X-Google-Smtp-Source: AHgI3IbhbPtbrBQvXzUZHr/C9VAQktkFu3XQtqgzdO6hTwoFscqr+8pwmAeleUBynm/s0SaEzsg1RA==
X-Received: by 2002:a17:902:e50b:: with SMTP id ck11mr20165plb.25.1551240328945;
        Tue, 26 Feb 2019 20:05:28 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:4faf])
        by smtp.gmail.com with ESMTPSA id f193sm26488111pgc.3.2019.02.26.20.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 20:05:27 -0800 (PST)
Date:   Tue, 26 Feb 2019 20:05:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Message-ID: <20190227040524.dsmrqpcbmf2pvebu@ast-mbp.dhcp.thefacebook.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
 <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
 <20190223023810.5s7zyj4zqe6poigg@ast-mbp.dhcp.thefacebook.com>
 <439aa0d4-3f31-1385-076a-bb8dab515bef@iogearbox.net>
 <24d2c526-3f9c-3101-ef60-d92777ebdcb7@fb.com>
 <ae7a96a3-d70e-1885-db59-f9d0a55fb636@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7a96a3-d70e-1885-db59-f9d0a55fb636@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 26, 2019 at 04:29:45PM +0100, Daniel Borkmann wrote:
> On 02/26/2019 05:27 AM, Alexei Starovoitov wrote:
> > On 2/25/19 2:36 AM, Daniel Borkmann wrote:
> >>
> >> Not through the stack, but was more thinking something like low-overhead
> >> kprobes-style extension for a BPF prog where such sequence would be added
> >> 'inline' at beginning / exit of BPF prog invocation with normal ctx access
> >> and helpers as the native program (e.g. time-stamping plus read/write into
> >> mark as one example which kprobes couldn't do). But might go much beyond
> >> context of this stats collection.
> > 
> > see below.
> > 
> >> That's actually an interesting thought, given the original prog->bpf_func
> >> is a known address at that time, this could be templated where an inner
> >> dummy bpf_func call to the normal BPF prog gets later replaced with the
> >> actual prog->bpf_func address to have no indirect call. This would also
> >> allow to keep the actual prog->bpf_func entry call-sites small and simple.
> > 
> > My first thought was that we indeed can have a template of stats
> > collecting wrapper in .text,
> > then at 'switch stats on' event vmalloc exec region, copy wrapper code
> > into it and manually patch 'call foo' x86 insn with direct jump.
> > That is still quite involved from coding side.
> > It's similar to what kprobe/ftrace is doing, but probably
> > an overkill for stats due to potential security
> > concerns with new executable code.
> > But it won't work due to tail_calls.
> 
> You mean for the scenario to measure the _individual_ progs that
> are part of the given tail call processing such that each have
> their individual inc in count and time-spent attribution. If so,
> yeah, agree. Or for the case you have right now where everything
> gets attributed to the "entry" program that triggers the tail
> call processing? Latter would be similar as we have now in this
> patch, imho.

There are two other issues with 'epilogue' approach.
1.
We call progs as (*(prog)->bpf_func)(ctx, (prog)->insnsi)
and from R2 we can get back to prog and from there go to prog->aux-stats,
but there is no room in the stack to save this R2.
So we'd need extra 16-bytes for start_ns and saved R2
that epilogue can use to update stats in the 'entry' prog.
With static_key approach gcc was smart enough to use callee-saved
registers and no extra stack was used in the caller
(at least for one callsite of BPF_PROG_RUN where I've looked at asm)

2.
when stats are flipped on and off we need to make sure that all bpf progs
in prog_array are with stats on or off. Cannot mix and match.
Otherwise this 16-byte stack mismatch will cause issues.
Which is impossible to do atomically for the whole prog_array.

> > With static_key approach the main prog accounts the time
> > of all progs called via tail_call.
> > We can argue whether it's ideal semantics, but looks like
> > it's the only thing we can do.
> 
> Yeah true, it's more about measuring how long the prog 'chain'
> in the whole hook is taking to complete, which may be interesting
> in itself, just perhaps a bit confusing when looking at individual
> progs' share.

yep. would be good to come up with a way to measure individual progs,
but I couldn't figure it out yet.

> It's simplest, yep. I guess if we get to the point of removing
> indirect call for BPF_PROG_RUN itself, we might need to revisit
> then and move it into bpf_func at that point. Kind of implementation
> detail given we only expose count and time spent data to uapi,
> though the direct switch at runtime may be a bit problematic in
> future. Anyway, lets see how it goes when we get there.

yep

