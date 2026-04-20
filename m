Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78A33DEDF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697092; cv=none; b=FyOvKnvAuwsvzuxA86Lz4o9wUFVE8uxwIjdjgn0Y2MTuxhcnz91XJhWXV69/llRpUBpCO4sl2OuThMdFJ5ztW08G79jHVHKzvqf+5xIs8814YuPPq6EwIl2Tiyo0WeSX3wlXSr37I5fODK2pthbNRbq0NrtjpQaeWAf7QE9CEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697092; c=relaxed/simple;
	bh=SXLijTqi6l+MR0vdBxF1201Q02q2AoqjtdDXjD/JH1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=khFpaFeHOCXe0qGXyFbiZUckNAqKiqeIdDBA1M+8/aTFzAfCjn8Oo9R6BbyZlLmaaCmac6JMQfYQR+Tpzek9pXmlACRud3L8gUipsS2G6WU39pf7it27X5FZbd2cdQ8A38TdVk4OcIEo3lDDmbklJsHpuJQatuYXMDWwJyUcHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Ab+vgi; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Ab+vgi"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c383f2fcso3056354a34.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697090; x=1777301890; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSMgP2++GGeGaXHNaVUS+xwePHWXDwLAYJCA/r6Bd5E=;
        b=W3Ab+vgij8efqTlqKVge/ZQcEIVf4NlO185lo46KhdsclmX6FJirCL9h2zTqPYTGwD
         9Qfupg+cW3grX3x4NiszUaq8CFYLfHNb8xl/e37rFfDiAgxquprqP36jnfzqfBlD+OfK
         oB8nIS/3+i7BQpikcKR1Pn5slx2zIqXZUr8clqHbOQujSW38BQRq0vttDy9Wu2FL3g9d
         OEI0dqaXIK6Nm/WoZwtxvTD34sLItb7LkyGFVWH3YssXBWaOGNNYza1g0k1CVnrixW1r
         XYaZ+8sXTOeMFl17J/TdV6eHcTzYGSWAWrA6BX5cnJ9jWXUtuK4g0ZN2g10Q5sK3hlE1
         yMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697090; x=1777301890;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSMgP2++GGeGaXHNaVUS+xwePHWXDwLAYJCA/r6Bd5E=;
        b=TKFkzgY1Q31n+Fr9fUZ3PDQEIPVaAgULiPEMSAX6ygaZMpp8jb0+TKAGVYTl51LMbu
         61COc1tsnBTn6PjTdN1Y1KHMruOUSD4DzSsp6jB3O2e+pnYa1rT08Vuhy8GYv4tF9AP4
         8QKlDkUM4YUm5x66dsasrLCzWN5IKKgANmEKJNEHSEqQHhMc/rnZE280VyENXeC8yTrN
         emfYnWi2F6CEPgguilmDngBD0CnuyaKYz+IUU3s4Ig4urOp5QxC21/NzNoKtgQ6gf1oD
         2gJUnwUaKxOCyqRkHCEo/U/pIAFarIIxXovJnCxbi4Y2EtmbFSfo2Pg9utCsa6twA866
         GVpw==
X-Forwarded-Encrypted: i=1; AFNElJ84Fumafdizb9j0YPcl8zzBHUL+J2+8Otc9d8oNfqzHwtGF/BHtxVZrPQAwub855jG054Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xYeNa3PjcqpvG9DcXugUwyaBHswzzQtwnv2LgWBw2yDkOYfX
	pRIgpeoTcpADruMV6ePcxE3h4R/YxgK+wigGVryrkT1pFhw3qdrEYirS
X-Gm-Gg: AeBDieufTjQ2UbCG3r83fvzx+d/viLiSbB0wpHg8u7Wu0rbF+LHeggYnG7JYqjpp1tg
	j/KatDipzSWC10aEyM92AlPzx7keo0XnEeoQhF5kVmA85SrBoSNHl52ZqAoqpPtb7bMGlNwTRXK
	lt8cxnTvPOJQets8DxY6yHQb+bbzAhZRSkB3iw1YbBirF3nj3sMoNXN6alLuSiSS2wfhnF9XEfs
	5GngI72+wCeunzIWcNjC7dYi8pfO3Tw8OWSMFtk5NAuFbj0h3Ouobzf5nPQf04yjRcMD9MMOd6R
	dRP2nstOA6GABG+L9gv95Zj4nmoSG/fATyfctjRE0mIUGSBsa4sw3VuIWahK6KvV1BQqSdI6Mwd
	1WqlMTeKd2tvHk17N4TE5SK6TWFd/l69nZ9eyDl1oVLNJfV8KKniFqGCRzguRoBMubzScDaUri3
	8KG7pQ775xDmSFc1HjH7syKeZwyIq6AbnQU00CL6IsM+liBgu7gurUPYD5Megm5l4LQ0bxlqwiI
	SXpHidVVHYhCEV9Udl34nbNqt0g
X-Received: by 2002:a05:6830:6d4b:b0:7d7:d60e:650a with SMTP id 46e09a7af769-7dc9521cabfmr10027799a34.23.1776697089678;
        Mon, 20 Apr 2026 07:58:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b057bsm9670787a34.20.2026.04.20.07.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 07:58:06 -0700
Message-Id: <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>
Cc: <bot+bpf-ci@kernel.org>, "bpf" <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Eduard"
 <eddyz87@gmail.com>, "Quentin Monnet" <qmo@kernel.org>, "Daniel Xu"
 <dxu@dxuuu.xyz>, <kernel-patches-bot@fb.com>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Chris Mason" <clm@meta.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>
X-Mailer: aerc
References: <20260414132421.63409-3-leon.hwang@linux.dev>
 <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org> <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev> <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd> <3556a456-70d3-45e7-affa-355107bac30e@linux.dev> <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev> <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com> <20260420052459.85772-1-leon.hwang@linux.dev>
In-Reply-To: <20260420052459.85772-1-leon.hwang@linux.dev>

On Sun Apr 19, 2026 at 10:24 PM PDT, Leon Hwang wrote:
>
> int xdp_prog(struct xdp_md * ctx):
> ; cnt++;
>    0: (18) r6 =3D map[id:28][0]+0
>    2: (bf) r6 =3D &(void __percpu *)(r6)

well. that insn was inserted by the verifier and it shows up in xlated.
That was expected.
The point about 'bogus xlated' was about offset translation.
map_direct_value_meta() should recover proper insns[i + 1].imm =3D off;
In your example it's zero, so not an interesting test.


>    3: (61) r1 =3D *(u32 *)(r6 +0)
> ; cnt++;
>    4: (07) r1 +=3D 1
> ; cnt++;
>    5: (63) *(u32 *)(r6 +0) =3D r1
> ; __u32 cpu =3D bpf_get_smp_processor_id();
>    6: (b7) r0 =3D -1280774092
>    7: (bf) r0 =3D &(void __percpu *)(r0)
>    8: (61) r0 =3D *(u32 *)(r0 +0)
> ; bpf_printk("cpu: %u, cnt: %u\n", cpu, cnt);
>    9: (61) r4 =3D *(u32 *)(r6 +0)
>   10: (18) r1 =3D map[id:30][0]+0
>   12: (b7) r2 =3D 18
>   13: (bf) r3 =3D r0
>   14: (85) call bpf_trace_printk#-129408
> ; return XDP_PASS;
>   15: (b7) r0 =3D 2
>   16: (95) exit
>
> The difference between these xlated insns is "r6 =3D &(void __percpu *)(r=
6)".
> This insn is for ".percpu", not for ".data".
>
>>>>
>>>> Ah, let me dive deeper.
>>>>
>>>
>>> As for the above changes, let me explain them using diff snippet.
>>>
>>> @@ -5808,6 +5808,8 @@ int bpf_map_direct_read(struct bpf_map *map, int
>>> off, int size, u64 *val,
>>>         u64 addr;
>>>         int err;
>>>
>>> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
>>> +               return -EINVAL;
>>>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>>>         if (err)
>>>                 return err;
>>>
>>> It is to guard percpu_array map against const_reg_xfer(). Instead of
>>> updating const_reg_xfer(), better to update bpf_map_direct_read(). WDYT=
?
>>
>> yeah and move map_type !=3D BPF_MAP_TYPE_INSN_ARRAY check
>> into bpf_map_direct_read() as well.
>> To cleanup const_reg_xfer() a bit.
>
> Before sending the next revision, just confirm the change:
>
> 1. Move "map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY" from const_reg_xfe=
r()
>    to bpf_map_direct_read().
> 2. Keep "map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY" in
>    check_mem_access(), because we should not propagate the error from
>    bpf_map_direct_read() for insn_array and percpu_array.
>
> Thanks,
> Leon
>
> ---
>
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -174,7 +181,6 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>                 u64 val =3D 0;
>
>                 if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_valu=
e_addr ||
> -                   map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY ||

yes

>                     off < 0 || off + size > map->value_size ||
>                     bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>                         *dst =3D unknown;
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5816,6 +5816,8 @@ int bpf_map_direct_read(struct bpf_map *map, int of=
f, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY || map->map_type=
 =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;

yes

>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;
> @@ -6370,7 +6372,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                         if (tnum_is_const(reg->var_off) &&
>                             bpf_map_is_rdonly(map) &&
>                             map->ops->map_direct_value_addr &&
> -                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
> +                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&
> +                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)=
 {

why add BPF_MAP_TYPE_PERCPU_ARRAY here?

>                                 int map_off =3D off + reg->var_off.value;
>                                 u64 val =3D 0;

