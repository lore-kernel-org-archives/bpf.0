Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F62392C5F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807250; cv=none; b=o8vVLo6t2zw149Vz8fqasM22yg0IngHKtTfdyO4UC2+xFhyV/T0Uc89CvkRkg2OIHX0TSpnLkDjOQQSItjxZ0kydUwqdnOrlIVADX2EKih9Dd5KoUnLDHAQG5L/195Tqn325nBn9a2D8XCj95v37GGuPEJ1fCcqnMEj8jAKrByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807250; c=relaxed/simple;
	bh=WZRaQENtIp7tgxm8Zjj7nUdRBZpjAlZEH1NXHD4fD/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgbxmpQ6w4mkx2X9kPBQzMzAJb1THSyau1JHOx55Zzhcd9kVs81iPNNCW9eyBWTdT+GSG3t+cKFw7/OGZxWRqmQq/sA0jqR1opz5MTcQUIUXPEQ2ticePFotxLGl62Rr93cyrcbsq41KJp4cicW1s2KxY56aqWajoKxlygPfgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfipFcXZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfipFcXZ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79cd8f8e261so29711917b3.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807248; x=1777412048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpgtcFKcnJO4nQYK6DQpgXIVZNQw9WNgo3BWRYhA6Eo=;
        b=YfipFcXZgjzEYWw1Cdk1aFOgrU5mNEvywgkhkKmquZNQzdr/fJjekaIz/HzKB2+wTI
         CAsfagOc5A7faZMrHo8P+NXNYiZYYKvTAymAfXcsqFRRgDXOGEdAI7qZNHNqJBo3dMNE
         txKSKG0CTM9k9SbWUZjPKSI2OSUf6VINyti0g7eLE/5h+LqUMArrEtL9EGxhUn/yELUa
         9pcSPvyq9uWJ+o20L8z0mmrlS6zq/OY50OJjiEhlKpXJz9flPY8QykgYG8YSavvcMsEe
         XvXlmp/a6WjV/cDqBHAbPbkGhH6utY/3o3poE2mD/qBwXCOBEhOPRtH9WW5lf86MAPfJ
         LbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807248; x=1777412048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpgtcFKcnJO4nQYK6DQpgXIVZNQw9WNgo3BWRYhA6Eo=;
        b=Lu/pD5Rv0M8S1Q/0qz0ch+N27pH4pU1+UK37ccwM7BKGlzXp8/k+f9CYcyVEAlEk1/
         IGunSH+oMZahD+nvRGppnBd4qBcyp/u6J8UUQVo5L7qzzXBtIHB0tA13o96P95RVt45g
         GLFxYukEGAUZbQpN+pfJBqt0D1U9RfoTe0/N8JdDZjiXkmQQ1DorcQSJQolrNtDt2s4B
         TRLLavWrj5USg1sAXL1PfLhy3zLXN+/PPv32bu0WZ9I9FjNYheneklpjGBAe/id4y2G6
         CUFfdzuERiqfJiqGG+lDq77x5WgeWykxHtcoHvb2lBbUMyGte/ZomkwlEVWvuRCHt8h6
         rxBA==
X-Gm-Message-State: AOJu0Yy3sGPYQ+pIcKaKHCo6icqE4Drq1L25pOPk5U86NY/WtHwa8ZD0
	rHW4nh7RQcUb0vV2aEuz96CLDEnxm8UQlWrZs4gxr+4wD1yNtdbJUmQsllmSMQ==
X-Gm-Gg: AeBDiev2jYLwsI5Wr8w1HfeZvXYfSFS3q3VK4c7467gXyovFRWIQNAm9DmtbjmzqkH3
	E2UWLdr6GPluSm/D0OoR0QXBxsSHmAvrWTIbyJo0Pkc7/dq2Evo5bZt4x+X3HCzm28omAfCLWJo
	CeNP6Zk69su6JLk6ObSHZL7MkqQK7vc9+rFdpQyC7aSuvcaYB5NKnaXMGNp9bGzdSGPeRSlD94Y
	Fj9LRI1OA+RodGFrEqr4oDRn0ae5jErHRiPJUvQmfl0wacO6YUJYOKQmeGL/qUM4BXzXj62Ges4
	WecTREWNgT9VLZ5Ozs0CGS3VsSanfGk02racBhwgljVbobhrZCuTGILjtWGrREh1E62puNM08Y6
	HgEslcoLfW3Zy5na9e4xDQcFTe9pEjcnBhbrY/rT0JsiDdNeAvjt+11YluhZFRuNWYKS7/E6KpC
	txBwRX9YmtUdssZGKGd9FzqlL/tTE5Ii6WXEb40XcQqnSeczT2O+VGTdRrt50IV0SUR7Vr/QU0E
	PduljQ=
X-Received: by 2002:a05:690c:c4f9:b0:7b2:4735:b99a with SMTP id 00721157ae682-7b9ed05fa8amr196748477b3.49.1776807248369;
        Tue, 21 Apr 2026 14:34:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2ac1:99d4:1cef:9896])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89abd7sm60718807b3.1.2026.04.21.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:34:08 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:34:06 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, jolsa@kernel.org
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by
 bpf_task_release_dtor from NMI on rcu_nocbs CPU
Message-ID: <aeftTnQjdOgjZyYP@zenbox>
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
 <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>

On Tue, Apr 21, 2026 at 10:23:56PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 21 Apr 2026 at 22:10, Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Hello,
> >
> > I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.
> >
> > It was found after further investigation from a Sashiko report on my patch:
> > https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t
> >
> > The issue is reproducible with a BPF selftest-derived reproducer that:
> >
> > 1. Stores exited task references in a BPF hash map as refcounted task kptrs.
> > 2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
> > 3. Runs on an `rcu_nocbs` CPU.
> >
> > In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:
> >
> > `perf_sched_delayed`
> > `  -> static_key_disable()`
> > `  -> arch_jump_label_transform_apply()`
> > `  -> smp_text_poke_batch_finish()`
> > `  -> on_each_cpu_cond_mask()`
> > `  -> smp_call_function_many_cond()`
> >
> > The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.
> >
> > Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:
> >
> > `bpf_map_delete_elem()`
> > `  -> htab_map_delete_elem()`
> > `  -> free_htab_elem()`
> > `  -> bpf_obj_free_fields()`
> > `  -> bpf_task_release_dtor()`
> > `  -> put_task_struct_rcu_user()`
> > `  -> call_rcu()`
> >
> > This is triggered from:
> >
> > `tp_btf/nmi_handler`
> > `  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)
> >
> > Environment
> >
> > - x86_64 QEMU VM
> > - PREEMPT(full)
> > - `CONFIG_RCU_EXPERT=y`
> > - `CONFIG_RCU_NOCB_CPU=y`
> > - booted with `rcu_nocbs=1-7`
> >
> > [...]
> 
> Makes sense. I think the reasonable path is to just close usage in the
> NMI context, otherwise we must address each case. Could you try the
> attached diff and let me know if it successfully rejects kptr usage
> here? Thanks.
Didn't work for me.

is_tracing_prog_type, despite the name, does not return true
for BPF_PROG_TYPE_TRACING. Only BPF_PROG_TYPE_TRACEPOINT.

I'm honestly still not sure what the difference is, but they are
different [1]

Would you rather do this or just reject the dtors with a
kfunc filter for this program type?

Or teach the verifier that the kptr ops need to be offloaded with
bpf_task_work_schedule_resume_impl?

[1]: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_TRACING/
