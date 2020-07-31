Return-Path: <SRS0=uiV1=BK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE274C433E0
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C820791
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 23:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trcI3tLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgGaXcu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgGaXct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 19:32:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C4C06174A;
        Fri, 31 Jul 2020 16:32:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d18so33297894ion.0;
        Fri, 31 Jul 2020 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/gengMCi3Uw6McIEMAFan1JWFgKWuADV89A46l0yRrE=;
        b=trcI3tLnnNLytOeFbhOBMgBS/h0bRCyNyUrGw9J/on9Sa6Ac2invyYJ9+9ponORuaN
         nsqo776VDvKVbX8U2kK17jM9+eWuy5DFDSbWLKzPFEZ/NJwjaggO5AyFUsB3my1FNGac
         g2Q+r0I7g8SFh8fPbdME9wAt/pWHWxR/MtqO5sNgirftLbDuMmdolKwqn11cySF5FrNF
         erBh9o95WfRxntjy2T0QbF6+hCYOfbVt3KKs3Aud9nMOIYG/R26QyvRSIOH6H/oo9MEo
         O5j8tf4VcKA9kjh9/I+kybTG/DA3NR18fhQNZVYfts0Zudwf5S2V7KrMmBt8miy/4ntp
         jhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/gengMCi3Uw6McIEMAFan1JWFgKWuADV89A46l0yRrE=;
        b=bN23yurcnmrcKvBvEgYTbIWEqe/dcb0iF7shw7pEfxDiGFeKqHhYOOkc6RqCA1lM+R
         iJnkU2LWrOnfBWPKve/iHIi3k/DO1I99r54ffHQ4STFsdgz0rzu9AWqv/GlcR1avS0U4
         a/J3fNAA4iHPIwVAJ+yBaCnDDEGdq7/k/VZmxMrBxSytu+jnRNhuPa4+xUoTZNvrvgOz
         9nrLvDiOKcAEXXegL0FuslqQVr3FOyOpYaK/PaQiw7Bn1vmhTVU2BLQC1dbsIaALRFby
         Mm3NuPlrvm2UY0jEKl/eP29iFo3iPAz9HMmQvKKtD7wGe+CtqYiI0qnzu5s1Mu7oVfh5
         U0fA==
X-Gm-Message-State: AOAM532j+3wDzEZmHZ4SaI5PY4KKonryJrdUSew37wdCooPiH5XX3sGu
        SFtJhXdC2ecUgIplAG5qAa8=
X-Google-Smtp-Source: ABdhPJxdmV3Vf6TLh1ZCR1vlHCLJcIP6yKZwYb5b8es4CexHol1Aqox9xbycCCPefbvH3fh2lrxxXg==
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr5980930ioq.130.1596238369174;
        Fri, 31 Jul 2020 16:32:49 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id i10sm5631999ild.29.2020.07.31.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:32:48 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:32:41 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>
Message-ID: <5f24aa196a637_54fa2b1d9fe285b47e@john-XPS-13-9370.notmuch>
In-Reply-To: <20200731182830.286260-5-andriin@fb.com>
References: <20200731182830.286260-1-andriin@fb.com>
 <20200731182830.286260-5-andriin@fb.com>
Subject: RE: [PATCH v2 bpf-next 4/5] tools/bpftool: add `link detach`
 subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> Add ability to force-detach BPF link. Also add missing error message, if
> specified link ID is wrong.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
