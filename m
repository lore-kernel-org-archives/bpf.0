Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4BC05027
	for <bpf@archiver.kernel.org>; Tue, 24 Jan 2023 00:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAXAWM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAXAWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 19:22:11 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30E30298
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:22:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 123so16978035ybv.6
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UzGcpZl8e1Qn++7G7KiAx6rjMcf/c2rYd9J7aFMDDCw=;
        b=nqx1T+j38NzuwKqYTbEIo10P8a0Qav3ssHCHjrYSMb0c3dRO5FFRzL0ikp2Qm+6OkA
         FUjZI7wvgmWEVepzMBzYNBLzGO4thnaOomFq3GL5gPT9M+50u2rlrGu/PUqnIqrSiNYt
         fN1aVBYWPleo+K/Dy302WjST1YmoY8DCsY7fNz7ltMc/FD4DuCImLXridu0xie/+pcrr
         fbk/XXfbMI9c9EZkXeTW+XOTTX1QcWE+lhffEZCYw/3Wl5G+TmSXY6LVC6CnmpPci1FC
         tlHiZ1YOa6CeASkvkymme2Xht4WB1PsprBDq3w9rfu5W6d8JbmX9gCjENa6EjIJG0R1V
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzGcpZl8e1Qn++7G7KiAx6rjMcf/c2rYd9J7aFMDDCw=;
        b=SFR6HZl/d0f8xYg64N15SjOY18woLdLyOLzi5OGcUZB3K0bjyYNGq2uw6UuxOAP0qs
         tHr0HMuAEN/E5u6p0rU9D4GuCXVfvbKe4H7MYxSL60SNuHJsByjgF8F96ui/NX8Ruoo1
         aXUo45WwfgKFCmmpa6YAQ+rJXJVV2SiUz0uLwEbabRhUC71tohWACtDQQ6u39w0tXdLG
         WuQyg8rA4xhBi5wkxMp3wx3+UsTbIIZQO84wGQisrvhn1bVMr9oom1b4A3EeMvWCZFu3
         xSjyqYQbdgJDd/A3c2B8xg546VU90+HvRBZMRo97zgpDAa8x8BmPoMG8rOR8uO94J6Db
         D8Rw==
X-Gm-Message-State: AFqh2kryRBmk02RSCK9RbxjXMpWI0nWdhL3hx4dOWZkCKhWvhbRiqJpT
        sBwYC12qiIVE5QNVqurDiEPuYqE5iLqHRBY8TVxBT9RSY0wVNmtvBSs=
X-Google-Smtp-Source: AMrXdXu6UeUDVolljFBIEduuWmP2ZsmvTtD9X0n/yCyUmKayT6b9xKNsh32Mp0tbUTyfH9LyfBeZ31HvXjinMKqv9gs=
X-Received: by 2002:a5b:a82:0:b0:7d3:c551:b7f0 with SMTP id
 h2-20020a5b0a82000000b007d3c551b7f0mr3246005ybq.78.1674519729168; Mon, 23 Jan
 2023 16:22:09 -0800 (PST)
MIME-Version: 1.0
From:   Jason Ling <jasonling@google.com>
Date:   Mon, 23 Jan 2023 16:21:33 -0800
Message-ID: <CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com>
Subject: Is fentry/fexit support possible with an external BTF?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some context:

The devices I am interested in have a small kernel partition (~16MB).
Building the kernel with CONFIG_DEBUG_INFO_BTF=y increases the kernel
size by about ~1.7M.
So I've tried to use an external BTF (generating my own vmlinux BTF
and placing it on a more spacious partition) but it seems like my
eBPFs that attach to fexit hooks now fail loading. According to some
comments in libbpf this seems to be expected.

e.g an eBPF program that looks like this

SEC("fexit/ksys_unshare")
int BPF_PROG(handle_exit, unsigned long unshare_flags, int rv) {
}

fails the loading process.


My guess is that there is additional debug/BTF information beyond what
is available in vmlinux BTF that gets linked into vmlinuz and without
this information the attaching to certain hooks fail.

So my question is:

is there a way to achieve my goal of using a kernel that has been
built with CONFIG_DEBUG_INFO_BTF=n and still be able to use
fentry/fexit type hooks?
