Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27EC433F5
	for <bpf@archiver.kernel.org>; Thu, 18 Nov 2021 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037E761A86
	for <bpf@archiver.kernel.org>; Thu, 18 Nov 2021 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKRVNF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhKRVNF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 16:13:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 508FD61A55;
        Thu, 18 Nov 2021 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637269804;
        bh=5VxsWo0iZZBF8ACoj4xUC9T34DvslY7WtHdcsY8Blo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gy4Vmfib1VslTl+U3bxFX+kXyT1Wzd4UlqIgJvtsc/NpLBuhLFAULndGJgoG2lbSa
         H/g5eLiiuF9217RHvSkU/MUmEl4vz7AsIlMIXMmoOEtMPptFfasa+bz4LcnMAwhA5F
         AbfjI7OBN3iXXz+YsBPGfbZQSKE+B3ec9VudBcRoVFbl3D2YRr8H0h68OZwrDkvArU
         FSIJWPByzoSKDyyKLKstZjcT6774r/tWn37suZC/74sGazCvbna7W0AgzpH4uBpd4z
         C4J1r2Lv5ftD9rKiKjFXTR7iTQBAdx9VFGjD4pw2EZswKQBXWMQBj8oOfilOYswcid
         uO6z+hJfZ6PAw==
Subject: Re: [GIT PULL] Networking for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211118164253.1751486-1-kuba@kernel.org>
References: <20211118164253.1751486-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211118164253.1751486-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.16-rc2
X-PR-Tracked-Commit-Id: c7521d3aa2fa7fc785682758c99b5bcae503f6be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d0112ac6fd001f95aabb084ec2ccaa3637bc344
Message-Id: <163726980416.22061.9661621395746434436.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 21:10:04 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        johannes@sipsolutions.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 08:42:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d0112ac6fd001f95aabb084ec2ccaa3637bc344

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
