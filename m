Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C5AC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39A222D8
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550149921;
	bh=5a27L9flt8PCEwIz1hCKB2j+dlTsnXwmjPV90YtkFSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rJAH7K0j013h3kZJxbfvTXOGdQ4s+NteW4JgS1VemWPb0/f2TQCUdjy6JxZ4k6joh
	 f5jvuXA9txqlWi6fZgXYNiJlhsRT2H2OmV5nlR7b29Q1RG5+3ZV2majqj/QmlveG5E
	 lGuf8Q7AAntWMEJF8PNPe5vW/tbH60TUHdyr5Bnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392290AbfBNNMB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfBNNMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 08:12:00 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF52B222B6;
        Thu, 14 Feb 2019 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550149920;
        bh=5a27L9flt8PCEwIz1hCKB2j+dlTsnXwmjPV90YtkFSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdkGBoprpI2Bq9IpTb9ubhlJERW0hcn281La0oK7epyDdYWwjawPVwaGeZt6rAH0W
         tWrA5WAtF9bTpWQzucLLknnED+NcvYaxJrkzJ9bGbM5BzHdQ+25CvLIMAUb/Wpbugn
         I7cSAsRxzZkbnEiC5+cr3RfpZKXWN5eWurNoc/bo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2608F410D5; Thu, 14 Feb 2019 10:11:56 -0300 (-03)
Date:   Thu, 14 Feb 2019 10:11:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190214131156.GU3269@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214124757.GP3269@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 14, 2019 at 09:47:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> > happy with it. So consider this email a solicitation for naming
> > suggestion. Keep in mind, that all the pahole's functions of the form
> > btf__xxx will be renamed as well for consistency. If you like
> > btf_info, let me know as well, I'll just stick with it.

> Can you try thinking if splitting this further into 'struct btf_loader',
> 'struct btf_encoder' that would live in the pahole sources and that
> refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
> point) is a move that eases your current needs?

So, the btf__new() in tools/lib/bpf/btf.c is basically a variant of
btf__new() in the pahole sources, probably we should go ahead and make
pahole use that btf__new() and do changes in tools/lib/bpf/btf.c to
allow for it to access internal state that it needs to do its job?

I'm tinkering a bit with it.

- Arnaldo
