Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5DC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CF220818
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLWtd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:49:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfDLWtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:49:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29CC6AF47;
        Fri, 12 Apr 2019 22:49:32 +0000 (UTC)
Date:   Sat, 13 Apr 2019 07:49:24 +0900
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in case
 of ENOENT when dumping
Message-ID: <20190412224924.GA21826@f1>
References: <20190411082700.26888-1-bpoirier@suse.com>
 <20190412030322.15494-1-bpoirier@suse.com>
 <44958814-3145-717f-366e-ecc52f2145b9@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44958814-3145-717f-366e-ecc52f2145b9@netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019/04/12 11:28, Quentin Monnet wrote:
[...]
> 
> >   {
> > -	int value_size = strlen(value);
> > -	bool single_line, break_names;
> > +	bool break_names;
> > -	break_names = info->key_size > 16 || value_size > 16;
> > -	single_line = info->key_size + value_size <= 24 && !break_names;
> > +	break_names = info->key_size > 16;
> > +	single_line = single_line && !break_names;
> 
> If I understand correctly, this will also change formatting when error
> message is short (shorter than 16 characters: the "value" line will now be
> unconditionally split, even for short error messages (other than "<no
> entry>")). Why removing the condition on value_size > 16? (This is just a
> remark, I am not against changing it.)
> 

With this patch, the error messages from bpftool ("<no entry>", "<cannot
read>"), which are chosen to be short, appear on the same line and the
messages from strerror appear on a separate line. Because those latter
messages are from a source external to bpftool and their length is
unknown ahead of time, I felt it led to a more predictable output to
consistently put them on their own line.

To be honest, I don't think the formatting in those print_entry_*
functions should change according to the length in any case. I think the
key and value for each entry should always be on the same line for ease
of grepping. A followup patch maybe...
