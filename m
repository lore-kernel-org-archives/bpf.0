Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E982F8E85
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080404; cv=none; b=ZLE3yG6Qkz9HpMuauXYu7exRGNOVmWt1MI/prnT/K0aYIc5Y3tJpgw0jdEM53wtpsoxdbH5h+r/IvGRlA+ZX1ScFYg2RCG6/1Ie/lgpMwGWLeiLXFrrheaSedFOUOJ3Vnma6IKeJGt8IfmmbJR29rr6sr5v6901PbI/j38zxtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080404; c=relaxed/simple;
	bh=SVUpaxhc/WIBfNSCedhE5+nKIJK1oRK66sf/5MKTEmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIHaORKlzaeIAtCEx+4Onkw3LpoUQmnZ5jAyz98y63SyeSpvCO143U6enesb77gxDLD+QyRerUEV3NZp/zK1E1bY5twqcPZcFklHJn18Vfv1nrd8XGh/oFBPCm7lAGOwyuchKgIZ2MOAY2l0WiWP+9ik4vvpp9zmZ9DQSZeOuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I49Qht4C; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I49Qht4C"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-936623c6dd3so143847785a.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789080402; x=1789685202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBU7hvidTKCJV2Nv+RIrUVUgoddYnQKNG/JROhtpIDU=;
        b=I49Qht4Cpz/sL9rBGh8wxvxgUJk5xpheKdbRJ/4xKgeY+pq0nnumHLLHSGY530L+v3
         INjAnNeeR9jL4Kx4wB8wsu3BNcizeEN8wnquaR7cTB8TCmwiOP5qPSFz0yi8biBWChHO
         3u3821uJ2DUVuP0UFubWPvrqYdwYb8Q7QKl25txTHnp7WZh2QfmeGcURolyy2l0z4D7G
         XfhtUYwXe2vGNNyeYZwkMonwW+hKS+FncBWaxHfwX7i+GqMVfo6/8gl28Rxb1O+hDNKN
         kF9slp3oCZrdB5Z4o6bmdJiR3lYG6cBzGDostK4mrlh46hqQMuWRh40800hHWIAxmecV
         F9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080402; x=1789685202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBU7hvidTKCJV2Nv+RIrUVUgoddYnQKNG/JROhtpIDU=;
        b=YM+qzfC6OuEYFG7FGj2Pmk3SD0j7NPycbjQPxwv5VdDPNSq3ovvsyCgoRWgvjH30uf
         jtK91aKCtUVLdb1IJK2ODwLZYDWQ+OxjAczUpLlX/nPKNz8tRMpJoHaCklws6RAndQLk
         sgM5s14l4PXQCldMLYcJo2vF9Fs0Hwo9sA07QO7TLNNfkAQ/GESoLoRT4dVHQJM9CUTt
         TBcrGV9nwz03tG0Hh1c5nBoB97kGELr6OIgSC9hjblJTBnK+SRSTD5tgC9dvqrqk9tgZ
         0LN7jkFeM1SGzr0UZKBodLAu57R3K/NzQwNxibcaLv23J5MBfsp6fnLNtq1qET/ya7iM
         E0NQ==
X-Forwarded-Encrypted: i=1; AKwUvByKo4Uruk2Vlr7zaLq0akFr5cHJ+BWgbc/oJhss0hwpP11ETeJS709sQs8OPldpjp4IotA=@vger.kernel.org
X-Gm-Message-State: AFuF++kO9rOlkRgEY78TghcZczYYJ5MaZZae+DbMjuSvRFEgcU3cfLb3
	IcNtMHko3vQf0E+JwhwEAGJpXMfibmwOE+XWSNf2K3KbCD/JaQWSkThGaiq7KL+pZ9k=
X-Gm-Gg: AYBFou2liEZ8+Nh7rDdiJLpexN4KBKzgV/+Bjv8sVWAPxlV7DrETVSKnoPUyS/8PM8p
	sRdKhHyJKJFxYMJov+0S43ziscK4StwhYPAUDCSLXjmc2ptB5GUr+h1Xc/TH+h294mNTbZuSQXI
	+441VmAcVR/V27vN4eSpN1MEg8Sy36Hm9/R9aO6DGPxBeMqr57zGVKIgKvDE+48IPmfluS/LQHq
	xMRYmBPsJipuPuUYKVNANgEcPmb/l3lBosA3n00g5BJQEtl2WzJFJjOwY0LcBinyph8rVgAS/aB
	fMntQiOc5mF27IkjZTCJ5TWekRK8yBzQad6tRR3JFsjHHkiA6LQLTAoA/pEciQalNKbSTRgWL8S
	wROhHtyocktwvN+Kd+KfH+oOh5YlmpljeOUvsAo/nK4pO6RCeAqTq314wV2D/041vVTKQMehE3x
	EQZsF9wBHKLsp8IR3vnzBERiudu3bbo8J3NI19RMin38NqjzbpwqDUd+XxeW8bCU62BtfnU3PcJ
	1VlRBwSReRu28qrhO6mN8COVJVEPQEWS1CfZsRJnyD8WgKoBI1YkYFJPsntsRQJ5hg=
X-Received: by 2002:a05:620a:3182:b0:939:75b2:8844 with SMTP id af79cd13be357-939d7fcb1a2mr822789185a.35.1789080401713;
        Thu, 10 Sep 2026 15:46:41 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm91246585a.33.2026.09.10.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:46:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 22:46:38 +0000
Message-ID: <e44411503b3696cdf003d3e46bc54fc6.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC 09/13] arm64: ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
In-Reply-To: <20260910190436.EBE3A1F000FF@smtp.kernel.org>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com> <20260910-b4-rcu-tasks-preempt-qs-v1-9-d4469f4cc101@toxicpanda.com> <20260910190436.EBE3A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 19:04:36 +0000, sashiko-bot@kernel.org wrote:
> > +/* End of [ftrace_caller, ...) for arch_rcu_tasks_ip_in_trampoline(). */
> > +SYM_CODE_START(ftrace_static_tramp_end)
> > +SYM_CODE_END(ftrace_static_tramp_end)
> > +
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
>
> [Severity: Low]
> Will this cause a linker error when compiling with
> CONFIG_RCU_TASKS_PREEMPT_QS=y but CONFIG_DYNAMIC_FTRACE_WITH_ARGS=n?

No, that configuration cannot exist. CONFIG_RCU_TASKS_PREEMPT_QS is
def_bool on ARCH_HAS_RCU_TASKS_PREEMPT_QS, and the only place arm64 sets
that is in patch 13:

	select ARCH_HAS_RCU_TASKS_PREEMPT_QS if DYNAMIC_FTRACE_WITH_ARGS

so on arm64 RCU_TASKS_PREEMPT_QS=y implies DYNAMIC_FTRACE_WITH_ARGS=y and
both the marker in entry-ftrace.S and the arch_rcu_tasks_ip_in_trampoline()
that references it are built together or not at all. At this point in the
series (patch 9) nothing selects the option yet, so the reference is not
built either.

For the tool: the two symbols are tied by a Kconfig dependency introduced
later in the same series; checking the select conditions across the
series would have avoided this one. No change for v2 beyond a note in the
changelog.

Thanks,

Josef
