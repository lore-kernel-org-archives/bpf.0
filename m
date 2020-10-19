Return-Path: <SRS0=px7A=D2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CE2C433E7
	for <bpf@archiver.kernel.org>; Mon, 19 Oct 2020 23:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DEF2242A
	for <bpf@archiver.kernel.org>; Mon, 19 Oct 2020 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603150204;
	bh=NtcUpauD/zPxEqXyKScPoJyRlxND8aVpkCRa7udhLyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=xTRnIVmSV8BFm3lRQoW+VHcjQKjwzH6fIXDfn6q/GUoxXgQOZFAKL8y5PD2rnFm90
	 QRQENIc/6qY8ScnNi5YJgQFgphzy2+thbl7IdlKPQkb43jL7OXxnI2KF3ibb/eI5MT
	 subasp+YdN12T8BdETuR+PF5fKA6CyqbxV0k19VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgJSXaE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgJSXaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 19:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603150203;
        bh=NtcUpauD/zPxEqXyKScPoJyRlxND8aVpkCRa7udhLyw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UEvoDsy8Y3KHROfBUqm13DooKrumzbwtR9rXCpxaeQnPuWQM4ZjUp7fLMWCkkxuLP
         vZmkanmZGRMP2xTv8M7MRtqjEqjMdM6jgDtobI6DgMTzTUeKU45lZgw2EWXjVoOYgH
         ZWEA/8EeHfWgiCuNLsAhmW5b5vKz3BydJmslixVY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf: Enforce NULL check on new _OR_NULL return types
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160315020308.10677.11192857731409269207.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Oct 2020 23:30:03 +0000
References: <20201019194206.1050591-1-kafai@fb.com>
In-Reply-To: <20201019194206.1050591-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, kernel-team@fb.com, netdev@vger.kernel.org,
        yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Mon, 19 Oct 2020 12:42:06 -0700 you wrote:
> This set enforces NULL check on the new helper return types,
> RET_PTR_TO_BTF_ID_OR_NULL and RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL.
> 
> Martin KaFai Lau (3):
>   bpf: Enforce id generation for all may-be-null register type
>   bpf: selftest: Ensure the return value of bpf_skc_to helpers must be
>     checked
>   bpf: selftest: Ensure the return value of the bpf_per_cpu_ptr() must
>     be checked
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Enforce id generation for all may-be-null register type
    https://git.kernel.org/bpf/bpf/c/93c230e3f5bd
  - [bpf,2/3] bpf: selftest: Ensure the return value of bpf_skc_to helpers must be checked
    https://git.kernel.org/bpf/bpf/c/e710bcc6d92c
  - [bpf,3/3] bpf: selftest: Ensure the return value of the bpf_per_cpu_ptr() must be checked
    https://git.kernel.org/bpf/bpf/c/8568c3cefd51

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


