Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF8214812
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638661; cv=pass; b=TE6IM9Ma4bm8XFh/XkE+/h9RW+baQe6regg1uhj1p10u0hjAeTNVk5UPbJc/KqDDUTfOK3q/a4CQGArnbFmLKm+aJBsTulXy+SFKAsrBjQA3AnkNmQttxw3AQzV3mfehx1CFX31FFXNjpIZ6//xPnxVR2ud4bR2jTIfljc02PZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638661; c=relaxed/simple;
	bh=+GGtYv2SQ7TNNCuCsy8O+Ee3YuNFOiRuO6paGiCjpOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPQS0W6fPR30/du1FapsKsrdYGCbmZ0cuVSkKerDLQGV/QeX3wADqi7abTFjhVY0XrVvmYWgK1iyflaC80ia2jRivjfIdM5czrosep6uBmK9udGMNa2cQi+aXvVKS561xf6o6UpK7EHbDqwgnVh4z1wGCWCSC0U8iIpz+O1i8Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzF4bsrb; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzF4bsrb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c4a93841so1048620f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638658; cv=none;
        d=google.com; s=arc-20240605;
        b=Bf46jSWRUBtr2btxO2/MQ8mAXs/x0I8S1xLcYbQCahj1Rr7yJnqQUOCE5aywXhe6MN
         BChXCd0V09OanV4Kw51XKzefoLC4iP7PneUjCcFLfUYjQuCm2docQkOo5GMw/3Yg8LQf
         fbNxOccNu9mJCu6CG86+WjL+EcsnqNT4Al8VqFoxvord+vqqBuuA+VSevZ0wpS7gZyfo
         FtVKhk8pTmP/QlzUUuTHfAMz1+PEp9vutV23AD7kFgDshdZMPu+fBYZtR8+yGUS7o5n+
         kXfPOL9hXY1yTWSmtVnbCkW9oI+tqF7pSP4K69LIv6Z7lX5ysHHudKjlYJWOWT651L6B
         sPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24C+fRjnWMRKK1Bz+qiw7F1sD6b+3uq1M/s7sYLnKLk=;
        fh=iMzrOB6qCEvQuf+WB4cfNypUTdfIZ6ZaJy8QTZEOyIQ=;
        b=JHF5gCi2I7XsctLEO4wa2UlnrKebNiNAl/6ri1wITRNy67xe36mP5NLePPSjNujGZU
         M2ovXaKh5UdtOsZ7DGP10+NgsvfB7zkewPtiJZUHDwkll+oFOxJSFQnZWpYyWlydKM29
         le+qFs8rYxi1SyRzuXKuBROAgQk/CUnt80B5zswhV7SoxwPYUJQTQ/9q3p+lW7HccVNn
         r4NPH59RS/5dSbCJU7opgWZWumnQ91SiFs6yneDHcLrAyFxIPf0lstLzqZnjAoDrjvCp
         saXVgQhqZtK8Sy+GB+SYGALGL5nwJQS3SHMV7b7dRGS16ARF3PtQYxEMH6QK3EopVuyM
         mCFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638658; x=1773243458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24C+fRjnWMRKK1Bz+qiw7F1sD6b+3uq1M/s7sYLnKLk=;
        b=OzF4bsrbBORLQ5AHmEzvbRByh6gpWE2O3KAc0/lOwj+l9iH+lnhbQNiK06IqQRYV8y
         TLUVyh6iqASYGvOlJqviRtGxH3PoLasa+GzNU3Wt+Hgi5zVboUus8cA5gxBClSoENmcs
         4Q+WE1mWyGRUELN+y/gPeHFC0voNOQ/FccFQjc9O3SibhLyGJBCMsVTShjKKLv2BRIuO
         jVhs+CD9AQQ00ZBdOSxraF52OaBcGKzEsR9CUAPqqhT+wLcvi8xFXjSFAKZB6gE3AGKn
         uHynG3CJGaZxmrHpgPkcHjTQIKGi7ELvdK2FTOSWPJ1T64nljzW35/CF0NIoqZqK88vc
         pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638658; x=1773243458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24C+fRjnWMRKK1Bz+qiw7F1sD6b+3uq1M/s7sYLnKLk=;
        b=JRULfMSBpgsAv1nfE7zgfhrxDr2jr9yPCQIGpvOnCN49ft/TfOF4uZvTmV8w0jyMnX
         g+63zLw7BKryaCp1+a4g/fWie1fztfWgRZqvHh8gO7YxhHTgHhk/bI24igsTVDCTmnvd
         DxHhpXVoBkvKf7s06NxTzFKzuDL6o41rykEXVWg3PbY3y6IPIBirZjxU/GP8tI97uKqF
         4paCYU9debjPkkkLKfNF3Aqb6+dgS4gPGJJW+at/ABpiPP/h2314L14bwPUHwHLsSyMB
         NCrkETAlLaodOnS8Pp+n8qNwamqPW0T/4VMo8QD9VmJPEzJ/PjQmcc4jzhXUniAfnNl/
         wriA==
X-Gm-Message-State: AOJu0YwfV9z3mRT5pJFCU4Aqc1DnT1KQt8QJsNUD2/2wueVPw3cE/vKM
	QvYWUEj1kj/XXSBKbEO8OmpX4mBH/d56mMWPrMahDK1xN5NoRs4o8OTqCyvC8heJCuLsYkw0F05
	pbiThPmYSCjQQ6sQMAA3uuI8Tp+dLHDE=
X-Gm-Gg: ATEYQzz7Iqu2qHvZ0TQl2yyA/FQWoMwAZCg1AcdlN0tXrX68B5k4z8V65WM0aVjIxqC
	6tknkdfAikHC2uVVTVk15loFjEcEs6syJvnancyAtyx8CCr1o1I6eMooqFyJcl5BXD1u7DZiBwW
	6IuP0PXD5v7YchBllYgZWLq6Wng3LOSWuNj3xydatnh5Z9RWAM6P3SlK7NAV/4H8/FwDl9jnJyJ
	BLuY45pFhR60Lhf4FQZ8Oa6JwlT2/tu+0iuC6bAgHI+WWGmlqoGzQ2etHspLlZ7yXSN9hcsITZo
	t89IY909EcB70k/bA2pQlFy4GDtqhLZSBIB9yN1JJYzY+ewFoWSmmawhN4t1XKdjVLiowaC3xYF
	bsDtkhgGblT/FvGebaQcuKdniMg==
X-Received: by 2002:a05:6000:144f:b0:439:bd46:41ec with SMTP id
 ffacd0b85a97d-439c7f64e3amr4552595f8f.2.1772638657979; Wed, 04 Mar 2026
 07:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <20260302102726.1126019-4-xukuohai@huaweicloud.com> <CAADnVQLoWzz8ioVg3MFjn08fBLfNq6HdvqLtqXV0zUb=SR_HGA@mail.gmail.com>
 <1ea52c33-ae27-45fb-b4ff-0c4637a4312a@huaweicloud.com>
In-Reply-To: <1ea52c33-ae27-45fb-b4ff-0c4637a4312a@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Mar 2026 07:37:26 -0800
X-Gm-Features: AaiRm51nYgrFTZDKYO__FZp669W9unlvWI8agTWcFrkv1cu7vf7-zveP0gghP0U
Message-ID: <CAADnVQ+HvsZ0zr6AGLBhMOVX1uRKwRqV28ywcvpVkrsDTyaXmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Add helper to detect indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 4:46=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> On 3/4/2026 1:19 AM, Alexei Starovoitov wrote:
>
> [...]
>
> >> -       for (i =3D 0; i < insn_cnt; i++, insn++) {
> >> +       for (i =3D 0, j =3D 0; i < insn_cnt; i++, j++, insn++) {
> >> +               env->insn_aux_data[subprog_start + j].final_idx =3D i;
> >>                  if (bpf_pseudo_func(insn)) {
> >>                          /* ld_imm64 with an address of bpf subprog is=
 not
> >>                           * a user controlled constant. Don't randomiz=
e it,
> >> @@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct =
bpf_verifier_env *env, struct bp
> >>                           */
> >>                          insn++;
> >>                          i++;
> >> +                       j++;
> >> +                       env->insn_aux_data[subprog_start + j].final_id=
x =3D i;
> >
> > You're adding final_idx because bpf_jit_blind_constants()
> > doesn't call adjust_insn_aux_data() ?
> >
>
> Yes, I added final_idx because insn_aux is not updated here.
>
> > imo that's an ugly workaround. Just call adjust_insn_aux_data().
> >
>
> If we adjust the env->insn_aux_data here, should we also adjust the globa=
l
> env->prog->insnsi array? I think env->insn_aux_data should remain consist=
ent
> with the global env->prog->insnsi array. Since constant blinding only rew=
rites
> the subprog's private instruction array, updating the env->insn_aux_data
> causes a mismatch with the global state.

yes, and subprog starts, and pokes that bpf_patch_insn_data() do.

blinding was implemented long before that, so it was never updated.
