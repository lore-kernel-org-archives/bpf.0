Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528E3AE704
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787846; cv=pass; b=NiZsSM0Ri03xEAd72rDlgZv5hzkxbyFTH9gvwh5RCrW6gGw7cBykuQ/BYMqFDhB2P0qFuBxlVA6egF3tTdypYN0YW4e+zq9jDj/ISxJ8dwSXYSWkrcEGs2xGKOGRFwowRv7eNwNXyRAKunHM3Vb37YiQPxNB/si2QfnpsqeXakI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787846; c=relaxed/simple;
	bh=yE4EwCQrkXlFctZl89cEfORwn+um7MwgGT0lNHpkVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTPMqrOF437p+QLwnjTyCDQ+RUzLL29V1ndH2SbLfyW1iDUXOAHZyuwrdAzij/E9FUVGmoZHPJCDFrMcp0We3DvCZz0aiRH1wdOkUpm0ohSmHonBc1uaQe3D2GgTb1F46dzUdfd3kJlsq+kM1gQOuUpJB00/HUkttSuWY5x8jdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s16jQowG; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s16jQowG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848d21bbaffso4181112b3a.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 13:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785787844; cv=none;
        d=google.com; s=arc-20260327;
        b=Vl/GRKD7+IxuN1gsO9j1zZq8dnFYVttk2zXSXFxtTRshDCkHVT5pk5FeVrq+YODlD8
         uehDmJerKnzo1ow91MGYjGSErv2hmQcrq6RZtUeMCPlme11UfgrbAo13Y9pxu7KAkS43
         wA3MKMsQljIKlrBH9AMC2rkwd/uA75RY42lEfb2kkVj70vwQDFOJlYDJqPxatV7wpzvG
         aU59/6nU4RGuEjnPISZtWa2a2W/JkVayWAOexpR6KxJMdluElGjbqroH7aDMQbUATt/j
         z8YapQVA9tqCvk0oZdOdIxq72oDEvkhqGQAqlOJvFgiUIVHWufLOWotk2zVnIrN2g1uo
         tumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        fh=IArENeV6LAmgVSCXOQMGfClNBcfUeHrZN0s7PW8jkmA=;
        b=ei1ZvKlS3zE5GhJaM5uzEhjROzsxw6A+oUDwBAXY9qWddJ+WS1C3Mbx1+TiMhiGv9J
         obrNO4cTu7BGFqbCQyPdU/8ma/iNAk+QJ4fVp4+g4yGxv4t5/mhdk/MwPjZti1aUMqbc
         LIJ7a5Y2OtimokdOUH22tsqFEAuYwwBcTpn4n+gYM9PxV28v87C5D2w0+aLLLqgHkgY/
         w4AtVLvDyJBSSKqWk+NJBCBxoloKIzy216c/RNq2zGGLakfFq2J1dvEe9UudK3a54qKi
         jsPmXRJLafruvHA77wcBXNcRCcIJFPzyo2IHLoit6sMNOz++fDS8MW0wT2g3AOjgIWDt
         XjGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785787844; x=1786392644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        b=s16jQowG8x1icf+2NoA+4KEZhbF77g1wsebQNsHoVONq6MqqKxHQjPpaDoUqADn+Hg
         bmW6GwuMOKnT5YMgYrkzpYcUVZnt9F5h2WS/F+cXspwLQaYUtqnwe4wCuYLTUNxQcktN
         /6rfj4m8yG6dRn217Gyxk5YWU5J5X7wfKnorB1gJ+MNnkst12AyrIU1xUrHsF0rkEngA
         9a/1ttordOqqmicOEWQzRj31BmERbN6H+kcczZcv/k8qzmpeua+zASuz9QVBohED7rMj
         vy78101WwWSFPjxM2u6+0JinOh7FMEgk/lKIs3Zc8+FkpZM6vEXebOmRkzTJcMSg2CXU
         H/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787844; x=1786392644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        b=T+H5+Iux5mYgyLCINxCDrgYgmABZmfxQClvkG5NVbUdlO3uVU1nIYOuhV66vDTimOB
         KdUhryk6VsIBGvZB3dJQZxFfVEvnfQrPpE4gZnfdloJb6PfZaYnsQ4Zr500Kka3AY5cN
         DA1RV+bccY7f/c0jsCDUEXHoParv9I5omRIzStEsDMxeC+Pgw6oEtHC5/cDc49Y6WgpF
         qVWUHsatChwUE9gPXDi1pF+QNtZ+LZMPrjPrdDxhbvo6UVDgw7tur42pG017F1mCIvaS
         I92eXy9Ebhx9/p/e4RnKwou9MdVP0tBSsxqT623piAqZXug4VM1OZSVgex49lwSdXsgI
         PJAQ==
X-Gm-Message-State: AOJu0YyeBb4aB1O7vsILIftOjey6Y8zEZ5VmUkJRdT1yCvqSzwn+5zsw
	NlRl44XQCClP7lgyEg26qMKcgjBpPZfY6XshiDdGAJ7HHSHBL0ugK8rPhROvAl4j9JQiMPVxRAF
	hMnKXeY1HxczRjmc45QubyDpNpV1PTyU=
X-Gm-Gg: AR+sD13VTWg5LGFheHENAPJiJGwlB2AWoAF3v73RgnFQtSxbUR9+x6AQh9gyPKuWdjl
	6d5TYLH2/6sIwijq/L3Fc47eUx/ZytLrqSK1bZH2cDwTEbsNpBpMze7uK8fJZ5KtIqdXvaw98Zd
	3nbkK12s8bVLoGJpBSVyw38M+VZ0eywoV3+buDlWdQIt2v9PK8uF8qeLiYNFHNmzYcj6dddNP0s
	wCgQY1OGyduZh7YXqg9SVGxiB4AHcXa2mKojg3rLsLtFZvkzyw0bTYmsnScCfG+RQlOciT1SutU
	NEo0U4zXCz3pUx9hhtK28RZ5t91BCFhOSUq8uxsr6m0MruL8aKmANgiP7j9r+tYo81T2toXrsTX
	USO+2Rl92QLgIik2KKEPnB7HF+Xq3vbzIoE2lAPsaQA==
X-Received: by 2002:a05:6a00:410a:b0:848:2f84:739 with SMTP id
 d2e1a72fcca58-84ee4960de6mr10407856b3a.76.1785787843886; Mon, 03 Aug 2026
 13:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-b4-fix_btf_tracefs-v2-1-6b66da8dc103@meta.com>
In-Reply-To: <20260730-b4-fix_btf_tracefs-v2-1-6b66da8dc103@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Aug 2026 13:10:27 -0700
X-Gm-Features: AUfX_mza3LRmAzFtia5BzQBO5N5wE20rFpI8s-AgwGjpL9M0w6YZNe3TZXihsm4
Message-ID: <CAEf4BzasGK651xFBzSXgqzkiqrui-U0a+pGkO6E=Mim9zAyviA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Make per-template BTF id lists file-local
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, broonie@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:18=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
> BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
> The class name is not unique across the kernel, so the symbol
> multiply-defines whenever two translation units instantiate the same
> class.
>
> Switch to the file-local BTF_ID_LIST: the list is reached
> only through the event_class_<call>.btf_ids pointer, initialised in the
> same unit, so tracefs readers never reference the symbol by name and
> resolve_btfids still fills the now-local .BTF_ids entries.
>
> The handcrafted syscall classes are the one cross-unit consumer: give
> them their own local BTF_ID_LIST rather than importing the generated
> sys_{enter,exit} lists.
>
> Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@=
sirena.org.uk/
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v2:
> - Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
>   without BTF the ids are unresolved and BTF_ID_LIST falls back to a
>   128-entry (512-byte) per-class stub, adding hundreds of KB of BSS
>   across the ~1000 event classes (reported in review of v1).
> - Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5=
f10b728f51e@meta.com
> ---
> Changes in v2:
> - Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
> without BTF the ids are unresolved and BTF_ID_LIST falls back to a
> 128-entry stub.
> - Remove verbose comments (Andrii)
> - Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5=
f10b728f51e@meta.com
> ---
>  include/trace/trace_events.h  |  7 +++----
>  kernel/trace/trace_syscalls.c | 27 ++++++++++++++-------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]
