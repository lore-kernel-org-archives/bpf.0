Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61891C433F5
	for <bpf@archiver.kernel.org>; Thu, 10 Feb 2022 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiBJRB4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:01:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiBJRBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 12:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE47B93
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 09:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF8361D97
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 17:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFEFC004E1;
        Thu, 10 Feb 2022 17:01:54 +0000 (UTC)
Date:   Thu, 10 Feb 2022 12:01:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: Re: [RFC PATCH 2/3] powerpc/ftrace: Override
 ftrace_location_lookup() for MPROFILE_KERNEL
Message-ID: <20220210120152.00d24b64@gandalf.local.home>
In-Reply-To: <1644508338.5ucomwqtts.naveen@linux.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220207102454.41b1d6b5@gandalf.local.home>
        <1644426751.786cjrgqey.naveen@linux.ibm.com>
        <20220209161017.2bbdb01a@gandalf.local.home>
        <1644501274.apfdo9z1hy.naveen@linux.ibm.com>
        <20220210095944.1fe98b74@gandalf.local.home>
        <1644508338.5ucomwqtts.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 10 Feb 2022 16:40:28 +0000
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> The other option is to mark ftrace_cmp_recs() as a __weak function, but 
> I have a vague recollection of you suggesting #ifdef rather than a 
> __weak function in the past. I might be mis-remembering, so if you think 
> making this a __weak function is better, I can do that.

No. If I wanted that I would have suggested it. I think this is the
prettiest of the ugly solutions out there ;-)

As I said, I can't think of a better solution, and we can go with this
until something else comes along.

-- Steve
