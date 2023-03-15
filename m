Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB8FC6FD1F
	for <bpf@archiver.kernel.org>; Wed, 15 Mar 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCOAAV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Mar 2023 20:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCOAAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 20:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9641DBA8;
        Tue, 14 Mar 2023 17:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6DCA61A7F;
        Wed, 15 Mar 2023 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 458CDC4339B;
        Wed, 15 Mar 2023 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678838418;
        bh=5DdQtLHzTW5eGLcbnSebTBwfg+PmaMgT2k1VbAi0NsA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BpDSfJBvyJHx9eGadHHFDrD1UpIglhr7GA0atcX7WuCiqt/MteS8EVQkzjHzBIpo8
         ndgM8Vj1OARvp4xSsB7XlCkRJAxfo7O+8oFa/J50vNKJq4RMjJlq6x6F26Q+nMIbT4
         VSOihpRdiQYK+8lRjjnm2oH4wsJUstuxutrWTAkAqBNB1BKmvRFoq6s2dJMqjxOHog
         X2pXMifamnoBo6jZ0wN5xvL35/qw5Go29VZD22wVZlIb0fQH9OMCUWjY8AvKKV65bS
         hUc2Zi3iLC1k0Mi6TaDWh6EwMyxpflsi5U1QhhMAXY0NnTIIYDVx2B4i45aB/mdQGe
         1+4WVUdfe6BtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 244D3E66CBA;
        Wed, 15 Mar 2023 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf/for-next] cgroup: Make current_cgns_cgroup_dfl() safe to
 call after exit_task_namespace()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167883841814.25739.5495610858369290149.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Mar 2023 00:00:18 +0000
References: <ZBDuVWiFj2jiz3i8@slm.duckdns.org>
In-Reply-To: <ZBDuVWiFj2jiz3i8@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Mar 2023 11:59:49 -1000 you wrote:
> 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc") added
> bpf_cgroup_from_id() which calls current_cgns_cgroup_dfl() through
> cgroup_get_from_id(). However, BPF programs may be attached to a point where
> current->nsproxy has already been cleared to NULL by exit_task_namespace()
> and calling bpf_cgroup_from_id() would cause an oops.
> 
> Just return the system-wide root if nsproxy has been cleared. This allows
> all cgroups to be looked up after the task passed through
> exit_task_namespace(), which semantically makes sense. Given that the only
> way to get this behavior is through BPF programs, it seems safe but let's
> see what others think.
> 
> [...]

Here is the summary with links:
  - [bpf/for-next] cgroup: Make current_cgns_cgroup_dfl() safe to call after exit_task_namespace()
    https://git.kernel.org/bpf/bpf-next/c/b8a2e3f93d41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


