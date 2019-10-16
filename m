Return-Path: <SRS0=ansy=YJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DBBFA3728
	for <bpf@archiver.kernel.org>; Wed, 16 Oct 2019 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3821848
	for <bpf@archiver.kernel.org>; Wed, 16 Oct 2019 13:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405403AbfJPNee convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 16 Oct 2019 09:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbfJPNee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 09:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 385DAA3CD90;
        Wed, 16 Oct 2019 13:34:34 +0000 (UTC)
Received: from carbon (ovpn-200-46.brq.redhat.com [10.40.200.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D145D6B2;
        Wed, 16 Oct 2019 13:34:27 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:34:26 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Eric Sage <eric@sage.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        xdp-newbies@vger.kernel.org, brouer@redhat.org,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, brouer@redhat.com
Subject: Re: [PATCH] samples/bpf: make xdp_monitor use raw_tracepoints
Message-ID: <20191016153426.1d976f17@carbon>
In-Reply-To: <20191016042104.GA27738@wizard.attlocal.net>
References: <20191007045726.21467-1-eric@sage.org>
        <20191007110020.6bf8dbc2@carbon>
        <CAEf4BzacEF0Ga921DCuYCVTxR4rFdOzmRt5o0T7HH-H38gEccg@mail.gmail.com>
        <20191016042104.GA27738@wizard.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 13:34:34 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Oct 2019 21:21:04 -0700
Eric Sage <eric@sage.org> wrote:

> I'm no longer able to build the samples with 'make M=samples/bpf'.
> 
> I get errors in task_fd_query_user.c like:
> 
> samples/bpf/task_fd_query_user.c:153:29: error: ‘PERF_EVENT_IOC_ENABLE’
> undeclared.
> 
> Am I missing a dependancy?

Have you remembered to run:

 make headers_install

(As described in samples/bpf/README)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
