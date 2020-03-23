Return-Path: <SRS0=tLdU=5I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D2FC10F26
	for <bpf@archiver.kernel.org>; Mon, 23 Mar 2020 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7852A20409
	for <bpf@archiver.kernel.org>; Mon, 23 Mar 2020 05:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zSP9ZmWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCWF7h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:59:37 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:32977 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgCWF7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 01:59:36 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ce0b89dc;
        Mon, 23 Mar 2020 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=WGVu87ZQHczmXiU67hTSuzatHAo=; b=zSP9Zm
        WUXLzVQbEwKRdvEoh5ukKhmqrINAfkRC1gGeI3jCMxKP5MfpeVaATXJnfpvtjvLw
        smfyAgm1vlUTPg4EbZ0hhIwbXXWIrOI2uQPoezg5MZKB04b5snK7VvXwpjmBrTrS
        F3OIqc4NuM4qmc8U1Vr8vfqStA2/MDoB1jlN9ZhavmwJWaal6BmTV9RKIelgescc
        knbSA2NBANlWninhJQFFIbMUxiQsR63+MVCDAjR8iH4aRNQJOGu9J06khdvvkFCR
        V/cZCuomy6jXWZyz+tMMUsqg5TnSM86y0YGl6cP/IlTeBSfwVu+QQXEkydUH32ru
        f4BV/jnJzvXQHcxA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d88e9016 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Mar 2020 05:52:36 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id k9so2200433iov.7;
        Sun, 22 Mar 2020 22:59:33 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0Uo4TzQ+qdDYyapmtqxSnBAkIL9EOD487TEwqTT16S1dWVmUjK
        9ri67Rsh90tZMCLUK4d4O3GG9nacyAjx0GiaIS8=
X-Google-Smtp-Source: ADFU+vuS6lmYSQJZ4wcu6LiQ2nO9kUZ2TdbidnYPjVlBmBOnTiMb5KaneGoPl4TYqZHi4GoDrbke+7cgnNZ9PDR+YpY=
X-Received: by 2002:a5d:851a:: with SMTP id q26mr9616021ion.25.1584943173125;
 Sun, 22 Mar 2020 22:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
 <50c6bd77-fb16-852a-adcc-3976550f6f81@fb.com>
In-Reply-To: <50c6bd77-fb16-852a-adcc-3976550f6f81@fb.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 22 Mar 2020 23:59:22 -0600
X-Gmail-Original-Message-ID: <CAHmME9r+anBCRihmhi-Jsy6o8bcZkbwiRRW2ZYytUd5uTrha-w@mail.gmail.com>
Message-ID: <CAHmME9r+anBCRihmhi-Jsy6o8bcZkbwiRRW2ZYytUd5uTrha-w@mail.gmail.com>
Subject: Re: using libbpf in external projects
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, nicolas@serveur.io,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks! That's much nicer to use:

https://git.zx2c4.com/netifexec/commit/?id=8a39f70c981264500d27e90bbd5e3baf8f2d10d3
