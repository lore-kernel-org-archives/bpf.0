Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01325A2DD
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254729; cv=pass; b=GF0fAlGCQrDfV33TWSqbXqysdLh534Xj9m5mGfMA0ujfQDpkTzaFzpjF3xB9so3oEq76Yg8t9CpWLRp+BHhWEiUJgOdjrOZlrJq4/SmF3bWztSQQdP3eKeM1877Al5mI8ynUSJP6zQE1lU1Y9JL/GuHc8YLhvNr4D16u/uPB+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254729; c=relaxed/simple;
	bh=LGD3xPl8+3E8efhfIb47wFuRS4vHkc4WTgX0GgWHECw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKrjgzXgryaW0GELPD1liwoFNM95sAkzZ1HJ3fH6r8hx3yh9TpIEMls3QcD2/FFZKSrwfgOycfNBamr9xAt7eJSBtbsVPBbSLUFGxHwk/RwkUquhT9DBys6ysK1+UnMFtsuKKCLC00/u8q6nlZs2Wbn8hostvorBZ/KyOGnRQEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV/DL5Jv; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV/DL5Jv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c40397e746so2008925ad.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254726; cv=none;
        d=google.com; s=arc-20240605;
        b=LWrnDu6Y5sOyGiyGZGRE/BC1lIf27A8swVgAofyhORWiaoW2PgoIpMHfJeFWBn2uQC
         I+otS8MzDUnSy3C6NnDjX2up0BO+ja/Jc8nQ/sgxU2BzqPQBbURQzXCJPpgxS3uQNHxy
         Zy9eIGZYADkLOt2U/Ght1g4Tj04p7Bh5+lVivyKFdr63buQgY+VSF/TUTsO7bgmvZOod
         PfrGJ0aqXeZ5qlykeWyzABXraJUPjeXGPqZtcW8ajMRlq4xhg8GnzRxkb/N81p6KOsRo
         hYY4+F76dMn8NIG+z+sGF6inDkwUsoDDY8MdsnYxRfs8O9PSVajXX7lI7vBTR6EqBIcq
         asPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7mEjHYXmjDXroNGYVpTIt6qxLgh9zdJjaDbvnTecPAo=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=kGhKExhVHFVyuicrbEvPaG9wKyyHQPZIRz2QoJsC/S/0zQZi+yt5fbYH8HkWHMiGTx
         UqEINE3OawM3foltj9l50gYNA1M4iQ0ZjjHlTK5IG4wePAMuum0at6yzTaC5fjkqUEBu
         7FD4E1RJ+Rx88IUOZA/Z94E54KgNlHRQ3pq/dRAavYcEpG2Hm9CTp5LA/nvlCCst66R6
         6WKYwCSpeQrr62ea3IC7KaohnKjaL963ZoOjMp5D+G7288zvtQdYnNHbfS03TimNdLgm
         pebCguwc1MtCVUP48Ol+bvvjfggHFv289NVolArmQjyjJDuG0TcUP9+SRjbFmtJWnRsg
         J3Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254726; x=1782859526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mEjHYXmjDXroNGYVpTIt6qxLgh9zdJjaDbvnTecPAo=;
        b=SV/DL5JvInw71gIGsmUGsVNi+hnXolR3aBudhkMiD4VcHg2lOfdqmaQP78GG9H4k8v
         0ZtgYmdOZLTZ6DeHnB5yTnam6mW+2DVGpTYR3ieGBVB6fNjGgUdjHCw5SerJoACP3j9J
         sAOzvp+hKGQX7zoxob2zKJIJs/Uh+/PGOjhmoBcwwTvFSg1sHyvljZK8XRjqpDPTRu0W
         4/l7dpN8hmmioRzX+GjP+zqruDxC2GPw949P1Uk7id1UmWlZPQ1lixHOaQUtQqYMiXqY
         HhZbptdanPqqI7Ix7+z7bkJo4Wn3ZRTAr0tbHMwq6qmz8VrQNqQDOuHUYN+L0sPdMQFW
         kmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254726; x=1782859526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mEjHYXmjDXroNGYVpTIt6qxLgh9zdJjaDbvnTecPAo=;
        b=VTqo2nX2tyPi8p+DSx14P4+ElPsrSKV5+TcJUg3x1wT5czDkotYxjuiIFcFYD+gbBg
         6hDExw5e5mo0Truq1ivwx9nUxksCt/ZDfzGvOy7VNuZbl8NYZM+l5E5g3zPnWdWDKSfr
         Ku4hdHeIRY9rXydky3lDg7/IJu2ToNWyaPRESC44U7ebpnSp99fJ3uDD2b3pKu1S++XB
         cBXxCdSmVFLqjzqayLTbMWiPbt6lzY0CsbadFnzwdZ7YlV5RnFbQLyDliX02+vFui3KB
         qACBnaJkjWBmG9yTJ6Lp67ibuedIYKCsnAl3ycLphpWZp842Vi59Nc/9NQjxGgt3oDB4
         54jw==
X-Gm-Message-State: AOJu0YxcgFLRp+qufyqXNY4Jyw9XAsUsoJ4wKeGaYuMXEsxFdf4EXpgP
	GyeMF59nu6nnd/n9RFdbuQDWebe4u6XHjIlxEoDf4aecVsElCfvOWt/mbs8/ADTHBkOEUMQQHkR
	/brsYc8Pq3wW7/9qDoHtGNqmC5FWmzKM=
X-Gm-Gg: AfdE7cnKpSeVZHr/cWPhZxzVOzrd8iyYJMPj9ggwF5PTScgbc4aHS4JWrLP4VRfyalo
	s1nAIiYd6lSzjByz8NKlejQSxnX3votRp861yc2TqZBuXIAIl0l7EuHC7ncFAk5hmn6nhgcr0xs
	xYXIS8TH3Ba2Oo2U7pftpoShLpgZgd3ThY5x3hfIivEVv1qZ2illfO9bYmAlw/evF3Lh0mpgO43
	aT26LY/GfRGYYKdc6mmuPMNF41sUKNOcgQlvnwaa1fWfG9n+xEeWFrkPlzbaKgFwwStGUMqx95F
	IT6gP/Z6PNZ0zN09GRYkqB8TJmbXEOwnMeUmK81kw7XrpnBS9pXYD+FNGeGxMAfqOqtlGg0Swus
	gm0DW
X-Received: by 2002:a17:902:db08:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2c7425cae26mr174343105ad.12.1782254726243; Tue, 23 Jun 2026
 15:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-3-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 15:45:07 -0700
X-Gm-Features: AVVi8Cfrddz_H5TXjjUkIYgYR3GXOiBk8OG9TWZVN7_Qjb0DR56O-SDqCq1vbJE
Message-ID: <CAEf4Bzbx5xB9sA5vpe0Y37DXeJLRYsbSHpvHTca6uw5Tj7jBAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 02/11] bpf: Disallow interpreter fallback for
 user BPF_ADDR_SPACE_CAST insn
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Since interpreter is unable to handle the 'insn_is_cast_user()' insn,
> require JIT in __bpf_prog_select_runtime() when the prog has the insn.
>
> Fixes: 142fd4d2dcf5 ("bpf: Add x86-64 JIT support for bpf_addr_space_cast=
 instruction.")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h | 1 +
>  kernel/bpf/core.c   | 1 +
>  kernel/bpf/fixups.c | 2 ++
>  3 files changed, 4 insertions(+)
>

apologies if this was discussed before, but this seems unrelated to
the main patch set, why not send it as its own fix separately? same
for the next patch, no?



> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..5e1843d2859e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1781,6 +1781,7 @@ struct bpf_prog_aux {
>         bool changes_pkt_data;
>         bool might_sleep;
>         bool kprobe_write_ctx;
> +       bool has_addr_space_cast_insn;
>         struct {
>                 s32 keyring_serial;
>                 u8 keyring_type;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..49398b5bd172 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2620,6 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>                 goto finalize;
>
>         if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> +           fp->aux->has_addr_space_cast_insn ||
>             bpf_prog_has_kfunc_call(fp))
>                 jit_needed =3D true;
>
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab6..2d5958774b61 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1523,6 +1523,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env=
)
>                                 insn->off =3D 0;
>                                 insn->imm =3D 0;
>                         } /* cast from as(0) to as(1) should be handled b=
y JIT */
> +                       if (insn_is_cast_user(insn))
> +                               prog->aux->has_addr_space_cast_insn =3D t=
rue;
>                         goto next_insn;
>                 }
>
> --
> 2.54.0
>
