Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD274E0214;
	Mon, 28 Sep 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606368; cv=none; b=tfGXsvjGiZMaFTedZtwrk4I6dytqPFdaMNzGNCVCOdMy1eJww5Tm/JkiZaKOvGrBcClpZhKNzHzK3s0/0hZUPDA7PvwOje2xF3qu7iajrOC3rnqfkvePUv1uLmnjn+Kl0iqTlh7Z/byXhSPj5tqthBEDyzoMKtGr+l1T2mSpEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606368; c=relaxed/simple;
	bh=j0K0YAzkwLwoVPdpWxWoYlfTgtpmwcoy3mrjJDSQ9aU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ooGcTh9XixXPyQGPF8ZbmFnON2nkB1Po22Lmq4lDKjoX+mjaTtyKG7BMP5cxPFSCuT6d0fPSDDZFw/bSn7ZF9xQYO+TEz0TjihWa3DFTMOtKs4/pBGHB0fMKdLuLtDwRMOd1X1r+ETj6ux+CBnVZmm/NvNpBkwZaAsPjwsfdOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaC/stsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaC/stsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D383B1F000FF;
	Mon, 28 Sep 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606361;
	bh=RLah77bWoY+PnyG6Ld6Ca6jGwCJvO+V1k+Gyc2YaQyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NaC/stsx2lrYQvksojtDaVHTRl0ddjq8L4RevlAqFLER/y5HfsLMQIq510liwdaq8
	 iPisZp/XHpI953Yxov5lYBlc8HRz8oftCvU/7Rlfef8vge54DqZxjGj9kECKlsmBCC
	 50a+74uuzHgIqEpdRAIXl0zJY7tr6JibJDi5d58fd9ihAaMAL1ZZxWrDy7HzsWwBOu
	 esUBXZktwMXdFLZmxJbLaTsBW0d6dQi1T3t4wXdENUrD5y861yHAgOAI7Ch1dS5h7C
	 uTT2lVzdNot8/vY7TmBF0fAu5wEwgkPCGCeXZawGzm8iGLXBibUpE2LqOgWLFhoAQt
	 oyqToy8Rmtgyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] rcu/tasks: Export call_rcu_tasks_rude()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179060576723.372125.8212099501235098804.stgit@devnote2>
References: <179060575297.372125.10581329083761385407.stgit@devnote2>
 <179060576723.372125.8212099501235098804.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:39:20 +0000
Message-Id: <20260928143920.D383B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rcu: missing rcu_barrier_tasks_rude() causes UAF on module unload
--

commit ba4806c534fb61d71e190abff5c0d237c0eb2648
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

rcu/tasks: Export call_rcu_tasks_rude()

This commit exports call_rcu_tasks_rude() so that subsystems executing
handlers under preempt_disable() can safely use an asynchronous variant. It
also provides fallbacks to call_rcu when Tasks Rude RCU is not configured.

> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -198,7 +198,11 @@ void rcu_tasks_torture_stats_print(char *tt, char *t=
f);
> =20
>  # ifdef CONFIG_TASKS_RUDE_RCU
>  void synchronize_rcu_tasks_rude(void);
> +void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);

[Severity: High]
Since the asynchronous callback API is being exposed for external use, does
there also need to be an rcu_barrier_tasks_rude() declared so that modules
can safely tear down and wait for pending callbacks?

>  void rcu_tasks_rude_torture_stats_print(char *tt, char *tf);
> +# else
> +# define call_rcu_tasks_rude call_rcu
> +# define synchronize_rcu_tasks_rude synchronize_rcu

[Severity: High]
If a barrier function is introduced, will this fallback block also need a
corresponding fallback definition like
#define rcu_barrier_tasks_rude rcu_barrier?

>  # endif

[ ... ]

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

> -static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t fun=
c)
> +void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
>  {
>  	call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
>  }
> +EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);

[Severity: High]
If a loadable module uses this API with a callback pointing into its own te=
xt
section, how does its module_exit function wait for the callback to finish
executing before the module unloads? Without an exported barrier function,
could this lead to a use-after-free or invalid instruction execution when t=
he
pending callback is invoked in freed or unmapped memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179060575297.372125=
.10581329083761385407.stgit@devnote2?part=3D1
