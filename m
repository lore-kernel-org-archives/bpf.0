Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609A384CCB
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478637; cv=pass; b=HiAuJ/91nZvWArUYYgXZNwBChKITf91kMvGnsAR9nRUAnSpvjcnIOyRdJt6Z0KlO8LA05WcUB7pJmiXW30nZvksuVNxdi5mI8e34jS+0UayBpAYq2oJGA0QyuKFYs9byAIMtS+bJ0dzTTAEiwinNK6gPoTvgxhDWdayp32INxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478637; c=relaxed/simple;
	bh=EealUt9yiKAPBbty3N6lJ+RKIaJuWiPigp/WfkIyv8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiAAaxlpaUSrRPKop2j4sa1FSaYwxTjvAK0VYprn1XUKSPINg2ymRDW5IGZ8dN8zLw+P0MUJrv5hCI+yOL6eMDD1UXYi3qA9gDbMhvOcT8Yt2j3nVuee+/r3jcJtqg8n+8Bx+SvdTEHtFBz4iKrMTBV5zbGTmIerW+mtzpl0JqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXSLyyja; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXSLyyja"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4c9859ea2ceso3414776b6e.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 09:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791478635; cv=none;
        d=google.com; s=arc-20260327;
        b=sy5q4IgVOzCMIM+cORE9iet4bC7f85UHA6KppQ5RL/KC9SdpgKhv8oph32X37qTUPN
         Cb4t1fOf2P94fXiHNOInqYH5yHkzEhngRR6FI6ukrGAcCMQK2QZq7TbyEAQZpCnFtE2I
         IR6+gMb8CzPN//cEp0Y6Q8pJKQjbDwIdt6Q/f2/FfiwiMLdqNVpe7X1Ia9p/RRuY6PCx
         ODCLefqe2+FIkeruRVEJwXo7+JRxRB272XxQdaewEE+Yjf26IrjSqrnu5kMUrB2e00eW
         YInB9XR88mGXL/MNilKX7gwR0GTAsKwaqXKwIifvsV95SLoRWdcxTwtD5+TrKKOkwF/s
         Fovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        fh=absG67w/qNTYqFm1xmP+YfnRFTOF1KixtsW9/EsWzdQ=;
        b=Di6qpWP+RW+B8pLCLD3mAIh9D9/SLhm9eR1I4zSO4+ZNDLU8yu1Z6s5uYx06/rDwnY
         dD7rDfY75leDit64GtVUswYth7srJwTuBEZrMMXiCpyNlOmE8U33bDeO2TM8HOXZU1iR
         jNvM7J6ZXssH7OlmDK9Ss4VWiGwNxUvyP7NMJYwOTwdlxKl3Hb6PWvTLYrBk+nQWeaCk
         C0SeAHsFBhWn7AdP90hrtTxASljtbTs9h+X43Rd4TVUwo+Q+Onvfzq++YzYeLGsSlUgg
         Gmj2AUh4u+X85EmSmsGjuuBaHsaCWPZP6x6UtqHCo6iQ6wrZdV/RNM2uhzuMJqU5CYv6
         3Kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791478635; x=1792083435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        b=QXSLyyja/l3RWyfaYwOk2Zm9bX2IPM4Cfsk7CvlMtJshaf0xbRsXxhQlR5WxdMjQnc
         UFuCaucNTh1LV0tTEU+fHFvVXm+2orbjrO8bUhzySSWj1JJCmiVwHbNPTNUaKnwiK56U
         ogLuTv76kMv8GhqRSrEa1U8c9BPjv44/LoYUnWyL1TLcQNnfxtaYuM1znjIkTXEw7WT2
         L3hqAbMq5v807KTuinMUrMH6Kr9tUM3nF/jTzfHWand1mgYYHBPeHbcnXeEzjSqyNUox
         fL/yZPLoptkzDQxfV5RtFQXNOcuGrHegVfE7TFqAVU86+kQ92L+JVBZaeLM3GCkj5BBj
         W3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478635; x=1792083435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ikvmCV3JRP1ZJXHNQL45uRqJpRc1YzVn+kqIi57H0s=;
        b=fweCpk1m3csTRAl8e3JIZQTvGsCNkTMcFKXMD7P+mtdSjq8mQdLoTpyBuSVMYcMsaP
         jiru0qARxywXZkYVILnrU8JsRtrM6WjSEgMQ7JK0D8WFip49XaCZ2B+KrnZ2mwN419Ac
         AthaL/gPQ8mN/2A62zS6XhOiGXknYkzO7zP1n7jB8gVubw6N4uojjJhK06iL7blFdd0n
         LXVRuDARi/1r7XUJRLTSsMnrb4AIrDJzD8PMAUI7iiiUNN3R2ZrcHIVcBwoHWk8219e3
         gdr1mu1mSySfAr7Jb2WvYTRkcu/JLdEJpGCx7KwercrWKereDaRVuDd/JZIYPpOu+JSZ
         lRMA==
X-Forwarded-Encrypted: i=1; AKwUvBzhtk36A5SiLmEMbKuaX74ZS7WqqXwStVsfykEuVApNn4WAmepS8RtGp03SAaJlpmEeUNw=@vger.kernel.org
X-Gm-Message-State: AFuF++n2NG0cXLFMhy4tBW4CrkGkcsxdX8+Zn+pIBzbGtNbSQ5vXjPhy
	6tbnQtIlKaQhE6VwwnAiEXy83nK/UN8ftkd19ku8ryN++1ZyuTdU1//w6u+F03L3Bn6ABxxoZvM
	NpOC1Esou3eO1GipgAso0NWVIQ1CdGXA=
X-Gm-Gg: AYBFou3wU2IEbWQgpDgDgHD0YRD4CxG3YwUlfNpPqKabCMA8IOpBgrOZYmDhYanryGZ
	sePoxcGpiSEwIH1CtDJlOY4jB3vTQoeJyQuJIoRGGvP5gajoVryx3haAf5dtYR2do64kI+nq3eM
	UCc68EcQXQ5ek4muDAEec16A2j1qLOdyX6nzRANKbxyNAcX2WIy25Sb3eK2t6zxs53DduTuhVOy
	PCXCeXq0uM8adbc7Ip+YPjIzw1YnsDtS9+8HmNlJeD1XZmTHzegNabpvaL5v7BDL2Qj3wOPk8uT
	WmmT6LFbhZ1O0T1M80fLoITa4F1yrl5T9hhenN7VP36ESjmR+ziKyQ==
X-Received: by 2002:a05:6808:5394:b0:4f5:aa1c:d948 with SMTP id
 5614622812f47-4fc48c0cfb4mr5098718b6e.65.1791478631140; Thu, 08 Oct 2026
 09:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com> <20261008031604.256498-6-kuniyu@google.com>
In-Reply-To: <20261008031604.256498-6-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 8 Oct 2026 09:56:59 -0700
X-Gm-Features: AclHuK_Xg7cFIkTBf_GUj7s-jv3sHiyOpgy6IlwJDWYXH05-Kw-Ya4SMvWFtvb4
Message-ID: <CAMB2axNXeYUioMLkqJjSr=9-LEGkxfH87HXYoXT1PgPrdr22nQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
>
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
>
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
>
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
>
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
>
> Now, bpf_skops_hdr_opt_len() and bpf_tcp_ops_hdr_opt_len() are
> just NOPs without bpf prog attached.
>
>   $ llvm-objdump -S -D --disassemble=3Dtcp_established_options vmlinux
>   ...
>   ;     asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
> >>ffffffff825127e6: 66 90                       nop
> >>ffffffff825127e8: 66 90                       nop
>   ;     size =3D MAX_TCP_OPTION_SPACE - remaining;
>   ffffffff825127ea: b9 28 00 00 00              movl    $0x28, %ecx
>   ffffffff825127ef: 29 c1                       subl    %eax, %ecx
>   ;     return size;
>   ffffffff825127f1: 89 c8                       movl    %ecx, %eax
>   ...
>   ffffffff825127fb: 2e e9 6f 02 43 00           jmp     0xffffffff82942a7=
0 <__x86_return_thunk>
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
