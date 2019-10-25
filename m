Return-Path: <SRS0=fH4Q=YS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E2CA9EA0
	for <bpf@archiver.kernel.org>; Fri, 25 Oct 2019 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76F20663
	for <bpf@archiver.kernel.org>; Fri, 25 Oct 2019 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BwtEXlJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbfJYQbX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:31:23 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:36935 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390417AbfJYQbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 12:31:23 -0400
Received: by mail-pl1-f175.google.com with SMTP id p13so1507329pll.4
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1EUj3irj6XVPBQ7Z9U8k8kcmlKkmc6kitqhex26/WnQ=;
        b=BwtEXlJcQ20cGQDYIU0gfNYys1FpKTgFQKDLWNAUjvxMX2F14kbUC3qhq96Z0ctb7h
         lRnPUrg3flmm1/MWivhAZAQAEUEsf6Mh0ZPOD36R56J4PIHmtFfM6XR37CveYwE6yUlI
         NqAbJ61nbX/ByJzeus/lVFpOxvGYJDOrtSqAJc75b7zsAQ3AUXS5JBRRPRNbICHcTV48
         20rPm5BTtmnOdADNFins1B6g38HPS2lYb7IvuDLnoKwv6wNFDfD53RFTi2VF4V8YVgDq
         Vodepyjg+xpt8wRjx7AqRXIcG5TmQecDJBFKpocxnxX8hNjxs/dmM72U0W+5LVMGXGcd
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1EUj3irj6XVPBQ7Z9U8k8kcmlKkmc6kitqhex26/WnQ=;
        b=WjCmXOZmnLWM3Y8BcmcNtqvLGm4F6kuSzJyJWRYNKH6m9bIzDN/Ml7SCY4gNM+Bgnc
         LmC+1Iqz4kQLSWvFT3qR1247YEBqXoAlx+X4ShAuWUcP1TmkwSK6qXmE+dCUMUijuWGp
         qvXgkiED+0AMp8oGhgsyq/nmZGG2no7l+vHxNB5HG30e6v+yp2LdqoVrwVdSEyqT4zw9
         0JOUBTd7Ucdzku4Ndf4MjIXYKvnC1NAuS9QK8UO+7iX9XpJOqWPHyRmxpdP+dCMw2VnX
         /Hdy2zZgSieFM0rRIfC/9kwZE/TFwJEe6V3PDcEqR0ZxUi2hntWqHfFyZoHob8qrGTCI
         0PXw==
X-Gm-Message-State: APjAAAVfYGXIsjLtb7sJYPtBL+moMkDtfLiEcJsH3AO5rHb9/eZj/smY
        tx5mEO+yWWesoMmgVbKlsAjPtA==
X-Google-Smtp-Source: APXvYqxIgWYAro3JplidCsKmEFeX4IA3PodO6Cd0sdWb14wx/ymxyllaQfpPEWRPtsASesqW2n/1Kw==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr4646650pll.317.1572021081092;
        Fri, 25 Oct 2019 09:31:21 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y20sm2822910pge.48.2019.10.25.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:31:20 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:31:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: [PATCHv2] bpftool: Try to read btf as raw data if elf read
 fails
Message-ID: <20191025093116.67756660@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <aeb566cd-42a7-9b3a-d495-c71cdca08b86@fb.com>
References: <20191024132341.8943-1-jolsa@kernel.org>
        <20191024105414.65f7e323@cakuba.hsd1.ca.comcast.net>
        <aeb566cd-42a7-9b3a-d495-c71cdca08b86@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Oct 2019 05:01:17 +0000, Andrii Nakryiko wrote:
> >> +static bool is_btf_raw(const char *file)
> >> +{
> >> +	__u16 magic = 0;
> >> +	int fd;
> >> +
> >> +	fd = open(file, O_RDONLY);
> >> +	if (fd < 0)
> >> +		return false;
> >> +
> >> +	read(fd, &magic, sizeof(magic));
> >> +	close(fd);
> >> +	return magic == BTF_MAGIC;  
> > 
> > Isn't it suspicious to read() 2 bytes into an u16 and compare to a
> > constant like endianness doesn't matter? Quick grep doesn't reveal
> > BTF_MAGIC being endian-aware..  
> 
> Right now we support only loading BTF in native endianness, so I think 
> this should do. If we ever add ability to load non-native endianness, 
> then we'll have to adjust this.

This doesn't do native endianness, this does LE-only. It will not work
on BE machines.
