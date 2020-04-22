Return-Path: <SRS0=w90l=6G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843CBC5518E
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6B720776
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDVR0z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:26:55 -0400
Received: from verein.lst.de ([213.95.11.211]:53830 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDVR0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 13:26:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEBBD68C4E; Wed, 22 Apr 2020 19:26:51 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:26:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 4/6] sysctl: remove all extern declaration from sysctl.c
Message-ID: <20200422172651.GC30102@lst.de>
References: <20200417064146.1086644-1-hch@lst.de> <20200417064146.1086644-5-hch@lst.de> <87d07z4s54.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d07z4s54.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 22, 2020 at 07:33:11AM -0500, Eric W. Biederman wrote:
> > +extern int core_uses_pid;
> > +extern char core_pattern[];
> > +extern unsigned int core_pipe_limit;
> > +extern int pid_max;
> > +extern int pid_max_min, pid_max_max;
> 
> These last two pid_max, pid_max_mind and pid_max_max would make more
> sense in pid.h as they have nothing to do with coredumps.

Done for the next version.
