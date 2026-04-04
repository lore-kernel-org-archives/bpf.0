Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE83164D6
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775327074; cv=none; b=ZMoUptA+CSijepNOUZIrH1fzYiaLcOH6mqcH8TomgFOuyTQEgaDYIjth/aSf04CKum9aBii4V3WuDDmBXP3dgr1IgTzFHiYm9eyny+v9mL9i4zCz2Yy10V4v0m1vNWr2bAYM/tIXUEdRyEz1yiTtbeO/WVgQdkVbNZL2GB3Mc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775327074; c=relaxed/simple;
	bh=zKW2G6yrYQNgTY5yq+NbaxheqKwUgaZVUqXxANHS29I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FsJNKjeIlnBV5ykZ526Bgu7xH91v81vKzDQRxDmc44Si3YOvr9LpTox3XchZ8yYeZT6K5GO+k8Mv/0Zevj8flyHAKsJSliUfxzmU7hnNLjCExIquX9VjaRQZlDF3L8tN+kUh07B5uPn1byjqSaw+IVFvC1dx82kGED71t4XBDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VAZ/0dQ/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VAZ/0dQ/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so1045104a12.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775327072; x=1775931872; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcSDQOwpneTnufVZJg0KVs8OnsBHV7c/HKQx0M9JyHQ=;
        b=VAZ/0dQ/AIjmHXS/npbOm3OE7n2ZxgPp5DWVuR99SYVTNFV2BaAiF7w/wtGRyRvAQn
         OxKF+8iXWM/je6t/PSL8FV7SsHL4rfBP/F6WT2TX11u/skZK7hPebHOkdJ8AyXXyKSTW
         kv42EM4LEZZlvlNqDkFY5rEvZsAOxkcibkzyX6C9a/j7+hK9EmjgGsgYv2TH/e9578hk
         D2IDalaxDuWRNAThBx8y/PcjLtZzkARLbxVxr/7NBVrKWML1ryvP7q1FfmDzt5gZRr6C
         hfKTIu/MJIDA9JNJRndrUN9UFG+M27AplVDZyN21Qx/MuNXV17+Mc9fxBJX1vFc+WnAP
         W5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775327072; x=1775931872;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcSDQOwpneTnufVZJg0KVs8OnsBHV7c/HKQx0M9JyHQ=;
        b=nGi/zokR94MOs/FOYZkyxN9Jk+GasOWztpFB4Tu3qIRByPW2KJeQvBBsYPx0uk+v2s
         BoBS+UCa5tmipF4QT50p8ngoItfiCo+iXKORnrNbK788c0uyAanlyTcEzvSN5Qbxbc1O
         YOITMMozm5xrdKITZhJ3V3r1Ngf3BkMeSh4rhQlJZlPWIr6obqVfAbBkWqxmuTw9BCPW
         2O9mBFVNsgGpFve0mY4qw5FSI7R6nF/I4CcUWk/GUi9q26i31+us+e6Yfd64agrMaJAJ
         O1h44xS7WzBpaRrUontr7Ce6IeMDuL99xouKMLKKBQG5mIaxSyXFZUTl2C4Plz+eo+86
         /aLg==
X-Gm-Message-State: AOJu0YygotHru08pVRzIZvIr1Odqq16/x6jhZ/mNzjUI5W150kaoPtco
	SEM1l8h9PUVOybvy0SxMwJrVLLb671oDMmPypq9vBYwcDWIUqumjtV38nYx/f1rbdt4=
X-Gm-Gg: AeBDieuoVjho7pAyrcfcccuQX3Y6YcUJcAZ3EmALPncmOj+XhSqp/ykvHPlFyM9BBBz
	0+zW0IQkm9HehkhVKSfCgkz/w2jH/B5jaFPzyCImOYT2syzoYtXy3DbrOKHwLtozXron7lZOFbD
	9pZ7Ge36fDoZcckb1L/YPWpYwL8xoV7/pbzMoCvc1gYKi+ZJ6+MmC9bqvQ/GAQFYPIuSjNALTya
	sgQ+DJ1f8t497oGd34fU+I7Oxh/Xkan05/uh2c8hvIIHizT2ddvRtlTPZ9R7h4b6RPedv7DCLvn
	Y/HxIcuaTZOENhq/2mYU2+zKnJFyC8NVELMEHI7x9PwJPZpZGeh0hfld8uOEYOxxmDYz40M+xmZ
	WrnA8vUyKrZs5nwOCrTjSHZSo7p9BWt7kDNH2ArP7Mpcv4qB35xUHADAIPibnOJuutQbBkLJ4+q
	+qsE8yfX8=
X-Received: by 2002:a05:6a20:9145:b0:39f:21a8:1e1d with SMTP id adf61e73a8af0-39f2f046ab9mr7668870637.10.1775327071924;
        Sat, 04 Apr 2026 11:24:31 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6562018sm8235414a12.18.2026.04.04.11.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 11:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:24:30 -0400
Message-Id: <DHKKX90W8XV7.116WMR48CDB2D@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Emil Tsalapatis" <etsal@meta.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403042720.18862-1-emil@etsalapatis.com>
 <20260403042720.18862-2-emil@etsalapatis.com>
 <CAADnVQ+3WG0ed8Redsn0wbZ+kwHYH-pz2G9bmzVH5MRX-kp02g@mail.gmail.com>
In-Reply-To: <CAADnVQ+3WG0ed8Redsn0wbZ+kwHYH-pz2G9bmzVH5MRX-kp02g@mail.gmail.com>

On Fri Apr 3, 2026 at 4:24 PM EDT, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 9:27=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> From: Emil Tsalapatis <etsal@meta.com>
>>
>> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
>> addition into the scalar register rather than the pointer register.
>> Handle this case by upgrading the destination scalar register to
>> PTR_TO_ARENA, matching the existing handling when the destination is
>> already PTR_TO_ARENA.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  kernel/bpf/verifier.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8c1cf2eb6cbb..583121b9aa7e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16333,6 +16333,24 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>>                                         bpf_alu_string[opcode >> 4]);
>>                                 return -EACCES;
>>                         } else {
>> +                               /*
>> +                                * The compiler sometimes stores the res=
ult of
>> +                                * PTR_TO_ARENA + SCALAR addition to the=
 scalar
>> +                                * register. Upgrade it to a PTR_TO_AREN=
A.
>> +                                */
>> +                               if (src_reg->type =3D=3D PTR_TO_ARENA &&=
 opcode =3D=3D BPF_ADD) {
>
> This is too specific and doesn't fully address the issue.
> How about something like this:

Makes sense, and keeps the SCALAR -> PTR_TO_ARENA in a single site. My
initial rationale for doing this just for ADD was that it was the only
two-operand operation that would make sense in this context, but that
is irrelevant to whether the instructions are safe.

>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84699a428077..457ac555da72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16572,11 +16572,16 @@ static int adjust_reg_min_max_vals(struct
> bpf_verifier_env *env,
>         int err;
>
>         dst_reg =3D &regs[insn->dst_reg];
> -       src_reg =3D NULL;
> +       if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +               src_reg =3D &regs[insn->src_reg];
> +       else
> +               src_reg =3D NULL;
>
> -       if (dst_reg->type =3D=3D PTR_TO_ARENA) {
> +       if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->typ=
e
> =3D=3D PTR_TO_ARENA)) {
>                 struct bpf_insn_aux_data *aux =3D cur_aux(env);
>
> +               if (dst_reg->type !=3D PTR_TO_ARENA)
> +                       *dst_reg =3D *src_reg;
>                 if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
>                         /*
>                          * 32-bit operations zero upper bits automaticall=
y.
> @@ -16592,7 +16597,6 @@ static int adjust_reg_min_max_vals(struct
> bpf_verifier_env *env,
>                 ptr_reg =3D dst_reg;
>
>         if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -               src_reg =3D &regs[insn->src_reg];
>                 if (src_reg->type !=3D SCALAR_VALUE) {
>                         if (dst_reg->type !=3D SCALAR_VALUE) {
>                                 /* Combining two pointers by any ALU op y=
ields

