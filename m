Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7651D7995
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818575; cv=none; b=ZO6Hazpt/egr2nD/EumuGyhAkA2Ti1PehuubU8wYdSsvxunSd/Xl9Klc+nQAOPWE29WS0elFx5bPKRiAPc7ZktxxFVKA5urZ8OREmHhWKqgLYlaZZiUDq8EhxobLkPaWdFX/cnVamPYkZrlT+a7u4Vvh/Dc/hDnjP5VgT3HonlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818575; c=relaxed/simple;
	bh=caWojI76uGreVnX5Y53GVJVVNItKpsnhUcLlCd5GdiA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pvgD/o+ePelgRkTwwVh9QFl9JsObU+UrHU/sYe+unlb2LVGaL47PQ7/cHFiAtonKN0sshwl6bPZUoJkUPXtSYun6qtincifsqjTaVAdpo7xH0ACoxozZ06HRU8rzjvNE2AlhkfMq/fWdfulJQQkpzBgMJOERvGY87XBdiFZanYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHPODac6; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHPODac6"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479ae363aaeso2653417b6e.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776818573; x=1777423373; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itHzo6d/N7EQqZ/RIdJLqIGZjiLroWPut7iT8d+L+rU=;
        b=FHPODac6B9s31fVCIB37nDuDWDB4iHbL9yJ5FMD0iPOcJyroQxNB/FvCY7oQy6LdSI
         6WwbPdv3h46M0EwFyf6PzUovdpIwow591UgzoyvcRfYIQticOCfjwXhfEuM8sWojLL3v
         YyNPEgwWoFgyCqptLZwx4ALmKFBnxUuSw5qmk2igL0gvPFRgIIrpP0zZ2Wz3TzwTRCqc
         RyuP3qK5ejzz/Kkgp8/CV7I2Lmd6WI71viuMB+swOc0gTDaeydunj2/YpLuBqnHbgyuV
         jdzF9e0Dg9xZYT1csJd+FhhCpmnCE/h3tSUEj6/loKMkBZEsW/Dy02as1cL9nHrXwbOW
         03+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776818573; x=1777423373;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itHzo6d/N7EQqZ/RIdJLqIGZjiLroWPut7iT8d+L+rU=;
        b=M1PTQYD8szziuPzvXkBCRPaoSF8IiqMeNEtIdOdAyHknvmBWoY2oqczaXLUj28UusW
         c8m8RLGP0gnZdiHeA4yAnjShnOmaxYnC2OQBYcq7FvyOIZRqAFwyKkV6EhYQexlnYPlD
         bUCpWq6eUfD4/KDpVXpUn2OBDhJgQv3A35+kgyp+7ZeWFZQ3Xy2D0JYLOvel5CBtV5Sx
         ZTk7KBngxnW9//nMoGGRrlWMeF8Py3dYYCmc7zo7ndrwf8CqjsHbGrS+rydTWEmCna0N
         ih/TW/gEWvLXDVVQsDGanlk35SxH4b9bi9UTjCtSTVY/r6Ql+gNA3oIj3DJfRT8qNYIJ
         G/6g==
X-Forwarded-Encrypted: i=1; AFNElJ9LkwOTAKp/ZUDkxUvcTpLIyV4YqSF33Y6KGLvoGDOv68YuRcYA2aCO9gJ/tEhcbF3aG10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwCBAx2jioKSf0F6iTaiXHIpAVIm1jH5dyhBgsuB379e32zfK
	bfTIa1NX0qHe8EFOnNrO8+Q0Mm7mk0aWBWFDPPtFk49iF1wP5j8IuRgR
X-Gm-Gg: AeBDies1GHRXHU6UR86XtX+SG5T6SajkgoXRUBG3fdUItbRofy8AlpSqmjoSXqAgCnR
	wlkAL23RYDZPq5uMLbSRbnW8zIgqd2+Al1dnj9pB65bvjjRmBZJJNitRzuK0mYX460swbwQExRU
	46zKTGavbeJkbOcfmNeWEges2WO51m9tysvryKxpzfI0XYtwQdPY1t31qPr1tCu80X8vDhty2Qt
	plpdzu+bmxM1Br3irz5+nV6C80mUPR+eOEH1bXc3rHLurU1SyqBnCnXgF9G6Mtg2EEbwNxhDscx
	0WsKe+sAIONlHBzHShHNCLbQsqIgRahZPZlEjlOx8QOWEuVaxYtrgd3azVaR2eQIH5UGpFX/Put
	B+YwbkJZkR5G76QKX7XZ1GwEXlL7vu52XNjKMSEe0x3j0Krxre6wf40aKggzrjmQHV2I72ib1qu
	ekn4o+x5qF9OiBm9qSlZTCmVHII/w1L1ANZUQKOK0SPRzlVTytYZ/tMRoHzkXgQgG/pxxVfuyB2
	LXMyZYj1eK0mrT3UvXYlSC+YNal
X-Received: by 2002:a05:6808:4f0a:b0:468:698:a626 with SMTP id 5614622812f47-4799bf4b93dmr9584269b6e.22.1776818573023;
        Tue, 21 Apr 2026 17:42:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc747f1aasm5742588a34.18.2026.04.21.17.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 17:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:42:51 -0700
Message-Id: <DHZ9M7ACK4GR.15DYRN8T1LZZ4@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 8/9] bpf: Introduce bpf register BPF_REG_PARAMS
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172007.3512280-1-yonghong.song@linux.dev>
 <DHZ6DPP9Q67P.17W3L0YIPN8Z4@gmail.com>
 <a98248e8-8b70-4125-b494-1a5ff12396fd@linux.dev>
In-Reply-To: <a98248e8-8b70-4125-b494-1a5ff12396fd@linux.dev>

On Tue Apr 21, 2026 at 5:09 PM PDT, Yonghong Song wrote:
>
>
> On 4/21/26 3:10 PM, Alexei Starovoitov wrote:
>> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>>  =20
>>>   /* Kernel hidden auxiliary/helper register. */
>>> -#define BPF_REG_AX		MAX_BPF_REG
>>> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
>>> +#define BPF_REG_PARAMS		MAX_BPF_REG
>>> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
>>> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
>> ...
>>
>>> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>>> @@ -630,13 +630,13 @@ __xlated("...")
>>>   __xlated("4: r0 =3D &(void __percpu *)(r0)")
>>>   __xlated("...")
>>>   /* may_goto expansion starts */
>>> -__xlated("6: r11 =3D *(u64 *)(r10 -24)")
>>> -__xlated("7: if r11 =3D=3D 0x0 goto pc+6")
>>> -__xlated("8: r11 -=3D 1")
>>> -__xlated("9: if r11 !=3D 0x0 goto pc+2")
>>> -__xlated("10: r11 =3D -24")
>>> +__xlated("6: r12 =3D *(u64 *)(r10 -24)")
>>> +__xlated("7: if r12 =3D=3D 0x0 goto pc+6")
>>> +__xlated("8: r12 -=3D 1")
>>> +__xlated("9: if r12 !=3D 0x0 goto pc+2")
>>> +__xlated("10: r12 =3D -24")
>> maybe shift it to r15 right away, so we don't need to touch this code
>> if/when true r12 is introduced?
>
> We can do this. Do you think the following is okay:
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b77d0b06db6e..fe7b6b943ea4 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -59,9 +59,9 @@ struct ctl_table_header;
>  =20
>   /* Kernel hidden auxiliary/helper register. */
>   #define BPF_REG_PARAMS         MAX_BPF_REG
> -#define BPF_REG_AX             (MAX_BPF_REG + 1)
> -#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 2)
> +#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 1)
>   #define MAX_BPF_JIT_REG                MAX_BPF_EXT_REG
> +#define BPF_REG_AX             (MAX_BPF_REG + 4)
>  =20
>   /* unused opcode to mark special call to bpf_tail_call() helper */
>   #define BPF_TAIL_CALL  0xf0
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018d..3ad286ef3085 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1299,8 +1299,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
>          u32 imm_rnd =3D get_random_u32();
>          s16 off;
>  =20
> -       BUILD_BUG_ON(BPF_REG_PARAMS + 2 !=3D MAX_BPF_JIT_REG);
> -       BUILD_BUG_ON(BPF_REG_AX + 1 !=3D MAX_BPF_JIT_REG);
> +       BUILD_BUG_ON(BPF_REG_PARAMS + 1 !=3D MAX_BPF_JIT_REG);
> +       BUILD_BUG_ON(BPF_REG_AX !=3D MAX_BPF_JIT_REG + 3);

Ohh. We have:
static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf=
_insn *insn) \
{ \
        u64 stack[stack_size / sizeof(u64)]; \
        u64 regs[MAX_BPF_EXT_REG] =3D {}; \


Please double check that BPF_REG_AX is not used by the interpreter.

but it's starting to feel that my suggestion was premature.
Probably better to keep this patchset as-is.

