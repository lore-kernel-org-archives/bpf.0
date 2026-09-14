Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F2397B1C
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427698; cv=none; b=YlAUBHLa/Vz+metsl0pV05tkHqd3bE8EH07FQzDKH4aa/tjHwq/b8vtJQe/ETDoshzDHyJiZzinOL7XhQNEBdwUn8QZZbqxnjQ8g4+2MI9GTf21baJKnlL4CQsjAGFXO610ibpclE1jXFDYYPboQ7WyIZB4Fo671RSJENgv4iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427698; c=relaxed/simple;
	bh=dNWkRDXWp/KrqQmtPXFkZQSHuSRvJ3x+hhcztmuuAnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ioeq8sy3SFQ7CISV09YS5069TD/aLXbnCoz3MzpdYsQH4IVxUJZdkPUPJRJ1kKyyib7r2KMfGpAlfPNaOaUk73xvR+1hqOqkO8OME77yFDbdG6f9FDgyxHIwzgSOHkTrGXRIiK1EW/u2kQKGkQ4lnayL3R/eg2/nlv0+Tbxs9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDU67i5I; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDU67i5I"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fe517774so33727905ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789427692; x=1790032492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wOiiGuIVQJiO4Ein1oM3zAj987RfgZm9JxhYW5Cgzw0=;
        b=UDU67i5IgSFBVivCCsHFpmtJPq9u51jazUwzwDzZle/fEveDvLUEe2Y8U6SpOHyKF+
         aq8fIrIn106W2RruQiukhtqbKzCzN9WIuHhRpRZ6RAixNw6ixkfFXyLxE9Jit/bpknZk
         KszINPu3lPUO2wIQ7D8tmc1qsVD0woel2PhGD3QVOt7pJFkcCk0Eu0cInrgtlfPGW+aD
         fP6zJjC5zKBO15KqkF4Jrl6bwgWtZi/QE7CelZHGFBHinbtua4/sU8DV2qfaAdXReF7n
         PjyVnMV4fXA7Mn3F7i6bqryKlN8p2XtLjn+Ntc9UrPQPJcCN4Bg4f9DZDDr3AJBBz5Tx
         W8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427692; x=1790032492;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOiiGuIVQJiO4Ein1oM3zAj987RfgZm9JxhYW5Cgzw0=;
        b=2AbESNVGDtOMgOzLpSn04d/r3ung7UmzjCT5wPv0Wls3mVCk2he8Etdq0UnmrISjT2
         +Hy9wNS21tD0rMhmTE5CKF4jIZDhyWhFYw3cn7nx8nzywa/6Y4yYkOoL3N2T8atk2wQj
         CismFv5cFwCmQEa/DnYyaLTMzvtlam0qXmIDJVfklp/trwqAwjR7qmrwDKYUXIElZRM6
         J0g6KsJpWJ3D6NU3nmKPpGfpe8XOX6tKJpFhLmNOt82mG8xBqQ8RPZF1UqJGlusXg0Ef
         PcmoP/IDqDhomIqRSeiE/McF/sk+C9G7VTNjHNpK8Qf8AEZKSCGwXTfqSOa7U+Ljq1fw
         XW8g==
X-Forwarded-Encrypted: i=1; AKwUvBwsW+FTZn2rYD7Zg64XGPsA1sjVT6yL504jyn6kJTNq9Fru7XjZJGnL4F5kW6lGRa76EWk=@vger.kernel.org
X-Gm-Message-State: AFuF++meDcQDCMkc89laAQaV4BYg70s9T/o5w/o+h7AwIT2EWdfsKS0Y
	BQD/uScgaWqqxZtcsArVAlrPMfb/21w3o+dxMSCm1HNzQ6q0rCwcQef7
X-Gm-Gg: AYBFou0kTPcrMlS9QWER0k7j2PyKTohko4VZkfdX4BvXhZa7KX7odbvN7pFeHVvs1lH
	+3a10j7nJN1U4Wl72Hk845QPvhh22ERztcerI7l9p8ZPXN+rFupv3YnpztaruH38K0jw3ZSRr6m
	5yNq1x4OF5X2bJhTg7cEH2hJISfFojueQ9GFt3nETHmugzK+pORaTSRrE7EOCBJ0FzE9uleG+Jl
	PgkGmttM0eB25DYMA3ZiUJPB1y2MXWUAX4TAY+XizJKoeXXv0JEr3QNu1pEFRDZHGYpj31KnAT3
	S6AxpurfzVu7gvEAgbwPKltHsZyqHK56BeE+TBNEgGqNRDEmCavc08U/2iK9XGryzfcWZi88CQQ
	Ou44DYz+GGzvfIU2YklYQLSXECcrtggSxKad79nSdineslgVYtsN3FIEuEW3K4pNTqQsd6bu1aP
	wYg9yrHpLyC+RNTsrzOugzF9W5tFScZKf+FJrmb2uP/Ktkg/Skszx0rCWaiAypbpZFxRVaW+Wrk
	RYbmPBiPJalnk7ZZ8hWD2FTjKU=
X-Received: by 2002:a17:903:94e:b0:2db:117e:cf50 with SMTP id d9443c01a7336-2dd6c5bfe2bmr114170385ad.4.1789427692378;
        Mon, 14 Sep 2026 16:14:52 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfe80fdsm55214065ad.67.2026.09.14.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:14:52 -0700 (PDT)
Message-ID: <c15e2c91b7f9a6f3dabb7fa75b10e5d235acfa18.camel@gmail.com>
Subject: Re: [PATCH bpf v2 03/11] bpf: Cache the jump table of a subprogram
 during CFG discovery
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org
Date: Mon, 14 Sep 2026 16:14:49 -0700
In-Reply-To: <20260914170326.249953-4-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-4-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 19:03 +0200, Daniel Borkmann wrote:

Hi Daniel,

I think this is a good approach.

...

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c

...

> @@ -383,13 +409,12 @@ static int visit_gotox_insn(int t, struct bpf_verif=
ier_env *env)
> =C2=A0	struct bpf_iarray *jt;
> =C2=A0	int i, w;
> =C2=A0
> -	jt =3D env->insn_aux_data[t].jt;
> -	if (!jt) {
> -		jt =3D create_jt(t, env);
> -		if (IS_ERR(jt))
> -			return PTR_ERR(jt);
> +	jt =3D subprog_jt(t, env);
> +	if (IS_ERR(jt))
> +		return PTR_ERR(jt);
> =C2=A0
> -		env->insn_aux_data[t].jt =3D jt;
> +	if (!(insn_state[t] & BRANCH)) {
> +		insn_state[t] |=3D BRANCH;

I think it is possible to exit early here if BRANCH is already set.

> =C2=A0
> =C2=A0		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &env->cfg.gotox_edges) ||

...

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c

...

> @@ -264,6 +267,15 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
> =C2=A0	if (opcode_info->can_jump)
> =C2=A0		succ->items[succ->cnt++] =3D idx + bpf_jmp_offset(insn) + 1;
> =C2=A0
> +	/*
> +	 * tail_call upon success and ld_{abs,ind} upon load failure return
> +	 * from the subprogram, which is a hidden edge to its exit.
> +	 */
> +	if (unlikely((bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_c=
all) ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0 (BPF_CLASS(insn->code) =3D=3D BPF_LD &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BPF_MODE(insn->code) =3D=3D BPF_ABS ||=
 BPF_MODE(insn->code) =3D=3D BPF_IND))))
> +		succ->items[succ->cnt++] =3D bpf_find_containing_subprog(env, idx)->ex=
it_idx;

It appears that check_subprogs() assigns exit_idx but does not
guarantee it to be set. Meaning that for the following progam exit_idx
would remain zero:

  0: r0 =3D 0
  1: r0 =3D *(u8 *)skb[0]
  2: goto -2

Hence the above would add a spurious edge.
I think check_subprogs() should be updated to demand each subprogram
to have at-least one exit.

> +
> =C2=A0	return succ;
> =C2=A0}
> =C2=A0

...
