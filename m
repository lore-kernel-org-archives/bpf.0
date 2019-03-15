Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A07C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378B0218A1
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nCZIVT8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfCOUZ3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:25:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46166 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOUZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 16:25:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id i5so6287302qkd.13
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=x/KeJ5HiD/0iEPonBBgI4iYyAQk3WhtlAj06JB/Hzx0=;
        b=nCZIVT8pyBX7UdW4iMU571nrlxxqk7SPxaTvOipr3cP7tUQlPVuUTCxsmLPxhi4N14
         qLKeJBM6d+HqGnac3yZclFj/4mIjG4JZbYsWYPSxJ1Sg1sWRRagBbv546oxqnSSfb44+
         CBrUZEyyfwLa7OMvEqfs/xArFKUHBBTKbl4i5Orw27yzedrLs7uT9dQE+aG+w/owBeYq
         cs77kiUT50gN86jy4rP144J+U4eTPUG/2ZLfUwZtgqdQ1/17+oNJbheHZMez0s8bb/YB
         lDygEplA0LZykrza88lxUnqgbrKIRm/vOkHASl0HgLiMZ/ZKaTfuwKOlkOHixR0V7eyh
         hRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=x/KeJ5HiD/0iEPonBBgI4iYyAQk3WhtlAj06JB/Hzx0=;
        b=uDImOoa/INND73LiyZKf+pVa4LAST703D7s8dNjCw1g7n53YYxiwJ2tu7CpzJAxXlV
         tn2nnhIF8j7JriXlsk9rDQeVqgtGx4VQILl17d2InlE70HO4FnYS1zniVZ3nzgNPoPlw
         JTGLUco4OswVPj2d7CTyP6qzQeC4HxDRV7Y/z8trXBVMKIwBJEYG4VSnLoi/49dJrKQs
         566SXHdq2sWOWsDYs/0vB3lG2gq0mvnVKYGuewV9P2oLbs0euE/xvq4IJf/RerMHDns2
         Fq4MKCLZw4G4+WDbk34E1JSQ/kKJlkRFquZy1sChKLf3UbnNOgIbqeEj7TFhpxdz6Qit
         irxw==
X-Gm-Message-State: APjAAAX5JogrKy5vq/Yw9+8XWj+AdGY4/NGShKJZExmYXwqnTK1tOX8i
        KKcVnMtBmsSF4rOLKjdKViqBaQ==
X-Google-Smtp-Source: APXvYqy6HyPBNfKWj8NR5ydFNPbDkdvkGpVo8VrhO7RWHl00RGIhUJ67gV61Ejiin7NNqxJxvAcAqQ==
X-Received: by 2002:a05:620a:1533:: with SMTP id n19mr4308373qkk.241.1552681528086;
        Fri, 15 Mar 2019 13:25:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o71sm1998672qka.18.2019.03.15.13.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:25:27 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:25:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
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
Message-ID: <20190315132523.74c69051@cakuba.netronome.com>
In-Reply-To: <20190315194800.GA22548@kernel.org>
References: <20190315183211.GB24482@kernel.org>
        <20190315121632.246824dc@cakuba.netronome.com>
        <9f6fefe5-0b9f-6257-4e84-19759dd72ab4@netronome.com>
        <20190315194800.GA22548@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 Mar 2019 16:48:00 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 15, 2019 at 07:41:35PM +0000, Quentin Monnet escreveu:
> > 2019-03-15 12:16 UTC-0700 ~ Jakub Kicinski <jakub.kicinski@netronome.com>  
> > > On Fri, 15 Mar 2019 15:41:41 -0300, Arnaldo Carvalho de Melo wrote:  
> > > > While developing 'perf trace' and looking at BPF maps it puts in place I
> > > > noticed that one needs to first use 'bpftool map' to lookup a map id to
> > > > then use 'bpftool map dump map id <map-id-looked-up>'.
> > > > 
> > > > This is needed because everytime we restart 'perf trace' the map IDs
> > > > gets changed so we need to do the ID lookup again.
> > > > 
> > > > To speed up this sequence, allow specifying just the map name, look up
> > > > its ID and then use the existing routines as if the user had provided
> > > > the map id.  
> > > 
> > > I can see how it could be useful for quick debug.  Names are not
> > > guaranteed to be unique, though, do you not care about potential
> > > duplicates?
> > >   
> > 
> > Jakub beat me to it by a few seconds :). I discussed possible workarounds on
> > that point with him though, so here are my two cents. I see two options:
> > first one would be to return the ids of, and then dump info about all maps
> > having that name. The second one would be to simply return an error if
> > duplicate names are found.
> > 
> > We agreed that returning an error if there are duplicates is probably the
> > best way to go, because dealing with several maps for anything else than
> > "bpftool map show" would be problematic (clearly, we don't want to update
> > all maps with a given name at once). Of course if you have other
> > suggestions, feel free to propose :).  
> 
> So, if there are dups, just tell that and print the ids, i.e. the
> following, for any 'bpf map' command that finds dups, except for this
> one:
> 
> [root@quaco ~]# bpftool map list pids_filtered
> 45: hash  name pids_filtered  flags 0x0
> 	key 4B  value 1B  max_entries 64  memlock 8192B
> 90: hash  name pids_filtered  flags 0x0
> 	key 4B  value 80B  max_entries 512  memlock do-the-mathB
> [root@quaco ~]#
> 
> I.e. if there are multiple 'pids_filtered' maps, the output for, say,
> 'dump' would be:
> 
> [root@quaco ~]# bpftool map dump pids_filtered
> There are multiple maps with this name, use 'bpftool map dump id NR' to disambiguate:
> -------------------------------------------------------------------------------------
> 45: hash  name pids_filtered  flags 0x0
> 	key 4B  value 1B  max_entries 64  memlock 8192B
> 90: hash  name pids_filtered  flags 0x0
> 	key 4B  value 80B  max_entries 512  memlock do-the-mathB
> [root@quaco ~]#

Yes, this looks good (modulo JSON output, which should probably be
just a single "error" value).

For simplicity I'd personally go for just always printing an error
if name is duplicated and not bother with listing the options.
