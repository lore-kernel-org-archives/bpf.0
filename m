Return-Path: <SRS0=vc2L=VO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185EC76186
	for <bpf@archiver.kernel.org>; Wed, 17 Jul 2019 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD58217D9
	for <bpf@archiver.kernel.org>; Wed, 17 Jul 2019 07:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563349955;
	bh=AduzEhpfg2VrAE19OEU5UAD569tPbdK9WGCbykgfs9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qtrMRuU3A3tKl0gcxdL72daCxwZ3OnyfjdXfedSwa1puIvlEX70/YYIlwmKK2yVPL
	 sISxwmRog1qZXeAgkGZF0d7V9PCTf8AM1tiWDuLBHRcf1+TW1WI26c2sSMJJtA2pmW
	 XnLAX4rFIiq23NHsp8dCnKFj1Hap8uIDweBmi/Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQHwe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQHwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jul 2019 03:52:34 -0400
Received: from devnote2 (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CDD2077C;
        Wed, 17 Jul 2019 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563349953;
        bh=AduzEhpfg2VrAE19OEU5UAD569tPbdK9WGCbykgfs9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ADdIIP4LbRiUvB+uliUTmVchJU8aHDFFjvL+4mfKZw7q6/t82HChdesjTx2n7xkd/
         OqVQchqbg+KmENao+1iR9M2GDc9vVYXws0IxdcL8wKtSkAqpukBA+c+gDbRzFS+nfN
         kaXeGGe3GeHlkVgZ3pSVw+J5uQCh/oQ8gKL8HRvQ=
Date:   Wed, 17 Jul 2019 16:52:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Justin He <Justin.He@arm.com>
Subject: Re: [PATCH 0/2] arm/arm64: Add support for function error injection
Message-Id: <20190717165222.62e02b99ebc16e23c3b81de2@kernel.org>
In-Reply-To: <20190716111301.1855-1-leo.yan@linaro.org>
References: <20190716111301.1855-1-leo.yan@linaro.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Jul 2019 19:12:59 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> This small patch set is to add support for function error injection;
> this can be used to eanble more advanced debugging feature, e.g.
> CONFIG_BPF_KPROBE_OVERRIDE.
> 
> I only tested the first patch on arm64 platform Juno-r2 with below
> steps; the second patch is for arm arch, but I absent the platform
> for the testing so only pass compilation.
> 
> - Enable kernel configuration:
>   CONFIG_BPF_KPROBE_OVERRIDE
>   CONFIG_BTRFS_FS
>   CONFIG_BPF_EVENTS=y
>   CONFIG_KPROBES=y
>   CONFIG_KPROBE_EVENTS=y
>   CONFIG_BPF_KPROBE_OVERRIDE=y
> - Build samples/bpf on Juno-r2 board with Debian rootFS:
>   # cd $kernel
>   # make headers_install
>   # make samples/bpf/ LLC=llc-7 CLANG=clang-7
> - Run the sample tracex7:
>   # ./tracex7 /dev/sdb1
>   [ 1975.211781] BTRFS error (device (efault)): open_ctree failed
>   mount: /mnt/linux-kernel/linux-cs-dev/samples/bpf/tmpmnt: mount(2) system call failed: Cannot allocate memory.

This series looks good to me from the view point of override usage :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

For this series.

Thank you,

> 
> 
> Leo Yan (2):
>   arm64: Add support for function error injection
>   arm: Add support for function error injection
> 
>  arch/arm/Kconfig                         |  1 +
>  arch/arm/include/asm/error-injection.h   | 13 +++++++++++++
>  arch/arm/include/asm/ptrace.h            |  5 +++++
>  arch/arm/lib/Makefile                    |  2 ++
>  arch/arm/lib/error-inject.c              | 19 +++++++++++++++++++
>  arch/arm64/Kconfig                       |  1 +
>  arch/arm64/include/asm/error-injection.h | 13 +++++++++++++
>  arch/arm64/include/asm/ptrace.h          |  5 +++++
>  arch/arm64/lib/Makefile                  |  2 ++
>  arch/arm64/lib/error-inject.c            | 19 +++++++++++++++++++
>  10 files changed, 80 insertions(+)
>  create mode 100644 arch/arm/include/asm/error-injection.h
>  create mode 100644 arch/arm/lib/error-inject.c
>  create mode 100644 arch/arm64/include/asm/error-injection.h
>  create mode 100644 arch/arm64/lib/error-inject.c
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
