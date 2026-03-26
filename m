Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC103BA235
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516107; cv=pass; b=LTJGe4+6ybkuTtEFRZ167d+sVDozmO26ASphMDgALPIPLBVyEST5BfDYMRjFWrXUfRSCA2rYPSO5yjMsE/ruMHgFiuFGkdFDg9OMWJqNYby3tF1K/VvbQc4MhOPELibQtZYxkJ0CLXmoFrpUdC2QGv7nBp9pmcjltpAS1ZuoLIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516107; c=relaxed/simple;
	bh=nELhMo5HbKoT5PmrQHIsDRZuES6n1hKRONlh2hGKiy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuZzLDZPdOUfTg7xvQ7v22Ec/milzzvWV99kk43uiJaQwunhJ2v596N5+jwauaQ67d/c5Se5k14CLZfgBXj/V2l9xoWJZnZ77Nj3znbCOXcjxyUXztNV8vuJUSCpEUZzuoWnLrsAtOS//rJJmthnoAYaMlzZoMjEYM4w8/sZJ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIuQlPu2; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIuQlPu2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66a4c6bb6ecso1122292a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 02:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774516102; cv=none;
        d=google.com; s=arc-20240605;
        b=RNKQJ5ZSyAytIr3cZeY2zfD0HhSjVHEG0IuVm2BJV1ZiQ3ERSEFqVN1ZBMdePHInQZ
         kOH4rJ6NNnbTDXDYdMoaOwSVNoShl02x+SSVBz1tenbWnuBdWichH9jselSF12pmIy/w
         o81HBo17qudcUg+EBiWGm76l1KM0AIvKXudRMF9YOlQfki6UhvUWffAmin1MCcauAo9z
         0heBa0yTmtga3p8uzhWKuP6V7IEW2jefDwxkjLSxlIp7EFRcQCtUt88+W9MiF5jGFIW7
         vhuaHJqNOmK/In5Vl0c2Ti+wtsvsR6XSycTKtKBMheo/GgYMKF+5Jhzn62JlL4+7woTN
         ukRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fupcQia+cIixkDUZQnHZg9spgTCSgrS5ZcgFhd7IQSs=;
        fh=kgRp5VWqnb+R1VaC6eqio3iVft5+kpalc+14mahCSvE=;
        b=KOODuZ2S5ch/V2qG7s0o9EyfdZNtyOMeqVz0YYbplUi0ipdS7dbWWVIua4dJObtLst
         LIXr3Ls+yXUzZVSgHzd/nJr+bLn627kO+7v7JMoVbPpYrhzy8qDcPPai0bn85VV7TJ8U
         gEYdNsvsMToFuRsW1yZ1/Jzef9mKZTwmvB+hflZAzWizqYe4FBlfJLcjPR2+Yfw3sAJK
         TE7rT7OCWyrxYLMkLUx6tR9/jm6q1jcTnvQF8kik480u4lP9GGDldHItdj8TycUlKQaK
         vkLuqPbyM//IYEdjJXdVCvASb5WDQvIrb9jLvZ2/siGzmdvCkPoxL/hiuzuRmaypadzL
         oQkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516102; x=1775120902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fupcQia+cIixkDUZQnHZg9spgTCSgrS5ZcgFhd7IQSs=;
        b=qIuQlPu24oLCDe6MsNAxlkbfhztEEpkDB+tVzFX5sl8dye0nLHlmDLLSanc835EPzk
         VrzKNnOnDb+UMFj1Eh8paJNQwaj3fdBODT43djTDl4QnU9ofl16jHRcgp3nHROLxoWWp
         BkpjeaGp4S7IOHtyLpMP8cIwdSB2lYwso+CDwjtFfTfdUUy171T9QDahrPhI23bssRDf
         f04sInFAhnaWiQkgL2YoqdViWEYDnPONUGCECHPkpLTjyG9X1Q97+Uiv5SkdF2r0r20u
         NWNuYEt1EEgDYMfcMJgTJPwGQDNGuZizLe4xjmFioQ1lrFZITm2kIT66y41ZKq7/3Sm2
         Cj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516102; x=1775120902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fupcQia+cIixkDUZQnHZg9spgTCSgrS5ZcgFhd7IQSs=;
        b=XDWgPetEEtAprmJbPuTybjm9LDtmgymSf2Ryk5X+S2EqFqXySfUGKZLpB3FoQCxNcn
         dHDgYr4ZBAfs0p+tBaSXE2x2Oca2r6YZ1L87MRmpUZnuaGUjNQ1q9bpMENtiehYF8ss5
         k/wFZmFtcmu5wRPApCuY5nxPodMkMNmWq0pjGm/uT7wNFxbFCtyxYTVYwJ/qb+qvpWrJ
         iBrDXMAMtBIZt4TVsaQT2qmy/Kt1VxLR82ZFeLFUScGOYpUpPx8ae3ZCG1LHKZas59EY
         cXz+NwLC326+WqC5Qc3I3Ho0IyTSL8vKi4wiIPYLrr3nxmom0COsTuNJdxfrLp1jjzGG
         a17A==
X-Gm-Message-State: AOJu0YzQCIIVZgoZxO2h2rdmJydM2/d0YNGefhkdxsDFczlxX5dNYt6u
	dPMCq2ohEvs1HwV1N+noEwscbpqY0HiidB6c/e04WVvwmfa5KkxMNP7F/77FAAL2ZA8hLf8KEYj
	XTBcdf9WUxxrcaPICbTHS/R1zQwL0jiY=
X-Gm-Gg: ATEYQzycJii/Y2P05U3lfEpDU66uweUvlXdJCmiN13MmAH4lMPFlDIrSwGiI0yWf1GP
	AeUv/pVtmgfh+Jb4ktXjIfNAf3QC6HeDQGl837ZSNFQAYkWKq5oFLikWF5CD262eYPbj5O0w3/X
	HVwzfRNQmq2BerBqHROzaJ4KNIRsY3rzJD8r33iXqNWFlswK0pZRGiCaPbl0JhHBZ/iFtlEabin
	DsO/DhaZW6i+37NYBcYGZ+KIkbjtpbDI+z4MboJOzoHyS3BBqBy0T1OAvlXLSd5aDVZ6vZWep2O
	afqj0AU5ivNapi0MCUSKvvk=
X-Received: by 2002:a05:6402:5207:b0:660:e00f:3228 with SMTP id
 4fb4d7f45d1cf-66a82709918mr4302124a12.30.1774516101793; Thu, 26 Mar 2026
 02:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn> <20260326090133.221957-4-tangyazhou@zju.edu.cn>
In-Reply-To: <20260326090133.221957-4-tangyazhou@zju.edu.cn>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 09:08:09 +0000
X-Gm-Features: AQROBzBur7JLtjpwsp3ueTQVtT5jCOMRuY5Q1dNhbv19g9q2roGQNP4teaJp1gY
Message-ID: <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:02=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
> the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
> (e.g., call_imm > 32767), this silent truncation causes find_subprog()
> to return an incorrect subprog ID, which is then stored in insn->imm.
>
> Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
> fails to resolve the subprogram name, and incorrectly displays a raw
> kernel pointer.
>
> For example, dumping the xlated bytecode of the JIT-loaded selftest
> introduced in patch 2/3 (call_imm =3D=3D 32768, i.e., 0x00008000) shows
> that it is truncated to 0x8000 and reinterpreted as -32768 in s16:
>
> Before this patch (with call_imm > 32767):
>    4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>    5: (85) call pc-32768#0xffffffff814aed4e
>
> After this patch:
>    4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>    5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog
>
> This patch fixes the issue by passing the un-truncated 32-bit
> env->insn_aux_data[i].call_imm directly to find_subprog().
>
> Note that the assignment to insn->off is retained. Although it still
> truncates for large jumps, it remains correct for the vast majority
> of BPF programs where the offset fits within s16 bounds. Keeping it
> ensures backward compatibility for existing user-space tools that rely
> on insn->off to display the relative offset. A comment is added to
> explicitly clarify this truncation behavior.
>
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in d=
ump")
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Yazhou, you should wait 3-4 days before sending the next version of a
patch(set) and add a changelog so it is easy to see what changed
between versions. For single patches you can add changelog below the
"---" and for multi patch sets, you do it in the cover letter.

Thanks
