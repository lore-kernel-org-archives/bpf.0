Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBC33985
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229259; cv=pass; b=J0tx7CjQjk9aRww2rq8fkX739/MWMCtkSSNUBDRdgeP+y38vF0/o/1Nm+72JqJhSwwl2OpW638NBTMFwiv4sU6Iuy3qIK6wdoKJggYkxSXfmCgxgIb6ixavJYgViinQn4KOXaBnc36mXFmYdleBTovhEjy7WBadPKU0A3H48fFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229259; c=relaxed/simple;
	bh=iARNUFYTd4dj8+/SIL/3BEFx0kzLTv6bCmdBPSVF9DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S25cefrbSBU4Fk+IJLB5BWhfO3RNKA5sKoYL3mq+MdcfNzhb8KtYPOPi44ZFiX46iTIPgJMzv+YpJt8O2b1YzkFmeBr6JXE80zWbbLU4U33TrZabiXevM1vcqMpIs+R//OaoR+5nSkxyke8wN888q36XX2gW7Gc2LL/SwCpfxTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u02J/6mE; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u02J/6mE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c55e3858cso3827173c88.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229257; cv=none;
        d=google.com; s=arc-20240605;
        b=YeTbbxYcvGfIc21Ea0HwQB4JP+bmWPzyNQ5gVcxa+qiReyhNtNF/h1gD28VQtCPRu8
         eug6yCO5TN+vYeDAKb2uG6OO3hrKTxkRckWtHmOY/y+1oEGFLBPShqPFFN/m2wLIHAtR
         AnHywhqhExrmrTq4kBGlC7/UiyNiZT4UK2vaS6+4XmxvCKTfJ1CKYTUNAofOZ01EEYcf
         nxJhjLi8GZbzh7bcT92ZKcxf31pUWqPKCWzK1GrP6yRcLwoAR2jS481X4yE/t9Ff01GB
         t3CNcUiHVDCJmJuNPyxLW5D/LiLE0wsw2KbREkiysS6VTrJdIfnbDEY/VWFHP6BqxTKQ
         JUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GfN9XFLS1jrFAoqXv2jwmOiKUfihDC6hceC1zKVNm28=;
        fh=M3XrL9QhTNENUwPWWf3Esz0Zr4Zfkel+qhlw/5ysuEk=;
        b=e6KOhQrY6K1hbMipaOGvN5qhrDdJTq8oJASwGv/DL6EsnZtSEqwTIn7DUuPEwmz2cM
         6anC+r96eO+p8JObEO5J0uhJDJTJ21PmZYr+g1O0WbZaY7k/RWh/IekOTAi0NUjCJBOV
         Hu2pNnjdrSPeLB+CbyDDvBtfqND7O9SMwOsb2EVq+VMqd23rsBbfJ5R8Hx7j5QxL8AoZ
         N857s6mrTvRsfFAoJPx5X2G3j72G8uXOkDbjuUOzwPiluJk4T/fmU7JGQJD8plRDZWJ9
         Bm2MmUx3gvHK/Z/AePofUJ1kGQve3euoxMmgUfkEialQRtWG/FbkvxxrNS2NtcKEGmLk
         rWIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776229257; x=1776834057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfN9XFLS1jrFAoqXv2jwmOiKUfihDC6hceC1zKVNm28=;
        b=u02J/6mEPs96PG6qek3LI7PqvfV5+FNSKYG2nIBYNWrIC14JMaPsHYH8j0M4WmftAV
         bUXc+/2mrVAkWv+WSMkY/tfrodaSQksvpdwQcqHe84ASZofsHiBGAoz+GKEs7V2sMsut
         hiatj4rAHf3jgYvkHJoquQP5clTuFInejztBv6ga8g4KqQ1NcCywPrzHYnHIc+bK9rls
         2ua8n4sOn9uRQpV3fSZgEqXC9tFO+tjkUGoWwmDKpZW2JaN5AuXuxCz8KEkCtwGaNtgy
         6LK7py567+XjDMqEKbf15RAabFfAjKQXN2WtfFSX7V6iX7e2OYgrJB28FpoelrdjbI0k
         /nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229257; x=1776834057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfN9XFLS1jrFAoqXv2jwmOiKUfihDC6hceC1zKVNm28=;
        b=soB0Izer2/yHSxTKZar9IxrpFvD3NJxHL42Y1kNSXw34C4W029VJNIe4SitVZwuslH
         wZ2fFpY3qM51+VUhMi65W1uYRt6N8oO8dZvL7EiFvBMX3IQgFS9F+WGMqwVg7bYoYFcN
         FiOUQ46Kc680PU15ej9U6Xs7R9Oz00HrBdPPm5LQLY9dp+SxXVfKDJhcjelCkmLa7VJ3
         bJhILJrpAOJU5lwMVFs6GY/3ZnKJZj2t5l80zNkEb/xTbalh8Ch8kioGuQZ8qNT0w50L
         xKIJ/hOMLZ8eMNi5Ix7eABAGwhshoybkL1R/4XDmyVVgQCK7lomYpLNotwzdqo/MSblo
         0eqw==
X-Forwarded-Encrypted: i=1; AFNElJ9+ObufNSMvF6fyTG0UI1yNngKNIWc2NvXYb+GTvJbs+aAhDAxBgnzXi+1HqQTqzZHPg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGMZI4pfWUTluDig+0gX8V9FaiF+tP5w7OUSleamDvW+60la5
	1WnGnUddL3rwQGsI1fNLW+QJ3AJ/WDpaIIfQw7paIfp97aKNxEdTpnfxWHD24zuS8ctGxhS2aXP
	wmbDTr3XntWkmV6KiA7rovak7VdwRl7OEOydlY0vB
X-Gm-Gg: AeBDieuOfiAiT0ZKtxOMis2TKs0LuZ1o6JO2t06EO6tfM6MX2faqDW30Ww8+LxOwoFN
	nIvKveyuZpLw9RQ3Dqz5/x+gdaY23OYSzlmiM6Xq5ak/9GoCQyCP/cmyDVzizXB5u1rnzpe7zpL
	P/HItoRLzWTP/x0OGEXkuZ6Cbh3abZu1/aZSEmOajQQIqu8A62jVMlzwdoVV+OBMf5JdhQcPhPR
	cKKwdAUA+KnSXiYpDD9HMBIa55FIvPqiR06GvFhID4lL8fP/k9zXcpHpWJYgPx0UBNApkz8bxHe
	VLlwh6vw31rV8H0KKlAnYwsltiLevojTi2iBwqJorCig7Cx2PHnG44pI3IwuqjGi+8Nvf3eMSfw
	8t5jmdCUIWoNoIzSncXucpW4a5oaZpc8FupN50+s426fr8wptbuukxrhwdmVnN61sV5oDR4uq3A
	==
X-Received: by 2002:a05:7022:4a6:b0:12a:6ab7:3f8a with SMTP id
 a92af1059eb24-12c34e92e4fmr11703518c88.3.1776229255880; Tue, 14 Apr 2026
 22:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
 <20260414-unix-proto-update-null-ptr-deref-v4-4-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-4-2af6fe97918e@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Apr 2026 22:00:44 -0700
X-Gm-Features: AQROBzCWcyEBGthSHzBjkSwXGQp6W8v2k1tUqmhXgWoT9GrpDaf9gxEIpJdb0bU
Message-ID: <CAAVpQUCnLtJmBZ3-KGxUMpvtO0aS-tQH9G-7yv4rXMooxDpCjw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 4/5] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:13=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) =3D newsk`)=
.
> sk_state =3D=3D TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe=
 that
> socket is properly set up, which would include having a defined peer. IOW=
,
> there's a window when unix_stream_bpf_update_proto() can be called on
> socket which still has unix_peer(sk) =3D=3D NULL.
>
>          CPU0 bpf                            CPU1 connect
>          --------                            ------------
>
>                                 WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair =3D unix_peer(sk)
> sock_hold(sk_pair)
>                                 sock_hold(newsk)
>                                 smp_mb__after_atomic()
>                                 unix_peer(sk) =3D newsk
>
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
> Call Trace:
>   sock_map_link+0x564/0x8b0
>   sock_map_update_common+0x6e/0x340
>   sock_map_update_elem_sys+0x17d/0x240
>   __sys_bpf+0x26db/0x3250
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Initial idea was to move peer assignment _before_ the sk_state update[1],
> but that involved an additional memory barrier, and changing the hot path
> was rejected.
> Then a NULL check during proto update in unix_stream_bpf_update_proto() w=
as
> considered[2], but the follow-up discussion[3] focused on the root cause,
> i.e. sockmap update taking a wrong lock. Or, more specifically, missing
> unix_state_lock()[4].
> In the end it was concluded that teaching sockmap about the af_unix locki=
ng
> would be unnecessarily complex[5].
> Complexity aside, since BPF_PROG_TYPE_SCHED_CLS and BPF_PROG_TYPE_SCHED_A=
CT
> are allowed to update sockmaps, sock_map_update_elem() taking the unix
> lock, as it is currently implemented in unix_state_lock():
> spin_lock(&unix_sk(s)->lock), would be problematic. unix_state_lock() tak=
en
> in a process context, followed by a softirq-context TC BPF program
> attempting to take the same spinlock -- deadlock[6].
> This way we circled back to the peer check idea[2].
>
> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@=
rbox.co/
> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.=
com/
> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@=
linux.dev/
> [4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1N=
vhOhU=3Dj+35+3og@mail.gmail.com/
> [5]: https://lore.kernel.org/bpf/CAAVpQUAHijOMext28Gi10dSLuMzGYh+jK61Ujn+=
fZ-wvcODR2A@mail.gmail.com/
> [6]: https://lore.kernel.org/bpf/dd043c69-4d03-46fe-8325-8f97101435cf@lin=
ux.dev/
>
> Summary of scenarios where af_unix/stream connect() may race a sockmap
> update:
>
> 1. connect() vs. bpf(BPF_MAP_UPDATE_ELEM), i.e. sock_map_update_elem_sys(=
)
>
>    Implemented NULL check is sufficient. Once assigned, socket peer won't
>    be released until socket fd is released. And that's not an issue becau=
se
>    sock_map_update_elem_sys() bumps fd refcnf.
>
> 2. connect() vs BPF program doing update
>
>    Update restricted per verifier.c:may_update_sockmap() to
>
>       BPF_PROG_TYPE_TRACING/BPF_TRACE_ITER
>       BPF_PROG_TYPE_SOCK_OPS (bpf_sock_map_update() only)
>       BPF_PROG_TYPE_SOCKET_FILTER
>       BPF_PROG_TYPE_SCHED_CLS
>       BPF_PROG_TYPE_SCHED_ACT
>       BPF_PROG_TYPE_XDP
>       BPF_PROG_TYPE_SK_REUSEPORT
>       BPF_PROG_TYPE_FLOW_DISSECTOR
>       BPF_PROG_TYPE_SK_LOOKUP
>
>    Plus one more race to consider:
>
>             CPU0 bpf                            CPU1 connect
>             --------                            ------------
>
>                                    WRITE_ONCE(sk->sk_state, TCP_ESTABLISH=
ED)
>    sock_map_sk_state_allowed(sk)
>                                    sock_hold(newsk)
>                                    smp_mb__after_atomic()
>                                    unix_peer(sk) =3D newsk
>    sk_pair =3D unix_peer(sk)
>    if (unlikely(!sk_pair))
>       return -EINVAL;
>
>                                                  CPU1 close
>                                                  ----------
>
>                                    skpair =3D unix_peer(sk);
>                                    unix_peer(sk) =3D NULL;
>                                    sock_put(skpair)
>    // use after free?
>    sock_hold(sk_pair)
>
>    2.1 BPF program invoking helper function bpf_sock_map_update() ->
>        BPF_CALL_4(bpf_sock_map_update(), ...)
>
>        Helper limited to BPF_PROG_TYPE_SOCK_OPS. Nevertheless, a unix soc=
k
>        might be accessible via bpf_map_lookup_elem(). Which implies sk
>        already having psock, which in turn implies sk already having
>        sk_pair. Since sk_psock_destroy() is queued as RCU work, sk_pair
>        won't go away while BPF executes the update.
>
>    2.2 BPF program invoking helper function bpf_map_update_elem() ->
>        sock_map_update_elem()
>
>        2.2.1 Unix sock accessible to BPF prog only via sockmap lookup in
>              BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_CLS,
>              BPF_PROG_TYPE_SCHED_ACT, BPF_PROG_TYPE_XDP,
>              BPF_PROG_TYPE_SK_REUSEPORT, BPF_PROG_TYPE_FLOW_DISSECTOR,
>              BPF_PROG_TYPE_SK_LOOKUP.
>
>              Pretty much the same as case 2.1.
>
>        2.2.2 Unix sock accessible to BPF program directly:
>              BPF_PROG_TYPE_TRACING, narrowed down to BPF_TRACE_ITER.
>
>              Sockmap iterator (sock_map_seq_ops) is safe: unix sock
>              residing in a sockmap means that the sock already went throu=
gh
>              the proto update step.
>
>              Unix sock iterator (bpf_iter_unix_seq_ops), on the other han=
d,
>              gives access to socks that may still be unconnected. Which
>              means iterator prog can race sockmap/proto update against
>              connect().
>
>              BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0=
x253/0x4d0
>              Write of size 4 at addr 0000000000000080 by task test_progs/=
3140
>              Call Trace:
>               dump_stack_lvl+0x5d/0x80
>               kasan_report+0xe4/0x1c0
>               kasan_check_range+0x125/0x200
>               unix_stream_bpf_update_proto+0x253/0x4d0
>               sock_map_link+0x71c/0xec0
>               sock_map_update_common+0xbc/0x600
>               sock_map_update_elem+0x19a/0x1f0
>               bpf_prog_bbbf56096cdd4f01_selective_dump_unix+0x20c/0x217
>               bpf_iter_run_prog+0x21e/0xae0
>               bpf_iter_unix_seq_show+0x1e0/0x2a0
>               bpf_seq_read+0x42c/0x10d0
>               vfs_read+0x171/0xb20
>               ksys_read+0xff/0x200
>               do_syscall_64+0xf7/0x5e0
>               entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>              While the introduced NULL check prevents null-ptr-deref in t=
he
>              BPF program path as well, it is insufficient to guard agains=
t
>              a poorly timed close() leading to a use-after-free. This wil=
l
>              be addressed in a subsequent patch.
>
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a3=
2e@rbox.co/
> Reported-by: =E9=92=B1=E4=B8=80=E9=93=AD <yimingqian591@gmail.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
