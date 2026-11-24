Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554529;
	b=itBCcDX/Y3yygO1oPKmyoBaw1XIZV3V4pKGBU80WmIOZvT5jzAn/yx6I+ztcl0adXFYd
	 3zPT0ytYXnPrSk6LovyBhj28QbEGWv93j4oUnjaPO+wv/WGShgs2YEhcaLRpUDcF6r/iQ
	 WPD/R5fZVZDRgyJn331R1YHpEyCe4CyVidbECLgTadYaBKOKJnxvil4exPdKpRFjtXyke
	 Nlk2p1oYZwD0NJRJF8d9Zg4+b1BZguc7jWMJjFzcgrag0iMqg02f3fVnC+ddAtxWJGMzM
	 +ExxORPfvN27aIjP5mnh5m1oTx49dY/ZITgXgxHEJqQ1Zng4fmhF+gZT3uBuUWlWXpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
	b=zTxK96SEOG3GJK1LIgJYu3/xwYFbGiMTOzy41ijmyGE5ucSOlzGy9+HlKW0HdwPAkAkQ
	 hY1Opq/y32Y5oUd+lTFvqrlbnzgByR791ci0bgfXqtb28bbL9erFIsYR9rPT5C1RnreBT
	 sgJ1hDpNxcllm0kSoxeXOr5OJNPQ+sN/HZbEuGwGA3KVJ3Z16RpewCKPfIJ/q4BclC0HM
	 5BTRfi4lIozuF/pvDQvrjYzlGm1GSSScIjbPcDb2P5JjaBP2u+NJgCTFzc8Je1nyrSqjs
	 qh5nYYoUsuXdOK0NuloAFThF0W0M0MHxYoOzleIu8gA9uPE2ydtcq5MbZZeKK1gL5CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vaZLIGHm;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94E606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C94E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vaZLIGHm
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a07078200fso2597392b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554528; x=1796159328; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
        b=vaZLIGHmdMLAeP3hCfVR9M8r2dq696vSeB4GJOOrtdhFWSfxRDHSp1L/iS5kl9gnqK
         zafbDaAj3hsmF2ZlXb+CBXrTsZ6cNqa4QtOdYr07CmsRMC/1IWK5KeUiqLkORuLebgGl
         WlWCn6XgFxNszcEVP8RM3qo0rFhvKeXH2ctH/8w7ru1RftiRxUgyw1CMKde7M0TO9Iy/
         ssaXEtzVj7t1AGk/GiKsDAEnqAIlKsqq3PjyeASMmlReECw33NlJwf6RKvI4DhXx7rnD
         u0r43telmLn3URSUiExeY98/+qDxPPi+L6keQbNWPINLuH20QbmxD138h4LcqdL9VtHY
         5ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554528; x=1796159328;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVSvyUb8nqSIYBliWEjWJ2l1assgxYp9ofjOe8CP8Jo=;
        b=BroiT4lDMSlHSm1x2riVdzrhP7htiDSsRmkt/O5/h4gRGRbQNpV1aOhkRtybF3SsYp
         aI+VkV7TsPGGh4oYvKDF+O8fe+HMG0UkV9aAzDIXlAB680vXjYxpehnhRKeuJ08jGdbH
         h6TBTMmljEiDmyZIGGsVPH2AFipwVwq2p0WAqFabD2KLSlZhgMlxrlW3jCk9etjz17Zj
         NTWUMLpEueE8BuMd09WJQKuHpBaCngVWF9PhSMifYhNJqsCEoC1Lq5+bucGeIC5l2Q29
         DX4r+zUgc6nnKXbiVCxOlXxPYOvsVlbIEFe2cvmW1Yd1cmT89P7gPsTuVFblmLTGwABn
         13Aw==
X-Forwarded-Encrypted: i=1; AL+hErEU6PH5tsSEm2nD0Na71VSoMaWFW7Y7nOUz+dAwfIvFbvq6T8hdyDee67eicS1ftWkbse4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aJXvYhslcQUANIgWMuolkVkT/FZAI7mF7sMVF6jR+DBI/xYBP
	oJIrznFD71lImm3et1TGdStRKsvH5GJf1bBrs2Ru/NyOMF9HzjvQcaD8
X-Gm-Gg: AZFdTZdR2nnlf/S9R7NftUFRL1JLHPHaJycdmUCpq7urf5le0itF0kZJayS4RSx5e8q
	gfeYxgCsoPUmMiSLb63bAUCwdwqRFmuN3MiJylEDrHQeB5OIoLkW0t62dBxvw6paRvHT8BI+u5J
	QnxZ41ljiUXoGvuDWHtqLKefCPirORcHoQwjIBuXvnCO1jry2B9Q0SrW+T0m32A/pRAzZot2BWo
	7y8DpQMKODMRMW9JScbkcu2/hotNgZcrigr6lfIevh2evBY02FDeJ5K670Dw+yGpZWVRhOZAktd
	eETUssjiWnxE/CkYXcEE34DokJkDfDDTeqIDKvtV6XBISWKFHvA6wUDSFAg38Kv02OWtTALN2Ig
	6HvSO7wHXtmzK/qCdXMlDE1ApL0twRjW9sNtl7LeeZzH6/tHCh3alRlWRYku60LnPAZTShTOiR1
	4yGHCSC6q5Yr3XKHdzUDTKCpjB3J3ohhyOsc1l0AoDwy0QP67ebhqNQs7UkvrreOJvapKJzWAOz
	scCPyymk/hZICZKHXgurdFrZNq8gCBRpr6qSk+qwwjPe1bTe0ehxWgNqN0RGhDzKKV1SvgSEJ8s
	W9XmYAc921kKyA2l95A5CLYR8f1splJFbbgzktANHjJMUYHFbxhvZHdLtPkvmN/PIt+0lDuR4Qa
	e9coAcds/nptK4DHpzrRNcGZfsoWGomGCog==
X-Received: by 2002:a05:6a21:139a:b0:3fe:81b:5194 with SMTP id adf61e73a8af0-4014e45f92cmr15775068637.62.1795554527700;
        Tue, 24 Nov 2026 13:08:47 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm7606443b3a.26.2026.11.24.13.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:08:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 21:08:46 +0000
Message-Id: <DN3QYI65E4KR.27D6XBG0SUWVI@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>, "Boqun
 Feng" <boqun@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
References: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 10:56 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> The BPF trampoline calls rcu_read_unlock() on its exit path. If the
> task was preempted in the RCU read-side critical section, this ends up
> in rcu_read_unlock_special(). When a BPF fentry or fexit program is
> attached to rcu_read_unlock_special() itself, the trampoline runs again

Not quite. need_qs and exp_hint set rcu_read_unlock_special.s too,
no preemption needed.
With fexit it recurses on entry, before the prog runs:

  __rcu_read_unlock()              nesting 1 -> 0, .s != 0
    rcu_read_unlock_special()
      __bpf_tramp_enter()
        percpu_ref_get()           nesting 0 -> 1 -> 0, .s != 0
          rcu_read_unlock_special()

> -static void rcu_read_unlock_special(struct task_struct *t)
> +static notrace void rcu_read_unlock_special(struct task_struct *t)

It should be fixed on bpf side. Only the bpf trampoline recurses.
ftrace, fprobe and kprobes take ftrace_test_recursion_trylock().
notrace takes the function away from them and from livepatch.
__rcu_read_unlock() is in btf_id_deny for the same reason.


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed..0e8afc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
 #ifdef CONFIG_PREEMPT_RCU
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
+BTF_ID(func, rcu_read_unlock_special)
 #endif
 BTF_SET_END(btf_id_deny)
 
Pls target bpf-next.

pw-bot: cr
