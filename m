Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7621EA65
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890892; cv=pass; b=FNUsWkM/eWfoyE/p8BRav/z/qvMmPW36ojv6I5lCz+Fx51k0VrFZvfeabc3q9If/GyuPKDKiIww67LNe8WlsQ0jLn6wjWDX7jHCXSsaO2RpmBZ+jq4jHP/v25dkC4aSwKEZbRZSdkK76PYPhyf+xWSwIKH6WuXv7cgF/K5wKIWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890892; c=relaxed/simple;
	bh=VLShzhsBblPDpTZ6t5c3wV6p/VgGFd7WcCWUNGVk2T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjwWZLSocsQStxq0xiWCLxLrZBKLBBwYH+VtkVHqc9/i9xo39aSsGZSW/gSXqIkdZfSEYGSD04czTL+k771Dmv/v/tALdKB+Ecu7vRFlg+uCuK/ZLWpS8nbKNTgHmeQFGc1HXxNmNvcxypJbZ4fes9Wo3ou7TJ8S3T6DKQyQLqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSxvESd3; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSxvESd3"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43cfd832155so4301832f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 13:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776890888; cv=none;
        d=google.com; s=arc-20240605;
        b=Gddm9vkc6XagEac+ImALVosk0jzsBwEz5ymf5EWlE91fmJ0FFlkLT2yGUbQ+yCBrPt
         0lvteZb336rcwSVcB69o2dBy7XlOCjNhJT1/k1wWbXA/nl91uSe3xRc2lY43kcXm6SU8
         tzaPBCM5pRDo7yI5f/NuDlw1Hs6mr9pZhT011pv9QOQodGBHjRpywMG7KnvDGPipvx1S
         zjZBFj2YGh4TDpJFfz+gBrdKs45iCrZgGrzSzAQ278LQsfCQepygvCY6CGGIeDjYgUF2
         +trjLcVRyGr5NldLZBe0eR53cLFbHDFbQ4v+RJ8PHq4qMnWbaxh69VVgnR4yDopuF4Wo
         xkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NBjbEXlHsKq4HdXitcslhfIes/4x2VOcQoCu/ZxzyBE=;
        fh=1uNWLdpXngJp60bqJOtI34s5d+/7bGwl2M2iDGSoq3Q=;
        b=IugC3jZA5hAJRW233eW5nsteDTRdYI3wtElPeXJwzkfA8jVEk11NP7ripJd+t9HtyY
         W0ETHh4Rh5DTXsuHIrNgWYFi2Yy0dAitzlrHOOoB2gwJeubtO4m+K0r8aNEyVHBPYpzo
         lMZCUkFpYUjAtECF3IN7Ov0yYi0m6J/edGMX0afRAGTiXMrZDT8Xqo5JDRcE1Ip5powN
         gAjyRc8mzNFxg/zTIzjY7bWPIiz5H2FPV1LGv6vKT1+NIbSYy+GVcbxo0+AKN1uEIfFy
         jXc/B/R80RjqxjP9czGcHsTmiUCABnXKrEWzGh1UPruaHECgm0B0wnKH44lV5CYqgWhe
         o8Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776890888; x=1777495688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBjbEXlHsKq4HdXitcslhfIes/4x2VOcQoCu/ZxzyBE=;
        b=KSxvESd3t0OVgl4DfsUUV2zEdWu7h0+e6s8tnepVziMs0n4vsZmoQb6D5S4d5xC8Xh
         8LG7+HYJ6jG3H+3L6gUxdDDZ3koeNxZFM5WlA2JVHMbJnx6cw3vzvkVTYutqZrQ/aspB
         l+ZrEjQmMlhuqVNW1+CTqczJb7pW5AWbbUauXJYeWDmrtBx9NEbSn3HV2fkiQGlPAiZT
         mTE0WEb2NZMkcmtjiNPfzb4HELieeTmGIPd3lF9JqNc/qERaLqmkEwyvWul0a0F6F3n4
         1Lk8mbTtg44H6oIRRhWQjUWbyY8EdGadgV366pmFfT8uDB1CBn8mtn78ZWfxSrFyUfSf
         9Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776890888; x=1777495688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBjbEXlHsKq4HdXitcslhfIes/4x2VOcQoCu/ZxzyBE=;
        b=mXkxo0i2/+XlIya/WU9qVdOO1EObKEM07nGtd/UPdHAjERfPIWdxo8HiRUfHht+ux5
         q2QmZ6xhwZnKEr0JdxieN+JI/8T88KaOqPt7ASSLtFaDeK56qgPS7/+oKU9+FNPDFsga
         mtAUddMxnepmPvdgQARCHQpXFn7b1/GF64N90Fsq2NCwo5jxdU4jyz5QjR18fACEPFX4
         doZzBRF5lahMVU6V31UR9De8+wZVmGWTYU1GFmUIWlXWmcVXCM8rSSxKiSnexlBhtVJZ
         98FGb/d/lYdXG1eoWWGZn8DHbGNViF2dka+hX/r6QtEOZ3hrSGwhk3ty/mBDnxYzrftE
         WZXw==
X-Gm-Message-State: AOJu0YwWU/qQPuy2W3Dy5bp9sZTZJkGQZbQOVCip6+QRq27NSBj6yyN4
	jQEALuq09aCcZOuqRIFbGfqGb7ULUiIsrFYW2BGXjnWFa2fmDW/MTVnVLCI1lw9+Fp8ZaNTnAIb
	u4ErHqg9eo3KRncUyakVBSCtlNTkTpxU=
X-Gm-Gg: AeBDiesBPYrm2YCf/hMECBlFgj12Z5LlN2F1cfHX29SWvbMA75f9QgnWoYvIswGGc1Z
	o2HUlFY+fh34pIFjwVwkvQ0mzx7v/S3psgrXB7UZ5l6Kd+OjBaYlz/GeqtO6IpXjCJDdtnp0qaJ
	Hlr/+mQbpmbvfrZXwYYx4oRDapQK2uni/OxeauvzUKFmx/d8JwBJRUzlt0gjtQKDfQONc9RVJS5
	Wa81qFYRRROJaThIDJvvSDqzZ7XhJ5f9AOOdpIPzA+7MTb+f6RVRfY876fYcwzUEiWUto6E5H+6
	1+b/9wIgnGNgM4P0kSgjC+NBzxoeNIUMztEDI/RPkaSxOJtZipjhoEdluB8CRePYR0gGL+iH4oj
	FULNeOu/q1uCNhnxoR5j5X3+ngASw0UsFrPkDG6LfPzl9g3xYvqoWzELC5z3PZxM7DfU=
X-Received: by 2002:a05:6000:2211:b0:43f:e94f:3da0 with SMTP id
 ffacd0b85a97d-43fe94f3deemr31839207f8f.4.1776890888273; Wed, 22 Apr 2026
 13:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
 <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>
 <aeftTnQjdOgjZyYP@zenbox> <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>
 <aejdhxJ4ev3mxE--@suesslenovo>
In-Reply-To: <aejdhxJ4ev3mxE--@suesslenovo>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 22 Apr 2026 22:47:32 +0200
X-Gm-Features: AQROBzAVFcJlVhtRx9wlmF_Ok0hqFlAd9Xs7VCYsJNPL3o4YD9B4Hn5H929cLi8
Message-ID: <CAP01T77aQF9_HgTokGWW_nr2zVv81ZLnLE1StPeKKSvEvTzrPQ@mail.gmail.com>
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by bpf_task_release_dtor
 from NMI on rcu_nocbs CPU
To: Justin Suess <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 16:39, Justin Suess <utilityemal77@gmail.com> wrote:
>
> On Tue, Apr 21, 2026 at 11:44:42PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 21 Apr 2026 at 23:34, Justin Suess <utilityemal77@gmail.com> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 10:23:56PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Tue, 21 Apr 2026 at 22:10, Justin Suess <utilityemal77@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.
> > > > >
> > > > > It was found after further investigation from a Sashiko report on my patch:
> > > > > https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t
> > > > >
> > > > > The issue is reproducible with a BPF selftest-derived reproducer that:
> > > > >
> > > > > 1. Stores exited task references in a BPF hash map as refcounted task kptrs.
> > > > > 2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
> > > > > 3. Runs on an `rcu_nocbs` CPU.
> > > > >
> > > > > In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:
> > > > >
> > > > > `perf_sched_delayed`
> > > > > `  -> static_key_disable()`
> > > > > `  -> arch_jump_label_transform_apply()`
> > > > > `  -> smp_text_poke_batch_finish()`
> > > > > `  -> on_each_cpu_cond_mask()`
> > > > > `  -> smp_call_function_many_cond()`
> > > > >
> > > > > The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.
> > > > >
> > > > > Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:
> > > > >
> > > > > `bpf_map_delete_elem()`
> > > > > `  -> htab_map_delete_elem()`
> > > > > `  -> free_htab_elem()`
> > > > > `  -> bpf_obj_free_fields()`
> > > > > `  -> bpf_task_release_dtor()`
> > > > > `  -> put_task_struct_rcu_user()`
> > > > > `  -> call_rcu()`
> > > > >
> > > > > This is triggered from:
> > > > >
> > > > > `tp_btf/nmi_handler`
> > > > > `  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)
> > > > >
> > > > > Environment
> > > > >
> > > > > - x86_64 QEMU VM
> > > > > - PREEMPT(full)
> > > > > - `CONFIG_RCU_EXPERT=y`
> > > > > - `CONFIG_RCU_NOCB_CPU=y`
> > > > > - booted with `rcu_nocbs=1-7`
> > > > >
> > > > > [...]
> > > >
> > > > Makes sense. I think the reasonable path is to just close usage in the
> > > > NMI context, otherwise we must address each case. Could you try the
> > > > attached diff and let me know if it successfully rejects kptr usage
> > > > here? Thanks.
> > > Didn't work for me.
> > >
> > > is_tracing_prog_type, despite the name, does not return true
> > > for BPF_PROG_TYPE_TRACING. Only BPF_PROG_TYPE_TRACEPOINT.
> > >
> >
> > We can add it but return false when expected_attach_type ==
> > BPF_TRACE_ITER. For all other cases, allowing it doesn't make sense
> > because these might potentially run in NMI context.
> >
> > Please let me know if you'd like to send a fix + tests, otherwise I
> > can follow up. Feel free to fold in the diff I sent into your fix, no
> > attributation needed.
> >
> > > I'm honestly still not sure what the difference is, but they are
> > > different [1]
> > >
> > > Would you rather do this or just reject the dtors with a
> > > kfunc filter for this program type?
> > >
> > > Or teach the verifier that the kptr ops need to be offloaded with
> > > bpf_task_work_schedule_resume_impl?
> > >
> > > [1]: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_TRACING/
>
> Sorry for the double tap but the change you're requesting for the fix
> will cause breakage.
>
> This will at a minimum break test_bpf_ma and percpu_alloc_array tests.
>
> More importantly, this will break existing progs that use kptrs in
> tracepoints.
>
> Would a narrower fix that filters the dtor kfuncs specifically be a
> better option? Or better fix the kfuncs that use irq_work? I think
> the real fix is to make bpf smarter about when it's running under
> nmi, but that may be non-trivial.
>
> If the breakage is acceptable, should I just remove those tests?
>

I think let's be conservative and let it be for now, given this issue
was found by the bot, and not yet reported in practice.
I think breakage would definitely be problematic; tracing programs may
also run from non-NMI context, just blanket ban may not work in
practice.
We can think through the proper solution (deferral the operation in
NMI context) later on, when it comes up again.

Please just resend your file kptr series as is.

> Justin
