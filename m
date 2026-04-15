Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22F3168E1
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229389; cv=pass; b=GkQcS+i6xtC2ZNC8pdvKLNa31ghTZF3ybMhr1sm+1r/7AqA9mVmy4P9M8wC+Q3KrzKQYc6JRBEcMfkQyo7XmVjNsyOfKj/2cA+1glk9s/L1qs33vrvlbtQLGuHzkt1ZztxsnoIqWNkztfBkdnNy+ou/3y7iEI7eLjJCakNcD6Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229389; c=relaxed/simple;
	bh=fGuuE8tUzF5eS1PAD+Ab0UOa4wxXcjrLg+nGVcrtBwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meEzZAYXjmFbslTHls8jGvVNZ3F5JXBnPGPdNRQMdYjc2wrN1qBZwscYogGN+KkpvW2/6z8cc5j0UO6FcnixRzL9abzaCpykpt0qYdehIjTyLHsGtcvGIvGg4rZ/K8DehxG16Zxx76vLZvUspcuZl7y45+AR/UdnZA9R4QQumJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzydE54M; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzydE54M"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c287eb77fso9965245c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229386; cv=none;
        d=google.com; s=arc-20240605;
        b=KEwlrvrAMADj94ZcJjTfrY7pX261SIGXuV57pRWitxJs14oaaFlTk3Ph/ATtS9sdqL
         wK+pwED35O5CQmC8W+Tp+3c7deUbwqsss+tM5qjnECmrpzoMN6exD4+yhNJAgB+nKVb3
         KWr1MyE7l8Gb8v0+ylCLtfBrT2m/qcuHja9EW3nkuXyO0OEVxPGUmUqIHjoow5FkvhMr
         IIKgTZFMvIvgaCUkW8HEmIV0aCSX3dh1ag4cdsrgxpjB+aB22RQiJV/1UbSykQFaxAlE
         lj4xo94gL0Wo61BhOB7NG7ZpZovlaUJio2OXLEoRILiL//uWKhj5p6KywlrDUXbC6dW/
         t8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        fh=SutEWVkyOHxljxMYuBDKk2qbE33ePvZ9JblLHkBHxK0=;
        b=e8a/X/JNDnLPou919py5Xh4JsVzstocJrLMNT6qeOGSRAciSoZ5pjudHRgZlT0oVHB
         072HvZ4VqQ4jVzhkUrTx1ziEoDjmIZvapSUluU76D952VCSDZFpUvCKpGEOtHztaKTT9
         jz7c+iRLrGT6rJ+zMRpRNl9osQwy/Y6MwBLbYJu+Jtd7F8y+SSBffBbjSqzUG8UFK+kq
         xZtSsEW7vlgoG/wUhNj6pt45EH5Ish3Pj/Mwz1JdmkdsS4cfaies7yzDEGP34JrHHeEB
         KHxCF2UGhttoNk6fKsu9n6sv3+nYYIQZR4OV7XN8qf/gtCub90vwgBlrxpXfjB0w1iyI
         OWnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776229386; x=1776834186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        b=FzydE54MCUpFwKefARAstG2UILU/+dVykGD6eTZm/Slstq6Sof5aWlljVGMkGNu4V6
         sx3ka9F0lYz08bWzSFN18xeLaLoF5HlHrOlX9Vm4tF1SVbN9w+7xPRKG15Ge4hLd2Nv5
         KDlhhu3B3YIaYnsH1VLcw8M0eftdCUcnILIhz0UJF+qmppTF9Xo+w1037NqQk6y2iBrG
         eLZtxODIDxAr4V0G522+pBplLL8c5P+0a4tMZYegBcnzAYqt6+Dq0A9K6WxNozZStsmf
         GEGbN/3StpTISrPNt9Ty2nwxGQTvfQ9cnbkfJcW/RM96wFSS7RYAgDkqKtR3e5Lp6ASb
         kLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229386; x=1776834186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        b=mur+IMm8/EAjAWozj2feRmJgW6HShJ5ihJWllXV+IXC0jT4Gr79aFOYjA6G15SIIft
         AdjYoSdn/ffz5lyMVWIVP7cmuh6aIglfJzJbRivEHMkPQ8Pld0W50bCy8XAgkLqkwB7j
         seaJ/iHPQdOblrDPvkz7E4GbPdbEnSbh04i+BdmeEMG27ln9tC1IlY3UmIAy+q/0za7B
         FKny1PZfb9SMuTW+jA+RW3owLWqsiE9G4OS+roO1vDvg6dsayJ72fkZGln3PLTY0BzN0
         0V4fka+AkQO7330xa142iFw38V+xfaZ0zyOnz/0sobGT8A5cani/zi/R/nGiSWbpHcdO
         FDEg==
X-Forwarded-Encrypted: i=1; AFNElJ8J4yEGEI80w3MZasJe2mHZuQJihShX/fMV4s/mBMGTSfpXt2zWzPGK9nSY/S1MLPDqHx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jZyMEvPC9FiuopC4f3FqaQXYA3Yncm1schYFTSMWIRjLCa87
	AjyRXrzo2x6Tc2YzMzH6lIEUFAHahIt6/GbtZogbPldRpMtDMAYIky2UI83EFyCppU8rObmS656
	VhWMp/T0/eu8Rs4/qdQQ5O2L5PUBmD6MY1Wbrxqc2
X-Gm-Gg: AeBDieukP+ilcy76Osx66uhNPufYjFwBd39i3esHcEDjcxIIlh1SqzOvdxDtSd4rU9v
	ox4Ky9UMkXyXs9R9NmiuWjKT1P+k8Fod463ERATgR4IcP6Jzf3YO72NCBspJ3gcV3TnjvfPQxDw
	5ZyegNN7Rui94u9SrJDjxXRiQvw1BrkTUjJzAX0XopMEnF6eA7bZt9JS662lwmvoU0KLsatzqKo
	rxdhC+bkyfhxnSXOeHk7n+dXw6eDZpGUuWeg014baI7vIiIpqAlqrO3sqIHf6kz7GqTMKn1swct
	WxNfFwMWgTBYHtM8R0jKcQdL+WkDRrOFimThcCvyBlCpn01Y2Mwdh0nvpuDOZAoxmCTMCSXsw2v
	6xK9T0ENMwtr1ap8piYDZTdbjuOo+qtdebKYFhN60tBs6PI3FAUqagiqcQaZhkcsTe7WzqjBtOz
	9TVFSrDRs8
X-Received: by 2002:a05:7022:faa:b0:127:3915:76b2 with SMTP id
 a92af1059eb24-12c34f07f1fmr11520144c88.27.1776229385519; Tue, 14 Apr 2026
 22:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
 <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Apr 2026 22:02:54 -0700
X-Gm-Features: AQROBzC61U2caASKHWRYjmp86WpWvwDPDOjBGrBWlvFKCfDox66DepDxhPOqVoc
Message-ID: <CAAVpQUBkq+wNSRiNLMKhpeY2AAZ48d9=hG9dWyGbf_MRS89-Mw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 5/5] bpf, sockmap: Take state lock for af_unix iter
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
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:13=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> When a BPF iterator program updates a sockmap, there is a race condition =
in
> unix_stream_bpf_update_proto() where the `peer` pointer can become stale[=
1]
> during a state transition TCP_ESTABLISHED -> TCP_CLOSE.
>
>         CPU0 bpf                          CPU1 close
>         --------                          ----------
> // unix_stream_bpf_update_proto()
> sk_pair =3D unix_peer(sk)
> if (unlikely(!sk_pair))
>    return -EINVAL;
>                                      // unix_release_sock()
>                                      skpair =3D unix_peer(sk);
>                                      unix_peer(sk) =3D NULL;
>                                      sock_put(skpair)
> sock_hold(sk_pair) // UaF
>
> More practically, this fix guarantees that the iterator program is
> consistently provided with a unix socket that remains stable during
> iterator execution.
>
> [1]:
> BUG: KASAN: slab-use-after-free in unix_stream_bpf_update_proto+0x155/0x4=
90
> Write of size 4 at addr ffff8881178c9a00 by task test_progs/2231
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe4/0x1c0
>  kasan_check_range+0x125/0x200
>  unix_stream_bpf_update_proto+0x155/0x490
>  sock_map_link+0x71c/0xec0
>  sock_map_update_common+0xbc/0x600
>  sock_map_update_elem+0x19a/0x1f0
>  bpf_prog_bbbf56096cdd4f01_selective_dump_unix+0x20c/0x217
>  bpf_iter_run_prog+0x21e/0xae0
>  bpf_iter_unix_seq_show+0x1e0/0x2a0
>  bpf_seq_read+0x42c/0x10d0
>  vfs_read+0x171/0xb20
>  ksys_read+0xff/0x200
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Allocated by task 2236:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x63/0x80
>  kmem_cache_alloc_noprof+0x1d5/0x680
>  sk_prot_alloc+0x59/0x210
>  sk_alloc+0x34/0x470
>  unix_create1+0x86/0x8a0
>  unix_stream_connect+0x318/0x15b0
>  __sys_connect+0xfd/0x130
>  __x64_sys_connect+0x72/0xd0
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 2236:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x70
>  __kasan_slab_free+0x47/0x70
>  kmem_cache_free+0x11c/0x590
>  __sk_destruct+0x432/0x6e0
>  unix_release_sock+0x9b3/0xf60
>  unix_release+0x8a/0xf0
>  __sock_release+0xb0/0x270
>  sock_close+0x18/0x20
>  __fput+0x36e/0xac0
>  fput_close_sync+0xe5/0x1a0
>  __x64_sys_close+0x7d/0xd0
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the fixes, Michal !
