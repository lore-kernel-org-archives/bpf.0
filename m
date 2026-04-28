Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F341396593
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368653; cv=pass; b=VKdn3rpj/FQYrYZsYw1/T+a7tfDEvVVc3lsD8HGdnzSakA8ijfRr67Z1nPe2Wz4LX8ja/ePSosgpmsRmFY5hjS77EjwWZugDkaS35UBc29+4KtKDSJ0EPptjdtCX6OpS3XO2vhrm1N60aJgiylt2kRxAKF9zP1vDnoH8xvBo6HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368653; c=relaxed/simple;
	bh=hRPWI01LczqM4hpt5WQDV7pY2kzEn4X/KE1AsQfA4BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcbnUx9hPgYy3OWbbNyjoeqXOBWQwzyMsMcCakE9SgiWwNDtFS5MfO7cVH92FNQHRsyjSa/wmmF8rNT1q8QhuDSInP/R5mmZ529xuehCHkau/7D6rGDD+RzbQKxn2WIOcwJDlj9j2Bnp5sIu9/CLqcS9HF4xSgbpu8zlSKaTErc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV9d+CL7; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV9d+CL7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso14448262a12.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777368651; cv=none;
        d=google.com; s=arc-20240605;
        b=b9mHVCJnbOvbQ2kFgmDLqOBSnTO1pw0Zt/J7zZ9io+RIXG1PLtWZpaZafTtZewE3pX
         lutH+W14ciKZa1dIHq3w4ntDyt3LpfVpYGlxjbiy0M/HMJm1XPx+nH7/SfoNZCxZbyrz
         vMbI15v6CIGj3ZrSERy5jYyHNt4njVYxCC8dyn0lMyvJhbt4I8jlGxs4r7wpv5WSSsx0
         7Qo6XJIsDKBWbsjsow2zex0NVtNDZs4QUqYOJxv3zT/ebcLrp4WcVvZE1uU5vE0nyOY9
         StWqSHSoM6stUUsF+iQXMyWBO3MScDmrEstyCqt874KbGnZLCyq0LuyvZqYtw8usatZ3
         eRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QoxiNwVDl7IQJDnKzxsDGzAeRCuBbcVKoGRhpQQSSE=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=BfvnlZ9bNXxO2JX4juulIXLxdnFv+nn2EtvRacfubvIHNHedI0yUQD9CV7ngdXB7l9
         Dj9lBR1AccamxhsDZ1GxJWFFrX2hCiSf1M4hO2ZIOLowo/Zy5D48MaVuHOCT27xZj0nl
         UcubEUp5iSlE8rPAoI32uYCcbYvqX6KAqJwEmQws5OO+QuxrbJekYZGMMzXlHNlQoiJm
         6KX48G60484CDyqS1M4lwZWR3Cw0Ox2hGif3y97mJ0+H0OH42l6gC2BoyiwjGkRrGB1y
         r2zI4tM72hYpTT8T7TJKlg27PuvYfO9pUW7dzL0Hbss/2zwoJS7NSjKTnLhjy26sil8Z
         KNOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368651; x=1777973451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QoxiNwVDl7IQJDnKzxsDGzAeRCuBbcVKoGRhpQQSSE=;
        b=hV9d+CL7eamauCVp1RfGIwBQwNdgkOQbqytT5sFLFhFeLxnr3WKfF/TIyQqyR4bFzs
         7eqbS2tLbyUrn+SVjcF6th59kol9t1UwjVwBv8EnX4nBcjYlm389kC36o6g6GVPOk/Om
         C9rbKJBIK0cFSUozGEyC7rkfcRTs9qMsfAgph3ykf9ztUMeuMOhe/YBjt1V6dSd9fHxG
         w6Foc4H06iR6zaXKyMOos1VOHXzD7iUCO+wscf24G6t23Y+UnJuhM0N020Ndn4MPk88C
         4nCG1OahtjZmrZc8KYQuiIjgFWLnmEJsLVA5ZzOj+/35G7VPduZNhF7RK8Y+0V/2Uieb
         +VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368651; x=1777973451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QoxiNwVDl7IQJDnKzxsDGzAeRCuBbcVKoGRhpQQSSE=;
        b=LOr5K8VjnzilblP8qABfbFZpYxkjNvlk+I7/ilBHafNd+M6RYFbryaEsTOlkX49YtB
         9CU3F6Q1BwUUMRaySX8XO9PiP3zNstUJEoFr71gms+6JuTSn/aB9abkKpdpzNsghLpwE
         i0+kz0iY1hDnSyjCTOGxx9pGICah1tkgXPrOmHTch/Br5xfeSWfPfoFqMsrQbt8o3Zao
         x1itKUOxTeC2KbHkI2dB+0c6lzodpTLXPYKe6mxYFzpIP57KdT33ZJ7/a/Y7iSGFTOiE
         7hogF4thed5BONASaMiHoGad9Pa1ij1NlCpVLg2puqjLzMjsfVMlrkoBa86lsyGFXtWE
         dFTA==
X-Gm-Message-State: AOJu0YyIHRxnetrpj0guelO7nuv7QKTF1uyAnBL8qkv87NseqdKZh93L
	/ninlhtNJVYepgEWBSBWWTyuRhMZP+xLw7LKr77y3M2x60giZ1xC4ZxCYOErHlgwG9110nF4cYU
	TVr5dAzddv1agyTyjps9uoXUQVdKS7oa9GGWnQ1Q=
X-Gm-Gg: AeBDievnCQqIIIHOZ9UCgTb9wnpqJuPE1imFw6EZPvotnW+IHH4+m4sQTXj4DEBaO+n
	MgP2Y7exuqxFspD1Fz9zS0f7Z21McgeuzA036frnRGaEX8pR7/yLJ9ev/Ysi0wnUm0mAbh+bkLI
	U8UvKvKPdalXesbXNpU5COwj6YtsNL6ZxxzumH899XZlaJOo0M/RkhwIzBcPuvhBZX5wefjKTMG
	pk+TMpQHDVSneavAhPp6PA9gGwOchnaELZETyyDKH2uAJu5vmf0shs5FtkwnNJncRRhl7NlKB+M
	VucRU26EWEjqou+x
X-Received: by 2002:a05:6402:324e:b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-679bb09a4a0mr768704a12.19.1777368650261; Tue, 28 Apr 2026
 02:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-6-puranjay@kernel.org> <20260428010537.21D54C2BCB4@smtp.kernel.org>
In-Reply-To: <20260428010537.21D54C2BCB4@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Apr 2026 10:30:38 +0100
X-Gm-Features: AVHnY4KE5HUzAET2yt59SOTeeiiNhF7ATWdseO9Oh0RhsOO7380gLx6KyotcVcw
Message-ID: <CANk7y0gRdXnn55RHjLgsGiR8gMUoiHxH6czdVwj-VNfZo-LArQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add XDP load-balancer BPF program
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:05=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The `cold_lru` logic inside the benchmark loop's `reset` block=
 toggles the IP source address back and forth, breaking the benchmark's LRU=
 cache miss measurement.
> --
>
> commit 295ed705f4fdd57c01615b43803c47313840bbf1
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> selftests/bpf: Add XDP load-balancer BPF program
>
> Add the BPF datapath for the XDP load-balancer benchmark, a
> simplified L4 load-balancer inspired by katran.
>
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/t=
esting/selftests/bpf/progs/xdp_lb_bench.c
> > new file mode 100644
> > index 000000000000..b9fd848c035d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> [ ... ]
> > +SEC("xdp")
> > +int xdp_lb_bench(struct xdp_md *xdp)
> > +{
> [ ... ]
> > +     if (cold_lru) {
> > +             __u32 *saddr =3D data + saddr_off;
> > +
> > +             batch_gen++;
> > +             batch_hash =3D (batch_gen ^ bpf_get_smp_processor_id()) *=
 KNUTH_HASH_MULT;
> > +             if ((void *)(saddr + 1) <=3D data_end)
> > +                     *saddr ^=3D batch_hash;
> > +     }
> > +
> > +     return BENCH_BPF_LOOP(
> > +             process_packet(xdp),
> > +             ({
> > +                     if (__bench_result =3D=3D XDP_TX) {
> > +                             if (strip_encap(xdp, &saved_eth))
> > +                                     return XDP_DROP;
> > +                             if (rand_state)
> > +                                     randomize_src(xdp, saddr_off, &ra=
nd_state);
> > +                     }
> > +                     if (cold_lru) {
> > +                             void *d =3D (void *)(long)xdp->data;
> > +                             void *de =3D (void *)(long)xdp->data_end;
> > +                             __u32 *__sa =3D d + saddr_off;
> > +
> > +                             if ((void *)(__sa + 1) <=3D de)
> > +                                     *__sa ^=3D batch_hash;
>
> Does this code toggle the source IP back and forth on alternating iterati=
ons?
>
> Because batch_hash is computed outside the loop and remains constant, XOR=
ing
> the source IP on every reset block will cause it to alternate between two
> values.
>
> Won't this allow the LRU cache to easily cache both addresses, leading to=
 a
> near 100% cache hit rate and defeating the purpose of measuring cold_lru =
cache
> misses?

All cold_lru scenarios also have flow_mask set, which means
randomize_src() runs in the reset block on every iteration, producing
a different source IP each time via an xorshift PRNG. The cold_lru XOR
is an additional per-batch perturbation, not the sole source of flow
diversity. With flow_mask =3D 0xFFFFFF (16M flow space) and a 100K LRU,
most iterations genuinely miss.
