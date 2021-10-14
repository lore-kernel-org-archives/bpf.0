Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951FC433EF
	for <bpf@archiver.kernel.org>; Thu, 14 Oct 2021 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2781460F9E
	for <bpf@archiver.kernel.org>; Thu, 14 Oct 2021 15:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNPfx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhJNPfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 11:35:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1932A60F59;
        Thu, 14 Oct 2021 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634225627;
        bh=vj6us1kbr617Xb8YTLBMyK52xmipqpFksYTDJbBY3LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLOSAIqNinq7J+3Jf5mi82XWZMq+kSgXrFejKz/KD9/W+8jvYEvBNMOaQKnBjriU/
         QKecK+GCEFXxZ0YvKJmkdxeuuBpRWOROEpQsLvzOu592lul8NnPprKrboP5grJvicf
         TBhYKVt1kED5Y9KTepw0xmqAaE1z8fTTd0+nNGl8=
Date:   Thu, 14 Oct 2021 16:56:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [RFC 2/9] bpf: various constants
Message-ID: <YWhFHnYc1H9JzFgP@kroah.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
 <20211014143436.54470-3-lmb@cloudflare.com>
 <YWhCHbCw17fxQtIN@kroah.com>
 <CACAyw98ju_BiXXMxzfLu9=8uZMBWyXdb4gQTksHR27WrcwBtAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw98ju_BiXXMxzfLu9=8uZMBWyXdb4gQTksHR27WrcwBtAw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 03:47:19PM +0100, Lorenz Bauer wrote:
> On Thu, 14 Oct 2021 at 15:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 14, 2021 at 03:34:26PM +0100, Lorenz Bauer wrote:
> > > ---
> > >  include/uapi/linux/bpf.h | 17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > I know I don't take matches without any changelog text, maybe other
> > maintainers are more lax?
> 
> Hi Greg,
> 
> The patches aren't ready to go in, I'm looking for feedback. The
> rationale in the cover letter for the series, I thought the RFC tag
> would be enough, sorry about that. I expect that there will be a lot
> of changes (if it lands at all) so I didn't invest the time to write
> commit descriptions.

commit descriptions are usually the hardest part of the patch to write,
but the most important for the reviewers.  We optimize for reviewers,
not submitters :)

thanks,

greg k-h
