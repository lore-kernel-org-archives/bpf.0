Return-Path: <SRS0=KgBP=BO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E6C433DF
	for <bpf@archiver.kernel.org>; Tue,  4 Aug 2020 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AE2206DA
	for <bpf@archiver.kernel.org>; Tue,  4 Aug 2020 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbhAv3x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHDAyb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHDAyb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 20:54:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64857C06174A;
        Mon,  3 Aug 2020 17:54:31 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f68so10879604ilh.12;
        Mon, 03 Aug 2020 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FLanpbfEXNoGXGQOL+bOfAO2qa0IL50hckyia7QK3Tc=;
        b=ZbhAv3x7ONxovUTA/zUtNnsWmNkMCXyiTWisNBO7+kOE/dISbPEtFQ2a0Ji4DdERZw
         f8LM4Y5IilL4bq/Sl00zlSM06LKkauaXgFFGfGLi5iJ0KCTdNS7mZaYX/Kha1xFuvNV6
         hYUI2tWB1kVHpKyZbfr1JS7iLrx4WV4oWtRd2kD+I9JooIpwL5J6hiLeUE4jWqiTJQrU
         JAuwPCam9sgoPlhfCyhdtzOOEz0qjjg8IszQBmuqyvAuQrlNgxLRUHNPI6OvtsceKorn
         tDsWUxEzYxZfS5rIxSrNoQDaZ0lifH0GCM4RIu97Yi0vm88PCIz30Gr68rUQY+FKkp8D
         3Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FLanpbfEXNoGXGQOL+bOfAO2qa0IL50hckyia7QK3Tc=;
        b=IjAvT9u/WKGCIORx+SGza0hyTHdQ1U7dqgKFAeGCmBOVf5xsrL/378QGooMbFGFRFe
         jtYmJeX2djSuE3TUeJ1/C8c969JTZqrvQihbKtJdvIFYFCnLP7hvbtpgO1FYP5kHA46P
         22UnbnbWZC08/7qQRxYmxOR+06xWMtlwwmGIKahyQhdKRaksqLZeysEX+cow4va97DI+
         ySdHxyAPv9HY/qGBzDOBO5omAOWRY/fMoZaUOIJeXhAlOU+v6Jx3CnsskQy699jJl4op
         bF1E8p9wPGCzIdU6QMITJ0H+14BzbCr8iU3XuDxOuh4Ao+kb5ms140rRpA6Kf/V4ZdMo
         jeOg==
X-Gm-Message-State: AOAM533yDf0Iiqbanak6ArphuoT+kk4YOH7QBpHAmbPtWp8/CN74H4XH
        T8rkUT/iCiKSEswBEVqM6sc=
X-Google-Smtp-Source: ABdhPJxivrYL0aFBw7yZpb+2Dh2XxdEp0a1yS+Iqi/BlEMmtGHnepW8QZUBcnqKloIUh87hNw0F7fw==
X-Received: by 2002:a92:1814:: with SMTP id 20mr2310227ily.81.1596502470869;
        Mon, 03 Aug 2020 17:54:30 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id f132sm11019233ioa.45.2020.08.03.17.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:54:30 -0700 (PDT)
Date:   Mon, 03 Aug 2020 17:54:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, kernel-team@fb.com,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
        Yuchung Cheng <ycheng@google.com>
Message-ID: <5f28b1bf96cad_62272b02d7c945b4c8@john-XPS-13-9370.notmuch>
In-Reply-To: <20200803231019.2681772-1-kafai@fb.com>
References: <20200803231013.2681560-1-kafai@fb.com>
 <20200803231019.2681772-1-kafai@fb.com>
Subject: RE: [RFC PATCH v4 bpf-next 01/12] tcp: Use a struct to represent a
 saved_syn
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau wrote:
> The TCP_SAVE_SYN has both the network header and tcp header.
> The total length of the saved syn packet is currently stored in
> the first 4 bytes (u32) of an array and the actual packet data is
> stored after that.
> 
> A later patch will add a bpf helper that allows to get the tcp header
> alone from the saved syn without the network header.  It will be more
> convenient to have a direct offset to a specific header instead of
> re-parsing it.  This requires to separately store the network hdrlen.
> The total header length (i.e. network + tcp) is still needed for the
> current usage in getsockopt.  Although this total length can be obtained
> by looking into the tcphdr and then get the (th->doff << 2), this patch
> chooses to directly store the tcp hdrlen in the second four bytes of
> this newly created "struct saved_syn".  By using a new struct, it can
> give a readable name to each individual header length.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
