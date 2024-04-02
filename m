Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935EA1400B
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022597; cv=none; b=UscJai6oFZWiwmN0oVuzLxjA8LNm1eb09ZzWuCTwPoFlsjJzjg397InYNZNSgoNa/hE724DnFA6u+p6tNGjwbmfTOzhkFF4M06Q4RAutNXyWoSKrfY01+iH7YwrNwpan4gWtoLo0fq28mCr+V5XdPPYHvBsFx/w19jpUZirBJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022597; c=relaxed/simple;
	bh=IvIaI6YcepRZkEIKLoMSBrhcnZQlydMnumKLgYMElE4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MhjS1W2t1FCyRPouDAAvywvHxyF0UUsTkHu6l8ISRpuYJZio4826mo+uiSfNb7mp6PPPS8J8akAxmakPlgoTOa+ko8iQh7cIy204rhWbtoaTo5Lsxy14wKs3uJS7f2zSrdiyrqzEsMq2wa7ct41ZFCK2OzLLCDhqEmdrgxrSXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqHRpgRY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqHRpgRY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0f2798cd8so37475525ad.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712022595; x=1712627395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTH7/CqajrUQhWs1w8gSzy4pd3zjnkuR2lf/Qk61RWg=;
        b=WqHRpgRY9b0MiLQSvrlV1rfKjHTx2Q0DWACbPBysxFW8F4ms99KW7ao0wfR4Qb4+TZ
         N5jlD0UrAL07b45Wq1xwRREvEyEOVix8K5RjeGtBAkBFpP+0jXk41P9mP3CiG+ei8Gl6
         V6rkYBputn2R8Lj8PeCTRT6cAFbGYznnb+yiwrRzW6dCzeaEXtn2RjEypLNGSK9/m7Yp
         3vUVB/FS3rQp1kjbHi4nI16xsO8HIvRlflXkAvkS2lEwzKN1/Om5BBTEo8s71ts0PgOe
         AUGziV+9xkhguIWlKZ3bGl2hXW/izYpEBIblDnAkXkTx06zxCZ3MSVizLuqQBvW8XctM
         137g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712022595; x=1712627395;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTH7/CqajrUQhWs1w8gSzy4pd3zjnkuR2lf/Qk61RWg=;
        b=OsHRxacV4PyMXXnQeYUiWMzHDBxoZgfIebm6qi3AS61A6NnWNovVQmoyqA//7Wbxms
         Wbx/Z5HrM5AP5i4oZP7rzjzUppb9udG3K9B1mlSaETqk0yzlF+fNHGwvxUegIJMBVHxR
         EjeiDwRu+7Vu0y0Z0AbWMBDoBYclkKxjMn0OG6lHYbbOjj9MTXaJHOyYFo5qyAHgpLxB
         8RGm86Bwih0rnL7WA7bC/VBLPgwF1lTPqfyr1gfPFbIGZWJwwZXRnJV03yQWqiqYydsj
         DtS9FZ2/KIl/2ZUA/rAqaAnEl+DWd9slIudvO6tdhg4WZ4Am2W4Fkje4LThBxS2+LrJ5
         roSg==
X-Forwarded-Encrypted: i=1; AJvYcCVVFZROs/32zMxpSQYFVOc3sKfEeXCaKsILOgAwRMcQ7VEcKy9m23n1v225kTJOvCa1FlfoZ9M6h4EGhsIx1dNo9gtj
X-Gm-Message-State: AOJu0YxJUQLgby+3U9nxmp1tPGVsqPSCiCOxDprnjH3p9cFtJKvxUceb
	9cJ7zJh2PWDDxb6RDbEc5l1wzh4ftDIo9XhhBJrKAJbdDZwzrIX/
X-Google-Smtp-Source: AGHT+IFfx/jnm09YcFbiUVJXt2uZWCjR+kwiA5yuSu92g9glssx72cRD27RypSu9orakBogCrxvRZA==
X-Received: by 2002:a17:903:32cb:b0:1dd:2eed:52a5 with SMTP id i11-20020a17090332cb00b001dd2eed52a5mr12192317plr.37.1712022594771;
        Mon, 01 Apr 2024 18:49:54 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170903434800b001e256cdaf5csm2799167plb.301.2024.04.01.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:49:54 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:49:53 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Stanislav Fomichev <sdf@google.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Message-ID: <660b6441860a3_801520892@john.notmuch>
In-Reply-To: <20240401100132.167226-1-aspsk@isovalent.com>
References: <20240401100132.167226-1-aspsk@isovalent.com>
Subject: RE: [PATCH v2 bpf-next] bpf: add a verbose message if map limit is
 reached
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anton Protopopov wrote:
> When more than 64 maps are used by a program and its subprograms the
> verifier returns -E2BIG. Add a verbose message which highlights the
> source of the error and also print the actual limit.
> 
> v1 -> v2:
>   * make the message more clear (Alexey)
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..559526191ae7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  			}
>  
>  			if (env->used_map_cnt >= MAX_USED_MAPS) {
> +				verbose(env, "The total number of maps per program is reached the limit of %u\n",
> +					MAX_USED_MAPS);
>  				fdput(f);
>  				return -E2BIG;
>  			}
> -- 
> 2.34.1
> 
> 

LGTM thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>
