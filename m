Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1F32F74D
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570831; cv=pass; b=ucZCfBFXrSRN8MX37pRZbRFPK0K+0H724aaoxdK65e+Ypw+KPfgLSa17iuRQ5/IvfkxCZ2NdcBWHW9Xoth+Y/HT4Yva6hv+YvT0BJIvft5iJ8BldNOgCvy+wckQb89Ox4cPAUb5pAmo8+F1Y7dEIv3mXLMFIY0SEPuE5o6jaBN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570831; c=relaxed/simple;
	bh=iY4WVVleHb/lTmxL4fdlqNXFtv1CSDN+6DiT6m4Rq0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIZnyWGgSMX2gVIQmxGFiFvuzavYc7maLs93UvjRL3DEXqUSGqbyiMoaf8SHWzTdA/Ucm/4Ol50CnclE4e7YOCaxJBgQp8i13Ddhe/cYDwluHdo7kB4zbFQxbz4XKWI1SZjlTuV73D7yms9VLE4NBB1q+KOdm4YbsnuG6LM63Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2sVq/hj; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2sVq/hj"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014b5d8551so181811cf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769570829; cv=none;
        d=google.com; s=arc-20240605;
        b=QsORqsEfBTIs9qq3jjEt5zdgENhsa66c9jkfpE2CHrwnxL0iwCkLEt4a393yaovohO
         UscU8s/Zm2MdIa2vR2CeZY65I6cgxPlGB28QFX0I4te+9H0XESgzz3S3+fB8naFf+1Pc
         cPPvQEE5lqXr5Ds8Zy2fGKLMT+SUZyHV8FZGlWrcJ8ZL+0FqRNBSTvx9CnItHJE/7RJO
         I4gqFvhO/9IPvgmNhjP+n7Ux1r41aI8xG98uNAtFjjJkEshBNuWev+TpIzygSFB3UHMS
         9fjHs3e/mx2R2p4+oBBEBOzBkIOzP326b4ztLNwBwutKG/AzRWwL+JanYO5swS5MOpHE
         g78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zf7Tm2Jip/HxUQQ0xjmMGOCazGDoMelLUCNE/JwSuI4=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=I4poDBkIsEsYqL4UocLIxH87tVFvXbY0k2MdkWAV5z8lXmbYIHAzE6AwxfUjhrf04e
         YY5WnbH0DaBNwGJ9e91uU6jo1c+VzXoElSKuiAlLZtV1Dsxrs1Bs2ip8PvocGORPERzI
         Rdpf5weDc7C9mK//ygt07ES6nY0umYg3iCR0rZB2JaHH5xMZIm+4WdjhZFzeGx+yxRy3
         v3b5VOV3mpoCJZcDMewesGa+fzxfAW2r2lzpdfUbEQBaMV6Es3FGeChJ/U6BYULHiwjg
         0UROD45Vbzg4Yy28oZYwHyt5/CZpWJEqxwPZy4IVk3x3B1va8D2maEJ0cxl3+1Kt9DUK
         ZDow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769570829; x=1770175629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf7Tm2Jip/HxUQQ0xjmMGOCazGDoMelLUCNE/JwSuI4=;
        b=d2sVq/hjfE0dCrIhtGQ/go0+vfD8LowfLQFMpHXuT/ThTazfX+R17nowKwau0Xjn5p
         zzysbArw7x23lSG7Lyey84beGC172yY5g/3FvMEWXNVJLK4bnfGFMwBLkYv9V33m7wTR
         6NE9ijqP9mWRs/OLLLbNHFLrcrLuvnJPBg8ouqMydeLRIyMGMCm0wcT2/pBZbSaYQug8
         CGurlWUlYr14kv0WrwyNjBBbn3fn2ZMmqTo9kQ7dVmgMVnxLjMAFd9ouoRbJPcM1x6oR
         EiAZmdODLEgi7DVNW2G4tWgvkkEuoFnRpu/0GbAg68KEXW3M5M85nG1be13jaHWXRyqU
         WXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570829; x=1770175629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zf7Tm2Jip/HxUQQ0xjmMGOCazGDoMelLUCNE/JwSuI4=;
        b=IA0dSx0R6f18Dq4/5mTuIvcF2tkklTU9wGWx0N2yVFQ3S96wMB2OYOIhVB7sZ0o4YV
         UyOe8Mbb/U6pmTn4CD7j4CjyNkR0/5mpuWrYjnP6taO+QSMK9CiJZFGjf8YyoBEnzINb
         He2TTvRECamiEYf5vcmjmN3QqK9g56gFUcnDn4FD1YKdz086aCw41Ja3GQ6PDsFEJdRq
         6H83Pk3kdQ8P/g+2MzFmhVIuU524v2oWnB4FFP5ZvvmArm+8WzFW/Qqena88togrIahp
         iC6ponz5p9IbgCnO68ZVKoCQMdXSjB+KPN1KDYb9a9ySqtWC4l0KrV3xSc4V3BgFh91e
         SAsw==
X-Gm-Message-State: AOJu0YwWy5ivs+Tpv1ntkohiqOkJa1OsOcDfEVgoKi2F2EOcxnkwUUx+
	9zimthJxNhoFvOOEKvQNSZ/RmUcUBGfiKoZyAn7SNzUKyoxFZ828vNcEuei3Wu8sRuHiKo7aibN
	M+7zQVDk1yqwstjLpANwWenikV4tVg7MpmweZtR8G
X-Gm-Gg: AZuq6aI4+f4PiixHy3qxpPI7Ds+0n1doxTD3IPmrKGg/2SDjKp2kSfLJp0SQHQR8haZ
	hPWdvn+VGh6aPadGL9Mj2bj2HSHPPfU1wOZ2vTsVJH33T+b5513pgPGuwfEx6dTkC25J9DVnRs0
	BhQEl3Z+ovIc7jAjIaSMHgzGPpOsegldPhe0ykvW0rv27i2V0rcxxssU6q/hAd3UVjFBCBrLhkO
	CuO8eMKOJtFwIN6fFEwofIuYS597UNawtfUuAG95cFlKVEt1pbzVkWTpocAF5xZNLWPrPWP
X-Received: by 2002:a05:622a:1789:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5032f45f3bamr11080631cf.5.1769570828932; Tue, 27 Jan 2026
 19:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-8-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-8-roman.gushchin@linux.dev>
From: Josh Don <joshdon@google.com>
Date: Tue, 27 Jan 2026 19:26:57 -0800
X-Gm-Features: AZwV_QipzviwRyw_75oZ7mX7mlAb-G56PYUvE1_6oR5zZnsnwBraNgz192rZadI
Message-ID: <CABk29NvSku-zb5sodOYjWhW253EHGu52VNQ6+pQ8QuvEoVQYRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Roman!

On Mon, Jan 26, 2026 at 6:51=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce a bpf struct ops for implementing custom OOM handling
> policies.
>
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       struct bpf_struct_ops_link *st_link;
> +       struct bpf_oom_ops *bpf_oom_ops;
> +       struct mem_cgroup *memcg;
> +       struct bpf_map *map;
> +       int ret =3D 0;
> +
> +       /*
> +        * System-wide OOMs are handled by the struct ops attached
> +        * to the root memory cgroup
> +        */
> +       memcg =3D oc->memcg ? oc->memcg : root_mem_cgroup;
> +
> +       rcu_read_lock_trace();
> +
> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upward=
s */
> +       for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
> +               st_link =3D rcu_dereference_check(memcg->css.cgroup->bpf.=
bpf_oom_link,
> +                                               rcu_read_lock_trace_held(=
));
> +               if (!st_link)
> +                       continue;
> +
> +               map =3D rcu_dereference_check((st_link->map),
> +                                           rcu_read_lock_trace_held());
> +               if (!map)
> +                       continue;
> +
> +               /* Call BPF OOM handler */
> +               bpf_oom_ops =3D bpf_struct_ops_data(map);
> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, st_link, oc);
> +               if (ret && oc->bpf_memory_freed)
> +                       break;
> +               ret =3D 0;
> +       }
> +
> +       rcu_read_unlock_trace();
> +
> +       return ret && oc->bpf_memory_freed;

If bpf claims to have freed memory but didn't actually do so, that
seems like something potentially worth alerting to. Perhaps something
to add to the oom header output?
