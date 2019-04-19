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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A1C282DA
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81E220663
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4AK3XC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfDSSzT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39712 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbfDSSzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id e92so1186182plb.6;
        Fri, 19 Apr 2019 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MOI0el+WCM+k0jaNElx1lOnObArB9OosKrYtHOAeyks=;
        b=P4AK3XC70vzjtft4P4Ee5QFnw3RW+oFs8qngOpwOzgXWeynFkRKdMv/4WcpazeYGt4
         QctcSi74dcD5e0CVw5Cxd8C76g5dLNrsfH7KDYhq3mkbTcnnIWap7yv9+WESuLGSM46i
         r6TMbhzzxZs4t5azi+s3BUlgCuN/8ATsHQi6Lj3chemVGsUexnZ4vcaHw+G8va54GyWA
         fJfhXyziOzZA/7QLdl/iPGdaZ+eb2ZFy9O7uvrk+Mc+hTpflfYFdYP53yYmksOkRE821
         G4FvteoLmGhyoYJD9a0tsubBjKLW/xugIhjm89hxg+6/d12AVjFUmprTE5nH2ONnhSQJ
         xMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MOI0el+WCM+k0jaNElx1lOnObArB9OosKrYtHOAeyks=;
        b=eh29BsUpkdErodeuAOqzkGy83mHf7SAprHsbtBTEsgR3czEKH2hX2TVsmnUbsG4e3V
         E2+sgMLYe6ueUjxbNiBwkXYGfvLEwcbH7URL/nj1GTEdscrdLZj+1PUN9GKWy3OePhzF
         sKnJ25IkgaTKb2AyfErxU+Zjo/DJOn4J+44dGla4WnZbsQAnfE/z0f77dH5SiEGe3whG
         bGPqC7bHAcKb2FxJnfiZQS7E/CQJBtQ5cV8KrcCx69yYtQSeeHrJKtLguESNzxhEHaGB
         t5/EDeqBU/FL8ER8PlQkxFKC7BHWSW1Usdn7nGXLWt0CO7emfSH5zV8ar9/MeP3I1C2i
         wLkw==
X-Gm-Message-State: APjAAAX/iyZo+GfiyWD+oKDzItStCq/1VpxhimCefpS5BO0Rhe1Nxyz1
        pruiFR2dCvtl78bgWI8eQxBWbVyS
X-Google-Smtp-Source: APXvYqy4ZcSZ7rUYr5N3RTOQd4X+B/NSoQ2ZfnXMFUDFNKneUyM4mFfoRm0IpLhx9dwpaKxKi4dtBg==
X-Received: by 2002:a17:902:7794:: with SMTP id o20mr1635537pll.189.1555649431428;
        Thu, 18 Apr 2019 21:50:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::78c8])
        by smtp.gmail.com with ESMTPSA id l88sm6550433pfb.104.2019.04.18.21.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 21:50:30 -0700 (PDT)
Date:   Thu, 18 Apr 2019 21:50:28 -0700
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
Message-ID: <20190419045026.ayalgmunvizwxc7j@ast-mbp.dhcp.thefacebook.com>
References: <20190415173801.257254-1-sdf@google.com>
 <20190415173801.257254-6-sdf@google.com>
 <20190419002851.7efgfnyo3swvtwvo@ast-mbp.dhcp.thefacebook.com>
 <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 05:43:50PM -0700, Stanislav Fomichev wrote:
> On 04/18, Alexei Starovoitov wrote:
> > On Mon, Apr 15, 2019 at 10:38:00AM -0700, Stanislav Fomichev wrote:
> > > Update all users eth_get_headlen to pass network namespace
> > > and pass it down to the flow dissector. This commit is a noop
> > > until administrator inserts BPF flow dissector program.
> > > 
> > > Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > > Cc: Saeed Mahameed <saeedm@mellanox.com>
> > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > > Cc: intel-wired-lan@lists.osuosl.org
> > > Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> > > Cc: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > Cc: Igor Russkikh <igor.russkikh@aquantia.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
... 
> > Also please add C based test for skb-less flow_dissector.
> > Current test_flow_dissector.sh doesn't seem to cover it.
> It doesn't look like we can exercise skb-less flow dissector from
> test_flow_dissector.sh; we need to trigger some driver code, which is
> hard when we send the packets on the localhost in
> test_flow_dissector.sh.
> 
> To test skb-less dissector I convert BPF_PROG_TEST_RUN to always use skb-less
> mode. test_flow_dissector.sh tests skb-mode, prog_tests/flow_dissector.c
> tests skb-less mode.

I saw that but I'm afraid it's not enough.
tun_get_user() is calling it, so it should be possible to test
skb-less mode via tun.

