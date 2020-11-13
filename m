Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8CC55ABD
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974222242
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 20:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfq/qwMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMUD4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMUD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 15:03:56 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B9C0613D1;
        Fri, 13 Nov 2020 12:03:55 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y22so10037853oti.10;
        Fri, 13 Nov 2020 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PkXzT+TPkhzSpI5w/HoXFjA/QANuhpY1HWs2a4izh2g=;
        b=bfq/qwMsoWDG1/lVdsXFvjuV9aHUj1IbCjW8MZk0SjxysU0ya7HR5i6+VLhDRnRZCS
         vygkAe1MB2sDTP97vzF19eTzChYBfNERIshkv3zvSzuDpzkwB7FjnKqMBtDMcAvKpIHb
         9osBxZAuRd8//wJc7pmwcoy1bT+vS6JBLW/PGpmHKHSL2dl/biUvHFYOmTQ3QwRFlyuU
         sJg9OprwBAlWRXDmq20hKeKR1eWZOeekWyaR8SDoG25CckR+u8YqtNRpZDn5rhf+O9eg
         PidlNEbym7E8xKBZJ5u8oSMCVP/vTDYzH24tcn2HQhR9oCwM7brxxT7+gcVL8ywk5KjU
         tbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PkXzT+TPkhzSpI5w/HoXFjA/QANuhpY1HWs2a4izh2g=;
        b=JeV61tEwX0lOFOo0WPDRSww9fx4GGqXCC4oPVRrCLShIPCSG+Wc/L7ARlk4gfJgN2x
         MV1VpiXeG7Ha8mrF2kvzHxAU3DNqdsd2BHPtKJ9CB42dQWTJkpUpfCUZxaC5TnnD0ncE
         WjnoZfCOUofQH38Cds74snQD6cL5OP2f8lC/ZE8biNNMcxSbNB5FV0/xq32anywZQJwO
         1utbsP8ty+UFxIBJj8upy+TC0j9eQjqKeOyrbuPPlAgHwJ//l0KFgvrGQtQqOhggKfxR
         6cTC56nwI9mIVPW3V+sXatyJb2uLyDq356YJGH2iBuryQ4zIyE625V/NocqSTUJfgqOw
         MvsA==
X-Gm-Message-State: AOAM532K9UfqBYr3x1zz3GjPzxOdxm3POautUAAsU72ZLEH7X9PvE01i
        AFRWpwgKYo+xMyj2AAJUUV8=
X-Google-Smtp-Source: ABdhPJyptrFQLDc69fr3fw2A/InfyRB2ExyrccDujxupClfGMNcVVsSaige2+Dvf3QIm446M+7lmKQ==
X-Received: by 2002:a9d:222f:: with SMTP id o44mr2811308ota.321.1605297835061;
        Fri, 13 Nov 2020 12:03:55 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id w14sm2266948oou.16.2020.11.13.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:03:54 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:03:46 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org, john.fastabend@gmail.com
Message-ID: <5faee6a263382_d583208a8@john-XPS-13-9370.notmuch>
In-Reply-To: <e190c03eac71b20c8407ae0fc2c399eda7835f49.1605267335.git.lorenzo@kernel.org>
References: <cover.1605267335.git.lorenzo@kernel.org>
 <e190c03eac71b20c8407ae0fc2c399eda7835f49.1605267335.git.lorenzo@kernel.org>
Subject: RE: [PATCH v6 net-nex 1/5] net: xdp: introduce bulking for xdp tx
 return path
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi wrote:
> XDP bulk APIs introduce a defer/flush mechanism to return
> pages belonging to the same xdp_mem_allocator object
> (identified via the mem.id field) in bulk to optimize
> I-cache and D-cache since xdp_return_frame is usually run
> inside the driver NAPI tx completion loop.
> The bulk queue size is set to 16 to be aligned to how
> XDP_REDIRECT bulking works. The bulk is flushed when
> it is full or when mem.id changes.
> xdp_frame_bulk is usually stored/allocated on the function
> call-stack to avoid locking penalties.
> Current implementation considers only page_pool memory model.
> 
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h | 17 +++++++++++++-
>  net/core/xdp.c    | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 1 deletion(-)
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
