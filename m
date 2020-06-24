Return-Path: <SRS0=3qi6=AF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAABC433E0
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289A5207DD
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 06:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPK0wRl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgFXGjo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388635AbgFXGjo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 02:39:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55533C061573;
        Tue, 23 Jun 2020 23:39:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d12so664560ply.1;
        Tue, 23 Jun 2020 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9h7m8O1hUXEeLPoiuIyawxzUsCDkcDqyjL6391tJMQU=;
        b=FPK0wRl85+ZOko1X7AM5JRgKLv3NKGiurcDkf75B9UjxnE31hRWJiIy4KN2J9CyDD/
         owNfd+y8XC5YGTSwoMfV2Mxkl3z7q+3oEc3RNVg+qfK1gDyWN1hq9GnJRALEqLyRvotu
         mMxtTgXAqZPPK7HvGWD9KorT2WFXRn/I3rq/Q/Bogcav0zSzq27hQQYw+FIStkp8idpN
         PTOgQnuQI25NUoEzSPGeN/6L+iBI81Eqi/fBhJ7WIMCjDpwoA6/4TG/BjUh2QMQtX75w
         cRA4j5LFnK0V75v8zvJJ+r3Rn6MsUb6gxn8KvntVbU/ELbitJvOq89xcCnSmp8QDlsTQ
         SF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9h7m8O1hUXEeLPoiuIyawxzUsCDkcDqyjL6391tJMQU=;
        b=GG8mBTuPYX0jisy6iz+2EO6s4oPR1Te95O9plqCulF2mZi2UBiHOAkvTP8LdHdOQNe
         LCKoGCde8zmwiIGKX1ONF9JmqD0MtDGzAb1LHOPq9KyODm5ahp3OtNkChbfc9ZLXsr/Q
         8rtf8gA8t0x2N873n821lBH/O6U0PGRSF7FEDHi9MpMH/j2sSfHgkDRGChaj9TTAVlJt
         zqMbAhB18AnIgJL6YjNZymqaR95k9/Rd4mvFzJ+yitHC2a5sf/ElHrQy9u6r7EV1LJ5C
         aowrxcESM7oIt51d7BZNfpAlUZ8g3DS4O0tb/d0YUe+vvZIgf4nnNvMDvWaSPlMkPS7H
         NHdg==
X-Gm-Message-State: AOAM531IRrsnRt56NygYF5vAEW7e9UZclrBsCV/+PAGJ95NPIzsieZ6l
        /ml4r+Amvp5k+Yuwl2r87mw=
X-Google-Smtp-Source: ABdhPJwTuUEMhDUuikKcNAqYOV6U4yBjBSdy4W42LWoNULv3C8j5oHDgHw++djfNEg/uQuKrg3THQg==
X-Received: by 2002:a17:902:b716:: with SMTP id d22mr26963655pls.33.1592980783789;
        Tue, 23 Jun 2020 23:39:43 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e7a])
        by smtp.gmail.com with ESMTPSA id n19sm15154196pgb.0.2020.06.23.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:39:42 -0700 (PDT)
Date:   Tue, 23 Jun 2020 23:39:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200624063940.ctzhf4nnh3cjyxqi@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
 <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 24, 2020 at 01:58:33PM +0900, Tetsuo Handa wrote:
> On 2020/06/24 13:00, Alexei Starovoitov wrote:
> >> However, regarding usermode_blob, although the byte array (which contains code / data)
> >> might be initially loaded from the kernel space (which is protected), that byte array
> >> is no longer protected (e.g. SIGKILL, strace()) when executed because they are placed
> >> in the user address space. Thus, LSM modules (including pathname based security) want
> >> to control how that byte array can behave.
> > 
> > It's privileged memory regardless. root can poke into kernel or any process memory.
> 
> LSM is there to restrict processes running as "root".

hmm. do you really mean that it's possible for an LSM to restrict CAP_SYS_ADMIN effectively?
LSM can certainly provide extra level of foolproof-ness against accidental
mistakes, but it's not a security boundary.

> Your "root can poke into kernel or any process memory." response is out of step with the times.
> 
> Initial byte array used for usermode blob might be protected because of "part of .rodata or
> .init.rodata of kernel module", but that byte array after started in userspace is no longer
> protected. 
>
> I don't trust such byte array as "part of kernel module", and I'm asking you how
> such byte array does not interfere (or be interfered by) the rest of the system.

Could you please explain the attack vector that you see in such scenario?
How elf binaries embedded in the kernel modules different from pid 1?
If anything can peek into their memory the system is compromised.
Say, there are no user blobs in kernel modules. How pid 1 memory is different
from all the JITed images? How is it different for all memory regions shared
between kernel and user processes?
I see an opportunity for an LSM to provide a protection against non-security
bugs when system is running trusted apps, but not when arbitrary code can
execute under root.
