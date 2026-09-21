Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04B229B38
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027998; cv=pass; b=otEZLmeoYczb7pCWcdKy0lUUomdiFN0xz67QrCrJss9273O63gqDXdrU6e8xfDmLbkHjZ9m6OAQMwz3DVHu8XpOCfrIQLqoj073oxR0gkiQBsNTiCIbndf6D6P8t8uMPN6IixTbuAYfgDItRFDCnZMsMHkOjl75pYiShtb3Wu84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027998; c=relaxed/simple;
	bh=ZSXJsLG0n5mKfVuoD1VqTcG9MfIiLklpu0DxRJ4e1Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh52F44d92p/QCajMrVsXn0kdSfZ0HFIttLMWfpfS39oLcnYEyHf0J+RP2ABSeOTBcWcd4kaEyC1N38Yl4NtNn4diRYUZZl+KVa/Lc1Y0DMAcvtfYNdXqpngoJzkfaCazg7Gw2aqbzSZJmGYcojm4GcKKaNmoQEuSkydAD5zzvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1AxPoWO; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1AxPoWO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso3335493a91.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027996; cv=none;
        d=google.com; s=arc-20260327;
        b=NIMSZTOJW56rLtFGQ9m5CPGgOa81tqokfOaVVJG/Iumht/OMCAI0ESM5fziEFgkSPt
         NLjvJlUcyVQ3wpezbiherab479l/USB+4IS2ctoDv4vF3747FO2U2VKifIfqZasyJis0
         e+98thJU1cYEAr5X0NPGLg18gkF5gogUG/v36UvsvyYWy8d7v57Gb13TMKAlABx7pBmG
         oExzTA228XVhk+r3uIfeLXK3i+o6+X7FQZDUfumbA9uv2gptHnowvlnWreBPvKI2IZQo
         lYsD1WUNuCGavwUzlYmWgyZoRlBM1mOXLD1ZrPLIaLE4sRwOK9Knlv2HgYidmVgaIWCs
         bRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zidmu+RY3RU2nq/L1X/QMRBfI/Kp6AgQCY+485qcP0w=;
        fh=fe3ZoP8lDZdK1DWy0CC1h1r1Nb1THfssTUvMBL8zgAk=;
        b=OpUEWF7bejf6EZbRAFj8TUKFC9ej4GB/ekhrgRZNkUuHAjFW9Lf95KB4vWCkxWLthf
         bzKEaRvFusNcvzcxch62Jcg4TT67rpC4UVUmWIDhiI8W4UMOayElFVyiJSaAI0XQfnRS
         Nf6m66se6wAJGoy+xurtQpjNmtgkk3mzCtnWAQz/2NmYUWTwpH34ldnTHyWFG8J5Cc4m
         fUPckIpWmB2piPeGDEElt7OP318x259lIrjG0xOZtIH1pyPWeOW4mVHByZrr+GX13IBH
         E1HjcrDQu0PG30cQBP1a3boIKJCHoDarZlpOM78bqANHzWYXL8VWu96sBSHJWZTMTKuB
         1VVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027996; x=1790632796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zidmu+RY3RU2nq/L1X/QMRBfI/Kp6AgQCY+485qcP0w=;
        b=M1AxPoWOCazRfv5+Iy4vbbs8fWR100N7HuGQG1DuJHKsi+u3DAWmiYm4Jq4Df+O7eF
         C8K0ZInYQqnEMPAs+mFUrtM8c4sGgtb7jeRtpzqF8uAN51aF12wVIDdIST7Dc72VNKo1
         GhcnwBZcHFurrPgCjocHJSwb8HZEOX4L1iwfwOMIN1HT4BnHp2ck9O2cVIXEbN7RwWph
         qK9fmr9r11moNKlC5InrApwUb4qLZFlIG34ZNfI8/b6uavSlEnSboDktGdadzgGmh2Sv
         SnBnEuOnGI+yVuw0Q7a/p8xREi48vxxEiDyJQjtZFAlaopy7CWUtKmj/5KsiPmINz3gW
         4nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027996; x=1790632796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zidmu+RY3RU2nq/L1X/QMRBfI/Kp6AgQCY+485qcP0w=;
        b=cjbqaVZbHygvhh6vJ2ZWL+GJ2vjC/SKGnqQFAalsg489f76cRkI3ky8ds8PorLI479
         ciRfQGjvTcP7dXBiAcUvswEHfZiicd/86UeTtGcy8+kPgEcxAADgMfdoF4iU1rmZI1KK
         8t4CoyCQXQixNb9DkJpaHpeJhVFYEG9EHWveuKiTNlUa6QweySBv+CjbuAISeCyIVrLJ
         bhbybJXYnpDgDC62DTwAr+Nm2B80eG7ja/1SFt+H0l4mD0SB0wRFzHGwzZOyryp9/Huy
         utdaDwuUyXRPC2YzN6zRV8wQch8VAGTxxnemLOHUst0E97ulbSwy8I7Rd5AStljcuSu3
         yTOw==
X-Forwarded-Encrypted: i=1; AKwUvBzmj8YNU4mYg9XUyunkE30sg3Spb6rdYOqRUubGagJCaeOw2W11CMhhv1Y9qxpP1A2ar6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n+VmzUvvT02oV0ctWdI0Og7F3/8xch6i0SujWcVyiyf60qM3jK
	Oi1MWM7K/JObtiBkBk1EJZjlH+KX0ir0SY69BBtGZKDdaBR86Fr2Qk1RsUiBXV+B0L6WygAue+q
	v+ipb53JZBTpnfB4wnMBxrCAhpjWcOi0=
X-Gm-Gg: AYBFou2MO+2Cs0+4R7+43Uc/RmFRvdx4KmWShw44K0XjekJ2CPkCE/1JvGsk/mpK6oJ
	Ve6QvzwlU0YJUaWQgR2Kw9GnhnAgpG70qiv9m7GEu0YAvfITW8tuHtMpgtk9mLk9S7y4TrwmM3g
	cRvcqH0mZ1qEGwORTyCXV2x8jHAdE43jWAIA+cACPKwIHxb8yUEbdOzNplMIgclGT5Y0UkyjT43
	n00iaUkweYMJlIm65OhH1GAZw4BsXpEmnBLvxNMl7mPP+iKY6Sr5uIhqHtEChxrpfnprJuskxYb
	1iCbTcwNV6YaNtXnE5M/hjrOHhTcgDmwg4Cc2o2UfXHRt9cVuTXDfqtRMI+g+SD+BWxmmYdbbEq
	e9Qg3Neh5+NsxrE8KQuZSodFYUe2YnkxJYtMmrblizplbQ3VeDpCE
X-Received: by 2002:a17:90b:4a01:b0:3a0:4abe:fcbd with SMTP id
 98e67ed59e1d1-3a04abf0758mr4461121a91.19.1790027996048; Mon, 21 Sep 2026
 14:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918102052.1247819-1-sh_def@163.com> <20260918102052.1247819-3-sh_def@163.com>
In-Reply-To: <20260918102052.1247819-3-sh_def@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Sep 2026 14:59:41 -0700
X-Gm-Features: AcwNN1Vk_AiZZqIRosmo3DKcpKEGJc9ONZnAL9NkbbMjJk-8DXnpZgX_IG1otnc
Message-ID: <CAEf4BzaxH2geQUUOOGw8S0fhm3c9Z0H5r75QPo9_ziiqU6MF2g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpftool: Fix sparse CPU IDs in prog profile
To: Hui Su <sh_def@163.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:21=E2=80=AFAM Hui Su <sh_def@163.com> wrote:
>
> bpftool prog profile currently treats the number of possible CPUs as
> both the logical CPU ID range and the stride of the perf event array.
> That misses valid logical CPUs when the possible CPU mask is sparse, such
> as 0,2-3, and can use incorrect PERF_EVENT_ARRAY keys.
>
> Keep the compact possible CPU count for per-CPU result buffers, while
> using the actual logical CPU IDs for perf events and the maximum logical
> CPU ID plus one as the metric stride in the PERF_EVENT_ARRAY. Keep the
> userspace perf file descriptor index separate from the BPF map key. Do
> not advance profile_perf_event_cnt for CPUs that return ENODEV, since it
> tracks opened userspace perf file descriptors rather than event-array
> slots.
>
> Tested:
> - Built tools/bpf/bpftool successfully on the host.
> - Booted an arm64 QEMU guest with a patched virt device tree reporting
>   possible=3D0,2-3, present=3D0,2-3, and online=3D0,2-3.
> - Ran both pre-fix and fixed bpftool with cycles and instructions against
>   a BTF-enabled fentry target. The pre-fix binary faulted in
>   perf_event_alloc(), while the fixed binary reached perf-event setup and
>   reported failure to create the instructions event on CPU 0. QEMU did
>   not provide a usable hardware PMU runtime result, so no profile counts
>   are claimed.
>
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Link: https://lore.kernel.org/bpf/20260813160858.1042834-3-sh_def@163.com=
/
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  tools/bpf/bpftool/prog.c                  | 51 +++++++++++++++--------
>  tools/bpf/bpftool/skeleton/profiler.bpf.c |  8 ++--
>  2 files changed, 38 insertions(+), 21 deletions(-)
>

I don't think these fixes should go into bpf tree, please rebase them
onto bpf-next/master and resend. As is they don't apply cleanly.

pw-bot: cr


[...]
