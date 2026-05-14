Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA643093DF
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772443; cv=pass; b=MJmX1o2Zp7nHtQUWfgqYTkoTHKqH1zE9/kxBUkMB9MA32K4UgEWBeIAV2zIwiw0tagtwaN7WO+o7JnXaisaBKFl59dpPDmQJE1ZdJA69k5+wdSKqhkyJ39zv0jP6jes/DsZg8WtLLO82RkUYCUPews2oL+NCBWjNCpYGN6X5wvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772443; c=relaxed/simple;
	bh=a32WAFRSmWqgloOjWjLcKDwoe9d9WV2q+uj8MCId4Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnNphDZQz2m+8caqDf5JoFwUOGoguw4kyh1U0CbNyMKaPVLxvU6oVGvgYZtdNYKMbEQHFAD7SF+l9SNvh2uo/ZI8kfjdo8WE7AWDvK5Rvmm5/A6b811mbsArGKu45sTfq3cGvqJFojRFrKFQgZc4T0tibsgzt8MLb7tnrsdTCQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDYfzZ33; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDYfzZ33"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d75312379so6203286f8f.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 08:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778772440; cv=none;
        d=google.com; s=arc-20240605;
        b=R4hkRa/XBVY8L4y8Ex67Z39UFv/4JatSiZsb1ZdlHKNmlWpTlVESYl5ktm3YBS51qO
         wkeHWxELXhgh7sM10yF4PhPQSLAmzUH/pgwg81qkbNHhL0LgyicCeuRdaPiEZbOO1fwg
         aFASKrpRutj6lhqcqUUCiGbUVK/yiR8809aenm3gDxDUD7NkFoa4VgbjdDTaA2VqqbFf
         0DoyfVDE0EcV54bBH6GQBsQt57Mo6JvCIn+g8ZB6+u8Kv2BxjdwJwNr50mROHJ0td0QH
         moajvCJCLmbPjelWc8ku7GRW9f0wXRj+E75r/G1dTrtEUtVs3Z+RMrzotAtueCq2Cy65
         mSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uk08Ee07RRbvfX24Gz8S6GrKsKQaj0zXyYDrCQZADAI=;
        fh=qzg27WHe/AzeTAbSIxJQiqV10qRboNfn84yENSW1SkA=;
        b=Ku/2Aymzq77uctuKG/bnwxeNeXdh5IfvAglPuOwPPM/+0MO3Fz8B34yBt5ch6c6z3P
         /VKyFRW2hwPHXkar/jr/h+ywNAqSfnQf87Znu2qS+1DmhirC+JKq4adqr2HKfO2HeoXF
         QZmo1MehWqAtP91ZTpHCeMd2m9ftAXPYMxjxfpnvjFfvwtxt36fw2OpqfEbY5nQDvqpP
         rP/Nu8d7uMaq1JzBqn03A2RXBgHHe+Qoxw4mOpJexWuN9VqHxnmjiVTIo74LFHSlHim6
         mZQAGFkJOMOFcZPi/0CcBkWr5zOJ6jMwf2jH8fI5jxZoNu2GsRuM7L2WPtLJwSkc7ewR
         O9GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778772440; x=1779377240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk08Ee07RRbvfX24Gz8S6GrKsKQaj0zXyYDrCQZADAI=;
        b=ZDYfzZ33/6bQWByyNh8kffCDM6fYZ+AZV98hGtQLMBMrKFRMExckmjJFIImBfeQzpA
         UV0KhHa8RLsOTvnNozDA/vGIfmhv6+tdJXLoBfdCTPHTArMoiR6kpgdpL5PHok+s7e+O
         s65SGo8QsbuQW25xgeOzwflFKx05YcahIQNMyuFwVDEhEKTNPfRilkb682pLaWTzCZjq
         j4DRB4MtqzfDSwdx4ykVUqWPcb8qUXqFokv5zj+lOzXw5FPurhuiF7wJAd6L4nzl6mug
         VjlbJKOsNy9dgwJ0bo0sGT683SAFGEAKLIuIHC8FlBar9kc7QAnJrSetQANVapHZx1EB
         v+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778772440; x=1779377240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uk08Ee07RRbvfX24Gz8S6GrKsKQaj0zXyYDrCQZADAI=;
        b=AMKf6dtebfirzt8X3sI3f3w2lkkhk2Enh1Avo86rYvHBxPmMYFKCsz69XxK60LLPtm
         +3w5ZTM1CnQ9aJ1yIJzEcetdvbY0672rQrmjKT4Z1QMWV53bUjYj0ogZ6RFGkOrWnteJ
         1xw9MhcnLtdFUqPjXN9Hy26f/2qTWMLOrmmsSu4a1v+vTPJ911N00J0kQr/JoEV9WYJq
         hx3hiNs2oIjGPRycq27BBBQOMGDuuml120BAvqAyeiRZFm0t4JTYxABH9ZdF4jgo6fmx
         RBOcVoueZxjOK+Y1u4USoDBu9atV5m/tJIy14dAucr1ZkElIGTg2VXJxjhblonZkuxRR
         1EmA==
X-Forwarded-Encrypted: i=1; AFNElJ+upZI3hJ0JVCDzvqtN/FZCc2mNLTGVGcQCG4VdB6ZH5vc3kixKzoQnuL9/zPBjh8nKa6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DMx8v3brsoYVrgvkIL8lexDh4OTVAKR9wC8IG76z3ByoSyXT
	VvfebRBhsUscVX0thGpzYCPo+5aAWSUpRnU6DM5wJTM+tUiDyjNfuWANAc94ChfkbBR6Kd9E5tL
	SLVTywMM/G2PQ37CA8CreRgTFXGBLHTw=
X-Gm-Gg: Acq92OF3Nsu5vFyltSyJovCzBY69RJ/4uhdJ9wzOOlJdQV/QM0szBzJ3JKfcVCfcWUL
	XEnqWzPPnQhZx2vaoZhm3mWNbiYw3yGpqQL3NaEApzse+M/LnmzaH7svznYn7Bw6Jl/J4n66Een
	OlMtEJ0HqHO92FjdLYielPuSMZgI6/NjD8r3DpcKPKDFydIlSAhkN+sxS1aicdDcGl1yukzn7Py
	Hr2Ubfdqajxj99aBSQVYGftR0NgaUWG10UXEwv/h1BHg36HSzzboWaey1AeKZheMM89GYVgPJ+C
	96oCl9gaKZSFfFLIgT8SGTGc8saioAjmHklwLqmuUfnaNTBfST6AlcgNbYF/AHBDE0jtbyu83Un
	NDa/xEqfCIm3FSbqaroJLWIC2qUXDmnmfYIn1
X-Received: by 2002:a05:600c:609b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48fe4cadfeemr695815e9.2.1778772440173; Thu, 14 May 2026
 08:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510030136.27876-1-chensong_2000@126.com> <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
 <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com> <f61ecd8f-675d-41e6-bdad-4496f5ecd076@126.com>
In-Reply-To: <f61ecd8f-675d-41e6-bdad-4496f5ecd076@126.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 May 2026 08:27:08 -0700
X-Gm-Features: AVHnY4J0s-rykE-zkwrHvZq-9PlgvvtIfXZ5JPeDxQu1_g8sgDM2zV18O4rbQR8
Message-ID: <CAADnVQ+HDDuatpxvEJMcTotiRvMax0q-bjF5Z2uLtz_gr6STQg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Song Chen <chensong_2000@126.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:56=E2=80=AFAM Song Chen <chensong_2000@126.com> w=
rote:
>
> Hi;
>
> On 5/13/26 05:41, Alexei Starovoitov wrote:
> > On Mon, May 11, 2026 at 8:19=E2=80=AFPM Kaitao Cheng <kaitao.cheng@linu=
x.dev> wrote:
> >>
> >> It seems that there are two problems to solve here:
> >>
> >> 1. Allowing kernel modules to override vmlinux kfuncs with the same
> >>     name.
> >>
> >>     This should be relatively straightforward to implement by matching
> >>     names in kernel modules first, and then falling back to vmlinux.
> >>
> >> 2. Handling the case where different kernel modules have kfuncs with
> >>     the same name.
> >>
> >>     Could we use a new libbpf API to establish the mapping manually?
> >>     for example:
> >>         bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
> >>
> >>     Or define a new attribute, for example:
> >>         extern void kfunc_name(void) __ksym __module("module_name");
> >>
> >>     We probably need to hear suggestions from other developers on this=
.
> >
> > I'm not excited about 2.
> > Two different modules are not allowed to have two different functions
> > with the same name.
> > The kernel has only one global namespace.
> > Hence I don't think we should be introducing such namespacing concept
> > into kfuncs.
> >
> > But 1, I feel, is useful for experiments and mitigations,
> > but it probably should be done transparently to libbpf.
> >
> > register_btf_kfunc_id_set() should be changed to return an error
> > when a module attempts to register a kfunc with a name that already
> > exists in the kernel.
> > We also introduce override_btf_kfunc_set() that would register
> > a replacement kfunc.
> > override_btf_kfunc_set() would check that all overriding kfuncs
> > have the exact same kfunc already in vmlinux BTF: proto and name should=
 match.
> > Then the kernel will just remember that the address of that kfunc
> > is in the module.
> > libbpf doesn't need to be aware of this substitution.
> > It will find kfunc in the vmlinux BTF, but the verifier will supply
> > implementation from the module to bpf prog.
> > 2nd module should be able to override_btf_kfunc_set() from vmlinux
> > and from 1st module that replaced some kfuncs.
> > All that only for bpf progs that are loaded after override.
> > Already loaded progs don't need to be live patched.
> > Thoughts?
>
> If i understand you correctly, you suggest instead of introduce
> namespace in libbpf, we should replace kfunc in
> vmlinux(btf->types[type_id]) with kfunc in modules by introducing
> override_btf_kfunc_set.
>
> In [1], I simply returned an error, your suggestion is a little further
> than that, correct me if i'm wrong.
>
> [1]:https://lore.kernel.org/all/20260122090404.15553-1-chensong_2000@189.=
cn/

Right. The error on name conflict and new api to override
if there is a full match.
