Return-Path: <SRS0=pSPe=EC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E617C4363A
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AC12067C
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUUyctzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829551AbgJ0TPp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:15:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44003 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829545AbgJ0TOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 15:14:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id o9so1265443plx.10
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gV/VVwoohxFwknw5Qn01WhfBtKTfE0pEszhFmiVXe+4=;
        b=bUUyctzcMSA6GV80xlX1omAD5lD1Q6cPzFS+DHgg4vnT5jm2fUe+9kyTyf1UtGDex9
         e7+aXR4zgdP6JfIYXGGlXWxmD/enEyR76EowHH08WydLVpuwbGdyeqYD7pW7wyRu24Ni
         cTpdJdaLJrOKGJEyA3oq5BVxfJ0ac1hK5p9Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gV/VVwoohxFwknw5Qn01WhfBtKTfE0pEszhFmiVXe+4=;
        b=deRprg4rp4yEy9xz8BGm9fcjCp6zlbgxqn+2X14HT+qfU3E3k+0PWGD7pSe06NMliS
         uYqtrIEAVcorYhQDNFW0cfEK52Xg3fsTLNlkEj/ftmEJ1Cbx5FvJUjaC90j4w0f5M1vR
         FrCF+M7jCsJoiSH9Jt71wwFr1wnmL6IIlpxD+dTO+LkJke5Djh2G5SgB07OvkDhHLp4X
         vKw7eL7YVyfDJxaRtDPv99awqZGm86YcfWOOgsA8QTVL0QCrTqjMmfs5m11CvX3Ayill
         UTlbvzNgcqi4ORkmVCFvIC7XrpsRn5gWryUO1xn6vx5fi3sqjbM2EZ8WY/ZprT6qxYuK
         EtSQ==
X-Gm-Message-State: AOAM533UPlyc3ALXOUdaBGAJDuEPkHyxPvAZq82m8gn1KOriFB805lsS
        7gPeRvKmcjxB+fgLljhMKr4zuA==
X-Google-Smtp-Source: ABdhPJyjtnpaZtReoire0YN/na6kS75vBmwzx3v3ddCq2YUxAsi++zqYgZgj/AIU9QAB6+bqwbbOtQ==
X-Received: by 2002:a17:902:6a8c:b029:d5:da81:dc42 with SMTP id n12-20020a1709026a8cb02900d5da81dc42mr3990687plk.40.1603826094485;
        Tue, 27 Oct 2020 12:14:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm3052970pfd.217.2020.10.27.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:14:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>,
        containers@lists.linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>, bpf@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v5 seccomp 0/5]seccomp: Add bitmap cache of constant allow filter results
Date:   Tue, 27 Oct 2020 12:14:50 -0700
Message-Id: <160382601078.2318738.11754677445961373147.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602431034.git.yifeifz2@illinois.edu>
References: <cover.1602263422.git.yifeifz2@illinois.edu> <cover.1602431034.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 11 Oct 2020 10:47:41 -0500, YiFei Zhu wrote:
> Alternative: https://lore.kernel.org/lkml/20200923232923.3142503-1-keescook@chromium.org/T/
> 
> Major differences from the linked alternative by Kees:
> * No x32 special-case handling -- not worth the complexity
> * No caching of denylist -- not worth the complexity
> * No seccomp arch pinning -- I think this is an independent feature
> * The bitmaps are part of the filters rather than the task.
> 
> [...]

Applied to for-next/seccomp, thanks! I left off patch 5 for now until
we sort out the rest of the SECCOMP_FILTER architectures, and tweaked
patch 3 to include the architecture names.

[1/4] seccomp/cache: Lookup syscall allowlist bitmap for fast path
      https://git.kernel.org/kees/c/f94defb8bf46
[2/4] seccomp/cache: Add "emulator" to check if filter is constant allow
      https://git.kernel.org/kees/c/e7dc9f1e5f6b
[3/4] x86: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/1f68a4d393fe
[4/4] selftests/seccomp: Compare bitmap vs filter overhead
      https://git.kernel.org/kees/c/57a339117e52

-- 
Kees Cook

