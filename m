Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76593C282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E7C2077C
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKNSx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDKNSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 09:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAA12308620D;
        Thu, 11 Apr 2019 13:18:52 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA2A85C29A;
        Thu, 11 Apr 2019 13:18:44 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:18:43 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        brouer@redhat.com, Edward Cree <ecree@solarflare.com>
Subject: Re: [PATCH bpf-next 0/5] Bulk optimization for XDP cpumap redirect
Message-ID: <20190411151843.197dfd41@carbon>
In-Reply-To: <CAPhsuW7yYqJwsrk2s5EaZOjhhxa5B0374vJGR4+BBKmh8UCQWg@mail.gmail.com>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
        <CAPhsuW7yYqJwsrk2s5EaZOjhhxa5B0374vJGR4+BBKmh8UCQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 11 Apr 2019 13:18:53 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 16:36:40 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> On Wed, Apr 10, 2019 at 6:00 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > This patchset utilize a number of different kernel bulk APIs for optimizing
> > the performance for the XDP cpumap redirect feature.  
> 
> Could you please share some numbers about the optimization?

I've documented ALL the details here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap02-optimizations.org

I seem to have found that the SKB-list approach is not a performance
advantage, which is very surprising.  BUT it might still be due to
invalid benchmarking, as I found that F27 behind my back is auto-loading
iptables-filter modules, which change performance.  Thus, I have to
redo a lot of the tests...

I'm considering removing the SKB-list patch from the patchset, as all
other patches show a performance increase/improvement.  Then we can
merge that, and then I can focus on SKB-list approach in another
patchset.  BUT as I said above, I might have wrong/invalid
measurements... I have to retest before I concluded anything...

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
