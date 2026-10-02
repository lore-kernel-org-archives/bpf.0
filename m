Received: from mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388962773D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903651; cv=none; b=InDP9J0e4ewdKmLZXgGD6/Dg7i83Mn+ar0t9O1U1S+ShAbMMHrlQ21zkoKR3mEdVHdyZz01NOR2cnRWMmaukVdi66N7Qub6fkASzrZiQQNff83MKd1M13Zh2ONWLYCsnnT0osnbydnPHcKV7AfKBeiX1/qdJKNNpk2+5NLk+Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903651; c=relaxed/simple;
	bh=NWX2xZSeNthE4d+FVcGdGWkc32k8tGi3zDx/87hg2j4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ti4JO7p/ZLy+iv5wL07JMAhow0s47F0tD+0uPQBCMIphwd4ZF3aDxemskWIzEp6ofeNp3FZPTKyhgs1zNUi6MvTd/0sfCZ2ovIVEHrxJxqVZULNRaSt6Z67xq7R4HkU6KFNUUSYppXIpzV7fQB00/PgJPlfaobwlsnNKf+ESWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3Ycw7ph; arc=none smtp.client-ip=91.218.175.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3Ycw7ph"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NWX2xZSeNthE4d+FVcGdGWkc32k8tGi3zDx/87hg2j4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790903646; v=1; x=1791508446;
 b=m3Ycw7phD/YQN32KXiDqeVhT6EC1vI8MwMtXR9o0IUOcyNdIW7THhnu1lsPs8cQVskZ/Rtox
 4A+z7EnhwfVaIn+rU9jWMZycWFqMyO97BuMomGLt7WFAg/a6DBGbCK26aJn47+sk68FDFWHKopT
 m8OYLdHrtBI6ee6HukXj5omY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 06414f6154828934;
	Fri, 02 Oct 2026 01:13:56 +0000
X-Mizu-Trace-ID: 06414f6154828934
X-Migadu-Flow: FLOW_OUT
Message-ID: <5382c8744bac2a1d17fd96f76aa6a5245cf8a94e.camel@linux.dev>
Subject: Re: [PATCH bpf 1/1] bpf, riscv: Fix stack arguments of struct_ops
 trampolines
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,  Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 09:13:45 +0800
In-Reply-To: <20261001154038.2265210-1-kafai.wan@linux.dev>
References: <20261001154038.2265210-1-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-01 at 23:40 +0800, KaFai Wan wrote:

I ran the tests yesterday and didn=E2=80=99t notice that Pu Lehui had alrea=
dy sent the same patch. Please
ignore this. Sorry for the noise.

> When a struct_ops trampoline takes more than 8 arguments (up to 12), the
> 9th and beyond are passed on the stack. store_args() copies them into the
> trampoline frame using a hard-coded FP + 16 base:
>=20
> 	emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
>=20
> That offset only holds for fentry trampolines, where the traced function'=
s
> T0/FP are saved at FP - 8/FP - 16 and its stack arguments start at FP + 1=
6.
> A struct_ops trampoline is called directly, so its stack arguments start =
at
> FP + 0 and store_args() reads the wrong words. BPF programs then see garb=
age
> for arg9 and beyond, which fails the selftest:
>=20
> =C2=A0 struct_ops_multi_args/test_trampoline_stack_args:FAIL
>=20
> Pass the stack argument base offset to store_args(): 0 for struct_ops
> trampolines, 16 otherwise.
>=20
> Fixes: 6801b0aef79d ("riscv, bpf: Add 12-argument support for RV64 bpf tr=
ampoline")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
> =C2=A0arch/riscv/net/bpf_jit_comp64.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 01fe66774f02..4ae6674f58ed 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -875,7 +875,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_t=
ype old_t,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static void store_args(int nr_arg_slots, int args_off, struct rv_jit_con=
text *ctx)
> +static void store_args(int nr_arg_slots, int args_off, int stack_base, s=
truct rv_jit_context
> *ctx)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> @@ -883,8 +883,7 @@ static void store_args(int nr_arg_slots, int args_off=
, struct rv_jit_context
> *ct
> =C2=A0		if (i < RV_MAX_REG_ARGS) {
> =C2=A0			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> =C2=A0		} else {
> -			/* skip slots for T0 and FP of traced function */
> -			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
> +			emit_ld(RV_REG_T1, stack_base + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP,
> ctx);
> =C2=A0			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
> =C2=A0		}
> =C2=A0		args_off -=3D 8;
> @@ -1179,7 +1178,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
> =C2=A0	func_meta =3D nr_arg_slots;
> =C2=A0	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
> =C2=A0
> -	store_args(nr_arg_slots, args_off, ctx);
> +	/* skip slots for T0 and FP of traced function */
> +	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
> =C2=A0
> =C2=A0	if (bpf_fsession_cnt(tnodes)) {
> =C2=A0		/* clear all session cookies' value */

--=20
Thanks,
KaFai
