Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9D2253EC
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770931; cv=none; b=FIuDJIq31bXc/cQLLRqzvfYpSirZmtMXO6ioxhBsr7BVprR726E9CuQe5H8J4Sqwn2amy8XZCozIAGJtoDFd0iLP0mDPMLJDVNZQ0IEnaPyCBx4PsYct4bTsYz66/Q/mdIy17/S2ro0dswYEey0BjlAi+P66d/P3ZIDz/Wl64JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770931; c=relaxed/simple;
	bh=7cdWsvVouZdci2tuBuZCRf9vT20zQ4iz3OMRvwePt+Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8YWl9WUdraMjJh4wMsz5gJns/oSVL7VP5Qo95AloXWxYbuCuaOUUHKnYglM4RCAvX08E66eZx7/tWpPcQMf62/iUB/ltxiH1TP6KBM4Ww87SdQ+l6pwQOJBBv4qAijH84ho0d3PqKYCBRUZ1B9Md0w5RM7lkgAjs63sa3awrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA8PhoiT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA8PhoiT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso25882555e9.1
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770928; x=1772375728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKOt9R7P3WfV391G39qPHz/kg+9iqxJyHBFj36QYW+c=;
        b=WA8PhoiT596c5BWEuvo9ReTJWfi7t6MEKxx3zZEtjBskc0ckgqOdx7umGf1EZRUROW
         /EeoUqejihr2vTM0iud2uWFpkqKEMzKjijJgaVb+j0kyk8DHD+SEe64B5f5lYq893qeV
         pPyBckAeTl0yzLaCMcfDeR9gqCSPUQwyxCt4PsedoPJYMk8eGKDpPR8cWkS+h1QuQLMb
         QkuhKVXM2p6drNootLWo8iA06BKDDBS2vNgcEm4eaaBpvLLYQRYgfGETGXu4mCoqywQS
         u5FCstORS6zEqYE48m2qVCusUFP5HKh/9P28gwKX2HqONrUMmNpqYAMUfhaI29/cUH/5
         /PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770928; x=1772375728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKOt9R7P3WfV391G39qPHz/kg+9iqxJyHBFj36QYW+c=;
        b=QpcvGpQ9vTGsnyPetLwWTt9mJel4sLlrx9umVaffyshWAU/KSuLlETr8WMWDgiMVxY
         xwoVwnNiYahKbN7IN3o6iUapAI2HHNko8cHSmsAIZ4ov1Lz9veI5R0MHb/gB5efcwXmy
         FTPzPBe1aPkfqFv6nMURGkpQrs2qVoKBZWDfxyAefTuMQ1KW1ZYx8+Kn91pHMoJMBa/o
         7hIowuIDFmL8tHpdqBZAAKsj/f1YThvc5pbe+TAfW/C+of0/wvwz1hLS6/RfRlZGfpyN
         pyNQ7k80HWuONFAE9HLpOS+uf8s7J9+/YgZAk+3aQD5wQ6fIMLwatsC9XcKQgY3zbtDB
         pccQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu790VvyjqxwczJGPwHQ4YITWKmK0aG0lzeYkSJMIyQTU+Fm1z2rY35H01f/ANyBC7CO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0woqDIiMSlHweFh2eJPjBChGMqg6FMfW9p4u4B+TosCOA0Sk
	mBdeiGWvH9kbdpVzGngFNsJiqzgMuTEkkweuBDObGqH3gjaxBn0bH3KR4bHuufEP
X-Gm-Gg: AZuq6aLLwb1pGsZ6tkoWA9rENwn7iEBZzIYO4SEjhByKFbmWQjNGFkLKAFan1f4dFKY
	ZrF16UuDxaZy5P/WO2AeczhPsApVW2WcRe1EV4Sjk2AJpiCxDHmwJFeUk6sWGZeeDLEU2hVR6DS
	2oycQM+ACMiCTs2zKyYvf9d8z1LOI7MdpQXbqsqPOph4s+mJ3PGe2qdzh7VRmZHwk+Qjk6n8h+q
	QlhAU+6bB83QKI7VtAESG44ZUKHqHlaE1kEevB+CG6Dh2/zsWwY0qqxX9IZdc2gAdWHtzXmrGTm
	60ejHgoTE40qAddgsXsr8wEtvwEbWyIGETS05+MTj1CTf419ow/sAo5D11+9/xTYNABsdSB77V9
	QrSvTkXDhnFtoM0jgQki0So48d2CdHDpnKsRZsUyKLSEsyvlxinKLDqUWympHkI37pMepOSUs
X-Received: by 2002:a05:600c:8b02:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-483a95aa31dmr91911095e9.1.1771770928501;
        Sun, 22 Feb 2026 06:35:28 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm11408066f8f.20.2026.02.22.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:35:28 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:35:26 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link
 session
Message-ID: <aZsULjQcIO-PModZ@krava>
References: <20260220100649.628307-11-jolsa@kernel.org>
 <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:56AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 5892dca20b7e..1cd6c1457bd3 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3611,6 +3611,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
> >  		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
> >  		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
> > +		    prog->expected_attach_type != BPF_TRACE_FSESSION_MULTI &&
> >  		    prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
> >  		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
> >  		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
> 
> BPF_TRACE_FSESSION_MULTI is now accepted here, which means
> a program with this type can enter bpf_tracing_prog_attach()
> via BPF_RAW_TRACEPOINT_OPEN:
> 
> bpf_raw_tracepoint_open()
>   bpf_raw_tp_link_attach()       /* name == NULL */
>     bpf_tracing_prog_attach()    /* BPF_TRACE_FSESSION_MULTI */
> 
> Further down in bpf_tracing_prog_attach(), the fexit node
> initialization only checks for BPF_TRACE_FSESSION:
> 
> kernel/bpf/syscall.c:bpf_tracing_prog_attach() {
>     ...
>     if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
>         link->fexit.link = &link->link.link;
>         link->fexit.cookie = bpf_cookie;
>     }
>     ...
> }
> 
> So for BPF_TRACE_FSESSION_MULTI, link->fexit.link stays NULL
> (from kzalloc). When __bpf_trampoline_link_prog() later calls
> fsession_exit(), it returns &link->fexit with a NULL link
> field. This node gets added to the trampoline FEXIT list, and
> bpf_trampoline_get_progs() then dereferences it:
> 
> kernel/bpf/trampoline.c:bpf_trampoline_get_progs() {
>     ...
>     hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
>         *ip_arg |= node->link->prog->call_get_func_ip;
>                    ^^^^^^^^^^
>     ...
> }
> 
> Would it make sense to either add BPF_TRACE_FSESSION_MULTI to
> the fexit initialization, or reject this type in
> bpf_tracing_prog_attach() since it should only be used through
> bpf_tracing_multi_attach()?

yes, I think we need to reject or MULTI types in bpf_raw_tracepoint_open,
it's allowed to attach only through new multi_link attach api,

good catch, thnx

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181
> 
> AI-authorship-score: low
> AI-authorship-explanation: Code follows established kernel BPF patterns for adding new attach types, written by a well-known BPF maintainer with terse, practical commit message style.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: NULL pointer dereference reachable from BPF_RAW_TRACEPOINT_OPEN syscall when BPF_TRACE_FSESSION_MULTI enters bpf_tracing_prog_attach without fexit initialization, leading to kernel crash.

