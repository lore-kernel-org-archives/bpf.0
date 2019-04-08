Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E2C10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E9920855
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3/aPqSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDHTIV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:08:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43532 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDHTIV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 15:08:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id w3so3516918edu.10;
        Mon, 08 Apr 2019 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHMi88D2v1B5AmHQAeMCsiHHeSRu6NnP/K0z8Ect5+0=;
        b=Z3/aPqSxxNLCV8Si5b9ZSZw6i4MYvhCIxmBvyoLq26Db3Z86ke+6Ct4n+LsJp5MBX8
         VjhIUAEmdjMUifrrRZ8+Sx9yxi4Bz+VNv53zNj05ggfo48FyCbaVpjsXbChYyj+3NRsV
         Lo4xzuxximUL7Qtw/yifT02ylacSijk7RIuD+BtaD4n0BlowYzLlccmKGTYhkBrM8Y9/
         oNF3qf/ey2hjvBMJRJd5OUCHSgJngkH/ST0gjcO48r9M9mgOk43vKmNivWCeflFzE2L2
         NR5EBlXzpuQAGQ/HujYhHuVL5/m5LPXrz5cz/QsjPoJc2pBb3NiJ5aPouY5Q1CMbP+2m
         FnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHMi88D2v1B5AmHQAeMCsiHHeSRu6NnP/K0z8Ect5+0=;
        b=i7Ng9AHP3cAivTROj8F6CMNZRJsRBFKqGOr+ue+bH0sCyIx/gvn9H/o3lTpExSQ4P0
         HWYWpuWm0LfyTNllKvwj8u15zm2dyZtRsP9zwli+cJ06iGHo812h1Bdnshz/HoGTGFHa
         LnS5QNI1COuoVUH3XLtbNP3kwrqli5h7uBTDNlJll6IhMe2m8mdh+WK5pijASHKO+HS6
         uGvkHyjoCPsK+Sy+PVv/ROwpiOVZpQOlZYAf5HTx0gVxOjpkUN3ofp1xKYn9+h9DzYrU
         p+q32nkVkeQFxo5Q8uy3E6mPXXBwJiO/FcpLTnblko+C/DxpHnYlezUgD2Rghhb7sdso
         zfVA==
X-Gm-Message-State: APjAAAXxXZFsM2j8ehfaPOvwtkeRkTKTUE6BSZDo4zXO4A/tUj4TK2TS
        pWCyyMcoIbvDQvxVirSrP8wHtezj6IvUKQch7sY=
X-Google-Smtp-Source: APXvYqyofdfLPd3rDaVzlo+O+47xoCi9VENA3FNkc9BAqLHoK8tklzi8zP5AiAMSqe3poFgH6l62iCFWrR2sIPs8Res=
X-Received: by 2002:a17:906:598:: with SMTP id 24mr17907758ejn.41.1554750499326;
 Mon, 08 Apr 2019 12:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com> <1554742668-28313-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554742668-28313-2-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Apr 2019 15:07:43 -0400
Message-ID: <CAF=yD-KkWQJDrjRH1mS0KcaWPANJ_Twwmhs-2R+=V2fMNj=0VA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] selftests_bpf: add UDP encap to test_tc_tunnel
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

On Mon, Apr 8, 2019 at 1:01 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
> introduced support to bpf_skb_adjust_room for GSO-friendly GRE
> and UDP encapsulation and later introduced associated test_tc_tunnel
> tests.  Here those tests are extended to cover UDP encapsulation also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

> +       struct v4hdr h_outer;
> +       struct udphdr *udph;

nit: unused?

>  # serverside, insert decap module
>  # server is still running
>  # client can connect again
> -ip netns exec "${ns2}" ip link add dev testtun0 type "${tuntype}" \
> -       remote "${addr1}" local "${addr2}"
> -# Because packets are decapped by the tunnel they arrive on testtun0 from
> -# the IP stack perspective.  Ensure reverse path filtering is disabled
> -# otherwise we drop the TCP SYN as arriving on testtun0 instead of the
> -# expected veth2 (veth2 is where 192.168.1.2 is configured).
> +
> +if [[ "$tuntype" =~ "udp" ]]; then
> +       # Set up fou tunnel.
> +       ttype="${foutype}"
> +       targs="encap fou encap-sport auto encap-dport $udpport"
> +       # fou may be a module; allow this to fail.
> +       modprobe "${foumod}" ||true
> +       ip netns exec "${ns2}" ip fou add port 5555 ipproto ${fouproto}
> +else
> +       ttype=$tuntype
> +       targs=""
> +fi
> +ip netns exec "${ns2}" ip link add name testtun0 type "${ttype}" \
> +       remote "${addr1}" local "${addr2}" $targs
> +# Because packets are decapped by the tunnel they arrive on testtun0
> +# from the IP stack perspective.  Ensure reverse path filtering is
> +# disabled otherwise we drop the TCP SYN as arriving on testtun0
> +# instead of the expected veth2 (veth2 is where 192.168.1.2 is
> +# configured).

nit: these lines are not really part of the change

>  ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
>  # rp needs to be disabled for both all and testtun0 as the rp value is
>  # selected as the max of the "all" and device-specific values.
> @@ -172,13 +208,13 @@ ip netns exec "${ns2}" ip link set dev testtun0 up
>  echo "test bpf encap with tunnel device decap"
>  client_connect
>  verify_data
> +ip netns exec "${ns2}" ip link del dev testtun0
>
> +server_listen
>  # serverside, use BPF for decap
> -ip netns exec "${ns2}" ip link del dev testtun0

nit: not needed to move this outside of this block.


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
