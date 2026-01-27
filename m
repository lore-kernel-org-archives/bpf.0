Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3843EBF3A
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493070; cv=pass; b=RVU9rhsgX0yGcUC+pwfYFDMVO0p1vDIg5m4NQf7JRH8iRxdCBPvPjqrKkQN3w3Jgam6n6ZGrdzzhyG5fpl6bmAGar/SC8WS6Nj7pM2d8j/d3oDW/KO2M9MIFq0U6J8cRxaWx9Ceux7KlELN1f37EVWAM8G0J8oyyHlSd3qC+9zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493070; c=relaxed/simple;
	bh=w/wM6wDIGeziOkyzEu6ilh30xwonS3F9zPHMvi9vw4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVchMfKmNDKvKwFJ0/8kd0J+CB7TCOlpnKL2MUiOOIxQ8fJrOjnaHkxa1JSPZEqv/9AFFfFfzZAvumna0o6SN2j0nzYbJU5mL6SGqkUtM0n7KQqrdPq24MyPALyD+kKnOwJxFJKgtSXxfgNGVlIvtMJLRo4tbOjzxtw/zbQhMQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdqjVSQs; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdqjVSQs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7942fca0da6so36291617b3.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 21:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769493068; cv=none;
        d=google.com; s=arc-20240605;
        b=X4ZczKWtnrY4+RIbDj+nCh4x4PTW78d9a1ENvIF1rOtJBkEEXe3jv2EJ9QMPdBMB/I
         +S9ftP+ZxeMm5eXYBuokgM1K03y/gZ08bp5CqN+duilpHWfu3fSSDEoiZh/R1SF91v4v
         RjHWVyJrnUNi1Hj5exHmzm9YJ0nVzHfhSd8lWMgFF7m5qG5uZeWXEEYXPSMxKSoX1eSn
         q6a5zrnqaRedCcMjk5WgbO92C6UXecWB8wVN6bSzmA1y7h3sOmrJC6zKp6wzoUZ7ztOR
         NJB4xBeSlvuxOEmsxm08hAc9T0UdkGaGqYNkmHQQsfQQc1zKPF3jcZs6OX/idCqN6L3d
         o+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=An7SHoxFNQVMVrQg+cVoi49+jQE1PDn2o0N/47lH2vw=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=dJtZULyEBjURKgFV3YQI/O6f8A3dwcZ2QO7toynPOwt/qoNCzzQ9a/wWKKbvWiUesT
         WN988EwGvEqNSSITQRyMuc37nk8ZkoiUWmjbD+bm2JHhSpyzStolqgqpQOIKb324Q0Zg
         2BiNpXJUn3xRHnqNcka6mLZCWabl0XG1GTgQu1lsYXBDpHHiQJNDL310vKJxhPfruBbW
         GIWbBjYk3PsJvU6YBsu1ldoUOOXb3FWPjDpY6mcM50D0U6YuSzVh/tkP2+oYQptARK2Z
         Qr+thE5Xe4RnfdPtsfMMW8/2zIqd/bPDI1K600Rqzitxc5acInS1o/larbInPIgBOE9F
         umlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769493068; x=1770097868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An7SHoxFNQVMVrQg+cVoi49+jQE1PDn2o0N/47lH2vw=;
        b=WdqjVSQsjinjo2vGfMwggTl5K5wHtlCJMBlL2gUX4rhwHNOOMcCvIzm73VEpukvtRV
         AHGwZDKi+KP4VCdqwTOrfAlsW1iJMbMCOqDslWeiyAuxUj61oSPKzHIFMPhjV8XnpiQl
         SgA4/lg/z19uo4fVNO+QbtsKOqwtUQdUa+94nu6ihyFc4imOnXpK5kbA+y1moooHsvRV
         s9XVUcNnz6o6kJ3m01+0RbmkMM9FWC1BvPzw7PGkeBy3FLGLgZc4fKCel9DXAm9PmeBf
         7fOU0hhotE/cN8K7QWmlEBIkGr2xknDTPTsZAAsjb54Bpk0XRmSwuS3MUAcGPMjRqckU
         zrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769493068; x=1770097868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=An7SHoxFNQVMVrQg+cVoi49+jQE1PDn2o0N/47lH2vw=;
        b=wMKecK8tNmhbGjkos+Zh5NnlbZwEU8D2gVALcI1ca1TMSaSd0DkbcP38c9uN/i/d7y
         x+r8oZFsfq9QHxdmfp3LqFXmoAcyhAL6/Sa9D8iadDqcxpy30xMkxiN+fbjO0KIUn7Ad
         4+bMzMwPQP+7TR+uUJL5D1q5KhQKaav3w2NkB/B1Jdu/oxVxbLqgIUwji+2EbAlze8Ob
         6LqhWMnj3v7/l63I2RTy1INlW2ghWseqB6kiu96XiqeKqZ+XsgJ56fSeB9SEhb2z7Vkm
         KukEWU6UL+ue3Wu0f4IIAg+5onC8RWkbGoOLWBH2AFZvoMbqzQZW55zeDHRGyxRqt1xW
         UcUQ==
X-Gm-Message-State: AOJu0YwSRIZYoRpOcSJvGkhCtgUTyYos7h4IA3oKZbURqFDr3sgYOHid
	KJy1rdTnVFj2WeAwtukBDIWAcH4S5XAX/FGVzIJGLlE0Li24xsd/ZQ4nsoIbSF3/sTTAqiGaMb3
	uNcYyd4B3WjVrENP0FvoTOoIyhHLxdVU=
X-Gm-Gg: AZuq6aILuwOwl6TB6/hbKsOHq0QdLnbh8CizNzR1GjHufNqzhzBtg8y1DWqpfPSptn+
	/KlnAVt3/I9lu45Zkhb6WPPGmqUrEaByqfyy/0m8Pu7SX9G9oTaXYl3ahx/D9F2GHXr6o4UVysH
	DnsPRhYsi1IYUPJhksXllmooJ5KQ/9W/8OhMurqLAMVlYuJm9+KYZDbvefpGnmjPYVJWo/mAaVl
	inYAoP7f5Fe3w0qgKU7CO1uUEKpIeyBbw/17uKuKyC20REt8U9EQ6fipfuaGy2oICZqSBvZ
X-Received: by 2002:a05:690c:6287:b0:78c:3320:9c5d with SMTP id
 00721157ae682-7947abfcb88mr3717107b3.42.1769493068454; Mon, 26 Jan 2026
 21:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-2-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-2-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Jan 2026 13:50:31 +0800
X-Gm-Features: AZwV_QjGmr9RumY3gWub6eVfLg0tOiVjCPC6kXyGcnKB2ouGmo-C9UpBzlDTXJU
Message-ID: <CALOAHbBt8Gf0ObNiBRcC2_7rx=Lo2ZytLmqk-J0=9bg1hsOskA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/17] bpf: move bpf_struct_ops_link into bpf.h
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:46=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Move struct bpf_struct_ops_link's definition into bpf.h,
> where other custom bpf links definitions are.
>
> It's necessary to access its members from outside of generic
> bpf_struct_ops implementation, which will be done by following
> patches in the series.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Feel free to add:

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/linux/bpf.h         | 6 ++++++
>  kernel/bpf/bpf_struct_ops.c | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4427c6e98331..899dd911dc82 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1891,6 +1891,12 @@ struct bpf_raw_tp_link {
>         u64 cookie;
>  };
>
> +struct bpf_struct_ops_link {
> +       struct bpf_link link;
> +       struct bpf_map __rcu *map;
> +       wait_queue_head_t wait_hup;
> +};
> +
>  struct bpf_link_primer {
>         struct bpf_link *link;
>         struct file *file;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c43346cb3d76..de01cf3025b3 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -55,12 +55,6 @@ struct bpf_struct_ops_map {
>         struct bpf_struct_ops_value kvalue;
>  };
>
> -struct bpf_struct_ops_link {
> -       struct bpf_link link;
> -       struct bpf_map __rcu *map;
> -       wait_queue_head_t wait_hup;
> -};
> -
>  static DEFINE_MUTEX(update_mutex);
>
>  #define VALUE_PREFIX "bpf_struct_ops_"
> --
> 2.52.0
>
>


--=20
Regards
Yafang
