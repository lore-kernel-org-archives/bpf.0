Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B8270EC3
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785703473; cv=none; b=NkiWgxCW8E6xZhzogD1knyDYzLjFmZNHjvtV38bv8W1SsgoxW2bgBjeW388E8RSDhPaYumqb2XB1991Pw7JdLvHMw0+O5DPi0YhmVW20dCziwFSChKOMFL1sV7/a4joz9TqbD08oJmr1MGRGBWx+jAlsYL1Jgy8SY3UJOG3v9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785703473; c=relaxed/simple;
	bh=XoF2yLF3AcvHIdTsY8+5xQfUf5rqYNg3g91Py3R48nM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf2/IAOl+2r69Bd64XKZPtvCxfPc879uRYgBoGW0+cZtgWxc7y07rH7SMc/LxmTDucM24RqlgX2nWWMltG9j0KhPmwvd187PF+4s2EUuzltVQYJE4Mi/3NwZKRUIBCwRpG965kLIVFt64gnbh806bbcbsqsyZ3+doe3Xk9IfYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYQqho85; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQqho85"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso5941515e9.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785703471; x=1786308271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0Po6SXhfV2vXQAkV6y/NPCPoeX6dz+V1IoPOu929LY=;
        b=CYQqho85vIYW54C7T/LuNZF+XP6kEz6GqinVZd1K45OrdACOK4fgJjVPvVO9V/TLu+
         m5pzpiGV/TT81y2lwNF1tE1gvBLvRi8pfB/TeJtePmAma7/nUFgWzswVXoVH39GROu20
         hWLe5PVSruXssnNjOS0qPqI4Fy2+SG6Cqs4/FAHqpS+a5S7sPzEPvYmbNfaKczaNow5+
         m8UgU3VvNGlj5t2NRX0l+o7yaC2JLHk4Z2luVhn7c9PFQim8qf492rpDwas2Z76XPoFz
         HcrnR7n4R0YLzFJzxC0k8l3b4MbRPKpR2MS36dL5ADVdngCYazpAb+bDmVxFnl81Sebs
         cePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785703471; x=1786308271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0Po6SXhfV2vXQAkV6y/NPCPoeX6dz+V1IoPOu929LY=;
        b=IxEnqIcbBnNgYenRqqpXimN/P9QAE6XHdafpQVIpSF65hSLwhhs5MCsmEbrxgygbI6
         mKCXSQPFLCpAPkaa9cVKwhwxQ26PCP1TA/4ihBv3lfX2BG3iRFQSTKDX65QofjcGInuX
         XSyavS8Xjc5BFzj5O/zRhQb4riUPYMHLupkF8I67aeDIqxP6NmvEdqoJnA00eRNXFJF9
         I7PPd/frXvnx6RCmI20AJf54H/De+jRP6u5O17EOpGs39rllP51Ndg8DapCODr9PCGZ7
         gBpmoRICO6SznTMqFOY7YJDUrZ6WdWzvZ4hea2mqVp7gVbvswJ+BjS1A4hHLG8nHhlRj
         uTKg==
X-Forwarded-Encrypted: i=1; AHgh+RrG0M7P/qXb8mjHi1eKhT+XK1FsWKv4RcfrEC28fQt+un4KsDVRRjMufIUDDhzoRVzPNwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVXoZTZYHb/MGCRw+CZWPzxnYO0Ujyph9qozK9NSvJZZPD4wz
	DB6RjR4B9CV8tMBqjOqLB9WedcAj1ryil9UT+1b0ayD1gD0Cbe3/YiVS
X-Gm-Gg: AR+sD12/rNwcupuqYhaE7vbYfPvQ9UNxhIvCHCl0mudf5fbxXQOAriqRtXjvG5Gg5pi
	y/Tu0+MeyhHsk6yI3LzdUeDF2kzpiWd+RdJIs8g2TRGSGRMGE7OJIwex6DVHL7s7P5/dhpmn1PS
	7UzGW0usGFUK75wiVIGEHol/hrModda9iUJhHREe/nNBMKc2X9Jo2ptUGI9KITBNjHxsOADiL1/
	qlRlehgsAEykF/R02Pak6QQlYiD+osfrgh4dkiOcpsXwt4i9vw0RgkJsMNSpZJaBBS9OcojbVxh
	aLn0n9NRFRMxCUUdTRI8a/pSGeueYIJaOMQKFSZERI6WkBqZ7hluewxchSNMmS9Ak8R4aSjvTl7
	EJdtkUYn84fvmob3EgKvJSK3rM0kwz308wQSrEADiFIVUqSPChsmzUZVGpy7hIjCw4WAvzKT9kR
	7nye4xbdxQiv+0uttmNjfFg7RYHzHgSetD5X777F53Sem4qsk8
X-Received: by 2002:a05:600c:a4d:b0:493:e46e:157d with SMTP id 5b1f17b1804b1-4980c693eaemr164544645e9.19.1785703470644;
        Sun, 02 Aug 2026 13:44:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm218215135e9.3.2026.08.02.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:44:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Aug 2026 22:44:27 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <am-sK_buCVI3khJv@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
 <amsuU7eXuoziObdh@krava>
 <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>

On Fri, Jul 31, 2026 at 10:30:37AM +0800, Leon Hwang wrote:
> On 30/7/26 18:58, Jiri Olsa wrote:
> > On Thu, Jul 30, 2026 at 11:05:42AM +0800, Leon Hwang wrote:
> >> On 29/7/26 19:56, Jiri Olsa wrote:
> >>> On Mon, Jul 27, 2026 at 10:28:43PM +0800, Leon Hwang wrote:
> >>>> The BPF tracing multi link updates several direct-call sites through one
> >>>> ftrace_ops. Its implementation is therefore gated by
> >>>> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
> >>>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> >>>>
> >>>> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
> >>>> direct calls. This enables BPF tracing multi links on arm64. Also
> >>>> generalize the unreachable-trampoline comment because the single-ops path
> >>>> does not use ops->direct_call.
> >>>
> >>> hi,
> >>> iirc arm needs ops->direct_call for trampolines to work properly,
> >>> that's the reason we enabled single ftrace_ops on x86 only:
> >>>
> >>>   424f6a361096 bpf,x86: Use single ftrace_ops for direct calls
> >>>
> >>> I don't understand the arm usage of op->direct_call, but it looks like
> >>> (codex thinks) that the fast path won't always work without op->direct_call
> >>> being set
> >>
> >>
> >> In theory, op->direct_call is the fallback for the case:
> >> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=y, out-of-range target, and non-BPF
> >> direct ops. This is what Codex thinks about.
> >>
> >> However, after searching the call sites of
> >> register_ftrace_direct()/__modify_ftrace_direct() in kernel, which would
> >> set ops->direct_call, the actual callers are in bpf/trampoline.c, which
> >> have been gated with HAVE_SINGLE_FTRACE_DIRECT_OPS. That said, for
> >> normal usage of HAVE_SINGLE_FTRACE_DIRECT_OPS=y, op->direct_call is unused.
> >>
> >> If someone uses register_ftrace_direct() or
> >> modify_ftrace_direct/_nolock() outside BPF in the future,
> >> op->direct_call will be used.
> > 
> > so any 2nd user on the same function triggers the slow path,
> > and that's fine, the single_ops handles slow path correctly
> > 
> > but IIUC the out-of-range target will now always go through slow path,
> > which in current code it doesn't, right?
> > 
> 
> Right.
> 
> Pls see the sibling thread with Ihor. With in-range BPF trampoline
> allocation, the slow-path regression should mostly disappear.
> 
> Let's continue the discussion in that thread.

please paste the link/subject for that thread

thanks,
jirka
