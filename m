Return-Path: <SRS0=dMgm=TJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA8C04AB1
	for <bpf@archiver.kernel.org>; Thu,  9 May 2019 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D2520850
	for <bpf@archiver.kernel.org>; Thu,  9 May 2019 23:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG1RO7ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEIXBo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 May 2019 19:01:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35123 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEIXBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 19:01:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id m20so3457377lji.2;
        Thu, 09 May 2019 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCAH7KsOk9niJJskOeykDP/4/x+QWrsBEWl5YZqfzGQ=;
        b=AG1RO7axa+jNvMfMyjCF4bPJoRHT/j76cITgLQd7sc/0MT/trc9thupCxB6jGGI7yo
         yTTgNYppk8BcR/PRNhCejiqXFZ8y7d6Q7yMGIwY7HUVl4KwH/hI6m+j2bgOcZAr5OrhM
         V7NcMpiCknzO+RuG0K5PAbjtc2G6dlzfy9w+ISaPIsXk5m72HYZMVzATJETECw3DpqeQ
         fcrY/VUoH1aho5pyiYVmjwmBUBb9pCcJSFL8GSf80RmUkgB9FV+pDd4ibnI61kLgmYY3
         nWlVwMou0cSOQNs7tXkOhGk9EDMS/pzw4XHhahoWR6uFMDb24Yo0hvttLEfxfezBhg1j
         n4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCAH7KsOk9niJJskOeykDP/4/x+QWrsBEWl5YZqfzGQ=;
        b=QQkmXi5FoAxd2F7HeebCrUZQCa2uIbY4edtlUt8BpYLodY2c86vCGTSQ6fO6aVxrr+
         xt60k62Da+iDGGtyZuVkeJ3VTdk+wcQFXicx6xLSEdBnJvnkBfLEVhzxUcdzA42IOo0v
         +qGQ+GK/ZPHn1K+vDflWM14EYkNktDarl3PC+s2lIPt//NcDuTMI+W99zCaBDk+W8r1M
         DXaWT0viQ/xiZdjvKX9gX3cQ2PYq8k1D2NzJjbCTrrHBbtmmcR1mgAJaBksle2vDCNEj
         8+CLJj93XfW9zkTNJPWsogcq9+rS8ncoirzq/Ys7YygYYBemIm01sIgSaw8+GKeu5dM2
         2M7Q==
X-Gm-Message-State: APjAAAV2XYEOzjcefM+8myGS1YPbOjno6Gb9uy2VPuobsHZh+nZQpR/8
        hNGk0RsZIZZqUfNRYquOkt2glJeO28iGcVTJ2m0=
X-Google-Smtp-Source: APXvYqykhx77nicQEyVpJNQRqqYO5YWcVTu5AuzdiK3HnSrB1+jyjeKCCvXhnyW02duf/fprn7qsJZ7MHANsLKId2QY=
X-Received: by 2002:a2e:6c02:: with SMTP id h2mr3761948ljc.103.1557442901356;
 Thu, 09 May 2019 16:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190502154932.14698-1-lmb@cloudflare.com> <20190508164932.28729-1-lmb@cloudflare.com>
 <20190509155600.4yypxncilarbayh4@kafai-mbp>
In-Reply-To: <20190509155600.4yypxncilarbayh4@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 May 2019 16:01:29 -0700
Message-ID: <CAADnVQ+Sr-ecQn7LCq=NOPwfeVT7QD9yy8DmPCPgxTMYKY=JAQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests: bpf: initialize bpf_object pointers
 where needed
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 9, 2019 at 8:56 AM Martin Lau <kafai@fb.com> wrote:
>
> On Wed, May 08, 2019 at 05:49:32PM +0100, Lorenz Bauer wrote:
> > There are a few tests which call bpf_object__close on uninitialized
> > bpf_object*, which may segfault. Explicitly zero-initialise these pointers
> > to avoid this.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
