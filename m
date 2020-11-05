Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA93C388F7
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 22:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E222C20782
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617035;
	bh=4HiUMXFfTMWojhcYABhByqsUoN31oPzYLU2VOxm5slc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QqH2en/B7320jEW0gADpdjzECwLf2iSEQ30j2IoA+xkilm1BSThkQNXIQ8jVE3ZXq
	 Cm0yoobgumLxmYiP22vnuczyamXAeWmAplEHZSBzSSr83rj4gzZghvZrWGXr59RFon
	 bhnt6Rh4Ctx+i7KSuhEOz8XtZEz+iEnJxAsIVCBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKEW5P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbgKEW5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:57:15 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F2E20719;
        Thu,  5 Nov 2020 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617034;
        bh=4HiUMXFfTMWojhcYABhByqsUoN31oPzYLU2VOxm5slc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGASsWQxXe3caLLm/7vBWyqdqt8vB+YGs/iklalrGZY17PjESICpdi2+Ovy0wd5XA
         /Sx89fXIpP89yBg7H2BfL6qe1cWjTugPCWPWbrIo6YDgnQTmxuNapVP1XMwnxgsP1o
         kfst2YRAXM5dBv64fqz636++qSHj/37CuS31rDww=
Date:   Thu, 5 Nov 2020 14:57:13 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Benc <jbenc@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next] bpf: make verifier log more relevant by
 default
Message-ID: <20201105145713.10af539e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAEf4BzZgXO1Uv49cGQ6PMoe6gXiF8obJr9uKBTeE2MzzHEr=PA@mail.gmail.com>
References: <20200423195850.1259827-1-andriin@fb.com>
        <20201105170202.5bb47fef@redhat.com>
        <CAEf4Bzb7r-9TEAnQC3gwiwX52JJJuoRd_ZHrkGviiuFKvy8qJg@mail.gmail.com>
        <20201105135338.316e1677@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAEf4BzZgXO1Uv49cGQ6PMoe6gXiF8obJr9uKBTeE2MzzHEr=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 5 Nov 2020 14:41:12 -0800 Andrii Nakryiko wrote:
> On Thu, Nov 5, 2020 at 1:53 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 5 Nov 2020 13:22:12 -0800 Andrii Nakryiko wrote:  
> > > Should we just drop check_verifier_log() checks?  
> >
> > Drivers only print error messages when something goes wrong, so the
> > messages are high priority. IIUC this change was just supposed to
> > decrease verbosity, right?  
> 
> Seems like check_verifier_log() in test_offline.py is only called for
> successful cases. This patch truncates parts of the verifier log that
> correspond to successfully validated code paths, so that in case if
> verification fails, only relevant parts are left. So for completely
> successful verification the log will be almost empty, with only final
> stats available.

If you're saying the driver message would still be there if
verification or translation failed that's perfectly fine, we 
can definitely adjust the test. But some check that driver 
message reporting is working is needed, don't just remove it.

Sorry, don't have cycles to look closely :(
