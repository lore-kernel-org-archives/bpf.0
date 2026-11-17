Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914126;
	b=fUmbOPq/a1sLOXxuGqm70dXpXZPh0tuMGR13P2btyvw5vcj9fvoCu8avslNVZmZl1ykN
	 dXvJGegiYCncZJjmxK1M+5EPjfIa2kJFBLtDG0e2Hp0NSsKumS1oihGB1ubYMdUAZmtle
	 +ryRMAU3ptN/LHX0CIxCuusz5NPAolyXQHaganNcpRlvhHynwpISsjJuhahHwy7QFoffy
	 WXyymhoIfv6A5AHkHk8RBGMuxby6caH7cQoCB05Kih+b7kDSwYQB4Zo4swNhXZrM5Q8MY
	 zdYK3YR32fb7Rur8xa6d0W3ZDyrRSvxHent9p70LaVIbp8UgqipV4xYyiphCz0jehyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=wkAifCWBa4yQo783yHdWz6gkU6PjHxfZYINEMlx6l2I=;
	b=SwQ0+odccYLkyweJiXn2/o6phu4uP+qILYvTQU+9rK0TCz5n56JuzrB+renReEJUCdEG
	 07gj67M/Tznv5y59/EpO12HG3MKBiWdq3KV31U19TRxniaYwb64ejrizMGTn4uBJJx747
	 XmmQEbxqINl00XhNQz7kZet9yjozANSCnxGnkyuGa5cgqby2uQ9gyDciDMsW4uhuvVI1a
	 jkdTkvQvyLhsnBlA7cVLa6SlSrtn/uHfrtohtKX2KxoohRAnFfvTUZXtsHFc9byzrAuXJ
	 C/OX+fenYDS7jWP7x+P4jxOVpu0wW3KhHykHEoYn5dCB33unCq7Qgmr9hDL6zMO+zDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAsa1mSL;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589C606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0589C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAsa1mSL
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so4572435b3a.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794914124; x=1795518924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkAifCWBa4yQo783yHdWz6gkU6PjHxfZYINEMlx6l2I=;
        b=jAsa1mSLjGhaQKr9R+v1TdaF5G7FQ5tiLTswTXbU70ClHv1TqF3rk7onGlBsNll9U7
         WZUqDqbYrFzY0D9gaf/Frrkaxj0gCCFJ4ZoULceD45JbWXY9Q3zukXgV+pJrNeRI8oum
         mOmLZTEvuJ0fHvSR59qS0pTGlQ4E6iRt1fQ7Pn5MOGAiGmVQBIvjWMC+BcJnQVittNyP
         DVmAkwFUnQ7fG8vE9797XMEyj84KacsBbaOnxvLpiEB0Bb8ZxfkK5gRXRqGAD6ce90V6
         VAJYWmromzDZPT2kdH3VJphA6WpyopItIM93zrB4YXIIfGDtTti+ZtnMEr1XuBHtF8Nv
         o0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914124; x=1795518924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkAifCWBa4yQo783yHdWz6gkU6PjHxfZYINEMlx6l2I=;
        b=1vB4EOrqt9YHebTk4Z/qH9mLbhWIwQKBcqDufyihsRdu4BeK1O33/59mLGGC5EFzQb
         5RxVdTEmIrYl3uFoL4eIJv9J9QJq/8QtQb8cg1zLoQcSiLXrKF9UstpGgLhAId59MtJd
         XW+5BQWoemPtIlE9jyjzqv61Heu9pi7JJbOYRFZXOQFf5TbjG/757MN4sLtY5xjFVDJc
         sZOGUMKcAGLBX3Roinha3v/P+sYzwI8e6jbTVo6vqlkSPVrdF4wxv0cZzK85aggqiBBz
         Couwi85ZcbM/+waXzfQaHnTYcsVJ51CB8esoijxoQKecCibFJu89aHGIbbfzJHaFyK/C
         ihjA==
X-Forwarded-Encrypted: i=1; AL+hErGvB6VtwJiOTqD0dc0HDFZKXVXMajuk6NRS9+6D2oMvHrEaJP2tbjUvaL3g6U9KT6WowXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ddH1Qklcp1gRshbkAZGigsw7XOjuqPh49s8AbFHdSlP+/QiS5
	jeTD5aUtqC/qxMk4mxkghEe9Xxnn2/IqzVTYk0NJMBFoyWz9TXy7sha1
X-Gm-Gg: AYBFou1XS+jTXj0+c1qKsNeO63sK+vUqX33fzaxz7yv2LJ2U5Tkb630n67Sb40gSAUx
	XSlRnM6Q/bXmPihU0x6dfDJDiAaCMYfX8wW0go1aXfYfx/wBOg26rcO8iaLU51OIwSkrn4Ualf6
	LZu5kUAkQsGbePtjy1qydMGq22WQOTmS61novVS03iohMDMaxHC/aKvg6twwCHbnevcFLKWvUkL
	CQ3jfyp3Vi946sS1IYCWyPtXJwc+oylNjYdQjrQeovQ6+AwEnZlwpb8Bzl+tmYnYaoZMOpBD2Uw
	fHLW74PcTvFBPynJG2cDjSwt11OW3el0/HXfCOjkqH/9giX6S+GWj36DThRzhpog7PMHfDuR65s
	o91gy4rLo1+SFpVtVf8XDxJrLGXgKC/nNB3EwynVyJNOPbfTSMuT5RM9lP5OncvjnYU/4lyv07i
	Fi/KaJpK2XGlLCc9qOpAC++DECBxlmHKB8m5sScq8xOwXQXqRBTMNeweTQxeOFO9ABqqUzIdtJO
	MmOlf/WM7tCnaEwHG00ihYh7qTgYVeuKLqKJYByxLgCYj3ZKAffRv40TJr4PgxG+82KfoXQ2wPx
	5ayUxcG1MUdyjC/crFQyC2W0GSyZeFQzXHGwTKbm9qOcePM2HcbZklFnpkYlW2UO
X-Received: by 2002:a05:6a21:180a:b0:3eb:b103:6eb1 with SMTP id adf61e73a8af0-3f7a83b9fdemr13383267637.44.1794914124417;
        Tue, 17 Nov 2026 03:15:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2039:4:4074:47bf:1530:a459])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde0f3f4c7bsm1237164a12.22.2026.11.17.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:15:23 -0800 (PST)
Date: Tue, 17 Nov 2026 19:15:16 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, geert@linux-m68k.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, gerg@linux-m68k.org, skhan@linuxfoundation.org,
	rdunlap@infradead.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, marscheng@google.com, eleanor15x@gmail.com,
	jserv@ccns.ncku.edu.tw, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org, daniel@thingy.jp, martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH v10] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <avw3REBe9uzZG2HQ@google.com>
References: <20261117095110.2736779-1-visitorckw@gmail.com>
 <146c493fb3b8d5f5171ad146cdc23e4f2693e1e142ad11ca67db5eae60cd4abb@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146c493fb3b8d5f5171ad146cdc23e4f2693e1e142ad11ca67db5eae60cd4abb@mail.kernel.org>

On Tue, Nov 17, 2026 at 10:36:39AM +0000, bot+bpf-ci@kernel.org wrote:
> > m68k, bpf: Add initial BPF JIT compiler support
> 
> TL;DR: bpf_int_jit_compile() has no check for an already-JITed prog, so
> jit_subprogs()'s second pass may leak the first executable image, e.g. with an
> exception_callback tag, letting a CAP_BPF user exhaust JIT memory.
> 
> > diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> > --- /dev/null
> > +++ b/arch/m68k/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
> > +{
> > +	struct bpf_binary_header *header;
> > +	struct jit_ctx ctx;
> > +	unsigned int image_size;
> > +	u8 *image_ptr;
> > +
> > +	if (!prog->jit_requested)
> > +		return prog;
> > +
> 
> [ ... ]
> 
> > +	header = bpf_jit_binary_alloc(image_size, &image_ptr, 2, jit_fill_hole);
> > +	if (!header)
> > +		goto out_off;
> 
> [ ... ]
> 
> > +	prog->bpf_func = (void *)ctx.target;
> > +	prog->jited = 1;
> > +	prog->jited_len = image_size;
> > +	goto out_off;
> 
> If jit_subprogs() calls bpf_int_jit_compile() a second time on a func[i]
> that is already JITed, doesn't this allocate a new header and overwrite
> prog->bpf_func, leaving the first image unfreed?
> 
> jit_subprogs() in kernel/bpf/fixups.c calls bpf_int_jit_compile() twice
> for every subprog, once in the first loop and again in the extra pass:
> 
>     old_bpf_func = func[i]->bpf_func;
>     tmp = bpf_int_jit_compile(env, func[i]);
>     if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
>         verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
>         err = -ENOTSUPP;
>         goto out_free;
>     }
> 
> On the second call only prog->jit_requested is checked, which is still
> set, so both passes run again.  bpf_jit_binary_alloc() returns a new
> header and prog->bpf_func is overwritten.  The out_free path then calls
> bpf_jit_free(func[i]), which frees only the header that
> bpf_jit_binary_hdr(func[i]) finds, i.e. the new one.  The first image
> and its bpf_jit_charge_modmem() charge are never released.
> 
> Rejecting BPF_PSEUDO_CALL in emit_call() and BPF_PSEUDO_FUNC in
> build_insn() doesn't cover every path to the extra pass.  A program whose
> main function has an "exception_callback:" BTF decl tag gets a second
> subprog via bpf_find_exception_callback_insn_off() -> add_subprog() in
> kernel/bpf/verifier.c.  The main program doesn't need to call that
> subprog or use bpf_throw().  Both functions JIT successfully in the first
> loop since they contain no calls, and the extra pass then leaks func[0]'s
> first image on every load.  A CAP_BPF user (needed for BTF) loading such
> programs repeatedly could leak executable memory without bound and keep
> growing bpf_jit_current.
> 
> The JITs that support bpf-to-bpf calls (x86, arm64, riscv, powerpc,
> loongarch, parisc, arc) detect the extra pass via prog->jited or jit_data
> and reuse the image.  Would an early return when prog->jited is already
> set work here?  jit_subprogs() would then see the same bpf_func and
> finish, and that seems safe because any real call or callback has already
> made the first pass fail.

Since this initial JIT doesn't support subprogs anyway, I'll just
reject prog->is_func upfront in bpf_int_jit_compile() in v11.

Regards,
Kuan-Wei
