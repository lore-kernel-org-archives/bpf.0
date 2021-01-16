Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5CC433E6
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F5C23A58
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbhAPEEB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbhAPEEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 23:04:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3AB23A55;
        Sat, 16 Jan 2021 04:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610769801;
        bh=3qEKJFDieK9U97V8E0sEFodhkBp6TTFYbchmJ44fps4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJ5uweFaELyls+6NgQy8Bv9kGFq0KxvkYwAauvyaFCQ9iXatRMke1VtCjA34HhQGi
         qW7NQlx4YPlvk6mZMLfXeOlh6jdVKdGc7KRkdOki/U1b9bjbok+4xxdtgBCLAKV4K4
         S4MJFLtBRYLsez201GMNuiUVCOYl/QZjjIX8ZB4w+v/BpWuY5IdU+2+a/lL5vSfabD
         /z3dBQKNDvvmFiBDEuh/n8jiqCNQXBYb49CJl0+C8x+CB1wkeBX0r3bJaCjLq4pHGX
         LaookNRb4nGYZdXey5Xl4HbprYM7SQks+cljyAWEeYYpNT0J6GtTaHKfpeg/HJJS89
         9/7EbexAy4B5A==
Date:   Fri, 15 Jan 2021 20:03:19 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, ast@kernel.org, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2021-01-16
Message-ID: <20210115200319.2ea4bc16@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210116012922.17823-1-daniel@iogearbox.net>
References: <20210116012922.17823-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 16 Jan 2021 02:29:22 +0100 Daniel Borkmann wrote:
> 1) Extend atomic operations to the BPF instruction set along with x86-64 JIT support,
>    that is, atomic{,64}_{xchg,cmpxchg,fetch_{add,and,or,xor}}, from Brendan Jackman.
> 
> 2) Add support for using kernel module global variables (__ksym externs in BPF
>    programs) retrieved via module's BTF, from Andrii Nakryiko.
> 
> 3) Generalize BPF stackmap's buildid retrieval and add support to have buildid
>    stored in mmap2 event for perf, from Jiri Olsa.
> 
> 4) Various fixes for cross-building BPF sefltests out-of-tree which then will
>    unblock wider automated testing on ARM hardware, from Jean-Philippe Brucker.
> 
> 5) Allow to retrieve SOL_SOCKET opts from sock_addr progs, from Daniel Borkmann.
> 
> 6) Clean up driver's XDP buffer init and split into two helpers to init per-
>    descriptor and non-changing fields during processing, from Lorenzo Bianconi.
> 
> 7) Minor misc improvements to libbpf & bpftool, from Ian Rogers.

Pulled, thanks!
