Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0E38332A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595923; cv=none; b=Zh3KsQoOQKdVbEcIG7cO0v0xyUqM6rX1Wo2HtaugxXQzlRwHLZ4ZqdQq/ONpnpFY/3x+KhxFY6qINhcHOUB1XsxuBcUxRisuhgtuyx1Uuj15SByWIy1YZXma2XTnff3oINGE2WN1rtiSjIbL79ibU/NW9KgUrsY1g/bvN13xz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595923; c=relaxed/simple;
	bh=XDqu3ir8uCjUXMcTFCiuaDugRlIbGOwBTxDfcD7Mprk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uV8PbiFpQT/heF61yaTd56J4lB01iLiaZQcU68uFGo3d+r1VsBfRSIucF9/hhwQO6UACeC/aA2HV7hg9H3SEvPO7H2d/GF8xNCH5JvtiJSxyDjAoS8dvqr4Um4xUtXFGLmwXMMjMdRbI1fkG2GhpVx3+0JLL8uISd6DTwbD5wDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D62UHBHI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D62UHBHI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso4002601b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787595921; x=1788200721; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xfDfEV2qkpa4xbSOFqOL6y0p1nO4JV/7xWUfb7bdf1A=;
        b=D62UHBHI/+RkOC6WPICpgKj6164EtOoiVx9PZI58XZzh5WyDzyNuQWFAOK1F+SPLcF
         GFbI3mO0QpSYlrXCFOPsPvlpj118enQVrQSOafl3zjUsgFQIFHv55gLqNSM3UgB08H8C
         rl7XNUxdz+x3WEdYK1T9apfokjKtr9ne+yrOhyqaVHFq/cU23wjbfdwEe8AhRmpCEPsC
         J2FPjEKI/I2UoRhvjz/3+BpClHOyIuxJtRicdji/wGboJfI/wDgqmi/DPS31gRktUjof
         NLIIhp5CjZn8T4ehAIXWXCCNSTnqlvXWDnA1Jz5f8f6AvoQ7IjkAg9uK8PYdwifHUg8s
         c5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595921; x=1788200721;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xfDfEV2qkpa4xbSOFqOL6y0p1nO4JV/7xWUfb7bdf1A=;
        b=CTJEt4IB2PjsFGV4nPkkcvGqTftJDX7D+903IKskUGJhax5sQ4SENTF9hqLqhny7lk
         DqymSWcH+ggbLVI943SmLnjT9qpT9erWQeHqlvH76k1UeFto7+Cx6i8tuKc24kkqKL9L
         MnfAHPn8zWX8qpV6jhl/Zdtqvjlacx5D62RRxLSgd/97e33lcZ5P4O3YFDMh9zFJk/v3
         OWfHuwYc0bCbXfLXMq4KlTAI3BzagyRa8Mt3b3fl72VeyZMiXEdD3/EbCvLPmL3dXjP3
         xfcLn4+of/48Knbshqn6SVCyGyjxgMqWH+9LvyPVD6X8GbDmZ5f/6FdqVJxebrgdREm/
         efpA==
X-Gm-Message-State: AFuF++kAeeU3+YXkyezKzSTVtf7KwXHi/4PtuBgOXtLL56MD4vGYPBAF
	6hpuV7r+aZNqXp+LALNAYOsg5hhaPPxK+1UgKV/baGxbQctFF1iTULGR
X-Gm-Gg: AR+sD12bn8yBph8AR0YyrOgDQOq9ssl8TTQH0T4OLrz+HO+wERKnJpEyumzPCXFSVon
	yt6fkhqGJirqBOkJ60zftoa0It2fWx2JlGzQuvoztJlUOwT6R1iIdtI9XRZnzgM5weLVml6XHui
	n9thTJ77ro/oox4NUKPRfUReQz/2A/jd4ir4HwxLKCtKrVgVEsX8iBK+duUaOn0XGpYH6JltoGV
	tIc2bpuPGr5mzsxf530SJV+OaFswxqMspFotYeGAhyx0V2/cEfDVOxk1zyHVEhq5lImID6mUfnl
	DglI5reeGHB11fvPnkR74aR0YS8fn1xBiJs8zMmJKCd8hLHraHxZ9DMEV1SlGwpm0mVNXpkHseM
	IT6Si4wlDikd7xJsTPir1l906f5jO3mMzs1RH6u0m/oPhFeGddMqiw+VP3mAwbtxObpggBSj8r6
	0z7iyKtnb0H+k7ctr0xDCZRJ3lJxhGv7EIvFtsqzR7S4sxT9ptbBgPXM+xABAQtkaGUD9sO2TbN
	Ikiti76Rm7k7owBTcMNAHXhqG5RFqvhxta9G3e3MPofhAEBcnKljFCamt4aVg==
X-Received: by 2002:a05:6300:398:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3cd4bc4540dmr35582321637.17.1787595921100;
        Mon, 24 Aug 2026 11:25:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm25849886c88.11.2026.08.24.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:25:20 -0700 (PDT)
Message-ID: <20c41530282cdad1a15dc1c46c7fdd370f7373b8.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, =?ISO-8859-1?Q?J=E9r=E9my?=
 Jean	 <Jeremy.Jean@oss.cyber.gouv.fr>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 24 Aug 2026 11:25:18 -0700
In-Reply-To: <e2a7e092-df3c-4f92-8f12-5eb371f004df@linux.dev>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <5d02cbe3-fd71-44e4-a6dd-706233ba248e@linux.dev>
	 <9f50810d45db0b60248f106d21b4a278f3ec2156.camel@gmail.com>
	 <e2a7e092-df3c-4f92-8f12-5eb371f004df@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 11:27 -0700, Yonghong Song wrote:
>
> On 8/20/26 3:32 PM, Eduard Zingerman wrote:
> > On Tue, 2026-08-18 at 08:23 -0700, Yonghong Song wrote:
> > > On 8/17/26 1:48 PM, J=C3=A9r=C3=A9my Jean wrote:
> > > > Helper callbacks enter BPF subprograms through bpf_callback_t, whos=
e
> > > > runtime ABI supplies five arguments. BTF validation nevertheless pe=
rmits
> > > > static callback subprograms to declare more than five arguments whe=
n JIT
> > > > stack arguments are supported.
> > > >
> > > > This lets verifier state for a callback use outgoing stack argument=
 slots
> > > > prepared at the helper call site. The helper does not pass those sl=
ots. On
> > > > x86-64, callback loads of arguments seven and later therefore read =
the
> > > > helper native frame instead of the synthetic values checked by the
> > > > verifier. KASAN reports a slab OOB write.
> > > >
> > > > Reject callback subprograms with incoming stack arguments when proc=
essing
> > > > callback calls.
> > > >
> > > > Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf function=
s")
> > > > Assisted-by: Codex:gpt-5
> > > > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr=
>
> > > > ---
> > > >    kernel/bpf/verifier.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index fdc5fbb1f78c..5fcefc0eaba0 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_veri=
fier_env *env, struct bpf_insn *ins
> > > >    	err =3D btf_check_subprog_call(env, subprog, caller->regs);
> > > >    	if (err =3D=3D -EFAULT)
> > > >    		return err;
> > > > +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
> > > > +		return -EINVAL;
> > > This is not good as user will not know why it failed. Your v1 does ha=
ve an error message.
> > >
> > > But this is not needed. Without above verifer.c change, user will get=
 an error message:
> > >      func#0 writes 4 stack arg slots, but calls only require 0
> > >
> > > NACK, see my v1 comment: https://lore.kernel.org/bpf/14a7e7c2-36f7-4a=
a2-9b20-cc54700a9f1b@linux.dev/
> > >
> > > >
> > > >    	/* set_callee_state is used for direct subprog calls, but we ar=
e
> > > >    	 * interested in validating only BPF helpers that can call subp=
rogs as
> > Yonghong,
> >
> > this is a real bug. Here is an example of a program that exposes
> > unsafe behavior:
> >
> >      unsigned long arr[10];
> >
> >      __noinline __used
> >      static int callback_9args(__u32 index, void *ctx, long a3, long a4=
,
> >                                long a5, long a6, long a7, long a8, long=
 a9)
> >      {
> >              return arr[a9] % 2;    // verifier sees a9 as 0 and allows=
 this memory access
> >      }
> >
> >      SEC("tc")
> >      __description("stack_arg: callback with incoming stack args")
> >      __failure
> >      __naked void stack_arg_callback_many_args(void)
> >      {
> >              asm volatile (
> >                      "r6 =3D 0;"
> >                      "*(u64 *)(r11 - 32) =3D 0;"
> >                      "*(u64 *)(r11 - 24) =3D 0;"
> >                      "*(u64 *)(r11 - 16) =3D 0;"
> >                      "*(u64 *)(r11 - 8) =3D 0;"
> >                      "r1 =3D 1;"
> >                      "r2 =3D %[callback_9args];"
> >                      "r3 =3D 0;"
> >                      "r4 =3D 0;"
> >                      "call %[bpf_loop];"
> >                      "r1 =3D 1;"
> >                      "r2 =3D 2;"
> >                      "r3 =3D 3;"
> >                      "r4 =3D 4;"
> >                      "r5 =3D 5;"
> >                      "*(u64 *)(r11 - 32) =3D 0;"
> >                      "*(u64 *)(r11 - 24) =3D 0;"
> >                      "*(u64 *)(r11 - 16) =3D 0;"
> >                      "*(u64 *)(r11 - 8) =3D 0;"
> >                      "call callback_9args;"   // this hides the callbac=
k call from the check in bpf_fixup_call_args()
> >                      "r0 =3D 0;"
> >                      "exit;"
> >                      :
> >                      : __imm_ptr(callback_9args),
> >                        __imm(bpf_loop)
> >                      : __clobber_common, "r6"
> >              );
> >      }
> >
> > J=C3=A9r=C3=A9my,
> >
> > Please update the test case as above, as your test case does not
> > really expose the bug. Also, I think that a better fix would be to
> > make stack arguments not-init in the callback frame. This way the
> > verifier would produce a proper error message.
>
> Okay, I see. The key thing is the below:
>     "call callback_9args;"   // this hides the callback call from the che=
ck in bpf_fixup_call_args()
>
> So callback_9args appears twice, and bpf_fixup_call_args() only checks th=
e second callback_9args(), right?
>

I wouldn't say it is tied to callback_9args() being called twice,
it can be some other function with stack arguments.
The check in the bpf_fixup_call_args() goes as follows:
- if there is a subprogram that writes M stack argument slots max;
- and only calls subprograms that require N(i) stack argument slots where N=
(i) < M;
- then report an error.

So a presence of a subprogram call with 12 parameters would silence
this error for a specific subprogram. But this is not related to the
issue at hand, the issue at hand is that we need to correctly model
that stack arguments are not passed via callbacks.
