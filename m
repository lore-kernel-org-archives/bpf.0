Return-Path: <SRS0=5juC=7Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436BC433DF
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09E620663
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLWFK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:05:10 -0400
Received: from sym2.noone.org ([178.63.92.236]:60562 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLWFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:05:10 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49kFC83k7Xzvjc1; Sat, 13 Jun 2020 00:05:07 +0200 (CEST)
Date:   Sat, 13 Jun 2020 00:05:07 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf] tools/bpftool: fix skeleton codegen
Message-ID: <20200612220506.nad3zmcg7j75hnsz@distanz.ch>
References: <20200612201603.680852-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612201603.680852-1-andriin@fb.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-12 at 22:16:03 +0200, Andrii Nakryiko <andriin@fb.com> wrote:
> Remove unnecessary check at the end of codegen() routine which makes codegen()
> to always fail and exit bpftool with error code. Positive value of variable
> n is not an indicator of a failure.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Fixes: 2c4779eff837 ("tools, bpftool: Exit on error in function codegen")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Sorry about this, thanks for fixing it.
