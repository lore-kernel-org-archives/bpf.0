Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE14375ABE
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393582; cv=pass; b=YNE7n1L/7HjY1LG/tXKVpniN6XL/IYvgOHsEhTO792Yu4hX9MH0TjEIOXiSJ87iVWT9VbJxNQJ0qKrh8Md2NzZv2I7LLpDlaXrhGl1pQx2DPPfq2djI+Ry047r1e3cVvbh1ca+vVS7/S+ovR57vJyEsu8IxVbPLQ6AUAwPEl0/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393582; c=relaxed/simple;
	bh=Mrl9hnYjNzsvW5V/54263E3XvGLPbjPgQW7Qq+pl7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twhNH3iaVZVexwq4/mCgPmZ2QpqbnGhtOTxIR0yho3yOQVaREt5zvNGgtclW0YGckqU1sqnkqqy7uh62mkD82ARXVl+kznhnQFI49a6F3j9PI8T+dEMlXWbe2BO5dhTJ7DgBGQViddA5lEsWAlkpuQTdR8o1jB3MFcMq3c5BgNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVriEuJI; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVriEuJI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e8c6fb80so89101cf.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790393580; cv=none;
        d=google.com; s=arc-20260327;
        b=C/VJxx94+Nu08JjdvvwgviXybYsxU6NJIg7z66z1Ame3kvvGoxCMr1gKywNo0fG0YG
         8BxvNUpraQ2eapCE9eAQfb65SWlnELH+VOsfflOt/mUUHel02xHhI+7O3EPfXZvtikFt
         asPWBv53cV3eCcloJZOA6CqY5XbWMOLicm7NoL/6et2CyFHOgkzt9LVLnTbS9XK1iBsb
         un3IpzhYwAezOZNJhXIzszg34nVja1PAJoJRocCNJg7oQcB9wf9vLaVnk08qFQ0MShfX
         Qr+jlU/99ZUINoW9opW5XibXkgjGURiFhqaAq7/xdrY9KnxP2Nliv8ZADoxXZn9fzTym
         G6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        fh=fCYgdE2BiaWmCbHgFCPn07WG8zUCfNK3JWk2gC7knMY=;
        b=OlJwDvXTVOTo1s9YzibeDUs32+x3XqOwG4W7yhkV41vA0U3y+rHPcWoX/abTSW7Tqm
         NvD/0st5JvwkKGeyfP26BoxPRT4Ecwd7o2gWJD9LvaFqHQOsOhPLdjCf9F2RfL0AsSyB
         0ce3WNDAwvjmJuZqcYvztC4FE62eH9/S7oZVdsRVAQcozT9uQ4zMcHbxtXRd+W6KsysX
         f38gVklkvsDJobaRBpLd93Rd16mCEV6JCOwBLum+zDrmF7gNNfuoG4OXoIF+sWXEUljX
         ahDFO152dUpkjrPyKhYR8//hXQeQF9xDj6m0s9aGPPm4151CSV1DPbtvTVyKOHQBxhIs
         EwJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790393580; x=1790998380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        b=WVriEuJItxd3dx61FWbAq2BFcTZ5g17EhX3ymbqaMvFMr0SU1/Qk9Z7qK0Qq1BNySw
         2P4AS3Gcx9lSPgWV+N7lWWhn4aBKfHRr1j9+oQQYQknOLL0t3LGSiLBQDI+0FmHEx7zF
         +XRIJ3fd5IysW/OVkjflA9lC7BBvFx09GyCXmkVcHQeKt1Np5jBA02TMV5KlJ54ys1TR
         ytXMVvjr1KV52Bxh8LxgQ6WoglKWgp65BdGo5ygO5PBG706a2esSlIj8Q8g+XlF+8N9B
         eV1RPc0FijG7WRsbQSOmV/ore9GvaNqn97DGD4qRUQ88hoobFl0/twideJJVFDX2hK9K
         kGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790393580; x=1790998380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        b=FXyavJttQF9mXLImN31GcdNEVvJIOw9WTTJSMOoCVgYkK6fDZ5qFAMCo4yqz38qE23
         Vwqu/wr5xbBCmUkmYr5HJSElyakkJNlMfoEFwq4MYZiTdCryy78ZAZ2AN9AuaEm4Dw1V
         niei0sqv6ibgvlCm4bt+e1CMUXcBoBXremfCUla8H5/ZQCkNKSksFJHBiHRBNzRNpOeX
         htqp1Dz9MsR73P0dH/awuITmj2jVFFuXEOKw69UeJ5Rfw2vqr6LH+GT0i997s8hMEgZy
         6W2H5p1rwS1Bm13vRyFPISp7acCAwP5W7RGKDV+CGlHRLONsqA8ie/NskJSYKuBHG7WP
         iJrg==
X-Forwarded-Encrypted: i=1; AKwUvByMnso+w4RCBgawbXDTDs7MwpKGPAoSs4kIruZy7ELtOEZ110KfqeMLKmtqgQVbJgyD/3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n1UgHr4C7j4HnZa4fFY873q+pnx58WxUa6IGC4PXD2s2ifvB4t
	pqSjpyR5nJNZFEnA6fR9kDP3+dk89bPL7W6K0eg7CalFtBFRnMgaeSB4rzluiIgt1zjAgEmxUBB
	UAf4nvcuk7BfgDuJJV+u6uvwbW8gmoqF7Zd29Wrho
X-Gm-Gg: AYBFou35oPAM9zJFRyRERXJ/GxiZnWIpozoHJtMJYX5iBS9K3CS5fAn9hi43+WskUut
	LR/XNEt9VrSIxb5wQODVbVT3Nap6XW5bpB/IIBoOoNkDCn2Z7w4RsqcSQQaljKe9L2DfuVjBmTb
	6VZfVRYv6CLeZsw+8HDHRIe9ZPVk3sLCrT9IRVcSyavdjODV26dFWdF0HkExYnMxH1vIYJ6sxe5
	wsV6ivulFQY4yXTBaPLggsInafJGVAYku2WUO+DtyJ7kGLsA97k/+WJfB9dPEVKlX7frf1ZhcW0
	U60NLOzFD58bbexPSK9B7Lfk4TyQwD4ctKKhUuXQ1KReGX5a3oSU3fY=
X-Received: by 2002:ac8:5c95:0:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-53320176517mr3678531cf.12.1790393579518; Fri, 25 Sep 2026
 20:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com> <20260807111818.GN687043@noisy.programming.kicks-ass.net>
 <ao90ncOA2Ce8ezIc@google.com> <arc2CZ5SrPlI0hF_@google.com>
In-Reply-To: <arc2CZ5SrPlI0hF_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 20:32:47 -0700
X-Gm-Features: AclHuK9Y-s7mwnYOc2bTtxVwmooo95aKKvfwHl6gj3vOPc0ZaRqs9Us7YYM1Bps
Message-ID: <CAP-5=fVbfU+eCqasH7U5366jgHzP-7+H5Lg_Vm5-C_-dt5ceKg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET
 support
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Aug 26, 2026 at 04:19:57PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Fri, Aug 07, 2026 at 01:18:18PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 07, 2026 at 12:18:10AM -0700, Ian Rogers wrote:
> > > > This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET to the
> > > > perf_event UAPI and implements full support across both the kernel
> > > > and perf tools.
> > > >
> > > > Background & Motivation:
> > > >
> > > > In order for perf to translate virtual addresses of samples into
> > > > symbols a file and offset within the file are needed. During event
> > > > synthesis perf will create mmap events to facilitate the translatio=
n
> > > > of a virtual address to a file and offset by modelling the address
> > > > space of a process. By directly recording in a sample the Build ID =
of
> > > > a file and the offset within it, no synthesis is necessary. The Bui=
ld
> > > > ID and offset as a pair are much larger than a virtual address, so
> > > > there is a trade-off between synthesis cost and extra size for
> > > > samples. These changes just facilitate Build ID and offset as a cho=
ice
> > > > for perf samples and the user can have the choice to use it when th=
ey
> > > > believe it is advantageous.
> > > >
> > > > In practice perf still needs to map a build ID to a file, so by
> > > > default this change keeps synthesis to allow this. It is expected a
> > > > user that knows their build IDs, say through debuginfod, will disab=
le
> > > > this option with say --synth=3Dno.
> > > >
> > > > The kernel support uses the existing build ID and offset support us=
ed
> > > > by BPF stack traces.
> > >
> > > That is still a giant stinking mess that needs to cleaned up.
> >
> > Then we can discuss how we want to handle that as well. :)
> >
> > I think this work would be useful on large systems with lots of tasks.
> > I've got reports it took too long on synthesis and timed out.  Also it'=
s
> > racy and easy to miss new tasks..
> >
> > So I think it's a good option to explore and maybe we can make default
> > once it turns out working great.  But I'm afraid it may need some kind
> > of optimization to handle multiple addresses like in callchains/LBRs.
>
> One more thought.
>
> Maybe it's not a good idea to traverse the VMA tree in NMI.  Can it use
> the deferred unwind framework to do that later?  We could extend it for
> non-callchain data like IP and BRANCH_STACKs for user space.

Thanks Namhyung! I will incorporate this in v2.

Ian

> Thanks,
> Namhyung
>
