Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD9C10F0E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E41218AF
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BtVnDmfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDMBIw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:08:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33187 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfDMBIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 21:08:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so6812320qkc.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+kRpVNRR4GRvS1/AFbciXADp3SEYf4vV3Y5cV0sbgvI=;
        b=BtVnDmfGCmBkUH2PlIpBHGi40SyRBtElv5sRl86yqHtFTC+tZbstjIIOx+TqIlBJzT
         zfHI3fvISUtJwibcNU9vMmGy0xqIAY7aOrofWQbcBF/kOaMqnyb/Zu1wOh0/ffLiWfNK
         c/eVUX2uKRXKdAhb3Ccxmiwuib9+8clSBqS1Y7kDgUcUclqMsNncKw2hXGHynIehDc3K
         XuqLJ3TnQhrKaNOmJuqDcgD9U/uHg1M3CXyEKjHc7OlHqLaypANB5PF47U59DOv8gZ5w
         1REThcswEOcIVy/nMm5xqDh6wZrlDSjkhSL6XYt8mp3Peh+tym7IAMI03VxGy7iS9pGF
         dsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+kRpVNRR4GRvS1/AFbciXADp3SEYf4vV3Y5cV0sbgvI=;
        b=sKrpU8kcJbsy6hr/UBtSUQBntiVQSVyBvSG7aPaLLZ2u95lUGqB2iitXJ5260mPS+O
         zZoHC/WorI7g01E3df4ovqyYX3wxyQBN9HF/+QGd7+a+IDI/I+Uz5oryG6cEhIJDS90i
         OTSyiQwR13JmCUU4JrzAq15np2aCPKIXD9biZCtip8uO80JJyMUGlnkIvhaHz0lyiuR5
         v/Y6VBqbPuK1eeD9hJlsXOpgVm3JaO8tsUUZLlpb4OvjdibUF7dX/KWiBfsFy+xBeT5m
         VSZI1LVMcDWzGcUslAzhY3rtyEjeQCaalWjzvj08u9nIxXKnJPyALczLXwM8lai7+cyu
         JjSA==
X-Gm-Message-State: APjAAAVoHL1Ip4in1U3+P6u5nMrKjhokcTc6+12Lge7PJ3Q2vgS58jwE
        aIsgAFoj7Wqf+oJoEmwo6lv1Wg==
X-Google-Smtp-Source: APXvYqxGQM3TgsYE6hfyHPdCB/GhSBeIIsfe3pwF50oVM666QawYy6RlUPjWXhzlV8TT8bRlJrG6mA==
X-Received: by 2002:a37:a656:: with SMTP id p83mr48662969qke.91.1555117731806;
        Fri, 12 Apr 2019 18:08:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id b37sm39662948qtb.92.2019.04.12.18.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 18:08:51 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:08:48 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 11/19] libbpf: add "prog_flags" to
 bpf_program/bpf_prog_load_attr/bpf_load_program_attr
Message-ID: <20190412180848.24ab1467@cakuba.netronome.com>
In-Reply-To: <1555106392-20117-12-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
        <1555106392-20117-12-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Apr 2019 22:59:44 +0100, Jiong Wang wrote:
> libbpf doesn't allow passing "prog_flags" during bpf program load in a
> couple of load related APIs, "bpf_load_program_xattr", "load_program" and
> "bpf_prog_load_xattr".
> 
> It makes sense to allow passing "prog_flags" which is useful for
> customizing program loading.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c5ff005..5abc237 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -320,6 +320,7 @@ struct bpf_prog_load_attr {
>  	enum bpf_attach_type expected_attach_type;
>  	int ifindex;
>  	int log_level;
> +	int prog_flags;

nit: __u32 or other unsigned type here?

>  };
>  
>  LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,

