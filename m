Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB50C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F92084B
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnHC5qHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDIOfM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:35:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36504 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIOfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 10:35:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16so15174471edr.3;
        Tue, 09 Apr 2019 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAcU5321jo2Xlc1o2VQjsVSaeDkBUE+c6ClSs34liSA=;
        b=nnHC5qHQp0rFYlxmoKrKfn5QkaLRjK3Pk6ytcSICCOykvQL+wB3S5jyi7ZnyrzGduj
         422UZPuiNE0AKeUBuO4IArZPGY/iqHeEF8nYBNgdwQlIu8wtaBRkz7DoXJtH0CnN4GjM
         e1yZ1yoDda7jlHwQ55iE7bhmiNMoC3Zvm4H2GXJenIKuKZoXORMTyiJxsH54ECDOV8rw
         3Vais0YUFocvKwfAuYVkVhbhUg43QwzB5aK84ZWcMXBIP73H394nGxwtAQyVMi2kGDL+
         t6uK2n2zTtnx76oGic5D7zBDj+/OhmT/WPqCOlgrJpzqI7WAdG0CJwVpabDXeOU2QxnR
         4mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAcU5321jo2Xlc1o2VQjsVSaeDkBUE+c6ClSs34liSA=;
        b=Uyx71+CowqlKiHXI8EeDBz14EkM9p/fVbAkxPnc0mVLxpbPcSTG0Dz1LJzSRmUDEdW
         C6wo556bb6aqkbRXZrANhIQtAEtecNYAG9w3mLCPNglC7CKBDvRxeJD2OpJ/GnHOdcey
         ihjcOGtheQvz//SQDgIj9M2l+yGv5g584JlN+loLkpBZ8nikwDLvQE8ian71wTzVdu27
         gxWfCVr496e67tfP3M+vmEFyy1QlFkyb1EWmRl7cd10ekbc/ZneSflP1rv2A4fTpoqT2
         GJTsCYWNznbyzlDsrAkH7cba2aA/YaIWpfro9j9dHgJZN2Vx0v66zmTOq0bldSBd9Mm9
         Zg5w==
X-Gm-Message-State: APjAAAWUOMjRAgUBb8I+ZrkxC1K9HcESy1eX5ALeCqc4ZJcNduVuXRsO
        lS5U1EIKyABsZU5ktxV6Jbr0qzgSX9VGfkWMqyU=
X-Google-Smtp-Source: APXvYqw72u/AFJ6dj/hrsmj3VuBZsN2YUOHTfmfvtwCe2/gVMZpH6erw3rhFttOMWVSZ1o/RVxGlw7Z8kD5u+IIILOI=
X-Received: by 2002:a50:ca0d:: with SMTP id d13mr22883835edi.72.1554820509848;
 Tue, 09 Apr 2019 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 9 Apr 2019 10:34:33 -0400
Message-ID: <CAF=yD-LxDeBehWTzZknjMNXnj5cmr1cqi00DCt1PCYTecy7KAw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
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

On Tue, Apr 9, 2019 at 10:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
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
> Changes since v2:
>  - updated tools/testing/selftest/bpf/config with FOU/MPLS CONFIG
>    variables (patches 1, 4)
>  - reduced noise in patch 1 by avoiding unnecessary movement of code
>  - eliminated inner_mac variable in bpf_skb_net_grow (patch 2)
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
>
>
> Alan Maguire (4):
>   selftests_bpf: extend test_tc_tunnel for UDP encap
>   bpf: add layer 2 encap support to bpf_skb_adjust_room
>   bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
>   selftests_bpf: add L2 encap to test_tc_tunnel
>
>  include/uapi/linux/bpf.h                           |  10 +
>  net/core/filter.c                                  |  12 +-
>  tools/include/uapi/linux/bpf.h                     |  10 +
>  tools/testing/selftests/bpf/config                 |   8 +
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 321 +++++++++++++++++----
>  tools/testing/selftests/bpf/test_tc_tunnel.sh      | 136 +++++++--
>  6 files changed, 417 insertions(+), 80 deletions(-)

For the series:

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks Alan.

(quick response due to iterative review: checked out both v2 and v3
series from patchwork (a super useful feature!) and did a git diff)
