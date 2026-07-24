Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D13749FA
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883244; cv=none; b=q7jdxaDAjlIgbH+XCk1blH7PIZl//beWibxGnMQj0NpQGnUjjg/wywpliq8NdvunZA8kGZ7CIqD3hthYGBia7/etsrQdy9HZAuTrultUYmk7gPq9MEZfw8O8rlVz0iF0ph8rTQA/x+kyQ1ccyp59c7OXS0amKKEZy+i09PDc9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883244; c=relaxed/simple;
	bh=klQCIolwI+k6JmIZSKwDbl1YcK5VyS99THqKtjqNyDI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvDFM1H1/ysZ3e+FyOI1yoKY1djVQkqbmolQtOt8uno2SRchWge2wbCuM1rnuEN/A5T1rn7NY26V3MISFyE/KE8sLP6WF7JyexnbgZmPxzN0EyjqTAWt242l/A021E2SYH6rZrZsO6Y0JWn608j3tYHVyZIwXzaAOsNYtaqbOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppE8JuNL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppE8JuNL"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso267618a12.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784883241; x=1785488041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcS03d1XBaJd8PfWBl+jgRK3Z0I7bTdQ96r2V4FxYF8=;
        b=ppE8JuNL6q4mZ7S9dITUL6Ove3HGNYvQKFIwphLl7O+Vpr8KiAFOBsvBk/LOYvygm6
         NiRG9rpsONmuHLXHSum+UNH5GNBkRjyUV52yypcOlw2ipSaM894epZCZ7Axb6JerhUh8
         85jP48HkZKJnva4v/EsWwpEEkm48BT/r5Mh8u1YU31BcR+7wAv1dxJa3HErMaorLIEZS
         i4CWdG2g6dbudGp9FORK4cHCOfcogrUPmdk/DfngjKVa2tjH31scm6pJemDMsCWADVvQ
         ajsxueoSsDxkKzGRrILw30BvtfyOAoZqKnsQw43VhCJKRCaKcwYj4+4+AImKLbjtETp8
         FjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883241; x=1785488041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BcS03d1XBaJd8PfWBl+jgRK3Z0I7bTdQ96r2V4FxYF8=;
        b=Vxcrz2Ysryk87akfezmWyMdK1thqVkhOLAPi0bJKJ/5MiliVtJwyezxh01QLanOUak
         Z/EzWD0z0C8goRv57+74dZf8d6SHiaAYH8Rp9yO989k8nXXRaTvAF1T6RrHrhde5jYo5
         nNBhqu0TtTXTrwC76tjPiHJxnlKA25ePTe627+asm8RKG2kOsEEKydzCjP+I4aDoAWwr
         6f9rh23T+s6xXMBL4GGbdRA6N071odyV3AHA9iHgqEJw1WvD6sqFD4Nwg+vwl94npJoR
         iA1yO0/pEXIjQrYhIu32eFzUNjKEekh2M5pcbSsdB5lnNC/IsLRyuvgXbfHryU7tX/Ot
         tiaw==
X-Forwarded-Encrypted: i=1; AHgh+RqJtWQYIdr/28TBTurv6oTxrLdI4bQA3Vu4ltZJSL+2E7ZTw0kUT6WSCR6bs1bF4soC68U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fMtsfLqSZ5nJ3K9JpcYcED2Vu/cchgi5IcbLIzp9/F0Rz2Et
	r3COJ5yz2/yYAVrnux897sruapBwEj/wm93jojFfoDZBlH9+z26UWn4d
X-Gm-Gg: AR+sD11BJRYIrk4booHIY7Q+wttNudGgJv/xvpLMenvJQBDryA/phjDL2Um4JHJY0lU
	Q8SNnrqAOy0EMUZMTTCSofSeTKC2feszSmESKmNmkwuFx69pEeGUTFHGRUwSiYdxYQNeiARMESO
	9uHxhcwUeCWcU7P8FQN09MUkrj1gqCW8i/dfyVdY0Ws0TAwJVp2Bcvz2OMlugM4GsR05oIvoSAW
	tIzK9Plfn4f9AlO2E1tY9PD8PF4rrKcxvvWoOITiLwB3JMIQr4muW9nU/OO1cxEpLGsrzxP4bUX
	BBUZaZtZyenmDbUBmdqiXZBTPIx0aBdTbGx7TTLJWindkluLaqBxSwFNTC15UgPJKJaLIAk3S2C
	iQE5EeUCcVYJ/8Fkg1+mLnp91C8YHrTaXv5EVFWEqL+UEjohO3VAoPHaiP9IAfHmMbc67pKDp5n
	0=
X-Received: by 2002:a17:907:7b97:b0:c12:34f0:f7b9 with SMTP id a640c23a62f3a-c1c509e5e46mr331280166b.56.1784883240706;
        Fri, 24 Jul 2026 01:54:00 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac8c4bsm333108366b.18.2026.07.24.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:54:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jul 2026 10:53:58 +0200
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
Message-ID: <amMoJnZUF5flJazb@krava>
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava>
 <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>

On Thu, Jul 23, 2026 at 02:58:45PM -0700, Song Liu wrote:
> On Thu, Jul 23, 2026 at 11:46 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> [...]
> > > +static void *producer(void *input)
> > > +{
> > > +     while (true) {
> > > +             void *addr;
> > > +
> > > +             addr = mmap(NULL, ctx.mmap_sz, PROT_READ | PROT_WRITE,
> > > +                         MAP_SHARED, ctx.map_fd, 0);
> > > +             if (addr == MAP_FAILED) {
> > > +                     fprintf(stderr, "mmap failed: %d\n", -errno);
> > > +                     exit(1);
> > > +             }
> >
> > hi,
> > so now pages are populated only when accessed, benchmark shows
> > this nicely:
> >
> > before:
> >                 nr_threads: 1, map_size: 1048576
> >         arraymap-mmap:       throughput: 0.006 ą 0.000 M ops/s, latency: 172703.437 ns/op
> >
> > after:
> >                 nr_threads: 1, map_size: 1048576
> >         arraymap-mmap:       throughput: 0.082 ą 0.002 M ops/s, latency: 12212.778 ns/op
> >
> >
> > would it make sense to add some map access in here (each page I guess)
> > enabled by new option and measure the impact for accessed map ?
> > I assume latency should be equal in such case.
> 
> If we add a read per page, which is the worst case:
> 
> before:
>         nr_threads: 1, map_size: 1048576
> arraymap-mmap:       throughput: 0.032 ± 0.000 M ops/s, latency: 31248.846 ns/op
> 
>         nr_threads: 1, map_size: 8388608
> arraymap-mmap:       throughput: 0.003 ± 0.000 M ops/s, latency:
> 372565.622 ns/op
> 
>         nr_threads: 1, map_size: 67108864
> arraymap-mmap:       throughput: 0.000 ± 0.000 M ops/s, latency:
> 2061083.005 ns/op
> 
> after:
>         nr_threads: 1, map_size: 1048576
> arraymap-mmap:       throughput: 0.006 ± 0.000 M ops/s, latency:
> 170794.193 ns/op
> 
>         nr_threads: 1, map_size: 8388608
> arraymap-mmap:       throughput: 0.001 ± 0.000 M ops/s, latency:
> 1346389.229 ns/op
> 
>         nr_threads: 1, map_size: 67108864
> arraymap-mmap:       throughput: 0.000 ± 0.000 M ops/s, latency:
> 10700389.105 ns/op
> 
> So filling all the pages in the mmap is faster than faulting one page at a time
> in many page faults. IOW, there is a performance regression in this case.

would it make sense to add new map flag for that?

jirka
