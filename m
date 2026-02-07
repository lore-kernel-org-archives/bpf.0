Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928133E37A
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770461636; cv=none; b=N/RvicRyFowOJB2Amf3x/7pkRocbvPV8v9TueSSO4kHVrkGm/OKVqEqnHqbpeQlRKGXwEIqWrj2g+3yzWpfekXZA0F/4UiREd/GNhFQWST45OOkzuFYiRyXVwyo0NB0KhTxeK4mvSxWJGKeHwOt6QgR9/MSHKX7o14eqEiLO8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770461636; c=relaxed/simple;
	bh=Vv1Z+kBNua6kZdCRwxY739RJbTwDKmwcS/7jgSTque8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNZdiaFdLmFqnC16KbQcunoPn8qBwcfF12Z6H2Xrr0Tpb9SvhPQYpUeeZbA2j3lU1uRAd+GTFoPATlmMGf3fX7jirG1Ox9zskakNmzPC4tQ/XG+mv7rq5DzE/o4s1+aKAMh+964kJP9wQPla6FS6BRLEmzmwJ7nOozZO6J9DEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bzUM415I; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bzUM415I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770461633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZh0R8vWCBol722cPbD/0P1LqMJ0zb7aYvYr9xYxFi4=;
	b=bzUM415ICosLe1IDqKekKvGuBGnaE93Ls22T+cW13EdVzFOfz/SdTc8KnhnLARVUR1PmRn
	bk3OIUrVs0K20T4YUWHwF7nOVuAcVHmIStsoeZksoKIL61VDngtDsuQlXA5RChztsDWeFP
	JwpzHVJKArWlK7xAOKnGwcbgcQVe9i0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Pu Lehui <pulehui@huawei.com>
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, jiang.biao@linux.dev
Subject: Re: [PATCH bpf-next v3 1/3] bpf,
 riscv: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 07 Feb 2026 18:53:17 +0800
Message-ID: <3042323.e9J7NaK4W3@7950hx>
In-Reply-To: <d6281121-b39b-41ac-a166-69dbfa1f4f79@huawei.com>
References:
 <20260206122002.1494125-1-dongml2@chinatelecom.cn>
 <20260206122002.1494125-2-dongml2@chinatelecom.cn>
 <d6281121-b39b-41ac-a166-69dbfa1f4f79@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/7 09:13, Pu Lehui wrote:
>=20
> On 2026/2/6 20:20, Menglong Dong wrote:
> > Introduce a helper to store 64-bit immediate on the trampoline stack wi=
th
> > a help of a register.
> >=20
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > ---
> >   arch/riscv/net/bpf_jit_comp64.c | 25 ++++++++++++++-----------
> >   1 file changed, 14 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 37888abee70c..e4f45e2e7e2f 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -926,6 +926,14 @@ static void restore_stack_args(int nr_stack_args, =
int args_off, int stk_arg_off,
> >   	}
> >   }
> >  =20
> > +static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
> > +				   struct rv_jit_context *ctx)
>=20
> Some nit. The first parameter can be removed by using a fixed RV_REG_T1.=
=20
> Also, placing imm64 before stack_off might looks better.

Hi, Lehui. When I implement the emit_store_stack_imm64() in x86,
Andrii suggested that we'd better use the register explicitly to indicate
the register is used. So maybe it's better to keep this part still?

I can place the imm64 before stack_off.

Thanks!
Menglong Dong

>=20
> > +{
> > +	/* Load imm64 into reg and store it at [FP + stack_off]. */
> > +	emit_imm(reg, (s64)imm64, ctx);
> > +	emit_sd(RV_REG_FP, stack_off, reg, ctx);
> > +}
> > +
> >   static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, in=
t retval_off,
> >   			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> >   {
> > @@ -933,12 +941,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link =
*l, int args_off, int retval_of
> >   	struct bpf_prog *p =3D l->link.prog;
> >   	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> >  =20
> > -	if (l->cookie) {
> > -		emit_imm(RV_REG_T1, l->cookie, ctx);
> > -		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
> > -	} else {
> > +	if (l->cookie)
> > +		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cook=
ie, ctx);
> > +	else
> >   		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
> > -	}
> >  =20
> >   	/* arg1: prog */
> >   	emit_imm(RV_REG_A0, (const s64)p, ctx);
> > @@ -1123,13 +1129,10 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im,
> >   	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
> >  =20
> >   	/* store ip address of the traced function */
> > -	if (flags & BPF_TRAMP_F_IP_ARG) {
> > -		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
> > -		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
> > -	}
> > +	if (flags & BPF_TRAMP_F_IP_ARG)
> > +		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx); >
> > -	emit_li(RV_REG_T1, nr_arg_slots, ctx);
> > -	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
> > +	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
> >  =20
> >   	store_args(nr_arg_slots, args_off, ctx);
> >  =20
>=20
>=20




