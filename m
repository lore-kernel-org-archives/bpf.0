Return-Path: <SRS0=w90l=6G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C2C55185
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B22B2082E
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 17:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDVRYf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:24:35 -0400
Received: from verein.lst.de ([213.95.11.211]:53807 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgDVRYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 13:24:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA5C468CEC; Wed, 22 Apr 2020 19:24:31 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:24:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] sysctl: remove all extern declaration from sysctl.c
Message-ID: <20200422172431.GB30102@lst.de>
References: <20200421171539.288622-1-hch@lst.de> <20200421171539.288622-4-hch@lst.de> <13b10b87-6753-7e7c-fa56-20d7793250d6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b10b87-6753-7e7c-fa56-20d7793250d6@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 22, 2020 at 12:30:22PM +0200, Vlastimil Babka wrote:
> On 4/21/20 7:15 PM, Christoph Hellwig wrote:
> > Extern declarations in .c files are a bad style and can lead to
> > mismatches.  Use existing definitions in headers where they exist,
> > and otherwise move the external declarations to suitable header
> > files.
> 
> Your cleanup reminds me of this Andrew's sigh from last week [1].
> I'm not saying your series should do that too, just wondering if some of the
> moves you are doing now would be better suited for the hypothetical new header
> to avoid moving them again later (but I admit I haven't looked closer).
> 
> [1]
> https://lore.kernel.org/linux-api/20200417174654.9af0c51afb5d9e35e5519113@linux-foundation.org/

I thought of that, but I'm not really sure it is worth it.  I'd rather
move more sysctl implementations out of sysctl.c and just export
the tables back to it.
