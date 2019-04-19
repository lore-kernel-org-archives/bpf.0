Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F02C282DF
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF6321479
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHc/irp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfDSTcM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:32:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41111 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfDSTcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 15:32:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so2935574pfd.8;
        Fri, 19 Apr 2019 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6tbljeHE4eiEGxW9I1MhSY8pUa+BRkr5mo/j+3PYxk=;
        b=jHc/irp9JxFZk559LxkrP0p83XGEHQWuM9fDCIRTmu+epE6/JsZpKRQTHd8FIzuJS3
         HaJhf1ZYK/SS6J9fHWSCxXGKtCnOwkWTtB9XFd8QuKQFC5IuS6+4FcjwMk5LcksnyQGF
         Ab8e6OalQJc7mO3jNOQdP/ttbjyUeDMyd5CIEgqMAYGNGSvuiXFLNAxRYfGoEfmbZwJb
         DtMuYgBkiSG+SW66bbG/u+Hw4m0nlWS/ZwGEmP7QCl7PHz9gVyzc/Pey1GgB0vfK6Wts
         yOnTXwv1CW/oFatajX8oK4a0KPbQC4SozzA2plL72YErLyT85cITtbk7aw8/mSF2lW8Y
         bkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6tbljeHE4eiEGxW9I1MhSY8pUa+BRkr5mo/j+3PYxk=;
        b=ks3bFpSiRjWOW19kPbT/62VaRghZPPa7duEB5qEzcgYsm+lnNRXWGh/2DlPcxlkf+I
         ar/us3klcP8wxWidv0geKbOgablpModEPWc+qlshfk0UeebscL7pQZRQy2BBWCSc/15p
         4+kXb2zWjLupgyPzf6MahZ+i/pTfA6I24tWuo1z78cq/XuXc4C8YpVp334BPH5ISkqMP
         urqqgItRfDs3aYCKaR7ksy5Uk4zRnHF1QLsbFvcLUHBD5iaH9XV65lzRoEUNM30+4vH/
         AfF3CNMcfxcAgBe/FHRo4/gr0IWnYl2ntbvT+H3HhZWaIHBb3d7sOIryLsx3hDI+vS2R
         DXpw==
X-Gm-Message-State: APjAAAUwQE0XO9hSHAb6Tb443QiB0AqCfTSPnAjRw1nLDYwhBIsZ7Iv8
        N9RLDapcINbjnEyCsVh/PBs=
X-Google-Smtp-Source: APXvYqydBoxioG2JhDvwH/6m3FJXCbSoIUmnB1Gby7/TcXSFC7brkJBU750O5rbUUNrtBRRXQ7hXJA==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr5575787pgc.416.1555702331437;
        Fri, 19 Apr 2019 12:32:11 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6f64])
        by smtp.gmail.com with ESMTPSA id p66sm13027340pfb.4.2019.04.19.12.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:32:10 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:32:08 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     robert.mccabe@rockwellcollins.com
Cc:     netdev@vger.kernel.org, robertjmccabe@gmail.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: fix BPF_LOG_BUF_SIZE off-by-one error
Message-ID: <20190419193206.gtu4ubv7aiu3xmge@ast-mbp.dhcp.thefacebook.com>
References: <20190419164745.3122-1-robert.mccabe@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419164745.3122-1-robert.mccabe@rockwellcollins.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 11:47:45AM -0500, robert.mccabe@rockwellcollins.com wrote:
> From: "McCabe, Robert J" <Robert.McCabe@rockwellcollins.com>
> 
> The BPF_PROG_LOAD condition for kernel version <= 5.1 is
> 
>    log->len_total > UINT_MAX >> 8 /* (16 * 1024 * 1024) - 1 */
> 
> Signed-off-by: rjmccabe3701 <robert.mccabe@rockwellcollins.com>
> ---
>  tools/lib/bpf/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index bc30783d1403..62d67caa7aea 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -92,7 +92,7 @@ struct bpf_load_program_attr {
>  #define MAPS_RELAX_COMPAT	0x01
> 
>  /* Recommend log buffer size */
> -#define BPF_LOG_BUF_SIZE (16 * 1024 * 1024) /* verifier maximum in kernels <= 5.1 */
> +#define BPF_LOG_BUF_SIZE ((16 * 1024 * 1024) - 1) /* verifier maximum in kernels <= 5.1 */

thanks. good catch.
please replace with (UINT32_MAX >> 8)

sending one patch was enough. no need to spam 5 times.

