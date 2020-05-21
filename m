Return-Path: <SRS0=Vsws=7D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04CC433DF
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A8020759
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590084249;
	bh=niEMPau5fW33ciK7opyh8p6Qii22izrIZJYhauAi/0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V/Zi9wULAoXR1UrQmooNGPAvhgADMF9SapGOQEdanW8bM28n6T4vMMlap3PaUqAEt
	 giZCCZGLeOPmlNEWo5lOIIBKE+ablQwYR1yDWGJvL4oInWLQSaw0S6TsLqj+JC7/2w
	 jXpfn4WeWrBawk3tspLw6RMX85FN2i2ZpHGeojd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgEUSEG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgEUSEG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 14:04:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66CC061A0E
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 11:04:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so9448617ljj.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Gg4b4CDCsETMIm4Edj1Xv31p6ZdZ0NWSz903G/X2Po=;
        b=C+6xQYv405ppXq81KjYUQtltgLKHhtWFV7DfKyUQgnD/o5JsMIaX3ld48tDI1ZlD7K
         U7kuhQvl7mdKFxmVsF/c3fYz37gu4oWx14U5jtAODWIsK4FqzsUCdodSWDq8PJADqJQN
         fxp/doyT7dYvEricBmr9oFTSOXixPbh/BPwNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Gg4b4CDCsETMIm4Edj1Xv31p6ZdZ0NWSz903G/X2Po=;
        b=mPYI6Vm2H1L0z6vjxFGXUXQXQh7e1SzsUTNXjuirqxXD1ICNXqKlPLqtN3gWIqBup4
         Hp5PhZkTrMlnMcRzKnQLqhz/s3YyI0hULa+TuHNzsJzoL4fLMqJ3EmtyflayINt5esoS
         NMcCLECso44P0DwZNQDTMykRA4ysV36U15bPo1GqEaeywxLwTeaS2CXP1wkYvsVFPrhf
         iOlIr6nOqzKvLUI2XUu89WpMZBTaG9TCoPD6ymy/kxmracIrHAM5B8TTYOMneXwlnXM/
         732Ad5O5CPiJsrJLsMz+7Za7nEoXJkUYAh7I9KdQEPzXHM666LwCEq8rvsBzoIP5O+nQ
         8KfA==
X-Gm-Message-State: AOAM532rVWTZaoHYUtqyVuLKYaS16gMOGvKvMtz6Ss1n9SHIoFtTZRri
        X7sWwcBNZYNt/4Weetx7nTyFQoao8es=
X-Google-Smtp-Source: ABdhPJw4rYyDlFhbNyb3Tmx55ibvtHPVnlwHhA5SqE5ABRQUHGx3+b3uwdUBqqBx2ICT0adMT4XvJA==
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr5282500lji.15.1590084242433;
        Thu, 21 May 2020 11:04:02 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k22sm1923840lfg.69.2020.05.21.11.04.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 11:04:01 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id z6so9366525ljm.13
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 11:04:01 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr3748342ljj.312.1590084240602;
 Thu, 21 May 2020 11:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
In-Reply-To: <20200521152301.2587579-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 11:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQa3GNytJDdN=RKzSKfGQdPBvso+2Lmi+BpOP=BA_n6A@mail.gmail.com>
Message-ID: <CAHk-=wiQa3GNytJDdN=RKzSKfGQdPBvso+2Lmi+BpOP=BA_n6A@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 8:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.

I could not see anything to object to in this version. So Ack from me,
but obviously I'm hoping others will try to read it through as well.

              Linus
