Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F3482DB
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751654; cv=none; b=H7ra9xE3/GLRtimejRireScvSom+OhE1vuIXOaKP6X1+2l3fIiLIUFY0XsDVmtRkdiBVYGlFcAr/Nrl4PPP7uRWMhOyHzQyvKN7C7m8O6+ZFY4tCc4xjoY0hC8X4LuaMNCnjarjHfeL3qJucmtYwOonKe5cAkckScAEtXZFBnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751654; c=relaxed/simple;
	bh=OxGuyj9VG/D335eWYXwM51uTPReZGFfkzuNg6L9ajMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTscwQwKB5HHgER+TsHvWYoJYBVyp3kcoDZk1B+Lzd1SOz0rGScrPkGUn62HmX+WZz1rZ/U1UDO10ut//1hTnlJODmcn1xiR0Ldm/VJqncYDWT69v6/8S0YXAbIkO8LsxCzIB3BMabHF8r9sty4M4h70VFqj7NbM+RJJb1Ac0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAda5pOq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAda5pOq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29df3333d30so1769802a91.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711751652; x=1712356452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOF857UwdxGTF7GEGb9geEUq4htJYKlbfwY0N6nRTdI=;
        b=VAda5pOqzx1HWjaiJezYAKGo5oQ5xw/DEToYBwfcKnXF5GgJox6hzwXBoDp//81HDi
         hXCCfL9lNRF66mr4Rib+rDmeR437Cdrkl2x6Zgm9m39uiy7f45CbOVFF06gRzvC1zMmr
         ix+0q/fyrtVrWcgxqVDqS5yefqcVRKq1t16eiOvRoNov+SaPbp2seJLRsHB3aD5+rVaf
         O1+A12AvcYjxqpg+6l4/oEuiPpNaA+scBp16CIRlXYVQV5Bphzvl4UyFKtp9A/Y7MSM9
         7NVQSSXIp2XwNeaKjvsZ8UjBZelV1alkMcbBlnslLU1waVIEUXag4jMnAZzTWdG5EoAW
         504w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751652; x=1712356452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOF857UwdxGTF7GEGb9geEUq4htJYKlbfwY0N6nRTdI=;
        b=iGeMDDHwmJCYgH3We30JRwpk+kXON+cwMF3iMkz1zVKImFUOF2W9IDVKeYUnP85IcA
         thsF5M+xq7BE+XeVBXcoR04e29BMIkOn0KISnce+s9CACnD5PF8PI6M2rokR7xfCvhgf
         KNGBlrgYj240R9sXnXhgk9N6vpCrWhDxnZEz3tA1G6u48n/sv1NuQnywZ+mu1N+zMLQC
         i1UfZGeT0dgbziDlsvWEgDOLMKlg9RhdXLqBOuNZUZ7Ry+cA4FWAdoR8LxE8hpBjLx4f
         b4wZ4X52NUpLV63KIlZhD9nc00nDkNy3glthOSDiBOxn4Av/hTWxszyutRMQF0c6euVd
         +igQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+NyKaGNjYAOjMtNT9aPRwgriTGKY/IH58aWVIaty7J88D/MTch3dFFmRP/0Ld/W536L9vhv3a40dP8wNEDAbtASzT
X-Gm-Message-State: AOJu0YzZ78KEm5CQkCARVrx92IzxKFh/KeZervSZUWVsJcMfJZQXg30p
	KsJI3SWQxsUBy1eE/BmuF1gIA7hTYp2WGo6K3yMqO8fJ12EY9+tbCr8X8vrz63kse3OEHNQDV7s
	v2AUZHcA6DeU5kJtDT7iVT43/8Nc=
X-Google-Smtp-Source: AGHT+IEW4q2mwnSZA9sK+uwgrLTR5c2CikcoGYCMy4jL7taxn/v81Vgt+mCmJ1cnfn0/sXb4vTlnDh7vVp1ohdc9ohE=
X-Received: by 2002:a17:90a:b004:b0:29d:f57b:48fd with SMTP id
 x4-20020a17090ab00400b0029df57b48fdmr3392372pjq.10.1711751652643; Fri, 29 Mar
 2024 15:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327102036.543283-1-jolsa@kernel.org> <20240327102036.543283-4-jolsa@kernel.org>
In-Reply-To: <20240327102036.543283-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:34:00 -0700
Message-ID: <CAEf4BzYXFX3Mx+3Z2BLHrUw5dG7qaz7R2Tfc82R+OMhT14rDBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add uretprobe syscall test
 for regs changes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:21=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that creates uprobe consumer on uretprobe which changes some
> of the registers. Making sure the changed registers are propagated to the
> user space when the ureptobe syscall trampoline is used on x86_64.
>
> To be able to do this, adding support to bpf_testmod to create uprobe via
> new attribute file:
>   /sys/kernel/bpf_testmod_uprobe
>
> This file is expecting file offset and creates related uprobe on current
> process exe file and removes existing uprobe if offset is 0. The can be
> only single uprobe at any time.
>
> The uprobe has specific consumer that changes registers used in ureprobe
> syscall trampoline and which are later checked in the test.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 119 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/uprobe_syscall.c |  67 ++++++++++
>  2 files changed, 185 insertions(+), 1 deletion(-)
>

LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

>  BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL=
)
> @@ -650,7 +763,10 @@ static int bpf_testmod_init(void)
>                 return ret;
>         if (bpf_fentry_test1(0) < 0)
>                 return -EINVAL;
> -       return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_f=
ile);
> +       ret =3D sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_=
file);
> +       if (ret < 0)
> +               return ret;
> +       return register_bpf_testmod_uprobe();

nit: keep using the same pattern to make adding more actions easier in
the future:

ret =3D register_bpf_testmod_uprobe();
if (ret < 0)
    return ret;
return 0;

>  }
>
>  static void bpf_testmod_exit(void)
> @@ -664,6 +780,7 @@ static void bpf_testmod_exit(void)
>                 msleep(20);
>
>         sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> +       unregister_bpf_testmod_uprobe();
>  }
>

[...]
