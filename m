Return-Path: <SRS0=zf1N=CM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2DC433E9
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 19:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83C220E65
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599161209;
	bh=yS2vWoQBhhf3QSRyhF5rOIpprqbVA5TZG9bHqKjsrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AHC1hMNGbeRDSv/fdILPQcXUjbtXxxh+Ck2EuK8g79fPfnwHVoDAydyMtPdx/5FjI
	 HdMe79w4n1wAtiH2ncw27xqNmUCzQO2nN9NGsgXibH4BT3lzOR8IgFtRGgdGNjSXng
	 KAMIpGQn7onEQMB/Wm8gD8K9YBdVsTNwVvkofPd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgICT0s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgICT0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 15:26:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03550206EF;
        Thu,  3 Sep 2020 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599161208;
        bh=yS2vWoQBhhf3QSRyhF5rOIpprqbVA5TZG9bHqKjsrgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpv1Qom+eMOgbXkpyj98wtFG3rFjKT/tP+A7ClmDHCZJfEaEunHQ/E685AF4Uigt7
         uqQ42Ym9QmxcIyL5ZtDkKJTtIWrktP27m8a+J9RWfO1crXnKn9d2wxoj7Xe+M/Q6rH
         Gx5ffmPf64zWSy3Ci7H9R03KCahXxiqgcsNZPPUo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B80E340D3D; Thu,  3 Sep 2020 16:26:44 -0300 (-03)
Date:   Thu, 3 Sep 2020 16:26:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] tools build feature: cleanup feature files on make clean
Message-ID: <20200903192644.GK3495158@kernel.org>
References: <159851841661.1072907.13770213104521805592.stgit@firesoul>
 <20200903190350.GI3495158@kernel.org>
 <eb3ad60a-68be-f350-9597-b999edae5244@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3ad60a-68be-f350-9597-b999edae5244@iogearbox.net>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Sep 03, 2020 at 09:20:35PM +0200, Daniel Borkmann escreveu:
> Hi Arnaldo,
> 
> On 9/3/20 9:03 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 27, 2020 at 10:53:36AM +0200, Jesper Dangaard Brouer escreveu:
> > > The system for "Auto-detecting system features" located under
> > > tools/build/ are (currently) used by perf, libbpf and bpftool. It can
> > > contain stalled feature detection files, which are not cleaned up by
> > > libbpf and bpftool on make clean (side-note: perf tool is correct).
> > > 
> > > Fix this by making the users invoke the make clean target.
> > > 
> > > Some details about the changes. The libbpf Makefile already had a
> > > clean-config target (which seems to be copy-pasted from perf), but this
> > > target was not "connected" (a make dependency) to clean target. Choose
> > > not to rename target as someone might be using it. Did change the output
> > > from "CLEAN config" to "CLEAN feature-detect", to make it more clear
> > > what happens.
> > 
> > Since this mostly touches BPF, should it go via the BPF tree?
> 
> Already applied roughly a week ago:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=661b37cd437ef49cd28444f79b9b0c71ea76e8c8

Thanks!

- Arnaldo
