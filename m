Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50232C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E4F2075B
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 16:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqsDGCVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfDOQZq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:25:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46602 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOQZq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 12:25:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so19754346qts.13;
        Mon, 15 Apr 2019 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPdhkUr074MC9RdjuT5t9efwWVQ25GdUm/04qU+gvV8=;
        b=WqsDGCVFUGZw2clnaIVR5VGA6neuvelgErEQ+oxovNjYlGH801M3C7v0PolbPvMwd3
         QJUJySWoNrd1vGD394VY4hL0k+5tybAWeNz9e5wALqU2EBsHuQFIzK/tRfa+ABmupkL7
         eA7cF6RSu5A3ah4gpk2L5i5qqUAe812MIh3Tk3h/N2QPUJC7qGM0lNCOLuCyTtBQYMzf
         VprYL5KtfbFGZykEw/Y6BnJSuPsVw2x444KoEg3cK7EDQvrUXJ44rr7IQZuQ1SiK0Dge
         MGvoMwnlQAfqnOY8M11Wgw67Wm0MfAmc60Eu9KCaK2zr12KTUXFLDTWjd9VcGeuTDGoY
         cBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPdhkUr074MC9RdjuT5t9efwWVQ25GdUm/04qU+gvV8=;
        b=hZ9nbONQttmgHG+LESaz2vLFJRm8AHovhWBOghWYa82ZMGVUBLmY8Kg6nLaXQyGFeM
         Hd0WFcGHibh+tdrTanvg1lDWOOOnuLx2QWteuMgFsnbp8Q5MHP28DYJDqQ26uwF2IViD
         uUfY/9d9mYcbsIi8x3vfBzNjqvSVN05/ffYzkffcz/yPdJwxiRNBfvoyvoD05GL8dojh
         djM21t/4f7FDRkvsineMjcoxUUH+vdgSfb0JVFel/lGavD4Q9BmerLfWjpy7RQVw8f07
         zKbO5QavAn/RenqXL0TRgt8c4TkPXo1jp8z/B1dtzgNBgcBkCkXAsEQRnBIahcSdFiXF
         j3Qw==
X-Gm-Message-State: APjAAAVXdlIrpbsL9DEkN5voCAzxo8CnHvK1r9Y2cf5Yx3bktOQuW6t0
        nZA8e+7stMt5hpaWxBDNEJMZPa4jc+c7iid55INqE5Ww
X-Google-Smtp-Source: APXvYqwtwxwO2jqHoGvp9BN1VVfnJo37kzJi1TV7tEDuBnMQgxefFA0hQW/WRQjUHII6VlHh8Eh9E2a+yKBImUcEwn8=
X-Received: by 2002:ac8:1876:: with SMTP id n51mr60651238qtk.234.1555345545335;
 Mon, 15 Apr 2019 09:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190412234310.174978-1-sdf@google.com>
In-Reply-To: <20190412234310.174978-1-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 15 Apr 2019 09:25:34 -0700
Message-ID: <CAPhsuW497kCk3knUgjER2YkbmRF1jdVduudxJ7DYfhGHaYeU8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make flow dissector tests more extensible
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 4:43 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Rewrite selftest to iterate over an array with input packet and
> expected flow_keys. This should make it easier to extend this test
> with additional cases without too much boilerplate.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  .../selftests/bpf/prog_tests/flow_dissector.c | 197 +++++++++++-------
>  1 file changed, 116 insertions(+), 81 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> index fc818bc1d729..1a73937826b0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> @@ -2,7 +2,7 @@
>  #include <test_progs.h>
>
>  #define CHECK_FLOW_KEYS(desc, got, expected)                           \
> -       CHECK(memcmp(&got, &expected, sizeof(got)) != 0,                \
> +       CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,           \
>               desc,                                                     \
>               "nhoff=%u/%u "                                            \
>               "thoff=%u/%u "                                            \
> @@ -10,6 +10,7 @@
>               "is_frag=%u/%u "                                          \
>               "is_first_frag=%u/%u "                                    \
>               "is_encap=%u/%u "                                         \
> +             "ip_proto=0x%x/0x%x "                                     \
>               "n_proto=0x%x/0x%x "                                      \
>               "sport=%u/%u "                                            \
>               "dport=%u/%u\n",                                          \
> @@ -19,53 +20,32 @@
>               got.is_frag, expected.is_frag,                            \
>               got.is_first_frag, expected.is_first_frag,                \
>               got.is_encap, expected.is_encap,                          \
> +             got.ip_proto, expected.ip_proto,                          \
>               got.n_proto, expected.n_proto,                            \
>               got.sport, expected.sport,                                \
>               got.dport, expected.dport)
>
> -static struct bpf_flow_keys pkt_v4_flow_keys = {
> -       .nhoff = 0,
> -       .thoff = sizeof(struct iphdr),
> -       .addr_proto = ETH_P_IP,
> -       .ip_proto = IPPROTO_TCP,
> -       .n_proto = __bpf_constant_htons(ETH_P_IP),
> -};
> -
> -static struct bpf_flow_keys pkt_v6_flow_keys = {
> -       .nhoff = 0,
> -       .thoff = sizeof(struct ipv6hdr),
> -       .addr_proto = ETH_P_IPV6,
> -       .ip_proto = IPPROTO_TCP,
> -       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> -};
> -
> -#define VLAN_HLEN      4
> +struct ipv4_pkt {
> +       struct ethhdr eth;
> +       struct iphdr iph;
> +       struct tcphdr tcp;
> +} __packed;
>
> -static struct {
> +struct svlan_ipv4_pkt {
>         struct ethhdr eth;
>         __u16 vlan_tci;
>         __u16 vlan_proto;
>         struct iphdr iph;
>         struct tcphdr tcp;
> -} __packed pkt_vlan_v4 = {
> -       .eth.h_proto = __bpf_constant_htons(ETH_P_8021Q),
> -       .vlan_proto = __bpf_constant_htons(ETH_P_IP),
> -       .iph.ihl = 5,
> -       .iph.protocol = IPPROTO_TCP,
> -       .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> -       .tcp.urg_ptr = 123,
> -       .tcp.doff = 5,
> -};
> +} __packed;
>
> -static struct bpf_flow_keys pkt_vlan_v4_flow_keys = {
> -       .nhoff = VLAN_HLEN,
> -       .thoff = VLAN_HLEN + sizeof(struct iphdr),
> -       .addr_proto = ETH_P_IP,
> -       .ip_proto = IPPROTO_TCP,
> -       .n_proto = __bpf_constant_htons(ETH_P_IP),
> -};
> +struct ipv6_pkt {
> +       struct ethhdr eth;
> +       struct ipv6hdr iph;
> +       struct tcphdr tcp;
> +} __packed;
>
> -static struct {
> +struct dvlan_ipv6_pkt {
>         struct ethhdr eth;
>         __u16 vlan_tci;
>         __u16 vlan_proto;
> @@ -73,31 +53,97 @@ static struct {
>         __u16 vlan_proto2;
>         struct ipv6hdr iph;
>         struct tcphdr tcp;
> -} __packed pkt_vlan_v6 = {
> -       .eth.h_proto = __bpf_constant_htons(ETH_P_8021AD),
> -       .vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
> -       .vlan_proto2 = __bpf_constant_htons(ETH_P_IPV6),
> -       .iph.nexthdr = IPPROTO_TCP,
> -       .iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> -       .tcp.urg_ptr = 123,
> -       .tcp.doff = 5,
> +} __packed;
> +
> +struct test {
> +       const char *name;
> +       union {
> +               struct ipv4_pkt ipv4;
> +               struct svlan_ipv4_pkt svlan_ipv4;
> +               struct ipv6_pkt ipv6;
> +               struct dvlan_ipv6_pkt dvlan_ipv6;
> +       } pkt;
> +       struct bpf_flow_keys keys;
>  };
>
> -static struct bpf_flow_keys pkt_vlan_v6_flow_keys = {
> -       .nhoff = VLAN_HLEN * 2,
> -       .thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
> -       .addr_proto = ETH_P_IPV6,
> -       .ip_proto = IPPROTO_TCP,
> -       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> +#define VLAN_HLEN      4
> +
> +struct test tests[] = {
> +       {
> +               .name = "ipv4",
> +               .pkt.ipv4 = {
> +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IP),
> +                       .iph.ihl = 5,
> +                       .iph.protocol = IPPROTO_TCP,
> +                       .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> +                       .tcp.doff = 5,
> +               },
> +               .keys = {
> +                       .nhoff = 0,
> +                       .thoff = sizeof(struct iphdr),
> +                       .addr_proto = ETH_P_IP,
> +                       .ip_proto = IPPROTO_TCP,
> +                       .n_proto = __bpf_constant_htons(ETH_P_IP),
> +               },
> +       },
> +       {
> +               .name = "ipv6",
> +               .pkt.ipv6 = {
> +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
> +                       .iph.nexthdr = IPPROTO_TCP,
> +                       .iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> +                       .tcp.doff = 5,
> +               },
> +               .keys = {
> +                       .nhoff = 0,
> +                       .thoff = sizeof(struct ipv6hdr),
> +                       .addr_proto = ETH_P_IPV6,
> +                       .ip_proto = IPPROTO_TCP,
> +                       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> +               },
> +       },
> +       {
> +               .name = "802.1q-ipv4",
> +               .pkt.svlan_ipv4 = {
> +                       .eth.h_proto = __bpf_constant_htons(ETH_P_8021Q),
> +                       .vlan_proto = __bpf_constant_htons(ETH_P_IP),
> +                       .iph.ihl = 5,
> +                       .iph.protocol = IPPROTO_TCP,
> +                       .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> +                       .tcp.doff = 5,
> +               },
> +               .keys = {
> +                       .nhoff = VLAN_HLEN,
> +                       .thoff = VLAN_HLEN + sizeof(struct iphdr),
> +                       .addr_proto = ETH_P_IP,
> +                       .ip_proto = IPPROTO_TCP,
> +                       .n_proto = __bpf_constant_htons(ETH_P_IP),
> +               },
> +       },
> +       {
> +               .name = "802.1ad-ipv6",
> +               .pkt.dvlan_ipv6 = {
> +                       .eth.h_proto = __bpf_constant_htons(ETH_P_8021AD),
> +                       .vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
> +                       .vlan_proto2 = __bpf_constant_htons(ETH_P_IPV6),
> +                       .iph.nexthdr = IPPROTO_TCP,
> +                       .iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> +                       .tcp.doff = 5,
> +               },
> +               .keys = {
> +                       .nhoff = VLAN_HLEN * 2,
> +                       .thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
> +                       .addr_proto = ETH_P_IPV6,
> +                       .ip_proto = IPPROTO_TCP,
> +                       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> +               },
> +       },
>  };
>
>  void test_flow_dissector(void)
>  {
> -       struct bpf_flow_keys flow_keys;
>         struct bpf_object *obj;
> -       __u32 duration, retval;
>         int err, prog_fd;
> -       __u32 size;
>
>         err = bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
>                             "jmp_table", &prog_fd);
> @@ -106,35 +152,24 @@ void test_flow_dissector(void)
>                 return;
>         }
>
> -       err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
> -                               &flow_keys, &size, &retval, &duration);
> -       CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv4",
> -             "err %d errno %d retval %d duration %d size %u/%lu\n",
> -             err, errno, retval, duration, size, sizeof(flow_keys));
> -       CHECK_FLOW_KEYS("ipv4_flow_keys", flow_keys, pkt_v4_flow_keys);
> -
> -       err = bpf_prog_test_run(prog_fd, 10, &pkt_v6, sizeof(pkt_v6),
> -                               &flow_keys, &size, &retval, &duration);
> -       CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv6",
> -             "err %d errno %d retval %d duration %d size %u/%lu\n",
> -             err, errno, retval, duration, size, sizeof(flow_keys));
> -       CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
> +       for (int i = 0; i < ARRAY_SIZE(tests); i++) {
> +               struct bpf_flow_keys flow_keys;
> +               struct bpf_prog_test_run_attr tattr = {
> +                       .prog_fd = prog_fd,
> +                       .data_in = &tests[i].pkt,
> +                       .data_size_in = sizeof(tests[i].pkt),
> +                       .data_out = &flow_keys,
> +               };
>
> -       err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v4, sizeof(pkt_vlan_v4),
> -                               &flow_keys, &size, &retval, &duration);
> -       CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv4",
> -             "err %d errno %d retval %d duration %d size %u/%lu\n",
> -             err, errno, retval, duration, size, sizeof(flow_keys));
> -       CHECK_FLOW_KEYS("vlan_ipv4_flow_keys", flow_keys,
> -                       pkt_vlan_v4_flow_keys);
> -
> -       err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v6, sizeof(pkt_vlan_v6),
> -                               &flow_keys, &size, &retval, &duration);
> -       CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv6",
> -             "err %d errno %d retval %d duration %d size %u/%lu\n",
> -             err, errno, retval, duration, size, sizeof(flow_keys));
> -       CHECK_FLOW_KEYS("vlan_ipv6_flow_keys", flow_keys,
> -                       pkt_vlan_v6_flow_keys);
> +               err = bpf_prog_test_run_xattr(&tattr);
> +               CHECK_ATTR(tattr.data_size_out != sizeof(flow_keys) ||
> +                          err || tattr.retval != 1,
> +                          tests[i].name,
> +                          "err %d errno %d retval %d duration %d size %u/%lu\n",
> +                          err, errno, tattr.retval, tattr.duration,
> +                          tattr.data_size_out, sizeof(flow_keys));
> +               CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
> +       }
>
>         bpf_object__close(obj);
>  }
> --
> 2.21.0.392.gf8f6787159e-goog
>
