Return-Path: <SRS0=ZGki=ZN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED97C432C0
	for <bpf@archiver.kernel.org>; Thu, 21 Nov 2019 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E88D20855
	for <bpf@archiver.kernel.org>; Thu, 21 Nov 2019 08:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUIwe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:52:34 -0500
Received: from www62.your-server.de ([213.133.104.62]:35144 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUIwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Nov 2019 03:52:34 -0500
Received: from [2a02:1205:507e:bf80:bef8:7f66:49c8:72e5] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iXiCX-0002Uf-1I; Thu, 21 Nov 2019 09:52:33 +0100
Date:   Thu, 21 Nov 2019 09:52:32 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH bpf-next] tools: bpf: fix build for 'make -s tools/bpf
 O=<dir>'
Message-ID: <20191121085232.GC31576@pc-11.home>
References: <20191119105626.21453-1-quentin.monnet@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119105626.21453-1-quentin.monnet@netronome.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25639/Wed Nov 20 11:02:53 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 19, 2019 at 10:56:26AM +0000, Quentin Monnet wrote:
> Building selftests with 'make TARGETS=bpf kselftest' was fixed in commit
> 55d554f5d140 ("tools: bpf: Use !building_out_of_srctree to determine
> srctree"). However, by updating $(srctree) in tools/bpf/Makefile for
> in-tree builds only, we leave out the case where we pass an output
> directory to build BPF tools, but $(srctree) is not set. This
> typically happens for:
> 
>     $ make -s tools/bpf O=/tmp/foo
>     Makefile:40: /tools/build/Makefile.feature: No such file or directory
> 
> Fix it by updating $(srctree) in the Makefile not only for out-of-tree
> builds, but also if $(srctree) is empty.
> 
> Detected with test_bpftool_build.sh.
> 
> Fixes: 55d554f5d140 ("tools: bpf: Use !building_out_of_srctree to determine srctree")
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Applied, thanks!
