Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C822083
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595692; cv=pass; b=qQ8OilIo2/ZoYmh2O000yxgVr4vKNPU+iCtFlgBFLKuiE+UVmiUy+rKhob3Wr0AL56gT6ZZjb/1ERTimesXFGNB/7zWlW8/C11eWQE+QwD2j3/ih4/2gfEPjzWMqL2NAGgco44ysQjO9XLI8UVlgmDynQtvwwAtnr/t1jg2oXLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595692; c=relaxed/simple;
	bh=bHXyF0m5CqYStThTVMjbMZ5K2JaUPW+GGYX7YaoVKUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K64YgAdogP7BdnFt6pjqIt+Ap9IeBERBDMe4uCM3Uu+3u9Rsak1jNpg1xSqkBnQK3VuErCwCEZD/dxNGksFZtHb8HThVuD2SjmyKisaImRfzwiri8rLl4nlg4+Hf2ue90z7yWwUqMJE9q+aUMP6OLFr6z6t8iHiUVaFlVfp8/xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyBvhQEn; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyBvhQEn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so15392895e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 14:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595690; cv=none;
        d=google.com; s=arc-20240605;
        b=kEsQmQkd+jhxkfVK4hzp9XCfzU93MKiBb3YpYamxdh3IPwNj2dx57+9qeXgUHwD2yJ
         WaBJkraLoKHq9J0IEdxbNpEtgd2JJIkkQfXi231bEfvfjXGiEKFWDuf0girpJ7eeBqVB
         5CS+wbENSKnxlhQ7TdY0MhBKwCzcxjJKJwvTeA3bnDCmYBkrfBasNto1cVlTvUBKwlWy
         2OgGRoCHcyelcgyxK/MIOtpi/uuZXqyKaxJLE+lNadeELIwPVHwl3iGSg/zTS06hPYdk
         wbBrcJaMbZ0OO2K74wO4VgQ2vAB8r3Q3xJKNkglgxBppjzVz5tc178Uj3+tOlRN2hwLG
         4/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bHXyF0m5CqYStThTVMjbMZ5K2JaUPW+GGYX7YaoVKUw=;
        fh=VNEPYi5u+PoSeDMqyPfs9sACVpTlNv7NtJzdGdFt4Og=;
        b=hsYyFdwtFsF0izhVvSMJP97Vyv+V/Yn5A5+Z8sKrKxG8eDO8QHaJmBs/A+u6JVp9CY
         KwR1KGnV+uoBwz5ssOuU2wsxLrjZA4m8/SPg0qnDtmcxKAZH4bb5elPBYiE1qwn5puwl
         DyIJOWX8M2LZ6RTuWX1MS4lqXvajsEW1NjAjWJGVniILQ4TXBHwLMbAlbzjoQcuI9IFj
         s/OZokVAzvWj+7ZXuJZ4vhax0V/GasDSfhVvabKAgiWNpLpY/abbngnxkGcjF2HgkfN7
         ooVT8NSvALhlXMkmaEh6QSCF9XZRry8NN5p/7O80BaV6RtofW+eBplXBHdzsbxGuT8gd
         NOOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775595690; x=1776200490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHXyF0m5CqYStThTVMjbMZ5K2JaUPW+GGYX7YaoVKUw=;
        b=SyBvhQEnLCokjRSuBDYtRy3AfBXUhWfmqoU+eozimQ5CwkGxIkkfWoUzdoqebYLvFl
         svdt2nlbXLodsGFyOMQ6H2602DoJoGOgkT2ygkUerIgr467PvJTCk+5n11E2nhOaf81p
         FVGVyiYwl/8mvice68syDsugsSNwslyiYGlY+r1BKGxtYxSHqyiiZfys/n6RC8TA82VL
         66PUyVjn5S7K0an6E1UdPjeYS/hSNwpOHDTj8LipMB1oFrFFTgn7oz2V0Z1Uy3jCxIHB
         Sd/m+wWTNcbhxVOCIGNxRjnNx3gV+kYrNjxVubW4xL6GAH2ENXS52AWXzUgOMmTFAUlA
         +Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595690; x=1776200490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHXyF0m5CqYStThTVMjbMZ5K2JaUPW+GGYX7YaoVKUw=;
        b=SqNnAJAf9Ac3/i9TqCLvCMd0piHS1Mzz2red8Qz+40jZNVWCsCZgaSrLWt/0EcL2R1
         FSUgc+MGRK1TwfDbJUOiqLJRmj4yAbvWUJBWPmKvqtFs62NSfST5wbyiZrQRt2wMeobp
         MM4ncY77+D93EKrJdtrZ9C6AzrcaC0qXHDBRDTraCE1XbPRNI+/esB7LQsBD2zctPARR
         be+EUCXgH/nDEy7kWY09bNUdkgG9uVIiDEsPMKAQ+Z11Es8kgO7IfOYjzn4n4EEyZh8k
         2L09OvXsogI3vUiL4OYq5yDYvREUjEQkCVAro/JUI1otRtchTRUFOOqHhaqbQPrbkBfR
         zmzQ==
X-Gm-Message-State: AOJu0YyuD+hqC/WSmPIHVASJ5ijeKUtcu/vfxSrQ1tdfMvQr7O7OGzv4
	Q2HZTLRumlu1sNhse+lJbngeh5fRprYGXc9R3PpNXyv7jGrLfxSaALTlk5X5zAOz4JSTg4LoBXk
	Bowx2svolrbKfFamJ4mrHqbMA5G5uS6o=
X-Gm-Gg: AeBDievRN/DNo9Q+4PGb3JxrE9yilVJFBleEyRttHlNpywSNh2XniX4f2U6FoJ7cM4L
	0QelZ6bbpljnQdtyeLhhPjoEjWs/Go4++Fgbr8+Z5psLXs0kg4oC4I0oHHe0b0dkUv5wz24/qR7
	3HuKUp1reJk3mc8DkIIcmbkOsG2CZW0sZgkIaJyTkRztMmlYjyBQ7jXCHebbWPma5IGgUcCH3qP
	Kri03SOFDxr3imMKb+C8Xgk2lZEJY3/26/MbQi6EIlusF/j0zvY1FrnzbmS4LoH/eOBC8B28aV6
	4Y/N7e3sSi9wltiZSdh3rOjM0U4uXcj3gVKL0ZaeZSsOIy2qDFpCQC/ocFWrUIFQrvCRVDDS9DE
	yQpV4uaLhXgKqVF0Hz7hU8OcZTw==
X-Received: by 2002:a05:600c:c083:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-488996a1d18mr187156835e9.5.1775595689612; Tue, 07 Apr 2026
 14:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407162234.785270-1-memxor@gmail.com>
In-Reply-To: <20260407162234.785270-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 14:01:18 -0700
X-Gm-Features: AQROBzCmoMGiFNst0ad0UGJfyUGslmV4zvk4qMgruFAjJj5jy8sIBii8K8Um1CY
Message-ID: <CAADnVQKeMYUcmdP4ha3zB9ENdmegnUWAs-zWL4r6D8+D2k=2Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Retire rcu_trace_implies_rcu_gp()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:22=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> RCU Tasks Trace grace period implies RCU grace period, and this
> guarantee is expected to remain in the future. Only BPF is the user of
> this predicate, hence retire the API and clean up all in-tree users.
>
> RCU Tasks Trace is now implemented on SRCU-fast and its grace period
> mechanism always has at least one call to synchronize_rcu() as it is
> required for SRCU-fast's correctness (it replaces the smp_mb() that
> SRCU-fast readers skip). So, RCU-tt GP will always imply RCU GP.
>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

It was applied. pw-bot is asleep.
