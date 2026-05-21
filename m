Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96733806A6
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358628; cv=none; b=JNwGb+YB7XZJ9HvsBUzk+o5hZaW0SzRy+Ocm6ZgM1TSYvxUALTh/m5CTc05kRcF+9EqYSDdybVuURvP06y6C16VNWSZnxJPZSOcoY1OhmIYbzYPRoKRMSNEDYGm4TmHTTE1X88rMIkYf69r1zEzNwCeg+f+yTrMFSyQjOia1FKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358628; c=relaxed/simple;
	bh=gTVwqpZagZa5mCYibePx2zbeiV2CRsJsiELTP61LUSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OaI2ggKJNsyE9dq7rAi7FBzF4Ayfo8AS6bOBO2ZsmiVZSoYvkDp6fG3w5EecfKG8B5NHCO01DWW7A40kmjnRyvBu6cmveknSTv8tBTKF9XbDn53VQEc3lGdh7ZVxTzQLApHpMt76uhc7CCSptc40PIzPz0BLwPtt8QrHir9bOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYEvHsJ+; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYEvHsJ+"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d85152c9so2232818b6e.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358626; x=1779963426; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76R8gX0FEqbjjjAZsnw+EspUsb2+PAhzM0rQupZXg5c=;
        b=hYEvHsJ+hyncey9tzMORTVIdoB1lepxigBGmRmgs5B3sYgAhtnYy131lzckUQqzFVd
         USGGcITj7EibIApOg9ZyqNyyJAz5aopDC5l2TB2RqqXK6NtYsr4lOJx4fTKQO2vjC62h
         FrkgjlWwbURaXY8pShK+Nf+FTB1ryqKEoFCdw5BEXgFIOmfzL3ooMBkCt2Fd9DK3nVH3
         QJA1AKxeUuOdAb/WdKfGyZNPPyUrzbfT5qtmQ59dufUtuiGUj6uozMbSCTBWJw53lRU9
         dPuLjYkZWAYdDjgFtdJDx31E/28pT7x3kzEa35GTrG7xv3bOPDchbFjKGsoFedX7LAmh
         b+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358626; x=1779963426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76R8gX0FEqbjjjAZsnw+EspUsb2+PAhzM0rQupZXg5c=;
        b=Dd7ypcjFK+v0exd/vEZLEz6BzStKrXrLAAK08o5/MapT7OTUZKwK0HMI1XfktbpbKF
         W+4b+GrP3bAZ8DP1qEkevgcEaUQwkAgrKhZBKKb3s8Rwmdd7WuAmmUGUDBglAy7mhYjE
         S25Et9CkbO0vyhRHZ90YMQB+OGkPrIRBFR9L5absPHL2u/iqnM9w15g+gXhV/sxotJZh
         EVCoLRs6ubu9gjvcn13iCN2AQA+Aix5aIkuiY0Ek3VqSK58pURgUR7Q90aKgH08FXTmB
         8Nx5jaBgnj/qz0wN+P4t8J06Ysf+hVxUYci+8B1R5c+MQUtqylHYnXZPtNmVB6TP07HR
         P21A==
X-Gm-Message-State: AOJu0YyhsgZ4YYELxRZmo7gU3pt8k/w18YcyJFQv9XuyHkJANCwGKVOg
	003HtjVxgw71pbeprTr8EXxiEtJ/0Qp1tMJGAcLFuaCEIxH1sl7WONCjGGP+Bkko
X-Gm-Gg: Acq92OGcB0BSPEaM5dKH8XhcdK0HrGvPOJ/FCQsSRNt649+l1e3KyFKsGCGU2pkjBXr
	PH/D1SyBTIqLkWg+yRCs5yv+aEgV8iWV1Dx7Ibg2VFCxDIbwTF3mjllaEas0FS85J4LzXlT6ZZ6
	V8pGSzDHUjBGB7tX1M3jQNmkdVx2TsunpEWCVRPBcaypGJ9FFZb2om8YUGmsaY9ie+ssOpDFV+v
	3qeMInhLjLCPrwPvEWH603L2vG6QJ0Ei2Xqh1v0t9Sxx7hx4TR4S8NO13wbIg9vhYwsBQq6kGeJ
	eWuEv3LkPjLjOQGmtCrY9i/JH5uneae8CpypqKsR2PEts2dWASKShYT/TJzAo7I3LQJsl54Ivyi
	eJ7zQ/pzdHJKqHUtLMAwvvutEur382669HDomk6mPoQmSP2Df3q4+bKtSGZyWc5H7GS2RtAsiDs
	R2otUuZbOqXDQLCGRasfs3+DlO8Z11RB7ZFkyRm/sJ14NQ0gIGRtNRsf7znzKU1dPaBDmDIFsX9
	O4+5OqUxpbXcA76NA==
X-Received: by 2002:a05:6820:6ac6:b0:694:914a:ebe1 with SMTP id 006d021491bc7-69d6ef1f6efmr792231eaf.47.1779358625454;
        Thu, 21 May 2026 03:17:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d771c3801sm252630eaf.7.2026.05.21.03.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 03:17:03 -0700
Message-Id: <DIO9ZMXP4AP8.2U06P4YWLPFV@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf, libbpf: reject non-exclusive metadata maps in the
 signed loader
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "KP Singh" <kpsingh@kernel.org>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc
References: <20260519215358.126364-1-kpsingh@kernel.org>
 <20260519231709.3D4561F000E9@smtp.kernel.org>
 <CACYkzJ6rxGSrixr9sChFyXyu3JcjG3JmZGR5YgA0vV0WNJPs0g@mail.gmail.com>
In-Reply-To: <CACYkzJ6rxGSrixr9sChFyXyu3JcjG3JmZGR5YgA0vV0WNJPs0g@mail.gmail.com>

On Tue May 19, 2026 at 8:00 PM PDT, KP Singh wrote:
> On Wed, May 20, 2026 at 1:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential iss=
ue(s) to consider:
>> - [High] The generated BPF loader program uses a hardcoded 8-byte read (=
BPF_DW) to access the `excl_prog_sha` pointer field, which causes the BPF v=
erifier to reject the loader on 32-bit architectures and silently bypasses =
the exclusivity check.
>
> I plan to move this to the kernel with a kfunc anyways. Any
> suggestions for the 32 bit fix (apart from an ugly union in bpf_map).

Use _bpf_md_ptr(). It's a normal pattern.

>> - [High] Branch target offset calculation is off-by-one, causing the jum=
p target to land past the beginning of the cleanup block.
>> --
>
> Yeah this is valid:
>
>  Compute the cleanup-label offset after emitting the MOV that sets the
>   error code in R7. Otherwise the JMP lands one insn past cleanup_label
>   and skips the first FD-close, matching the emit_check_err() pattern.
>
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index becfda5b9025..6950443ba698 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -592,9 +592,9 @@ static void emit_signature_match(struct bpf_gen *gen)
>                 gen->hash_insn_offset[i] =3D gen->insn_cur - gen->insn_st=
art;
>                 emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0=
));
>
> -               off =3D  -(gen->insn_cur - gen->insn_start -
> gen->cleanup_label) / 8 - 1;
> +               emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +               off =3D -(gen->insn_cur - gen->insn_start -
> gen->cleanup_label) / 8 - 1;
>                 if (is_simm16(off)) {
> -                       emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));

maybe fix the math instead of moving this emit ?
Also split the fix into pre-patch.

>                         emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2,
> BPF_REG_3, off));
>                 } else {
>                         gen->error =3D -ERANGE;

and while at it remove redundant 'emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));=
'

pw-bot: cr

