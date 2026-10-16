Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBD4CF476
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178386; cv=none; b=tL8W9SeeaZBdZ9JfLkZ0ee+imZbGAFGDnvGESSkTyQiPAXOsRQj5rkuGMTqW/mzdQn4/dMqUR33IsYI/GF4HnkdNcKTBUH60cGOmbm67pd8u/sHhINdwkW0jOUXG5lRnymOfC5uB2z6CjIvan/M0SBoPL+QyzECHE+3w18zUfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178386; c=relaxed/simple;
	bh=JB5wm0nwOiFQqduTpLKkrLDQYyG74lSZhVzOqVoZMXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j3hJYj7j/63wMDXlypxf7KkUY9p0UqGk2CqdtQAytNuKosNFiT0T7hxFHInlV4lYB+dZs4uaoC6BgpIKHlo2M5n/6zajjQ8VQEjxVandmUKSWCzl+o9hXW1kBVFbh56hDodGpDDC0cUhpDDaVmdZKMVeNzHUDFPyhT9xnKyPfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Kp8w7mJ4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Kp8w7mJ4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd3310348d2so728330a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792178384; x=1792783184; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wk3QGo2Xm63rFj/G+OW3dy0tNhbTuuvWGwhG2nAQauc=;
        b=Kp8w7mJ4RHSQxgbHK4CAPiR+J5iGUKYBF7rYg25KZTneFCBv510IyfDoos9vBwK8gf
         LxO2YWJ+7BHIe+xlfJ/h8OwSwDAa473iayMKYde3+W53c4AjY8y9M1RxIuXhOf5L1v2T
         f/M9YPOXuBw2rRLzfmMEJFzzoGhEhVRxpDgGOVR6BBG4S9hQ9b8rYf2kk2Lc/OVqeyiq
         8POgDzldHwYpX1cEnFtHEQLmcuIzxKpGzW7Mzf8NsfXqtZMjPKtzEThk7P1i4GBVzxca
         QeydiG709UcP+VNgNvFNEnINeXYlxJFzzB+Vc77KciOALfvMa+VLN8ws7ebA85TnHPr3
         xyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178384; x=1792783184;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wk3QGo2Xm63rFj/G+OW3dy0tNhbTuuvWGwhG2nAQauc=;
        b=tgBK6k2kPI8WxNOWUVJ6x4P5q91ZzgXILTXdkeJzrCErwyIgCxt02zowbffxwya7eV
         EuzvxwY+/GGMVdT4LG4XJNPRaLj2TGSn7dpnPzscA5RrlxTKy7lRMora74Fxb3O88+qh
         MKjCseYkmZ+al/l8mDYlSmoIjC+/25qn/v4l/paUHLqyvbZGad+EM89Cy8tt5NHH50vp
         h/b0MsrfsJbgmf6LtCK3eXR4wVa+vytJimIrNfkOEb7R4Y6MRLE9bOVJW1VWdn0u7Cd/
         dYdFvlM6DMn/5J8AMhbzAInrjTJpwdJwDoNOaN5gcRH2ElpvFzSV+QnMjkKS0th7EYYE
         SWxg==
X-Forwarded-Encrypted: i=1; AKwUvBxtgoy4zPeMqb+RTmqjIHx3QnxwQsQoodQy75WJbVREM+YFMj6/T5L+zU8m5bVSa/vEJSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHtUOHiuA8nOcxnHQ3htDyMdbDHzyvVOufN74+lGTEhuTIGQxH
	XV+Cp5XAMH23SyGI/SpYT3nkAIUC+NffSeKc79yc5OYY+D3V6LWJUmvfoi1vIgkMdDk=
X-Gm-Gg: AYBFou3Ng5SSU5U+F7Zv73hr20dcpiIlmObwiVhh6BEdayAmidRsxOhRYsC4JVfaAYM
	9KL6gUjcMQkx4KvNTieN/TGfYzgdfxILoqasJGvWFQXX9tlWX+avY/ktIqx2z1F1KBDKUX+JzRI
	ChpITIihfefHBZA7DK1cz0XyjgmT5mVdLIIzxxa+VyeYgFwnEw9gkkCFx2m2Nt0+leozbNzn03H
	YEYFBjS2b/8sMsVijFnxMSS8oDRNTq5y/tfXhxHsyms6WDyEJ/DdmJDds5coMN2IC4pUktj7u36
	yILHlWawkTTy8T5IsS/RZ7OKW4cI4Jf+IasaS+anVSl5/sMixs5rCe9Ukh5ivqxrkgNZ6oovax4
	+NCcn0+8M5OcBpFlzSOuCx7sxF1cfTrhD/kBt3ZnTHzlum4J2ueu81FCMDWL01y15wX2jPl3OLo
	ddemqRwztYwdoWzS1OFq0R3LlKwgi2fk+L9zmq/IFQOqIM8awiGd9qs4FL3+2FkiNNu0ezYBIBo
	U91KT9pSzSvt0aNqKT7GhDYGhkD26+9ybwiew==
X-Received: by 2002:a17:90b:1f8f:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3acef29d02bmr408364a91.25.1792178384468;
        Fri, 16 Oct 2026 12:19:44 -0700 (PDT)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ebe40sm5341663a91.6.2026.10.16.12.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 12:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:19:42 +0000
Message-Id: <DM6I7R3QQ1QO.269JGZBC9VTPW@etsalapatis.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v4 6/8] bpf: Fix arena race between page free
 and alloc leading to incoherency
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-7-emil@etsalapatis.com>
 <DM5W5UNBV54W.LJ1K9VUN2S3S@gmail.com>
In-Reply-To: <DM5W5UNBV54W.LJ1K9VUN2S3S@gmail.com>

On Fri Oct 16, 2026 at 2:02 AM UTC, Alexei Starovoitov wrote:
> On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> @@ -1063,23 +1147,51 @@ static void arena_free_worker(struct work_struct=
 *work)
> [...]
>> +		unavail_node =3D range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
>> +		if (!IS_ERR(unavail_node)) {
>> +			s->flags |=3D ARENA_FREE_SPAN_RESERVED;
>> +			goto clear_ptes;
>> +		}
>> +
>> +		ret =3D PTR_ERR(unavail_node);
>> +		/* Retry without starting teardown. */
>> +		if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOMEM)
>> +			continue;
>
> v3 dropped the span here. v4 puts it back into free_spans and
> the worker does schedule_work() on itself until kmalloc_nolock()
> succeeds. It's __GFP_ACCOUNT and it cannot reclaim.
> At memory.max the arena cannot free its pages, because it cannot
> allocate a range node, and those pages are charged to the same memcg.
> The kworker burns cpu in the meantime.
> In arena_free_pages() -ENOMEM goes to defer: where kmalloc_nolock()
> of the span fails for the same reason and the pages stay mapped until
> map free. Same as v3.
> The free path shouldn't allocate before the ptes are cleared.

The next version drops the unavailable state, so the free no longer
allocates a range node before it clears the ptes. range_tree_clear()
only allocates when the whole range is free, and then there is nothing
to free, so the free is done. The worker no longer requeues itself
either. It waits for arena->lock and for a contended mmap_lock instead.

The one allocation left before clearing is the span for a deferred
free, when a sleepable free fails to trylock arena->lock or one of the
mmap locks (see my reply to patch 7 for the mmap locks). It uses
GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL, so it can reclaim. If it
still fails, the free has not touched anything yet. The pages stay
mapped for both BPF and user space and are freed with the map, as when
kmalloc_nolock() fails in the non-sleepable path today. Allocating
after clearing would be worse. The pages could not be freed then,
because user ptes may still map them and the page table walk in
arena_map_free() no longer finds them.
