Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988500;
	b=4sRqlTvbjtQA4AWTg1Qdt1sMVd1K7LIRzn5DT1Fw1qdtyXPTQ/rMETv4kAwFgQEhxKKH
	 H8HIX0NwATF8QI3zrEmZvfztQQYzsVr6HvOUeQvpynoY4Gd0qfOYJsZPwfUuBAtuEel1I
	 4RLyiMm8QaaOznAlNQaiud3yGv+I8Xmtz4zkPbK+Ja/AOISxCFx+4aVufUuU4ywHjvCve
	 vEitL+nF0gXv8XKkhNPYQ5ACCAm4+KjDop9VbrJtuvl1ZjCP9Q1FhiRWpLfFHJc4swCve
	 UE4IN/OaxqrN3vaDcCmeg/7PD2ZKDx8LYGD17n90YCfZ4A08aXXR6WWedIIzlF8TPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=y2wF0KFzbTLe+cqzFbIObBj2RjK9rW7cuVbUfbsAFSE=;
	b=jqZk6+f7/AbAQ8pTrEchkS58hBy+yrGmJOJUB4Ki/PVdxkUAYhh9uWToE2QnTcS4jLaz
	 jE84aJx2dpgHvlD4gBeKLGtz8NnoaI/MYkCO2MIm8fF/PWBQl0OaFMm+PdCnGxZFJIL+z
	 LYUYeUpW7dZOf/R/cOQNN3xuSUbfC3u1T4WQfSK3LSK8bQTLvR7atRr7HBqAWMpyY3wc9
	 AwK/jNq4pdvalA5k4Kt51wv7jum5N8MsQJRw/hPobgelEhuvuaLxMWog78v8E9tOghOiA
	 UOeNP7iJ9HUBEsbfkoxaMABKe/sORBU7gE6giZzkD1+ANrmLkbhdGAOxSitF0eaDtkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z530XT+x;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EB606D814
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819EB606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z530XT+x
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1208240eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988499; x=1794593299; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y2wF0KFzbTLe+cqzFbIObBj2RjK9rW7cuVbUfbsAFSE=;
        b=Z530XT+xR5lm7nOvFmjjQBynvV9sCjoUFRgIDimqpt9vI1Ts1frETBvfKxKnkJQkIq
         B6aNiWZxgpFviG8ebcSeQamz8nTNodLQM2fvoNF7cd1lqn79N0olGqKyhS5SHnuv0ygS
         97h8G7swfqelGUm959VQGssT/5udxz5mJesAEe6Wgwp3SPYVITFYxXkzwIYb9+fbsnpf
         FJLy0uRjNpp+FGkrdQTDl+Bfa7Nsx76PExyM0fEjPz/vDih6dF0ORrnXGDi8mR52SA9E
         D1O1h/FqGPzjxgLGnFF333ajMsxCTQ8EcUYb8L33beKVtfkzL5OqzWSdJAkthh0NgMX5
         zANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988499; x=1794593299;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2wF0KFzbTLe+cqzFbIObBj2RjK9rW7cuVbUfbsAFSE=;
        b=dfLNFcvaf8Bfp1twQeZPg9BeQZY7lvcyedWkGqvpqIegFF5JGFuRHIoPCwPwKxOVAj
         FFH1t/C+Z79LEF685p1f6WB9euYWKqbH1HBWUdm+zeEUlvDNPxhIODWLA0Ya4IVhlfT+
         Qiqg0SwWVs4zLVU1A4uhxreNK38iNCo2h7Ygz3HMtDsAnx+rhHb37/KZCNbb1LMMIc6l
         tFUMM84EsZxokC/guweQjNVFDUJJlVXdFPHdVKSIuCnmD1lxK+mq/L5U4YV+u8F9GbQH
         4PTvrxNlQwHDSn7Y5UlfkhaprXesYyvLCJDJUlWw39e0+84uDQZFAYkq7mKTfKaGjlZ+
         zBgg==
X-Forwarded-Encrypted: i=1; AL+hErEomilPIxlFq/IaOBBeBr1/znfx0vkRTY4DVVumMqpxm1Uzb8Zk7uuHrJMkdZtDoJvSFLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G39ZOiOIHbbxE5vpKueI2T7vQJMsuCQhNunzgnUricAhmFVEK
	GEjoj/lZ1HNil/btaxqiOVMUu5ftEbbwfp5vXbzs85EFUpw7+Quua+Mr5AmzBQdd
X-Gm-Gg: AYBFou0sbxFX0TI9cBR22OV1SudBaFfI9pIgCEjNGZvzjh+oIWgEDj454QZHmuFCgdJ
	47iEctzc0MKiEu83q2zCaXDAgGY3KZhphJOFsC7tfdalgbifoMgkMTjo7a0k1liM14ObeVZuE/g
	tFkqeQSBW+riLkLsWwYOk8vtCzT13igzr8QJ7gyVlQD1A1B6DoZGKNxNJSC4/z10p5fV3YbilZd
	huM6NrVSh/gEuPDSTepx9UB+eu+H2qID8JDmL3ueSdTYsUmROcRsiUYc4zctvHzh9/9lGd2B4sU
	0+EwxoIVy7g88xzjP0iMvN+EmIKV+Y6bTBGfWCykyiFR26xLM2p+RQUTE6uoPZP09qQoDvyuaRD
	oapIiqiEcwayED1LwX38/8K11q4iZeSah2EPqIkZvil8dMbVST+O8UUZdlcRVP+sNP9dJutBhZL
	/50p3whDzK1DS+4wlmY1OoUc1kx2lsQNMqlDLiTFAoAWc3eXahTwxFjGh6eJqMaUYQVQi+1Zm+1
	N80imn7Cj4RfdqbmSuxGvVJJ8pdHPDdclxPL/eu2trM6d2i7S4jAqG2lIll28dbXkeGpIfZiKDg
	TtcpQjXVU3vxaUnBYv3XC/bPFz/xvM8kyar2zkFU29PgApC3eXVxm4fAchmNGUidtB3M
X-Received: by 2002:a05:693c:68c3:b0:36e:2626:4ace with SMTP id 5a478bee46e88-36f7398b906mr4338097eec.5.1793988499062;
        Fri, 06 Nov 2026 10:08:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a::1c6? ([2620:10d:c090:600::1:7f98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm18596199eec.3.2026.11.06.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:08:18 -0800 (PST)
Message-ID: <6d9ffb229ca293c765fd550fb1e0ec988c26adb3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/45] bpf: A verifier that joins states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Fri, 06 Nov 2026 11:08:14 -0700
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-06 at 03:50 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> The verifier follows each path of a prog, and each branch can double the
> number of paths. The work grows with the paths, not with the prog:
>   insns processed                                    today    this series
>   rust-bpf  scx_beerland/beerland_init_task        1000001 *        17893
>   rust-bpf  scx_qmap/qmap_init_cids                 131088 *          196
>   scx       scx_eevdf/eevdf_dispatch                350041          15199
>   Cilium    bpf_host/cil_to_netdev, Oct 2026         64658           7472
>   * "BPF program is too large", "The sequence of 8193 jumps is too comple=
x"
>=20
> Authors cut their progs until they fit. Nobody can cut core, alloc and th=
e
> crates of Rust: of the 653 progs of https://github.com/4ast/rust-bpf 187
> load today, 170 hit one of these limits, 164 get "infinite loop detected"
> and 122 "recursive call". Now 648 load, and no corpus of C progs loses on=
e.
> For rust-bpf both kernels have 4 kfuncs on top, see Numbers.
>=20
> The idea
> =3D=3D=3D=3D=3D=3D=3D=3D
> Do not follow paths. Where paths meet, join their states: r1=3D1 and r1=
=3D5
> give r1=3D[1,5]. Repeat until no state changes. States stay apart only if
> they have no join, or if a later check depends on the difference.
>   loops      counted by scalar evolution: one state covers all iterations
>              walked: a state per iteration, while constants decide an exi=
t
>              all other loops: join at the head, widen, add may_goto
>   subprogs   A static subprog is verified for the states at its entry, no=
t
>              for each chain of calls. Recursion is the same, with widenin=
g.
>   run time   may_goto limits the time of loops and of recursion. r10 limi=
ts
>              the depth: it must be in the upper half of its kernel stack.
>=20
> What users see
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  - The limits of 1M processed insns and 8192 jumps are gone. The limits a=
re
>    on states, for a prog of N insns: 1024 at an insn, 16 * N + 4096 at
>    a time, 256 * N + 64K in all.
>  - "infinite loop detected" is gone: the verifier adds may_goto. A loop
>    that has no exit gets "loop at insn N never exits".
>  - may_goto is also added to 5 progs of the table below that load today:
>    loop1, loop2, loop5, tcp_autolowat_enqueue_rcvq (GCC), chaos_enqueue.
>  - Recursion is allowed on x86-64 and arm64. Patch 22 lists the exception=
s.
>  - All added may_goto of an invocation share its time slice of 250 ms. Th=
en
>    the prog returns 0. A subprog that cannot unwind, or a frame that hold=
s
>    a lock or a reference, leaves the loop. The stderr stream has the caus=
e.
>  - A join loses the relation between scalars. This is rejected now:
>      if (c) { i =3D 3; n =3D 4; } else { i =3D 7; n =3D 8; }
>      x =3D arr[n - i];                                    n - i is [-3, 5=
]
>  - A cgroup_skb prog whose r0 can be 2 or 3 attaches to egress only. That
>    holds for a range too: 'return 1' and 'return 2' are joined to [1, 2].
>  - The log has no "mark_precise:", "N: safe", "depth=3D" and no scc colum=
n.
>    Level 2 shows "from 13 to 9: within", "joined" or "widened" where stat=
es
>    meet. The statistics line keeps its format: "limit 0", "mark_read 0".
>  - BPF_F_TEST_STATE_FREQ is accepted and has no effect.
>=20
> Numbers
> =3D=3D=3D=3D=3D=3D=3D
> A: bpf-next 8424858a5de0. B: this series, the same objects. The selftests
> that the series adds or changes are not counted. None of them is lost.
>=20
> Corpus                 Progs  Lost  Gained  Insns  States   Mem  Time
> ---------------------  -----  ----  ------  -----  ------  ----  ----
> selftests               3043     0       1   -63%   +120%  -18%  -27%
> selftests, no_alu32     2905     0       1   -66%    +86%  -27%  -34%
> selftests, cpuv4        2914     0       1   -64%    +96%  -27%  -32%
> selftests, bpf_gcc      2733     0       5   -69%    +96%  -16%  -24%
> 37 builds of Cilium     5189     0       0   -75%    +11%   -6%  -31%
> sched-ext/scx            495     0       0   -89%    -34%  -66%  -67%
> scx, as BPF CI has it    428     0       0   -85%    -22%  -38%  -39%
> tools/sched_ext          240     0       0   -69%    +37%   +3%  -11%
> public progs of Meta     511     0       0   -85%    -35%  -55%  -48%
> all                    18458     0       8   -74%    +10%  -19%  -36%
>=20
> Progs load in A and in B. The per cent compare sums over these progs:
> 75.1M -> 19.2M processed insns, 61 -> 39 s. Mem is mem_peak of veristat.
> Time is the best of 3 runs on kernels without debug options. B counts eac=
h
> state that arrives at a basic block as a state, A only those that it save=
s.
> Gained: loop3 in the 4 builds, 4 progs that A rejects only in GCC's code.
> Of the progs that take 1000 insns or more in B, two take over 5% more tha=
n
> in A. loop5, 82 -> 4182: a walk up to its limit of 4096 insns, then a joi=
n.
> res_spin_lock_test_held_lock_max, 2356 -> 4088: states that hold differen=
t
> numbers of locks have no join.
>=20
> rust-bpf               Progs  load in A  load in B  B: insns   time
> 16 schedulers            225         52        225      1.6M  1.9 s
> crates                   428        135        423      7.3M  9.4 s
> For rust-bpf A and B have the kfuncs of patches 30-31 of [1] on top. They
> are in no series now. No released compiler emits the code of rust-bpf.
>=20
> How to read the series
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Start with patch 7, the overview. Then 4-5, 13-14, 15, 17 and 19.
>   1-2    what is added to a prog: may_goto, the checks of recursion
>   3-5    union and widening of a range, join.c: the join of two states
>   6-10   data structures of flow.c, passes ahead of the main pass: order =
of
>          the insns, places for may_goto, what later checks depend on
>   11-14  the sets of states, iterations, what is not joined, the merge
>   15-18  how states move: edges, calls and exits, loops, added edges
>   19     the switch. The check of one insn against one state is the same.
>   20-22  more counted loops, static subprogs on their own, recursion
>   23-26  removal of pruning, precision tracking and SCCs: 3382 lines
>   27-28  callx: a pointer to one of a set of functions, live registers
>   29-38  code that needs more than that: casts, the context in a struct,
>          subprogs that check for their caller, loops that are not counted
>   39-45  selftests: 39-40 adjust tests, 41-45 add tests
> Each patch builds. Patches 1-18 add the code that patch 19 switches to.
> Some selftests fail from patch 19 to 39.

Hi Alexei,

regarding the Meta veristat failures. Please find distilled examples here:
https://github.com/eddyz87/bpf/tree/ast-new-verifier-v3-meta-tests
Applied as commits on top of your series.
All slop but seem to add up.

...
