Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB147C61DA3
	for <bpf@archiver.kernel.org>; Tue, 21 Feb 2023 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBUVWA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBUVV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 16:21:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854B2DE79;
        Tue, 21 Feb 2023 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3wwgaOAtJyQ/6lKVyvGMkGGUg0khszmE+NnlRtfyRGE=; b=ptOJRKvmkM6BsAfGjOho3V0KSD
        PN9bW/0hw1WvnmlM3NjqciRIXTJTc59BWzQnmnE8GIyLRQltT85VeeHdTEiffLHiT3OG28WGusWQm
        +K5f4pKq0vaKOl6d0sEQ20jjWvPkt9DUeUFDU1iQQuaSg9hhFzm9K5nlbKTlQetFe5B9tS8+R/KP5
        TfzHlNxYeyq2/u3F15gbnMgKTY/8PgoYquEVK4bqssGLSmyUDg/3aho7RsTNyZRWbCIezVJGqP/9P
        30rwfqKxhGpsftch7ckJRyTmlNh419NDz0MbRU1uVk5oMwn2p+rX8kqXQ/ntokx4q2B3g4U5SKFID
        5DsS0L1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUa5A-009nyA-S1; Tue, 21 Feb 2023 21:21:52 +0000
Date:   Tue, 21 Feb 2023 13:21:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Nathan Chancellor <nathan@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        ndesaulniers@google.com, trix@redhat.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] module: Remove the unused function within
Message-ID: <Y/U18FlTNVhwb6+q@bombadil.infradead.org>
References: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
 <Y+0MsMomkcDBdjNI@chrisdown.name>
 <Y+0PzlA0LijhfD8R@dev-arch.thelio-3990X>
 <Y+0VAr21hlIdrxyp@chrisdown.name>
 <CAPhsuW5U2qXa_O46_v-hzWqq5L7bRs6bQe5QGGnMOMzX3y4KgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5U2qXa_O46_v-hzWqq5L7bRs6bQe5QGGnMOMzX3y4KgA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 10:57:09AM -0800, Song Liu wrote:
> Hi Chris,
> 
> On Wed, Feb 15, 2023 at 9:23 AM Chris Down <chris@chrisdown.name> wrote:
> >
> > +Cc: Song
> 
> Thanks for the CC!
> 
> >
> > Nathan Chancellor writes:
> > >On Wed, Feb 15, 2023 at 04:47:44PM +0000, Chris Down wrote:
> > >> Jiapeng Chong writes:
> > >> > The function within is defined in the main.c file, but not called
> > >> > elsewhere, so remove this unused function.
> > >>
> > >> Huh? It's used by __module_text_address(), no?
> > >
> > >Not after commit 2ece476a2346 ("module: replace module_layout with
> > >module_memory") in -next. This patch should have a fixes tag, even if
> > >the warning is currently hidden behind W=1.
> >
> > Huh, I thought I had checked out latest -next, but must have not done so
> > somehow :-) Mea culpa.
> >
> > If it's only in -next then no Fixes needed, since there's no stable rev yet.
> >
> > Jiapeng, in future, please make sure to cc the author of related commits when
> > reporting stuff like this :-) It helps people to update their patches.
> >
> > Song, you probably want to update your patch.
> 
> Luis, would you prefer a new patch with everything folded in? Or would
> you apply the patches on your end?

I've merged this patch separately onto modules-next and enhanced the
commit log to explain its needed after your patch.

  Luis
