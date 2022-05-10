Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CF6C433F5
	for <bpf@archiver.kernel.org>; Tue, 10 May 2022 08:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiEJIVS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 May 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiEJIU5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 04:20:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F397A28C9D3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 01:17:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BCC0B68AFE; Tue, 10 May 2022 10:16:57 +0200 (CEST)
Date:   Tue, 10 May 2022 10:16:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, "Harris, James R" <james.r.harris@intel.com>
Subject: Re: LSF/MM session: eBPF standardization
Message-ID: <20220510081657.GA12910@lst.de>
References: <20220503140449.GA22470@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503140449.GA22470@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks everyone who participated.

Here is my rough memory an action items from the meeting.  As I
was on stage and did not take notes these might be a bit off and
may need correction.

The separate instruction set document wasn't known by everyone but
seens as a good idea.

The content needs a little more work:

 - document the version levels, based on the clang cpu levels
   (I plan to do this ASAP)
 - we need to decide to do about the legacy BPF packet access
   instrutions.  Alexei mentioned that the modern JIT doesn't
   even use those internally any more.
 - we need to document behavior for underflows / overflows and
   other behavior not mentioned.  The example in the session
   was divive by zero behavior.  Are there any notes on what
   the consensus for a lot of this behavior is, or do we need
   to reverse engineer it from the implementation?  I'd happily
   write the documentation, but I'd be really grateful for any
   input into what needs to go into it

Discussion on where to host a definitive version of the document:

 - I think the rough consensus is to just host regular (hopefully
   low cadence) documents and maybe the latest gratest at a eBPF
   foundation website.  Whom do we need to work with at the fundation
   to make this happen?
 - On a technical side we need to figure out a way how to build a
   standalone document from the kerneldoc tree of documents.  I
   volunteers to look into that as well.

The verifier is not very well documented, and mixes up generic behavior
with that of specific implementations and program types.

 - as idea it was brought up to write a doument with the minimal
   verification requirements required for any eBPF implementation
   independent of the program type.  Again I can volunteer to
   draft a documentation, but I need input on what such a consensus
   would be.  In this case input from the non-Linux verifier
   implementors (I only know the Microsoft research one) would
   be very helpful as well.

