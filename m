Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330C25F988
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962140; cv=pass; b=QxsSvN96ZLpHqcu47VGxo4RFnaiF0RTNYRaKZKNxDGrQAUrZuM5AXebpOLTUVqzUN9hHgRus42hsfWI3lta8QVHI5xijBaOPJfy/yCi3TH+bpPIk4HsoRTTlQkNEDNHEamH7hrcBZzXu/Wn32yhqyPQhDvPFJJtwtHRMxCzOjtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962140; c=relaxed/simple;
	bh=88pCCXXugUUJuucVAUR1M8sAMLkWfKTmmS40YDWPiPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoUPIeOrT10vsa88iyyljKPuxeEJOHntlaU4XgMehTgWvGD3Gef3hEoF1V/jbnysvRro+AdbNYja/aow4/ol/x9Lz+GRNvd+xHV4DQkDDEc/9FgTg17YllmR8gsqBOR+Q0vLsuQMtMLsWrBe7k1Q+EFObe05T8mZ8b7CnLkzVGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKGd1L2I; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKGd1L2I"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4398d1f06caso493022f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:42:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771962138; cv=none;
        d=google.com; s=arc-20240605;
        b=NkTtrhpX3ukmNDQxfJmjChslkYndTpI/gGSyqCTm/oIr3X/EE4kLXQ2yroON4l+KYs
         blCdpx6HuD5LfPU95QVeFTTMRu6oLNZ5aYdaTbJaJejCVnUTxMDoFunbAdaIv5NLRUft
         u1HcJXhyeor7OOdxM9Kxlqgr6oz261KHRaUllGwJ7r3WDaWG40FxrKAHzqsmfFWD7B1x
         YqUJmry+Ru/QCeMOxoVN7bHOESg92mwGRM/9Af/UjB8e4qCsRHpt40M7BfQ031yYEj+Q
         OsvVMOFDpoMqxVZhbuaeu1awuPSMCc0pHQAFIHCjhy+//IvldLKRXyFCO9znv/Y0mD46
         /qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NjGnpf57436m0UVBKLKsVuNC8V3Q916nGrvH49ppEqc=;
        fh=Gb0MnzH43o2cFaag1/VKU0fpjo8vwbtzRZooWNb2mso=;
        b=YPEew/Gct7dY4bS/r8uHyqJkegV1pmhEwur/Ytr2Cn5uptVk1dDodW63lPaFgraYa8
         esn3yqYkT17mlPsUns2j/xi1woPz7iFnyORuxds8vr6GnTLb+7+Lfs0Fhhprp13bZKeG
         SsDDxvaBP8Cp4iIWEgdEoOfAhLn+vUulNultu3AaF19KSyy+EiX6ETUBo+GPlceVTeXU
         mzdT40hM1yt6WeBu04sxD8yT9/fEB41nLGGxZKRq+SJ4UPiuUAPly2+CuZNtv9FO+YY9
         ZJMkojEok8gOD4lHDOJLC20wfoEj/1GkawPR2blfLScxu2QigtIAIfmPsdknkNGXQuz1
         7y9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771962138; x=1772566938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjGnpf57436m0UVBKLKsVuNC8V3Q916nGrvH49ppEqc=;
        b=BKGd1L2IYMNzc2uz3Eih6dCkUS8EHScukcAnyHpYu3R+sTcTnisTH5IndhR+/q524m
         nBhCgvQ+KOF1wrezMyfMM0Y1rxW7VJZ1W+3x34REwE53eBMBVwewpxDVarzrDMdjdpLV
         t9ecEdQOpnpcoVFTopLyawKDzkHVo7idBQSHMhwjZYdWs10p/cpRPz7UD0FYkxprje2X
         T0O3guzj6pJvgzeDrTmts7x67uu+1tTq8VBRnDMspDoQQQxX69P1cDKizCHuJyvwXoRo
         E5gWfGFvv+x12VcBa8KumdTLOcDkenC/stUh5+lzWdUb1Dv4HJCvKOEueisW+WLeqEfp
         2UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962138; x=1772566938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjGnpf57436m0UVBKLKsVuNC8V3Q916nGrvH49ppEqc=;
        b=N5Vts/R1Hd3dIWMZqcRe7BK0xRvQt3O9mxPOETnGEO2+JlGBdOvlyWaxT3Z4Q+g8CX
         yWUI+6hH1gBHyJrDlTNQV2HLP0+7X0AJmGSyeHaZvjJRm6+DjyHBoyBAYSwPIas/2zO9
         ujxiombIV4BE3poYc91ohHLHowNcNrdQcbpHOI617t0xuk66nGG+T+5K0c8mpzY3Oxog
         bUFogk66JYUnkDpfnoSVylXhXqGdC+0gnqHJzQbVi1KQ3WAujq3vhQJxLTKpklHSbccS
         GC0CFL2jjImVhSaigG2Oit0wqmdOVjaPaBsg4btlQUSQwdJR72CKikDxo0C9o6SZLw1d
         4AGA==
X-Forwarded-Encrypted: i=1; AJvYcCXxZVzRL1zlAulc9ibgDW2281PigdulvCXXrXwCiboGcb/EFArRJFSROUyIiSm4VIw8ke0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrimppgs8sGQA4AloaBfDDHWzMkOrVvwECWCbTpWpdixEa8Kcd
	9dzq1vHlU/M8/QnWG8FNMtaetAaDvk1mPUMgHdDCHyWIvqAXcvfd2jfH5zZN5N0QdM/IIqT1lEv
	q5tBgjSnKsTHHJzRKJ5j01Bt1B6xwTx4=
X-Gm-Gg: ATEYQzxnMdfcgkuObGoesWffy0CkkRrp9FeIfXVZXyjZWH1GFdTQxiKeHy/vH3l9IF9
	0ESUJoB77kBgtlW74FDz/Jnsybktkp46fDAJVBZaGPp1jFGJHS/saqszRU2s2XOm0jT7FYDBmwL
	/Y0PJXeycuy6It+2P4ad+PL/KRyFguROAPROsExxnXoCG6wkFsAwuyZ6Uw+0JipQBvTMIlX8Z5k
	1LkfiP52CmFVn4YdRWQj+3YdGROV7poHy68on/MrPDTc5dF0S3EtAwpb+9cPjqEuODqcuhq7qyB
	Ci4jz+Z9vtQm7zvdfzqiH50JKt+CI3KeDFVfsthcdrG7Nrf89ca4Kqbjr6Ky
X-Received: by 2002:a05:6000:2486:b0:439:879f:f8f5 with SMTP id
 ffacd0b85a97d-439879ffb04mr5543916f8f.8.1771962137643; Tue, 24 Feb 2026
 11:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <20260223174659.2749964-4-puranjay@kernel.org>
 <562fc6aeef17412ba8965bc4938fe9c0dbbe0f9e.camel@gmail.com>
 <CANk7y0gjg4tCcDvoK7nwcjw-w2aPtjDiJCdPvqRHS0Wvce2wiw@mail.gmail.com> <20ec0bf67e3664eeac349dde21bdda2d3546079b.camel@gmail.com>
In-Reply-To: <20ec0bf67e3664eeac349dde21bdda2d3546079b.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Feb 2026 20:41:41 +0100
X-Gm-Features: AaiRm53VIzRktW_VjgYCA3fs-pFUo9wn-dB3tAmddEsR386xel1YirRFywu-qxk
Message-ID: <CAP01T74Sgj8dgcEavYPLuK_y7qH59xe7udBi9BwDqTyuaikhDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 at 19:17, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2026-02-24 at 15:24 +0000, Puranjay Mohan wrote:
>
> [...]
>
> > > - remove the following check from do_check_insn():
> > >
> > >   >   if (env->cur_state->active_locks) {
> > >   >       if ((insn->src_reg == BPF_REG_0 &&
> > >   >            insn->imm != BPF_FUNC_spin_unlock) ||
> > >   >           (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> > >   >            (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
> > >   >           verbose(env,
> > >   >               "function calls are not allowed while holding a lock\n");
> > >   >           return -EINVAL;
> > >   >       }
> > >   >   }
> > >
> > >   Relying instead on `sleepable && !in_sleepable_context()` checks in
> > >   check_kfunc_call() and check_helper_call(). (As one more refactoring patch).
> >
> > But removing the above hunk has other effects, this check is not just
> > about sleepable but all function calls under bpf_spin_lock. Do we want
> > to relax this now?
>
> Discussed this off-list.
> The side-effect of this change is that calls to any non-sleepable
> helpers / kfuncs would be allowed while holding a spin lock.
> This should be fine, but probably belongs to a separate series.

I think there are some problems with opening this up, e.g. we can
deadlock if we do bpf_map_update_elem that takes the same bpf spin
lock as the map value.
Definitely shouldn't be done as part of this set.
