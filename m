Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5B5A4C6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217417; cv=none; b=CUttfGJuJCngcZTiby1sdZfvtXrFBufrdHa9jhhA0E4EEi5KIKsXP0gnZ7qjsQxuykjjM0TslvF4c5evGrTFcZ2ySd4D5zhX6y0ZrJO5CL+z2VJ6HfU31gUHy9ZRCLtmmn7eTBOKDkXlkdzTvg2yXH7OG7WKWXcEi2Kmij/suUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217417; c=relaxed/simple;
	bh=kCPj1hlakQrC4IhvUYKVi8F8QkQ0G8wnlSsDeL3+SD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEPOJSL1OtwonrDSO9HH4HZW0jf/RvVcL51ISo2EA1s1owgIOqUEJRGnipT7kZEuW/sU9yK3mTZgNssbQsMkY8B4iAV4eH6dnBF+sQvV/PdDI5Q4GpVOr6iQmDzdwMTR6K6gpfB5AQyENVIGoh5LofCKdY0fZyO41P2MQ+Mj89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UptaCsTb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UptaCsTb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e0c29ad5dso753485a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712217414; x=1712822214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y29/qpPxzAWfWFfMf8Pld4gRZ1KgdAFM+RCXGkMh2Hg=;
        b=UptaCsTbtJ2fW4NID7LubpWtmesO1jsU1gmQQ5b20rSrBg+UT9BP2320mkNIbkHp5T
         v0WbE5RVsTI8APAX54bzbGaFeiHld/fiDfAw9jNDgQgFpIoc36DM7Q8TjWrsOHdqRuOY
         I2A5vFNNrZbpGBK8HhKYKtOR910MF8DytBuL6m1cK9FlxmvqTTGCPs9LOXMcm0FkFXfk
         o9kEYrgpTY7s5f1z82c1yTzfiBQL+S6jT56r6QPq29mmR9XylWooMqosF0Li5uCtOPGV
         5t4w2FU12oYl2EeBFHUELIVvPKjr1AZ3RNhkQyNH2bhasCZmxYU6gAPEf0xyMHzGdacU
         811g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712217414; x=1712822214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y29/qpPxzAWfWFfMf8Pld4gRZ1KgdAFM+RCXGkMh2Hg=;
        b=pi6nA9WE+WzRjG/z5Od89GkaRYECE1dOCQZfsJ2lZ5M0y9SRSR1ggjUG9J3cwWTWE0
         6EQaWv5cSs/o4sTLxfMB8wAyMTImcOJ7lF034lVUb/Py3XEA2hiVPFcGw2LQyTFCACpZ
         iNBm1Y9l39m+LJyrWeFqMoN12eeqxBd78A25USS/PqXNw8tU3jXmqhI23w661gzW6767
         0bSDJCunEpxR84GAmh1qZMJTvYRh3v7ZCdTG+7X0WA5MewwxdHtJ0F7tARCYVBqR/NIs
         ZBoXtsFHWzVNF3p2uJACVMoNRs1ZskE2m9N5gjAT9bYn0zyvyYqP2nhp4VktENMhYim8
         yncQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQNd1CYVJSxjBaXkUai22Z7PeI7c0+YYwGoICgJ7U0rXdAUngIeEcZ0yaGG3JU6NwHh9MuRaQpRYa4WEKvsAAHyzjZ
X-Gm-Message-State: AOJu0YxFdxCzJ9lqwTTmYOhTlQnO5amg8SG5Uql1Wd/77BeHDMzMj2nn
	Eep9TvMGRrw9JIeV+7ri0STWdZ5Tk1i4pN1w5BuAGfKP8quvbIVF4woiUkLIqLE=
X-Google-Smtp-Source: AGHT+IEB5dhaVwaMiAP821W9FpbBoozf4DB9kuMwyIFYRH3vH7JPaAHPa+kR59g4hK9m6TS+l4mz4Q==
X-Received: by 2002:a50:c31a:0:b0:56c:2785:ca3c with SMTP id a26-20020a50c31a000000b0056c2785ca3cmr1182391edb.7.1712217413775;
        Thu, 04 Apr 2024 00:56:53 -0700 (PDT)
Received: from lavr ([2a02:168:f656:0:f319:c437:b8e1:ac7f])
        by smtp.gmail.com with ESMTPSA id l24-20020aa7cad8000000b00562d908daf4sm8959669edt.84.2024.04.04.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:56:53 -0700 (PDT)
Date: Thu, 4 Apr 2024 09:56:51 +0200
From: Anton Protopopov <aspsk@isovalent.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
Message-ID: <Zg5dQ6KYqVWA2Iia@lavr>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
 <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
 <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
 <1c3d3079-e1f7-4420-b542-c3c451038963@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3d3079-e1f7-4420-b542-c3c451038963@app.fastmail.com>

On 24/04/04 12:31, Arnd Bergmann wrote:
> On Wed, Apr 3, 2024, at 23:00, Daniel Borkmann wrote:
> > On 4/3/24 10:09 PM, Arnd Bergmann wrote:
> >> On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
> >>>
> >>> Declare this inner union as __attribute__((packed, aligned(2))) such
> >>> that it always is of size 2 and is aligned to 16 bits.
> >> 
> >> I think you probably want 32-bit alignment for the structure,
> >> to keep the ABI unchanged on all other architectures.
> >
> > Fwiw, on x86 nothing should change on this regard, see below pahole dump
> > before/after. I think similar might be true for other archs as otherwise
> > we should have seen a kbuild bot complaint on hitting the size assert.
> 
> It's not the structure layout that changes, just its alignment.
> Of course this is unlikely to cause actual bugs, but if there there
> is no real need to change it, I would leave the alignment the same
> as before.

I think the struct will now be automatically 4-byte aligned, as it
has the following layout:

    struct {
            u8 a;
            u8 b;
            u16 c;
            u16 d;
            union { u16 e; u16 f; } __aligned__(2);
            ...
    };

So if the union is 2-byte aligned, then the struct is automatically
4-byte aligned, because its address is 6 bytes less than the address
of the union. In fact, as Daniel posted above, pahole shows that the
struct actually has __aligned__(4) attribute in the patched version.
I can add explicit __aligned__(4) to make this clear.

>         Arnd
