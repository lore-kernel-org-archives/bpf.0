Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECCC433E6
	for <bpf@archiver.kernel.org>; Thu, 11 Mar 2021 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8E564FBA
	for <bpf@archiver.kernel.org>; Thu, 11 Mar 2021 02:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhCKCen (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCKCeV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 21:34:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD20C061574;
        Wed, 10 Mar 2021 18:34:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id s21so2560890pfm.1;
        Wed, 10 Mar 2021 18:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFi6QSYLRoYVZflaHy7/sw+qmXXsB/rC/woDCWvVEHA=;
        b=YxXrjMsLHTEsbM0XCg8Sjk/Ab9d7HhmHHPWFYhut2a8Ii7CxB0k1GxHoYcQZa/D+RX
         VGNlYOJM+LgqOU8alWT48Wt9ldc98csZRkB4YdnsJp8oP82tUUwFL2bCHksu6xxXxLE4
         O2NccJEL5afQq+f1KU3TdhcR8jRoFu1KiH5lIaX2LfXr0kAT3SHyQLxz7mN3eAhlnT+s
         hl4qxCjY44izSfJ12nlu5ERZ8VXUP29GkBqE+V4jT3wKWqwGF7EOdX2UD/aS9XtXH4yf
         Si8G8bngXd/8M8iidqn8RgJSEn4hw0Ae9Ifwob98YhO6Cht/v0NWZ2uIVDSmFUy/Qann
         cZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFi6QSYLRoYVZflaHy7/sw+qmXXsB/rC/woDCWvVEHA=;
        b=PlSxftzY1Biryifoy0anGa4WJCqyGqOPcIytLvyv5jgV7icsr9QqSc0uorMAS7/8p8
         kiN5p77fEX7COnnpbypfzw4Z7bERNeK68EZ3OF75DZdnksSAvJr789QWkO47dQNvXeYv
         xhyjiFQvSeChFbj5Xz4mzYrKjCrlPWwaFyd3nTdV1IUVgrH+sD9tjfQcLA1R65l1wPJt
         ljSuaKBLBHmlipKk70vk1rL9DuwzedFPRAUWOI/mD9ubCfgkvgsmfCEdNe6ZF822WoYB
         1jkwo6yySFaYOgSrdrb+ZvQ3pe/eP1QZq0LexO5XztmN1mwtywjtM4JBoqJx/WvxZ7Y7
         fJhw==
X-Gm-Message-State: AOAM531snKhKjsdvSAWEJ/VcO9ScMt2ZN704hPEmF6RvDMMLyKw9Nrr6
        2k9TrnK35PqP2/CqEIfVqsc=
X-Google-Smtp-Source: ABdhPJz1PQvWmwyjKh8PLoYYcEgZxoWg6SpqgPgUJbPVu+RuObjQdNedISmu102C6c4UATCPYvVIMQ==
X-Received: by 2002:a63:f921:: with SMTP id h33mr5180236pgi.419.1615430060736;
        Wed, 10 Mar 2021 18:34:20 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:917c])
        by smtp.gmail.com with ESMTPSA id g7sm681424pgb.10.2021.03.10.18.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 18:34:19 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:34:17 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 05/10] libbpf: add BPF static linker APIs
Message-ID: <20210311023417.vhwe4avhvri7gcr5@ast-mbp.dhcp.thefacebook.com>
References: <20210310040431.916483-1-andrii@kernel.org>
 <20210310040431.916483-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310040431.916483-6-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 09, 2021 at 08:04:26PM -0800, Andrii Nakryiko wrote:
> +
> +	struct btf *strtab_btf; /* we use struct btf to manage strings */
...
> +	str_off = btf__add_str(linker->strtab_btf, sec->sec_name);
> +	sec->shdr->sh_name = str_off;

That bit took me an hour to grok.
That single line comment above is far far from obvious.
What the logic is relying on is that string section in BTF format
has the same zero terminated set of strings as ELF's .strtab section.
There is no BTF anywhere here in this 'strtab_btf'.
The naming choice made it double hard.
My understanding that you're using that instead of renaming btf_add_mem()
into something generic to rely on string hashmap for string dedup?

The commit log in patch 2 that introduces btf_raw_strs() sort of talks about
this code puzzle, but I would never guessed that's what you meant based
on patch 2 alone.

Did you consider some renaming/generalizing of string management to
avoid btf__add_str() through out the patch 5?
The "btf_" prefix makes things challenging to read.
Especially when patch 6 is using btf__add_str() to add to real BTF.

Mainly pointing it out for others who might be looking at the patches.
