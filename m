Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B831F99A
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296506; cv=none; b=BJSgl5vTti30dFX2N+T+kzn/Oj3B+hPMyadUNHLSMbPKj5pIVW//qc3CXkmoGqfYnbPjC+Xz6SwEWR69CPHH8s6fRvW6J2emd6fN+VhF9nBGE4TR8rQ0f/hfnRdcHhyDDxQYkEiMQjqg2eopDYm/Hx1NAEzHzBf8dvw1ylpR6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296506; c=relaxed/simple;
	bh=+u+CFwSmjV3AfK62n9ArlsuoMlGY89N7Q9UqsP9awUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5LjN6lAXlpf9av2LVt2NQYipGEI6vbmtEAFtqXWxxqM3TmOxTpU57n1Hxl9jg9RIcA0l/MkU11qRkoszzgkwc8UMrSTMKX9hW7j+qdzf95/XdFKa/Z6E5W8JSTHhvJYmNxUxUI8S4tTyTj6nKUyfnZJClubfnD2Q0IHJN89WI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZ1hlY7i; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZ1hlY7i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773296502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuKKwasLprSWBy32WqLV5hwLjaw3K00o0uOV/1NKmNA=;
	b=OZ1hlY7inJf/uBftc0QKP/KWyJYVXBseEnxqARIhichcoajHPGOOxN4HFlGbwRRIAKCrNy
	Jq9nEyfra/ZwkgszXQ3XwSBtuNHbLapyAkCADILdoUcij/OI8qXdCOmFRsYZba8XHZQZUb
	o50kSqhs6Yhu2VyJ8MxPpd4aof7KKVQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>, Leon Hwang <leon.hwang@linux.dev>
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
Date: Thu, 12 Mar 2026 14:21:29 +0800
Message-ID: <6246261.lOV4Wx5bFT@7940hx>
In-Reply-To: <46583200-ee0e-41dd-a0a9-8944ad710a9a@linux.dev>
References:
 <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
 <CAP01T77gknuNiiVKny-cThb6b-dFxGPmPKx1eMryLoN2AkHo8w@mail.gmail.com>
 <46583200-ee0e-41dd-a0a9-8944ad710a9a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/12 13:50 Leon Hwang <leon.hwang@linux.dev> write:
> On 12/3/26 07:07, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 11 Mar 2026 at 19:53, <bot+bpf-ci@kernel.org> wrote:
> >>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>
> >> [ ... ]
> >>
> >>> @@ -25435,6 +25441,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
> >>>               case BPF_MODIFY_RETURN:
> >>>               case BPF_TRACE_ITER:
> >>>               case BPF_TRACE_FSESSION:
> >>> +             case BPF_TRACE_RAW_TP:
> >>>                       return true;
> >>>               default:
> >>>                       return false;
> >>> @@ -25464,7 +25471,7 @@ struct bpf_attach_target_info tgt_info = {};
> >>>       }
> >>>
> >>>       if (prog->sleepable && !can_be_sleepable(prog)) {
> >>> -             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> >>> +             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
> >>
> >> The updated error message adds raw_tp but still omits fsession,
> >> which is listed in can_be_sleepable() just above. Should this
> >> read "fentry/fexit/fmod_ret/fsession, lsm, iter, uprobe,
> >> struct_ops, and raw_tp"?
> >>
> > 
> > We can ignore AI for now, Leon has a change for this.
> > 
> Just to confirm the change: is it
> https://lore.kernel.org/bpf/20260303150639.85007-2-leon.hwang@linux.dev/?
> 
> If yes, it is to add "fsession" to the verbose log message in
> check_get_func_ip(). Then, the AI review is correct: "fsession" was
> missing here.
> 
> After searching for "fexit" in verifier.c, "FENTRY/FEXIT" can be updated
> to "FENTRY/FEXIT/FSESSION" in bpf_check_attach_target(), and "fsession"
> is missing in some comments. I'm not sure whether it is worth a patch to
> do such cleanup work.

Ah, when I search the "fentry.*fexit", I found that there do have
some missed things in:
- the comments
- the log message in check_get_func_ip() and check_attach_btf_id()
- the document in bpftool-prog.rst
- the help info in bpftool
- bash-completion of bpftool

I can send a series to fix these things, except the log message in
check_get_func_ip(), which is already in Leon's patch.

Thanks!
Menglong Dong

> 
> cc Menglong
> 
> Thanks,
> Leon
> 
> 
> 




