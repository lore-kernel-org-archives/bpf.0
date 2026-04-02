Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA42571D7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091380; cv=pass; b=JNIskfXu66z2nfy3CQeNJRoN/VAbK2dFrcI1bkCrkQzMstAe9r2slMj7VjM34t09R3Ns6WARR1I8Ddsx4lXprMvf4dM3LPA6M2dRbm/nM+EZLST/1ptJ4Bm9jtriwFn+obC6Mx+aUyWRN+1RKPpZqtgA5Owqesfm1GWA0H6CJ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091380; c=relaxed/simple;
	bh=nSW0pENPT1VOvv7pn4Z+NqKHMp6r0Gr5gVHgW8Hj4Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnWUTtltl1J07UixwdUwzWpx1oBu+bqkwbVV7GLUUMpZ0AGQ6pZ2Nhq8m3rIW59fL6LqwmNaVXPEG5vmRj8rvCUtuC8G7/cvkfuhi0s6ly7MNmFi2+DmWEu2ACJG8a7cAdIQcOSgyosFDFO+Q2Kd6o8oXa/vhqMTD0WlMNFzvyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETOe7s0m; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETOe7s0m"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a74765703so2624867b3.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 17:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775091378; cv=none;
        d=google.com; s=arc-20240605;
        b=EZFs++n5jBbCrJ5xGRGAh5NaxtiW6UwesCPMqIonhTHLRfR5IoyBMgUPMSEkBZjJkP
         Q7HAWyurg1N7xl5bV9J0Dm6CtZIM0Ug8HrLPu/lvzqbAQp4yZ/1m2kcUeAvbY5qVOz8e
         OeaUieU/klyMDdTIUwrZtlRwC7Fy6XC8KWMRqI71CTIdoBQunwgA8kfftNMwth4wSGz6
         lsm9sj5MmnIYzojhuaK90AySV94ef8c81BgwA4U57a+ILx9B9j97CZCiylcJiXIr/VgR
         vVJgJHUzbu1tzQfCun7xXhbC6wUnDf+5Yv+euQELJTHWfgxNGUbh11/fqnmUkhPPD58Y
         /lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o9elT+AFw/LdAc+ufjVDYxNJubwh8yJqZdh/dGlBGIA=;
        fh=v0/mufKAUFoWgQroqb0e/REd+X2hnX2W+mexrweD1KQ=;
        b=V7486FDIPrbHQzAPBXu30jDFXgmFECYRftdJgIdmfsbF9ZglsNLkx8MH0xk0hCTHEY
         8CZwT2hgdbBarwxQQgKLWAxqpm+UCpiWR6UhMcbH4EY/85XNPh3Lxd7npX5b222thISj
         Y1hkmiUygd0yw8NePwIUP1MevuytHEmeHggBQ6AwDkWNt2ehyg4j7FtmPQc56dwNSSkX
         5frwBuivo/9YD7+x64HHEbtzNwTpxNr9M0hgO9BJnbE0pkf7VyKx6UH7n21E47wAM4+2
         bmiytk9EmirjVK+uDHTgQTCUZzqiN0k4APiCXMcsQkADE/rJoLWUmeP4ZThIG72oDu/K
         fdfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775091378; x=1775696178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9elT+AFw/LdAc+ufjVDYxNJubwh8yJqZdh/dGlBGIA=;
        b=ETOe7s0mlDof7bh0gR79GyEdn49dYazb0qFxPGmHiZ328nsOnGvjkmgoKtQ/seTTD/
         0qdPB9TH3wGzpl8rvkgXHyzN93HTTt1CZ4b08AsO/ci9uA2u3RK5kRdDq6GqAUs2Du/B
         y8F2wTCEMFw515QVf7G/qKIrPlNJOyDiWTuCnD45+hKbfcN4/e0tDy6i4WBbAkD4K7St
         KLneSfTCYanSo8o79HS3Eg8+t2HWSkB9pKfFWCrLogjTLrDe8ERVC8f15KsByFLFWfNg
         /ntQlMLCEjdAkdQcMeIXKuMheQ3ELg99ifZXilEdPZcRDZ/8niPki7h4Ha3hfYvH76tr
         QQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775091378; x=1775696178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9elT+AFw/LdAc+ufjVDYxNJubwh8yJqZdh/dGlBGIA=;
        b=dxpdiZDtRyhbhYqX/JYb4qJjIrn6wm3l5b8IIiilulP0loMBEgWzml/daYvFajuM2O
         RIocqIrLEw9OzAxFxSRhUTxHCm2X3+u7cAbKMa6x4gPmicUEYlVza2VyIVZ2oQqX8peZ
         qCegzuPTk5stjH7KCDIP0ABErk5moYjsxEhAiovLJeCWjkRnK4hAJX4AuBg9DM6Y/fOJ
         0xNn5BmrBkFlacrqifKDQjp6GB6L0x3EwE+CVYvjQduPCrURBazv6u1L7jElwa/y6EOg
         p1lm9ECNvp0TzhH5wDg701gWhNz8KmKXJX2H6/ZwptjQBiEZJ9C1R+DT28nmSSJT3SiU
         gLDg==
X-Forwarded-Encrypted: i=1; AJvYcCXLjAaJWjy9hyKyjhFlxKo0KTNnpWmZ1kw8NWHAJKKD4hFlE6eanqSWSfWVv0Dy0ABSN3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QZX7YfjNRq/JCSf6iLCYH8wbjuVbcKSzLNSwO73GzRYQAZbp
	A34tlIbfn2qDoVF9eUmYhyI2dskYwsB/FF33O0mcUIMk5SV9CPNyoDe0bs0d2cofdX4zAP625Cz
	WqhueFcD5OxEeYCXtqmAwiHwF41o6iig=
X-Gm-Gg: ATEYQzyv8l+wq3WI0lXbrvmFN3YI88naHo1seWKitIaMQ/ygc86nXisYymw4aZZYF73
	90Ch1pSEXuf8tKEzr55e+vSvdc/WhFFZEpeH4EAj9VBzDZcYbT5iKUl1ATvZ93nMy4VfwELGssS
	9LTixilrgo120As5Ay24BAXGsymx+OdpMp9REr6/x2hMHP1u7h+w4/qHl0G1ewWVdfoKVvxR+Qg
	p65nPuAlr2he/NR4xIkJfZVqAtFzpQYx7Z+2JAYgcpfLFAce4o2/azqi1sppFaXXPCvoENIc3MW
	jKdfmRMUjMtiub/krufST/k25vIKfjm8AOiQQVOR2hJIwA49/Ww=
X-Received: by 2002:a05:690c:6889:b0:7a2:3d38:3391 with SMTP id
 00721157ae682-7a23d3837b9mr57744517b3.34.1775091377855; Wed, 01 Apr 2026
 17:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401192615.3548627-2-bestswngs@gmail.com>
In-Reply-To: <20260401192615.3548627-2-bestswngs@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 08:56:06 +0800
X-Gm-Features: AQROBzDfy6sAxRALQZ74uN3RO872yt2rDNVPnBo_8Q2-QXTjVvJZJfQ0Z_-IL_4
Message-ID: <CABFUUZH2COQ297MoyL5A8=Fo6eqbr7wdp=euqxFt4mY1xoMawA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix end-of-list detection in cgroup_storage_get_next_key()
To: Weiming Shi <bestswngs@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 3:31=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> wr=
ote:
>
> list_next_entry() never returns NULL -- when the current element is the
> last entry it wraps to the list head via container_of(). The subsequent
> NULL check is therefore dead code and get_next_key() never returns
> -ENOENT for the last element, instead reading storage->key from a bogus
> pointer that aliases internal map fields and copying the result to
> userspace.
>
> Replace it with list_entry_is_head() so the function correctly returns
> -ENOENT when there are no more entries.
>
> Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/bpf/local_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 8fca0c64f7b1..23267213a17f 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -270,7 +270,7 @@ static int cgroup_storage_get_next_key(struct bpf_map=
 *_map, void *key,
>                         goto enoent;
>
>                 storage =3D list_next_entry(storage, list_map);
> -               if (!storage)
> +               if (list_entry_is_head(storage, &map->list, list_map))
>                         goto enoent;
>         } else {
>                 storage =3D list_first_entry(&map->list,
> --
> 2.43.0
>
>
Looks correct to me. It might also be worth adding a selftest for this
cornet case.

Reviewed by Sun Jian <sun.jian.kdev@gmail.com>
