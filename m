Return-Path: <SRS0=G29D=7V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD016C433E1
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 18:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E82063A
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 18:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGfpXEsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgFHSfQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFHSfP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 14:35:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1BFC08C5C3
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 11:35:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so9114077pgv.8
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKuK+ZsV7MPmpsgKX1I2np3sySPSJbPqU/PgQTtt/OU=;
        b=KGfpXEsSQeV7Jw57zwT+PfjW56m2tlBM4JvWhjQF68ZgiYc51WNloeGQo86pikEB0A
         3k9RQghvZrKUsNWcfepoQ5TQGls3x03ndnuUogkuGmv4ukwTeukR+wqayWcWlmgD0SNr
         AhW8yWjXyM16ScrAruCIZDYQzVeXz8dlAQmrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKuK+ZsV7MPmpsgKX1I2np3sySPSJbPqU/PgQTtt/OU=;
        b=lBP7W1+jlPfBvMi4sZ95/9eFSWlGtARtygQvWz//TZcYoeqcijWx5IuRjuKoISqZeE
         m/ELn5Vviit3d4P7tGbgT5dMBIr/Jmz/clS5S5lJwUxlGZXOgD08SpGAiIRjoqxrZDLm
         CUTcUa0b6spgRG09pB2Tawtkc8n9YRpLxPsNG2vs+me1vi7ObaXPPhhEqnmuK/n+JLkb
         Y7tvdjs0wO4d+enEbMS4IvHND0DKthPP56r1ZLzBfjjYhxkZjkfjmUBGtV88QE05tpyY
         XRm+nyp9UUAiO0VASQake+JKuVRMyuPOuDHQx3h8dSKe8l++dnauIGEZ8GUpLom/Xvl/
         N+sA==
X-Gm-Message-State: AOAM533weDEGKIA87kbo91BGOdPKodIGpjy6LgWWIp8E0Saenl9kD8k5
        yR7Kk/6lAnDWWiiY3WEImGvhRQ==
X-Google-Smtp-Source: ABdhPJwe7hqwsg7JbWVhGEjmTX4WnIzcJLgFf/ma9Da7qAsuFJ8m7vq5pu4dQSfkoysLJh+40u9WkA==
X-Received: by 2002:a05:6a00:84e:: with SMTP id q14mr22457795pfk.309.1591641314677;
        Mon, 08 Jun 2020 11:35:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm6282911pfb.120.2020.06.08.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:35:13 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:35:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <202006081130.CE3AE614F@keescook>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
 <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 08, 2020 at 09:20:27AM -0700, Alexei Starovoitov wrote:
> Take android for example. It can certify vmlinux, but not boot fs image.

Huh? Yes it does, and for a while now. It uses Android uses dm-verity[1]
and fs-verity[2].

[1] https://source.android.com/security/verifiedboot/dm-verity
    https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
[2] https://source.android.com/security/apksigning/v3
    https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

-- 
Kees Cook
