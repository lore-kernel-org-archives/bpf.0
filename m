Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F726E702
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682994; cv=pass; b=Ms+uNP0ZbfiMwbk2kVoVl3R18bTASqf/20AJi8P4W9oK8im6kJmk18KHxx0blD0VRQYJAC4jJ6EO4txsngrdHTAmZiGJsFO2SEWANMLwNmOd1JVlpZ6RyCq7WkUNNb+hri/ftBMqZNAVco6M9NYLRwrfZfIgYFz7DN7SdPhgIzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682994; c=relaxed/simple;
	bh=zDEJrILcnHalrm8g7W89GhK14P1I+zqWDdhHa1gfgXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Drmgvi4hjfimz6NUUCYsDf1aZnINcqxkCXWIePIU/lMLByuXzEqOSFf0/kEe2W4C7TSccxnOAMq+uBtAZlsBrRg4V/tVWGJnJKHZzSkLQvqwwylMAyERqN8VqFkDQ5ynwNcF7xTsxtmx0EXPhdQjhxDsVVeq9nfQLlVDw+E1x4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4/pXvjH; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4/pXvjH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c4bde55cso1259726f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:56:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682991; cv=none;
        d=google.com; s=arc-20240605;
        b=TCT+sP+znI7f7qLltZj4APZgRvOIJItX5c3zdsrdInXC2YAIDGpMbycBA0JKBqaAQY
         XH4yAT//Mb7sMNPFdDnZ4vi/01dooLjv2lzTSPyLa+PojNrxDi07RsJjBey4zJY3hDWv
         dSk1TpDLs5kNesTNGKBanrtHhmUMJVoFu1WAMsOUpdLX+UdqSeJZ/QRLEanBJPOfybd0
         Ma+B5PQp9jmGu07iBXiG/c443zBC8Ge4qxmZYnIKf+t+FwN79ybWI/wmBt+m+Kfl3b6M
         0JBgD3+AA5t6mOORADalblE+Rjt139F6FlUb6c3Tv+rgEgcrWZW1h3nQZ8m+VG0HwFVc
         hccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DSMQoK9CKr+LoofYVBjOMA1G+9sSOQ945cuPkJEnW+U=;
        fh=iMzrOB6qCEvQuf+WB4cfNypUTdfIZ6ZaJy8QTZEOyIQ=;
        b=jR4XXMsprq8ahG5OP+liA5D48HIqn3stVjbgmElmcVIJJCFTPi4ZmSWxCyqIbpsaZf
         DdrM41dqr0SVRHY99c+AfTxtHuhxq3/bxPQT2+1zNB0H08YozzQRm31FZABtApZPRpH2
         +PZEa0JO5Zwd9E/H2SCwS4/5y++eaxYStgcfMyheuj7uWys+/bQTtmxDv2rDmGZpBFzG
         G6FoKNEEI0ZDvnB3kH6Dzwg/JxnQ9EuzI+zbDVvICgJzGlQxIMY3dde9xBw4VKu9kWXn
         ION9u0g/tV4YZtFOhNJ2Am/8aLr73EcDnAO9H+Xz9ZLMEIeiMKxQ620Nc604uADQmxzx
         kKGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772682991; x=1773287791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSMQoK9CKr+LoofYVBjOMA1G+9sSOQ945cuPkJEnW+U=;
        b=U4/pXvjHXZ/ra7BxvaVj1LOjP0xlhsYD/kV9x3HnwpFWPMyX+smoLEqv+Mtc0OprZu
         1N34t49zDw1IyeMB9qIXOyX0vjubpU932lZrvocfZpn4KcOCj+QIykWoGUgWy58gFhQE
         4lNlsI4kp3KW3f5hiobVr1/E6iuPrt9Rjl8DkSu1G+iD2dFIEEIHSxkVvdadSF0KIaKv
         BO/b6UdT9pehZ2DsW9FH5akmhr8RJrzzcwlekM3BY6SOX/ahHDV6M4PPmXic2RL/QUeG
         A3oNeN3Ue9++7CEqyXSHoLxiTMdkz0swHbHO4DXDTVtaVTtddMnr5ElagmDY0YaNapMo
         qL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682991; x=1773287791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSMQoK9CKr+LoofYVBjOMA1G+9sSOQ945cuPkJEnW+U=;
        b=QDNtdob0SmXuUnvkMyFzeZ//N8sxEJHSI1gsKQLjQL5PSnWfjsenGzXHRJ22p8IIg+
         ZMQgjlXHYzF7tCzVH8r95gdOgZFXZo7EzJulTkehjdgg5xW8Er6MQpxRj3lhNOQfqCWT
         q37YpI3HgrAOi4luFmgztiCU+oGaFP8g6c9ylI/fJDZhKoe3wv+7xzLnQKOp4IpJSTNb
         jyk/m7tVWT97hpMb4ePC4jV6O3u4/M0Zz8d5OgYCuvIee4zgvhkSIbpkTNY99efmO1+B
         h7RWisrroMEvbZ1YC2xilovswMibnFPBK8hCsDXIIX46HYGjmFTXkGwovo7RnGpBXmCJ
         qokA==
X-Gm-Message-State: AOJu0YzfpgwjEA9bOqAHu4y8JTsrg1hL6HWU+frqe8BOW1GO3FVB33UX
	552m6JDjHzRJouec4m3OTX3pUmUaOe8b8DSgMdKEBxUx65Ppbzo29Cu452iREaphNUJ1wraulWU
	fl4tez4h1v2T7VqACvneMZutMqikV+23RkApQ
X-Gm-Gg: ATEYQzxm9JSod0pe1+9ByKcuThgeBWptfIzw+gSvX7GzgqZPj3WDYkAK0HlZgWKIom5
	JxCiTsEFm7O4zYArSRDNsig9tLjkqVPl1TySC0vjHw+wLpjoqhCx4GSaLF7r84hWI9DVZdo+Egh
	3SEBFSoaeN+bRPFc70r4SGIiVQhOPT1FNYcMJ1TQ8AdO+qKu4oanjXj6GaOLkr5/24njwmgKpHQ
	HEH4l3hCqQ+10o6gTCS4UQm4Z1SXO60c2pGqkNBeYuz284xDaVCYgVybFPulrYwBQgYYB7b5s3k
	j2njJZ3Grmsn0Lha/mzAQI/uzCYg9jKAEY9aRgElVJXbW6NfIR2L/CvWJA0o4qQ99rOil9woJz0
	KCALfOx+RRXugkMPO/SigD7K0Pw==
X-Received: by 2002:a5d:608e:0:b0:439:c92f:ef35 with SMTP id
 ffacd0b85a97d-439c92fef50mr5426026f8f.17.1772682991134; Wed, 04 Mar 2026
 19:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <20260302102726.1126019-4-xukuohai@huaweicloud.com> <CAADnVQLoWzz8ioVg3MFjn08fBLfNq6HdvqLtqXV0zUb=SR_HGA@mail.gmail.com>
 <1ea52c33-ae27-45fb-b4ff-0c4637a4312a@huaweicloud.com> <CAADnVQ+HvsZ0zr6AGLBhMOVX1uRKwRqV28ywcvpVkrsDTyaXmw@mail.gmail.com>
 <0f18b3b1-9bd1-4ce8-a7df-c1149cf6e14d@huaweicloud.com>
In-Reply-To: <0f18b3b1-9bd1-4ce8-a7df-c1149cf6e14d@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Mar 2026 19:56:20 -0800
X-Gm-Features: AaiRm53xbp8-NAX3A4O1s33pD9uNRg2yfLWGq2t7tCn5lWZ6f21ccsyp9hyEmv8
Message-ID: <CAADnVQ+ryOMoDUAhvDMJYe_mh_gt9Wbe4Vcb+A68tty=RZCtrA@mail.gmail.com>
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

On Wed, Mar 4, 2026 at 7:47=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> On 3/4/2026 11:37 PM, Alexei Starovoitov wrote:
> > On Wed, Mar 4, 2026 at 4:46=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.=
com> wrote:
> >>
> >> On 3/4/2026 1:19 AM, Alexei Starovoitov wrote:
> >>
> >> [...]
> >>
> >>>> -       for (i =3D 0; i < insn_cnt; i++, insn++) {
> >>>> +       for (i =3D 0, j =3D 0; i < insn_cnt; i++, j++, insn++) {
> >>>> +               env->insn_aux_data[subprog_start + j].final_idx =3D =
i;
> >>>>                   if (bpf_pseudo_func(insn)) {
> >>>>                           /* ld_imm64 with an address of bpf subprog=
 is not
> >>>>                            * a user controlled constant. Don't rando=
mize it,
> >>>> @@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struc=
t bpf_verifier_env *env, struct bp
> >>>>                            */
> >>>>                           insn++;
> >>>>                           i++;
> >>>> +                       j++;
> >>>> +                       env->insn_aux_data[subprog_start + j].final_=
idx =3D i;
> >>>
> >>> You're adding final_idx because bpf_jit_blind_constants()
> >>> doesn't call adjust_insn_aux_data() ?
> >>>
> >>
> >> Yes, I added final_idx because insn_aux is not updated here.
> >>
> >>> imo that's an ugly workaround. Just call adjust_insn_aux_data().
> >>>
> >>
> >> If we adjust the env->insn_aux_data here, should we also adjust the gl=
obal
> >> env->prog->insnsi array? I think env->insn_aux_data should remain cons=
istent
> >> with the global env->prog->insnsi array. Since constant blinding only =
rewrites
> >> the subprog's private instruction array, updating the env->insn_aux_da=
ta
> >> causes a mismatch with the global state.
> >
> > yes, and subprog starts, and pokes that bpf_patch_insn_data() do.
> >
> > blinding was implemented long before that, so it was never updated.
>
> I see. Since env->prog->insnsi is rewritten by blind_constants now, would=
 it
> make sense to move constant blinding to the beginning of jit_subprogs, ju=
st
> before the global instruction array is split into subprog copies?
>
> This would eliminate the need to invoke constant blinding per subprog fro=
m
> the arch-specific JIT, simplifying the overall flow.

Makes sense to me.
Since we're touching all JITS, lets remove bpf_jit_blind_constants()
call from the too and do it from generic code.
