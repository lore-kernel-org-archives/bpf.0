Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065473D8133
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932445; cv=pass; b=K6jxngbbFffOYcbDkt0yWIDxzc4C2Pyy50U9uZwXntWt7jjAvJ5XKQwIEKokFfNHZlzCnhLPU1uawyTTuahv2PqK4gA2mey+t8+qbB/pIZhuh+282eSv/00TPBww1e+xFAqWZ1NJtyy01mZ0JGVocDSUJW12n1aoO7bqRlJ6a/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932445; c=relaxed/simple;
	bh=fwf68In4lw6OzxT6+RKKPcqK+bPzBDtFyJ9yLZBnxBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WstdGt2kyf492GY7UU8dRsC38lkL1zOk5dIPAhVV2cRkBdnVYAtSY47IUPkM4YM0BeAieMuPbmZ8NffXDEIMBvtSgSDvNNxf9Yazj7d8m9+7+VkpldQoOL3gKVJon3ekO5lfK7Q5mnSKa7tKVgnaEr22AXtY1n2N4QibQcVQqNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khaEzRX/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khaEzRX/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176fc0cc72so46613121cf.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 08:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932443; cv=none;
        d=google.com; s=arc-20240605;
        b=KlZpGZeS6Zz5pM3iGxL+Fe4ZQwDxcdJWA42yssM7yX4Tn5jwmZmovCh3767jjk39gI
         6IGQ9Z3DSDocjkFIOnGVws9oD3w5xnq1QuKbhPCHkHLl0PT2ONQ6/Qh8ertlngLvVkoF
         yWmjDm/XPzeDd6ydOBNmi9ty3HamPvUs3TcqeRZ5cAxOZS9Z6uw5SkbIZ15WRumAaIaa
         syE2tUMhhnosk/PGbdtnEOgR70qSSV8QI134mfGoAOE6Q0yoNKTL966PSVyMSaUIzArk
         6/WFNuIJRNb6i+xXJxEuWWeXRb9RKgPEpb5BFiUbJ7TOW0djBYSsNl3n3vkluEY4cFH3
         jJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/GbkNEHyeZtCcR1SX/qfPashyaMfCVTzBkT238FTUo=;
        fh=dldswN0RRM/xuttgMviE+a8GtD/9/pyIe+OShLHdGyY=;
        b=bypInbnaUVJdmmUmnqwbLp5nNEKu7eQXwSamr9q+QyXrXu6ucP6m9A/m6wyh+I+Htg
         NXH44thjgUDhAHvUJwOglBxRZw9mK/G8vI+ZuLG3eOFP3vP8kFo59iMRDtSC8F9Y6F0n
         CutTtPPmkvUB6GgRpuAkJR7AoTdrja00Uv42YfCRYh4SYygGDTyl6S2qJqNinzEMCz+E
         cM9OV0NBsQE9RfZKgKMJHV09IZkwVtheiJTmIbBlb7ziRECiJEHepNntqogcGnqKfyco
         Mh7kqOJiLaXZ3S4dpLiA5IuaAbhWcuLobv4EC1oxxyjHOCeiOHOhOZVCe5lUgmpVhKGp
         GbvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932443; x=1781537243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/GbkNEHyeZtCcR1SX/qfPashyaMfCVTzBkT238FTUo=;
        b=khaEzRX/MmCNL7k1dhkK914552kfxNz66By2dkJWdrr+IW18hxP1p3V1Nlak/d0MJv
         ADi4DAFvA6+nKgk0TuRbw8ooQ+/btrV4ULPndg3IuE8LBAhCQoNvA7H3wNlfw4krBn/w
         qbzMuGOx57/e8In17XBlFikKpFJIhzaP9+Qf8OBGHq8/2porjDBbga6CuRXsWETOWrce
         f4Jqd4sE7A3dUUkogjG6NgXIJ9OK3p+ufq2ji56ZROXfzFk0+rkvxJFiTIUtlFbM6gQP
         Chj59dz1I95CN3gM1UO7UcB+gYtuTRvAmbR42Jwvzq8cZSEmE3JCbKklybsEMe5V0tGb
         Wbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932443; x=1781537243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/GbkNEHyeZtCcR1SX/qfPashyaMfCVTzBkT238FTUo=;
        b=nTvVKsmhVReuEaE2po6MJabIdXEn0jd2MQgCwwK4jE7JlFODFqxu4hmUZAsRsxQ4ro
         ASJnspUKL+ykTKxDTscpDs6zllCIgDdLF6JH3E76vOUTkdUYS0rvAM53W+kko6sb2eZR
         keAmuMuoVmM6cfey0mFnJHFfXcE/fcOoo+jqzBT2IyG+sDK/ABzXBkPePsWXR1vRT//o
         AXtWAwNBplwxBlLpWbhBp05FE4AaojHq4H+ZIe6aN34V8g18oJKySQxrsH8z0BW2hC09
         ok6BPOcp1mV76qaiab9Rot9udDpYthbTe33jmvMKK4UNcKAMqpraI5IlzmNxTMjWB9Gk
         zOOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+u9MDtUbL1Hil97F+923lQf/+3vaRo2+TVSqkNHHqq9CY9ByKpvLiDdisTk3yVbH8zbEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLJGiGL5O24O7HCVjaIEm8Jzj44P/n1AW4sxjwCIEg7lvUv2q
	c+DcoOy4aalApJQgSPHbHlT5iwWjUiKUfHuIT7+aLlDkQSeKx9mLcGMjW0BqfO5B4PhDNEiRA1n
	yX60RXiyqcOIBHEXVBd6AZaQGVazXAsRJ5w==
X-Gm-Gg: Acq92OG9zWboxQzebx5Sw/3B47f4w+RovK82DpZksAyrsn9f7/v9svTGd25rcRSZJCi
	L9auw2GCcfa6iKlidy1kBwKWYN5kvoHM9/ycjZPDAn88NhDTNzqHRcO6IcLU3KIexjZeB+0l+7b
	BRimB0b9FJDgHBuDS3t+u8ig/eWTjZjPShYuA0OHxH7czfONJ028xCF6U4tqwlGQMEpP2VZRR7v
	MgR2UNTSnc1crTxz3rzrrC2BGVJm5db4di6CyzfbfE7Xlvd4GscOj0L70oRbJ9Ch2Qnv7L+cqsW
	a7zJcJkOifUQR3k0QRVEGE4kj1+JNFHI1cH4oO1srKxrtYOtQpLckfJaX9NG
X-Received: by 2002:a05:622a:251b:b0:516:c9f2:a9f0 with SMTP id
 d75a77b69052e-51795c6b1ddmr122455501cf.30.1780932442701; Mon, 08 Jun 2026
 08:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605145707.608579-1-dwindsor@gmail.com> <CAPhsuW7jSxHF1sH2jMYf9Px0iuMadt0bX13ABF4D=og-hQuq_g@mail.gmail.com>
 <DJ2OAQE4L6G9.PX5YMVK1D2HU@gmail.com>
In-Reply-To: <DJ2OAQE4L6G9.PX5YMVK1D2HU@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 8 Jun 2026 11:27:10 -0400
X-Gm-Features: AVVi8CeZQTRB8p-2bK_jFNkHSqOH97zB-SYhVrDHXIBsjZ4XIhQFv_j95KLBJWU
Message-ID: <CAEXv5_juUiF+ALPAnYnk_GYn-AnoZBC88XpWU45c+xf3kwLWrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at
 load time
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 4:27=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Fri Jun 5, 2026 at 11:40 PM CEST, Song Liu wrote:
> > On Fri, Jun 5, 2026 at 7:57=E2=80=AFAM David Windsor <dwindsor@gmail.co=
m> wrote:
> >>
> >> The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
> >> not attach any sleepable BPF programs there. Add support to the verifi=
er
> >> to explicitly reject attempts to load sleepable BPF programs destined
> >> for LSM cgroup attachment.
> >>
> >> Without this, we get the following splat from a BPF_LSM_CGROUP
> >> program marked BPF_F_SLEEPABLE attached to file_open when it calls
> >> bpf_get_dentry_xattr():
> >>
> >>   BUG: sleeping function called from invalid context at kernel/locking=
/rwsem.c:1567
> >>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 34317, name: =
load
> >>   preempt_count: 0, expected: 0
> >>   RCU nest depth: 2, expected: 0
> >>   Call Trace:
> >>    down_read+0x76/0x480
> >>    ext4_xattr_get+0x11f/0x700
> >>    __vfs_getxattr+0xf0/0x150
> >>    bpf_get_dentry_xattr+0xbb/0xf0
> >>    bpf_prog_e76a298dac9218c6_test_open+0x6a/0x85
> >>    __cgroup_bpf_run_lsm_current+0x326/0x840
> >>    bpf_trampoline_6442534646+0x62/0x14d
> >>    security_file_open+0x34/0x60
> >>    do_dentry_open+0x340/0x1260
> >>    vfs_open+0x7a/0x440
> >>    path_openat+0x1bac/0x30a0
> >>
> >> libbpf provides a .s named section variant for every sleepable
> >> program type except lsm_cgroup, reflecting that per-cgroup LSM program=
s
> >> are intended to only run in a non-sleepable context.
> >>
> >> The above splat was obtained by bypassing libbpf by using bpf(2)
> >> directly.
> >>
> >> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> >> Signed-off-by: David Windsor <dwindsor@gmail.com>
> >
> > We should add a "__failure __msg(...)" selftest for the reject case.
> >
>
> David,
> Please follow up with selftest for the fix.

Thanks, will do.

If this gets selected for backporting, it'll fail on 6.1 and another
version; I can send the fixups if needed.
