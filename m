Return-Path: <SRS0=qOzI=SW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC16AC282DD
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D421855
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfDTMil (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:38:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMik (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Apr 2019 08:38:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so9100273wmk.4;
        Sat, 20 Apr 2019 05:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wwki6hVMFYAkNEViaKxQo8vPDzEJR3Hu4BRRdDosy98=;
        b=T9R+5mfpT8Gntpck4PO39tt1BNWcmH3lJvJAl/RZGuu94JUK2BnO4FpojSozCh8l3H
         lOqMSGkUWFqsJW78xG9g8kFMVz+dMV5OVmug4YmbTIRI8x7ZwgnHbrcgG6D0CC0Bo/5w
         SrgUvjBX7GqPbTbUet2bQSD823u46UR0p2l36sme5Ap9X4UdRsSiPmuwBfQpVWWTSPbj
         bcAhBCv61dmf9flgWNDYGt6MAsYtzQdQ7dafx151br/08+QBs1ffE9qw6+MaXjTyxb/J
         YgSd412pNmRzfWgj7v7quFSIlPN8rnOfkeK/nhoWlvlsfLOEVZ3vN5kz/JS5hr1hJsZB
         7bYQ==
X-Gm-Message-State: APjAAAWXzf5Oebq3JmqeqZ+2ByPadhY/xUHB1ROzyQVHAHXJKuMdCDJv
        74GGJTq7lme7RFeNfqSzGgc=
X-Google-Smtp-Source: APXvYqytyt9dhkxGdZB6NMqsPURCuQ+Qz88YDS8LyHjNNNzqHJQK/2+O4/jkOiXGEIp9inw9f2Pb4w==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr6103527wma.53.1555763918963;
        Sat, 20 Apr 2019 05:38:38 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id s12sm6052787wmj.42.2019.04.20.05.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 05:38:38 -0700 (PDT)
Date:   Sat, 20 Apr 2019 14:38:27 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 0/2] bpf: mark registers as safe or unknown in all frames
Message-ID: <cover.1555761008.git.paul.chaignon@orange.com>
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

1: sk = bpf_sk_lookup_tcp();
2: subprog(sk) {
3:   if (sk)
4:     bpf_sk_release(sk, 0);
5: }
6: if (!sk)
7:   return 0;
8: return sk;

In the above, mark_ptr_or_null_regs will warn on line 6 because it will
try to free the reference state, even though it was already freed on
line 3.

Paul Chaignon (2):
  bpf: mark registers as safe or unknown in all frames
  selftests/bpf: test case for pointer null check in subprog

 kernel/bpf/verifier.c                        |  6 ++---
 tools/testing/selftests/bpf/verifier/calls.c | 25 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.17.1

