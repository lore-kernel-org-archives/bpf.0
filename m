Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08239F165
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761792; cv=none; b=dtr9l0Fb8CKz2cEW6W8hpab2MgpLbjhCTEi9M/x+uX2tLm7oiDVD5R5slgMDbw+L7rCf6z9+sAar9C1ykeLtnrxs2nTD2WmMFZGI2Ck6/teyyQNKSHSQvvbk8OWMOtjMVb61yXObX0pYKqj5fmKwTI9JamhlBSWTlHGrivjvpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761792; c=relaxed/simple;
	bh=pExkivel/ZaBEO4bHizI9P4PRlz1p0RCx/iUpmCfBQU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hROKM/AOBl5eR5rFAYpPas1eGTq53wXGuNxmh8AQpg7G/QAuqXuez82dR/fVfx7rNOpE+AR6kOX9CmsQUeVdmvdRZTymFDEDkT4Xl7qoz1r8s4r4mtqfQS9w1VWQrtWfcws/t/Rugx0u18AoYM/t/LC3XMIv74tC+07HhOqX/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFacM8fK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFacM8fK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39676545e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761789; x=1777366589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J59zA3Quq6FhJKIoZt1fzmbvr8cEcfVCYBolSfyAqDU=;
        b=UFacM8fKQci5alYzoHBecDDcoB9/flVKsE37Ox37DeQKhNtvfIiVvhlyTn4nxdBCMA
         +4YLxsWzYotlHFuNxtP9y3ZpQOMkvXxApC2BAcnLHZ438iN5hUQloL3lEwj77xV2IuNy
         hEuRAqwBgqUwtGy396NUL93LDb5spUe5GJIghgc3AL6AzFF1TR+Gep6vDpCnydjO7VsJ
         aJzD+GrPh/U/GsO/InTNtGgNDXRNVeZgWvZoJPuG5bTLpfavzXWBKUdMsQnsymUF5XeJ
         1AG4vXtfZH/qTrQqAIQEi9NUixrpt/TEivuD0RKzVl0ZuR3aNDazOQtLxQFKFenii1w3
         Nc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761789; x=1777366589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J59zA3Quq6FhJKIoZt1fzmbvr8cEcfVCYBolSfyAqDU=;
        b=sGjGQ5LKO7FZlAoncpPGTB9B7VsP47vPR482fe3dCegEI95OUzmyOzeLffAYTNfWAF
         h20Pmb4sHwEsifDKedHCkmAuJuvUJJQmpt67FX0Dbxszg/qNBlyh2Oeu1synuyp1BznD
         apucI3+QBJ9B6RJXUrr8tOB2+FG7j1HFXTF5qxp7ZCuH6wVJIIoOOye5N7uw3DtnI4rT
         J25JQyAPa+LGrcljX3OpaJC/wX9NUU+eg2GdxrfwiNvLiLjmHLQ7BbIkPSgcGnf8243o
         Q0fLDQsOfsYzkfcpL+zujJLiV7Aqzdee7y76/eJrchS33fP97DJK0rCYy4K2zlfHfViU
         dNvg==
X-Forwarded-Encrypted: i=1; AFNElJ9z0+apV6kbuudyUjVB2Dzl/Tvjvo74o3dHHOML6h2baAt5e/cY4tAqZTqtyYfVdeI693Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNIx/leph3Btva+9PxxGRBOjNtfdhYivO0Lvmy1zlSxI25mao
	+tb8lEXm33CNwXueodT3JzfsD+m+SEDe1kaX5SA3soCMSst/WnDYsf7h
X-Gm-Gg: AeBDiev1kL+SrDuJ0UXDGFlX15zpfNBfPvKp+O2eDGfV+ETY+faoI5YW2JGIlpXStS0
	VTif4dhlLmPuW/TqjkgokM7op+nLebr7OTIaIMLxRuXixPFX1iEft7Du0iXRifKi94xQ6bMYlRO
	Lpyt/B0zBb2GOM6lhyLpmcPna7sQCs3AMq1ZdpnmVHrl2524hM/533ZZvj0vBJ2HnejXj2W1Tmt
	iRimpUDEVXtwbSJZzYJBwKojqDE9/UC2641izfUzXuSJPZ7XEwvAKSsu41LmyoRQUEcYh/dBrKp
	kMyZ4p6p8ZrHTxpc54eMUn8IJay4XUe011O3+aih9U3vs3qzvyS/lU7s+itYtrgwVpauDmv8iaV
	PceYLDn9m4wNy6esK5RxqeKXePvLFfRKOjzX7ut2VdBXnJSR20GuZPYlxosXISOMTSE+wWWx3PC
	yMgLttaXbBjaYn3BpkYg==
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr119653775e9.6.1776761789230;
        Tue, 21 Apr 2026 01:56:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm229563515e9.2.2026.04.21.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:26 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 12/28] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <aec7utuKyC1YtpYv@krava>
References: <20260417192502.194548-13-jolsa@kernel.org>
 <0fefc9ca058787dddef9c125163a0182c6ddd1f47d2754f2ddbb5a82bfc9126a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fefc9ca058787dddef9c125163a0182c6ddd1f47d2754f2ddbb5a82bfc9126a@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:10:57AM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> > +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> > +						 &trampoline_multi_ops, data);
> > +		if (err) {
> > +			rollback_cnt = i;
> > +			goto rollback_unlink;
> > +		}
> > +	}
> 
> When user-provided ids[] contains duplicate BTF IDs (or distinct IDs
> that resolve to the same trampoline key), multiple nodes point to the
> same struct bpf_trampoline. The link loop above then calls
> bpf_trampoline_multi_attach_init() more than once on that trampoline,
> overwriting the saved old_image with the newly assigned cur_image from
> the previous iteration.
> 
> Scenario with ids[0] == ids[1] and trampoline X starting with OLD_X:
> 
>   i=0: attach_init(X) saves old_image=OLD_X
>        __bpf_trampoline_link_prog() -> modify_fentry_multi() sets
>        X->cur_image=NEW_X (OLD_X refcount not dropped, intent is for
>        multi_attach_free() to release it later).
> 
>   i=1: attach_init(X) re-runs on the same trampoline and overwrites
>        old_image=NEW_X (the only saved reference to OLD_X is lost).
>        __bpf_trampoline_link_prog() returns -EBUSY (duplicate prog).
>        rollback_cnt=i=1; goto rollback_unlink.
> 
>   rollback_unlink calls bpf_trampoline_multi_attach_rollback(X) once:
> 
>     static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
>     {
>         if (tr->cur_image)
>             bpf_tramp_image_put(tr->cur_image);    /* puts NEW_X */
>         tr->cur_image = tr->multi_attach.old_image;  /* = NEW_X (stale!) */
>         ...
>     }
> 
> Result: OLD_X leaks (its refcount is never decremented). cur_image
> points at NEW_X which was just released via bpf_tramp_image_put().
> 
> The rollback_put loop calls bpf_trampoline_put() which frees the
> trampoline (prog was removed, progs_hlist is empty), so the dangling
> NEW_X pointer is cleaned up. However OLD_X remains allocated via
> module_alloc forever.
> 
> Reachability: commit dbf2afe2f603 ("bpf: Add support for tracing multi
> link") copies ids[] from userspace without deduplication. The series'
> selftests (commit 411fb40d4b2a "selftests/bpf: Add tracing multi attach
> fails test", 'fail#7 (kernel) attach with duplicate id') exercise this
> path explicitly, expecting -EBUSY.
> 
> The trigger requires the shared trampoline to already have cur_image !=
> NULL when the first iteration runs (i.e., another program attached to
> the same function), so modify_fentry_multi() is used and there is a
> real OLD_X to leak. The first-time-attach case (register_fentry_multi,
> OLD_X=NULL) only leaves cur_image dangling briefly until the trampoline
> is freed.
> 
> Can the code save old_image/old_flags once per trampoline instead of
> once per node, or store them per-mnode to avoid overwriting the saved
> state?

I think it's better to ensure the btf ids array does not contain
duplicate entries.. wil check

> 
> > +
> > +	rollback_cnt = link->nodes_cnt;
> > +	if (ftrace_hash_count(data->reg)) {
> > +		err = update_ftrace_direct_add(&direct_ops, data->reg);
> > +		if (err)
> > +			goto rollback_unlink;
> > +	}
> > +
> > +	if (ftrace_hash_count(data->modify)) {
> > +		err = update_ftrace_direct_mod(&direct_ops, data->modify, true);
> > +		if (err) {
> > +			WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
> > +			                                                       ^^^^^^^^^^
> > +			goto rollback_unlink;
> > +		}
> > +	}
> 
> The recovery path unconditionally calls update_ftrace_direct_del with
> data->reg, but update_ftrace_direct_add is only invoked when data->reg
> is non-empty:
> 
>     if (ftrace_hash_count(data->reg)) {
>         err = update_ftrace_direct_add(&direct_ops, data->reg);
>         ...
>     }
> 
> When update_ftrace_direct_mod fails and all trampolines already had
> cur_image != NULL (so nothing was added to data->reg),
> update_ftrace_direct_del is called with an empty hash.
> update_ftrace_direct_del at kernel/trace/ftrace.c:6511 checks:
> 
>     if (!hash_count(hash))
>         return -EINVAL;
> 
> so it returns -EINVAL and the WARN_ON_ONCE fires spuriously. Should
> this guard match the add path?
> 
>     if (ftrace_hash_count(data->reg))
>         WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));

yes, replied in the other email

SNIP

> > +int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
> > +				  struct bpf_attach_target_info *tgt_info)
> > +{
> > +	const struct btf_type *t;
> > +	unsigned long addr;
> > +	const char *tname;
> > +	int err;
> > +
> > +	if (!btf_id || !btf)
> > +		return -EINVAL;
> > +
> > +	/* Check noreturn attachment. */
> > +	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
> > +	     btf_id_set_contains(&noreturn_deny, btf_id))
> > +		return -EINVAL;
> 
> Operator precedence issue in the noreturn check. The two subexpressions
> are joined by ||, so the function returns -EINVAL whenever EITHER:
> 
>   (a) the program's expected_attach_type is BPF_TRACE_FEXIT_MULTI
>       (regardless of whether btf_id targets a noreturn function), OR
> 
>   (b) the btf_id is in the noreturn_deny set (regardless of program
>       attach type, rejecting FENTRY_MULTI attachments to noreturn
>       functions as well).
> 
> The intent is to reject only FEXIT-like multi attachments to noreturn
> functions. The non-multi path in check_attach_btf_id() correctly uses
> &&:
> 
>     } else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
>                prog->expected_attach_type == BPF_TRACE_FSESSION ||
>                prog->expected_attach_type == BPF_MODIFY_RETURN) &&
>                btf_id_set_contains(&noreturn_deny, btf_id)) {
>         ...
>         return -EINVAL;
>     }
> 
> Consequences once bpf_trampoline_multi_attach() is wired up from
> user-space (commit dbf2afe2f603 "bpf: Add support for tracing multi
> link"):
> 
>   1. Every BPF_TRACE_FEXIT_MULTI program attach request is rejected
>      with -EINVAL, even when the target function returns normally. This
>      disables BPF_TRACE_FEXIT_MULTI entirely.
> 
>   2. Any tracing_multi program (including BPF_TRACE_FENTRY_MULTI) is
>      rejected when its btf_id is in noreturn_deny (do_exit,
>      __x64_sys_exit, make_task_dead, etc.). Rejecting FENTRY_MULTI on
>      noreturn functions is an unintended behavioral restriction.
> 
> Forward search in the git range shows commit bfcad202ce99 ("bpf: Add
> support for tracing_multi link session") rewrites this hunk to:
> 
>     if ((prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
>          prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
>          btf_id_set_contains(&noreturn_deny, btf_id))
>         return -EINVAL;
> 
> The parenthesization + && in the later commit confirms this is a
> precedence bug. Should this use && instead?

yes, replied in the other email

jirka
