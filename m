Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC938F947
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878843; cv=none; b=YwFt5HfIQFGEMbtvRhJibOVZKWWQyxJ2YqW4JSToZMCIYCSJlJFik8ByjITJP//fycS/sG2y8cPh/+vh6NJxYbGgLrrjnGxC2BHOovz5cE2cBWLTSmGCHRRRg3yZKgzwEjeFdtJFKrv2GDOFTtbxqMhNNcPocPr89EarR3mP8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878843; c=relaxed/simple;
	bh=dXT2ahJqasc9p4cQsCG156kB2AzaxEJOjoIHqogI8S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP8MzPeihlT/svSsfisBu6/LxH0/DcurKwwK0EwUHgqHSXkKHQSYdaZv+pPo4H0r1v3BtPTFumSMkIgxddG5pLvIzFnVXvwg7XxoY62V1SDeBmt8FqUupQSZ+gxRSaWygMsfG14gtU5EWtAjEyBgTOYrexe+ralzZEHC+rqaNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2EozNqD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2EozNqD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47248615e4dso115354f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782878833; x=1783483633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYt1JaFwWQ+K5BLa9YiKbNban4KncdVGbMcNeutj1cE=;
        b=b2EozNqD3Rto9LC6ZaiIHBEepu9kBGmS6TciNhkYnQEf5DZvEdPXmKrAnhC7+3te9O
         1QtRU6ZmP5OZNGpGTcL/IV79KCu9F72Lr0mn3rzxJPvxMoX8hL1jTbgjqpdBL4ew/VDp
         oGAbElFYrKKV8XTxQLpkqtLCBAPPhW97/uhp3oPu6KatKzSIgoNVJRy24446GEfQWKll
         x3IwKOT54iC8sNV6DtzY8YmOW4Mn4mTpcjATk4WTd/Mycz/PwY7ztQCzZK81uzqZ36Cu
         EOsXyu3TdEghxA7vnAce6IzQqNK2ieo6Z96pYuQ80OaXMkgHzIXubXb0xujzy3lJ2U/M
         TnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878833; x=1783483633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYt1JaFwWQ+K5BLa9YiKbNban4KncdVGbMcNeutj1cE=;
        b=pa6GgQpjQwblaF7iULZlzgrB7gOJPFL8t1+uhg2gfTGmB8TOy2ETzNdotuw34CAhlM
         lBcq2GCc/EDa3LjobHDDmUYO0aT+HEmZFDCXx+xyua0yAfRBkwZki4dsH4eLWjxRT6k5
         8rd3YqMeukY3HYqwGarzxHlb/Esqf3OAOOrF5Gjd4AYrcJW0H+iKeDlvnhZYWU8HXnkE
         F7T7cax13D+lGvzmbfrv9kK7VUSRTzH+gp7tQ2CPOMOWRsXBiISglqN0TFdrg6O4Ch16
         iqpcMTWNd+0PBRxyrizUBFGz1vD4KA7yTM4pa9+735QtzhODFp5xPzesK7TqylyW/p+F
         gAvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr440pEI/wJiyke8C3QW6h/ieDHkSwA8nsT1uBwuz9HZjm76Jdkl0Iolzdt82sAUugb5cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38GKvNwCyhXnt6LevWbaeqMGKj3ty0B2RtTW2PngEnEJT2gqw
	P+WjwK3vijZucOQGTUB/YDXWS6paWAnlltr1EYWJOt2uZS/5t/kUr8kA
X-Gm-Gg: AfdE7ckUW+f2VUEwMdSYoIx8dutJl/ZoejLjrrwif6D8myfrL9w/PaGLNAKvAfokJSW
	p+0qnc2kBKMOemMkC4iBjm6KFiZiE6RwqfPTatGTsw4OLU7Ysi/W8SEt/7aXAkSj7XQsbqvBL8c
	TocDtH1KwezS7pJ1Cf8OypTv3S4baRyclS4JKPE7ZfVYaExeg7dxb+rFSGbl2H/ea//wvIbnc+D
	4fLiIpWQxMERIbDVrCcv3lEeuGJ/YIqXzkYXSfPjSovrDxyexkBTMnWyyFCBZyeF8W9gnX06Qkb
	qZOv5zR9WZmCKICZbns1eVHs2sqshCS/AS7jGNcUloAaiZhh8Qx6vAU24A21/7c8O6mQwolPCyI
	Ac1VbaSH9YCtApDivQKvRbt9RWf9byMGWFUh4Jnygo6qZKBHmhlA6ZDh+XQwNEvTI9J9TORdUFz
	oiU9TB5s5c+K63tSyg2qjm0Gl8XEz1KKiK
X-Received: by 2002:a05:6000:993:b0:472:90af:e406 with SMTP id ffacd0b85a97d-47659ee659bmr4120684f8f.37.1782878832738;
        Tue, 30 Jun 2026 21:07:12 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm13850596f8f.8.2026.06.30.21.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:07:12 -0700 (PDT)
Date: Wed, 1 Jul 2026 04:17:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Message-ID: <akSUyRNYp6hx7BK+@mail.gmail.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <DJMQ5HY26JFM.3QOFH7X8RTPIL@gmail.com>
 <5335390d-6627-49fb-9645-ebcce410277b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5335390d-6627-49fb-9645-ebcce410277b@huaweicloud.com>

On 26/07/01 10:18AM, Xu Kuohai wrote:
> On 7/1/2026 6:07 AM, Alexei Starovoitov wrote:
> > On Sat Jun 27, 2026 at 3:51 PM PDT, Xu Kuohai wrote:
> > > From: Xu Kuohai <xukuohai@huawei.com>
> > > 
> > > This series introduces static-defined tracing probes for BPF programs.
> > > BPF SDT (static-defined tracing) works similarly to USDT. User defines
> > > probes in the BPF source code. The probes are built into NOP instructions
> > > in the ELF. At runtime, when an observer is attached, the NOP instruction
> > > is patched to a CALL instruction to the observer prog trampoline.
> > > 
> > > Unlike USDT, BPF SDT requires explicit macros to generate the function
> > > prototype BTF for each probe. This allows the verifier to validate the
> > > probe sites against the declared types, and observer programs can be
> > > attached similarly to normal tracing programs using the function prototype
> > > information.
> > > 
> > > A probe with two arguments in the target program can be declared and defined
> > > like:
> > > 
> > >      BPF_SDT_DECLARE2(my_trace, int, int);
> > > 
> > >      SEC("xdp")
> > >      int xdp_prog(struct xdp_md *ctx)
> > >      {
> > >          int len = ctx->data_end - ctx->data;
> > >          int ret = XDP_DROP;
> > >          ...
> > >          BPF_SDT_PROBE2(my_trace, len, ret);
> > >          ...
> > >      }
> > > 
> > > An observer would be like:
> > > 
> > >      SEC("bpf_sdt")
> > >      int BPF_PROG(observer_prog, int len, int ret)
> > >      {
> > >          bpf_printk("len=%d ret=%d\n", len, ret);
> > >          return 0;
> > >      }
> > > 
> > > The target program and probe site for the observer program should be set
> > > at load time via bpf_program__set_attach_target() manually, since program
> > > names are not unique and program IDs are allocated at runtime - there is
> > > no static way to identify the target program.
> > > 
> > > For BPF_SDT_DECLARE2(my_trace, int, int) and BPF_SDT_PROBE2(my_trace, len, ret)
> > > macros, the compiler produces:
> > > 
> > >    [code section, e.g. xdp]
> > >        goto +0                  // NOP, patched to CALL at attach time
> > > 
> > >    [.bpf_sdt_notes section]
> > >        ___sdt_jt_my_trace:      // symbol marking this entry's boundary
> > >        .quad  0b                // 8 bytes: offset of the NOP in the code
> > >                                 // section (resolved by the linker via
> > >                                 // R_BPF_64_ABS64 relocation)
> > >        r1 = %[arg1_reg]         // 8 bytes per argument: BPF move insn
> > >                                 // whose src_reg field encodes the BPF
> > >                                 // register holding each probe argument
> > >        r2 = %[arg2_reg]
> > > 
> > >        ....
> > > 
> > >    [.BTF section]
> > >        FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
> > >        DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs
> > 
> > Interesting idea and encoding scheme, but I don't think we need it.
> > I'd rather see static_branch/jmp work that Anton started to be completed.
> > That would be more generic and folks that need SDT-like observability
> > inside bpf progs can instead guard their debug code with static_branches.
> > SDT equivalent would be static branch plus a call to nop function
> > which can be freplaced.
> 
> Sounds like this is similar to the kernel tracepoint approach. I'll
> hold this work and recheck if a dedicated SDT-like function is still
> needed once Anton's static key work is posted.

Yes, one of the reasons for adding static branches was tracing.
I will post an updated patch set soon and cc you.
