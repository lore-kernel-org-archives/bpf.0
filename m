Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB401C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A386420854
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552044003;
	bh=J+TUwI5AluQ/WTlWgB+C9JnusxdUlUOCeBDQAePDcRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EYRC1SaxLUPkCS5LTbgxhOqdkiDOtrICch+N6JAF2aZcfqN6yEKqlQMuc0vSGUy8w
	 PgzapDTPGKhjkut3FFVVVedjJOe9yqSoMtoREuNIrmHZ0SNKx+b6+Kgs7VBz7cLi2H
	 eFkv0QNcx4CfH1FM9mvRQ7jrwByjkf+3+zHBwkzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCHLUD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:20:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:41138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfCHLUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 06:20:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CFE8ADC7;
        Fri,  8 Mar 2019 11:20:02 +0000 (UTC)
Date:   Fri, 8 Mar 2019 12:20:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
Message-ID: <20190308112000.GG5232@dhcp22.suse.cz>
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <69fdfb33-057b-b7fe-033e-d82006a779b9@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fdfb33-057b-b7fe-033e-d82006a779b9@lambda.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-03-19 12:14:16, Martynas Pumputis wrote:
> 
> 
> On 3/8/19 9:44 AM, Michal Hocko wrote:
> > On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
> > > It has been observed that sometimes memory allocation for BPF maps
> > > fails when there is no obvious memory pressure in a system.
> > > 
> > > E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> > > could not be created due to due to vmalloc unable to allocate 75497472B,
> > > when the system's memory consumption (in MB) was the following:
> > > 
> > >      Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> > 
> > Hmm 75MB is quite large and much larger than the slab/page allocator
> > cann provide so this is not really a fragmentation issue. Vmalloc does
> > respect noretry but considering that there shouldn't be a large memory
> > pressure I wonder how NORETRY managed to fail the allocation. Do you
> > happen to have the allocation failure report?
> 
> I got /proc/{meminfo,vmstat,vmallocinfo} just after the allocation has
> failed:
> https://gist.github.com/brb/62092c1d83daa6527271b88f0352e32d

dmesg with the allocation failure report would be more helpful

Thanks!
-- 
Michal Hocko
SUSE Labs
