Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EEC433EF
	for <bpf@archiver.kernel.org>; Wed, 13 Jul 2022 09:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGMJy2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Jul 2022 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiGMJyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 05:54:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CD814A7;
        Wed, 13 Jul 2022 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cRqnvJDsfN6fhCEHJ9PA7nMRlfBPVLCY2LI3JbYP3BI=; b=YizJ1nYTaKqOQYxSGU2ehyP50d
        iVe2FTsNk4GY/Y5qCdgE2T0lMkg+t+xKiyngyFnNq6rTdsWCLs/DrAxcJV1XwgTxlUYx+wUe13Jmn
        y3dv6uuBBl8ZaG52YxvIVD4bVJpM9t2r7x4o1mskPjtdZxapuwN3QscxPm1aBAzf320XZjXxqXe1P
        HT9AlQkbrx8QnCvUcQC0RLGPrUl2LFLuar0qF6RQRZapypgjcUQIr6D3waGaKwINKoRgPnnusFQcH
        WOpKOcuzrqJl6nDZmT61RLifjjMYp0Byex1NUmEt9oG9rAFk/exRv3jsSWzyZK/tOzIBl1y68qPrg
        iQQ4mkIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBZ3X-003WS6-4A; Wed, 13 Jul 2022 09:53:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85606300110;
        Wed, 13 Jul 2022 11:53:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E4B6201ECFBD; Wed, 13 Jul 2022 11:53:15 +0200 (CEST)
Date:   Wed, 13 Jul 2022 11:53:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, keescook@chromium.org,
        hch@infradead.org, dave@stgolabs.net, daniel@iogearbox.net,
        kernel-team@fb.com, x86@kernel.org, dave.hansen@linux.intel.com,
        rick.p.edgecombe@intel.com, akpm@linux-foundation.org
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys6WCwU0VlTe2zIf@hirez.programming.kicks-ass.net>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713071846.3286727-2-song@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 12:18:44AM -0700, Song Liu wrote:
> +/**
> + * vmalloc_exec - allocate RO+X memory in kernel text space
> + * @size:	allocation size
> + *
> + * Allocate @size of RO+X memory in kernel text space. This memory can be
> + * used to serve dynamic kernel text, such as BPF programs.
> + *
> + * The memory allocated is filled illegal instructions.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +void *vmalloc_exec(size_t size)
> +{
> +	return vmalloc_exec_pack_alloc(size);
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_exec);

NAK! modules do *NOT* get to allocate text.

