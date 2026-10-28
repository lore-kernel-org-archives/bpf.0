Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793152542;
	b=YEG21YooES8jxUAurZybxALcG/stsDVnMHdSkIHfz5KCdxedZ7zED8BZRyrv6dlOdBx2
	 oiE2VgmT2KiYSZbQxTRzClLriRUih9UnTaUQGblxeEwcIp/5m2LMf1DAgC4JFk1FSy7bs
	 91DZFr7ErtNYlZAmoP6RImJuNmM+k9fIQx4qeF1wxrSDgs4LRwQ/A0u6xTKwcZV2DmS9K
	 dFzICwsGizMw3fQ0LXkZ0/j2tE7NgtcnKwQPkbW9qSnNGMLsSc6ehH4/6yLMKwwgdRDB6
	 aUw9iCVmnjinVQP73mIxrKVFHlpHTXqNz6GTYCyI9bLurv7BZyz/Fgm3x3+3sdIrRhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jvfh1qeOkznspVxQfMXkt9Tg2caKCz4yBpkmoL1NbL8=;
	b=DfkdpVixGftIQjmxHKs+CW2RrSID1VVMzUKlh6FKwi780suPOzQ/X1nxTcowq0CABfL0
	 0lUYKtvM+tX2yLVlJdmo9TrSUHSwfrwKK1/RT4JL3ds8iaQlNOFYBSOloMdqJ4FBjvXlV
	 Txte3yP6Y9WDs0iy0sMdJOjkyNFivl4PUeyLN7As1Aj6T1g6v3VGimRnkXJOnLoSB5K0H
	 dwgcevXcXj2hQkRNiHx2pFjIrkOmdl1JxNvjUaL1bqEUQl9B+yORrYZD13M2GbJwQWS6m
	 fmjgP54BjEKh5jHxxE8j2ibFirgZIa2f6MbirmuoEdtfNZijrP8vrt28tHv96ZM6O+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="j80j3/w9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9A606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=j80j3/w9
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677af43eed4so532545d50.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793152541; cv=none;
        d=google.com; s=arc-20260327;
        b=TxRuv7K5C1gQ3OVcYeHpRPom1op8XPEdoXQw7XgJByLOKlh0RpNlVCERxab9H3b1Ez
         GtiVatqy2JziH2X14dEWTIaLITuNYRTE5exVsH8Y6kxM/Imquq3+H+IzpKtk2NVpxpzS
         ybYeKXi5f6/kp0cbSyBLOZ1ZvIKjyAgA9bMScuYzpy9ZK23aSk5MdpHzT1SQfzJO5YpM
         /914FaFk+0YnGKxkWpOeqcxt1VxQSKYjEID6oBvtZXvq/wYq+/6zbzRHglaMyHXkdbQC
         epJJDFJJLsIg5MeO+wlUAi2rJmXKqsmTxcYnfFRzBfaKTuA13KVe7o6pDS0NY8b0Yw9U
         TfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jvfh1qeOkznspVxQfMXkt9Tg2caKCz4yBpkmoL1NbL8=;
        fh=GsizxCaGQ2nVZN5bHfNu+gnasnbmBAOTZ+FBDFs+xqE=;
        b=N4I76j8wlkiSZ5Hnh3zMJHS6WbsMc3s6wqs+0Qqt/GzO4TLBw8Ot9J9n24bsKFMYhh
         Kr+LNh1rszKRDTMi9TfUbyuUmxNi3kZse1knOBk9/mbTlGI1ZAE2XH50JK05PWurU1xd
         bDMTOVXExTIADLdznrv/B+BAGa2xjpfVpGUXHEraDHqu4bTtvzhCCbLsTA1fbOdvhkt4
         v5wTa+SGr6JpuYN8Z3mH8FyZLCYjw7KM5IqX45DFJqaPa/w1lFppxmDYa8JXA1XYLDLC
         Jl4veA8+zFRZedfgmFncX96NQ5l1edh3YeI6RcUNqsqe+m/HkUmS2EpcEAjY/SYCS4xw
         sLdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793152541; x=1793757341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jvfh1qeOkznspVxQfMXkt9Tg2caKCz4yBpkmoL1NbL8=;
        b=j80j3/w9ZEihPH/dZecWaWulveRVoDUWlFUlsIzYPCbpMTF42+nBbby+EHNaP2hDCG
         4edUcKqiF1p1gPdOriTMq0CGew8DcWIdgi4jgoyKcVj0nJHDT/QjP4xzxSmU3TnY51uW
         KSNsKLumc+YFJSS5f1+7llI7UA4Of+y96Du29Ulm9Q+C8XIQ3BA02R3qCIR0oCIqMenj
         iAogc60OnF+Kz78hLSsFyBk6/h0GxmBZa+xLNCPHvPsg5HPFg8sbIeYjM3jVaQawHNQ+
         O/bBR8+a6nmfO4pyQL40TFonb8pGvgwgAuhiDs3FCvVCKj0gkNiZYsOgOKbZCQL2Cz7p
         16wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152541; x=1793757341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvfh1qeOkznspVxQfMXkt9Tg2caKCz4yBpkmoL1NbL8=;
        b=GOkA4YYp4vWBzp16qtUmDA6ae+hN0kNJYuLnYaLTJ2N4rdb3tQuEWlhwj1aMXqX+/B
         NUmcagI+jQMNOpzF74rQy900va/CCaF/D2xhHUilx1vgFe5eiBV06hRwpAUVblLDfrmx
         Ly2a9omjUrVyw+QOKNyS6E77M7VC2CGBTrLsMUoFoKVNveEKlh6fOZWKVl8siEFILnCG
         On52j1bmRFVtkY2OhUSEmA95OJ+rImwPITeKBH3gAMT9Vlgw69Ur5KexJEIM3u6fDJxJ
         o931o1tGqG2ggwce2/6UkNmW/Jp6SzRbOgSaRxpOlNF1Q8SVN6xRX8VAoiob2RXCfxku
         VqDg==
X-Gm-Message-State: AFq9FYLy3gExvcnYunuv4Ah/YDfLtqFFhn4+ZQy5x5h1kimZiwebQ7hM
	vWM063LwsVsG2zaqHmDGCoEgM+6cY0iaDgvggTq5rdPgjIUs6lo3iBBBTly/SXX/IfmD53eo7qH
	wzQMdwTaq1saPDzhLn1cdp7h+zVVX9YIdd9vYOSwwEA==
X-Gm-Gg: AYBFou3bRDq3zEv7aUTE025wg+nzy7FwOaC0fJXqIFBjt99AgowbUTVIdRY3SSw5I00
	7QRvPUttKPnqrpxXX2MwHTn9uWU4V6TqjKjAJRgi0BkndamHTQ2hZg9seJa8Ees4kF1EBCH8ho+
	/UQy6+WoAbYr6LEs8ljPksWgSz9SqQ5Koaz086YBJXcQYUV+H7+iIrDjqfxQDvVZ1kVkFJCFLYb
	pLmuQTiVPnqXW4qhtyso80c1cWwmTFQCVBCimH5VdvzpjYCStxrpbnEijD2o2dd/6+3OXH71f7j
	bLlFduhDXmTnr+T+DNe0QBKyCOuYV9R5TWUcX44vUgrmgY0MxU4AoeJwE36umuRXW63sWQ3tqwk
	fRUsZYZyFDDD5Jh2bKiGCX4VyqYwOz+FalASu3CIHS7sSgeMdsaJu
X-Received: by 2002:a05:690e:454c:10b0:679:a74a:d3b7 with SMTP id
 956f58d0204a3-67a7bd313f6mr803343d50.39.1793152540853; Tue, 27 Oct 2026
 18:55:40 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027162820.10887-1-emil@etsalapatis.com> <DMFRZIXSG0M2.YYE6X1OWNQWL@gmail.com>
In-Reply-To: <DMFRZIXSG0M2.YYE6X1OWNQWL@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 28 Oct 2026 01:55:30 +0000
X-Gm-Features: AclHuK-jA6kXCPfd8fXeMm_qXTtEIeCoYmZahiOti5hAMvkXqaXjFYGZB9MFlog
Message-ID: <CABFh=a6PxhNKnQ7KJJ9TbWhLg_GOQYWPxe3QSEAGEMTQ=o-5Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Inline IRQ enter/exit instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 27, 2026 at 09:28 AM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
> > Add inlining for those functions. The inlining happens in two stages.
> > First replace the call itself with a special BPF instruction denoting
> > an IRQ disable-and save, or restore-and-enable. Those instructions
> > are translated by the architecture-specific JIT into the corresponding
> > operation.
>
> No. That doesn't scale. We cannot add new insns for every to-be-inlined k=
func.
> See bpf_jit_inlines_helper_call().
>

Ack, the code below seems strictly better than reserving an instruction.

> Like:
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 6a2fe3d..c1c9a1c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3495,6 +3495,17 @@ populate_extable:
>                         }
>                         if (!imm32)
>                                 return -EINVAL;
> +                       if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL && bpf_j=
it_inlines_kfunc_call(func)) {
> +                               if (func =3D=3D (u8 *)bpf_local_irq_save)=
 {
> +                                       /* pushfq; pop [rdi]; cli */
> +                                       EMIT4(0x9C, 0x8F, 0x07, 0xFA);
> +                               } else {
> +                                       /* test dword ptr [rdi], X86_EFLA=
GS_IF; je 1f; sti; 1: */
> +                                       EMIT2_off32(0xF7, 0x07, X86_EFLAG=
S_IF);
> +                                       EMIT3(X86_JE, 1, 0xFB);
> +                               }
> +                               break;
> +                       }
>                         if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>                                 fm =3D bpf_jit_find_kfunc_model(bpf_prog,=
 insn);
>                                 if (!fm)
> @@ -5116,6 +5127,14 @@ bool bpf_jit_supports_kfunc_call(void)
>         return true;
>  }
>
> +bool bpf_jit_inlines_kfunc_call(void *func)
> +{
> +       if (!IS_ENABLED(CONFIG_BPF_SYSCALL) || IS_ENABLED(CONFIG_TRACE_IR=
QFLAGS) ||
> +           cpu_feature_enabled(X86_FEATURE_XENPV))
> +               return false;
> +       return func =3D=3D bpf_local_irq_save || func =3D=3D bpf_local_ir=
q_restore;
> +}
>
> ...
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1..26b6a9d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -5197,8 +5197,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_PERFMON)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL =
| KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
> -BTF_ID_FLAGS(func, bpf_local_irq_save)
> -BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_local_irq_save, KF_FASTCALL)
> +BTF_ID_FLAGS(func, bpf_local_irq_restore, KF_FASTCALL)
>
> and corresponding bits in bpf_get_call_summary()...
>
> but before doing any of that there gotta be performance numbers that it's=
 worth doing.
>

Makes sense, I assume you mean more macro numbers from
production-grade programs apart from ubench numbers.

> pw-bot: cr
