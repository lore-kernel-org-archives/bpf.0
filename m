Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF06C07E98
	for <bpf@archiver.kernel.org>; Mon,  5 Jul 2021 08:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04991613B6
	for <bpf@archiver.kernel.org>; Mon,  5 Jul 2021 08:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGEIUI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 5 Jul 2021 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 04:20:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32158C061574;
        Mon,  5 Jul 2021 01:17:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t15so17616098wry.11;
        Mon, 05 Jul 2021 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0hN6t3XOPfYl7bbCREM9Ps0hpP4pUKWb+JjtXnJ6TMY=;
        b=s0FopFfcJJr0KsFtnbGPHOSAe9XCFfZpNrl8E0mT7vGLXfUNcyCkR28wT7mUZBO0zo
         0ANXLA95yP3XsebQ1PQIPXABNWh+0pe7O+BKumXzEv9ta/4r5jRXH6GyM+a1kMovZmVO
         4kw4hFqnckMdjh/CrNrZCFyuaLeZGxOlEY27Q+EGdXA46/Yn+w0OyuXiDDmpet1rxJvG
         Wweln2NqzNZr3xJV2wNZp9IQyvrsseo7nQbOyFEsT9Q4QN0wDT9vyMtpaVxBw8tT6Dt0
         CiyGqjiP3k6x5TxWVmNPjI/iSDCueCcrWwFsErpavhoXuO4yAgtAmsFPsaDp6GBzhAlH
         JE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0hN6t3XOPfYl7bbCREM9Ps0hpP4pUKWb+JjtXnJ6TMY=;
        b=jvKMp1yuErD61Q3YMvNyBJoBFg2yj4hNOwZ894nFnUjnucTCIQLLs3xMagl+889I8n
         7IkDpm5vp0VRReVqRbtmKetuT4jgP6Izser9pwvYs/P62kQ0XU09oVTX7o2Vf+hFh78k
         I3Os1sF0iXN2Rt+ofYUuiq3suePcjxSbJK2jCSflwvxoSFGbvfEK+7Mshjaku1BZXOnd
         A4+HPclyb8qePa78wrAjv1MMU1+Q9TrHC/Ht65Uxmq3UIEiGgD/E9zOTg/3tDtp0c6J1
         ZruGGRpHruJrV57Me2vwFJvyWyOqX2SOTH1L3Z8zvmhanpWNUBbpUy2LNZvXcPpaAxio
         RJbw==
X-Gm-Message-State: AOAM5329sFKYHFWmrnTvWJEfmAfxHuBCfBpM5lknhIEGIDjZtwNT826Q
        TuXYbjcKJUHVU7jLwPxR2Ss=
X-Google-Smtp-Source: ABdhPJxldIS0FV2nN7r6D7TYxp4Z3Kg5zle4YEupnyXfrICk/EBGqctPw0IMvloXUnaET3Xk9yYGsA==
X-Received: by 2002:a5d:4849:: with SMTP id n9mr6780932wrs.186.1625473048901;
        Mon, 05 Jul 2021 01:17:28 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id j37sm8968987wms.37.2021.07.05.01.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:17:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 10:17:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 10/13] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <YOLAFswnvyNReMmI@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400001661.506599.5153975410607447958.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162400001661.506599.5153975410607447958.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +	/* Replace fake return address with real one. */
> +	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
> +	/*
> +	 * Move flags to sp so that kretprobe_trapmoline can return
> +	 * right after popf.

What is a trapmoline?

Also, in the x86 code we capitalize register and instruction names so that 
they are more distinctive and easier to read in the flow of English text.

Thanks,

	Ingo
