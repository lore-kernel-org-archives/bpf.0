Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C95C07E95
	for <bpf@archiver.kernel.org>; Wed, 14 Jul 2021 00:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB7761370
	for <bpf@archiver.kernel.org>; Wed, 14 Jul 2021 00:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhGNAan (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhGNAan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 20:30:43 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF542C0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 17:27:51 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e2so8490424ilu.5
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 17:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0ogzIjfu8RHZZ1KmbxAqBf4mddcvtrKOnk/j+D06Q/c=;
        b=WK5xWlKIVl23wruMyqYxOU/4G1Kyi4LCN5vHKx5tzSQAL/bEFNX432Er/pyLTj+Mu7
         H6FlOOI3dSTz8hxsZfaSlA60urusW1iBX9fB4NwN0lT5kwEUj/6XxUf9fpbXbmWH//Me
         /vbdKmhxhLrAjTZN+oUl4Q86vFQM7yt1IsJ8dc8ywDp6vOGouu/8uuSDtcuwUKU/O8/+
         B7kssjKcIBTHGD9g8GNXzEDkIE+TLXiIbP2UBgD8FNYY0cSSyjnMEXjSmyz/iOpHqGyG
         pJyKvcaXiUEhlTjagEL8mPM+mvEu6sbFTUKQg5ng5xCFc/7lQ+9tnQe8iCHuR/O2Ps0D
         nfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0ogzIjfu8RHZZ1KmbxAqBf4mddcvtrKOnk/j+D06Q/c=;
        b=fjBK5WbcxlBOl++FvhL/eXqw3R6aAVLHHd1SUwq9ELGhntbjUe1YqBKoSxbifMITX8
         w26+r/Xo4L07LruEGUfF9RJcBkFxMl0Bz6ZHkrDYu2TaJ5FZO8soiWqVo6hOZsAXqx6p
         NkCfk4gKS5J0IbashQIrVFNCec1Yjk+LjJPjWQtuvUY0LTotiKo4t9Ulim8oVAxJI9U7
         W3LWa5/wjiYfgH24yiq/eCCyi4XgjvCR7t4i7HpUbri568qG1dIzMJeQlkzcELdlmsR/
         6MKeOiNAToHR4i1yONpdJqdDLvVPGgrgF8njAPtbth5R7knaq+iRrLueNkXy/4Ysw2cR
         JSpw==
X-Gm-Message-State: AOAM532msuNTxOP8RjsNnD9k1Dwcm3uSdCItJj3SPbB+TCrO0XOgKbpH
        PRSJYFyJmit/JHuJkbcqr3o=
X-Google-Smtp-Source: ABdhPJx7CyhFosLTdjQni7Hob22QYSAwcIW3pf27YNNbN7nMrLcIf/Stckw42iFoUZrN7DBeq1Q16g==
X-Received: by 2002:a92:ddd1:: with SMTP id d17mr4543085ilr.46.1626222471280;
        Tue, 13 Jul 2021 17:27:51 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id x10sm324591ilu.33.2021.07.13.17.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:27:50 -0700 (PDT)
Date:   Tue, 13 Jul 2021 17:27:43 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Message-ID: <60ee2f7f9f787_196e2208d5@john-XPS-13-9370.notmuch>
In-Reply-To: <CA+FuTSes3Lr0yGTc6GHGzgfPz4w6ReP_vnMKn=OeVhWgcpcOqA@mail.gmail.com>
References: <20210713102719.8890-1-tklauser@distanz.ch>
 <CA+FuTSes3Lr0yGTc6GHGzgfPz4w6ReP_vnMKn=OeVhWgcpcOqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unused variable in
 tc_tunnel prog
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Willem de Bruijn wrote:
> On Tue, Jul 13, 2021 at 12:27 PM Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > The variable buf is unused since commit 005edd16562b ("selftests/bpf:
> > convert bpf tunnel test to BPF_ADJ_ROOM_MAC"). Remove it to fix the
> > following warning:
> >
> >     test_tc_tunnel.c:531:7: warning: unused variable 'buf' [-Wunused-variable]
> >
> > Fixes: 005edd16562b ("selftests/bpf: convert bpf tunnel test to BPF_ADJ_ROOM_MAC")
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks for the fix, Tobias.

Acked-by: John Fastabend <john.fastabend@gmail.com>
