Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6D54704A
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789793732; cv=none; b=SKiVpt4NiKHLVOWST6eLNJA3cQMhMiiUxaSzs3n2fQonz5QH2yjGmSj9rfsmyrRYenpysSFqaJfduaODAg9tDCCuamQbOURWUolfxmTO0j0Oa31YTKFR2ANkaQp/VbCn0lnHuC4uKMoINC7vRul/N4QTQR0NZ9ZDg/Lmz2TcaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789793732; c=relaxed/simple;
	bh=mQXvGj/1ZhlpI5x1xgsizbo/FjVBEb9gbL2dKN3OrCk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kBe1ngkiaLN9ZxlAp/40zX+r3cA632oXrB227nmU9Hv8VZTKXBnn8ZzgBJbt4KWAHItP7vXRg85sIGcdZYWBA52yRHdYunIAivPzCgv2ioBFjwCYFg1cDC+Z9dZMIFoBxgH+t2cb/HcfG5M4Oybx0EW2hLqg3Zahr0+48+4tb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa3iJZmz; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa3iJZmz"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so499145b3a.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 21:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789793730; x=1790398530; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8126oMm6t7slDrtus16ZsnBIitmGk5AAdc1Of8AAUGA=;
        b=Oa3iJZmzvHFahWJDtLhAFIT8s//1w2N7Z8kDbcXBogu3B1SlB8faDNpRouKqKWoSqn
         i1X2jyUQ03ipgd2XIVFejtytk3WjxwcuEzg+aNo5oZrE9T0HQ15CiG1w1ae7FaaU6Nqh
         w81mRHtjBhpZhzFEKA8PqO4VEgEwkXD3ybcLTfrMrFDQOjiHQzrbbK8dYEcsyyz4FUn5
         Y1I65qrxwrd+vvygR8L/oHWcLMr6dUBR0v0c8cmtuRGxyx3c7GQLry/D+NfjycojP78S
         HNfw6qR28cuNbxSd7P+UcsxXsW98OxpP6IxZmxKmANXhENE3u7b/Lkyg6taTEOEelkha
         w7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789793730; x=1790398530;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8126oMm6t7slDrtus16ZsnBIitmGk5AAdc1Of8AAUGA=;
        b=CJtirOL2KVZpHLU5B0AccwDJMQTVJVGSNb8uEjt509XmDegGW9fKrw4PORgCejT2v7
         L/Thfj9U/TGnlhkPYHiCeW737S/QLdJ5uCoaZVMJG4skalccN8/hsl5RRZ8wUI6btp19
         VlOzBnYW8h8cnIYuzMaTd2NHBtBkAc2h+J8e21cRvZr9Ve/w+67msB096bqWFKFURW3C
         haRpFcyaS4yaN/OMGZ5JclBCi4hC77BS3wadLXbTSOPafLCKXKgCqLxuAY9b8hLoH4jt
         ajgGmD3K5/gro8TL1zxw/jX/qIjbZVcGZE72X4nsHCOABG+6SNGMaWiM9w4X9kYVPxgi
         zN6Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3XmZdu0vyh2whfgqIb61LharffbmokOFnHt6G4pgd+LyX0kWL8gpelOJoP+OYVm0RinU=@vger.kernel.org
X-Gm-Message-State: AFuF++ngqBq45rVlW90p7Hyjfq0yb2nD5EWg19BNy+LdQHpmNRR6Rnie
	hDOH9CRLJDbO3vQjh65rUvqfj4mBpVjMI8zid1vm1stoQUxWqckifIXe
X-Gm-Gg: AYBFou1n+J4ZvFGVj3nTqsv6wMZDY06jXZUX2zQW0cp0XTTnP+i/E+Y8WOKsTqGFAqV
	ylwlgsgwZzKoFXGVf04t06fYWWuL9NBOQrvkqmIQqjfOZjqZfxnOKso2fzHtVCP8YQBfLy/5FUu
	NaHZ8t90OeO9tbc+tNNJum9jsLWRrC9MVezUvDxFlM8ilOmAu7y1RlyTjQe/o0I0We7H5ONyqPu
	XYdU8kTt+iPxK8r5WGgbs8Aw9nLgw5jNNUvNB7EvHVo5w9UBHCxvZcgs5j2dyVqjA1W6kHGOysL
	Lwgy2VxoTSdunP40IwfgM/zDHEJTBBrjVZKRODWXe5iTJZvu4T7osjkerfXK0TLaZ77RD/yHmC/
	oX/ngM62n25etkqKxiqJCuCe1lWtyUHK5LaPP5HhRzaL3QrgsLlvJjQrFd4hv0MGnLK286OBtk9
	38j1nT9jwrFiJpDr265L38Q4L8drTOHRg+65/SvVgdsdNH5GErHpH+U870zdCkYnhVUCTpPNUon
	fHl5CCOyIt+bskwbLjVQfqnaTOwIV6VbWMxlJmdpBf5ZhlBvasehbwpCo8VpGY4JlHaUYqR36Yy
	epZl
X-Received: by 2002:a05:6a00:1d9c:b0:878:3704:e0f0 with SMTP id d2e1a72fcca58-8783704f769mr291139b3a.22.1789793730121;
        Fri, 18 Sep 2026 21:55:30 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa401474sm557306b3a.53.2026.09.18.21.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 21:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 04:55:28 +0000
Message-Id: <DLJ0XC51BJVC.3P80YCN4K6KP6@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <kernel-team@fb.com>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/20] bpf: Add lookups for exception
 cleanup resumes and landing pads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260918044211.3286855-1-yonghong.song@linux.dev>
 <5dacf8db0cf086b921c09c3b65da5bff0d1957eb96a3a11906781a6a80c02c2d@mail.kernel.org>
In-Reply-To: <5dacf8db0cf086b921c09c3b65da5bff0d1957eb96a3a11906781a6a80c02c2d@mail.kernel.org>

On Fri Sep 18, 2026 at 5:44 AM UTC, bot+bpf-ci wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index c08505b9ba821..f9bccd3e0f4db 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
> >  	bool needs_zext; /* alu op needs to clear upper bits */
> >  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable =
context */
> >  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> > +	/*
> > +	 * 1 + the instruction index of the exception cleanup landing pad thi=
s
> > +	 * call site unwinds to, or 0 for none.
> > +	 */
> > +	u32 cleanup_pad;
> >  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog pe=
rcpu alloc */
> >  	u8 alu_state; /* used in combination with alu_limit */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> > index 2add8001c3ec3..82b00fac6bd6a 100644
> > --- a/kernel/bpf/fixups.c
> > +++ b/kernel/bpf/fixups.c
> > @@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifi=
er_env *env,
> >  		}
> >  	}
> >
> > +	if (env->cleanup_info_cnt)
> > +		for (i =3D 0; i < prog_len; i++)
> > +			if (data[i].cleanup_pad > off + 1)
> > +				data[i].cleanup_pad +=3D cnt - 1;
> > +
>
> [ ... ]
>
> > @@ -549,6 +554,7 @@ static int verifier_remove_insns(struct bpf_verifie=
r_env *env, u32 off, u32 cnt)
> >  	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
> >  	unsigned int orig_prog_len =3D env->prog->len;
> >  	int err;
> > +	u32 i;
> >
> >  	if (bpf_prog_is_offloaded(env->prog->aux))
> >  		bpf_prog_offload_remove_insns(env, off, cnt);
> > @@ -573,6 +579,17 @@ static int verifier_remove_insns(struct bpf_verifi=
er_env *env, u32 off, u32 cnt)
> >  		sizeof(*aux_data) * (orig_prog_len - off - cnt));
> >  	env->insn_aux_data_len -=3D cnt;
> >
> > +	if (env->cleanup_info_cnt) {
> > +		for (i =3D 0; i < env->insn_aux_data_len; i++) {
> > +			u32 pad =3D aux_data[i].cleanup_pad;
> > +
> > +			if (pad > off + cnt)
> > +				aux_data[i].cleanup_pad =3D pad - cnt;
> > +			else if (pad > off)
> > +				aux_data[i].cleanup_pad =3D 0;
> > +		}
> > +	}
> > +
> >  	return 0;
> >  }
>
> Can this logic handle NOP removal correctly? When bpf_opt_remove_nops()
> calls verifier_remove_insns(env, i, 1) to remove a single fall-through
> goto +0, if a cleanup record names that instruction as its landing pad,
> then pad =3D=3D off + 1, so pad > off is true and cleanup_pad becomes 0.
>
> But removing the NOP leaves the pad's next instruction at the same
> index, so the correct landing pad index stays unchanged rather than
> being zeroed. For example:
>
>     off:     some_call with cleanup_pad =3D off+1
>     off+1:   goto +0  (NOP landing pad)
>     off+2:   actual cleanup code
>
> After removing the NOP at off+1:
>
>     off:     some_call (cleanup_pad should still be off+1)
>     off+1:   actual cleanup code (was at off+2)
>
> The `else if (pad > off)` arm erases the record instead of preserving
> it. Nothing rejects NOP landing pads during validation - a goto +0 has
> code 0x05, not 0x00, so check_cleanup_info() accepts it.
>
> The ordering makes the loss escape validation: bpf_check_cleanup_exceptio=
ns()
> runs before bpf_opt_remove_nops(), so the verifier proves the cleanup
> path releases acquired references, but then the NOP removal zeroes
> cleanup_pad, and later cleanup_info_for_subprog() sees `if (!pad)
> continue;` and omits the record from the runtime table. The program is
> accepted but bpf_throw() finds no pad for that call site and skips the
> cleanup, leaking whatever the pad was supposed to release.
>
> Does the `else if (pad > off)` arm need to distinguish removals that
> consume the landing pad instruction itself versus removals that happen
> before it?

bot is correct here.
pls fix

pw-bot: cr
