Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A0C10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BCC20855
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3QzgU9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDHTIN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:08:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37026 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDHTIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 15:08:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id l20so5211001edv.4;
        Mon, 08 Apr 2019 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmjbhlLgAtmzP1Dxogx/hNBE0FbeYdSQl1RL+p70dh8=;
        b=B3QzgU9LyIVNFP7mHL6+lVunQLqsetCGVV+dv6068StgtpQabUKhBFYVow36//u3CL
         3Elm7qD9ebtWnPBiuIzxPa/GoPEVGg10cT5nEUtxyDMD1AjbSwzaQxkB0ywFAT52/naG
         +uqN/DPWNbUlq+62TW8WdiwngaRHGT6uArboXh5gNDXh2DCwo5e+jr3yx9mm5GKl5fZn
         KQMqsjoJIdTquI8OCoxzjMSUGXVnaVt8cDo9dqk0JDMqd2CVROanEeiJnDkMVprIBoRq
         Txk8swaQqtLtozPv9YP3DzU4QYEf3WmsUpwNKfMkCNFJfo+zQ34t9qdQyBe53D/i4pkQ
         8bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmjbhlLgAtmzP1Dxogx/hNBE0FbeYdSQl1RL+p70dh8=;
        b=Njw0HRrzuFQMR//wLxKAx2ahrsAIxuGnsjm7JUQMwMPoF3crj3sDYpPzPCKhwk+zCP
         kxBLn/6KzhhEv9GZFdP+vo1uZ0ghiNLGuCjwoWxyCDR8gvzOQiNmXXBBQEHBnrxB5IQr
         VzRXDMBe3bD9+uO/rXpZvZhBKC6ABhBL7i+mBSEMse/O9MrHkdVj7JWfv5SUoCPlJMVa
         YtxX+ebSSQO9SyluyFDBS1Qf4FL2JxdbILNXswn2NUa95NMCbwVHSC5UHXgPF6TEhgww
         oPJv68Qj8b49VCFNYIoaNHhgTtXiUgsUT51Xh9Xql6cTqs4W1NahJ6V019wMuqGnIw87
         bNHw==
X-Gm-Message-State: APjAAAVMgPWjuRBQVrYTpAZF2A3AZh/God6NqJICvzs4VKxMEAgWJDx/
        VACURCtg+JyD039OGau5hIuAxgP7vEEWtE2ltDg=
X-Google-Smtp-Source: APXvYqy2fEFS9lSrXa8VfNdMFsvwk2Rqh9GE/67AWepGLgK2/OxB3n7ruOM9fdKUiO6+IOU1bBnYs+ENNg1vKP3Rde0=
X-Received: by 2002:a50:ee11:: with SMTP id g17mr12363975eds.102.1554750491306;
 Mon, 08 Apr 2019 12:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com> <1554742668-28313-5-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554742668-28313-5-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Apr 2019 15:07:35 -0400
Message-ID: <CAF=yD-+AR7567TotUCO1y0Ch3TRw8mOV63zqXK4DXxP3YTUirA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests_bpf: add L2 encap to test_tc_tunnel
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
> Update test_tc_tunnel to verify adding inner L2 header
> encapsulation (an MPLS label or ethernet header) works.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

>  static const int cfg_udp_src = 20000;
>  static const int cfg_udp_dst = 5555;
> +/* MPLSoverUDP */
> +#define MPLS_OVER_UDP_PORT 6635
> +static const int cfg_mplsudp_dst = MPLS_OVER_UDP_PORT;
> +#define        ETH_OVER_UDP_PORT 7777
> +static const int cfg_ethudp_dst = ETH_OVER_UDP_PORT;

nit: static const variables not really needed if duplicating the macro.


> -static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
> +static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> +                                     __u16 l2_proto)
>  {
> +       __u32 udp_dst = cfg_udp_dst;

nit: __u16 (as in encap_ipv6)

> -static int decap_ipv4(struct __sk_buff *skb)
> +static __always_inline int decap_ipv4(struct __sk_buff *skb)

unnecessary change? also for decap_ipv6

> +elif [[ "$mac" == "mpls" ]]; then
> +       modprobe mpls_iptunnel ||true
> +       modprobe mpls_gso ||true

this requires adding CONFIG_MPLS and CONFIG_MPLS_IPTUNNEL to
tools/testing/selftests/bpf/config


> +       ip netns exec "${ns2}" sysctl -qw net.mpls.platform_labels=65536
> +       ip netns exec "${ns2}" ip -f mpls route add 1000 dev lo
> +       ip netns exec "${ns2}" ip link set lo up
> +       ip netns exec "${ns2}" sysctl -qw net.mpls.conf.testtun0.input=1
> +       ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.lo.rp_filter=0
> +fi
