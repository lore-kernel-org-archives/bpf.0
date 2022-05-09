Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A98C433EF
	for <bpf@archiver.kernel.org>; Mon,  9 May 2022 06:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiEIGRS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 May 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiEIGFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 02:05:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14674163F69;
        Sun,  8 May 2022 23:01:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F31468D06; Mon,  9 May 2022 08:01:06 +0200 (CEST)
Date:   Mon, 9 May 2022 08:01:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv5 bpf-next 1/5] kallsyms: Fully export
 kallsyms_on_each_symbol function
Message-ID: <20220509060104.GB16939@lst.de>
References: <20220507125711.2022238-1-jolsa@kernel.org> <20220507125711.2022238-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507125711.2022238-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm not sure how I'm supposed to review just a patch 1 out of 5
without the rest.

What I can ѕay without the rest is that the subject line is wrong
as nothing is exported, and that you are adding an overly long line.
