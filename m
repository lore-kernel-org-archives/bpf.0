Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD7C3DA6E
	for <bpf@archiver.kernel.org>; Sat, 17 Dec 2022 09:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQJxr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 17 Dec 2022 04:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiLQJxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 04:53:44 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFA1742E;
        Sat, 17 Dec 2022 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671270818;
        bh=JouZ6st3CYo4QzJIiGOY2B/ojRdjjgnSW9GrcLgVarA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hJ4Dazaa2S+EdiilUN8C5RPXkrGHH+SBV48iHSsmSMMU4ufhooL9bI3+4ipYw+V5T
         iKPSLuzjrTp9swBnGMWYr0ltDDJrTNpPjbasy3p+03K4WOr61XlyG1nz6XYZ6SU3l/
         XSbxxlUDhpdRUPxS55YvP4soMbrKBoVekpJJkMbo=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id D633F853; Sat, 17 Dec 2022 17:53:35 +0800
X-QQ-mid: xmsmtpt1671270815t3h8oup6i
Message-ID: <tencent_84C64B10159B57C45158C406032921B22C07@qq.com>
X-QQ-XMAILINFO: OZiGlmjmGvyhT9Tovp0kXcvTdhA0VADCjQw9uDxDVu/Svl6L2ELDPjLN8GZ+sh
         CImNOjsryElJgsCu8ETr3cUWVHe7s6g1CYLBza5cdIWSs34+PgIfEY/rCBR8OmDtj1MBJYq1Owh8
         7OyazBzwo2fg2EvXeYWdK82qfiyja0PRcIvUJetCpbAy5d1tCsdsaTEhjQj4IPEeZYFXhj1qGeEa
         0B5dF04dJG/FQOg8SnfAplt8IlnTddP0Fu6x4SrPfSDBn7VVTJFLRMNdyHjeHB/xD5f0SUTYQIzO
         mXvB7LqdWZK62gfUbnYtL+u41TM5Qr1CoO3lHkP2PuBmBRPElPlfZg3gGAUuuts0nqCz7HAaYydd
         NpFNQaQTK1EKx0isSTqDN01wpxtswC1vlmwVrAFnm+wZtTpJhhXmRZnt+3h3S1gGvbqKtZzi9Sd+
         yqf+rdir2hDyrMLvfJS8JR7k/UZCoKmVvpSd/c6AaDmhcNph4T2fxZ0De7RC3cPtbPaGU7Vfkkr8
         c1fKWwfZFvcPdkVjvLm63rt3hBEbocmgU3dNPUjEpBwp8rn5PGA6ChOMjbdJl/JOZcAaaU5FJhiE
         G0yrHN6UE2HxoIMaRHv7SAnGd6botEDk284hub3mg4oXWn9o6d9UouJHii8ytRc/aX+bVfaO5zWo
         HRLUYrjbq59ry3+gVFo5aIlnRMK+3U80K96PcOSp0rhtXEz9nbM4KIk1wH/jZ0xrPPDIJhV1NFXq
         Kj3ay76f6vdLHa6iVQZnO51Cnz5bPK56mRBbPw9hQEtmW6ebcL9WPeG1ZkCz3UdxqZafpEju2/Lm
         +WNX8LWM1qi/TQTUUi0f297YC/n0cmHPqUybIGtCbf6EbiUrMOR+PZb6B8ndFzgtP1txFmq0Zxfc
         sxMiGu96a9JvNckSWtiA8E6nAnURhLCU6/Fvhqv36vI/HE1GdbuKYhVKMWoW43xVheNm4Tgq0B1f
         /7sjb3Wld2qdiHCdkalMOmnNTbmeumWfggncyD13MziNyr3Yd/dhquRURYHeaDgZczVIMaZTs=
From:   Rong Tao <rtoax@foxmail.com>
To:     masahiroy@kernel.org
Cc:     bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, rongtao@cestc.cn,
        rtoax@foxmail.com
Subject: Re: Re: [PATCH] kbuild: Fix compilation error
Date:   Sat, 17 Dec 2022 17:53:34 +0800
X-OQ-MSGID: <20221217095334.538189-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAK7LNASu6i9V4b_u68azpM45zPM0udGW8kVWGd+UZzJtSq0+TA@mail.gmail.com>
References: <CAK7LNASu6i9V4b_u68azpM45zPM0udGW8kVWGd+UZzJtSq0+TA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks, Masahiro Yamada, I compile again from scrach. the compilation
error not happen anymore. I think i miss 'make menuconfig' before.

Thanks again!

$ git log --oneline  -1
77856d911a8c
$ git clean -dfx
$ make menuconfig <<== Which i miss
$ make -j8
$ make -C samples/bpf


