Return-Path: <SRS0=D/lL=2J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81520C43603
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE1D206EC
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 15:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSPKg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:10:36 -0500
Received: from www62.your-server.de ([213.133.104.62]:41862 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 10:10:36 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ihxRi-0005Zt-N2; Thu, 19 Dec 2019 16:10:34 +0100
Date:   Thu, 19 Dec 2019 16:10:34 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Add missing newline in opts validation
 macro
Message-ID: <20191219151034.GA4198@linux-9.fritz.box>
References: <20191219120714.928380-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191219120714.928380-1-toke@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25668/Thu Dec 19 10:55:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 19, 2019 at 01:07:14PM +0100, Toke Høiland-Jørgensen wrote:
> The error log output in the opts validation macro was missing a newline.
> 
> Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Applied, thanks!
