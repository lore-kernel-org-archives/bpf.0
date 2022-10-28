Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE5C38A02
	for <bpf@archiver.kernel.org>; Fri, 28 Oct 2022 06:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiJ1G0R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 28 Oct 2022 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1G0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 02:26:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAF1B157B
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 23:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 290FAB82890
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4881EC433C1;
        Fri, 28 Oct 2022 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666938373;
        bh=az8ub4koIxBpHdC7yjNh9KisFbtP4iRmnKv9PNShwZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kC9qNLb2Jnql8e53u7NvVYzAtFd1ETNSvZi0o3bXLGGU5rZ8CtvRiEZcDIhTxl47Y
         Zcb6AQn7w55bXe7zLOH89poL+U1GAXOEZKl1erjcBL0njfRJm0nOBHWY29K6m/NEBr
         QtUFzuI4EEKVNRbjWiqF5Gczao5sO9lhsPbDtdEQ=
Date:   Fri, 28 Oct 2022 08:27:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Subject: Re: Closing the BPF map permission loophole
Message-ID: <Y1t2OxF3o0mtF1Hm@kroah.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
 <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 09:54:57AM -0700, Andrii Nakryiko wrote:
> But first, two notes.
> 
> 1) Backporting this is going to be hard, and I don't think that should
> be the goal, it's going to be too intrusive, probably.

Don't worry about backporting when doing your work.  Get it correct
first, and let others worry about any backporting if it's even needed.

thanks,

greg k-h
