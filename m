Return-Path: <SRS0=kPz0=DW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90477C433E7
	for <bpf@archiver.kernel.org>; Thu, 15 Oct 2020 04:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294F922243
	for <bpf@archiver.kernel.org>; Thu, 15 Oct 2020 04:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHj42zYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgJOEWG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Oct 2020 00:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgJOEWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 00:22:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D979C061755
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 21:22:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z2so1104535ilh.11
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Somlrf0ExP10Fj8WfOm+BVLtpunVfzX2Kv+d9BC5xZ8=;
        b=aHj42zYfOm75QSl7bzVqS+Vis1sHH8s13SgshSRiF8kWtO2uudolFrp8BX9w866rD/
         zAHh4B6XIgi5uh0CTbEza3BcEnNkzHECUJMBSAYu5c90VWnuBd/fiJAtwZSPEGVZizU+
         DymhhppeB9q2kB6AHjZSQJ0zV97QI/CAa/SOhBJLhRBeoi65DY25peRw9QogLFunsqXM
         85kL7V/j9qpvuWOiAepYGKPOshXs6NYSjT5lSJDhmbhKDUe4PnDMvQW2r3LUBk6+Tmjr
         QqMQLGJkWvFWNdoZ4DID/mNEvp29FA1xEsl4yeJE3FqypHYjHJ7tazZsXIWZzw+xGpiz
         cvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Somlrf0ExP10Fj8WfOm+BVLtpunVfzX2Kv+d9BC5xZ8=;
        b=Hfb5ehxQKDn9cFb53NG2dmlg/XTRvw2rN3vbplJAM6+dR8PJSJzQRB/Cgh2t3EG9+c
         Qx6uK2Ljj36SD5Ws3/T0VqCIKX8Gq2C/m+/h68zvCJNKTDpIA52RE/labT3wcrVKFNBS
         5CN5VXythdm4QMNpiYsbmRr64lmvopCEFDyMgEj/w+Ubt5AtZMOGKtiSRrjs16oMkoTK
         SFTPMgYy5sb1aO29U2x66BZqhMWoTMd+6mekBDIKl9LkArOKGxrhLkQ0ZmQwT+GmUaUL
         FyQDCznCf745OSky4kqc4aodXPD1Gt8fYV5vImPOzinTU7MICSlx2VUJ+yoUtgY9kYoj
         CDYA==
X-Gm-Message-State: AOAM532vJkCaZx9tQW3U5MlciiCFKlrc6a87rlktFQQ83JTh8qnbytdT
        MT3rpcIgqltwFDI2ZAet09U=
X-Google-Smtp-Source: ABdhPJzUGkHe50D4Cqn2Y8PBEyEehsG9cV4sqc9ytfBoyu3cJ6yB9CBF+54Nx6mLG+QyIAicQtO6mQ==
X-Received: by 2002:a92:8404:: with SMTP id l4mr1953594ild.134.1602735725021;
        Wed, 14 Oct 2020 21:22:05 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id d7sm1454830ilr.31.2020.10.14.21.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 21:22:04 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:21:56 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Florian Lehner <dev@der-flo.net>, john.fastabend@gmail.com
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dev@der-flo.net
Message-ID: <5f87ce648edd5_b7602085a@john-XPS-13-9370.notmuch>
In-Reply-To: <20201013144515.298647-1-dev@der-flo.net>
References: <20200922190234.224161-1-dev@der-flo.net>
 <20201013144515.298647-1-dev@der-flo.net>
Subject: RE: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Lehner wrote:
> John Fastabend wrote:
> > I think this is OK, but just curious is there a real use-case
> > that has keys bigger than stack size or is this just an
> > in-theory observation.
> =

> The use-case for this patch originates to implement allow/disallow
> lists for files and file paths. The maximum length of file paths is
> defined by PATH_MAX with 4096 chars including nul.
> This limit exceeds=C2=A0MAX_BPF_STACK.=C2=A0
> =

> Thanks,
>  Florian

OK the check appears unnecessary. It seems a bit excessive to have
such large keys though.

Daniel, Alexei I couldn't find this patch in patchworks, not sure
where it went.

Acked-by: John Fastabend <john.fastabend@gmail.com>=
