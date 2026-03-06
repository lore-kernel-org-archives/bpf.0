Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD23783C2
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785662; cv=none; b=GfIfXyQ9n3aId4TaHVhJNNPgFuXslgNu1y/d579dV0RhzzIKPGBGeqqsk6MV8OOPetG5nSToWZazA6ZMHNl8zNnCt1vlwAl6cLK1JLFjRCIXP5zzG8HOSrFdfThqqTui2JwR7Xp1IHLfw8Enkoc0O+rKF5ldH70C+sS3z0c7pVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785662; c=relaxed/simple;
	bh=yslu5RPnNhzci89rFmpdvxsiq/g3xBp99ex2GB+gSCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Od2dgJMwTt0RrH64ilOJcPtsicNAvHdyaelHyU5hvkAz6avHUCWBKpuuVr/Ftkvus7cIol1eWuiJa18C1HkfvMQ8u5TDdbnBHBHDelCQDOI99LXE/fgFqyQEkMxlKS18Fq8H1M1MA1MKmrUJMJ5mpjP0tUKiu7tv78SBLY95ZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuZTBP26; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuZTBP26"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb513e860cso919072085a.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 00:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772785659; x=1773390459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hCukL+6ccg+w5dUM3YaotXteECvpZxzoyeu3ZQhWdo=;
        b=kuZTBP26uVN1n2Qg9LN/KHZknipXlPLMX6s1+dzzG7VUXmNrF/uBH3Qwed1ENRyClf
         oNjomH52GI0u3VGf3qmrComDyKshbnx2KPuQ+yAaOwfqry88KZab4KkCJ8BWiqf6wliI
         lVLnGHjjTMt89HLJm2Qxlcjx1v6pZwmX100hBi0ug97rqPTE4fArLX2x5X1bY9atJVsB
         YV8tngZgmZvf5gnoBgwhJhzPDyy04M9Dkb6D03evMxNIG2AkQffn4cRCK8oq8y7QeepA
         ohNEEYVNhbT4uuJME/YDEiPrVNkh0Oib/6AsLMu5ttOrR98tzl2Jo2ym/4haGXG6z40a
         4vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772785659; x=1773390459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hCukL+6ccg+w5dUM3YaotXteECvpZxzoyeu3ZQhWdo=;
        b=eCXsqfHMJd8lDV3+cWLQIAuMtPMMB+ORybPRf15nQOFFXI+cXwooXPo7B4yzcPwxas
         BAi60VC0h1ddKO5MTmDhuN0vBXdsb9ajEMJEW+vkuR0HI4VIwU8bkbed92NLEutAYeaj
         Dg+mlxhF2cUVtXtHhP9xppXoiQlaIDuyBnt9bigY4NgK4ZsOCQ8Q6PE5BBaCXDsJV/lr
         uJZf6wvi4dJJ5VIcrI23dStKzEok7Q+QA78Bd/DReI8ac004W5uKH8Zl+NNXUaLczHP2
         TZMbI2cFi7pMgTRT3K+VHhxYHKyT1o7P4dPDQsOjhPxZOj1DQ2IbqR39tFIFNLN8c9gG
         j+UA==
X-Forwarded-Encrypted: i=1; AJvYcCUHFy6EHV6ZwKeFv3+pvQw8ahMrSnHFrXAK1dhNHNUHBq5mMneAJ6eSzvQGsRnwvZUOJ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz043pXHkNReTIUtt2T23iYEAlDN9SgS/eCBl+hkNKjdYRK171B
	lZcPA/dvPENRRwWvS8zhLGpsdsOvQe1T+EeYDOEMscwjnl3wVKEuL2np
X-Gm-Gg: ATEYQzygk6Vw4zckh1bkK9f5OzCYAPjWEcDtN5OlLK76d5/7vdg/7zVwmJKqRlX9zZ/
	MCBuv5AXOz9tVwQTLRNasFaWRbQeh2RxboIyuoz/QIyI1/N/jGU0VLyC4bth8eE7so8zQqcvdxi
	eiGf+zizTrg/7OnytStQ97tza0/Cz71qZWHO/HXN5Nv2wKJMNLJl+x/lrxzZNkCYpND/ODix79G
	IUF+SNb1VLkKJBs2tI/f6vp35BrVr1JsDA0/doCRnGRv0IDRMAijKVOX8wCqUBTOzd/xf72lRzu
	iq4YygBkBMBxxvL6KqNrSYJo/sayo78naIepCnQ2DVvwzHarYNT/YkLvkLGUWW+iiBfUmvwjG4A
	W5T87YESLh8HqwWp+QZm3fn6TUj4SuLg0iLRdoGRbu2CfW1PHm/ChMf1s0MFT2jjN7UMXk7Kb71
	tb9S0pOZ9YQ56Q9pUmhzqUO6/jQ2Nz9F6kPzyiF1lMRxSKCYIu4iIE
X-Received: by 2002:a05:620a:454d:b0:8c7:768:3b0b with SMTP id af79cd13be357-8cd6d4886c4mr161908785a.65.1772785659343;
        Fri, 06 Mar 2026 00:27:39 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4ab73dsm53086885a.20.2026.03.06.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:27:39 -0800 (PST)
Message-ID: <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: Eduard Zingerman <eddyz87@gmail.com>
To: Levi Zim <i@kxxt.dev>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Fri, 06 Mar 2026 00:27:35 -0800
In-Reply-To: <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
	 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 16:20 +0800, Levi Zim wrote:
> Hi Eduard,
>=20
> On 2025-12-30 15:13, Eduard Zingerman wrote:
> > This is a correctness fix for the verification of BPF programs that
> > work with callback-calling functions. The problem is the same as the
> > issue fixed by series [1] for iterator-based loops: some of the states
> > created while processing the callback function body might have
> > incomplete read or precision marks.
> >=20
> > An example of an unsafe program that is accepted without this fix can
> > be found in patch #2.
> >=20
> > There is some impact on verification performance:
> >=20
> > File                             Program               Insns (A)  Insns=
 (B)  Insns      (DIFF)
> > -------------------------------  --------------------  ---------  -----=
----  -----------------
> > pyperf600_bpf_loop.bpf.o         on_event                   4247       =
9985   +5738 (+135.11%)
> > setget_sockopt.bpf.o             skops_sockopt              5719       =
7446    +1727 (+30.20%)
> > setget_sockopt.bpf.o             socket_post_create         1253       =
1603     +350 (+27.93%)
> > strobemeta_bpf_loop.bpf.o        on_event                   3424       =
7224   +3800 (+110.98%)
> > test_tcp_custom_syncookie.bpf.o  tcp_custom_syncookie      11929      3=
8307  +26378 (+221.12%)
> > xdp_synproxy_kern.bpf.o          syncookie_tc              13986      2=
3035    +9049 (+64.70%)
> > xdp_synproxy_kern.bpf.o          syncookie_xdp             13881      2=
1022    +7141 (+51.44%)
>=20
> I see that the first patch in the series causes some impact on=20
> verification performance.
> The patch contains "Fixes:" tag for two commits that landed in 6.17 kerne=
l:
>=20
> c9e31900b54c ("bpf: propagate read/precision marks over state graph backe=
dges")
> 96c6aa4c63af ("bpf: compute SCCs in program control flow graph")
>=20
> I have a BPF program [1] that is badly affected by the patch that it no=
=20
> longer loads on 6.19.5 due to
> E2BIG error.
>=20
> The program consists of multiple nested bpf_loop calls as follows so I=
=20
> think the impact on it is expected.
>=20
> (entry point) func trace_exec_common
> -> (bpf_loop) callback read_strings for reading ARGV
> -> (bpf_loop) callback read_strings for reading ENVP
> -> (call) read_fds
>     -> (bpf_loop) callback read_fds_impl for iterating over the fdset
>        -> (bpf_loop) callback read_fdset_word for reading a single word i=
n the fdset
>            -> (call) _read_fd for getting information from a single fd
>                -> (call) read_send_path which reads the absolute path and=
 mount info
>=20
>=20
> After the patch, I find that I need to comment out the=20
> bpf_loop(BITS_PER_LONG, read_fdset_word, &subctx, 0)
> statement in read_fds_impl function to make the eBPF program load.
>=20
> Does it mean that after the patch, the verification performance degraded=
=20
> significantly compared to older
> versions of kernel, e.g. 6.6 LTS? Or is it that older kernels are also=
=20
> impacted with the same sort of bug and
> currently waiting to be fixed?
>=20
> I am also exploring ways to fix my bpf program so that it could work on=
=20
> 6.19.4 and later kernels.
> It would be greatly appreciated if you could share some insights for=20
> fixing bpf programs that are badly
> affected by this patch.

Hi Levi,

I'll take a detailed look tomorrow, but am curious if patch-set [1]
helps with your program? As far as I understand it is not a part of
6.19, as it was not marked as "fixes".

[1] https://lore.kernel.org/bpf/20251230-loop-stack-misc-pruning-v1-0-585cf=
d6cec51@gmail.com/

Thanks,
Eduard

>=20
> [1]:=20
> https://github.com/kxxt/tracexec/blob/main/crates/tracexec-backend-ebpf/s=
rc/bpf/tracexec_system.bpf.c
>=20
> Thanks,
> Levi
>=20
> >=20
> > Total progs: 4172
> > Old success: 2520
> > New success: 2520
> > total_insns diff min:    0.00%
> > total_insns diff max:  221.12%
> > 0 -> value: 0
> > value -> 0: 0
> > total_insns abs max old: 837,487
> > total_insns abs max new: 837,487
> >     0 .. 5    %: 4163
> >     5 .. 15   %: 2
> >    25 .. 35   %: 2
> >    50 .. 60   %: 1
> >    60 .. 70   %: 1
> >   110 .. 120  %: 1
> >   135 .. 145  %: 1
> >   220 .. 225  %: 1
> >=20
> > [1] https://lore.kernel.org/bpf/174968344350.3524559.149065470295517370=
94.git-patchwork-notify@kernel.org/
> >=20
> > ---
> > Eduard Zingerman (2):
> >        bpf: bpf_scc_visit instance and backedges accumulation for bpf_l=
oop()
> >        selftests/bpf: test cases for bpf_loop SCC and state graph backe=
dges
> >=20
> >   kernel/bpf/verifier.c                     | 13 ++++--
> >   tools/testing/selftests/bpf/progs/iters.c | 75 ++++++++++++++++++++++=
+++++++++
> >   2 files changed, 84 insertions(+), 4 deletions(-)
> > ---
> > base-commit: f14cdb1367b947d373215e36cfe9c69768dbafc9
> > change-id: 20251219-scc-for-callbacks-d6d94faa2e43
> >=20
