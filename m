Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D273F0767
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857831; cv=pass; b=c98vlAbD9cVhFNIWvbXXz3ejfs7t6OLgYAzNWE745Ccv3mV4Ady5a7o++EEIk/13CgTn8of7Ju9khiM1wYfEeqRQGFgbSUrS6fe5DyBxFh+D7W/fd0IvD6cwvy7o2oPENNaw61oNDJzZqiHXNt9jiNjmKt+4DBsmFV9DM4fFiyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857831; c=relaxed/simple;
	bh=1e6icdFjU8+9G13mCMkJbMOIoeURTDtn24Q/J9qsd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGN7B+45AXOnuPDb8juVdr2Tc1Dp7A3ZimswvObxbvFiJ/cVH5AdP3zzPPXFkXt7TCt7GPsrDmHqD1tm0cXdJ6e1SkSU1dAjoC1UXSEE9mSxqi4J1ay495G3HHnuso7V/wh8GsGWqYbJtDrEPQHcZ56TQB8kiMF+sD51QpZJgR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBl0jKAC; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBl0jKAC"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-675617e81f9so2455614d50.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 19:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791857829; cv=none;
        d=google.com; s=arc-20260327;
        b=RRv/yuoeiiAQle/aNoKQvvDbA8P6gqHASUFxDbNbekhZD2gnTvuOP5fy/rg0/Ya29Q
         JOiTxjZLkSfEnq8SWrmS5JEPqLySDQPv6nutqmr4cOIJ1Ng5mz/8ItFOPUGIHeVJiI8I
         f9ffw18BTO5Z5Ja4VPZ1fx7nvqG43YM/n+Y8zbzRwp2j5+0vAIueff97IKSuyN0q9zyD
         yQpaXE58E3o4YmQr18Qrx8b3Ujv9x4OAPnVit2P7om9MyLhw6c/jIBC8frNXx+zLDpRY
         6YYmZioL+hOlu6IxTgZZU3hc+FA/KrFgmNnmZ2o3huBcFai3fMEICY5F5zgKvmRY7x3R
         u6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yIn2x59SlJfeG2aH0jkfT5zU4fOVP6oTpHe5FuJew3U=;
        fh=IPL9OK3DjLRfWglgt04M/lB/bGJsmJ1HIiBVCqaVLeQ=;
        b=niZf6u9vRbNz/egvSiSGpoZBClpoKL+jLN2zxXlJ6t8HVkCV/iUL1pYzJglscTzhXb
         liq5qIWzfwzDLfAnxedXseBmyRnAb2rMTUOsae1imPLOk8sawKGVpXSdZB/Px8uZ90LK
         oVFmi1zV3T6alqOC7+gIhQmsdNcZk6Jzb/PvvjywrYRmXdiqEknt/QrSCKRWtJQfFQ+b
         Aa+KHH3VcuAwf6dKp/ncFgZH0uaaPDLuvX3u2xwbE3V14O6RqT6DcpwVZYFQifROhMTn
         U52uWvmQ47+E5YMlVXdXbeTlcI1vCbvqK6xgzW36RzLT0qwOjtcpBb6ZCAFARSTeMnlu
         5sDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791857829; x=1792462629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIn2x59SlJfeG2aH0jkfT5zU4fOVP6oTpHe5FuJew3U=;
        b=cBl0jKACTBpEhNhNf1f+qVqVSynQf2sZqtgWXf/qEjOzsMjBj512ETrV538exeXIBl
         qCm9/UpB9Stfx9Jvg37Cop4DDoi5zHoHhfECy1lsvQ2EThZ1H2/JtdI8gFpu57g1aKvB
         U9OS8ayivO+MKQuhfdTuXe9rdJ5F4o8P7PMhuVsO/Gq+KAWzaa1kiu4zlqPekPnn7ee0
         2K+EfHmXySJNZEz8OSDNSPvj8Xasm2kybS/Fnz0M50FWWrpSqwir37vlM//eB7vdn+lp
         mxD66mIjqkzq+YtNjhYF7t4N9fkfKWCFtUkgJYjJw/iv0dvxJ2sGrdBE1bwZlnadn8n9
         BCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791857829; x=1792462629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIn2x59SlJfeG2aH0jkfT5zU4fOVP6oTpHe5FuJew3U=;
        b=OVb/bytu1E7pK1kAHGRacpH1FdpzU+/i+E+K/RZoUDg5CpeP5186rmxroRTAXpY5OX
         QedWQsEaxhcUdztEwTBTOAh87vV02Bh6YCi6ooDgSI1RcQiOAZEVqJtg0kHeV4d1NIkL
         dJNIF1/KsipjxH959Xsj9+Kh5qcSun3jLCxIEOGxbm23dVyG+FZjSs7N0bZqp4atg0T6
         TspG8OoiKS3GhezptqrSpOuDkfVshYHEqX+KV4cpx72e3jvgPHRNzlsiYbvQPQjqc02/
         GzdHgrOM/O3wlJEibK61K3ytJ7fmUbC08VRqSMtbPWHhZXu30nDPuurF2j9U3JWonL0f
         xStg==
X-Forwarded-Encrypted: i=1; AKwUvByrzHgSsa4XN5pG9icg81D408NPZ2YvNS76LvNGkbhfbpGbzBSRJ/aS3XMRTvWNGbyhaSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4IQVMClEs9YUPjdlt+fUdLLgTh4cQL36nTNkZNd12mwSF6glV
	frar1cwTodvMHk95Qc9H7Rl7FfnKcXSPGuyks/GIBuLRnpGNEd7GEK5OTwsvWYeHaYgJ1n6WSHU
	Uzo6HKDoCGQxJJq+cX9XVzGk3m/l8zOg=
X-Gm-Gg: AYBFou3OS6EEJuHGBzDywqgE+br3YhIvd8v/zLakaRrzhfcKtMmk6DanKQH27yIFfbB
	rKMpmSw6/sew0CkxmNx46ZlvIAnsV/15MTRSdTbPuSHQvIwB8uBTT4pIrTAyoZZT+8h7kSUp/6R
	8FB2Q5YPNqynzRmdHdr9x13X9lBNSLiGcfBN4ywH0vNbPynO/WeTxZB1P8Kt2QVl02OYsbWE9is
	s3FVLWnFi4SUgthr4si7scqGKvWU+R7stjd+3Y4cAy+81faGu3VSmJ+sI8fg6Iw5P4GAmsUeAls
	v+AczRbOqhs9wJ1oZI8oIZxVGTemhMkO/oipRzefuPVG2cxb5v7UA+b7JmvwBaCD0yPmHzG0Fqc
	cEgM2UMHCuQ==
X-Received: by 2002:a05:690e:1383:b0:671:7e90:70f4 with SMTP id
 956f58d0204a3-6793678d44dmr3771206d50.10.1791857828879; Mon, 12 Oct 2026
 19:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <d9a3367a1852158f60cc2e89677fb12f@kernel.org>
In-Reply-To: <d9a3367a1852158f60cc2e89677fb12f@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Oct 2026 10:16:32 +0800
X-Gm-Features: AclHuK-uH2UB1rAnuK0zhwCfF8NmZTYihTg9_NG0CYh1qo0sK-2XTafwZpGcmUQ
Message-ID: <CALOAHbBE_1ssK_26c-UY7N6WxhkVNpB6v9WACVGaOiWZ5zchCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] BPF-based per-cgroup NUMA balancing mode selection
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:51=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Oct 12, 2026 at 08:04:35PM +0800, Yafang Shao wrote:
> > This series adds a bpf_numab_ops struct_ops which attaches to a
> > cgroup. The kernel consults the policies of the matching cgroup and of
> > every ancestor and combines what they return.
>
> The op doesn't compute anything. It returns a fixed mode per cgroup and
> that's all the series uses it for. BPF is unnecessary here. This is a
> prctl() feature, not a struct_ops one.

Part of the consults are keyed on struct folio rather than struct
task_struct: the folio surface answers from the folio's memcg, the
owner's request, not the touching task's. I don't see how to key
these callsites to a per-task setting.  Please correct me if I'm
wrong.

prctl() is also a stable uAPI rather than a kernel-internal
interface: a new option is frozen the day it merges, which is a
poor fit for a feature whose semantics are still moving.  The
struct_ops/kfunc surface is explicitly exempt from the uAPI
stability rules, which is what lets us experiment with the kernel
feature rapidly.

--=20
Regards
Yafang
