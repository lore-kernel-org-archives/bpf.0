Return-Path: <SRS0=tzzN=IG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A4C433DB
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 13:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7711C651C3
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 13:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHNKa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCHNKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 08:10:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C8A966518F;
        Mon,  8 Mar 2021 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615209006;
        bh=X6dboDfGc3Kwhg681NdLNUwjrwtCVBfB5c1R2LALe6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=frdGiA++ZviU0y7xtjp9eRbgPxZmX4Kuo2p2NyR1btSdlerTLhJd6GvQE7r2wVgeK
         S/r7y3Zsy1m/s3Y19GJMsCitInvzl/VZKvVWQ2aDyDWNbUelT8rYpppWfRZfEG8sUi
         GhbtO8uEPqb6wRn6dzCLn+00eE0JymO/NFvk6fgw01WBkJXECQcnYnqtdQ5S0z/kJ7
         6YolMSRc5xmZ3GwH2oMTu5w8KjhD8435y66h/s7awU9BaeMBYm95b7uPDlGx4MScl3
         LA2RL2hOkjSZDoF2f6vWQINwVvjejH1zf9RbO8E2bcet2zdEbpjNKOvRmFMT14LCJd
         tXRyeRCfIwxGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Dont allow vmlinux BTF to be used in map_create and
 prog_load.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161520900676.23977.17829281573568193224.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 13:10:06 +0000
References: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sun,  7 Mar 2021 14:52:48 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The syzbot got FD of vmlinux BTF and passed it into map_create which caused
> crash in btf_type_id_size() when it tried to access resolved_ids. The vmlinux
> BTF doesn't have 'resolved_ids' and 'resolved_sizes' initialized to save
> memory. To avoid such issues disallow using vmlinux BTF in prog_load and
> map_create commands.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Dont allow vmlinux BTF to be used in map_create and prog_load.
    https://git.kernel.org/bpf/bpf/c/350a5c4dd245

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


