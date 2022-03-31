Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB8C433F5
	for <bpf@archiver.kernel.org>; Thu, 31 Mar 2022 00:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351954AbiCaACd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Mar 2022 20:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbiCaAC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 20:02:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E269297;
        Wed, 30 Mar 2022 17:00:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648684809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f93RugVHUQxMTA0bnAiY2VXHeWwPqVsL/byJ9IrZ/Fs=;
        b=AivTVFEfanb+t+GwmoRKdZ5Pz7jzlMOVPEHevctk4u6L7N16uVvv/FraI/2/gzVekImI1m
        x/p61Z5aP+lYfddmSCOC2z/WSNMyc9AVxZzR2oY9C/8pm8/Ngc8NnIgPLMbuCgibOLVwlz
        UlWImsvXOu/c7sXqKjXh5HgRNnjY6udf+AkkupHjR0OwzAkzVRJqYfdGFJIF0lZaGXhDCJ
        stte417LttX2UtVlmuk227nSQyc8y5DSWzUvQHV+jWBuVSpKWIFveFmxDDcnF83Nr5oljS
        r3hYkLLJ/s9NJwLkgvl3LdD4d8e/b9lfmB+CB0W/usVIEWgLZ8xM1o9i0Zidag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648684809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f93RugVHUQxMTA0bnAiY2VXHeWwPqVsL/byJ9IrZ/Fs=;
        b=U1u9bIQ+ZcS125XgnB5eKfxxk+keScRqsmuBo0Q2IDgMQKZWPvGwVZhB0FB1OIXYzMRj1Y
        Z0vipFmo+xyjuFBA==
To:     Song Liu <song@kernel.org>, linux-mm@kvack.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kernel-team@fb.com, akpm@linux-foundation.org,
        pmenzel@molgen.mpg.de, rick.p.edgecombe@intel.com,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf 4/4] bpf: use __vmalloc_node_range() with
 VM_TRY_HUGE_VMAP for bpf_prog_pack
In-Reply-To: <20220330225642.1163897-5-song@kernel.org>
References: <20220330225642.1163897-1-song@kernel.org>
 <20220330225642.1163897-5-song@kernel.org>
Date:   Thu, 31 Mar 2022 02:00:08 +0200
Message-ID: <87r16jm1o7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30 2022 at 15:56, Song Liu wrote:
> We cannot yet savely enable HAVE_ARCH_HUGE_VMAP for all vmalloc in X86_64.
> Let bpf_prog_pack to call __vmalloc_node_range() with VM_TRY_HUGE_VMAP
> directly.

Again, this changelog lacks any form of reasoning and justification.

Aside of that there is absolutely nothing x86_64 specific in the patch.

You might know all the details behind this change today, but will you be
able to make sense of the above half a year from now?

Even if you can, then anyone else is left in the dark.

Thanks,

        tglx
