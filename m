Return-Path: <SRS0=yg+S=4C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F08C3F68F
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31942082F
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq86TUJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBNW23 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:29 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:41095 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBNW23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 17:28:29 -0500
Received: by mail-lj1-f179.google.com with SMTP id h23so12391031ljc.8;
        Fri, 14 Feb 2020 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9n+R3ijwPPaVq0VQpZW564wlW6k2sDGec5BmReAaN0=;
        b=Hq86TUJpAisORc4WL4/w5KI0g8NcH7qNqcfmhxXuoyCyjsg1n/gZZvxIwPeXHHQ4yB
         86r4S7pt5A7AsJnIYMYBZdTit98IcehvwQHpkAleD63Q8XxfvwNcXxEhTJORGITrpUMG
         ax8DOnB00bW5gTL3ZRryTilxp8xX3SkeIgb0KLcf85D8DGmLSufIgm2QvfY+//d21vN1
         BHB1zOcZxgEa4GBJtuvP0BHhXrMAyW3F+dR1skRUC3xGGqrCwHRyMB/eRsggkjTiZn6b
         w44VxsZJit0jucLM9qWjoVNr9bWGL2xysrQAV4Xm8Uiou62w7Hx+18aZOYd6pV2Ih6XZ
         nt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9n+R3ijwPPaVq0VQpZW564wlW6k2sDGec5BmReAaN0=;
        b=qAlc4fPDoIkcisAtjYqh+f171gui0pFT0oh27rxM80l1A3J/TZBOrcYnghksVlbB7M
         6qEVPU2YjzIzQ1XwZC3bDGvnB/6SWsNyf5+qbO3cS4RLOMoGVVYEVUZ/45uOJZqTWkQZ
         X0YOa9YrgkJ7cHNlg7ukcYrAIuLPUQYiH7eBiEQm3RqAMZbSNE4xcNFNun4F+9EWXRi8
         ReChvJGE2bvz8GV6L74i5BytMy/B2dkHNcTz8AISEEOKA2Ae4kY5CzO4g2drfdvq8zHs
         jC5Rb6f1AbrLBE3Hvght4ZQN6sY0D3PzwCLjFchZ0IMj9d3OMI51/fs6GN1NRANYNLKU
         JRAQ==
X-Gm-Message-State: APjAAAUutTtNhNj2FR+G8ZgJsJkZM3XAM4NMJ3pimfzOCFmpkqc6p0a9
        yI3Pi/opgAR8lKcvUupSAbrXPMpVa4LPx+WklvsslQ==
X-Google-Smtp-Source: APXvYqwf/0ZI+UGWANGHK0rw5ferPMwpijxKROZf2scwsfHVLn1sML4mLk8m9dznGJd/va+mHxDz7dwijGL+zxUYKSA=
X-Received: by 2002:a2e:a404:: with SMTP id p4mr3448041ljn.234.1581719307797;
 Fri, 14 Feb 2020 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20200214.141328.1414498612682173242.davem@davemloft.net>
In-Reply-To: <20200214.141328.1414498612682173242.davem@davemloft.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 14 Feb 2020 14:28:16 -0800
Message-ID: <CAADnVQLHmvSXJ8zh+VN8sYOsfk0GGp56my22DkKvg4U52q45fA@mail.gmail.com>
Subject: bpf-next is OPEN too. Re: net-next is OPEN
To:     David Miller <davem@davemloft.net>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry everyone for delay in opening.
