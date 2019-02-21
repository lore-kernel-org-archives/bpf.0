Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF309C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AEC2083B
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550777614;
	bh=vKfVl/1s05IylsoYMA1Gs7+QRCwIb5I59KAB45Kg/lA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gnOrlLizxH1p+UREHWWNfe1TiBfYIC+qBFYCkLwVBkUe2DwxDmlb+Bp5mYry+SGG6
	 IrdkaKY5ehtGnOacoNBGGCsUaW1VGRm8jPAq4v3dIYFCvodzO0A1KUGrXluUnFwYEl
	 +WOrFFFRVcOqEORF5fmqCPvDojJEgmc8H8t4+yfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBUTde (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUTde (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Feb 2019 14:33:34 -0500
Received: from quaco.ghostprotocols.net (177-59-142-252.3g.claro.net.br [177.59.142.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C6A2077B;
        Thu, 21 Feb 2019 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550777613;
        bh=vKfVl/1s05IylsoYMA1Gs7+QRCwIb5I59KAB45Kg/lA=;
        h=Date:From:To:Cc:Subject:From;
        b=1g3oZhDMDuozhGQJMC8EUgewgR9Z6ZNHtvxr2qygnb90d9chlHgK84Bw2w++E7csU
         I+61qSZFKM4ur6p1npVENbx7veHNxrx1AKgIXtXHdL0AjxBM2o1g/+4hWtwjP6a1r4
         EoeiZz1at60eQ4ENjDNNABX3+iQPXWj6eUigQOYA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC9FD4039C; Thu, 21 Feb 2019 16:33:28 -0300 (-03)
Date:   Thu, 21 Feb 2019 16:33:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: LSFMM BPF Proposal: Using BTF in pahole and perf: Always present
 type information
Message-ID: <20190221193328.GB9755@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BTF in pahole and perf: Always present type information

The presentation will go through recent developments in making information
about types, function signatures to be always available, for the kernel and for
BPF programs and the various possibilities that brings.

Now pahole, a tool to show all sorts of information about data structures
already used by the kernel community for years, can load DWARF and encode BTF,
and also can read that info, be it converted from DWARF or directly generated
by clang to the BPF target and show it just like it does for DWARF info, but
much faster.

A recent development, the deduplication of DWARF info will be described,
showing how this dramatically reduces the space needed to encode all the
kernel data structures and function signatures.

How this is being used in various tools, including bpftool and 'perf trace',
for instance to pretty print maps, will be showcased.

Further use BTF in debuggers, making the conversion and deduplication of the
kernel types be done as part of a production build, and havong it available in
vmcores are other opportunities to discuss.

With this always present type availability the usage of tools like
pahole become more feasible and automatic detection of non optimal
struct layouts can be done automatically, as part of kernel builds. It
is now much faster due to the much more compact size of the type
information.

The comparision of the types used in BPF bytecode with that for the equivalent
kernel type can be compared and under lots of cases allow for
compile-once-run-anywhere BPF bytecode, with offset adjustments, etc.

The need for kernel headers is diminished, with the possibility of
rebuilding types using a tool like pahole or directly by perf, bcc,
bpftrace, bpftool, etc.

Advanced filtering in 'perf trace' strace-like mode is also facilitated,
as well as the syscall function signatures for automatic pretty-printing
of its arguments.

----- End forwarded message -----

-- 

- Arnaldo
