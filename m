Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC54C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94362177E
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550584586;
	bh=4Rtw2/lMEnNfClfil7NNZc/YVqC8mD6WE+a6ms7PMpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCpH1ZyFG1TlEbVAMqdpIb1H2yogBgYD6eVEnyNwIWLIh5+qWIK9q8j2wyzKtEocT
	 Zxx9QYR4Pyo0JrxlnvlpasvdKK8gzs5fwXuQ3qLPeqyqmxraSUmI5bAll1IY+btauy
	 t3HdxE0+/H9hWk78wgZ2qbcXhJvttxBqxJlvrr6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfBSN40 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfBSN40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Feb 2019 08:56:26 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753272147A;
        Tue, 19 Feb 2019 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550584585;
        bh=4Rtw2/lMEnNfClfil7NNZc/YVqC8mD6WE+a6ms7PMpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZianNDkZW+oQ7nvagjYEqR4ohbr0rafIDF5gJYTwOuMemNZQuCNVxkqqvKIFlFs1
         bNKObEj6aOcpBaLMyQbcRDmj6HTU1O05s52h9HJSBkStpQ2MCEsxgB1BNIgYo4cDOL
         xt6igP/9kc8JKCJaQpjdtkXymw47Xm01UOh9tue8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C4C4410D5; Tue, 19 Feb 2019 10:56:22 -0300 (-03)
Date:   Tue, 19 Feb 2019 10:56:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
Message-ID: <20190219135622.GZ31177@kernel.org>
References: <20190217082018.1008069-1-andriin@fb.com>
 <20190217082018.1008069-3-andriin@fb.com>
 <20190218142900.GR31177@kernel.org>
 <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 18, 2019 at 11:38:41AM -0800, Andrii Nakryiko escreveu:
> On Mon, Feb 18, 2019 at 6:29 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Sun, Feb 17, 2019 at 12:20:18AM -0800, Andrii Nakryiko escreveu:
> > The 'struct sun_disklabel' is interesting, pahole doesn't print it for
> > the DWARF case when pretty printing all structs, but it works for the
> > BTF case, I'll investigate.
 
> I wonder if that has something to do with the fact that btf_dedup also
> does FWD -> STRUCT/UNION resolution?

Nope, when printing the classes (structs and class) pahole has this
show_private_classes option, so that structs and classes that are
defined inside other classes or functions are only shown when you ask
for that, and that is what sun_disklabel is, it is defined in
block/partitions/sun.c as:

int sun_partition(struct parsed_partitions *state)
{
        int i;
        __be16 csum;
        int slot = 1;
        __be16 *ush;
        Sector sect;
        struct sun_disklabel {
                unsigned char info[128];   /* Informative text string */
                struct sun_vtoc {
                    __be32 version;     /* Layout version */
                    char   volume[8];   /* Volume name */
                    __be16 nparts;      /* Number of partitions */
                    struct sun_info {           /* Partition hdrs, sec 2 */
                        __be16 id;
                        __be16 flags;
                    } infos[8];
<SNIP>

This information gets lost when we convert it to BTF, so for btfdiff
I'll add that option:

      --show_private_classes Show classes that are defined inside other classes
                             or in functions

When printing from DWARF info.

- Arnaldo
