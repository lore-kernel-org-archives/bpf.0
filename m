Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD7C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB13218A5
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lJq/f7CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfB1AVu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:21:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45168 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfB1AVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:21:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so21504769qtg.12
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 16:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fs/bu37Mcw+d3VzDjg4phEfm3v6ipkkIUnTmELwpZxQ=;
        b=lJq/f7CYsaUw/If5sAeCaimB3kylOER64aANv+kN3VDOsrz1pcakMR+H+P7cHy21Cd
         6V1P3Dx/DsorQ2fbTljHoK7AD0k2sty6wslmvkR/LWvHAUPzy2ghCInEmAJcgqNByCdU
         t0cmEztTE59tjQ5115CRCNA1ktM1DL2YAMS5uAAnEoTiW9MnoHaA2nAdclGrOIiEsBDZ
         0HJviO0r+GXLM1AXEq4hpMrUiohuQVg0VxXHFgIip4roow1sY3kB7Im01AgH2WGHJpI5
         FK2uL8XWNSxiLPBGxSs7BAjRD+i9ri4PN3a8xmsRFGNvBkpM4SNCsmVpma2w2pL5EW5b
         +3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fs/bu37Mcw+d3VzDjg4phEfm3v6ipkkIUnTmELwpZxQ=;
        b=dHgoanpFDUHwyNCAkgsclqbf5DCL1JCm25j0OOtdPwQREgj3iiE9jxUK62XY7OGlkI
         b7LOYlYfzu8Qv4w4hA2ogAaP09Piz54KD7Quivr2XxYNPBt2HT6M+N3obSBmXrBGH3DU
         Nz3d/sI1o7iWVMM5Z0PbK0U7cHhMrBf6bxtXIu/kR4jeJvNx/alRlZ9jOWJsbACiVKsN
         2i8OL9XBOQPjoe/NT0AQqU9nOMs9gxAFND0H+hr85ALvESFFMcAqypewQHPFZL16S12A
         NJ7XSBwgmRHzzJ7WsX3VqHiSop43G3tuCBPca3kV8kkEURdgEy4d9h6AO35kw2sBGMv5
         pqSg==
X-Gm-Message-State: APjAAAVTTego9P63JST7dzD3b8YcvDEkvxNhG9GS3V5QiTHX+CeZc/XO
        ug3Yen/DBB36lM6i3LyoNgakMQ==
X-Google-Smtp-Source: APXvYqyMDxMRC/ukpI50r/SUkepN7cW8LyrNlFlDoCNAKooftX6RD1APjICAc1mgcfGJxC4YKCtIew==
X-Received: by 2002:a0c:9802:: with SMTP id c2mr4227037qvd.13.1551313309627;
        Wed, 27 Feb 2019 16:21:49 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id b50sm7665909qtk.50.2019.02.27.16.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 16:21:49 -0800 (PST)
Date:   Wed, 27 Feb 2019 16:21:44 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH bpf-next 4/5] samples: bpf: use libbpf where easy
Message-ID: <20190227162144.43273307@cakuba.netronome.com>
In-Reply-To: <CAEf4BzZsYnvQZTqB6g9RocZpuCMxZ+eCnLqBccerFNkQ8ReEFw@mail.gmail.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
        <20190227233046.11718-5-jakub.kicinski@netronome.com>
        <CAEf4BzZsYnvQZTqB6g9RocZpuCMxZ+eCnLqBccerFNkQ8ReEFw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 27 Feb 2019 16:05:45 -0800, Andrii Nakryiko wrote:
> >         if (object) {
> > -               assert(!load_bpf_file((char *)object));
> > -               return prog_fd[0];
> > +               assert(!bpf_prog_load(object, 0, &obj, &prog_fd));  
> 
> Here and in few more places below: is it possible to specify correct
> bpf_prog_type instead of 0?

Some of them yes, some of them no.  There are objects with multiple
program types IIRC.  This program type argument is only used for
checking if kernel versions are needed, and they are provided in
samples so it doesn't matter.

I'll try to add where possible.
