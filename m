Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF21C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D1820863
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj4SvXqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDHTH7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:07:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46908 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHTH7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 15:07:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so12663861edd.13;
        Mon, 08 Apr 2019 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBNWlPMptGUN/lU7SWfOJJiZCnIs+OZIoU/tTbQnres=;
        b=Uj4SvXqUQ+G5gAUKLGnB0lD8wo/DhTfr85kcg/0qlMD38SKJnHjJlkWwED9Askl8Cd
         E8aocVOA+gRGgs7oCW2HHFXm+fpPcpvYcyLyGyEdNBl24u7MBWktMzm1mH4CGA2ySNkM
         BCjHfBZC4qtvl3tjR9arv8+q0x4KLtR7xv1Q/CoWtBbP2ZpfPtHOyWIvUQRvF/pR1/1x
         UwbzaRv697158C0XqLiENQ2HTHW+UIK4cPppvCZqFW84J/6NpO7CsohsEzq1f6kqvG8A
         IkQvhAhH+CF5xuZdl4ZqIlKIB0H+59qkRVU+IMQ5v646MZidlio3gsFWAwUeURUCpOfL
         YHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBNWlPMptGUN/lU7SWfOJJiZCnIs+OZIoU/tTbQnres=;
        b=K5b2Iw1hzb/lI1wj2jWT/qRHYr3I/xdxbsbtIVeChK17hIVV0vepff5C0XlF5F56fc
         t7VMdNvZRndsr9cKKWtTlFPVHSHiC2K4xadBeMbgRSFpcjzlqnPWwE+1PWPB2SIQ4JYe
         nJDZ4D6N+iMkvKG7AzOm3zk7/cjPM5NXlpI1zxVFnxbiVXmiWcHx5on4WQXcfMW3b3vc
         2tnn9qBAYi6xqgDTgr92ZWBy4vTq74kobeOVHwXCv8w59hhntEU1HNolr+eN+cfhu3JO
         quBnoThC5jPtsvKklaq4wI+jxRPDL+QQI5E5wFl+1t1kAbkS+LXI9Szu7ACglCb5M3TA
         ukVQ==
X-Gm-Message-State: APjAAAWFTZHu4XccPfYEvecTLBa1tV0RwdqPIUlCm0vYTj1+Jx8Pns+v
        N6T8JW0/ZhECoVRQdBYFZ98KePoiqvHH+0hxQ+I=
X-Google-Smtp-Source: APXvYqy8S0ZL1/QcBDBMTmhjFmzfbDAafxcU3m8+OSuHrKR8VM9YTtlO+GrFun38ScFo5RZyMSvvRWHJi51gZ7SrvaQ=
X-Received: by 2002:a50:fa8e:: with SMTP id w14mr20341816edr.121.1554750477120;
 Mon, 08 Apr 2019 12:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Apr 2019 15:07:21 -0400
Message-ID: <CAF=yD-KFZNGLV4xNJG=R25kRQpsrtQUoWCLh1A09U-CdM3B_yA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        John Fastabend <john.fastabend@gmail.com>, rdna@fb.com,
        linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 8, 2019 at 12:59 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Extend bpf_skb_adjust_room growth to mark inner MAC header so that
> L2 encapsulation can be used for tc tunnels.
>
> Patch #1 extends the existing test_tc_tunnel to support UDP
> encapsulation; later we want to be able to test MPLS over UDP and
> MPLS over GRE encapsulation.
>
> Patch #2 adds the BPF_F_ADJ_ROOM_ENCAP_L2(len) macro, which
> allows specification of inner mac length.  Other approaches were
> explored prior to taking this approach.  Specifically, I tried
> automatically computing the inner mac length on the basis of the
> specified flags (so inner maclen for GRE/IPv4 encap is the len_diff
> specified to bpf_skb_adjust_room minus GRE + IPv4 header length
> for example).  Problem with this is that we don't know for sure
> what form of GRE/UDP header we have; is it a full GRE header,
> or is it a FOU UDP header or generic UDP encap header? My fear
> here was we'd end up with an explosion of flags.  The other approach
> tried was to support inner L2 header marking as a separate room
> adjustment, i.e. adjust for L3/L4 encap, then call
> bpf_skb_adjust_room for L2 encap.  This can be made to work but
> because it imposed an order on operations, felt a bit clunky.
>
> Patch #3 syncs tools/ bpf.h.
>
> Patch #4 extends the tests again to support MPLSoverGRE,
> MPLSoverUDP, and transparent ethernet bridging (TEB) where
> the inner L2 header is an ethernet header.  Testing of BPF
> encap against tunnels is done for cases where configuration
> of such tunnels is possible (MPLSoverGRE[6], MPLSoverUDP,
> gre[6]tap), and skipped otherwise.  Testing of BPF encap/decap
> is always carried out.
>
> Changes since v1:
>  - fixed formatting of commit references.
>  - BPF_F_ADJ_ROOM_FIXED_GSO flag enabled on all variants (patch 1)
>  - fixed fou6 options for UDP encap; checksum errors observed were
>    due to the fact fou6 tunnel was not set up with correct ipproto
>    options (41 -6).  0 checksums work fine (patch 1)
>  - added definitions for mask and shift used in setting L2 length
>    (patch 2)
>  - allow udp encap with fixed GSO (patch 2)
>  - changed "elen" to "l2_len" to be more descriptive (patch 4)
>  - added support for ethernet L2 encap to tests; testing against
>    gre[6]tap tunnels (patch 4).
>
> Alan Maguire (4):
>   selftests_bpf: add UDP encap to test_tc_tunnel
>   bpf: add layer 2 encap support to bpf_skb_adjust_room
>   bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
>   selftests_bpf: add L2 encap to test_tc_tunnel

A few small nits in the patches, but overall this looks great. Thanks
a lot for adding the detailed tests for UDP, TEB and MPLS!

The only change that may really be needed is adding mpls to the config
to avoid kselftest bot failures. Otherwise, I would not even have
bothered pointing out the nits.

With that change, for the series,

Acked-by: Willem de Bruijn <willemb@google.com>
