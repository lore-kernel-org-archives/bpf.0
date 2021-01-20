Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD4C43333
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57582360D
	for <bpf@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbhATV17 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jan 2021 16:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbhATNlP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 08:41:15 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8CC0613D6
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 05:39:53 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id f65so575565wmf.2
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4HuaHnHsq3+9UDKnhuRegf7VhNzlZpKuJ1R6ivtSlOg=;
        b=RzwwBhI0LFDqKRi3rX8rfrpXZflyXVI8WUwGnh7kHJ3Rle/pz7qDeRwRyRnlJJPqD8
         AbDOl6ZRZHzI3FdOtQuR5PVuvAF4YuwgUucDI82DRg70lf7PQ85hM5g3qcrL/r9Ci9LP
         4E4wX5o5GFVFLBTVo18e+aywt/VYrsTcwYihokSuh1rpKBOiBOd6wYW8/eEJTHrIaTzG
         p/ObA5CGL2n/xo3pYACU0NdLVle/TTdGtxEeWFUsBoQjdYdz0hBfb67exaOcXtXOE504
         U5/MfbwJNVd2jtfthveCkpFwMRLuiDS0SN5W2OBNZTOseChuxpzulx0V/jtV8eeL+iM1
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4HuaHnHsq3+9UDKnhuRegf7VhNzlZpKuJ1R6ivtSlOg=;
        b=CamZOr60BOZBhZu36Wv219WG3j5/zXAvF5nq+nBx2FqS7RrGpSxs1Nvov66kLm9xfN
         umoF9mIWDrRHd84CcJSS0B6PZTMdl13/m3DxoZQdZ1ac53ayfxXEIZqZvOQpbyw2236a
         ozvvc+reyU3bg/AleBZYA0aeukj4kqvz0Gl5Ya4y1Ckd67wpX/nZs/sU+9m2HCMcgqK3
         9ym8RqivZ0/KCBlFwqoyqawIs8wnHsFEC6pskXblzpEO80SJR4tijSFhXSI4cKc7tFj+
         xkp0b1p++HJKxoyAx6rD0RtpfJ2bRZNGrjvyl3KbB9x0lDj2mG08lZaCCkkl3xO3p2bQ
         9zLw==
X-Gm-Message-State: AOAM533cRHXkhS74Gt3WRqCufQII9D4QSjwenYug8fUgF4fdjnTbgrO0
        auW1eQhvtucDvAODwGPuGZSWlCx2r4lZhheTpxWGJkPnZXv2dMviqe0CYT6yfIcvwHKZEVEms3g
        tkhtQOdIKMzTjW9LLzd76EtfZgV3r7qIaYzo9G0BkxQUWY90vQ//CIEkI+/w4Fbw=
X-Google-Smtp-Source: ABdhPJz9D0nnseUovWpFIZ6H+T0/V01e1hCruHihQvhd66s20FOaGPv8ik7N7xcP/s+yNf1ljx+YYerX46ujqA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:cb54:: with SMTP id
 v20mr4532747wmj.148.1611149992267; Wed, 20 Jan 2021 05:39:52 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:39:44 +0000
Message-Id: <20210120133946.2107897-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v3 0/2] BPF docs fixups
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Difference from v2->v3 [1]:

 * Just fixed a commite message, rebased, and added Lukas' review tag - thanks
   Lukas!

Difference from v1->v2 [1]:

 * Split into 2 patches

 * Avoided unnecessary ': ::' in .rst source

 * Tweaked wording of the -mcpu=v3 bit a little more

[1] Previous versions:
    v1: https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t
    v2: https://lore.kernel.org/bpf/20210118155735.532663-1-jackmanb@google.com/T/#t

Brendan Jackman (2):
  docs: bpf: Fixup atomics markup
  docs: bpf: Clarify -mcpu=v3 requirement for atomic ops

 Documentation/networking/filter.rst | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)


base-commit: 8edc0c67d09d6bf441eeb39ae9316fe07478093f
--
2.30.0.284.gd98b1dd5eaa7-goog

