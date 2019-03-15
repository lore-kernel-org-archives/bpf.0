Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C9EC10F0B
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1E4218D4
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amgn6Fbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfCOTvs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:51:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44450 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCOTvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:51:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so3172518qtb.11;
        Fri, 15 Mar 2019 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3IuxAgUqEhb7OHNDlf2hFLeIRGF4qpP3kcxjnn1TjVY=;
        b=amgn6FbgW+vzJn4xE9J3R9gM6BWck3iIg2+8BaXeHaTIlw1jQ1lsye6zaXf7vUJFu3
         YUsN7giQekd75wvg3h7+l/WReG7MjhX2FLZoai8pU5jGPPCkaQa0AlpuZSaxDRcijNHD
         b+QxRMmU8N89qzX9kTjPz9JOGWKNbxHls1eHZtWYqZIuYZ6qGpfx/q1M1jObSpB3KdEX
         2wwmQJI8VMtiNgF0EEk3ZK+F0dlRgDxpYvE6cubXf+iy37cw6BtZYwf66JQ32DxlWtos
         n7mv/hmOHlOJTQQ5x3xday0epUNd3FtA+1R9Yb9moz6Fm/2k79dJ8YX8w0/sFScKxDO0
         /ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3IuxAgUqEhb7OHNDlf2hFLeIRGF4qpP3kcxjnn1TjVY=;
        b=cdGtUxS0PP7/RkLRnszU7YcNsQjD+iKPRWGwjIqcW4lPgk2ccB/7VowGd4s+KjVaIf
         c14eSpuhyU0St+ewCTipoTwjclEsLgCg/C+zvC+k5nyj9Ih/kIB3uSdPfs4OcKuIyABn
         zvR/MbAqq/aw8x8i6/MzIcI1H4gJwhG7HG/tM7ivLvWOwlULx1Qu+dLqGCEj7aRGfKN/
         n+zLOgJJbbUlIF/ndnaklJvEhzJonKpbWhx9sF4Qn2cc78sdSRqUyGkaTogFmAyQRL5u
         B9v4jhIc6Z10XUrWtKO/C3IvMYB/PNuHcC2sBGF+tA7vRAZRmjFvJK7gohFIqYOWQP/q
         lPIg==
X-Gm-Message-State: APjAAAWvAJpk2tLm+mJwH/kQo65JcULgmfY8vhuncmYf0x5EC0SEmgx8
        500YHOhu9ZLF5Kh478Ftxno=
X-Google-Smtp-Source: APXvYqw9O2H8Y5bLEcFZCWhazQTfQaSBy+VB74SsOPwEkfXd+fb5HZLEfbBKuhf7ME4PAveBLhe6Zg==
X-Received: by 2002:a0c:9ae5:: with SMTP id k37mr4064460qvf.128.1552679506500;
        Fri, 15 Mar 2019 12:51:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id n3sm1646104qkf.93.2019.03.15.12.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:51:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 876F54039C; Fri, 15 Mar 2019 16:51:42 -0300 (-03)
Date:   Fri, 15 Mar 2019 16:51:42 -0300
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] bpftool: Allow referring to maps by its name
Message-ID: <20190315195142.GB22548@kernel.org>
References: <20190315183211.GB24482@kernel.org>
 <20190315121632.246824dc@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315121632.246824dc@cakuba.netronome.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 15, 2019 at 12:16:32PM -0700, Jakub Kicinski escreveu:
> Please do keep the current model of name val, IOW dump map *name* pids..

I don't have a problem with that, but what would be the problem with
supporting both:

  bpftool map dump name pids_filtered

and:

  bpftool map dump pids_filtered

And for that matter, even:

  bpftool map dump id 30

And

  bpftool map dump 30

Ditto for 'pinned'?

I.e. less typing, the tool can be smart enough to figure out what is
that is being asked, i.e. is it a number? Try first it as an 'id', etc.

- Arnaldo
 
> >   [{
> >           "key": 26554,
> >           "value": true
> >       },{
> >           "key": 2592,
> >           "value": true
> >       }
> >   ]
> >   #
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Quentin Monnet <quentin.monnet@netronome.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Link: https://lkml.kernel.org/n/tip-rrnxuhvety3j3rf0r9zlbfro@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Please also update the bash completions and all the help/mans/docs.

-- 

- Arnaldo
