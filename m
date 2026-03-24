Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339633CF03B
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362588; cv=none; b=AkkKqzAohSUfTm5JHT+eDpvdYN08sgfy2aVCyx77+E8BoXro3SSGnxkxdi0KFj6SFBePUuhgc7KnNMLolclg5jn9XKa5hABc5tWDn6Nc7Urjca13qqQIurnZnyJbb2oBaYDBRzhJX3jzW7MOfOibII/DC+FSfDgWkwrv0rybHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362588; c=relaxed/simple;
	bh=M97mpQnDV66jGT+RZ5/PvVHHnBb3fripn9Zj/IeFKBc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlokIRdPIGJoLshAjhox3kxtTGI5P7LGWfwu8+93uIDaF4gbNAH05X0TO9Qxa4kC+LQ1AuLNgbtrQPjbRmCaoufci1QXIvRGoeVlEgN/ImiaM4SD3kAL+d5Ok8uy749GNC9v2ehiiJLGUhT4ppMpzDwGKT/DUepsksVBuOe2jgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB+qpfm/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB+qpfm/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso10399115e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774362584; x=1774967384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku5SW27ATyQZZacq12btZ+N4SJ7ImnrT4i+1ZhasesE=;
        b=FB+qpfm/cOIbU4KpO1hnV3FFx45NopJwxudqt4xxAv0UulcsD1mCw9siRbDRCR3x4W
         GgQmsEChxp1/3UOpjSr6l+Hj2MaBVeCa0Z1PLSWtWyolR2rnNyWHZXyq4YWbyBfu54Es
         O8TMkIZELXWM0vP32/O3yjZDzqgrWn4PDMcfRVOJIyG4kEnhwGfxKhAzYZX+S1JIhFcX
         F/46V9LXGgNiZuW2M7aq03xHT2xN7Nemrbo+ixT9X/47W2ykEedukVe7hAa0a2OLPrGW
         WF3K55FI1mdgdn467wdUD6rzIEeX7ODYxrfzznxjzxC48eoincLN//JeMtHOPCzkk8r1
         iaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362584; x=1774967384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku5SW27ATyQZZacq12btZ+N4SJ7ImnrT4i+1ZhasesE=;
        b=Lh256MMgiYIC1zU5Qub2gs9Zv2gVzL216vpk4qpifZaoepx8RJYuqzzhw8tpv2fjzn
         6Z2X1txfr3HHvs45N+5CEK047GXDm/Ufiu6prs8fREMk6X2OSWmxQzz9EEceafx8LaFh
         Cpqe16VJcKP4zPTsKDbGoHtIQd8ryrJgM2hX2YghOF3ixEt4Qk2NthcUeOAU7ZD19BA1
         youRPyPZpz4mTlB4J0y5NVW515dzOBiTtiUuJ22KsOXqMEaWHwUVFhuRLEBNEN9ZDC9F
         YwD5K+OiSdOdbM4qRS5X8LfQDteMOVhKR3Bx2FAjXD+aYgtvVyoszPuboYEMG9EezkJv
         VNBA==
X-Forwarded-Encrypted: i=1; AJvYcCWsgCbS5t8Apg7KvevzWCuFr4AW7XhIry+cGfELhOgRGWxmICPspFXBij2QZG5Sr6BoRts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnZ1vy7O9G2gcq8rADcHsrnB7jdb/zeN1iYGXQSVULnGYFsD9
	tIHl4KMe0XVlAbkXq8cs+vMgsnoxxEo7Bu6doVvIdGr7TvCfMZ38ZnbT
X-Gm-Gg: ATEYQzwovMGe+R/65ljxyQZ+6sV9l34Omlr7PvsPyUBNZJ0bgcxXfuPK5UH6W6S7Vxh
	M89fbzm+0N0MrBCmQnhJHP/want5MjbGpQvVlp1hZOPCuT8H8GQehzAM/ZlNygJKiEYB/XiFunK
	EZG6+88C8KskZeHf3No3uLCqIM12G9wufMkjpmbE5XhGHZkH55It2SnDDmZQNu+kG5mPcON8d+A
	sumndHj2B6SvgrFuAaiCmv4qJ/IZaySr1KRAN+6kWq1ZgbbCDuriITaXL59O3imBeK6WRuo3ZdJ
	ypuGUt5DrcB/Yz46E4RCSbeX9omhWmezwRf3q36GIUc01XpuGfbaJK+gJurSIq3V0gTlo0bX81x
	pTPIKPqPuuJhc38YzmwDbkKcBbqCAIp9SpH+qzybO5jWwKztZlQtXypntuFC0Y1bhZJ1unHQhfi
	jnS4wWtiZVX2I=
X-Received: by 2002:a05:600c:6287:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48715fd545bmr78785e9.10.1774362584260;
        Tue, 24 Mar 2026 07:29:44 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871169384dsm59025945e9.1.2026.03.24.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:29:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Mar 2026 15:29:41 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 bpf-next 09/25] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <acKf1RMe7YMmxKzb@krava>
References: <20260324081846.2334094-10-jolsa@kernel.org>
 <711e8b90d27722e47cccfc30a1ccfe243ea7a696322997c15fda1a2147dba6a4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711e8b90d27722e47cccfc30a1ccfe243ea7a696322997c15fda1a2147dba6a4@mail.kernel.org>

On Tue, Mar 24, 2026 at 08:58:41AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index a9e328c0a1b3..2986e5cac743 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> > +{
> > +	struct bpf_tracing_multi_node *mnode;
> > +	struct fentry_multi_data data = {};
> > +	int i, cnt = link->nodes_cnt;
> > +
> > +	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +
> > +	if (!data.unreg || !data.modify) {
> > +		free_fentry_multi_data(&data);
> > +		return -ENOMEM;
> > +	}
> 
> If alloc_ftrace_hash() fails here under memory pressure, the function
> returns -ENOMEM without detaching any trampolines or releasing their
> refcounts.
> 
> The caller in the next patch (bpf_tracing_multi_link_release) does:
> 
>     WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> 
> This drops the error on the floor. The link struct is then freed by
> bpf_tracing_multi_link_dealloc(), but the trampolines remain attached
> with elevated refcounts, permanently leaking them and their ftrace
> hooks.
> 
> Would it make sense to pre-allocate these hashes during
> bpf_trampoline_multi_attach() and store them in the link struct so
> that the detach path cannot fail?

it's not just hash objects but we will need allocate also entries,
I can do follow up with this if others think it's needed

> 
> > +
> > +	trampoline_lock_all();
> 
> [ ... ]
> 
> > +rollback_unlink:
> > +	/*
> > +	 * We can end up in here from 3 points from above code:
> > +	 *
> > +	 * - __bpf_trampoline_link_prog or update_ftrace_direct_add failed and
> > +	 *   we have some portion of linked trampolines without ftrace update
> > +	 *
> > +	 * - update_ftrace_direct_mod failed and we have all trampolines linked
> > +	 *   plus we already un-attached all new trampolines
> > +	 *
> > +	 * In both cases we need to unlink all trampolines from the new program
> > +	 * and update modified (data.modify) sites, because those have previously
> > +	 * some programs attached and the new trampoline needs to get attached.
> > +	 */
> 
> This isn't a bug, but the comment says "3 points" and then describes
> two scenarios in two bullet points. Maybe say "2 scenarios" or split
> the first bullet into two to match?

first two points are covered in the first bullets, I think it's ok

jirka

> 
> > +	ftrace_hash_clear(data.modify);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23480161822

