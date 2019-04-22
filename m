Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E61C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C8920684
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfDVSeN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:34:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33456 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfDVSeN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:34:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so503629wmi.0;
        Mon, 22 Apr 2019 11:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kmwM1rzPC/xqtlc/U0P8jIajWriBBI9OVjex7mHXR5I=;
        b=XQa0xm+JzUW2CZYjoyKBKV8UTmqcxHyjl2x4wfWZoK19XGFTxRo7lRta0r3oafDO+x
         cWd33ROHVi8eE/B1XJRKli8JsfmPCVQV6iS+wj3BpRxZMByGt6oFAdWN9btguc9QhfFT
         pWIErp5MqY9WxarFztYc6BuCSC79IlSDGlb4tRNUz7o8cAxoHff9MHEYuNGEw91RiJn+
         xnHpSY1IXpsjo1ow4D35fPbIXJkEM0EGE92AwiM4EtVoe9XD6Nkc87uOfdj71E2joOzL
         Wxg868JPmawmGMt9/ko2DLt89ZPBh4M7me1yvhWPrNuLS0he13wnY6VGFXACwpND47Ka
         2TJw==
X-Gm-Message-State: APjAAAWGJKVVjLuUQDAHUmIx3NpT4N1VoGvxKMhZSMaN4wwWz+0szLlj
        JHMMYcBsjiPddOIwQyLRPZc=
X-Google-Smtp-Source: APXvYqwlBagGPGne1VrYGeYYtZQ9Bop1MqcTxUmD64HOr1v6siHUh9hzS3jA2s0t1sVxbvx6GivsQg==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr13906730wme.105.1555958051651;
        Mon, 22 Apr 2019 11:34:11 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id i28sm32275224wrc.32.2019.04.22.11.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:34:11 -0700 (PDT)
Date:   Mon, 22 Apr 2019 20:34:02 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 0/2] bpf: mark registers as safe or unknown in all
 frames
Message-ID: <cover.1555957346.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of a null check on a pointer inside a subprog, we should mark all
registers with this pointer as either safe or unknown, in both the current
and previous frames.  Currently, only spilled registers and registers in
the current frame are marked.  This first patch also marks registers in
previous frames.

A good reproducer looks as follow:

1: ptr = bpf_map_lookup_elem(map, &key);
2: ret = subprog(ptr) {
3:   return ptr != NULL;
4: }
5: if (ret)
6:   value = *ptr;

With the above, the verifier will complain on line 6 because it sees ptr
as map_value_or_null despite the null check in subprog 1.  The second
patch implements the above as a new test case.

Note that this patch fixes another resulting bug when using
bpf_sk_release():

1: sk = bpf_sk_lookup_tcp(...);
2: subprog(sk) {
3:   if (sk)
4:     bpf_sk_release(sk);
5: }
6: if (!sk)
7:   return 0;
8: return 1;

In the above, mark_ptr_or_null_regs will warn on line 6 because it will
try to free the reference state, even though it was already freed on
line 3.

Changelogs:
  Changes in v2:
    - Fix example codes in commit message.

Paul Chaignon (2):
  bpf: mark registers as safe or unknown in all frames
  selftests/bpf: test case for pointer null check in subprog

 kernel/bpf/verifier.c                        |  6 ++---
 tools/testing/selftests/bpf/verifier/calls.c | 25 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.17.1

