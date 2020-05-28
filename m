Return-Path: <SRS0=Fl3P=7K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622FC433E0
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 00:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B7B208B8
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 00:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590626201;
	bh=l5wZRM+En9EhTkWEiIUiMBwxkTXPk7INqbMM1OHAcws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OIjEQtcJnGWxitzIHXIwBYKwOr4trQgvvmQ5fLcE3Fb4yVorw54FwGzcIWePqF2rW
	 PIR2bxP2itU7wUDeeyv7yvRNpoeds3HICrSvJL6qN3HRudLWx4aLbE7S3+//x9yj/N
	 0XA+YfGZRkcoCBVt24vHQGYEzVsX1Ls9iJMZH1o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE1Agk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 May 2020 20:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgE1Agk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 20:36:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7336D206DF;
        Thu, 28 May 2020 00:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590626199;
        bh=l5wZRM+En9EhTkWEiIUiMBwxkTXPk7INqbMM1OHAcws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h9Wd+eaorp2Qz1deBfKgqA3uJOQcd+/XPw+cKZslTF9e2MNRlQptp2ULVCE554v2Q
         EsKlXKubui96Zpk/k1BivDNxlCT/MlJQpIL0y+jTkugMACJ89bPTVHqU+d5Q3Uk7wS
         mUWE9EeNxOMGUDTZmCY4+goDCM4jfZN3efWrQMbY=
Date:   Wed, 27 May 2020 17:36:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up and streamline probe_kernel_* and friends v4
Message-Id: <20200527173638.156eccece443d8e98c646310@linux-foundation.org>
In-Reply-To: <20200526061309.GA15549@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
        <20200525151912.34b20b978617e2893e484fa3@linux-foundation.org>
        <20200526061309.GA15549@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 May 2020 08:13:09 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Mon, May 25, 2020 at 03:19:12PM -0700, Andrew Morton wrote:
> > hm.  Applying linux-next to this series generates a lot of rejects against
> > powerpc:
> > 
> > -rw-rw-r-- 1 akpm akpm  493 May 25 15:06 arch/powerpc/kernel/kgdb.c.rej
> > -rw-rw-r-- 1 akpm akpm 6461 May 25 15:06 arch/powerpc/kernel/trace/ftrace.c.rej
> > -rw-rw-r-- 1 akpm akpm  447 May 25 15:06 arch/powerpc/mm/fault.c.rej
> > -rw-rw-r-- 1 akpm akpm  623 May 25 15:06 arch/powerpc/perf/core-book3s.c.rej
> > -rw-rw-r-- 1 akpm akpm 1408 May 25 15:06 arch/riscv/kernel/patch.c.rej
> > 
> > the arch/powerpc/kernel/trace/ftrace.c ones aren't very trivial.
> > 
> > It's -rc7.  Perhaps we should park all this until 5.8-rc1?
> 
> As this is a pre-condition for the set_fs removal I'd really like to
> get the actual changes in.  All these conflicts seem to be about the
> last three cleanup patches just doing renaming, so can we just skip
> those three for now?  Then we can do the rename right after 5.8-rc1
> when we have the least chances for conflicts.

That seems to have worked.  "[PATCH 23/23] maccess: return -ERANGE when
copy_from_kernel_nofault_allowed fails" needed a bit of massaging to both
the patch and to the patch title.

