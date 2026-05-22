Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DF30E821
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484763; cv=none; b=ns9JHtB6A4NimGbDetBh1/jjQuZyWVEiHUNVxc8+hW7YBvbDkHMwvI58J/7HG3KH638mZz/nu0tErQM86OLtY0fjT63UTK8EL+vQzQSqfVF49e2AsXZKdxGtsiv8vBdumarCBqZn5VWOBkYQc4QtHFk/3gJFPOxaHIsyKeBgHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484763; c=relaxed/simple;
	bh=L9wbN1T4LDGePzg75yM9dmh/F/pg8lluRRQrq19Elbg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVe2AgoSJ/wqNL2N6/OC8JKVuaam8zi5MnMeOeKGxHsjVwVXayKJKxuobnAtd1guvCJykjJpq1rNFAxDigrnf8bajpsU65YzrLlRReIr/wWuUPfmqJ8GMJ5wnxUaUpBOME/qbnUhsFL7qm+zfz2Jf5+uzzCPl3pvn+zPWqEInTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7heXhti; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7heXhti"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso56164455e9.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484760; x=1780089560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Ojzs/5/GrhBIbAEZOryGvNL55Luuz8K7dEMD1BYwVg=;
        b=i7heXhtiSSTO9VeebO2wXWtTCeMTErdqwJncHrBUWNksKCVOQpF4sHqDkKSFnyzmJ8
         mfn3X6gxyoUH/OxEhSSp1t80YayuVrqwLRFZAd3WZblEDCGTMTiN4GxHFjbpAoVUU6rw
         InnutzvbrNfK80eiIRHx5PI7tgihtLwz9ES8AgCDgg+gfF/u5ZTz/aMJKphTKGwNziDf
         RTu7eKDMRSWIdG5dNCQIwV0rpe0AQhNRJSdMpZjVz/LgSjfVcg5G78VBLZr1AaK8llNd
         MPEgxbM8dLSBQ0i+DwaxjWjDaaKUqrjuK8zcpe2F/jWtMFGOiKlundpObOdxDqTp/mwy
         XKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484760; x=1780089560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ojzs/5/GrhBIbAEZOryGvNL55Luuz8K7dEMD1BYwVg=;
        b=B35gzeSfNNmcuKasp5ZHZ8f0dRUCOlreklW8XLTz+1kUv3u2K78ur7LluX2q/YwXtv
         dVzK+EyPjsnBjzhiuvbN2y0GSNx9JKSTroQ//LTBjn5wCkfLxWpodBCM0y5UI+iPvhQ5
         fBuzyiB/njALXhbOZt7OW7dojN2PztFk2SCvo1lXARzG5jCLlwOwlT2Ml3QGC9Pf/mhG
         Qfgx2fvx7HaOUod2uvq9+n9iwCUkTe/ilcxgbMyil947lSSDpUAeFyRU2+d0mgrsdrZs
         yo6TLJ6JpRK5XDib+/toVjctTqWQUdzXzCkII0/y6mKPh+8GuoKAMjUCA/vbBstxQ0QT
         ysGA==
X-Forwarded-Encrypted: i=1; AFNElJ95Mm4AXy3fwM3TIwAuBN8nwwD+h3fMuKhc+8mS5FC3zMjxP+XC/FLHWNgKvOG8S37Zdwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjsChiMaz5FxUUDkWtE5vi1hbAnxPImteuh+lwsOLcJ2tpUPW
	K0W0UnHk4mr1zE8u4B/VXgk2nSLk+mCfZSmKTyn+/0Rj9yINn55MDqbunBzK47Nd
X-Gm-Gg: Acq92OGbM8Szy1HT3ehN4a7r8bUzTzOfAeQoYkFoSC1u3q9OZTZAJBOezMMpABL9Fij
	Cnrdv/9qg1kemn9tQPuMcgx/v/ORRypiEtYrVUhd4wdv1TbIgnHxE9JYvoGngYCRsqHk/WgCG6M
	RAiIgAmhYSRXcwxRg1tLgRGWgPoPdH/6HG/X1ui4NOOI1zAexD85T5T0/yoz1Aq/Nkob62H1wRy
	tl//4Niv8T2fJ5dekDG1ezKFkNS6K2ilJyl2gBdlsJpf3yV9x4Xt4syMhylL5533MW07FlbUyiU
	oMiUAMwXEb4YNYKuZfbnGkYJjwIYqkj7JS1himYaDEm/wCJuULMikEaWw5HDCfkwTt58bbhP3iY
	AnjWgKbtsj3ZYUj0xQAW1AUOT3zvCh+NTGkJw1sxNFSj5iNP+fzzHEU70cvnI507MRPhxsshvK+
	iOlgLXz0WKOJk=
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490426cef73mr73301715e9.20.1779484759881;
        Fri, 22 May 2026 14:19:19 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424b5b80sm37865495e9.6.2026.05.22.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:19:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 May 2026 23:19:17 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <ahDIVTM5WfVqiYE6@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-5-jolsa@kernel.org>
 <CAEf4BzZ+MToBKJS9Vdu=YZrX+2kRpUcmWejVhuoqhtu-ijqDAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ+MToBKJS9Vdu=YZrX+2kRpUcmWejVhuoqhtu-ijqDAQ@mail.gmail.com>

On Fri, May 22, 2026 at 11:50:44AM -0700, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 5:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> >
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call, like:
> >
> >   lea -0x80(%rsp), %rsp
> >   call tramp
> >
> > Note the lea instruction is used to adjust the rsp register without
> > changing the flags.
> >
> > We use nop10 and following transofrmation to optimized instructions
> > above and back as suggested by Peterz [2].
> >
> > Optimize path (int3_update_optimize):
> >
> >   1) Initial state after set_swbp() installed the uprobe:
> >       cc 2e 0f 1f 84 00 00 00 00 00
> >
> >      From offset 0 this is INT3 followed by the tail of the original
> >      10-byte NOP.
> >
> >   2) Trap the call slot before rewriting the NOP tail:
> >       cc 2e 0f 1f 84 [cc] 00 00 00 00
> >
> >      From offset 0 this traps on the uprobe INT3.  A thread reaching
> >      offset 5 traps on the temporary INT3 instead of seeing a partially
> >      patched call.
> >
> >   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
> >       cc [8d 64 24 80] cc [d0 d1 d2 d3]
> >
> >      From offset 0 and offset 5 this still traps.  The bytes between
> >      them are not executable entry points while both traps are in place.
> >
> >   4) Restore the call opcode at offset 5:
> >       cc 8d 64 24 80 [e8] d0 d1 d2 d3
> >
> >      From offset 0 this still traps.  From offset 5 the instruction is
> >      the final CALL to the uprobe trampoline.
> >
> 
> I'm sorry if I'm slow, but I don't understand why we need that second
> cc at offset 5? Isn't original nop10 processed by CPU as single
> instruction? So it will either be at ip of nop10, or at ip+10, no? If
> we trap at ip and in int3 handler +10 from there while we are
> installing lea+call, why do we need cc on byte 5?
> 
> I.e., I don't understand how CPU can end up being at ip+5 until we
> finalize lea+call sequence? Can it?

hum, so I though it's for the case when you do unoptimize+optimize,
then you can have cpu executing the previous lea and hitting the int3
on +5 offset.. but as pointed by Peter (and you) the call instruction
never changes, so now I'm not sure why we need it

jirka
