Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD03FE375
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806977; cv=pass; b=KEcc1Up+GuzguffJGIlwbqfsb2d0gGyxQxFz0wnPB1s0N04pW1dDE62sGEbfe81hBHL+XO2G65reuL6TzTmunRx1xKUcIdTbA/wAsME9LsLirv3bBQSyxzPLrpaQRwMRcdpwhZyVddQeOAUvGOD3QNRXQjnwu8C3HU6X17Vfv0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806977; c=relaxed/simple;
	bh=gwz0iKMAWJ5phZxYKd9rPJxAmiusXvmLjHD/1OAfayo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4VgiVovyUtuJR1qhxhfcm5O3N5TYiHz7cD5rGx0n1Ldiks1IipJmwX/R2NVYIRHJPpe047felbj/0IBw4GC9jr6+XQ6KziX4NVl0giy8CCsqcdVEdute4hfiu7crMqmFlQ9Xvxhx0v1x6OLmcqfkxjep/nWUv9GFBxgXjA9fO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhfOsJwE; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhfOsJwE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49048e043e5so31448365e9.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779806975; cv=none;
        d=google.com; s=arc-20240605;
        b=TQDZ1A33W34UguUdBXmekFArGwGKBGHC7QcU8A8qQfvuv/1FLdS8t2U5biLcNS+IWN
         HNUAfnF5u2SAw8+/MeU3ZMjLbcW1JvoW0zBX1v+gUWEdWK7gfiVyknUMpHjYprCFfk7/
         LRxvwLgolrzFY2z7plOQH62mlKeahU5kybeeyriEf4d37Y9ber9wc52jla+NuoSYMYrx
         hHeQPxa51IhxYruBtp6AfjAt18O0CEsVW0gFLT7Sve5cVUgQMQXPR5INfJ9tnyM5TRtZ
         roPlzGcEgsXC8R+u6Nsss5IrukKDnm6rKfiXTfxtw4qiRFf/YN4s8tHdXSC1yXyKre/x
         4cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gwz0iKMAWJ5phZxYKd9rPJxAmiusXvmLjHD/1OAfayo=;
        fh=N9NhXPdwAo1Jmp1eihMvJEYPhqq48Crun35ADbQB5zA=;
        b=LYZzeAbpfBYrh8uv/6JqtFDkfvctCc5Zp4FBOjeuJUgcSHMbXiL8/R7W8FMxHArXHa
         0TtqOkV8FsA95oYyo71vGGTyeeFf0TICC5kp8u407ZRu0Wb1iGmmgQOKla9RrxV2Fnoc
         LRbLBdeemOzz2/rjhq6pAn/jtvxgKETLTzQmDSOJdAZ7z3nNx+YQthtmoHnTC1wrgLMJ
         6AkV5nnTdjBAGYYfK7yoEhEx5S/bGqVfYz1fo9BPIyKpFlzukR1t7A4z6uhSc0/5gHCa
         YoHdXl4Qeilzt21IgjbTqQH6Wn+LAYVSNylCLoaHSDT8mzDY18MiRDJMBYU5ZhWjisFr
         IOaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779806975; x=1780411775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwz0iKMAWJ5phZxYKd9rPJxAmiusXvmLjHD/1OAfayo=;
        b=GhfOsJwEapHiTlVU6/7roqVU+QMdWJ0vsR6c7e9j/2IhHWR7g8+I+WqSKnddsUwV+8
         vivTDlUR08wHjpwu6ldohy1SUl3AssonWuhOqcuYx9fKTrJXC65yJIWDg3aFrCJ1ZpNu
         pmsQmUQZUJo+DoWZCOuSRFKfLU9LZrbYm5XXLDj+f9FkvgeS+jZAkXkTDE+GH5cxKCZX
         5p2uowjr2cxslbrlzaElsaiP+FKBSu4uLLDqArv2t2IrI2lU4ll3kHz+rk3Bby1Uz2Ll
         Fb2JXrHB3MjWSfybjkGaQ7IxdkDxFn4X+Zu0qTE5J5Gq+Ihyk/PjmAwt95FVQCXXch9I
         lxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806975; x=1780411775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwz0iKMAWJ5phZxYKd9rPJxAmiusXvmLjHD/1OAfayo=;
        b=N1LA7jyPZSdd9Yt6B4oqYcHnTe8bvyRm5LRKmwE2xvH/ueaRXw1h8qjE94V2pAr9A0
         BaW9WINoYQiTHq+jcWqNv0sjNuuCzbAMpAldWC9TwI1Ml1Qbkshsr1A3ehtti58QGzZ8
         xonbTxrooHHBBqcLuu67lINoNkJzPUOQr+gNyFlcVERXMHGSvtzJlnibTccf9b9UT60z
         hbQ0WaKWefZioCzYvaxjxUqyFwD/xBtGT0bIOlko2RHQNef62UU1AMN1IqKFk/xLlLrl
         qjHaRyMt70KSyrMjKsx1jjDYjmxKhE3ZAKknZi9gWd7lOaoTXreKbck4OlqlHHHit62D
         LGQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GXkDKwfbECriAL38txYaZ4gC++p/q5x8Qew24iV5z2UkPYX4CNgBHwRvYBRELTkyQM1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyGGsVVTuEAYsKw3Lbv4bo+hlpB0MNhhZLkAdo7AQ3QllPdE6
	JV/csQ1JxOQMCDuMnrNZ6LH1xeohki1qbB+9dAyJTzCXwMaI2HMUdBzsDa+J9auvUwsgjp7HkaG
	gJTS9Q0QxxtL1N3K1jeHzaJTtH6Kp30Y=
X-Gm-Gg: Acq92OFEr5/lQD6Uziy8kSdV1tgCOf2NcCcqUO2oPAwJf+9jmLU0SEYkxUt/kTvVQp2
	7vwn7o1O8t87lvstZghOuKoZR6OTdVcttNhynKThGZNnaG2ReA9g5wFfTbUZDRsazmim3eXSkDM
	esi0+7jsddSaT5aux1tmqE2iQcLGcZIoJOf7hcMmTDrYpBoGk5knTJYRbrGHkGXDfNAbH8UvyPG
	6xtMJ0KuzFurjy89JzafS4PB/kDTW/lO5r9pWdifzEx55baM3pb4T2/sjrVcEAVsGJqf0pCgB9X
	qt22SEk8Gel/RlaxuTYVU8IBrGTEdNWqPxJyl5CGJeAURh16pc5/eTYuuJJ461ItqCxs8Ea2ZgP
	Ws0qOpA==
X-Received: by 2002:a05:600c:3b13:b0:490:598a:226b with SMTP id
 5b1f17b1804b1-490598a2290mr197056275e9.28.1779806974324; Tue, 26 May 2026
 07:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 May 2026 07:49:23 -0700
X-Gm-Features: AVHnY4KdKmmA68XKWbdzDyD4iZcJrL_jrgJRI7WR3Ng7KRNIDpQ7mydaAoVOHuo
Message-ID: <CAADnVQ+AA_fmRw7uRwdL2TMyMbpWeebOQKb=0wvpKiQR6Ee5xQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] libbpf: support STRUCT_OPS in light skeletons
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, gprocida@google.com, maennich@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 7:15=E2=80=AFAM Siddharth Nayyar <sidnayyar@google.=
com> wrote:
>
>
> With these changes, it is now possible to generate and use light
> skeletons for BPF programs utilizing `STRUCT_OPS`, such as custom
> sched_ext schedulers.

The selftest is mandatory to prove that.

pw-bot: cr
