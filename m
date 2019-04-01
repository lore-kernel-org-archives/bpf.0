Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C21C10F05
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E72720830
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY/f7ch4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfDAR0m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:26:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40197 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbfDAR0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so8984492edw.7;
        Mon, 01 Apr 2019 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvrgK3phBe2cb14hN38nY9ORO5qe3i747GjYWn86zZM=;
        b=UY/f7ch4nyonjZvNi9gN910LgE6vosEpWzpNLePf44pH+8wcf72a4t0Ysc7vJQxilK
         Hl4T5aL7VtgJs7d6U9Pxn2qJv5CLSftOz00BGAK1n4KsL8tJAQZxxsGMGv3q2YCjpvpz
         +XbwqR7lSuKtmcXcSdxSQEBY1R5zo7dt9YBy2lOfDBg0Ia+NkByFBrtctiElNChekHoG
         ClDPAVpXx4Na/LXJG0ZYA28j4mROJHCKJjVyrDiVirDlIt0xuVu24IlPh6wY1JnqkcAh
         Izi2j4CKRR68a8Dn2i6km4GJ4AT2dvHdN1WbLUhJjkeQcEnn+ErxWDxkP7EqG9M5btuE
         437w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvrgK3phBe2cb14hN38nY9ORO5qe3i747GjYWn86zZM=;
        b=l023C+XHB+UffRjLGAPVDx9jfLxkoxgXX/doB5QE67rw/k3ZIoUzExkHSmcVhWLEpm
         pMh1a98o7268pnT+ZcdE5UWdmWTdwTKf3APBAQh4+vlGFPKpon4GJWneglt54GqnLsjQ
         sI5PM7Y8xuZfqVJDjUWVHEU0d2sgrIgIrIji6WFGMWu0E38xm9rwZAgraG9uDh1gwRg0
         TciQv3ccB4a3rqQkXKDSRhwj0OyPvAJY90Dym2ztPPLtRL3cg4UeTk4+2QlW+ghZg+mg
         mduNUDN1Hz7rojvJgkzncetqrdyKUf8W/kn9M/t8KdeNm6Ji3AMrtu2YT9Q27G359vgB
         d3sA==
X-Gm-Message-State: APjAAAUtDLWXIbFnqBaxLZK7+tXA0ELgK5rwStsnsZButEqsgo/HeO3+
        0ealBRamry3VJvgbJXAVoISPQQSTaJMlCIUHYTo=
X-Google-Smtp-Source: APXvYqxO+ywLXpeOKdZPLSHew7xIRh/C2hNLXTvfeI3vnxQAmbsHGEhLO7mutWm0X0p+vZKKuFa9YsKSg+9R4ZLDHiI=
X-Received: by 2002:aa7:d6cb:: with SMTP id x11mr21268528edr.85.1554139598870;
 Mon, 01 Apr 2019 10:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com> <1554132731-3095-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554132731-3095-2-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Apr 2019 13:26:02 -0400
Message-ID: <CAF=yD-JpNaEa83cx08vgJ-GV0PimDX=xakDbW=T5AYHjEUXGYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests_bpf: extend test_tc_tunnel for UDP encap
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

> In
>
> commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
>
> ...Willem introduced support to bpf_skb_adjust_room for GSO-friendly

nit: please avoid unnecessary vertical whitespace. Explicit mention of
author is also not very relevant. I suggest "Commit XXX ("..")
introduced support [..]. Here and in other patches.

> GRE and UDP encapsulation and later introduced associated test_tc_tunnel
> tests.  Here those tests are extended to cover UDP encapsulation also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

> -static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
> +static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
>  {
> -       struct grev4hdr h_outer;
>         struct iphdr iph_inner;
> +       struct v4hdr h_outer;
> +       struct udphdr *udph;
>         struct tcphdr tcph;
>         __u64 flags;
>         int olen;
> @@ -70,12 +83,29 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
>         if (tcph.dest != __bpf_constant_htons(cfg_port))
>                 return TC_ACT_OK;
>
> -       flags = BPF_F_ADJ_ROOM_FIXED_GSO | BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;
> -       if (with_gre) {
> -               flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE;
> -               olen = sizeof(h_outer);
> -       } else {
> -               olen = sizeof(h_outer.ip);
> +       olen = sizeof(h_outer.ip);
> +
> +       flags = BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;

Please keep BPF_F_ADJ_ROOM_FIXED_GSO enabled on all variants. Here and in IPv6.

> +       switch (encap_proto) {
> +       case IPPROTO_GRE:
> +               flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE | BPF_F_ADJ_ROOM_FIXED_GSO;
> +               olen += sizeof(h_outer.l4hdr.gre);
> +               h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IP);
> +               h_outer.l4hdr.gre.flags = 0;
> +               break;
> +       case IPPROTO_UDP:
> +               flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
> +               olen += sizeof(h_outer.l4hdr.udp);
> +               h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
> +               h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
> +               h_outer.l4hdr.udp.check = 0;
> +               h_outer.l4hdr.udp.len = bpf_htons(bpf_ntohs(iph_inner.tot_len) +
> +                                                 sizeof(h_outer.l4hdr.udp));
> +               break;
> +       case IPPROTO_IPIP:
> +               break;
> +       default:
> +               return TC_ACT_OK;

> @@ -158,27 +175,46 @@ server_listen
>  # serverside, insert decap module
>  # server is still running
>  # client can connect again
> -ip netns exec "${ns2}" ip link add dev testtun0 type "${tuntype}" \
> -       remote "${addr1}" local "${addr2}"
> -# Because packets are decapped by the tunnel they arrive on testtun0 from
> -# the IP stack perspective.  Ensure reverse path filtering is disabled
> -# otherwise we drop the TCP SYN as arriving on testtun0 instead of the
> -# expected veth2 (veth2 is where 192.168.1.2 is configured).
> -ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
> -# rp needs to be disabled for both all and testtun0 as the rp value is
> -# selected as the max of the "all" and device-specific values.
> -ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.testtun0.rp_filter=0
> -ip netns exec "${ns2}" ip link set dev testtun0 up
> -echo "test bpf encap with tunnel device decap"
> -client_connect
> -verify_data
> +
> +# Skip tunnel tests for ip6udp.  For IPv6, a UDP checksum is required
> +# and there seems to be no way to tell a fou6 tunnel to allow 0
> +# checksums.  Accordingly for both these cases, we skip tests against
> +# tunnel peer, and test encap using BPF decap only.

Checksum should not have to be verified over veth, when packets never
leave the host, of course. Indeed, it is not for unencapsulated or
inner packets. If the checksum has to be verified for upv6/udp
tunnels, it would be interesting to understand why and whether that
can be fixed. Not a prerequisite for this patchset, to be clear.

I assume that this is the udp_lib_checksum_complete(skb) inside the
udpv6_encap_needed_key static branch in udpv6_queue_rcv_one_skb.
Shouldn't skb->ip_summed be CHECKSUM_PARTIAL here? I wonder if
csum_start is now incorrectly set to the outer (tunnel) header, while
it should continue to point to the inner tcp header.

RFC 6935 and 6936 suggest extensions to IPv6 UDP to allow zero
checksum in the narrow case of (some) tunnels. If this use case
matches, I guess it is fine to support the mode even if fou6 decap
does not. But if not, it would be better to make the test more
realistic. For instance by setting up checksumming correctly. Perhaps
with BPF_FUNC_l4_csum_replace or more interestingly by relying on the
properties of local checksum offload to only have to compute a
checksum over the headers (which we can do inline in the program, as
length is fixed).

> +if [[ "$tuntype" != "ip6udp" ]]; then

Irrespective of the details above, can we avoid the code churn from
indentation below. Just run the test as is, but only change the
expectation of error code in client_connect on udp and skip
verify_data on client_connect failure?


> +       if [[ "$tuntype" == "udp" ]]; then
> +               # Set up fou tunnel.
> +               ttype=ipip
> +               targs="encap fou encap-sport auto encap-dport $udpport"
> +               # fou may be a module; allow this to fail.
> +               modprobe fou ||true
> +               ip netns exec "${ns2}" ip fou add port 5555 ipproto "${ipproto}"
> +       else
> +               ttype=$tuntype
> +               targs=""
> +       fi
> +       ip netns exec "${ns2}" ip link add name testtun0 type "${ttype}" \
> +               remote "${addr1}" local "${addr2}" $targs
> +       # Because packets are decapped by the tunnel they arrive on testtun0
> +       # from the IP stack perspective.  Ensure reverse path filtering is
> +       # disabled otherwise we drop the TCP SYN as arriving on testtun0
> +       # instead of the expected veth2 (veth2 is where 192.168.1.2 is
> +       # configured).
> +       ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
> +       # rp needs to be disabled for both all and testtun0 as the rp value is
> +       # selected as the max of the "all" and device-specific values.
> +       ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.testtun0.rp_filter=0
> +       ip netns exec "${ns2}" ip link set dev testtun0 up
> +       echo "test bpf encap with tunnel device decap"
> +       client_connect
> +       verify_data
> +       ip netns exec "${ns2}" ip link del dev testtun0
> +       server_listen
> +fi
>
>  # serverside, use BPF for decap
> -ip netns exec "${ns2}" ip link del dev testtun0
>  ip netns exec "${ns2}" tc qdisc add dev veth2 clsact
>  ip netns exec "${ns2}" tc filter add dev veth2 ingress \
>         bpf direct-action object-file ./test_tc_tunnel.o section decap
> -server_listen
>  echo "test bpf encap with bpf decap"
>  client_connect
>  verify_data
> --
> 1.8.3.1
>
