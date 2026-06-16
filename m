Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D833C8724
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583835; cv=pass; b=Uin6+obRYS19aXbN3ELt2DXGcM448ez2K1pbiUlbXwHfs7pzJaaJd5kuqZ9e42kBQM00qK8SJWrF5ZgrHzJ9cz6Y2oFeh9nyJf7wvjTAJURaWsOIkSkKzLZaMDbFxm8N5hGZ78J8lqlzCxJbpfluncPEKQh9hBayi4msd2Ni0Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583835; c=relaxed/simple;
	bh=zHb1G1zBECKKQ+80h6h6GBoc9FyVi/t+jHn4goyVTEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2he8/fen6Zs8RSjzxb8QQMbnfQnS7cmxvtZ0jCuudoSMyDcYLjZQSCK2zDslnQNhxBsPZxJJiV8l+MRx8lMi+KWcImTJVdgvjf9/+KFhfijRh3uvDDCPajp/NnIJFV55XlP+DF5gUrsKTkrGUv3R0nYZ8AYJYBV+VKfAEUIetI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp2vOKAE; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp2vOKAE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e16f05fd79so41866917b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 21:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781583833; cv=none;
        d=google.com; s=arc-20240605;
        b=RLt9puSdP5my4n7qo6+mngDtvQR5TDfykrKBBhazIAflp5Ewuzm0iMb1W9n/rVB6L4
         lqRhWjW0LrMhY7IepGdacaAFIyelA7xkXk8SE0U5k7se7lAmI6UiVC8gSV22kXymH6jE
         5nSOs+EIh0u/4uNvTy+k6b1Zpvdqohzwk7KVI7bTwXLDJAYw4Ozw0PFN1new0UP1r1L0
         lQ8WAW4cNb/JnnpFFx0JxA6TZQx8/O3po5TtZO6g1VN1F5u+P2YkzM/b+bhDsRdpg8p5
         j+mzHbElj55RoJBBnLgJrWaq68pk6TAlZmdkNVWSx4PACfFepA7XS2+ptmz89Xw5yA8j
         xgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8VvGQUUvkZUkZDMYB04oCktoadoDytnukLijQ4Pz86c=;
        fh=X0l9sPbb2t+5IxJQLnkn0l+s0pm8FIa9Ze7hrXpNJKY=;
        b=VUcethEKXJ1W0jdInKToO70yE6B/pJB7O4vqS7cF6zXi8d8qhbcsIOXJhObXyOCZUw
         Orne+BoL+XCVFVH5e9zSClyLvq55xIRvADGOCpkkyzB97A7ChCqe1dgS7JMvG7yiUvdW
         82gNiaDTmSHneXv0VF/J3HQapmTXB87Tj+fj3JzdbtFVlFxtFIKJrTtCp7HnQRQDqQi+
         SklMuWSG5vgyTOw9vmsPbSR04c+sRBAE1QDhO+MuH1gp0milJrtmwn/DBzdg5Vo3K08B
         vLfO09Sp07EGZKVtNg2WHyAWEpcGoG3S41+ruLLPxEU5zLDPnsbeVkVCoAFFQyRxaCsH
         5oWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781583833; x=1782188633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VvGQUUvkZUkZDMYB04oCktoadoDytnukLijQ4Pz86c=;
        b=Hp2vOKAExq1TvDMVi1UDKuM/rsotfFBgU7PHjYEG4SyTeIjUbOBRRCcaTapJkpdKYg
         Oa6o7dGrZe0zQUJogNbkUbPUyNa2/ewonSTR9BLLMJc2pWBYfe2UQgA/n7FrggvQBEsW
         Ta6oCSlAMWKPpUT0ouo9C8n6OZla6SznITRTdaycHoHLJkO8yaQ5tfqNuNtdreS3vzys
         ONVAfVTzi9crcVk8jORhHReRtNPymqFhk5JbzhbQft23z/yA+NJ3AiE3mmh6GEDMLzAD
         K+j81KGi0GymipDSrSongVvERB3TI11/OnPluPGyZCS0/WT5WIw1NKW4vA2D8LFmdmdC
         puSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583833; x=1782188633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VvGQUUvkZUkZDMYB04oCktoadoDytnukLijQ4Pz86c=;
        b=Pc9UTWvTsur9XsovhcTNSjLE7PCfhE/coYEUs40Ew4y+cS5JbviXfulkTLxuemaprM
         cPbDUMdTn8C5W+F7ezJA86qEztlI70vPjLaEXbBfSVxP6aU0V5RrGnfcfgB8tczJGyfn
         39bDQoFaZUC9qqrhXio0mwJxpE7HpjWqxbqKDh5a4qHtAwC+aDgOSmFpnYIP1Y1zhv5g
         vRr5Kdgr9UU2A9dN8Fj4CYCHloowh7plWwGxZZBiqvVZJw2FiynwMl2jhljW6038dOA5
         aHKQO4NF9zxs5tsKXTQwDtgHCZuPT8YfSfwZ7Sph9vMQf1TuNh9kY11vmAr7z8zU+fYy
         NHdw==
X-Gm-Message-State: AOJu0YzvBL0hgt8c7DlyFmo7mwxRO5NvELUP4PFcMr6vfzhjho5sYObL
	/Kvov6Zcm0d67vmBSe45+w11/cIfeWFk3KiLVW4qagFPwLOda8IYuD+7LgVfUnwCfah/3WS4Txx
	S5Bh2bUs3kBQA3z5mUvKDjs7yLqO9P5Q=
X-Gm-Gg: Acq92OFNUJQisYfuiZuMA21iWkLaZeU9/F+fMbW1rsN3w5pDI41j8IWBmoRF0T3La+O
	y94enPPa4P6wngT/ulYp/P6HCZqzvvhLln9ug3vHzvRgUKtBoEvpRlzUYA/Z1L72s7XLDBDHJwM
	WRpe36WBJHt9YjQJIQLu6HAE68qVUgtTkP0i406cyXnaptPJeLm0wlKgGFfl2W38f4RgfmLvGba
	q0zIENvtljvuamc3Iz27G/Ih3WE0k0p1NFciGSRIz4wn14bPsb19Ny5TpdgCOiUfd+fcwFIAqFm
	MncWFouvMmjLw7v+vyowp1BRTGhHJ27GyZyAGSqfmCj3B9JPRRGAUXDCozEHch1En4pxMGZHSPa
	NWA3Y7hOjfdJiFeG5vmTa0DYb1STX3dbPmW8=
X-Received: by 2002:a05:690c:7090:b0:7db:ccda:a409 with SMTP id
 00721157ae682-7f7b564871fmr156914137b3.9.1781583832723; Mon, 15 Jun 2026
 21:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615152646.27639-1-leon.hwang@linux.dev> <20260615152646.27639-12-leon.hwang@linux.dev>
 <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com> <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
In-Reply-To: <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jun 2026 21:23:40 -0700
X-Gm-Features: AVVi8CdCY8CwvOpjegmVAAQQVFiMJANyhc1HaIAiQsegpqM7k_Lqr4_6NbUA3Qc
Message-ID: <CAADnVQLnnSrHDbw4OQCPrXz38wZ15PC1HuS1-aSB7LZxOQhd1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:19=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 16/6/26 05:29, Alexei Starovoitov wrote:
> > On Mon Jun 15, 2026 at 8:26 AM PDT, Leon Hwang wrote:
> [...]
> >> +    ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm6=
4 opcode");
> >> +    ASSERT_TRUE(ld_imm64_xlated[0].dst_reg =3D=3D ld_imm64_raw[0].dst=
_reg, "ld_imm64 dst_reg");
> >> +    /*
> >> +     * The xlated instruction has the map ID in imm and the offset
> >> +     * in the next instruction's imm. The raw instruction just has
> >> +     * the offset in its imm.
> >> +     */
> >> +    ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw), =
"ld_imm64 off");
> >> +
> >> +    mov64_percpu_reg =3D BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_reg=
, ld_imm64_raw[0].dst_reg);
> >> +    ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64_=
percpu_reg");
> >
> > If the point of the test was to check that percpu_array_map_direct_valu=
e_meta()
> > computes 'off' correctly then it failed to achieve that goal.
>
> It was to check the 'off' and the mov64_percpu_reg insn.
>
> To avoid relying on the insns loaded from ELF obj, use raw insns to
> check the 'off' with a percpu_array map:
>
>         struct bpf_insn raw_insns[] =3D {
>                 BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
>                 BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
>                 BPF_EXIT_INSN(),
>         };
>
>         skel =3D test_global_percpu_data__open_and_load();
>         exp_off =3D offsetof(struct test_global_percpu_data__percpu,
> struct_data.nums[6]);
>         raw_insns[0].imm =3D bpf_map__fd(skel->maps.percpu);
>         raw_insns[1].imm =3D exp_off;
>
>         prog_fd =3D bpf_prog_load(...);
>         err =3D get_xlated_program(prog_fd, &insns, &cnt);
>         idx =3D find_percpu_ld_imm64(insns, cnt);
>
>         ASSERT_EQ(insns[idx + 1].imm, exp_off, "exp_off");
>
> Would this achieve that goal?

Hmm. There is nothing like that in the patch.
What are you talking about?
Some future improvement to the patch?
My question was about the patch you posted.
What was the point of it?
