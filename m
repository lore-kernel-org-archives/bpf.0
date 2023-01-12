Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F8C63797
	for <bpf@archiver.kernel.org>; Thu, 12 Jan 2023 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjALU4v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjALUxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7091D0ED;
        Thu, 12 Jan 2023 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5XtVOpPk797RWssSm4RUwIm5IGfVc/kxn1XcmHsVb/w=; b=O9bYVqsPNtukPAFGgy5B11bHji
        cH7xn2RkX+Ow0T4kpYMcpRov+4MWn9c4u6h0hJrkGaQP1m2wMoB8RNjrmAkCjYq+JbQh54Z5opVXQ
        88fMJVxIQ1svjtM502fDbzSTen8proAvL+C+6URmlXR8XlPt8HRv+91bgira8NHFXFmLWk+99grMz
        0Hcq3zJjxyBjz5o3leBWbTbo7ZYWqwI3GMA6GWFR9gj/vUO9Vnx3CVcTWM1bA0C+5+ILgYO4qmlIF
        GPVjn7a0zOe22v96r0kCIdCUclxd3KOkqUXYjrm+KXJAoM0a7Z6t2gKPWGVTFQiidn8VrVIXpCKaS
        UXF8Fh3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG4Ij-005SJn-OB; Thu, 12 Jan 2023 20:35:54 +0000
Date:   Thu, 12 Jan 2023 20:35:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Brian Norris <briannorris@chromium.org>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] tracing mapped pages for quicker boot
 performance
Message-ID: <Y8BvKZFI9RIoS4C/@casper.infradead.org>
References: <20230112132153.38d52708@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112132153.38d52708@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 01:21:53PM -0500, Steven Rostedt wrote:
> What I would like to discuss, is if there could be a way to add some sort
> of trace events that can tell an application exactly what pages in a file
> are being read from disk, where there is no such races. Then an application
> would simply have to read this information and store it, and then it can
> use this information later to call readahead() on these locations of the
> file so that they are available when needed.

trace_mm_filemap_add_to_page_cache()?
