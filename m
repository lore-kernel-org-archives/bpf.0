Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BD1CAA78
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607833; cv=none; b=VvOwfLPoNGR5tDELn45fDnbG7jWACG0O1Lf9qFTpucEGtyRQB2ZKOIGgqCFhXL7UfUqsYmMq/wVo1fPUng9IXdYZo09clbtonmZaXhqPLv/OIfEWp3XjLlanlwLrieKaTo/eCculqqRko78fgMqjkfQLfvAVs1CTE0oOV5FPipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607833; c=relaxed/simple;
	bh=3fICS9Csi+nlJQK43ytP+dop+wq8MBzte5BeTYJ0koo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDmS6qNciBzkq8f1+3A7Ad5KVma/39NnJ8LfAE/hh5G2iGhZn1IzgYk4dcQdBdYsYsxMxgIUD89LaTUXukc0nzCF6bVOYQxmWZpACvKHenApcuw8PWymzvCHdPoJgJBFAXLk2IO2Wffx1IQ5NeaZNlVx2xCiH5LWwHi3njwl2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=NuucbmMw; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="NuucbmMw"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc71so2067851cf.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789607831; x=1790212631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5zFJ55cgnEY1OXRIavKUOEIG38H34pgZ3VgFg2bzwY=;
        b=NuucbmMwYB4rH4LdRz3rj+oUbzdl2pMAlrFl7js/lFG2OHxI06CjJtAFlNYeIWYgWc
         LOvPOwuYYcIFYxsnkb96dz6qi6uhawdiYNSt7ClpcxkPrPFqFSy2oVhXRQnMCYQuFarC
         y89aYxmRrxYboR06vMqzQU24Tm8b58j/qalTYBXmRhB6U95wFsU5NbwvWt2xt/FUlp3d
         fiFbursIuDNdBjHockPrWaBPAZp9jUaJtkvXCYvepgUQyM/blMO4Il8/S2UBMVmebDXn
         214o8+doZShoWzIX5WWWOTBtWUADeNz5c3TK/HQmyLdLaW96Y3nW7WnE4qNAt3th1kKR
         xDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607831; x=1790212631;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5zFJ55cgnEY1OXRIavKUOEIG38H34pgZ3VgFg2bzwY=;
        b=2ru80QKXoYa0u+b+RpVvJRioeTr/LMmzZOB6ZaN4xpYRDBkiefI9NoCURlwBCRrs+y
         cr7jxEZYMEDY+KJr7Yhi4/XYGy5Y8l5i7nUtLlb8YL4aLTqScvZ9iZeNdQ30dZa88VFH
         4hnj8ChBhPF2orO+nHLYfr2uGPuUk+VFxWkmIwotWIvovChIGIx9hwQGPhW0bNEPCeZr
         iJlDv5JaRhaPfudkS1gleuMzll8OB7Xd2+/NPeI3hSleMbIOYjUthoO27g0WqQ9e0DUC
         Pnmg0AiOkXa7VGSVzS2dBfftUjTAWGtUV64W84lm1AgAQOSobmJCCpKBMmWXmD9xUxx5
         1Cdw==
X-Forwarded-Encrypted: i=1; AKwUvByZWkPAgKILxPoGwT+vjy6s+ShzRH9HnvsEdwIHQQTF3foOCfMf5QJONRrr4+lzkPRsfoM=@vger.kernel.org
X-Gm-Message-State: AFuF++kEI+ImIVFg6LKA+eyUHwIvS1098Aj0VlzWUadQBHamI7mRY0Q1
	/EUdd2bqyx2t4lV3IC6FFlOs9kIy2Vu08n53EatN3+liIWcO44hvYBTGEZ7aC2ADQTw=
X-Gm-Gg: AYBFou1e4RuO8tujbjt49rnJ7pa7/iQtlUkui/7BNoLHMUevAdcZXsJyA9ZaIzRwRM9
	S5f2H/ivNkwXwHsbRRo5+XJ51XlZZuc97lFwasDfhWA1iRR85OEWFjeYPvMmibwOz05E6hYboJA
	VsyAIb1ygrLnN/WOXi8XYvMpOLWuN1ffS/K5gBdq3OJ8hoSgczXskedGeWeH/cLXaFSaNmnf6fn
	oGLhvPhW9qL7UMCPb32mx/LN+GUhpjl1crgw/yW7+p8LIzxRCuVqG7qGyjqQcWW5pWemjiu7itY
	6ynGHc7QEIryZaoo11dENJagMgMtevdFNLBTxyEVNlIYQRpA1Vc1gIEQ/HF91MAjcqgFV+VILae
	DmFbuKrMpMwLFFqFqTmzT7K2RwleGgrk5Jv42UD3VCq+kCI3Sb0j6KIyGcdP+NuXAyRY5Z82Y9T
	K0vgEwUkasUQwlezC89uzLEC//XG1OlDTz5qrKEJxUPlVL0Wi4VgwCY7LIN+N2Wm2NOwzyu7ZD9
	Du/EWYlvE1txJ3HO+N0/B9OXNmouIDugRv8Y0kvyRbG/GBUJcwUgngV
X-Received: by 2002:a05:622a:1a93:b0:530:4249:e7a9 with SMTP id d75a77b69052e-5327ed78742mr91407171cf.13.1789607830859;
        Wed, 16 Sep 2026 18:17:10 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326200b8d1sm35571491cf.12.2026.09.16.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:17:09 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:16:58 +0000
Message-ID: <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the trampoline glue
In-Reply-To: <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com> <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 03:45:16 +0000, Alexei Starovoitov wrote:
> On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> >  	__acquires(RCU)
> >  {
> > +	bpf_tramp_read_lock_trace();
> >  	rcu_read_lock_dont_migrate();
>
> This is double increment. rcu_read_lock_dont_migrate() includes
> rcu_read_lock_trace().

Unless I'm looking at the wrong tree it doesn't, on Linus' master and on
bpf-next it is

	static __always_inline void rcu_read_lock_dont_migrate(void)
	{
		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
			migrate_disable();
		rcu_read_lock();
	}

so plain RCU plus migrate_disable(), no Tasks Trace reader. That is why
the non-sleepable glue needs one added here: on these architectures the
trampoline image the glue returns into is only kept alive by Tasks RCU
while the task is a rcu_read_lock_trace() reader, and rcu_read_lock()
does not give us that.

It is two counters for a non-sleepable prog on x86-64/arm64 though,
rcu_read_lock()'s and trc_reader_nesting plus the SRCU-fast percpu one,
if that is what you meant. I don't see a way around it short of not
using Tasks Trace as the trampoline reader: the prog still needs plain
RCU for everything it dereferences, and the image needs something that
survives preemption. It is compiled out on every other configuration and
nothing changes in the JITed image. If you would rather the reader be
taken once around the whole image in the JIT instead of per prog in the
glue (which would also let the fentry-only teardown stay a single grace
period), I can do that for x86 and arm64, it is what v2 did with the
private counter.

Separately, Junseo's "bpf: keep trampoline progs alive until image
release" also adds bpf_tramp_image::nr_progs; if that lands first I will
just use it here.

Thanks,

Josef
