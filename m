Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB5C282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784EA20663
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="gtcZZupI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfDSXrt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:47:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37451 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDSXrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 19:47:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so3144655pfr.4
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JqU8KH70MuJWP7eyTCnR8HmwOYo2jRZ2PSnfqIHcWTs=;
        b=gtcZZupIkhPc2kGrvGMENpDyD3pNcLl8MRwvIQ84yzZ++3mrEv3SUk2af6xJJqFdHY
         vJmmAOMo9MqLH+0n7HeHZ6i4cR0AxNcP61VYIOworEFdGgAxV6AXsU1YkYm2qZyuYcta
         le2kznowTwECe96bEosNMytgWoJycX/5PVz1IZf4umjjxkxajJrvH3G3KhrPreQxkdSE
         rV6U7D5ERNJHmdKs0wAL11anFumM+fv4erLBAbqJN35OZNWi26J3qV+9z3Cp78BXpQRr
         9qIPJYyglonvoljfiav5O+xHhm6bUPFtnzsVqsOnGGYWt/hKyxzjH2HNx8lVeNKYjPHh
         ZYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqU8KH70MuJWP7eyTCnR8HmwOYo2jRZ2PSnfqIHcWTs=;
        b=WWybvFDcVuo71mrYf7xjE/0Y3mEO3IC+XxiJ0uovrMQoq5zDAQ1MB/mqZa91gokZLg
         byCeqz+LvEWyqsHzMhEAABLui8iX1l0pqYOVIOdWorO6LbUCUrlZGNQvfmiLGHLCpIFH
         G1Pon3/ay8wIh+UlAVBVzJDPNlwzjLo4rOIdSWBNZKSUchWTA8YAab+hhH7nMrlUb4ux
         SEiixPBUx2poTahYvvIQ4DWWlxiv7BPS31Ughic31TO4v9NQAZKB8IlXhFQn2DD3kX8X
         FRY4NSoYUrEXa1+lkdWqOQOmgbSLTijisNhC9gLO+TD0E3RZNrudf4B+2JsrAAuIYOMV
         u96Q==
X-Gm-Message-State: APjAAAVpmtzbM+buBSqPNfPvf4tGtncLuBkr6S9ouH9ewoNKpGizVUF8
        er5YoFuj2YbkffvrTLuNPu8PXw==
X-Google-Smtp-Source: APXvYqxi4oMTksQqA2fSEIE0hOP1sIdRis0s2Pl8dARyOIRHvmmHZ0X3jCLltY04YG5m55XGmsFpZQ==
X-Received: by 2002:a62:a219:: with SMTP id m25mr6791352pff.197.1555717665976;
        Fri, 19 Apr 2019 16:47:45 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d8sm6318235pgv.34.2019.04.19.16.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 16:47:45 -0700 (PDT)
Date:   Fri, 19 Apr 2019 16:47:44 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>
Subject: Re: [PATCH bpf-next v5 5/6] net: pass net argument to the
 eth_get_headlen
Message-ID: <20190419234744.GB27730@mini-arch.hsd1.ca.comcast.net>
References: <20190415173801.257254-1-sdf@google.com>
 <20190415173801.257254-6-sdf@google.com>
 <20190419002851.7efgfnyo3swvtwvo@ast-mbp.dhcp.thefacebook.com>
 <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
 <20190419045026.ayalgmunvizwxc7j@ast-mbp.dhcp.thefacebook.com>
 <20190419232944.GA27730@mini-arch.hsd1.ca.comcast.net>
 <20190419233749.x6ein5ksltfcuarp@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419233749.x6ein5ksltfcuarp@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/19, Alexei Starovoitov wrote:
> On Fri, Apr 19, 2019 at 04:29:44PM -0700, Stanislav Fomichev wrote:
> > On 04/18, Alexei Starovoitov wrote:
> > > On Thu, Apr 18, 2019 at 05:43:50PM -0700, Stanislav Fomichev wrote:
> > > > On 04/18, Alexei Starovoitov wrote:
> > > > > On Mon, Apr 15, 2019 at 10:38:00AM -0700, Stanislav Fomichev wrote:
> > > > > > Update all users eth_get_headlen to pass network namespace
> > > > > > and pass it down to the flow dissector. This commit is a noop
> > > > > > until administrator inserts BPF flow dissector program.
> > > > > > 
> > > > > > Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > > > > > Cc: Saeed Mahameed <saeedm@mellanox.com>
> > > > > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > > > > > Cc: intel-wired-lan@lists.osuosl.org
> > > > > > Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> > > > > > Cc: Salil Mehta <salil.mehta@huawei.com>
> > > > > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > > > > Cc: Igor Russkikh <igor.russkikh@aquantia.com>
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ... 
> > > > > Also please add C based test for skb-less flow_dissector.
> > > > > Current test_flow_dissector.sh doesn't seem to cover it.
> > > > It doesn't look like we can exercise skb-less flow dissector from
> > > > test_flow_dissector.sh; we need to trigger some driver code, which is
> > > > hard when we send the packets on the localhost in
> > > > test_flow_dissector.sh.
> > > > 
> > > > To test skb-less dissector I convert BPF_PROG_TEST_RUN to always use skb-less
> > > > mode. test_flow_dissector.sh tests skb-mode, prog_tests/flow_dissector.c
> > > > tests skb-less mode.
> > > 
> > > I saw that but I'm afraid it's not enough.
> > > tun_get_user() is calling it, so it should be possible to test
> > > skb-less mode via tun.
> > Spent some time today looking into how to exercise this path in the tun
> > driver: doing writev() with IFF_NAPI_FRAGS IFF_TAP device would trigger
> > eth_get_headlen, but it looks like there is no way to do a test with
> > pass/no-pass result around that.
> > 
> > The problem is - we don't actually do anything with the result of
> > eth_get_headlen, there is only a sanity check for "headlen >
> > skb_headlen(skb)" which can't trigger for BPF flow dissector; we
> > carefully clamp thoff/nhoff and should not return offset outside the
> > input buffer.
> > 
> > By reading git history it looks like this call to eth_get_headlen was
> > added there to only make it possible for tools like syzbot to fuzz flow
> > dissector. That's why we don't care about the result, we just do that
> > simple sanity check. The main goal is to trigger some problem
> > (loop/warning) in the flow dissector code.
> > 
> > tl;dr - no mater which bpf flow dissector is attached to the namespace,
> > it would not change behavior of the tun device; even empty 'return
> > false' program would not alter it.
> 
> sure, but the program will run and the test can validate that the program
> saw valid packet, parsed it correctly and returned correct dissection.
> The results can be stored in a map and validated by the test.
SG, that's doable; that would make bpf_flow.c less generic because it would
have to have this map which would export the last dissection, but that
should be fine, I guess.

(I planned to use bpf_flow.c internally instead of writing another one).

> iirc you were saying that you'll have one program doing dissection
> for with-skb and skb-less cases.
Correct.

> I think it's important to have such program in selftests and being
> run continuously for both cases.
Ok, in this case, I can write a small userspace program that writes some
dummy packet into a tap device (triggers eth_get_headlen) and reads back
and verifies bpf_flow_keys from the shared map.

Correct me if I misunderstood something. Otherwise, I'll get back to you
with a v6+test.
