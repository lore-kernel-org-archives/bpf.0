Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5178DC4727C
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32E12184D
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601404204;
	bh=245sG4Bi6z7cOnMI+y2FxsxhqlcUK5iOoMYvr9XRAx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=AgUaYgF+qwfLtYe2XkIN+BT7ft8NtNGPBkUvBXjgk8NIufRlwC6J2+IWh7Cv3yZzh
	 fwpeei/pyWyd3BTfiGG8xO9GNb3fS9npaHnOCd0IyFBxntT8K8KreCaSZDB39Iwky8
	 tTOnT9kJlS7wxkM/yQWRBntxTOVhg8xZUg4T926g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgI2SaD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgI2SaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601404202;
        bh=245sG4Bi6z7cOnMI+y2FxsxhqlcUK5iOoMYvr9XRAx4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f8ZzXCwLXUTXH1sl1I+6AtBNY+iGtOR33U11ozJ62tLJh9WXrBP1QMqsahtnO4dQN
         dJA0BVaJRmtoF549qFFEpDfQq064V/BUQEXuRtJ0oEjzTWayovmgAn55zuf6m2Wag/
         YmNDu1afsYaCiNMiWxke7D5hLmHGCtboentKX4xw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf_iter: don't fail test due to missing
 __builtin_btf_type_id
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140420265.22687.13555607329686499231.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:30:02 +0000
References: <20200929123004.46694-1-toke@redhat.com>
In-Reply-To: <20200929123004.46694-1-toke@redhat.com>
To:     =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 14:30:04 +0200 you wrote:
> The new test for task iteration in bpf_iter checks (in do_btf_read()) if it
> should be skipped due to missing __builtin_btf_type_id. However, this
> 'skip' verdict is not propagated to the caller, so the parent test will
> still fail. Fix this by also skipping the rest of the parent test if the
> skip condition was reached.
> 
> Fixes: b72091bd4ee4 ("selftests/bpf: Add test for bpf_seq_printf_btf helper")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf_iter: don't fail test due to missing __builtin_btf_type_id
    https://git.kernel.org/bpf/bpf-next/c/d2197c7ff171

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


