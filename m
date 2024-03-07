Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FE633EE
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802944; cv=none; b=GVjpuDuIlZA+9FvF3ozJW2geQqCKbd6I6Soi3JwHVWSUP4w9uov27TrCL0VA43oak6fw8OUSSQK6p1XFXjGayrEkTXD6t9ZtixlqlpaenrdHymt1klhedInINXpFT8LMA2vL5gD/JM8WcUCtxCujOb1TgP70r8di/Ugal9WCNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802944; c=relaxed/simple;
	bh=Ex/YtpeQ6zOb2VjSiAzzNrAJFXCii7IjYwdt77pS7Pk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXg5qA5KDvvYzpabF8YMOT64KT2I02VCrrwEncc343ioK3NZ9dkwyTuEMXTEK5bywgUuKkqnk7Ue6W9ykOVhmFHLhVDBjLBUbTnG1XY0IsL0tVSGio3kYEaAoIS/bHbvBm10cvUqyGUfz9ShJmAYU5Taf8IasO07rywpWRjwtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJnFPi6s; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJnFPi6s"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so723317a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 01:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802940; x=1710407740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDvCC5XTXUzHuemp/cKdblWiXf/lH0h/s2K0KOGjnlM=;
        b=RJnFPi6sF9+p6uBHqBcV8iHC5WZMhJ/WqujL2qOrIruEncIsj9MKNvdw4YS7Ant6Ln
         0oPyj6vFwBjIIxSvRp5YRx6nRXLpsHFV+pMX5MDf0E6tc5Ka/MtqolflcbC0+i0EI3Se
         DerUXWXZkFHC94fNx0W6/fpVdx22DY68ObugaIsfto8LXPyFcoQsaTi4Yh6FiAUv+aYn
         zmyC8pNrDTpaR3ER+T8J6pfc4MlU1Q9dAOwFIA9NUVwmOZdcinskNwjIbhlmpJtASiCY
         kxt3y5HJ2qqCzeThzuaDwMxUjhKbZ8URVk24GOpeUgEDHGzJrQnmbRnufD5eKnmVMoSm
         gHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802940; x=1710407740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDvCC5XTXUzHuemp/cKdblWiXf/lH0h/s2K0KOGjnlM=;
        b=uG/1xe/boV3adQinrQjrQOpTZ3GSHI7hirrhVMDjibJM+gFJ6FlWZHDw/Kgu0i8m+F
         uCo+Gje9UrgkC8BL2uUtIIRxunQ1OrvrCdBqyE09bZEA/Q6Z4Q1Nlf30Kk6MubVBjsfm
         Ex5226hjmKQb+6zxJTHqTsxvprROE/yqAvfXJQhwSRK4tAsMO6ktkEFAB+pmIIRuQgAh
         7RmPgFgKpnfG4habbrg9bxjCcZoYzR4V9p8EfyzvH+pwqIOpzGc4MRWdGhTZQ8+VaHrd
         w/S7XQJpUqCToaVOh6YIKUyeXTBoVarv5iIHrj9e+Uq9T/5zaBXivlMBbGsJsjbnDImi
         vaDA==
X-Forwarded-Encrypted: i=1; AJvYcCUvK+v26QqzFpANZHqhfX/WWeuld8pMCrUCd9oSfgDQtUwNj8ADxewlPJZY/O84Hws3+0oKIj0o+XsVRVZ2aLpxUiMR
X-Gm-Message-State: AOJu0YzVX+Ew9qYaJJspMBB98R82rDeP7gzAXi6UIiPevAF6cTY2avA6
	rYinVntKspfLTa4eMZL6s/32dhlo9sJW2Hslerw0Nb5tdVdZdiJw
X-Google-Smtp-Source: AGHT+IFv+odCIPhphJl/bdxifFzYHIJs9P2WjAu84KFSgcxq9SdhWpzcBpQphbWe7g5IYYIxobp1iw==
X-Received: by 2002:aa7:d1d2:0:b0:567:6db5:c373 with SMTP id g18-20020aa7d1d2000000b005676db5c373mr7056662edp.26.1709802940218;
        Thu, 07 Mar 2024 01:15:40 -0800 (PST)
Received: from krava ([2a02:8308:b08e:be00:8f2b:9f9:3953:bf])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b005681486cafesm649704edb.0.2024.03.07.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:15:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Mar 2024 10:15:37 +0100
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Kui-Feng Lee <sinquersw@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZemFudw2SOhdwwVW@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
 <ZedT8S-GjNOry5LZ@krava>
 <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>

On Tue, Mar 05, 2024 at 03:53:35PM -0800, Song Liu wrote:
> On Tue, Mar 5, 2024 at 9:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
> > >
> > >
> > >
> > > On 2/29/24 06:39, Jiri Olsa wrote:
> > > > One of uprobe pain points is having slow execution that involves
> > > > two traps in worst case scenario or single trap if the original
> > > > instruction can be emulated. For return uprobes there's one extra
> > > > trap on top of that.
> > > >
> > > > My current idea on how to make this faster is to follow the optimized
> > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > user space trampoline that:
> > > >
> > > >    - executes syscall to call uprobe consumers callbacks
> > > >    - executes original instructions
> > > >    - jumps back to continue with the original code
> > > >
> > > > There are of course corner cases where above will have trouble or
> > > > won't work completely, like:
> > > >
> > > >    - executing original instructions in the trampoline is tricky wrt
> > > >      rip relative addressing
> > > >
> > > >    - some instructions we can't move to trampoline at all
> > > >
> > > >    - the uprobe address is on page boundary so the jump instruction to
> > > >      trampoline would span across 2 pages, hence the page replace won't
> > > >      be atomic, which might cause issues
> > > >
> > > >    - ... ? many others I'm sure
> > > >
> > > > Still with all the limitations I think we could be able to speed up
> > > > some amount of the uprobes, which seems worth doing.
> > >
> > > Just a random idea related to this.
> > > Could we also run jit code of bpf programs in the user space to collect
> > > information instead of going back to the kernel every time?
> 
> I was thinking about a similar idea. I guess these user space BPF
> programs will have limited features that we can probably use them
> update bpf maps. For this limited scope, we still need bpf_arena.
> Otherwise, the user space bpf program will need to update the bpf
> maps with sys_bpf(), which adds the same overhead as triggering
> the program with a syscall.
> 
> >
> > sorry for late reply, do you mean like ubpf? the scope of this change
> > is to speed up the generic uprobe, ebpf is just one of the consumers
> 
> I guess this means we need a new syscall?

yes that's the idea, to replace the trap with syscall,
so far I used light version of that for initial testing [1]

jirka


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=uprobe_syscall_bench_1
