Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1FC282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4CB20663
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoM704Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfDSXum (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:50:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39094 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSXum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 19:50:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so3122538pgj.6;
        Fri, 19 Apr 2019 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7hCxR4Ye1YZdtLVGC544cEdHvKvEn8YKGXp6+i/XOc=;
        b=XoM704BsPOmLKe92OzQBBwiurKYWJQyxMIpTk9jLhW5qXsDBKnsbpGMjusduoQCPZs
         W1LzHZrRz0sG/08SZp8WKK5GVUiPWaHxj+MyK0yWRbezovaooI8Xpoeg37DQnI1VTb0V
         OnEVmWT8RksSDBMGN+BCh7u5ekMEbfvHTUey+Ooduhw7D2//AYoUqGPCxC2xNKwpqjCy
         OHwIpASEXAGjumeq87zKlYIKgvQWQHRKNiPxwQ6hGf2Fr/fwnFCkf+x51G7hIQFdSmny
         BzgaGCzunXryyCL5mKKRCx68lUdx0oTjwbUK4pphnRyZWFVDBVHpHmEG2V4CfeG4XInf
         I19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7hCxR4Ye1YZdtLVGC544cEdHvKvEn8YKGXp6+i/XOc=;
        b=nPWqzc0bWR5/MtyqDul9bnP0/dChqC9miYlO5d5zHpp2atyxkGKEhn/r1jgtHGiO6s
         FYxVjYHdErUm+i7u1z5usD6RtzMnu+016Ikq6qqSzaisDO1TO32alddB6s9vONy1HpuY
         ZIU4otJTKVE0sy8D4EQ21cXtSbtVih1nIyIOEdv3M/YanhoErG8G+/qdl9lMhHb34+tZ
         iCx9e3oDLaOmGrNxVDYbL6CcGt82k2MFVlCoiVvaqS47xE76k0tzdq6DXOvllVOITBm/
         CoCztg+arZ2qdnTsRR8RAVABqHID15PnVAM9dPyRsHxS8xa4HD/LYnzixc9ozxKcok6T
         Isbw==
X-Gm-Message-State: APjAAAUIRLUNBmha8QdAb2FSvKow8cZuJ2LC+Jd7iauA0DaAMsD4J2+K
        BC8ucMxMcrRa/Uz0dPx0Kew=
X-Google-Smtp-Source: APXvYqzfp0AvosOL2Ee2iX231KGORNBc8miWl+82JYEPmfMuF+LuRW0cv78NIyX8TkuLw6iyromnFQ==
X-Received: by 2002:a63:e045:: with SMTP id n5mr6201915pgj.230.1555717841295;
        Fri, 19 Apr 2019 16:50:41 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6f64])
        by smtp.gmail.com with ESMTPSA id m16sm11244436pfi.29.2019.04.19.16.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 16:50:40 -0700 (PDT)
Date:   Fri, 19 Apr 2019 16:50:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
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
Message-ID: <20190419235033.d63h55b6fdgchwz2@ast-mbp.dhcp.thefacebook.com>
References: <20190415173801.257254-1-sdf@google.com>
 <20190415173801.257254-6-sdf@google.com>
 <20190419002851.7efgfnyo3swvtwvo@ast-mbp.dhcp.thefacebook.com>
 <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
 <20190419045026.ayalgmunvizwxc7j@ast-mbp.dhcp.thefacebook.com>
 <20190419232944.GA27730@mini-arch.hsd1.ca.comcast.net>
 <20190419233749.x6ein5ksltfcuarp@ast-mbp.dhcp.thefacebook.com>
 <20190419234744.GB27730@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419234744.GB27730@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 04:47:44PM -0700, Stanislav Fomichev wrote:
> On 04/19, Alexei Starovoitov wrote:
> > On Fri, Apr 19, 2019 at 04:29:44PM -0700, Stanislav Fomichev wrote:
> > > On 04/18, Alexei Starovoitov wrote:
> > > > On Thu, Apr 18, 2019 at 05:43:50PM -0700, Stanislav Fomichev wrote:
> > > > > On 04/18, Alexei Starovoitov wrote:
> > > > > > On Mon, Apr 15, 2019 at 10:38:00AM -0700, Stanislav Fomichev wrote:
> > > > > > > Update all users eth_get_headlen to pass network namespace
> > > > > > > and pass it down to the flow dissector. This commit is a noop
> > > > > > > until administrator inserts BPF flow dissector program.
> > > > > > > 
> > > > > > > Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > > > > > > Cc: Saeed Mahameed <saeedm@mellanox.com>
> > > > > > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > > > > > > Cc: intel-wired-lan@lists.osuosl.org
> > > > > > > Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> > > > > > > Cc: Salil Mehta <salil.mehta@huawei.com>
> > > > > > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > > > > > Cc: Igor Russkikh <igor.russkikh@aquantia.com>
> > > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ... 
> > > > > > Also please add C based test for skb-less flow_dissector.
> > > > > > Current test_flow_dissector.sh doesn't seem to cover it.
> > > > > It doesn't look like we can exercise skb-less flow dissector from
> > > > > test_flow_dissector.sh; we need to trigger some driver code, which is
> > > > > hard when we send the packets on the localhost in
> > > > > test_flow_dissector.sh.
> > > > > 
> > > > > To test skb-less dissector I convert BPF_PROG_TEST_RUN to always use skb-less
> > > > > mode. test_flow_dissector.sh tests skb-mode, prog_tests/flow_dissector.c
> > > > > tests skb-less mode.
> > > > 
> > > > I saw that but I'm afraid it's not enough.
> > > > tun_get_user() is calling it, so it should be possible to test
> > > > skb-less mode via tun.
> > > Spent some time today looking into how to exercise this path in the tun
> > > driver: doing writev() with IFF_NAPI_FRAGS IFF_TAP device would trigger
> > > eth_get_headlen, but it looks like there is no way to do a test with
> > > pass/no-pass result around that.
> > > 
> > > The problem is - we don't actually do anything with the result of
> > > eth_get_headlen, there is only a sanity check for "headlen >
> > > skb_headlen(skb)" which can't trigger for BPF flow dissector; we
> > > carefully clamp thoff/nhoff and should not return offset outside the
> > > input buffer.
> > > 
> > > By reading git history it looks like this call to eth_get_headlen was
> > > added there to only make it possible for tools like syzbot to fuzz flow
> > > dissector. That's why we don't care about the result, we just do that
> > > simple sanity check. The main goal is to trigger some problem
> > > (loop/warning) in the flow dissector code.
> > > 
> > > tl;dr - no mater which bpf flow dissector is attached to the namespace,
> > > it would not change behavior of the tun device; even empty 'return
> > > false' program would not alter it.
> > 
> > sure, but the program will run and the test can validate that the program
> > saw valid packet, parsed it correctly and returned correct dissection.
> > The results can be stored in a map and validated by the test.
> SG, that's doable; that would make bpf_flow.c less generic because it would
> have to have this map which would export the last dissection, but that
> should be fine, I guess.
> 
> (I planned to use bpf_flow.c internally instead of writing another one).
> 
> > iirc you were saying that you'll have one program doing dissection
> > for with-skb and skb-less cases.
> Correct.
> 
> > I think it's important to have such program in selftests and being
> > run continuously for both cases.
> Ok, in this case, I can write a small userspace program that writes some
> dummy packet into a tap device (triggers eth_get_headlen) and reads back
> and verifies bpf_flow_keys from the shared map.

that sounds good. there could be two test programs. bpf_flow.c that you
use internally and another one, but please make that other one to test
both with-skb and skb-less paths.

