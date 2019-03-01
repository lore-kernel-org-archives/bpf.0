Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7BC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C68204FD
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="A77TUduC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfCASvF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:51:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41397 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbfCASvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 13:51:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so28965880qtp.8
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=r1OmJmZYOQ2jolnAaYqWjQIPSMGN5OIqqu52038hTQg=;
        b=A77TUduC4lj6rwqatECC2IgMhTY12PGeYA+S4q4yn2h3xcQv+HpbXZGsOhNGqq/Vf0
         r3VJlORRhaThWrDTfWDNPVvBxGR6FHK5wAqhU0bDhWp/5XibbBFap08LaUFxF1ZZfCO0
         1aGe2heuwASQdNTD8ydCWq+H1NBxXdwG5GV14f/976zFpCBUf4WWgO93Wk7TcfGhUpbX
         Q2qc5Ik+4q/OEWX8+B5tUglzevsPQelKMpjDUQnyMqrYrTUeFyxsZ1j/GhXNJ4alC6ed
         KfsrnHKRvaJf4FknnUirHKyMGdAnjc5mSSdBfgSyaH+13zrz5QZjM2/d+rEV85BPCyxT
         7PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=r1OmJmZYOQ2jolnAaYqWjQIPSMGN5OIqqu52038hTQg=;
        b=axbTj9xUFF/D6ui4UqG6Zlx86p6XRNO0esbI1n1J0bbyJRCldBzxYPSUCSwXOIozHs
         AyaUg/PAsvDbQkPz7+qtuiWlwDQFLLHKF/V3Sz/gZ1iUETYD/jfCCQzqs4D0EXIrtCtK
         Qp20I4exVUB59nZtGCP3p1kbd5GtdKAGpQzhn8osWYYHEF/Flak2bHnE0zt4ukpL8kpH
         WNASmb2pQoZRoSjZBpTVN41Lfkwk4LUCfK0HGSU6gWXHuFw79g/d5Uq0MOC08AwJ7vUz
         UV1b+nNt5/gHKoi2ssEy0u2cUA9VG36qUWxVrlhuGvA00Vczc7LYfG8F9k8GdVHFwxHq
         IhZA==
X-Gm-Message-State: APjAAAV4AtXyZLqE7H1bDYAOAwqiCxX8OmmmeneGgEuBllcpaQZB2wCu
        9t4oXOpzPtIMdxvSK+EVKgFQuA==
X-Google-Smtp-Source: APXvYqwXIAlPD3sGzQXMCQpRZFo9yobMCxNOaI9m8ms4FZyCrtNtDoCyXlE1D2WY5res01l5i4OB7g==
X-Received: by 2002:ac8:2a57:: with SMTP id l23mr5272066qtl.34.1551466262861;
        Fri, 01 Mar 2019 10:51:02 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o26sm12060229qkk.51.2019.03.01.10.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 10:51:02 -0800 (PST)
Date:   Fri, 1 Mar 2019 10:50:54 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        lmb@cloudflare.com
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value
 access
Message-ID: <20190301105054.727f8e28@cakuba.netronome.com>
In-Reply-To: <93040e2a-cf74-0dfe-276f-0a91598011c5@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
        <20190228231829.11993-2-daniel@iogearbox.net>
        <CAEf4BzYCFw861q-S=7VH3B7d9wQha5WYbNnbi+YU6XEya1ZE_w@mail.gmail.com>
        <93040e2a-cf74-0dfe-276f-0a91598011c5@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 1 Mar 2019 10:49:46 +0100, Daniel Borkmann wrote:
> Overall, BPF_PSEUDO_MAP_VALUE felt slightly more suitable to me.

FWIW +1 I think different type is way cleaner here.
