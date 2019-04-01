Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7733C43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544420896
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV+iZUkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfDARX4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:23:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36110 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbfDARXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 13:23:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so8986562edr.3;
        Mon, 01 Apr 2019 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLsvpcEwyGjfec+Yj6QD6wJ4U4MEiuT5DMj7pFqAMDA=;
        b=CV+iZUkRQjmT0Q+zfDdP3XzIi2vFTj3SoablqoSACFuni9WhW+3ZVm6C0FB7OLY8tb
         KQU02l6izzRyAby6fwjBAnRrEdT4lH/ox0rAvUWmobuqJ38ipx+dBAg6+PU+MTFZQMJo
         +Bvvej0cMcetHBj7tflWIAJuUyybyemNqm9P7KMNhqfv5C1b/CiTV6dlygImDPtn2ayX
         VwAs+KsLaWQcCNfKN14LLveaezlQR5IjsY2vBU0OGVg6vSmSrlTHeqe123LB3Z+25dZm
         CWFOwD9+C4e+FScKq12fDfX922gnzstUqMCQudVff6jsHIwkT/A1HlTZvLBkWkXUnoOQ
         95QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLsvpcEwyGjfec+Yj6QD6wJ4U4MEiuT5DMj7pFqAMDA=;
        b=c+LICPR4E3qiKmTJhe6TOT+hCMdlWX0iqUQxbvFwBVVkWKOWzLmJbFUOQ1jbwD6ygx
         OzEbGSZBv5IHOvOOvaDmO2Rr4U7vAXLYPIVn0LhLSJaBHXkbXEeXzVn6KDzjbn5Uv19+
         Xbg5E1zm2gl+YwCH4BWuv4e4XbcBmhwbEPmJY8nm/ePBgXLdMCw8OGmHuMRSpSoHXTvn
         PyETDm7wNFsECwWj2rtp6y7uFVHHPNuxaF7gv8tBnMJLw2EdsyBP7y+o8WSpG5Pdk0pi
         jr4sOWi0WkRN5WCRtEYZ9yaKp2x1nLgOV/+wTZgbSEIyplJE2mb59e+ZY2OeLbfoTHwe
         fPAg==
X-Gm-Message-State: APjAAAVRsGrCyIquSTQCITT1fFsJpxfc/c8JXGeWVWRKx0dYoaaNe2SG
        pjVrkSwyFz7erZuUVgG+BzBQ/0fNwTklxTLzckY=
X-Google-Smtp-Source: APXvYqx4ovlnjrVJXie/byEqyF5eAqfxRTU/aCydb2daPB4ut0bN+Ldc7xCCvuUqG+ercYcomtaCD++ObiJwXk4i2oc=
X-Received: by 2002:a17:906:31cf:: with SMTP id f15mr33416162ejf.246.1554139433025;
 Mon, 01 Apr 2019 10:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Apr 2019 13:23:17 -0400
Message-ID: <CAF=yD-+YDxYXPhAG+yiEo7ZZXZNxmWXw91RZq6yoTBiR8CDy=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
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

On Mon, Apr 1, 2019 at 11:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
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
> here was we'd end up with an explosion of flags.

Agreed.

> The other approach
> tried was to support inner L2 header marking as a separate room
> adjustment, i.e. adjust for L3/L4 encap, then call
> bpf_skb_adjust_room for L2 encap.  This can be made to work but
> because it imposed an order on operations, felt a bit clunky.

It seems slightly simpler to me. But this removes one extra call, so
is fine, too. Given that there is prior art of encoding length fields
in flags.

That is, if it works for all cases of L2 encap: by itself, before and
after L3 tunneling:

- [eth] {mpls} [ip] [tcp] [payload]
- [eth] {ip} {gre} {mpls} [ip] [tcp] [payload]
- [eth] {mpls} {ip} {gre} [ip] [tcp] [payload]

Less important, instead of encoding length inside flags, it is
arguably cleaner to have a one-bit flag BPF_F_ADJ_ROOM_ENCAP_L2 plus a
new argument l2_len.

> Patch #3 syncs tools/ bpf.h.
>
> Patch #4 extends the tests again to support MPLSoverGRE and
> MPLSoverUDP encap, along with existing test coverage.
>
> Alan Maguire (4):
>   selftests_bpf: extend test_tc_tunnel for UDP encap
>   bpf: add layer 2 encap support to bpf_skb_adjust_room
>   bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
>   selftests_bpf: extend test_tc_tunnel.sh test for L2 encap
>
>  include/uapi/linux/bpf.h                           |   5 +
>  net/core/filter.c                                  |  19 +-
>  tools/include/uapi/linux/bpf.h                     |   5 +
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 281 ++++++++++++++++-----
>  tools/testing/selftests/bpf/test_tc_tunnel.sh      | 105 +++++---
>  5 files changed, 318 insertions(+), 97 deletions(-)
>
> --
> 1.8.3.1
>
