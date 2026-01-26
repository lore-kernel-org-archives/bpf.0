Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD629CE9
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420886; cv=none; b=IHOZ9m+acoJ8UtDIH+DWoNtjkBwL/+ekULJKnTAGsxnGwdtrw/R2veKVMyem0vdclqSKwlvM4EeZ/01YYSJZ73n8XqzmpQw2eyePMb7TWXYeujoBNSthd5EcWnW3lxSabwkcoJ0fi+OQRqGU3SlwGEsvt+2wibk5QJCCxe8XHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420886; c=relaxed/simple;
	bh=JuWl88GUT2xNpe/aGWnkgndeh1Tr9QkfFN1BABiUC4s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuD5VY3U6ZH3KaOQ1Tz8gmf/N7yucsPnJHOzjtAxoNPh7Xmwv1q6QGD8GixiawoLhSrPWUN89vysLr3fT9TZm1k5JL8j8G4CURMX3VIbnhyQRi7h+KOY8iaPh+u7gEZxXxlxtonRvlHaucYokWXa1QqA6YJBGxDwlj/kxf8cE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgq10quC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgq10quC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432da746749so2248678f8f.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420883; x=1770025683; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ku8hCC/KeIeBXZMKlasY4QhX+B4SFXs580a4fks1WRY=;
        b=Rgq10quC8okGybKbwcLnOjxD7i9kxrX8UsYRXDsPnh7QbgytFON32IjqCWZ1avwaEq
         HX2emsjQuhLivsN0jH70V+c9B2DFR9oln+qV6C2R6MccVFJ+AsQS/B8UaZpV7/wFHxK2
         sHQmMBDWDeCd6onFRyFS79mhrR5+4H6PhGEtXhqG20W6IGLRzeL+ZnBMUIqEOvEsel0p
         q8cosLuYMA0xIfB6QoTatH34gjY3I34nAdwN/CwPLBRFAxyMHd39nDY3C2wpqgPCxiBs
         J2WshpDRVLBArpB79trm1WxOJ8/tQEdhPHvKgbURfYBfPvzgpT9NTIgYevXXGGecU8z8
         mFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420883; x=1770025683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku8hCC/KeIeBXZMKlasY4QhX+B4SFXs580a4fks1WRY=;
        b=Lpn5J8xBOXN6NukUmTB8dnEMmO8tyqpzh4xEcBvD1K8Hvoi9X3bE89s8YB83rAo9V+
         pTzGjP5zEL/Yk/Mt+PRr7hWcoaJch6Ou0ASBXbP5Epsdxac2T0uDDHCXJyADaxO/1LbI
         KKGRDWIr+6l/gyD4deLeRMSnY850sEbDPsNwcn/mE6LvXjcpXgVfYKTmepl2q/kJdjuH
         g6FSC7jtOQ+r5oYxwMKiWWu4+nfFyQ8iPXmZs+UvFB4VaFkpm1Lr98f93NIs9rRdAK3w
         4RGv9CmZ/+vF6zTssnd7v3s2uxV4pmsY4eYKRfCbdmsio2LJ0YPgLN1dQHo+rHtqpaXq
         YXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtfmx0zYDEapfXKL9ooBsueCh6YXeJ9MFQqu/W6YFmZ/q3jNLE8h2hEKx2uMRGjCe9RYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHboLOupQfyIQUoS8/1zCHHOhmhBCoMEF6chmj6NjX/3AecrxE
	a1lDb5Nu/ZX9bVPTQt9ZaJuagJJB/fST9o4LVXrTMzM/t9dkDWdihj2T
X-Gm-Gg: AZuq6aLwEmJcheDy5HuHCz8Kxai6RE5zV99AtqehItXfX/+3mRfJW3IlmXA28i13luR
	PlBbpU3DgRysbzc68RhEHA6cvXGTUENx2f6hEOWHLnnM53qATyI+UPknJ5H0jMIxbrVdvYc26Kb
	YXuNcZSYQePsjKMyDB4Yb4rAf3Gj5EsoKpefkd7MobQWXhZf2I78rR89/+54ZBLBB+l4hnpEIqe
	RtP5gKna1Vhl/7fllc+TlUZLRjDUTbfLwBfcU5RpafeFsTOTgz66HUokwNuWPBVR+D+sGa157sV
	HwjhnCSzleiR2tSj/FTOXP7vHoaiLEoWMoUEpfjicQUpbS1RHycf22IHkKq+0BiYSfOWmGxwqgp
	CzvyGf5NIpisYulBwB0PpECPia4OmHpkYwPjqzpSSdJiLkeu8LKMa4jO8vFRX
X-Received: by 2002:a05:6000:2403:b0:430:f97a:6f42 with SMTP id ffacd0b85a97d-435ca39c59bmr8042341f8f.54.1769420883063;
        Mon, 26 Jan 2026 01:48:03 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm27562381f8f.38.2026.01.26.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:48:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Jan 2026 10:48:01 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf
 trampolines
Message-ID: <aXc4UesvE3zYfPqn@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>

hi,
gentle ping, thanks

jirka

On Thu, Jan 15, 2026 at 10:54:09AM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 30, 2025 at 6:50 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > while poking the multi-tracing interface I ended up with just one ftrace_ops
> > object to attach all trampolines.
> >
> > This change allows to use less direct API calls during the attachment changes
> > in the future code, so in effect speeding up the attachment.
> >
> > In current code we get a speed up from using just a single ftrace_ops object.
> >
> > - with current code:
> >
> >   Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':
> >
> >      6,364,157,902      cycles:k
> >        828,728,902      cycles:u
> >      1,064,803,824      instructions:u                   #    1.28  insn per cycle
> >     23,797,500,067      instructions:k                   #    3.74  insn per cycle
> >
> >        4.416004987 seconds time elapsed
> >
> >        0.164121000 seconds user
> >        1.289550000 seconds sys
> >
> >
> > - with the fix:
> >
> >    Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':
> >
> >      6,535,857,905      cycles:k
> >        810,809,429      cycles:u
> >      1,064,594,027      instructions:u                   #    1.31  insn per cycle
> >     23,962,552,894      instructions:k                   #    3.67  insn per cycle
> >
> >        1.666961239 seconds time elapsed
> >
> >        0.157412000 seconds user
> >        1.283396000 seconds sys
> >
> >
> >
> > The speedup seems to be related to the fact that with single ftrace_ops object
> > we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) and
> > we skip the synchronize rcu calls (each ~100ms) at the end of that function.
> >
> > rfc: https://lore.kernel.org/bpf/20250729102813.1531457-1-jolsa@kernel.org/
> > v1:  https://lore.kernel.org/bpf/20250923215147.1571952-1-jolsa@kernel.org/
> > v2:  https://lore.kernel.org/bpf/20251113123750.2507435-1-jolsa@kernel.org/
> > v3:  https://lore.kernel.org/bpf/20251120212402.466524-1-jolsa@kernel.org/
> > v4:  https://lore.kernel.org/bpf/20251203082402.78816-1-jolsa@kernel.org/
> > v5:  https://lore.kernel.org/bpf/20251215211402.353056-10-jolsa@kernel.org/
> >
> > v6 changes:
> > - rename add_hash_entry_direct to add_ftrace_hash_entry_direct [Steven]
> > - factor hash_add/hash_sub [Steven]
> > - add kerneldoc header for update_ftrace_direct_* functions [Steven]
> > - few assorted smaller fixes [Steven]
> > - added missing direct_ops wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >   case [Steven]
> >
> 
> So this looks good from BPF side, I think. Steven, if you don't mind
> giving this patch set another look and if everything is to your liking
> giving your ack, we can then apply it to bpf-next. Thanks!
> 
> > v5 changes:
> > - do not export ftrace_hash object [Steven]
> > - fix update_ftrace_direct_add new_filter_hash leak [ci]
> >
> > v4 changes:
> > - rebased on top of bpf-next/master (with jmp attach changes)
> >   added patch 1 to deal with that
> > - added extra checks for update_ftrace_direct_del/mod to address
> >   the ci bot review
> >
> > v3 changes:
> > - rebased on top of bpf-next/master
> > - fixed update_ftrace_direct_del cleanup path
> > - added missing inline to update_ftrace_direct_* stubs
> >
> > v2 changes:
> > - rebased on top fo bpf-next/master plus Song's livepatch fixes [1]
> > - renamed the API functions [2] [Steven]
> > - do not export the new api [Steven]
> > - kept the original direct interface:
> >
> >   I'm not sure if we want to melt both *_ftrace_direct and the new interface
> >   into single one. It's bit different in semantic (hence the name change as
> >   Steven suggested [2]) and I don't think the changes are not that big so
> >   we could easily keep both APIs.
> >
> > v1 changes:
> > - make the change x86 specific, after discussing with Mark options for
> >   arm64 [Mark]
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://lore.kernel.org/bpf/20251027175023.1521602-1-song@kernel.org/
> > [2] https://lore.kernel.org/bpf/20250924050415.4aefcb91@batman.local.home/
> > ---
> > Jiri Olsa (9):
> >       ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
> >       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
> >       ftrace: Export some of hash related functions
> >       ftrace: Add update_ftrace_direct_add function
> >       ftrace: Add update_ftrace_direct_del function
> >       ftrace: Add update_ftrace_direct_mod function
> >       bpf: Add trampoline ip hash table
> >       ftrace: Factor ftrace_ops ops_func interface
> >       bpf,x86: Use single ftrace_ops for direct calls
> >
> >  arch/x86/Kconfig        |   1 +
> >  include/linux/bpf.h     |   7 ++-
> >  include/linux/ftrace.h  |  31 +++++++++-
> >  kernel/bpf/trampoline.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
> >  kernel/trace/Kconfig    |   3 +
> >  kernel/trace/ftrace.c   | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  6 files changed, 632 insertions(+), 75 deletions(-)
> >
