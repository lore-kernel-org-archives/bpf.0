Return-Path: <SRS0=Rse5=CU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6757C433E2
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9E221EB
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 17:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="0mB8mslJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgIKRBq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgIKPEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:04:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D0C0612F8
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:55:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z25so11295035iol.10
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yo3dy5Vma+egQOknSTT7v4G13EtMgJGHzgkRhn8Lv4U=;
        b=0mB8mslJ9ZnR0jUvPq3QKut0MVyc3f0/yD0wvR/b5hayQcJxZmp5sgdloSJ4tDx9oS
         69WJx12+D+KyxFfpBy6lO1AB2uD2fyMbpJTwWQhUiJvQdsZ/ziGW28kwaYFQi7PiF+Tk
         u+13LDocqY6r3ZtqpsrsjB0VmW+p7sQQJz1oB1VnhG3Dk5LdX7FsTg0YwoWOBq8KihdN
         He1PNydnYqj0IqQkIEVo9kCIMNUex3z2F+9Vb944tllwOIuRFuQOGJyQLpmBC4azo6q2
         e0Zn39nxhgYgOKCgQ+u+Ak6eq0K4aZpTMakQCqC+CCMd6WquM4iNLezWprRz12BWC2j0
         kHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yo3dy5Vma+egQOknSTT7v4G13EtMgJGHzgkRhn8Lv4U=;
        b=S5japk+ooeDu08oH8Ok6Hm2HKgdRC6HdYmQDKkUxak3jjfjZhX01Mm2aiavMZZkufs
         YCCpw1dkH+tbrS5tG9pSYV0/tjqq/D4sxw2+ktaCs/OY74D6bkDeiGv0ekWYpOy+tjvk
         Bx3ONZrkvoinMLjf/6oto/BZO0SbvbUCyMAuSLslL3E16l/1bQng0M2np/4tiqJkgQt6
         TvTa6rw09isBpJ/H9u3jZltxFBLh5VEOZb3Pkg46u5tZ5pxxsCHvotFKrlpVYAhWZgff
         wtLmaL+kY16ZAVi+a/Du6iOYd2hKkQXQ7RISk4Mexrox03hikNICeNsufGZeM+zHSGDQ
         OPSQ==
X-Gm-Message-State: AOAM531Rf/1kt6vTslxiEfA27ghGDfQl9+xYLcpf8CoOQNDIR8OfgZW2
        L3DX62EqYcQw9pXbrUkLOOPy42imrMuN8ewzpKZ3OmANtUsq+2zT
X-Google-Smtp-Source: ABdhPJwh97MiplAFrPeWrGy1f3/KGQ0YjxM3uvPnjeSO7PZaqxYxXTr4uEQkOGdiPaFlAuyfGtT4aSLWLtoFY0GcGPM=
X-Received: by 2002:a5e:9b0d:: with SMTP id j13mr2052799iok.210.1599836150019;
 Fri, 11 Sep 2020 07:55:50 -0700 (PDT)
MIME-Version: 1.0
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Fri, 11 Sep 2020 16:55:39 +0200
Message-ID: <CAGeTCaXCwN6XLNM6u6r+2_DuqQ+GFbqdZah345P38U9xOntMeQ@mail.gmail.com>
Subject: map_lookup_and_delete_elem for BPF_MAP_TYPE_HASH
To:     bpf <bpf@vger.kernel.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

As far as I can see, `map_lookup_and_delete_elem` is implemented only for
`BPF_MAP_TYPE_QUEUE` and `BPF_MAP_TYPE_STACK` [0]. It might be useful to be
able to do this operation on other kinds of maps, e.g. `BPF_MAP_TYPE_HASH`.

If I'm not mistaken, it would have benefits over `bpf_map_lookup_elem` followed
by `bpf_map_delete_elem` in regards to avoiding race conditions.

Is there a reason this functionality wasn't implemented?
Is it planned for any time soon?

I'm looking forward to your input.

Best regards,
Borna Cafuk

[0] https://elixir.bootlin.com/linux/v5.9-rc4/source/kernel/bpf/syscall.c#L1501
