Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06FC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7570214AF
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsXIyRB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCKXGs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:06:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfCKXGs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 19:06:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id i20so346078pfo.6;
        Mon, 11 Mar 2019 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obDBGQvq1pj8nicq607HzpC6gZFwj4s0tsv7qSnC+AY=;
        b=OsXIyRB+2f6NpDhNcVAI9wgQUl6D0O8p6AGvYDeISsg1mfffvyExRgC2R1kr8c6v1E
         5KwNS4p6mrxkQNgkDOhWsaJdXFterzYotT1NAYTpO+9YI1FMUW4Oz+a8CxyfVkutPSAo
         5rTrKEQ7NZbWD3KtS2oQWPII+mZI9KqC68woigaJarIi6SvXBWd6PIB3gc22GP5g3K+n
         rukGo+m6BTTVT7fF3TkabrQ9rWpJhc0nduzKCjqPh8yvakQcMfRGmZoiiExuh5Uuu+Qd
         R1/4t+CXOds+Ome9uF39h2G2Yee7LU9XEj1erXw0EejiuhKgw4BW4RjttbKLEltg969p
         s0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obDBGQvq1pj8nicq607HzpC6gZFwj4s0tsv7qSnC+AY=;
        b=HkxE8l6+5o+r+dhIdTWkknoftEaLfz6ENmbQR8IWtG/3LGwlGWMBZ1N3te4qc5e5D/
         2XP/PNmK/bO3POvsv80w92cuGiW2cGfVqBeJwb04RZVOGbtPJ346mBdTPSfLWxu0rq2K
         Aydtcrpnce9NfxTjJEi/f9DKQ0jOBcq9WP6HiNDd6Ferik9e/Cy/yyA5Nbj7dbnALZfV
         LgVAl45DnXJVyFwD9NSYNYexebpAfC+fnvGO3+dwn9kE9j4nnzRdmgJQf1/X76ALfgCH
         9lv0s9hY65wGQimkz/RAWJbnHNLwn4dfo8Y42MXBt8l6KTfFwy5Ka264wOCyAJtt6aVG
         rCtw==
X-Gm-Message-State: APjAAAXoGxU/wqn1ng+eb/y827eoYUun+fwK3F9EVw7e8z0X0zLHnMy1
        M+88apkfMdN/wadpffSqcVQ=
X-Google-Smtp-Source: APXvYqz6+O+M3+B3UVSoCOsqAVMOkub46EdAPmiEf7/9rA4VlCAawwOfHvmD60Fe1hUy1WMdiPqacw==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr34844860pfm.190.1552345606966;
        Mon, 11 Mar 2019 16:06:46 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::2:263e])
        by smtp.gmail.com with ESMTPSA id p2sm15587751pfi.95.2019.03.11.16.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 16:06:46 -0700 (PDT)
Date:   Mon, 11 Mar 2019 16:06:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        joe@wand.net.nz, john.fastabend@gmail.com, yhs@fb.com,
        andrii.nakryiko@gmail.com, jakub.kicinski@netronome.com,
        tgraf@suug.ch, lmb@cloudflare.com
Subject: Re: [PATCH rfc v3 bpf-next 2/9] bpf: add program side {rd,wr}only
 support for maps
Message-ID: <20190311230643.hpbcxczrq46hnn7r@ast-mbp>
References: <20190311215125.17793-1-daniel@iogearbox.net>
 <20190311215125.17793-3-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311215125.17793-3-daniel@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 10:51:18PM +0100, Daniel Borkmann wrote:
> This work adds two new map creation flags BPF_F_RDONLY_PROG
> and BPF_F_WRONLY_PROG in order to allow for read-only or
> write-only BPF maps from a BPF program side.
> 
> Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
> applies to system call side, meaning the BPF program has full
> read/write access to the map as usual while bpf(2) calls with
> map fd can either only read or write into the map depending
> on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
> for the exact opposite such that verifier is going to reject
> program loads if write into a read-only map or a read into a
> write-only map is detected. For read-only map case also some
> helpers are forbidden for programs that would alter the map
> state such as map deletion, update, etc.
> 
> We've enabled this generic map extension to various non-special
> maps holding normal user data: array, hash, lru, lpm, local
> storage, queue and stack. Further map types could be followed
> up in future depending on use-case. Main use case here is to
> forbid writes into .rodata map values from verifier side.

I think WRONLY | WRONLY_PROG should be invalid combination?
Since these attributes are set at creation time and cannot be changed,
nothing can ever read from it, so why write into it?
Similarly RDONLY | RDONLY_PROG is invalid too?

Also looking at the next patch and 'lock' command...
May be it would be cleaner to do add WRONCE (from syscall) flag?
Then for .rodata the attrs will be RDONLY_PROG | WRONCE
and no 'lock' necessary.
WRONCE_PROG probably doesn't make sense.
Storing dangling task_struct pointer in the next patch doesn't look great.
The whole 'lock' concept feels useful, but in the context of implementing
.rodata it feels that WRONCE would be a better fit,
since libbpf won't be able to make a mistake and forget to 'lock'.
'lock' syscall cmd can be confused with BPF_F_LOCK too.

