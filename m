Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECECC433DF
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF67620771
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 09:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgFWJ6X (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:58:23 -0400
Received: from sym2.noone.org ([178.63.92.236]:43150 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731947AbgFWJ6X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 05:58:23 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49rhYT49Z7zvjc1; Tue, 23 Jun 2020 11:58:21 +0200 (CEST)
Date:   Tue, 23 Jun 2020 11:58:20 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] tools, bpftool: Define prog_type_name array
 only once
Message-ID: <20200623095820.3xiwsfaxsxyyosbt@distanz.ch>
References: <20200622140007.4922-1-tklauser@distanz.ch>
 <20200622140007.4922-2-tklauser@distanz.ch>
 <c961c0ee-424a-6f3b-942e-42fdc7ee9b95@isovalent.com>
 <20200622150510.nk6pkzsof2diolwt@distanz.ch>
 <2df810b0-b31d-641a-9d81-47eb11c3f0a4@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df810b0-b31d-641a-9d81-47eb11c3f0a4@isovalent.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-22 at 17:17:04 +0200, Quentin Monnet <quentin@isovalent.com> wrote:
> 2020-06-22 17:05 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> > On 2020-06-22 at 16:26:17 +0200, Quentin Monnet <quentin@isovalent.com> wrote:
> >> 2020-06-22 16:00 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> >>> Follow the same approach as for map_type_name. This leads to a slight
> >>
> >> map_type_name looks unchanged in this series, could you please check
> >> your commit log?
> > 
> > Yes this patch intentionally shouldn't change map_type_name. The idea
> > was to say "do the same thing for prog_type_name name as is already done
> > for map_type_name". I can rephrase that to become more clear if you
> > want.
> 
> Ok sorry, I thought you meant map_type_name had been moved to reduce the
> size as well. I think I got confused by "Follow the same approach",
> since map_type_name has always been in map.c, but it's both
> prog_type_name and attach_type_name that were moved to main.h from their
> original files some time ago (so not much to "follow" from map_type_name).
> 
> Anyway, minor confusion on my side, no need to respin just for that.
> Thanks for the clarification.

Will send a v2 to address Andrii's comment on patch 2/2, so I'll
rephrase the commit message on this patch to be less confusing.

Tobias
