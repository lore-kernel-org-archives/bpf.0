Return-Path: <SRS0=G29D=7V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C15C433E0
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 07:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F932076A
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591600186;
	bh=rjBLjDjW1O9fGRBJf6kjv/K3zXOgcWg6SA2GxlenQUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YUKR7fDZm1wFxaDkxOOaOx6Cz5ugNf8AOq/6L72qCl7HtyUq/gTeJd11OXLdnXX29
	 6t4SDHR9wcWiZbrulQtr8LgtWyOaILXeWFvgyqOLi5JJDHW2Y9oaEvgTVVolCJEEzk
	 koFPl9m4XithXItFqvL4SvW2R6bXJ6NxuOttqfE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgFHHJk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFHHJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 03:09:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92FE204EF;
        Mon,  8 Jun 2020 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591600177;
        bh=rjBLjDjW1O9fGRBJf6kjv/K3zXOgcWg6SA2GxlenQUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV7zn0HjBkPTH1rFr/cRU+ZpTXJyYcNmWp+gw0iMmCCAAh/ir+o04fbw3JuqBDR81
         Kxp8krRzNTiB2yteIVm77VaSqGr7xthU4h/vQ+OR2nvGkId4m/0itdRo1Obwd69XIi
         nEbWRIadXESsfCcJN0lTqzbyBCZrbiTu+TysZzRQ=
Date:   Mon, 8 Jun 2020 08:09:30 +0100
From:   Will Deacon <will@kernel.org>
To:     syzbot <syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        ebiederm@xmission.com, edumazet@google.com, eric.dumazet@gmail.com,
        hawk@kernel.org, jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        mkubecek@suse.cz, netdev@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, songliubraving@fb.com,
        suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: WARNING in dev_change_net_namespace
Message-ID: <20200608070930.GA555@willie-the-truck>
References: <000000000000c54420059e4f08ff@google.com>
 <00000000000011eb1705a76ad69d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000011eb1705a76ad69d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 06, 2020 at 07:03:03AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 13dc4d836179444f0ca90188cfccd23f9cd9ff05
> Author: Will Deacon <will@kernel.org>
> Date:   Tue Apr 21 14:29:18 2020 +0000
> 
>     arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109aa3b1100000
> start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=129aa3b1100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=149aa3b1100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
> dashboard link: https://syzkaller.appspot.com/bug?extid=830c6dbfc71edc4f0b8f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12032832100000
> 
> Reported-by: syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com
> Fixes: 13dc4d836179 ("arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()")


Yeah... I doubt that very much.

Will
