Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5D33B95C
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770491657; cv=pass; b=Oz7vAfzKNK1qBuga0xgRvLHUzMfdRtroE7/SPfJO/wfYum4T5t29pwj7JwpqhunBZhNyQkWiFLl2O3Pt1jRyiaUbiBQyzsoZNzfTs6jUxBoJRQGlh2ZTBKsKa6mkId7rOHKfqyNwelQtI04lT7hRgUnLoo96KyZ/aHelMq3zlwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770491657; c=relaxed/simple;
	bh=FjkaHPuElOBB44uTelMn0UPjI+jPasTY3KiBIXox284=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZU8l8rGNnPcerRTiYA744r1tQebkfF0ZB+ss3H9QKdzlIOw/Zofw34+0brkTKrTPTK/nD8Cv9MHJCYycz2jgCvG1IJIu+9xP99h6IsMEDtxJnRK2rrZuL74/wJnYutfH2phEmfbOrmQ2Gz5rMrUe5yvklOPGo2m+rabfy9vAM64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+3yZijf; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+3yZijf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso1228412f8f.2
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 11:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770491655; cv=none;
        d=google.com; s=arc-20240605;
        b=YNl3gw7RRMG1liIuymHykClIjTJRTVMlGCIq54ubnc/cZqI1TYBaM9mvC3vmNa8qiu
         Bz1xVhptKdCn3UwYH+KomH8SxYPBU5Qx+pEUJu8HDdhCkSNWOIcR4vffRDi+j2upwY3V
         ye3VLa7dp7dfO/PV99RUYexry+51fpgfn2Me6uu3vGDd001JazIGsglrlXXAD9BgDYce
         HOcV1mhqNopeReWwVS7drHFdXwE41/VAhf7NhqjZG/AwHHTD4f7H5u6dB0xHZc9HIgGY
         R2wkgSBpsk5pSQj0204Rs8Nack2B41d9GyBJ+s8DVnEMaEXM+b+MD/DGpbNmfp7dGUPD
         u1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jcrvr5wraqN/h8nskCTF/xn5cgM1Ku/oiwwkDvO3IVA=;
        fh=Z/Fl3zYaxAxSKlqkB4M9/PWWF8CMchl7hxkyvqSANMc=;
        b=igNG9ESFWzEw4PrDIGUUdS7ucXZc6y3facPjjD+irQj1bdcDUPUUbxr0gHEAIAcg6q
         nj8EFbH61fIQToiemSQ0iN5I04Z8SkorGZw+7RtUqRdqsM8u5Qf6yjFC7T/4qxYCkTyf
         G7KpLqnQpJTnBMwX2fqwuh7R0B4rZt145I8zogHvfvl1gT/I+HIe2IYKhTW1g7d2IjMV
         Hr8487NSHsOHdApnLRZ1FJWH2jxmc9Z8VAS/uuqUjJtnzJJr/Yy0OU+7y212OQvFACHZ
         1Wy3j8cku00yezGVB8BFfuaM+s8t12KQ6gh/zeUiy6ep+h4vpUHzEroRcFWpmJnqBoiT
         cU4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770491655; x=1771096455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcrvr5wraqN/h8nskCTF/xn5cgM1Ku/oiwwkDvO3IVA=;
        b=C+3yZijf+d7e+nnbxj9mqNryu/JORhUwFzohoBDqCgejluD6uGIrdDhd4C//I0PBrX
         BDG7ZFVIz31JBrsV3ziQJi6h96PMPIyAh4pMf7frufph8EuVX58oMPwS0yWocoiL+ulG
         ytbWKWxzlm49zKiYvSTE4OTjsHaZsv1jUmtUEsmtK50K2v65sZEzQHwLhHNjWbk1hHzJ
         3fN2uTxTBqRiIlMgFdYHwwlIbfbxVbjT4k6ZWNn7xnu2gxL7oD+jYWLaViRoCNnQ0rvM
         az7SLgeiAKE5vMmDZVUyc5reFNsIewEusL/LT1FjCZenbqR/xkDh/iD2AGrMt5dlvFG9
         6+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770491655; x=1771096455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcrvr5wraqN/h8nskCTF/xn5cgM1Ku/oiwwkDvO3IVA=;
        b=IqUDBV+vkPd3bZ6/FnFVeIf3dRhq9JHskO6WfitPlS7knfkFFrZkgR/+hJwIkdiGQS
         Tb7ayGo4rxRGLooNbdgG7aOv1MCn7xKytJn6WqI0zl4UOnTaI7IvCLGz9J1DP0MRvYfB
         q56teyuKCGHDo2xY8DRXtPBF1lSLf3zw1I/cxGeMXZ+Oh8qnS2wz0AEAybSZdbcWbJHI
         sClDS5ILFgRtDBoaHlQFYe/qo5efJoVH3369L5OiWPsJ6lSE4PW6vkMV/0AI81OYGV2O
         xobBBryfsAvfrTow5MYwzIj7O8aLEP2ke7v6TWSwRWtFPwJvXZFbgihX7K4Rsp/4cB6n
         Pq3w==
X-Gm-Message-State: AOJu0YzvrrTwQbCZe5WMC/X58BW2MkcqhfBWQz/WgDOdc5sv0o/ZwI1h
	qWf+ZFZyNqiR6LlJt2FPPRwO/aoz8hvyr3tC0GSNazxsgz6DvJkKdXkMHp98dE6Z/6vLo2JaYeX
	Nh3PUApEz1FA2R7+HMhq+D2z/cUimw0Y=
X-Gm-Gg: AZuq6aICSzY6gRYFMrNvu2KZ5E5OazYDeK280y0BaAbpXI35LYj1IU2EAvy2BjeVpqB
	7k2iL+95CdgEmO3J/SlPf+6T6g4KpcIwv72YLF48L/EeTOE4s9L5K1Qd0Zq4UKQTMc5uMb4dOi3
	jZVC5pHiEJXasqdW5zAE7J39WocJBlHH3avXZ14YDWBZrpokwJj+PODqU0w6iS5ly3KwooBCxi3
	UWl4G/TQqLFTBSnDU1lLC7DF1uzRYn90sirEDswCNQbjHBg6qpYBGF2bPfoKrqOsapjV/EggPu6
	56aTFjZyUFt7rTyLbDBml2+w5+eJ/VzD1oyvutxNNGRo4wOu98l4O8b4OJ2rbFKONUw/WMc5tBi
	QN1PmZD0CHfz5Vw==
X-Received: by 2002:a05:6000:2307:b0:435:a9c9:159 with SMTP id
 ffacd0b85a97d-436293411e4mr9811207f8f.18.1770491654853; Sat, 07 Feb 2026
 11:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com> <20260205-rhash-v1-4-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-4-30dd6d63c462@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 7 Feb 2026 11:14:03 -0800
X-Gm-Features: AZwV_QhYN286ERsE6R0aWw5-phKeXHHUh_r_9NcQSMJkARrxasB47xt-ztI5cSQ
Message-ID: <CAADnVQKvp2tnQSWW4Kh3ofGLvaEYJ47kyZeNUscAH_DShw8XHw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 04/12] bpf: Reject resizable hash map in
 tracing progs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:27=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Resizable hash map uses spin lock per bucket, which makes it not
> possible to use in NMI or IRQ contexts. Reject in verifier.

It uses irq protected bit lock.
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_RHASH) {
> +               if (is_tracing_prog_type(prog_type)) {
> +                       verbose(env, "tracing progs cannot use resizable =
hash maps yet\n");
> +                       return -EINVAL;
> +               }

This is too restrictive. lookup is lockless and
update/delete are using bitlock with irqsave,
so we can do if (irqs_disabled()) return -EBUSY in map_update/delete
helpers.

Also please add it to selftest/bpf/bench and compare it
to regular hashmap. It's likely slower, but how much?
