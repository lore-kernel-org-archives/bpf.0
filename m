Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E52C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A52C218D0
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSExuGHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCOTsG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:48:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34524 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCOTsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:48:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id n6so6235736qkf.1;
        Fri, 15 Mar 2019 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xo/aIbLDIyCLgNtb+NZ4RnCWICbCc4VFGFBYxGMuUNU=;
        b=JSExuGHKFw42+kLFy2lv65qYJYAWNugQx6SduW1he4nTf3Q72vSxagKLrLJrNdnLAG
         lWVCoKD/9uOJvfjTTiueez0rGp4Z3LfoGXafHPXPSTrFhgmZEqG9b23lM0N7Dv1o4kLH
         sIHL7cswf+8UKgpWRfWA/9ZBCmwWMf5o1Q+ZtjbDj5Igok3ahMjG/bELFNEMJOWVwzAC
         /05oV/wvxGixdFYoAulPrajHItFI2nd4pi9f43q/1q3qCGU6zlKeUB0guGGtnjWp8Ia+
         LoCH2Fox+1vZcbj7cCYRQZSkljS326tAjqPRjRE2F4pq4KRCEPCDBjSV3bvkuY/rxLiP
         0guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xo/aIbLDIyCLgNtb+NZ4RnCWICbCc4VFGFBYxGMuUNU=;
        b=JgZm4Nj4Xaxv32jVpM3oBFoNrNUI7qwz2eOgjhXePzL/2HMtmFvv+yCC/Rx3/WMtzy
         2MwtUhzZZgS3wUXrzTQwk7j6UzlgrPeew4yKmBurOE2WdvfYkrlHyn+d7hx825qtnf6w
         eu/7WYLeuxzyG3pcXV+2JqQNRBSuatqUN3l5k0RrC/pbxkCSbvVjpJFMnhOCop4kIijo
         XkJNxrYVzZLADYTe1stiH88QVGYEHgPVKFZBFK1Qcf1wWoUgYYgB9KT7E8dQVKRmPKSz
         m8iWPWzDmqfgSYsn6DBdbPBIbbpvpN/1SsqbV/OdqdB+L9I4P5aTbgR149K7M2DRXyxp
         8MUA==
X-Gm-Message-State: APjAAAUMgNribOlImsSOUJdyz/qvpiN9M5LVLVvSq2NVpzellAk9iUDq
        Hpfux1Vu+ladDLgsNbCQxv8=
X-Google-Smtp-Source: APXvYqxgOcF+4x82iUcYO0+zDydLrULaP6mSC14R9zp+YFeH0Xj0ngzuZb+HM4vGLW4Grcc/k4ikPg==
X-Received: by 2002:a37:96c4:: with SMTP id y187mr4040277qkd.149.1552679284192;
        Fri, 15 Mar 2019 12:48:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id e22sm1843225qto.33.2019.03.15.12.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:48:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3FB784039C; Fri, 15 Mar 2019 16:48:00 -0300 (-03)
Date:   Fri, 15 Mar 2019 16:48:00 -0300
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] bpftool: Allow referring to maps by its name
Message-ID: <20190315194800.GA22548@kernel.org>
References: <20190315183211.GB24482@kernel.org>
 <20190315121632.246824dc@cakuba.netronome.com>
 <9f6fefe5-0b9f-6257-4e84-19759dd72ab4@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6fefe5-0b9f-6257-4e84-19759dd72ab4@netronome.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 15, 2019 at 07:41:35PM +0000, Quentin Monnet escreveu:
> 2019-03-15 12:16 UTC-0700 ~ Jakub Kicinski <jakub.kicinski@netronome.com>
> > On Fri, 15 Mar 2019 15:41:41 -0300, Arnaldo Carvalho de Melo wrote:
> > > While developing 'perf trace' and looking at BPF maps it puts in place I
> > > noticed that one needs to first use 'bpftool map' to lookup a map id to
> > > then use 'bpftool map dump map id <map-id-looked-up>'.
> > > 
> > > This is needed because everytime we restart 'perf trace' the map IDs
> > > gets changed so we need to do the ID lookup again.
> > > 
> > > To speed up this sequence, allow specifying just the map name, look up
> > > its ID and then use the existing routines as if the user had provided
> > > the map id.
> > 
> > I can see how it could be useful for quick debug.  Names are not
> > guaranteed to be unique, though, do you not care about potential
> > duplicates?
> > 
> 
> Jakub beat me to it by a few seconds :). I discussed possible workarounds on
> that point with him though, so here are my two cents. I see two options:
> first one would be to return the ids of, and then dump info about all maps
> having that name. The second one would be to simply return an error if
> duplicate names are found.
> 
> We agreed that returning an error if there are duplicates is probably the
> best way to go, because dealing with several maps for anything else than
> "bpftool map show" would be problematic (clearly, we don't want to update
> all maps with a given name at once). Of course if you have other
> suggestions, feel free to propose :).

So, if there are dups, just tell that and print the ids, i.e. the
following, for any 'bpf map' command that finds dups, except for this
one:

[root@quaco ~]# bpftool map list pids_filtered
45: hash  name pids_filtered  flags 0x0
	key 4B  value 1B  max_entries 64  memlock 8192B
90: hash  name pids_filtered  flags 0x0
	key 4B  value 80B  max_entries 512  memlock do-the-mathB
[root@quaco ~]#

I.e. if there are multiple 'pids_filtered' maps, the output for, say,
'dump' would be:

[root@quaco ~]# bpftool map dump pids_filtered
There are multiple maps with this name, use 'bpftool map dump id NR' to disambiguate:
-------------------------------------------------------------------------------------
45: hash  name pids_filtered  flags 0x0
	key 4B  value 1B  max_entries 64  memlock 8192B
90: hash  name pids_filtered  flags 0x0
	key 4B  value 80B  max_entries 512  memlock do-the-mathB
[root@quaco ~]#

- Arnaldo
