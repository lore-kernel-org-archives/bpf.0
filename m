Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0F379EFE
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530006; cv=pass; b=F37ti6zlQRsvb/vbkTMbYl5i9pOEt+waz2InNSQBZ+nOzXtw0bQh9yYxdR2QkqGCy1DzQHMgnWDTCphcfSHTn/t5Q5hQGt9fLXVZXkeVt0MHreHU6RXLWIy4wlRAfqmXfNYu0S0q9gIx41sY2x/fT8A0EjV4cOcIqqrCylRlMGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530006; c=relaxed/simple;
	bh=yO/EmkVIHkBBMRUcngEKNItvEXSsSe+RskyQw5Jk4BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/7yIgPqOVyqnO0gOvbwsdygya7bsIVcA1b5+vq+XWBcX9pYktKKRyfOwzjT5Wyx0mo0dM58pZBRsRwHs3k5tmNV3U8R4tvG4kydYgzUYytL8W3T2MHJGtjhS6TFNOee8RrCGusvc4Wp0/e0sKotceetiCTlWEeRnYbY3/cf0VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Drx9z37t; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Drx9z37t"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so849970966b.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 13:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530003; cv=none;
        d=google.com; s=arc-20240605;
        b=ebMKoNqiEHBH6ip4xhHK7/u/4kgA2FNShwiWXgsoleDy2gbFzcNFG2DZTh1NM2mmaF
         ge2CyQeQzp7GuEaXE7B91SdbQiIY2mshZ731jEdMZ1drPdx2aWh3ku0VdimmKbZoa0zM
         xI+tLPmgnpGrUrS7Rgp8la675pUxacmahEeUSFlL68z67ZuOzUxTFoisFVdagpFHmRZk
         f2+ym+MtLeZT0Xa9W70/iekThf6cWSW7/HFJ+by4NV/qySzIjbYvCpXMd5OZqbzaH3a6
         /lMI+6mDE+4NEtNyddiosOFGxnqIC825QNEKVNIeglMRh+2V4CwC2ocJ3cGFbT2uzv30
         Q3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iaAiWK/jlnXrBb2kmro41iMZ5g6bVIAs0Q/KvlSqcaU=;
        fh=ab2t4L7a6mVzGwA69xWXBYH8TiCfATgkPJyeWVypoB0=;
        b=Ef1PHyur0fXFpf7cMATtXMSXTBJCYAxKjCQRrixPf7W2pcoa4nS/McfjL/VnOKItNx
         Xwht/siV7b2EVEqW8QmTd4imeOikxTqt1NnFP7Iew/LNzEZFWhm93SQ0W/xgByU7LIpC
         i86b1J3j5IjoMEemiqmkR/qW5v63nxTg5xw2787LxSsMzgYVQMOqD0WiKM9SJFXjbQ9i
         aXF05BVvW5RiP/lpl9i4DCzBTj9e5G+VOXpmev+Q2HlUg4DkYYWyYqT6xo5E1wRYTsZv
         4vPe1vpRXNgS7JBW2D42Zg+1lt63GTiFGISYSGhaZz7DCGKXiSvRxszYn/lhy4lsAOc5
         3efA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778530003; x=1779134803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaAiWK/jlnXrBb2kmro41iMZ5g6bVIAs0Q/KvlSqcaU=;
        b=Drx9z37tjgAgivR2RVKT/H9Sv7ixVQlN/KhAusGYtP8LlQtitsR0dawdRsNY+3HqVD
         kpnu/PXEvgimkVea2I0ypN5vq28TMWq+Mn/O6eoVfJ2kkQlY4gY6kBeu1V0j+sbfvFiR
         a7Aweo1x0EhgwSP0jaKts73VS59U4we+dp/vyDDzzmaJ1lo/AMHgQ1umHM3n2vkYyBV3
         XSaRbaLZ08UWe/JCkHK+r6FBHYEYMZrtYvf+vXXeUmyOLBVQinc/9HdfMxp4ZBjcMsZm
         R9HugjF0NI8YA9yVroNjNWgDUm0G8hV51svKgKEVNhMnz+r9v1xQTtoiIDyIRGd5ONCS
         Rqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530003; x=1779134803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaAiWK/jlnXrBb2kmro41iMZ5g6bVIAs0Q/KvlSqcaU=;
        b=m6rUNgCyyC/0xouGb+RQmTgyymmWk+SVeawQFpL4war/237vNng8cf2SLSqGcTpHxD
         FST5OccEuTgZBiBRT4j1m2nb/4a0iu3ivJR8gF5xEDMTW2DJ6nuGZ3Il3cw04X2CrmUj
         FGfLU1jFrcolI9/UcUN9BKDQ7Me4J1yWJMcfuS9SbVDbsG1LjF+snlI1Wk37LzRG8cLA
         4/aCbJie4+aBUJ9mDhA0KSE+d3m5tUFxDb4HXcE7V4Sp8m950pZg1/qzU3nPGhgXkK6v
         WXW7nVoThdd8deq8AtqZW+Il/UzABhklmz2RLyh5sevutDIZP5AUMtDfgxvslANWwY3m
         nY+g==
X-Forwarded-Encrypted: i=1; AFNElJ/6DjVr16IDd6sxgHfvaVWO+uy+kJIQKLwtTUrS1vAJr1ePJTUVtJD6xX6FkzbSu1386hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzNnpttj9+z7R/ZgFK9spuGQ16HBPm9Ge2m3alVksTuJqHAYG
	XpGIsscJL+aomvxHaCaYltX32BoVaFQFGmT74MvXAIzQCR323nrRk/qj8T30LBDVd/+dqK3Gwsf
	NZo8r/fJ/vsX4IWJftrmUinYoefDj1J6i+jU6Nze2
X-Gm-Gg: Acq92OF4Z4koMQXbYMKpKzt2EMM5/U/Mmguyo2LX1sw7Levch2XrBFkO0KAf5KjfkUy
	FbOwDkWzgriQnC7cBTGY2gfrAjIm5MdRNVKCtk1H7zrM+fEqmC9SoxSGkHOdqfnUwqdgCcOe9sz
	IOTfEJrkb2gapGBxvdxJi1SGtzD+Ph91ZkMoZQLjPKwzzYZ8kQrgH4TZl+ZQyAo1Qu6xEu457ef
	l/1w74cmEUCJW9IyzFENRmTFLwvaRBK7YAqim2okX+9ki1vKytQnAUJikWH6V4RD2KHrveKq3li
	NLKYdhMXEj6homHFYcP4jWRCVLPsny9CVQz/NJWOOn1u60uXnn/U
X-Received: by 2002:a17:906:7944:b0:bc4:c901:20fc with SMTP id
 a640c23a62f3a-bc56e5fea09mr1393779066b.30.1778530002409; Mon, 11 May 2026
 13:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-2-wusamuel@google.com> <8ca6f748be9913a2ced3e9f821153bfa914c206e089626e37e32d7d27c83be09@mail.kernel.org>
In-Reply-To: <8ca6f748be9913a2ced3e9f821153bfa914c206e089626e37e32d7d27c83be09@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 11 May 2026 13:06:30 -0700
X-Gm-Features: AVHnY4KeO5w6YEpmsSlgr9DnnAi-F6xgJF0AMvkGoo5f5Q_Eg8n5b2_v89jUAVM
Message-ID: <CAG2KctqDYmVORfikxr=NJbyMS-RVq_ZRhStJ00Y8vioXCSmUxw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
To: bot+bpf-ci@kernel.org
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:27=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:

 [ ... ]

> > +/**
> > + * bpf_wakeup_sources_get_head - Get the head of the wakeup sources li=
st
> > + *
> > + * Return: The head of the wakeup sources list.
> > + */
> > +__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
> > +{
> > +     return &wakeup_sources;
> > +}
>
> What stops a BPF program from using bpf_wakeup_sources_get_head() to get
> the wakeup_sources pointer and iterating this list without taking the SRC=
U
> lock?
>
> The current API design requires BPF programs to manually call the lock/un=
lock
> functions, but there's no enforcement that they must do so before accessi=
ng
> the list. A program could call bpf_wakeup_sources_get_head() and directly
> iterate the list without proper SRCU protection, which could lead to race
> conditions or crashes.
>
> An open-coded iterator would solve this by internalizing the lock:
>
>   Iterator new() acquires SRCU lock
>   Iterator next() returns next wakeup_source
>   Iterator destroy() releases SRCU lock
>
> This design pattern ensures that the list can never be traversed without
> proper locking. Puranjay Mohan raised this concern in v2, but it was not
> addressed in v3 or v4.
>
> Reference: https://lore.kernel.org/all/m2y0jeg5sg.fsf@kernel.org/

This was already discussed; the response is at [1] and the BPF
iterator attempt is at [2]. In short, BPF iterators and their
tradeoffs were explored, but the current form was chosen as the best
option.

[1]: https://lore.kernel.org/all/CAP01T74KNVT2SVRR+XPbFb1vy85W=3DJkp4_yD6xv=
TSg2avQo8AQ@mail.gmail.com/
[2]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.co=
m/

> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(wakeup_source_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
> > +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
>
> Should bpf_wakeup_sources_read_lock have the KF_RET_NULL flag?
>
> The function returns an SRCU index cast to a pointer (incremented by 1).
> If wakeup_sources_read_lock() were to fail, the result would need to be
> checked for null. Without KF_RET_NULL, the BPF verifier won't require
> null checks on the returned pointer.
>
> Looking at bpf_wakeup_sources_read_lock():
>
> __bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
> {
>     return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
> }
>
> If the underlying wakeup_sources_read_lock() could return a value that,
> when incremented, equals zero, or if there's any error path, BPF programs
> would need to check for NULL before using the lock pointer.
>
> Puranjay Mohan raised this in v2, but it was not addressed in v3 or v4.
>
> Reference: https://lore.kernel.org/all/m2y0jeg5sg.fsf@kernel.org/
>

This is fine, the underlying srcu index return value is guaranteed to
be non-negative, so the return value of bpf_wakeup_sources_read_lock()
will be positive and not need the NULL check.
