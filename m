Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696627;
	b=J068j2JdH/0Ha7KJOXUMwO2hKhe0/A/Uu2+j+oeRMsU5oZEa3se19oeSCZVm7QyKqA27
	 5s7nmL4MMqsoD88XbKvk1y3tuVuPSzeUCSUzAckgFiYlVDmxn/lUhPt1jUpjpUJZrR7XS
	 ZZiSgMMxRv3a5FN6fM6iKK6249ZVSt+3A9FrCJG7Tk6pxPyIsbNC9JoAGzLv/Se9yoHhM
	 +KGmOpvGes34Yjuw6yRCA5vwA5AcOhxlUUa7HfFd0AhT2KtDTvGEboOydRcdlaDTps4P9
	 2tcNCuFxbcb2Pe0AIglur13S92cjUscdK0KnjqbvbB0dwNHiXAkGJuO0AgUIa4Ms/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696627;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=rF3lwQrlgvyoEcEb2mTJ5z+aXEk03V2/91Tqdny4RHk=;
	b=sRe5Fzm8DGadBu4kBTABUFaRWFxiwBFgFw7BPVbxtm868B9IONpJsJ/R33hiEvX6M+2B
	 /4dBA2YLbVH36G/0/ebRQgV3k5TlmmZI12srxKoW12hwhSnyzwhDAo2BjhlghPhmeFgkg
	 vQy61ztoXBH7wlOjLsVU6duwpeTYhaDmFzI1e0fu8X8vfGBcK/clJsaYuBXh9EJZ5Qv72
	 9nkwPHFEIF8ZKklE5xJRl/qsd6nwHhIP+uBSoE33l7O8DBesppuK5m6oP17vsnzZV+ZyQ
	 AIQLW2bKwghgW1xQLHeKnpmzOK7cnDLxfUAXry5V5XJTh9p2L9yeO9i5lOJlCdELwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BiLfIXx9;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D44606A327;
	Tue,  3 Nov 2026 09:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D44606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BiLfIXx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rF
	3lwQrlgvyoEcEb2mTJ5z+aXEk03V2/91Tqdny4RHk=; b=BiLfIXx9RjMXEnQtb9
	QSO8NrVbPKRHOcKoy7lSNWOhVpoChejG9bW79ViG2r8cVtuZeRu1J0/jXq5Zjw0e
	/g3OZKEAFuz2sRURAqgQHfjeXlsNKG6Yb1fQhXDw8LPMrI7AopQNsZJcGaEz2xi4
	3t5vBj3tbXVi1juplIBYwW2PU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHT6oyo+lq0SHqDg--.7504S2;
	Tue, 03 Nov 2026 17:02:44 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	matt@bobrowski.net,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
Date: Tue,  3 Nov 2026 17:02:42 +0800
Message-Id: <20261103090242.680147-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DML8PRKSQ4ZX.2A8Q5SC26RO6Q@gmail.com>
References: <DML8PRKSQ4ZX.2A8Q5SC26RO6Q@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHT6oyo+lq0SHqDg--.7504S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Xr4rur1DuFWrZF17trb_yoW8Aw1DpF
	93tr1Skr4UXr1Fyr47Ww4kWa45CwnxXa17WF1rKr1rA3W5Zr17WrWxKF48ZF98CrykWw1j
	qFyjq39rGr4UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR4KZLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxULg2rpozXY7wAA3w

On Tue, 03 Nov 2026 03:03:02 +0000, Alexei Starovoitov wrote:
> On Sun, Nov 01, 2026 at 11:37 PM Feng Yang <yangfeng59949@163.com> wrote:
> > Route these paths to bpf_get_stack_sleepable() and mark the new protos
> > might_sleep, since build_id_parse() may fault in file data for
> > BPF_F_USER_STACK | BPF_F_USER_BUILD_ID.  Sleepable programs that call
> > bpf_get_stack() from inside a bpf_rcu_read_lock() region are now rejected
> > by the verifier, which is the correct behavior for a helper that can
> > sleep.
> 
> That's a new feature. It's not a fix for the splat.
> Andrii's point in v1 is about build IDs. That's a good reason for this
> patch, but the splat needs Songsen's patch anyway:
> https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.com/
> 
>                                         Songsen's patch  this patch
>   ------------------------------------  ---------------  -------------
>   splat in sleepable progs              fixed            fixed
>   splat in bpf_wq, task_work callbacks  fixed            still there
>   build ID when the page is paged out   no               yes
>   progs that load today                 all load         some rejected
> 
> Row 2: the callback is sleepable, but its prog is not.
> 
>   bpf_wq_work()                    rcu_read_lock_trace() only
>     callback_fn()                  prog->sleepable == false
>       bpf_get_task_stack()         may_fault == false
>         __bpf_get_stack()          no rcu_read_lock()
>           get_callchain_entry()    rcu_dereference(): splat
> 
> Row 4: sleepable fentry, lsm, iter, syscall and tracepoint progs that
> call bpf_get_stack() under bpf_rcu_read_lock() or bpf_preempt_disable()
> load fine today. With this patch the verifier rejects them.
> It does so even when flags don't have BPF_F_USER_BUILD_ID.
> 
> Pls respin it as a feature, with a new subject and commit log
> and a selftest.

Thanks. I will add the selftest and respin this patch as a feature change.

