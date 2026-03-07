Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB622D7DEE
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854311; cv=pass; b=TuorhD5Yi3sMwCvcLX+64ALWSAlRXJMzGAr2RMKkr9kzWmpzRQ8VqqPOjsGPEWaSjuNFCvDEXCVSoOr1m3D00YNZHct03KLc0p1/k5Det594JGTFFHUbL85j4t+Hx2kCviBqeQyNEALrZcCyKXSCHd+GR3+3zfI8w1caSOXjEJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854311; c=relaxed/simple;
	bh=wB6oMjJCSgZ33Y6/5AT8sCdL63g4WRUflSdiPrlVB1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNbwg0gnLmT4QEA5/Sat/VDqlO9KdgAdw7yoVzxM5H7Sd3t3bineZpPHWKozc9oxFAzMQbA/irLL6ayptLKxuw0rUySNaxMUmZm+zO6papr4PK/kpEpZBOM9PBVrweWa0hDY23f89ync9TzSdkIoL/onAFYJBWTRQKMv0oTn/WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh7IoBZf; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh7IoBZf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso85740355e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 19:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772854309; cv=none;
        d=google.com; s=arc-20240605;
        b=hxlkhdDrRuf8VUzpnj6LVW9CIaHk02HFph58dyILGatybQH+vThW7BEuoWzcylv1Uz
         Cq68a7oTiZwsluI311MimRPfOHhrszNGnEbHIhWwYKoXjR2mZHpgVUW9CTx8V3saWjk1
         eBd6Uy0xctahanPlKt5283a25x6tNZ4wRkkgyFSXZKAORI0hM850zoyuDiN2Q/y72s/7
         c7AWs3jq97Tbaz27VLPwBH96t0sGx9Tzlgy9ecmKloS8fnoCoqmkGSGhlPcb3t0t6RYh
         uxh51GAYBZIFMrCh/1DzT496waL9Q8OBWrR+Ash5vhhfkkEpJfhZUvaXImTKnz+B6tH/
         tJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGN1QXrWGfa0Ptbu6IpRr4aZ6XJIz8upZWNXq+g2t9Y=;
        fh=j1CYaFIvaCUq88urJPp7lKZOvZoFGsDxixmFeciTlNk=;
        b=FasRV07UcVKkhxLRxUbwTazprL1c6Qm8fPx33VzqCgz1s6cEeqnQqXWUTZSBMCHoRM
         NKg06GmBuWMMlP3g7ZBbcYx2AtXnuqyOuZzzrsCiXGH8zvSzjIZls7SmujjA3+qyURab
         9LGDV5qCllX2ImKtPxpRpsKZjxnAj8O+M1Bta0NeZQak9LBlp0aWSt6A0zk5omEPbjWG
         JVXJY84HY3BRqN7SHaFbRFdNKSrQZ6RjGpi4xhZMtzakokJfexiKu2HiwXYMu3w9D4ao
         YUFoQVYAE/BcaOI7jEIvMosmbTGv92KxFCw6dibLeCKaa/sMfsmS594uqkiwoW3agVQN
         FDTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772854309; x=1773459109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGN1QXrWGfa0Ptbu6IpRr4aZ6XJIz8upZWNXq+g2t9Y=;
        b=Uh7IoBZfU/q6G2WetN7FbhvEb8eJJ5KfGMVrWCoKzXOJH5Y+RmtSMcVGINV3+h9/MQ
         kxcDS3cWn/C/Ne8oSDIkPIyDmlxPaN2uLW0wuKoN6Jl105pyO4C3ncYMpAYQWPNhweQB
         DInbduAtyW4qmURVmlGhqW+fAZLkbUfKQelCGYAdH5th0D/4XGtA/tNMqiMni6BYOsk7
         Ub4A5j3RBcJewjA5En4J4mYmwCqamDKOmo9vhV50AjU5ovugurunsMnGSsT2xqtPvHwg
         dnYRa+sqDOCPeYJdHTc4qq1sOZGhoSm0YeKuzLr2yYfuf6DMqtvxI/DOpuWG/4qJy3XX
         E2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854309; x=1773459109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGN1QXrWGfa0Ptbu6IpRr4aZ6XJIz8upZWNXq+g2t9Y=;
        b=b8RSPPWfaOCX0AChEBNE10ePG3g8N5y1QZltID9ZsrrAN8Q+JjkDJXKYB8QgCLXvuj
         GVvbR9W2UFQzGH165/nsytOrldmSCYPypX61W+VZqJl2yLVh1pOF1hMxOFSp1OKGJemy
         kHE71O3WjGpM9ZU+8EdG+H04SpuzElU4kvONEauktvUtm2taT5wc7zOHEckSvSKfDbIv
         635TNFV4XahcBCuz9EyibfQ971gs03ks65mB4y8fRcRT0zLOl68DhKNqddQ/cx5j4Fc4
         ONHJGNEi8MVMnRr1UfIwv8XxAF62Ipepi6AAtlJd181uFN2FHhprgAiqlC4L6GNFS/US
         t0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXcbd8g5DSnGmGC6lD0n8SZmyfWNhYeajKMSZXgy4egw+FDc36m1HczTsBwDPbDqb7dQic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/UPYAjn2hUIQm7v5CvfG9ArXuN/XlgsxbKdAui4SMCU1XRVW
	Fx+DRZ3rJd6IwPXRdaktDrODTgHoa725+xUdFU/I7dAzYjCbODO6Ls5tbWXNq8U4qZtLR6uIMHE
	qjzlDUckWyNUtbD86Ok2cdAhOYAu4eFg=
X-Gm-Gg: ATEYQzzUq8RMGSATKX8KRCmtl/hCvKO1k4+yaut5kdnbF58YCTq1VM5hP/Y+leiH/K7
	5NhS3FNLqusqZLj6UziwU+zzooPjzi5EcTITk2Skb5H1KoVbM/tCm3wX6LVE/n9y0Sf43u56yk1
	QANnHnNw+9r59fCi/KTxJJeSYp7Eez8V8ZVEOr/4fZZj8jkwGbekUfk5779/5tJ8lKAl77efau2
	YVueCnDltnhWadWPtWMkW9aEKTl8CI+wfl5SCIbcjqNJcCIa3UCv8PV4xqh4uHhNiGMCiGB4zTD
	TyJ8Fq4sxpIDvYDgylqg4Qs6Rqfqw2WMejU3QNSiBI/obzGUpHARpgcTw+8B3+C76+tsbGTRFHW
	mNyc4ipkI32TGp4LQlAGZqC6kwg==
X-Received: by 2002:a05:600c:4f49:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-4852696bfa7mr77938455e9.29.1772854308434; Fri, 06 Mar 2026
 19:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
 <20260306102329.2056216-5-xukuohai@huaweicloud.com> <c79adbee77ba5ce11d3df1ffa922c48937c8b536.camel@gmail.com>
 <e497dbd2-4f8e-45c2-b227-1bf0634dd924@huaweicloud.com>
In-Reply-To: <e497dbd2-4f8e-45c2-b227-1bf0634dd924@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Mar 2026 19:31:37 -0800
X-Gm-Features: AaiRm51L1KzVFyWBJNAti2LDkU1NC2b9xI_FNBZP_bxzn6yE9UJLt1vHg2IL8LQ
Message-ID: <CAADnVQ+EoVfSHwX_ni9krTEk7bvDZLfrzuCKEy46ZrASDBn-DA@mail.gmail.com>
Subject: Re: [bpf-next v6 4/5] bpf, x86: Emit ENDBR for indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:15=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> On 3/7/2026 9:36 AM, Eduard Zingerman wrote:
> > On Fri, 2026-03-06 at 18:23 +0800, Xu Kuohai wrote:
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> On CPUs that support CET/IBT, the indirect jump selftest triggers
> >> a kernel panic because the indirect jump targets lack ENDBR
> >> instructions.
> >>
> >> To fix it, emit an ENDBR instruction to each indirect jump target. Sin=
ce
> >> the ENDBR instruction shifts the position of original jited instructio=
ns,
> >> fix the instruction address calculation wherever the addresses are use=
d.
> >>
> >> For reference, below is a sample panic log.
> >>
> >>   Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
> >>   ------------[ cut here ]------------
> >>   kernel BUG at arch/x86/kernel/cet.c:133!
> >>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
> >>
> >>   ...
> >>
> >>    ? 0xffffffffc00fb258
> >>    ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
> >>    bpf_prog_test_run_syscall+0x110/0x2f0
> >>    ? fdget+0xba/0xe0
> >>    __sys_bpf+0xe4b/0x2590
> >>    ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
> >>    ? bpf_prog_test_run_syscall+0x215/0x2f0
> >>    __x64_sys_bpf+0x21/0x30
> >>    do_syscall_64+0x85/0x620
> >>    ? bpf_prog_test_run_syscall+0x1e2/0x2f0
> >>
> >> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++--------
> >>   1 file changed, 15 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 2c57ee446fc9..752331a64fc0 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -1658,8 +1658,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, =
u8 *ip,
> >>      return 0;
> >>   }
> >>
> >> -static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u=
8 *rw_image,
> >> -              int oldproglen, struct jit_context *ctx, bool jmp_paddi=
ng)
> >> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_=
prog, int *addrs, u8 *image,
> >> +              u8 *rw_image, int oldproglen, struct jit_context *ctx, =
bool jmp_padding)
> >>   {
> >>      bool tail_call_reachable =3D bpf_prog->aux->tail_call_reachable;
> >>      struct bpf_insn *insn =3D bpf_prog->insnsi;
> >> @@ -1743,6 +1743,11 @@ static int do_jit(struct bpf_prog *bpf_prog, in=
t *addrs, u8 *image, u8 *rw_image
> >>                              dst_reg =3D X86_REG_R9;
> >>              }
> >>
> >> +#ifdef CONFIG_X86_KERNEL_IBT
> >> +            if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> >> +                    EMIT_ENDBR();
> >> +#endif
> >> +
> >>              switch (insn->code) {
> >>                      /* ALU */
> >>              case BPF_ALU | BPF_ADD | BPF_X:
> >> @@ -2449,7 +2454,7 @@ st:                    if (is_imm8(insn->off))
> >>
> >>                      /* call */
> >>              case BPF_JMP | BPF_CALL: {
> >> -                    u8 *ip =3D image + addrs[i - 1];
> >> +                    u8 *ip =3D image + addrs[i - 1] + (prog - temp);
> >
> > Sorry, meant to reply to v5 but got distracted.
> > It seems tedious/error prone to have this addend at each location,
> > would it be possible to move the 'ip' variable calculation outside
> > of the switch? It appears that at each point there would be no
> > EMIT invocations between 'ip' computation and usage.
> >
>
> Besides the changes shown in this patch, there is another line in the
> file computing address using 'image + addrs[i - 1] + (prog - temp)'.
>
> It is at the call to emit_return() in the 'BPF_JMP | BPF_EXIT' case.
> But there are indeed EMIT*() invocations before the address copmutation,
> so a pre-computed address before the switch statement is stale in
> this case.
>
> To fix this, how about introducing a macro for the address computation,
> as the following diff (based on this patch) shows:
>
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1606,6 +1606,8 @@ static void emit_priv_frame_ptr(u8 **pprog, void __=
percpu *priv_frame_ptr)
>
>   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>
> +#define CURR_IP      (image + addrs[i - 1] + (prog - temp))
> +

No. Don't obfuscate it with macro.
I don't like INSN_SZ_DIFF either.
