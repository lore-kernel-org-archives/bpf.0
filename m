Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E96348866
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366450; cv=none; b=FHNI3UDllwCpWwWBRUcfraZjG6Ii0xtoMKTuYGb2Kf36erdX9oL5k84h/r0tIfOZYjalvVRoI7SfSz4tZfH+wM3cMsc0pFtZU9sxwz86FSQJ20ByiKNoYmtNi7d9UWaPCrjfJhDZup48B1vZ12OJLyN7LeB23tc/cuzg4plC0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366450; c=relaxed/simple;
	bh=cJUFiVuff/KPlnx1eULVJx3hfbbTA1i+WxGtZimLSEo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYsZ0NCDyN1S8hwKb8yoF/4sphhTzM/oKGMHxRDxfH+lyE6FHAaeG+GqAqxVOsdU3nXPOI/pQSbMOJQgW7bx4WM5HZEoRLTyrl3Prsat9AvNgdfzs+oXvjX9ayYKfcMaP/+ogSjTtNS85fKQXZFSRgzLpgTlYfwV0lvDoq/hHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCLPzcaI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCLPzcaI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso18711295e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 00:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770366448; x=1770971248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yK3NKY8aaTUDoPfEVQhx9I8PtsQ63/NYZYEF7PuRZjc=;
        b=SCLPzcaIBHfa0u65NVJfUj0vQWTmcHicdHZzt2h36sOQwG5Z1w6tspO5dV/7SekjNR
         SJs02zRH/q6xWu2ewis1iVOac/o5+wQEmHqgTCHfkFQo5+Hj29c01aw3STgm38k6uXDr
         B5N3v3ggebUNps1e3y4sGuHdbw4Vc8aTmERFUKAcQMGNetGyQrCx0cJPbDWkxqAJKciM
         5BHpz47cmYldleb2puOZdbXM148EpAkLDPPBKZAVtx7HfcpWr6C4MZLbXlyt1dYENPZ4
         DnB6r0k7vhcc/1cQ432VlXIgNmRJM25sy5NPzTFaUC1ySlSLrRzs1LZE9MmTD4YMbRxQ
         1dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770366448; x=1770971248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yK3NKY8aaTUDoPfEVQhx9I8PtsQ63/NYZYEF7PuRZjc=;
        b=h/DbyPYRs0KQ6P4EZ4WFykHppUPSN6mTIYogvWbXbauVwJxaSeJgaAb6R4R4kRiq0g
         Fiv2PGiA0dU2Ydgl4TYT4QSWR7uta14XjIbBJ/qKMSMqqTYTittl/rOyrGsVJRuqbSIZ
         k9qfiUrjkVkt2ZVShAek1eolzhSaz0u8e+EMnanslsdZQbtkr+k+uDXk51ZKUZMP9PhS
         +sBSC2vvfrO+BYCLCHILnAm+2Y3zwKSYaKNNvVO35wzlssy24n2D19LHnjkX1+NSRqAp
         ZnO82WekYsJr9m+NGXIgw4B2xNix5tXqZTGKvimIKi/vYPBHiHSLszBEaQhEhchZKywM
         csOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3SS49TlvzF+qoS3qGdFnCydeCFa9ntS+W2qnflhtDM8n3I4oWMwZm2ohcIArv4PVeunk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tt0V/RqnHcJTJ5dmlm2ZwFvg8BsEAQW0JofXAunaV3s7nGHo
	00wAKXUzvWL9d5gctXEH7MnzzzVaRMV72PY2dAjtj8egEfxPU04THfHY
X-Gm-Gg: AZuq6aJfMJI4RNAZGCb2nnNATzvKyRTYfR5Filskzk9F2L3PoPUjeShKjTkdlRJqpax
	YrTk21L3GVRqEplsTimUZXG8XswKmyFBv017VCNzsyl+BjkNVDqN22cE4AuCTpDPh8gsu5AXM3u
	VD8DLMz0FJ1/L2X3rGK5MjnZqC0E6tqiUcXLi3acSG3/5SjyY76K+JgmlMRfrYF2Yr/z2dzGXRa
	5YdPBHeLPgEuj4m2J7WIqJLYTZVsUoRAfrX1Q+eCluI0BBOlbXkLnkiZfpRMXoJD06IRRys+Sca
	Y5EaeCMcbAEmdoAVgiRymZpD1XDF9nZrfnnT3BVMVV14s+9H/ZccoixWGHAE0wOlYXfS1+YRc+0
	6mD9CnlgTodyBhdAlAzECR5f4G/Nb0qf7qpJIe+1w3gzoWbhJ2deBR7nzqDs1TKJvvBKaJFM=
X-Received: by 2002:a05:600c:3148:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-4832097e27fmr19030385e9.28.1770366448150;
        Fri, 06 Feb 2026 00:27:28 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320638ff7sm40060185e9.0.2026.02.06.00.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:27:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Feb 2026 09:27:25 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 04/12] bpf: Add struct bpf_tramp_node object
Message-ID: <aYWl7Y9ok32_eZXi@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-5-jolsa@kernel.org>
 <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com>
 <aYRbYY8f_wWoiZhk@krava>
 <CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com>

On Thu, Feb 05, 2026 at 02:27:38PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 5, 2026 at 12:57 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 04, 2026 at 11:00:57AM -0800, Andrii Nakryiko wrote:
> > > On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding struct bpf_tramp_node to decouple the link out of the trampoline
> > > > attachment info.
> > > >
> > > > At the moment the object for attaching bpf program to the trampoline is
> > > > 'struct bpf_tramp_link':
> > > >
> > > >   struct bpf_tramp_link {
> > > >        struct bpf_link link;
> > > >        struct hlist_node tramp_hlist;
> > > >        u64 cookie;
> > > >   }
> > > >
> > > > The link holds the bpf_prog pointer and forces one link - one program
> > > > binding logic. In following changes we want to attach program to multiple
> > > > trampolines but have just one bpf_link object.
> > > >
> > > > Splitting struct bpf_tramp_link into:
> > > >
> > > >   struct bpf_tramp_link {
> > > >        struct bpf_link link;
> > > >        struct bpf_tramp_node node;
> > > >   };
> > > >
> > > >   struct bpf_tramp_node {
> > > >        struct hlist_node tramp_hlist;
> > > >        struct bpf_prog *prog;
> > > >        u64 cookie;
> > > >   };
> > >
> > > I'm a bit confused here. For singular fentry/fexit attachment we have
> > > one trampoline and one program, right? For multi-fentry, we have
> > > multiple trampoline, but still one program pointer, no? So why put a
> > > prog pointer into tramp_node?.. You do want cookie in tramp_node, yes,
> > > but not the program.
> >
> > yes, but both links:
> >   - single link 'struct bpf_tramp_link'
> >   - multi link  'struct bpf_tracing_multi_link'
> >
> > are using same code to attach that code needs to have a hlist_node to
> > link the program to the trampoline and be able to reach the bpf_prog
> > (like in invoke_bpf_prog)
> >
> > current code is passing whole bpf_tramp_link object so it has access
> > to both, but multi link needs to keep link to each trampoline (nodes
> > below):
> >
> > struct bpf_tracing_multi_link {
> >        struct bpf_link link;
> >        enum bpf_attach_type attach_type;
> >        int nodes_cnt;
> >        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
> > };
> >
> > and we can't get get from &nodes[x] to bpf_tracing_multi_link.link.prog
> >
> > it's bit redundant, but not sure what else we can do
> 
> invoke_bpf_prog() specifically doesn't have to get prog pointer from
> bpf_tramp_link, it can be passed prog as a separate argument and then
> bpf_tramp_node  with cookie separately as well. I haven't looked at
> all other code, but I suspect we can refactor it to accept prog
> explicitly and the relevant parts (node+cookie) separately.

ok, makes sense.. will check on how to refactor that code

for some reason I thought we don't wan't to refactor jit code much,
because it means changes through all the archs code.. but this one
should mostly change just arguments, so it's probably ok

> 
> Just at the conceptual level, we have single prog and multiple places
> to patch (trampolines), so we shouldn't be co-locating in the same
> data structure. It feels like a complete hack to duplicate prog just
> to make some internal code access it.

ook

jirka
