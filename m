Return-Path: <SRS0=jPHo=WZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C080C3A5A6
	for <bpf@archiver.kernel.org>; Thu, 29 Aug 2019 10:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7352B2053B
	for <bpf@archiver.kernel.org>; Thu, 29 Aug 2019 10:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="szNMJLYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfH2K5C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:57:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfH2K5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 06:57:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id t9so3331894wmi.5
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=V48A0d02O6Zz1PNIZqcK4fmc9jSgKnu0iuclFkazHTM=;
        b=szNMJLYMtcVYjo6S4+ThfKliFq245mqyL3fCf8Xq1tmQyNaTMIkGJ44SN4T3a9Ts28
         30ym1t/4vNXyDDp43RyTj5Rkuxi447a7mgE8jhXLCPhhAOjI6+cWSNn5KuSk7scLU+lF
         1FEp8w8e3a6qf7OY76rXtlAB2t+AAB9jc12faO8lHLdhV7uOMxTPyjvVefaN5HonJY+6
         /4CHwjzXjfW9NUM/7NrQo7gnoPUl2ZKEEMQW92iCeZuP9xDxFB70VtOEcnE5QYnJ0NEI
         MUWYPpUr+5YPyKPzq8JWH3EJQe1IrS1EeYK8l0dTBhT12w6BbyPdvK92DLuLAPYT1DRX
         B3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V48A0d02O6Zz1PNIZqcK4fmc9jSgKnu0iuclFkazHTM=;
        b=JykxSdbW+WBSL1AHpIJK8ZzPuBaQ0jNQPn2z8Riwt58oNK4YrQA3VxYw4Wb9f6Px/6
         JQFfrHkSfDgytr7OA+tikAHiEHIhTxqGkSrECQBsMnna5sfUN5UKh1cT4JU9ZqjkGYuI
         ZRXrEoh6/m187xmIjx+yfMNw1uLkad/o2eCkya7OeUNFL0ciFoBbQuQ/+/dpty8iaxBb
         h1IWUiDaFocyx8XoxdUt5Nd6sWMAHMXnexPqGrj9gHTEiweQFsqN5+Nectp+QIK1BqPP
         bWrGMoWRDQSg4bZ2O6e0KdHhzd5ZKyeQ1rIJpSbedLXpM/UXVAkO0EYpShxgzptcZMX0
         Hn+w==
X-Gm-Message-State: APjAAAUSgEq7XUbLUN9+sA2LaFguYqSHuF/YHp5SSIxTJ3B39xjyPU1g
        MZTH+tp3e/8eyh7yyuPcjQNSJA==
X-Google-Smtp-Source: APXvYqww27sgIBuv7JIwIuZkS5SCLc+TbWa0N8DnpGZwDPmOJkiHy9A/sbxGzPquNpN8qb/JrcfSRw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr4769098wmc.124.1567076220190;
        Thu, 29 Aug 2019 03:57:00 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id j18sm2091938wrr.20.2019.08.29.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:56:59 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 0/3] tools: bpftool: improve bpftool build experience
Date:   Thu, 29 Aug 2019 11:56:42 +0100
Message-Id: <20190829105645.12285-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This set attempts to make it easier to build bpftool, in particular when
passing a specific output directory. This is a follow-up to the
conversation held last month by Lorenz, Ilya and Jakub [0].

The first patch is a minor fix to bpftool's Makefile, regarding the
retrieval of kernel version (which currently prints a non-relevant make
warning on some invocations).

Second patch improves the Makefile commands to support more "make"
invocations, or to fix building with custom output directory. On Jakub's
suggestion, a script is also added to BPF selftests in order to keep track
of the supported build variants.

At last, third patch is a sligthly modified version of Ilya's fix regarding
libbpf.a appearing twice on the linking command for bpftool.

[0] https://lore.kernel.org/bpf/CACAyw9-CWRHVH3TJ=Tke2x8YiLsH47sLCijdp=V+5M836R9aAA@mail.gmail.com/

Cc: Lorenz Bauer <lmb@cloudflare.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>

Quentin Monnet (3):
  tools: bpftool: ignore make built-in rules for getting kernel version
  tools: bpftool: improve and check builds for different make
    invocations
  tools: bpftool: do not link twice against libbpf.a in Makefile

 tools/bpf/bpftool/Makefile                    |  18 ++-
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/test_bpftool_build.sh       | 137 ++++++++++++++++++
 3 files changed, 149 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_build.sh

-- 
2.17.1

