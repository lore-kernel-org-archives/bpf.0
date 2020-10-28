Return-Path: <SRS0=zDaf=ED=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC2C388F7
	for <bpf@archiver.kernel.org>; Wed, 28 Oct 2020 23:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A546120759
	for <bpf@archiver.kernel.org>; Wed, 28 Oct 2020 23:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgJ1XOX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:14:23 -0400
Received: from sym2.noone.org ([178.63.92.236]:41764 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390213AbgJ1XNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 19:13:09 -0400
X-Greylist: delayed 4197 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 19:13:08 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4CLqZ551RYzvjc1; Wed, 28 Oct 2020 14:44:45 +0100 (CET)
Date:   Wed, 28 Oct 2020 14:44:45 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Michal Rostecki <mrostecki@opensuse.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] tools, bpftool: Avoid array index warnings.
Message-ID: <20201028134444.qt44rvpdekwr6m4w@distanz.ch>
References: <20201027233646.3434896-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027233646.3434896-1-irogers@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-10-28 at 00:36:45 +0100, Ian Rogers <irogers@google.com> wrote:
> The bpf_caps array is shorter without CAP_BPF, avoid out of bounds reads
> if this isn't defined. Working around this avoids -Wno-array-bounds with
> clang.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
