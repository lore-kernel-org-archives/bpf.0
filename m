Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC180C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 01:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55CB218D4
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 01:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4iEv9UG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCUBdD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:33:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38365 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCUBdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 21:33:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id v1so3086539pgi.5;
        Wed, 20 Mar 2019 18:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMw26BLxnf/qsDyIwygFeljT5QzDYRRiA/f3gZtlvCs=;
        b=U4iEv9UGGGhZ3doVww4ogig+ar5TuZNVgljDmoP3JOOQlws/lVmnhOJ28/kqkNBl+z
         TVg7AVsDDEShzkfdwLfae+n0vNbcUl5Rlptq1lpBn5XwXCWFDhxtg9DuyPeTPn3BrxR/
         +C8/J6cm3pnLGAcTzFBMWe5f0T/YIAsbVe7SbwqKu2RunynQYqj/qG7N2CgwFQ4quwSS
         fJ/qtxAz5tSCfJfIICn7nwowqK8CJsPt+R/MFTKdj4mQ23AMuqbn349dg1pV/lQcY6GN
         2Gh+XzsvCQDFLvt9n+k9nkYzwPWkn9Dwvm9ZnosHBQJBLPCgQS0B/ixwVNnvmrIE6sdM
         l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMw26BLxnf/qsDyIwygFeljT5QzDYRRiA/f3gZtlvCs=;
        b=mUr+Sb/hQN6TGrjbYZCuMLmD+NkBHBsCm+y+iDHJWx/s/hFpD5/2T0qyVNXLwwJKNC
         Hn3zQ5B/BISiCB9Z/LrQoStsqDvn5wYqvRzxmrEQtdQSPWphrxX3CvvJaBlNqjP1OHX2
         HH8zjv4ZPIywdAXzLdcx3ZU/hGRRXa63SAfPwB9wljBiIZz0dR1klJD+m0PIK06PKr05
         WnO4WhX9V3FnTeKetf2cJqxjQ/bEUCHXh/sIu2+T7j3uTrWX1OJF6LHGvw3dXpxbZERI
         91tPEPx7yZlO1D0xzNKAwqh2hpK15q5fJe9bhTdFIONaGRUiaVBDqwe0WuWmJIUTNeDD
         7zhA==
X-Gm-Message-State: APjAAAX867VopaT2Fh/LsWp/e212x/n3ZnzhcOhjXiAMnJK+EvYTNqZn
        5BHKJHefCtZkNpJ13cCe2Lk=
X-Google-Smtp-Source: APXvYqz78VIB4yNg4+UzsKTh1BO5PzhsTH3TbzhN39YP+O1bKN2QD9pMIjwJRmHqzXY5WI72WMKTqg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr845197plb.328.1553131982305;
        Wed, 20 Mar 2019 18:33:02 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id l28sm9121547pfi.186.2019.03.20.18.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 18:33:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 18:33:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Michal Rostecki <mrostecki@opensuse.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf] libbpf: Check if map names are not NULL
Message-ID: <20190321013258.6eoy5nm5qqbulfa7@ast-mbp.dhcp.thefacebook.com>
References: <20190320122742.19311-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320122742.19311-1-mrostecki@opensuse.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 01:27:42PM +0100, Michal Rostecki wrote:
> BPF maps do not have to be named, so map names can be NULL. Map name
> pointers should be checked before doing any operations which cannot be
> done on NULL pointers.
> 
> This issue was detected by the following errors coming from bpftool
> built with AddressSanitizer:
> 
> bpf.c:256:2: runtime error: null pointer passed as argument 2, which is declared to never be null
> bpf.c:92:2: runtime error: null pointer passed as argument 2, which is declared to never be null
> bpf.c:169:2: runtime error: null pointer passed as argument 2, which is declared to never be null
> 
> Fixes: 88cda1c9da02 ("bpf: libbpf: Provide basic API support to specify BPF obj name")
> Fixes: d7be143b67c2 ("libbpf: Support expected_attach_type at prog load")
> Fixes: 8a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>

I don't think that's necessary. memcpy is fine with src==null and len==0

