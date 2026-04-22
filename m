Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16D3101B0
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868747; cv=none; b=rbd1hdxCA0IxvmpfSzJizC2hBmKF211ue3t6JmrBlVjBQKlF5u2Lwln3JN/dbmgYV1ounzrWQ+x3TStuMhWvOIZah4CwgB5S13oyabnYN3pql0sWSz634Xd8nxSgeIG+8DfEj56vIl6Al0RhFdhULeiCRNn3zxwbDFSJwv/4WOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868747; c=relaxed/simple;
	bh=pSdK9Obxt/VQgMmB7T2dNPeDq2FFcsQzh35oHlhLGM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okNIn/DA4z+LFZIwcOyDPAeqTBfBPmmX3Lo6QIxTUhOeRZlh2Ok/CNmZYOSvOkoXZOEDZljsuUbrk8oxNYBI4GPLw6yhPoX5grGLapi0BNiDR2BEwU3pWOIDjnAsghBRm/vpm/FtCYskqdFEApdlcs9jAUMn5X9yAD4mRK4B33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THtEQRtL; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THtEQRtL"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651cfaa21e6so5249223d50.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868745; x=1777473545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lN2+ZAka5Ml1kEv2XiWcetURKfDSQtDSZ+W/WbZpIbI=;
        b=THtEQRtLnYMXSj2vwUu6vdrnIv08+9BDlYofBCJHfkunxbe968+2E+5UU5QkbBUrOV
         D1tdsL71wFLyHMuaV6nHTaG82YDcGeCEtwCS9vkZbP5MoCLuJnlM0NApe0k8PQ1ZLkri
         4cEzXaEtO0uEivB1DA+tyzL8GuULZwAGuOV9/StKBbTr3lL5f2URmbarowNavTZbpSoQ
         j/uQYvjuJ+y4kx4tyKJ83smJmvAvNuYroyzZSKTWWwJ6QMfQNGEQiXfMxW9jXuKFcwx6
         cxF/5I9eRgP4rRhh3/rWXTLKcFqD8M8Z3k+KmO0EFQh+hfe5NT2qYFRROTeAEQViW8N2
         V2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868745; x=1777473545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN2+ZAka5Ml1kEv2XiWcetURKfDSQtDSZ+W/WbZpIbI=;
        b=YGFTN3Lw6YIABGemZ+d8uYeDQptFWgBCpVa9zGoyzk0ZutfnT0m8F3LHpVkicBO57T
         NpIDQ+yEGFmel6srj0f5Mk3HYTdvt2ndpX47J8j8wjryWWELXeAIhCrfjonI5ClGBFv4
         +JlU4uKTRB+OqAGBTNH3QQVdV8llpNFHaWIeCNqrBl9ztl5qXu9kYLddAh5h3jxzx3Tj
         lF27+JvHNn6IsAeodVAoabCf79DcHWSd6P5wgn72LxvH2V6d4scE3eGk3FaBE7h5Bvtx
         r8VZzHrTaAayWFUzvHANCpa5V2RUyfvLpxpyhqpQnITK/Xvdd/8AAx7BOd3mfX6/ZWbC
         f55g==
X-Gm-Message-State: AOJu0YyhKrbq2Ltt/bzJg71FxNDGCDjvaBpZPRu09Eo39fr7sWBXCr6x
	IchsQj00b6NgLonZHMUDbnDIs/op5OKsaOqHuEIDf0Zt2BQRJokbm6af
X-Gm-Gg: AeBDieuCrBYdb7JCdloJpOvQoomx6QSLH3bB/nL41QwQMejOSzJ/vXqw3v3y+j0ISRx
	5vxcA5uLyrbAIfnixJklH/EGAtzbf0mxGaLh1Zagsvwd6ixYzykI5DSFN7uQZaBspUyl3RZzNIv
	es4PGuqDwCuXi3arr8C05rSJx1yXx7AZphgiDpLu54F14OZL1AFlo2U8+OgnNCQmyChPi2MvRIQ
	hUxoA0JSMAGjncer7J2SaqFeOXrpzAdke0pbuL/6ufH5WKm/ZwmyBO8juOaXA5W0Nc4T4kH7lqT
	ZOnddhAXPDu6tc1hFScbe0E4jnVn81JpkDcWjoW/M2K58w20AdGObAWzkzhiS72NC8gFsPDXwMy
	fMDATdX8hYps5gly8nR3TVQlFlRDA0+AXDUcrZ4qm13D5BcF8367jCWLbrR3nWrpYijZ7Et4SG/
	YGYlVRcBV4aL2iWFd7uZpi9sk9XxLIOAlz4LXfnnlKxFgZ4ro3AYXgZ4SLbJ5IbqEaUGwS4g==
X-Received: by 2002:a05:690e:11c4:b0:651:d869:db24 with SMTP id 956f58d0204a3-653119616admr16315019d50.15.1776868745221;
        Wed, 22 Apr 2026 07:39:05 -0700 (PDT)
Received: from suesslenovo ([129.222.86.44])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e328d6sm7933028d50.11.2026.04.22.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:39:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:39:03 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, jolsa@kernel.org
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by
 bpf_task_release_dtor from NMI on rcu_nocbs CPU
Message-ID: <aejdhxJ4ev3mxE--@suesslenovo>
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
 <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>
 <aeftTnQjdOgjZyYP@zenbox>
 <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77626uOQLrxkiMRDE_-VyMO=BDEYYRNEW1fgkj9yRv1NQ@mail.gmail.com>

On Tue, Apr 21, 2026 at 11:44:42PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 21 Apr 2026 at 23:34, Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 10:23:56PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Tue, 21 Apr 2026 at 22:10, Justin Suess <utilityemal77@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.
> > > >
> > > > It was found after further investigation from a Sashiko report on my patch:
> > > > https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t
> > > >
> > > > The issue is reproducible with a BPF selftest-derived reproducer that:
> > > >
> > > > 1. Stores exited task references in a BPF hash map as refcounted task kptrs.
> > > > 2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
> > > > 3. Runs on an `rcu_nocbs` CPU.
> > > >
> > > > In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:
> > > >
> > > > `perf_sched_delayed`
> > > > `  -> static_key_disable()`
> > > > `  -> arch_jump_label_transform_apply()`
> > > > `  -> smp_text_poke_batch_finish()`
> > > > `  -> on_each_cpu_cond_mask()`
> > > > `  -> smp_call_function_many_cond()`
> > > >
> > > > The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.
> > > >
> > > > Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:
> > > >
> > > > `bpf_map_delete_elem()`
> > > > `  -> htab_map_delete_elem()`
> > > > `  -> free_htab_elem()`
> > > > `  -> bpf_obj_free_fields()`
> > > > `  -> bpf_task_release_dtor()`
> > > > `  -> put_task_struct_rcu_user()`
> > > > `  -> call_rcu()`
> > > >
> > > > This is triggered from:
> > > >
> > > > `tp_btf/nmi_handler`
> > > > `  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)
> > > >
> > > > Environment
> > > >
> > > > - x86_64 QEMU VM
> > > > - PREEMPT(full)
> > > > - `CONFIG_RCU_EXPERT=y`
> > > > - `CONFIG_RCU_NOCB_CPU=y`
> > > > - booted with `rcu_nocbs=1-7`
> > > >
> > > > [...]
> > >
> > > Makes sense. I think the reasonable path is to just close usage in the
> > > NMI context, otherwise we must address each case. Could you try the
> > > attached diff and let me know if it successfully rejects kptr usage
> > > here? Thanks.
> > Didn't work for me.
> >
> > is_tracing_prog_type, despite the name, does not return true
> > for BPF_PROG_TYPE_TRACING. Only BPF_PROG_TYPE_TRACEPOINT.
> >
> 
> We can add it but return false when expected_attach_type ==
> BPF_TRACE_ITER. For all other cases, allowing it doesn't make sense
> because these might potentially run in NMI context.
> 
> Please let me know if you'd like to send a fix + tests, otherwise I
> can follow up. Feel free to fold in the diff I sent into your fix, no
> attributation needed.
> 
> > I'm honestly still not sure what the difference is, but they are
> > different [1]
> >
> > Would you rather do this or just reject the dtors with a
> > kfunc filter for this program type?
> >
> > Or teach the verifier that the kptr ops need to be offloaded with
> > bpf_task_work_schedule_resume_impl?
> >
> > [1]: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_TRACING/

Sorry for the double tap but the change you're requesting for the fix
will cause breakage.

This will at a minimum break test_bpf_ma and percpu_alloc_array tests.

More importantly, this will break existing progs that use kptrs in
tracepoints.

Would a narrower fix that filters the dtor kfuncs specifically be a
better option? Or better fix the kfuncs that use irq_work? I think
the real fix is to make bpf smarter about when it's running under
nmi, but that may be non-trivial.

If the breakage is acceptable, should I just remove those tests?

Justin
