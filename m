Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3123C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A32084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDKLXq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDKLXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 07:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDA673082E03;
        Thu, 11 Apr 2019 11:23:45 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEC0C60BF7;
        Thu, 11 Apr 2019 11:23:40 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:23:39 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        brouer@redhat.com
Subject: Re: [PATCH bpf-next 1/5] bpf: cpumap use ptr_ring_consume_batched
Message-ID: <20190411132339.5427313b@carbon>
In-Reply-To: <CAPhsuW5FQ_npvmCUSfDKUXFj_vXF4OVk34EKqHJXZtu5eYwF2Q@mail.gmail.com>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
        <155489661778.20826.7424374812567038804.stgit@firesoul>
        <CAPhsuW5FQ_npvmCUSfDKUXFj_vXF4OVk34EKqHJXZtu5eYwF2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 11 Apr 2019 11:23:45 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 16:24:37 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> >                 /* Feedback loop via tracepoint */
> > -               trace_xdp_cpumap_kthread(rcpu->map_id, processed, drops, sched);
> > +               trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);  
> 
> btw: can we do the tracepoint after local_bh_enable()?

I would rather not, as my experience is that this result in strange
inaccurate readings, because (as comment below says) this is a
CPU-process-reschedule point.  The test tool reads these values and
calculate PPS.

> >
> >                 local_bh_enable(); /* resched point, may call do_softirq() */
> >         }

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
