Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3A41E4E
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004117; cv=none; b=SoIJJ9GlcMtx5NQabrZnOxr5tlD+2aDdEkG/BRgHcI4nvJUkTuv5ErkIXJ1zapmrt5ftm530VD7DaeDvpKg89zm1mElNKfRtEnk12WTGpLhqJoTT+MIAewAVwz5IaMaPql5yri6jYri+RbRZm42TMQrbYbKwElPqCa+W7S76+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004117; c=relaxed/simple;
	bh=SAIleurdGSaNMkjA3GiQDalXb0OL3UkpE6hkZgsy+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvILvBUejVo8Tg4oKObBzpm/RMIUMhv6Lwo3RcA9XoHQgjJ+6Bxb2oZJ9WyBaCa+VbHX2MFMJIn/IPU4L5cbkmvsC7S5kesTRLj/KIYF9pF2WW9Avmpt51gFnC19Qik4nKux/G0BqhRM+UpX0S2BlHjGkCtG5X3hSKVsOt622Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8Lg6oay; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Lg6oay"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41462295004so4721675e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711004114; x=1711608914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMRt69/l8ce/kY4LmogoH2YZViQ73MTGxQEO7X+mEgg=;
        b=R8Lg6oayoThX809bsLnDgKA7AqiFXxG/HH6iFLPqOY+/d+KQyTOrGymsSG5dfL8NKB
         YDa6g1v++P5iedvB1eAUgW5txVdFtvWpkZmrghLLj8wtw53H1EpE/Fe1E4w2HQN6yBe9
         jUdo3qJ4DDrVtzHv7pW3CcFBkITCQAPHsNbAVyl0npe7jw94YvZGkdGUAyJC2xJdMkm2
         KM1jgGz3KUvk+KTjhJANVlSfxPSiz//8z1Vvt65SzswKZygsNUJmDWAdIcuuX6JNf8QX
         wsWqYnoWue7VRcRNxTORxoG21b3ZgSENVJk+Qy1+MA6TWvZq8B+D3+U2aANtGlzBGcQX
         sqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004114; x=1711608914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMRt69/l8ce/kY4LmogoH2YZViQ73MTGxQEO7X+mEgg=;
        b=J3wCT1FwPyVZm6ZlsjDLUpYan+wKElTSqQyEf61hHRyToJvm3W8VBLQNW20LLG+f8J
         Wt8ua7oeVVSPUOLch6n97nA2Zh05vqXaRgU5JZEiqnV1l7galj+0e1mOkit94q3uWZUy
         wHmG9wGVAZ8MsUTT/eibHWwAhoBcXcf7dqslkNWtNJ5fUoomvgDhxPzU35ySQb9uZp6l
         n1ND1ro3qZUXKC4LBGUyjPTxazsTocQqXs0nQI8c6JhIe3MlI8skykD/EwSPCla2cSJQ
         XN/JGcWJrodY+C5Hpf3+krrLoYo7CyLvFjjttkb3D2qE9mCkED3WGx9H67lTiNp2ArS7
         2qvA==
X-Gm-Message-State: AOJu0YyctUT7Y4JpEHubfRODyBXG7i/sNebIOqGOA7Za8qC6+i9kRjs9
	UVxxiKaQO62ERjQ68gurmcFIn7FdWoKK2SPS1zdZg1ynMv8uvVuwYEuM5yD8UJM3imqNDc1CG//
	SPs2tzO7mygIhYgDT+XhMIkaZAPUM5EW2duA=
X-Google-Smtp-Source: AGHT+IEVSKxbCaxqyU1O4OB2sze7iBJhpPNGXqnrk6Gyj1P/dxq6r9bZ0p67Q02yKmSJHZJvMBkypze86sJdrUjyqDE=
X-Received: by 2002:a5d:4949:0:b0:33e:818e:d076 with SMTP id
 r9-20020a5d4949000000b0033e818ed076mr830752wrs.47.1711004114375; Wed, 20 Mar
 2024 23:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320200610.2556049-1-andrii@kernel.org>
In-Reply-To: <20240320200610.2556049-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 23:55:03 -0700
Message-ID: <CAADnVQK6v47nqE+0BGGFXFp+_5_Tbj23=H24yDJJo+MihQJYdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: mark kprobe_multi_link_prog_run as always
 inlined function
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Dump of assembler code for function kprobe_multi_link_exit_handler:
>    0xffffffff8122f1e0 <+0>:     add    $0xffffffffffffffc0,%rdi
>    0xffffffff8122f1e4 <+4>:     mov    %rcx,%rdx
>    0xffffffff8122f1e7 <+7>:     jmp    0xffffffff81230080 <kprobe_multi_l=
ink_prog_run>
>
> This means that when trying to capture LBR that traces all indirect branc=
hes
> we are wasting an entry just to record that kprobe_multi_link_exit_handle=
r
> called/jumped into kprobe_multi_link_prog_run.

I don't follow.
If LBR was configured to trace indirect branches then this direct jmp
shouldn't be recorded.
If LBR is capturing stack frames (those should be call/ret instructions)
then this jmp also won't be recorded.
If LBR is actually capturing all indirect, direct and conditional
jmps, and calls then saving an entry won't make a difference.

Maybe it's an LBR configuration issue on the retsnoop side?
