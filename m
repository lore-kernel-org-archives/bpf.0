Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4403859D3
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411969; cv=none; b=qw0ESd4Qw0zAnOWYh5f2GsuYuEcx3fQlaBBy9JFtCDFNcdJfnl6veBLx8zuI4b7d+0ehOki/uf34H9lD0xECQZRejqRr/BBz5+oP7a8Fga3QDFsaiXGN1eRq/hU+u2aMsFvv9pBW3dBDeogiewVtEABWZklT77ct7aP4gVPXSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411969; c=relaxed/simple;
	bh=XcqC8oqWDZC5uDyieqKXTFkGc+RMbwDU1TRH4aQ37w0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNrveA/8m0gXBwwa6Pt6LVHZ6eiIcHfqBOP/PJhDl1qv7tN0AAKAOOJqPNsCxY4ASNYkjJbNT+J0Cjf0LrbOmZSDCTgeLFzuUgUfp7eJE6a79PL6YGQ+h4781lsD4N7SyY6Tbe9L8Qix0Nd3uQsqoFD97rojw2+jz/zyFnhA+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb9PH5hp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb9PH5hp"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso21668595ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789411966; x=1790016766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p2TyOMbn3V//+XxdcMO+zgK/q6s6v4LMcutMW+PH0Xs=;
        b=Jb9PH5hpVR0smT9A4Ll4yQhhF/fgR2qHuEOKJWquYKdtyWua7lxMMa3TqzmuDjSCOL
         WP6zOqWzH/QEpHJE7P2+sG9WjKzmpGBiy+0VQz8n+Mi3ZpKSIc3kde8pMMym5JTwcWj+
         uPryawlgMabd7989Wkp4CHNxpvqNG8jjGFfaEwhCn/lhg8pPxCTYsUM8bxi1zoZhTMZg
         RXMuu5D2cPVhHI35FsLCMmKrACApy3a+7u9QPINhglfH0KHvtlX2BxoA5V3hxQzFu7hA
         D6SiXogY0l0Batav/21HToHtRlOkfpgyKJQH83H7WvD5P5exlVLkX8K4wyWA7SN/xz8V
         HOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789411966; x=1790016766;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2TyOMbn3V//+XxdcMO+zgK/q6s6v4LMcutMW+PH0Xs=;
        b=pbqFCYXkvf5uudBH/ft9NyYDSWpEaVoIQ+Q4Ji23HVaqwIXbcphj636yr7N3T7QLFk
         OI+nGqfI9tWIWaowa8nMvztp61IpUcDmJ04hYqQFXkNMxxtSsREt782te5dGeiBpjNva
         iGfJSmHih1Aco1T4mvpUAoluPg865fAgezXtupIW8ZHuuzzl+PS1J4ox9hwZPd601xEd
         08GI7yRFY64MAI0PAAxmT+WLULye5+DnEitDVRHK2NyAUvXItgj4BISy9y536lVSpMev
         N9yKzJfPDZ6NtfGUfqUoIlXv+KDphW0zB3FzSWQULrQtPi3Eq/j7fjCQeduPGD5sLR/A
         gJXA==
X-Forwarded-Encrypted: i=1; AKwUvBxua7IkR1FSZYW9bHlETjdyYay9V7NPDHhrtKY4fomXoui1C727JhwjSqrqfcf05HFW3a0=@vger.kernel.org
X-Gm-Message-State: AFuF++kDg/ttMf47eiPMAHFFOIAokx1WSttSGJ7y0vzXcY4ARcFcx7Yh
	Fe4Q4azujNv8OYQf6ZYK6m5VhEwio/A8fn9s0+cscMr99XX7dNkok9WH
X-Gm-Gg: AYBFou1yGSz6r87Q+5u9WTkG4SxQy8v1pOLwq/lsqm8/GV+Ivskr4UwUL51WYJxBHUU
	fpnklyGYtQGB9Cy6FblNFJbSa3EU0v2ULe65wkKvvh/BvmlGowf2bw/lvDXo/10h9/avnCAkqNo
	whpGl9prJMPlatu0evzXohtstx4N8ikNrfJQaPUiPtDWlpycbQiI/inxCFr1KKQ3SNc+2xsovjr
	05xyZazNZYq739pOJ/n/nH164YheoC0GUlWRAK8jaNFj8jpsQXd5U8fUAVoOMQqGLcKFSHQECZJ
	RKt3r7PzoW1zh4wCGRih6bwaSuyebNDiCF81M0VyDVkQ9CVS3aPbVHsUEnauomh8/O3Sqd/x0hG
	EdZRsgOYrFavgx/v88FvduLgACwC5bDttfXLnYfg/3n9y+laI07FLGrP4LhQRTaVrX1TmbHSD9l
	g1HuJK0kLzgssZJqWJs3lHkGj4S5S3i7t/x3bTe8Pz2+xsSl6ekySYE4H1+FOGy1ZtB1wTDNRum
	TUc3hPi4BE7mKdIW8Y1SeE5vRU=
X-Received: by 2002:a17:903:244b:b0:2db:2413:87d2 with SMTP id d9443c01a7336-2dd6c5cbdbcmr74488725ad.4.1789411966310;
        Mon, 14 Sep 2026 11:52:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd561e2af6sm32534195ad.70.2026.09.14.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:52:46 -0700 (PDT)
Message-ID: <1dc63638136bbdbc7e832dc50dec2072924af349.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/7] bpf: Make post-verification instruction
 rewrites killable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 11:52:43 -0700
In-Reply-To: <20260914131701.2529725-2-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
	 <20260914131701.2529725-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:16 +0200, Kumar Kartikeya Dwivedi wrote:
> After do_check() returns, the verifier runs several instruction rewrite
> passes. Some of them patch or remove one instruction at a time. Each
> operation moves the remaining instruction and auxiliary-data arrays and
> adjusts all branch offsets, making the overall work quadratic in the
> program length.
>=20
> A privileged loader can submit 131072 unconditional jumps by zero followe=
d
> by a valid return. Verification finishes quickly, but bpf_opt_remove_nops=
()
> then spends a long time removing each jump separately. Since this
> post-verification work neither checks for signals nor reschedules, a pend=
ing
> SIGKILL cannot terminate the task until the rewrite finishes.
>=20
> Make bpf_patch_insn_data() and verifier_remove_insns() common cancellatio=
n
> and rescheduling points. These helpers run from BPF_PROG_LOAD process
> context, and bpf_patch_insn_data() can already sleep while reallocating
> auxiliary data.
>=20
> Report interrupted constant blinding as -EINTR and propagate it through
> both JIT paths, including kernels that permit interpreter fallback.
> Other blinding failures retain the existing fallback behavior.
>=20
> This does not reduce the quadratic cost of the rewrite passes, but it mak=
es
> the work preemptible and allows a killed loader to be torn down promptly.
>=20
> Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8b294dfc1ad4..df1eb43d1933 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

...

> @@ -2625,7 +2628,8 @@ static bool bpf_prog_select_interpreter(struct bpf_=
prog *fp)
> =C2=A0	return select_interpreter;
> =C2=A0}
> =C2=A0
> -static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog)
> +static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 int *err)

Nit: in case if there would be a respin because of the CO-RE handling,
     I'd suggest to avoid adding the `err` parameter and using ERR_PTR
     mechanics instead.

> =C2=A0{
> =C2=A0#ifdef CONFIG_BPF_JIT
> =C2=A0	struct bpf_prog *orig_prog;

...
