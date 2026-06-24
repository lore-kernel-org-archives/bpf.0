Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAD3E5595
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335236; cv=pass; b=OsSmDkFCVZ9AeOLDbGItCGDa4bcif5WAgpgVvU8Wdxe4BlrpRYRHKBIV1uWgx3DnhmNvY2vafYLm2bd2+bbFCWBM1dnjdTQ/8ek8eadPzOeaPUVc1dNDuGjW7wTkSRY5VyVK+y/EZXkh/zQ0pGRUsgYtrUShxMkTyKLpA2LJZ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335236; c=relaxed/simple;
	bh=41gHxPt7HUxFBkNkDE3LM0TVD4IOiCpFU2mOz/M/aAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee7vO9mNR2prkD87egeQTNrnghDiVLQ/DMrq+qkqS8UDXKhObrC1HcGSDPLzrCrjqEMmLfZDaWKl3vCv0794dl/dVhW2XR1XD7VZksnNfeW9+4oE+chfRRwBDuIG6/k3QPvlm8X+MN/FP7ahmMAdquzPPqnBVFpKKnSS6wSWmrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9HZZ5Ym; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9HZZ5Ym"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e1916922b9so20645797b3.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782335234; cv=none;
        d=google.com; s=arc-20240605;
        b=gd7XsDT3To3O42/V4B03b96XJ7ExRqHBUbfh/STpM+ZZpFQOgGukbBMRa0Ky+YemsO
         Yxm/WVjIwWiTMa8wzz0co8z871+WB3jAL37/trJxBuDBf81tG5x3iI4PHIEXNf+CTe/v
         9HemIcmpPVdFvgsPZJhSrrUpNYsxRtjBmGnZKzJTym/FlGuwlm7J0OEoZkDoQr3py9ol
         Uuh8BwOHsGEFgGvQB76UfS+2RNGVCFPI3oZTdLmLF7sp/nwOjb7IAx0HoBI/NYv7HRIO
         o+B9Nl0XmC5uzL6+PQYhrfTFlL2UvkPEAB0GxczOsx9dLCIL5EpHqJO2lsExJ12ZyQXe
         JPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41gHxPt7HUxFBkNkDE3LM0TVD4IOiCpFU2mOz/M/aAM=;
        fh=AERbmmtxEMERBwt7nbL/4bLHOsye09k8YqdNOw/FY04=;
        b=TqucFEFJ+wq++LEjIVzobYp0Zw1pxRjPNfOHHHLLA+x81+A2QNfjaM2uFNc/pJPDmu
         bZLSrsr2NGRETlEbgGPzIKvrI9aWzP80EVOrlZQC8IVvorkkgjaLgowpoMW3HKYSXVwb
         iO7ZyX8Bq2zQlnE6qalcNsqrQWdd4n5+v7lkLRHsK8AKN5G/JNmkBa/82e8Qvlz1Q4h/
         van6VADpuSWly4cT1DNayqNGrdOUUk0fbCKScpYgehI/v0L1SftPUSq8lIcJttVF5u7D
         qmG7VKG9MqwKW9732TJUrVdmzibxp9muB+R6jl2hOAtqs+jWywilwtBhMsMbH+pxTB3y
         rI5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782335234; x=1782940034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41gHxPt7HUxFBkNkDE3LM0TVD4IOiCpFU2mOz/M/aAM=;
        b=T9HZZ5YmOOOZgwyzkdu5Dtbhv05J5avNeVJfym5W6tEmiuBDqUX3/RHonzKsmEOGSF
         2WpylLzEHNs/9+zkIohmRSiHtfN2YGqs6R+NIzwKsDpNfds70g++/b1veqA6K1D2mIkz
         OGzxTquXH1fBDSq+gAD0rOQQ8vrPOSXSyPWxlKu3qQHZ59hPlu87BIMCtfPfSgxqsnqv
         M3bglf9IUyn4t/CLDaEzneA/GTcQoLU89rBowBbLUpfXIBCEV+zFpDzC9qPNRFFAvBky
         9H6HxJBZzu6KNjjgaJfV6K8LfyrWc/SGyiSkjkHYzsbHoRHOz1z1XC1JwcebZOM2zIgB
         t9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335234; x=1782940034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41gHxPt7HUxFBkNkDE3LM0TVD4IOiCpFU2mOz/M/aAM=;
        b=RLE+T8hsY78NPJFUGZMmBLw3hRVA6ZoQGxME1ychbS/ApktDc2t2aLghm3WgEbzDnc
         4bjT48XZXpwUjFuEwngBaOJjfJJlmibJD1+wvnPeecrSn5HF0nXjkjhbNfOApnv+3Nul
         hQxIeRuipuiOnmClDJYcu+VR5BoQ1EQCzIv/AP6b4ePNYGJUgpTecutMMNaVERZeQo4p
         egvPOM58S0V1tqltOwTSFha3f9vUxi/8irk8vOpF+jYgrCZcBExhYVM8XMmGGzPUFqpp
         Lhbj7IA7Iv08EAub1PGUvaZBQWEK3DktlQc9X0nuA7jSohVZsIFlxDMTvPIVQH9+QPfi
         GzrA==
X-Forwarded-Encrypted: i=1; AHgh+RpIkHtvcw3hviRIIuxrK5SyK28ihvM32CTINsh6V0C8e0TDZJYj5PKYjcLaBF+HIlvSw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE11ZyR4uKITC77DZAuWiGlilMk5s3UsufaSxJq9lwNMD4iIU
	dBWmKGwOr0L/MT1PP8eIrmnzNMmSNi2qkbp8k6Kh78P+6MsxHHHAez8ZWi1JW08hmo/TP+DVDxI
	YEksiD4fpZdjA2+ztDs1sQpgLmQ34lgU5cg==
X-Gm-Gg: AfdE7cnqDojGtYitvD6AGz6JqENMBy/yHbi0qb8kYo7eth6geTE5MGWR5f8dvULsnaY
	2Yo3oKm3w8FfRWSc5yP9dC0Vhmf3qk3+HiDSJuCDk/EQI0Ig000dEHVrHhngyFD+RN/BsizzV6a
	hhAVY+HRTysWdJP4gr9w63AfFK4LpA9PVyGab4gZ4Et+v4y50eJHF1hS1dKdPBXNxfekX0Fm2x9
	7OWq+vQKGo3jJu9wo2LsEATe/vo9312YZKOC6Vx+MgvKTHQ4wxn3ABX2TQa9ODZ46uQP/4asaYV
	x6leTav0hCoLOET3xzSepNkGKKH8bXhxfOa4MsOVUtL2CbPvbmYShRro9HU=
X-Received: by 2002:a05:690c:e3eb:b0:7b2:bf20:cdc3 with SMTP id
 00721157ae682-807eeb6f49dmr52477487b3.0.1782335233754; Wed, 24 Jun 2026
 14:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
 <20260624193149.3EE921F000E9@smtp.kernel.org> <ajxEE59cuz9XUWMV@pve.cherr>
In-Reply-To: <ajxEE59cuz9XUWMV@pve.cherr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jun 2026 14:07:00 -0700
X-Gm-Features: AVVi8CdU58htoB5Js73L8sSmYdKMl6WQEpVsEYhmQ9JMyh58gXCYVNgBn07RzCk
Message-ID: <CAADnVQJeMsZWpJavHz-X0h3VKEMRN-xhHy-wpOOqFB3dA=pfDA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix use-after-free in htab elem with bpf_task_work
To: Shengzhuo Wei <me@cherr.cc>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 1:55=E2=80=AFPM Shengzhuo Wei <me@cherr.cc> wrote:
>
> On 2026-06-24 19:31, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 5 potential is=
sue(s) to consider:
> >
> > New issues:
> > - [Critical] Unconditional call to `check_and_init_map_value` on inline=
 element memory causes out-of-bounds writes for per-CPU maps.
> > - [High] Dynamic memory allocation (`kmalloc(GFP_ATOMIC)`) in the eleme=
nt free path breaks NMI safety and causes memory exhaustion.
> > - [High] Permanent bricking of `BPF_TASK_WORK` fields during in-place m=
ap updates.
> >
> Will try to fix in v2

Do not. There is nothing to fix in the first place.

pw-bot: cr
