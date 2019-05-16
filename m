Return-Path: <SRS0=32pG=TQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24110C04AAF
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122520815
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEPP00 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 May 2019 11:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbfEPP00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 11:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29D49307D913;
        Thu, 16 May 2019 15:26:26 +0000 (UTC)
Received: from krava (unknown [10.40.205.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E38410027C6;
        Thu, 16 May 2019 15:26:23 +0000 (UTC)
Date:   Thu, 16 May 2019 17:26:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Pavel Hrdina <phrdina@redhat.com>
Subject: Re: [RFC] cgroup gets release after long time
Message-ID: <20190516152622.GA20592@krava>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516152224.GA7163@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 16 May 2019 15:26:26 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > hi,
> > Pavel reported an issue with bpf programs (attached to cgroup)
> > not being released at the time when the cgroup is removed and
> > are still visible in 'bpftool prog' list afterwards.
> 
> Hi Jiri!
> 
> Can you, please, try the patch from
> https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342bf6721e148e2 ?
> 
> It should solve the problem, and I'm about to post it upstream.

awesome, could you please cc me on the post?

thanks,
jirka
