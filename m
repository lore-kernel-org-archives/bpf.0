Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F00C433DB
	for <bpf@archiver.kernel.org>; Wed, 10 Mar 2021 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C11464F4B
	for <bpf@archiver.kernel.org>; Wed, 10 Mar 2021 15:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhCJPJV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhCJPI7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 10:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615388939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/y/H0bJShEAqvQ118GFOubDIFXmTHRwvOstt+Xw9FT4=;
        b=cne97lfS6ydlZQ+h2Pd5s/RKkDXXOoh8/7FZiTc2dVtK5cSkZGhFivfdExpMI7FZ4kysCK
        yI9/Urejl3eDrwwPuzdKNQBOxOja11gTZEnDXbhehutcY/uaTrjDpAURcq/VISHcAV58a0
        2PjoUU/AFPwYr8+gr2dsteYHus4/ovs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-uRWwTBJvOv2zTtGDi6k1yA-1; Wed, 10 Mar 2021 10:08:55 -0500
X-MC-Unique: uRWwTBJvOv2zTtGDi6k1yA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8632F7A4;
        Wed, 10 Mar 2021 15:08:53 +0000 (UTC)
Received: from treble (ovpn-118-249.rdu2.redhat.com [10.10.118.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17D9A5C1A1;
        Wed, 10 Mar 2021 15:08:48 +0000 (UTC)
Date:   Wed, 10 Mar 2021 09:08:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210310150845.7kctaox34yrfyjxt@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
 <20210309011945.ky7v3pnbdpxhmxkh@treble>
 <20210310185734.332d9d52a26780ba02d09197@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310185734.332d9d52a26780ba02d09197@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 06:57:34PM +0900, Masami Hiramatsu wrote:
> > If I understand correctly, for #1 you need an unwind hint which treats
> > the instruction *after* the "pushq %rsp" as the beginning of the
> > function.
> 
> Thanks for the patch. In that case, should I still change the stack allocation?
> Or can I continue to use a series of "push/pop" ?

You can continue to use push/pop.  Objtool is only getting confused by
the unbalanced stack of the function (more pushes than pops).  The
unwind hint should fix that.

-- 
Josh

