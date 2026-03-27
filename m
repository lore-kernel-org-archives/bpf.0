Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E63F20F4
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622076; cv=pass; b=Z85WyFPKYvUOiApEm9W2vRmWWwp5Z30aO4K5ElsmBskpf762kGpRWziUdrTG+zG3fz+oDsGUJ2c3sqoXRwrYDH+tZIksdmd6Q3i9/UEK2aLfTXNBiCzlDz3vLSCk9z+hEMVHbsvoIR+u8dvK50k1kZXTK6v2m+0LxB1t9sk4aNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622076; c=relaxed/simple;
	bh=pdoBgUWmVL04SbS9o1vxaIom96sgyYdDB3fSjDPEhtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwHnOAPs5qBdhThaqfQ1AJmzIba7Zuz/1XdRzYsvZirG5ilCswqjKgaroBY5wB11vd+hH5A/jRVx+Kv4zjLpXf44Eh3xiieBlk0Y4mocO6nj5B4i1sxPoIeJ4fJMRAdbFQkBnO31WNjWf5YNf6FnLRbr+QX8qBTC3Xn053oap9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlYtthjU; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlYtthjU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so825445f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774622074; cv=none;
        d=google.com; s=arc-20240605;
        b=hByTJ+CQuQxCRpdzWfPh079Pa5QaghBoKvL/xkub9V3ha/NyshYZJn1mk8bjt2EqrK
         kYZ/f9H18q+bP+PsD18EMlNJevWnIi3lJ1QAyx5j3fTylZhLKG9IqJWgzqpNYe0EkUg2
         o1FWc9m10ofx9as2htRYXjKa+THPlpzxvvpnb9kFRVzSN9ZzouYMwtn2YS+DtOBk+5Fy
         oIejw/CH4FTsv1mcKIgbevRFKTB2T8hZeDW7YWkG3/47frmNJ7lJXK8ZDlaSqNVCgfAf
         DFnST1KbrmquR1X7A2IqkEHRyaHMXe2lt0qCo2Rb8IjqfpwiJlfB5+dgR0TVK8A5uSqD
         TCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyP+e4Fn9FDvoaJNG5B1U0uuJYtJY5heCvBJDGiFHi0=;
        fh=F06WLmvmWB+m3Ma6eou0oChwEbnEYdHilvZ2klpXswA=;
        b=fP/Yjm1PveP1a6rrJLHV8G0bpLRsnahMIEOSu+G7UghR4JRGVis/s3AiSv5N0qH93G
         h67QB7aVEvxfkekD9ke3IfmQix4+FGAILFCeuvCyEvm7CeaBVRKMmUpQS4Y7/qGeJKUO
         kF+Tm/Fn6R1cloHImkZ2XgixizTZ+U4LI5z4Q1k73SeEJz8YPd8zyHSkGmKEfvsdyfsF
         lnH+oQ/wn9uaHBJnbeHFVjOiuC8kQoXoAg4ATJDolSwT57Kl/Zk/xtQtUWk3mDdJW7cL
         a12Wso7b9slBlb80brSHTJdxoSjDeUyX88h7T38yVP48ciz9mwAuLjGlBoQaopC+xh3h
         eAtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622074; x=1775226874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyP+e4Fn9FDvoaJNG5B1U0uuJYtJY5heCvBJDGiFHi0=;
        b=dlYtthjUAYdoIqSvhqi5VUCxnALcfR16zPGsiu0Ap6FyhykYgtjSdKEf+72QOL+YZE
         YPQhE1Don/11mv/oK7Me7pFe1n5K8P3b19mSoFfKl8P0BOzy2klUtNlUhGzeRNEa3f07
         pMiomkHosWOuiTFpAq4DjkIfdffbRAQ3vA3fxWLz5w3uxLz1wRSMVNJYCHh8OE0S6tEE
         Lq1f2lyiTMK2SRLNSf0r58Rh3p2AhOBBcFAXpCOPDSAs/r1UfFtbW/Nxx9SZHV0wEYli
         nICsCzL0txHN0xozJ32aOYX09bRSq8c1UchrdnmWEHF63Gv39m3PLR4vtdwaSIcbQFNo
         Vu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622074; x=1775226874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyP+e4Fn9FDvoaJNG5B1U0uuJYtJY5heCvBJDGiFHi0=;
        b=JNY75+Q25o2Ptj0ZnMk8uOq/5fkugQbyGcEIQ5f017dCirWqUhghwNo/Tud2Iw2R2Z
         AGj1skbcvr4aWjUQXS6l+GE8pdDvV36zqNZhcpmQqJkLwFRmuqrL4zxfD2xSRtlsin0r
         PCIsY9mVIhyWoAiQXbFjrwhjGmyRciI6gBwnTUQCQDrXc2IkiJwnCS2SCppzI2qY8/cw
         DN0NnRPYjoHPNVI1zRJvH7XICNr5Wrst6CHtbYBN0WBWRcZQrcZQC+RGUYl5MjBpH+ox
         NVyK89XsLeFFS98gbvZAsp5lvYm41c9J9hs+rkeWBp6CkySfwTp/Ec0U0BsZtUC79Jvb
         KUtg==
X-Forwarded-Encrypted: i=1; AJvYcCUL3qsyd6E9SGpTieBcsTEMI7QCWgyW9T6rfC4nzTUTtCN9IQLbN/G0KCTV/OugLaWLH+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtlu2zYYW7gaBf+aWx3sbMdRzL3lFUKsLTfgAYTkzl/1E0GSX0
	cnte56+r/q+pM+OaASWWTFL0+eYgdSiEZApAcTnVYcSiquhSkGTgMbvTc+jQ78JFac4xCuJZ1HC
	hdcUtDJFN65I9vB1xu/tNqQtaY/LfqJQ=
X-Gm-Gg: ATEYQzybTvGpaL8crNcsxndpLHg9vKM2/VLX0qvrIbuaWsaMvXIz9rq+f4TILK+1fKn
	V7A46zgAAx273Zh1dQZAQOYLo2oI/P72PTb3uAlu5E6UmiVUBziJxYdcK2ZbJRv7D7CTwahIBP6
	JW7S4/O3ficr4oGv89/4SYL6bl8QYcBfNwRamOzomLfprxwytktVEN3QMoFG9PIE1BJfEPMQ3GK
	6peYDoZ5sYT8x4tD22TJWemsv6/aHtF+ljtigTv9qvCgstUjEnSzMuGQaVesV49IM/YnjOhCQ79
	IlFwAVzcgVasVbMrFJ9JH/kt5M3jQ8TD3yFQm78UpHGwYiOsPqj/w42AFQdYsJOx2EOeXaGk993
	TxtCSKY8oGS8JUoefOj6xxp/gR8e2+59i3K5z
X-Received: by 2002:a05:6000:26cf:b0:43b:4921:8745 with SMTP id
 ffacd0b85a97d-43b9ea45e96mr4740369f8f.21.1774622073610; Fri, 27 Mar 2026
 07:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327002759.4033863-1-ihor.solodrai@linux.dev> <9df5e40dc601aba53aea886e4087aad98d3987ef1986f6f1145da63ee8e43eca@mail.kernel.org>
In-Reply-To: <9df5e40dc601aba53aea886e4087aad98d3987ef1986f6f1145da63ee8e43eca@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 07:34:22 -0700
X-Gm-Features: AQROBzD2Vo4_4v7mqV7D1t-E8M11DMAYhvRFKadf7WqaynJPSOfB2jBlOpX2_vU
Message-ID: <CAADnVQ+bR_ok2NX-expiDiO3_aaz1chr2RZFWA9MPgiTnf=G2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: bot+bpf-ci@kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:15=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 11207e63c94e..33f6c226d528 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12369,7 +12369,8 @@ enum {
> >       KF_ARG_RES_SPIN_LOCK_ID,
> >       KF_ARG_TASK_WORK_ID,
> >       KF_ARG_PROG_AUX_ID,
> > -     KF_ARG_TIMER_ID
> > +     KF_ARG_TIMER_ID,
> > +     KF_ARG_BTF_STRUCT_META,
> >  };
> >
> >  BTF_ID_LIST(kf_arg_btf_ids)
> > @@ -12383,6 +12384,7 @@ BTF_ID(struct, bpf_res_spin_lock)
> >  BTF_ID(struct, bpf_task_work)
> >  BTF_ID(struct, bpf_prog_aux)
> >  BTF_ID(struct, bpf_timer)
> > +BTF_ID(struct, btf_struct_meta)
>
> KF_ARG_BTF_STRUCT_META is added to the enum and btf_struct_meta is
> added to kf_arg_btf_ids, but neither appears to be referenced anywhere
> in the verifier.  The other entries (KF_ARG_TIMER_ID, KF_ARG_PROG_AUX_ID,
> etc.) are each used by a corresponding is_kfunc_arg_*() function.
>
> Was this intended as scaffolding for a follow-up patch, or is
> there a missing is_kfunc_arg_btf_struct_meta() helper?
>
> [ ... ]
>
> The commit message lists 7 kfuncs accepting void *meta__ign:
>
> >  The following kfuncs currently accept void *meta__ign argument:
> >    * bpf_obj_new_impl
> >    * bpf_obj_drop_impl
> >    * bpf_percpu_obj_new_impl
> >    * bpf_percpu_obj_drop_impl
> >    * bpf_refcount_acquire_impl
> >    * bpf_list_push_front_impl
> >    * bpf_rbtree_add_impl
>
> bpf_list_push_back_impl also accepts void *meta__ign and is converted
> in this patch, but it is not listed here.

Looks like AI is correct on both counts.

pw-bot: cr
