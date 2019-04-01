Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225FC10F05
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799320830
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS+QJPFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfDARqQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbfDARqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 13:46:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so9032578edc.8;
        Mon, 01 Apr 2019 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0J+ZoDq0nCEcG1VMBPFqMJbnT0mUdG2R8J6sd4vM/M=;
        b=rS+QJPFRL4kye5J++Anw32jWr9RHFI4xBBZuSfaCGs0cQbBho35Uo+RLTAxkmpmSV3
         j1JsYn4tiGM6C2ZXxz+ALRplfP2FOeAEHaSsxaknY7dVCOu2rYKQNia/AapefFRFmfrK
         9pFtpkrEw+kyeWftzDStzDVwTmpU0M0w/+NbUFNP9PK7L39KHI4dWpq5p/B2y8BtVJSB
         punDuFNmxHkocpd2FnQqmFk2TX5AjXMIhp/7FdK4KIOQqTy2y/O69Y5ZDPCpQDX3kY7R
         SGbfTQVB629xtZjjuPrW5tvk7etDZQKcJE57Am3/N6paVy8Ark9L3QRorjqx1/vB0s+k
         JNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0J+ZoDq0nCEcG1VMBPFqMJbnT0mUdG2R8J6sd4vM/M=;
        b=sTb3Kq+Gxq4M+7oSY/96cFh7pPneOruyYAvo9zlxemKjgLZXksqqRShmJZ2T0uZ8XP
         4XfZDQ4EFevQV4sPqm+x0TE5dqlfjfNCXimFVCkmYWQtFRRAQZhoV8rwCsgD2UvCDo8y
         o6mODiOZJ84QASBt1J6J0zKzkLc/qBv6qHYWh68zxnPjKatHsKojjXRZQU7dv1aNcDT5
         IA292SjRKf8RMGMa6WU7Xp1bKzUCzvdCtExRm/Ed3pMUGS0ZDJ3nrNOqQiTTfjxQEZMV
         jX1o+M21OFkzJBKyyqXFJFSjFMKYnwefkd82d44G4t6Krzp84rGTk//pZkMM7VEjpyoB
         SqpA==
X-Gm-Message-State: APjAAAXcSUvWL651C4pgMhzUUivTxVJ7EH8Ojxky7xyd5U4ePkLlYrSA
        VRw4AZSxUXbTBW9IodAb+4R1+vt+rdBkhFfsnyw=
X-Google-Smtp-Source: APXvYqxP0bMsKeip+KJRC46kFpLuH/d2P+0M+a/E25C7ZTWAdmmA7c1BnMtfxF8BRuq8q+hbGBUnuBBJuoQEWA+1LfA=
X-Received: by 2002:a50:926e:: with SMTP id j43mr45251818eda.60.1554140773884;
 Mon, 01 Apr 2019 10:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com> <1554132731-3095-5-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554132731-3095-5-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Apr 2019 13:45:37 -0400
Message-ID: <CAF=yD-++bp-MN2WiThMsVzR+cxtz25LKL+yC_Fpfd_xe5xy+SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests_bpf: extend test_tc_tunnel.sh test
 for L2 encap
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
> Update test_tc_tunnel to verify adding inner L2 header
> encapsulation (an MPLS label) works.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---


> @@ -84,23 +95,39 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
>                 return TC_ACT_OK;
>
>         olen = sizeof(h_outer.ip);
> +       elen = 0;

nit: could you pick a (slightly) more descriptive name? I don't get
what e is an abbreviation for here.

>
>         flags = BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;
> +
> +       if (l2_proto == ETH_P_MPLS_UC) {
> +               elen = sizeof(mpls_label);
> +               flags |= BPF_F_ADJ_ROOM_ENCAP_L2(elen);
> +       }
> +
>         switch (encap_proto) {
>         case IPPROTO_GRE:

To verify that this L2 encap method is generic, it would be useful to
also test IPPROTO_GRE + ETH_P_TEB, if that's not too much work to add.

>                 flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE | BPF_F_ADJ_ROOM_FIXED_GSO;
>                 olen += sizeof(h_outer.l4hdr.gre);
> -               h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IP);
> +               h_outer.l4hdr.gre.protocol = bpf_htons(l2_proto);
>                 h_outer.l4hdr.gre.flags = 0;
>                 break;
>         case IPPROTO_UDP:
>                 flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
>                 olen += sizeof(h_outer.l4hdr.udp);
> -               h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
> -               h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
>                 h_outer.l4hdr.udp.check = 0;
>                 h_outer.l4hdr.udp.len = bpf_htons(bpf_ntohs(iph_inner.tot_len) +
> -                                                 sizeof(h_outer.l4hdr.udp));
> +                                                 sizeof(h_outer.l4hdr.udp) +
> +                                                 elen);
> +               h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
> +               switch (l2_proto) {
> +               case ETH_P_IP:
> +                       dst = cfg_udp_dst;
> +                       break;
> +               case ETH_P_MPLS_UC:
> +                       dst = cfg_mplsudp_dst;
> +                       break;
> +               }
> +               h_outer.l4hdr.udp.dest = bpf_htons(dst);

nit: more concise:

      h_outer.l4hdr.udp.dest = bpf_htons(l2_proto == ETH_P_IP ?
cfg_udp_dst :  cfg_mplsudp_dst);

>                 break;
>         case IPPROTO_IPIP:
>                 break;
> @@ -108,6 +135,13 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
>                 return TC_ACT_OK;
>         }
>
> +       /* add L2 encap (if specified) */
> +       if (l2_proto == ETH_P_MPLS_UC)
> +               __builtin_memcpy((__u8 *)&h_outer + olen, &mpls_label,
> +                                sizeof(mpls_label));

nit: no need for memcpy, can cast to __u32 and use regular integer assignment.

> +
> +       olen += elen;
> +
>         /* add room between mac and network header */
>         if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
>                 return TC_ACT_SHOT;
> @@ -124,18 +158,19 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
>         if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
>                                 BPF_F_INVALIDATE_HASH) < 0)
>                 return TC_ACT_SHOT;
> -

nit: irrelevant change



>
> -if [[ "$#" -ne "3" ]]; then
> +if [[ "$#" -ne "4" ]]; then
>         echo "Usage: $0"
> -       echo "   or: $0 <ipv4|ipv6> <tuntype> <data_len>"
> +       echo "   or: $0 <ipv4|ipv6> <tuntype> <none|mpls> <data_len>"
>         exit 1
>  fi
>
> @@ -148,9 +150,10 @@ case "$1" in
>  esac
>
>  readonly tuntype=$2
> -readonly datalen=$3
> +readonly mactype=$3
> +readonly datalen=$4
>
> -echo "encap ${addr1} to ${addr2}, type ${tuntype}, len ${datalen}"
> +echo "encap ${addr1} to ${addr2}, tun ${tuntype} mac ${mactype} len ${datalen}"
>
>  trap cleanup EXIT
>
> @@ -167,7 +170,7 @@ verify_data
>  ip netns exec "${ns1}" tc qdisc add dev veth1 clsact
>  ip netns exec "${ns1}" tc filter add dev veth1 egress \
>         bpf direct-action object-file ./test_tc_tunnel.o \
> -       section "encap_${tuntype}"
> +       section "encap_${tuntype}_${mactype}"
>  echo "test bpf encap without decap (expect failure)"
>  server_listen
>  ! client_connect
> @@ -176,11 +179,11 @@ server_listen
>  # server is still running
>  # client can connect again
>
> -# Skip tunnel tests for ip6udp.  For IPv6, a UDP checksum is required
> -# and there seems to be no way to tell a fou6 tunnel to allow 0
> -# checksums.  Accordingly for both these cases, we skip tests against
> -# tunnel peer, and test encap using BPF decap only.
> -if [[ "$tuntype" != "ip6udp" ]]; then
> +# Skip tunnel tests for L2 encap and ip6udp.  For IPv6, a UDP checksum
> +# is required and there seems to be no way to tell a fou6 tunnel to
> +# allow 0 checksums.

Please update comment for L2 encap: why can we not test with a device
for MPLS decap? I am not suggesting adding it if complex. But note
that I added the tunnel device decap before the bpf decap especially
to have some verification that our logic matches that generated by
real tunnel devices. With our own BPF code on both sides, that cannot
be tested.
