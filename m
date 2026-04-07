Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220733A9FF
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573454; cv=pass; b=QC7tBIYPMABeCXTeOgaHMQiDGOq62mQ/Ojkd7ilSlV5dgOJpSgmy5DkT7aYrnmnOPu2d8Z2WEov4zqZvhOmXcH5xHLNqGQX2sca7gKG0zQIJxRczsIaBDThRoAx/BhgDOgYu/SyY9iEHCmgch2g8PLB1Q27ndWCbiVGGCvL7QrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573454; c=relaxed/simple;
	bh=hG/FTwzy/ZE2SWNV7WriQV09KuIc7XMwXJVmR4rclLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a19e23MceWP31juF8Gdz2EwUGsD134zSP75MKmbqcjl7TpQ5Nbhw0MhMHx7IS/7xWq7Vjsmf4BlPsvb83QDVn76ng2eb7cx+suDNeARxuqCHTrAzJUdS8GBy4p0rEwzgbc3VhRNtTLUlCM0SO3P969GeKacOyw0J6oVgfTXzfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE0XifjP; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE0XifjP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so30108155e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 07:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573451; cv=none;
        d=google.com; s=arc-20240605;
        b=VsRKD7Sq96FReAFJinA1PMhjLsOsZlSdwJliWBz3GVCNSoqAs2pgizZEvO5X9Rsqhk
         3auaP6Y2wntE48vYPAeJIbh2+wJZOrPjlie6pTFPhFnS7b8cfTz8Accc2XfEegS/JTE1
         vXMM3X1ZeZaI6tr2zP0H/wncDDXXZB9B8/t4+66/+hF9SbRMl8I96IhwQSgf+RbTNEeu
         Ti9YbYl1z0rZ5iFWzQojATWKzFucU/KVrHhCT0HjcGusJV2tHu1g8eEFO0AIlLd5PaX4
         NtINwuMiYsaQUlLAjrgYStIvlID9GDp3csRQgvck40AAXv50x8xK7D7wGUHUnKRqH2FK
         5nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        fh=jYyNGIOWrhOeLf3d5GyCPlNdGdNW629kGq65oTvPEHU=;
        b=YosphyR31d/YzNVYk89ME/ka+w/O/RuFVoIXNiMOIbm+xlZjDaJ95WElyV+l5tTTYC
         l9wQ1QKq+YCxqeNRpAZr//94O7fDe9o7HW7WsWl0+lq5JstgZxpGzNcOy0TCPjNR/Cou
         Badpo50bUIrxcgmy+cgBgAebdRwrthrt+948qYHIfwrcpA3s7IFsuYCc2OflWrx3H/DD
         MTdKO6pv6AOGGXydQaxr3UVIbh1k+qQOU55Fy7z1veQzgKUF/f636L3t++t+xIAlxnj8
         NzW33SydWO1V2189bErbKB4NMT02Utiia681OfDqnAS/o2NgigFLjDJW9QMxTJRBZkCC
         n7eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573451; x=1776178251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        b=IE0XifjPI6pCdNxwwaV2KCkBy1PDjBAazo7B4h6NEDEwSLml8mO6kvC7CG5PYXQIif
         YntET/Kbc4f1VQtzRsAOH1QVSdJgjDeRBvWCyP4yEL8AREIrlBTAtAC23FqS9PrBWT/h
         6S4jSG6KzBOBGCsizeG0RBmlRe/jjyzRCeWmmr+bbHS2FtUBhdQt1qyjXAmrO3E8vd5q
         +VE+eAvZBOdNnjaWtB97OxBjfHcvfoiQnY6v7R6m88Ec9piMPlb82+C4RlHxpvtmk3Oh
         wiveOzkYuMladuysL+GjZFG0zExGXCTRl4XWltdnAqAUUWt8w40VHF/E3HADIJSgcCLr
         FwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573451; x=1776178251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        b=kZL0drwLaZK0dxMQjbat+3/wU39+YTRcyxnN5VGWZNKxwZ9uKeDl4J5JLhJ7FcZW/k
         a+1++1OzoOYkO3D4x0a7umG5zuSdD0xJetYFbVP1NugfdgXGaPHQF97RR300fbobMElb
         DaI2um7dIHEMYmsxTdlMuIbFJves4iXrNaAU5q/WJEYRnfVonlYFppQLHGSk0qr50/kg
         +anXJaqHah81xSX7i3jDdIhK7BzXHo3d0dTWvENXAFxRKSRAW0SXhAcSuw5BS7Vp2TaS
         QLIJQAxHEC3law6Y684vXXWtbDGZi3TsvHlptEqn1xiUgOcRPP9+hQLPDQTaB/z0M+Mz
         TtZg==
X-Forwarded-Encrypted: i=1; AJvYcCX05QzBdOmCR0R1/Yl7Q5vOPtTLt6+r+P+tlRyxVs2Hf3w8I3qLe2JGXGTouSv4T6MVjpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSvYv4GBn0615I7WRvwZZzqb/vfgo2h+R63oEuPU8w8PS9puu
	mIONo6uuOU/7y6I3DszcmJKn4n99Gh8iH8F0j8zr+/rm5zkLwmTicfp8QqgCJku2NL+pSyQ2WjH
	cwefeIpQUywIcMnBtCHu1zYjh/Llh9dY=
X-Gm-Gg: AeBDieuyJpIemMZJJtZJEYzTP/HVq65Vyts0G6qy/r93bRGyyWt5GYprZy1zbW3t+8W
	QSngcXRMYqmg82YmxTi5e6rjj0uYnC72kWCT+60t/UeVfSLWQvtv8HRo8sdcv8BTrJmvFoUZAjQ
	u1Ys3pLGky6Ku+dOWCqr5f7dGuLrZgchPjyzCD6MjqInY1StNsstjG4J9xD08hShORLRxHuex1U
	qdIoluMvGLdFn/cgqQ9UM+mw3i7hqvpzeC1hfesfXez+NxjFcjN+glJvgI79h9KMQRghVavvVo/
	zpwmt5Bg3PZieL4oo8PWNPYFoT6QtzjrbHbuJJBo2jwnytS+cplbvQaFS7Mv/v4XTAlVqHxVdEV
	PMDAA4ihLbmr82seZgDdf7dBf4LUtlbZ7MAfb
X-Received: by 2002:a05:600c:3f08:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-488996d2323mr285113035e9.3.1775573450574; Tue, 07 Apr 2026
 07:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-bpf_rcu-v1-1-fbc9398d05c5@debian.org>
In-Reply-To: <20260407-bpf_rcu-v1-1-fbc9398d05c5@debian.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 07:50:38 -0700
X-Gm-Features: AQROBzDp9hrsf35BhvzwwyjXQEk6_grrb8c07DLrm0nLORrAsgPCMCgQlbwgd2Q
Message-ID: <CAADnVQ+NBOORC510MWz1OAyWw=Xbg-LRYVFG56xR7BzH31VgfQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix suspicious RCU usage in LPM trie for sleepable programs
To: Breno Leitao <leitao@debian.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:48=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> trie_lookup_elem() uses rcu_dereference_check() with
> rcu_read_lock_bh_held() as the lockdep condition. This is insufficient
> when the lookup is called from a sleepable BPF program, which holds
> rcu_read_lock_trace() (via __bpf_prog_enter_sleepable) instead of
> rcu_read_lock_bh(). With CONFIG_PROVE_LOCKING enabled, this triggers the
> following warning:
>
>   WARNING: suspicious RCU usage
>   kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   1 lock held by .../...:
>    #0: ffffffff86ca5bd8 (rcu_tasks_trace_srcu_struct){....}-{0:0},
>        at: __bpf_prog_enter_sleepable+0x26/0x280
>
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x69/0xa0
>    lockdep_rcu_suspicious+0x13f/0x1d0
>    trie_lookup_elem+0x99e/0x9d0
>    bpf_prog_3980d36ecbef0e34_net_check_ip_pod+0x42a/0x510
>    bpf_prog_57df4ce643736a70_enforce_security_socket_connect+0x3e9/0x69e
>    bpf_trampoline_6442540179+0x60/0xf9
>    security_socket_connect+0x25/0x80
>    __sys_connect+0x15c/0x280
>    __x64_sys_connect+0x76/0x80
>    do_syscall_64+0xe6/0x930
>
> Use bpf_rcu_lock_held() instead, which checks all three RCU flavors
> (regular, bh, and trace) and is the canonical helper for BPF map
> operations.
>
> Fixes: 694cea395fded ("bpf: Allow RCU-protected lookups to happen from bh=
 context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> I've hacked a reproducer for this issue, and it could be found at
> https://github.com/leitao/linux/commit/59c83f313face36107ef1e8392e27b1cf4=
887b70
> ---
>  kernel/bpf/lpm_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d4..ac36063cb7e62 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>
>         /* Start walking the trie from the root node ... */
>
> -       for (node =3D rcu_dereference_check(trie->root, rcu_read_lock_bh_=
held());
> +       for (node =3D rcu_dereference_check(trie->root, bpf_rcu_lock_held=
());
>              node;) {
>                 unsigned int next_bit;
>                 size_t matchlen;
> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>                  */
>                 next_bit =3D extract_bit(key->data, node->prefixlen);
>                 node =3D rcu_dereference_check(node->child[next_bit],
> -                                            rcu_read_lock_bh_held());
> +                                            bpf_rcu_lock_held());

This is not a fix.
The issue is deeper than it looks. We discussed it before.
