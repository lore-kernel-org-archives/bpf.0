Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D51FC433DF
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AF720772
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsfOk+l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHSBIj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHSBIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 21:08:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED946C061389;
        Tue, 18 Aug 2020 18:08:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so415327pjn.1;
        Tue, 18 Aug 2020 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MRTjQoKzFBglneMcqPVOSh6rfmDu+GFH72NRY+c7DHU=;
        b=SsfOk+l5GxCvWOg2Cc5l+TTl8UNn9E35f2N2KmxQXoIAPMP+0HYErihHPF1nQd8T09
         QfvEb6Oqcexl0hGYr4Hkailivw5yGr081DJAJaA2zdPImpHgwtYqW6lP39fR7f4REk0q
         S4+UJOSFv3WT3XlDX3TXFRxXTAt+r5q3jJGRoPbcSdFQxiDJZpMaMRqXqCj8lrB/jkIP
         SesoiepjUZq1x0JU6cphlb8ze1gbtoO+XshjXoW0GVco4j4LPaeixBJCzIo3JBIrM5EX
         5xF74il0bcrVhZvqUu/YMpwbYUzBK45q/6yV2rEeqlPz1ozOWlhh6+Q7rWbzAGawCcLP
         91qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MRTjQoKzFBglneMcqPVOSh6rfmDu+GFH72NRY+c7DHU=;
        b=iDeHXwJHyX3ONoUG32xzyeCBnwq0eOvhezuaFFERgkL1stA14HPeoW3+57CHMdRLGx
         tJGYwUeYeEkwAnKM9JLgtuCj2AxeUn0jtyP8HeptPEGudxXaDXo8cqLvf/w55kTV1Izn
         mQ/SmAwo14ZIpRQlOjNtjvDseKk+SXHGnF17VNtDVfWG25hm0yesQkSoWBXmikeDX1qn
         lRUjnRKd4uUP89DMqk5y5OrBsNAP+RWuEjQGMcQh+fQecy9yAOX48zj52+tLeJqLIhia
         vFW54ilMLiJWDnoqKRxpf/u/WJFEJK3mz/AD6ZTl8Fn+Myp8KBT1BCL/Gj1v0IjzdBJJ
         T3Yw==
X-Gm-Message-State: AOAM532QATNO6BB3YjHG/mhu9UzVlJKVd9xOjT3m5yLLaSWMsjVKnVa0
        4wzB3nG5Mq65pAveK9jFpXQ9iPV1Aok=
X-Google-Smtp-Source: ABdhPJwaKsfrkVPAQqrmNPkXeOoV5ojbnFBjbeKZA/jS5qJJ/IayHYWc5lHLQayGyxNzSMj9tj/HtQ==
X-Received: by 2002:a17:902:d30b:: with SMTP id b11mr17216779plc.107.1597799318500;
        Tue, 18 Aug 2020 18:08:38 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:20fd])
        by smtp.gmail.com with ESMTPSA id l78sm26298479pfd.130.2020.08.18.18.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 18:08:37 -0700 (PDT)
Date:   Tue, 18 Aug 2020 18:08:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 4/4] tools: remove feature-libelf-mmap feature
 detection
Message-ID: <20200819010835.3r7ch5h4wb4yue6k@ast-mbp.dhcp.thefacebook.com>
References: <20200818215908.2746786-1-andriin@fb.com>
 <20200818215908.2746786-5-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818215908.2746786-5-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 02:59:08PM -0700, Andrii Nakryiko wrote:
> It's trivial to handle missing ELF_C_MMAP_READ support in libelf the way that
> objtool has solved it in
> ("774bec3fddcc objtool: Add fallback from ELF_C_READ_MMAP to ELF_C_READ").
> 
> So instead of having an entire feature detector for that, just do what objtool
> does for perf and libbpf. And keep their Makefiles a bit simpler.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

overall looks good, but this patch doesn't apply to bpf-next.
