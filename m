Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0E3AC0E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946296; cv=none; b=g7LsSHi5SD8V5mRqxnhxtgaY9VF3/dbS+fA9/0BNyiQ8qXE5sgiZpH0ox9Jcm0KoOykL1En3evX45KBiTXhdWZ9o91CWYgDhYFGUN8H5bgtaoqMDHGkkKgRVrQSgRv45cr0cpYJTCIGfgq/58lVU3F7+V6noJArMpTnTRtzOBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946296; c=relaxed/simple;
	bh=dlrMDGUUKVjIlrc75iL3K3nboZCut5mLe/czW3En8vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRKN0qH63byKYfGul85zLHVe+3RF7/1LnL3ykmB0SzZIwvHoMueVseuLBirdHjMrFw6x3iWfztYkPrPLc79HT0ZsBSy6ja1FbtIuv9QpRWt38u54l7CNuRaWb3LEKDDSr0oRFOm3XP/cXEsmeKxo0ovLRepIZe8KDwqm1iLTszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGkA7a+A; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGkA7a+A"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847a52edeb2so797593b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946290; x=1783551090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aY4Pfbw0n6kkU2Fr9UteNsfwm7gENlQGES9cY9LSJlg=;
        b=lGkA7a+AQ+7XLSz5guDBYkWqg8tz2lB/mlXXivKVEwTG9sFgmA9P7MmFV18q94Z3yl
         XmyT79jtty5LmU6ZE1lQq4SMYqUvukH7QPpAuNdZzP3dkck7stllpRv+dEDkyr21fZcW
         x5HHIW49f9vG6DgRWqpudMmW0M7zmFz/TU1Ewj9OdCnYlSfNSEuHPhA7S4mJIr3/WVZg
         nfVyLkQMNkYsyjG45m2AuAvUjrJKl6Z08kioLQR6UGSDNL0cU9xRSqfSYzBvKYjiekLe
         rfMf89xxyruoHPSjugDaIzUVXLNcAXtywzGtTUjnsTI7Qli4kfHPivhM47qEFYxsCKUg
         fYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946290; x=1783551090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY4Pfbw0n6kkU2Fr9UteNsfwm7gENlQGES9cY9LSJlg=;
        b=qkyrDHQStSP0zr7dMqv64KWA+dlJL+ELqidQKF3gULIW+/3pNKR6A6nN9iBDGtUlxq
         Q/DtMxIHD4dBBQTxL/6CtL00WmEvxLSY89JdAX6A5gG+jmF9YHCk0bwUyEGuR3G9VM0F
         FExwaxyYmilyUgsUm/go70uIGaup3GQ83t2rCzw8vAoKeSszb1YDY2wmnFpcahhDIO66
         RvCtKi/wo0CJmf8zZqmCe4f86NDo66+fMVUtTBiHbKZILSNZuzBcotvgkYEO2D+DdM2g
         AO6qD+VA4ynAcze/xdGFV0ESmkOQAcqIByMY8BRlZ7pr+V5mmjY+huZJFnceTIPe1SUs
         TWiw==
X-Gm-Message-State: AOJu0Yz1jCPvdP/IDhwaVnbcO3Kuu/eTPwY0alSPqdWiANlUzRtnlkS5
	qnTOLM41MTREsN0cncc6dlQuZpymCrl2Zz8BR4W1uprJjtBd1po16jvxbxtj/Q==
X-Gm-Gg: AfdE7cmV10h5YDBji/SvUpLXkNT4OhxAIMQgFLWLVzbeoZ/KRT0vny6SJo01FAIrFCI
	svMlx45MWlaqHxNZY5yuz2vS+rR5xiQlvTFSbBcnBarzSGSluUbcjL6uQx/g2pi9oAgLAF9Gx/w
	xZKo+W0eZQ8BQ64H6migIz1gpKEH6tcKJFrmQhLAcirXYyPSPygnG7SVsIRXGUWho51Y35ubaSr
	0s6Q2YW93d9HOPhR8oemR9IcBt0XpDf/XuyycFY/zogJS25nJohH9VoxfZsH9K0x3Oro41VZd0Z
	rZvG01D6P2m2WnKNKkixtG02bzXdEx5SBLKv2X1TpEwCQNYiNbT93J2N0Q7R2hdYrqS8Io6JimJ
	asnNYQGfqFe+jjNGIcdFhiT/q2rX8FLmHRdRcJ2zSZS8bVA9qMF6GZTz1GVECDY7O4eMAg/ZIE3
	TRZc/wrawsow==
X-Received: by 2002:a05:6a20:c891:b0:3bf:a412:ca11 with SMTP id adf61e73a8af0-3bfed4de4b0mr3908111637.48.1782946289873;
        Wed, 01 Jul 2026 15:51:29 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b07646sm374444a12.16.2026.07.01.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:51:29 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:51:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 1/2] libbpf: add
 bpf_map__reuse_fd_from_loader_ctx() to allow shared maps
Message-ID: <akWY-viOzKeoMeAr@john-p8>
References: <20260626215113.52273-1-john.fastabend@gmail.com>
 <CAEf4BzazLB50iNEX9vzEzXyO8LfJh7ErxuvZmw_wG+dPrvbCDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzazLB50iNEX9vzEzXyO8LfJh7ErxuvZmw_wG+dPrvbCDQ@mail.gmail.com>

On Wed, Jul 01, 2026 at 11:39:37AM -0700, Andrii Nakryiko wrote:
>On Fri, Jun 26, 2026 at 2:51 PM John Fastabend <john.fastabend@gmail.com> wrote:
>>
>> This lets the gen_loader use a map that may already be loaded/pinned on
>> the target system. When we are loading many signed programs on the target
>> we often need them to share maps to communicate/pass data between the
>> programs.
>>
>> Note it is slightly complicated by needing to ensure on error/close that
>> we only emit_sys_close_blob() for map ids that are not these shared
>> type otherwise we could close a shared map unintentionally. To track this
>> we added a borrowed_fd_array.
>>
>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>> ---
>>  tools/lib/bpf/bpf_gen_internal.h |  2 ++
>>  tools/lib/bpf/gen_loader.c       | 50 ++++++++++++++++++++++++++++++--
>>  tools/lib/bpf/libbpf.c           | 11 +++++++
>>  tools/lib/bpf/libbpf.h           |  1 +
>>  tools/lib/bpf/libbpf.map         |  1 +
>>  5 files changed, 63 insertions(+), 2 deletions(-)
>>
>
>[...]
>
>>
>> +void bpf_gen__map_reuse_fd(struct bpf_gen *gen, int map_idx)
>> +{
>> +       int idx;
>> +
>> +       if (map_idx != gen->nr_maps) {
>> +               gen->error = -EDOM;
>> +               return;
>> +       }
>> +
>> +       idx = add_map_fd(gen);
>> +       if (gen->error)
>> +               return;
>> +
>> +       set_blob_borrowed_fd_array_off(gen, idx);
>> +       move_ctx2blob(gen, blob_fd_array_off(gen, idx), 4,
>> +                     sizeof(struct bpf_loader_ctx) +
>> +                     sizeof(struct bpf_map_desc) * map_idx +
>> +                     offsetof(struct bpf_map_desc, map_fd),
>> +                     false);
>> +       pr_debug("gen: map_reuse_fd idx %d\n", map_idx);
>> +}
>> +
>>  static void emit_signature_match(struct bpf_gen *gen)
>>  {
>>         __s64 off;
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 7162146280a8..af1553e9d4df 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -5085,6 +5085,15 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>>         return libbpf_err(err);
>>  }
>>
>> +int bpf_map__reuse_fd_from_loader_ctx(struct bpf_map *map)
>> +{
>> +       if (map_is_created(map))
>> +               return libbpf_err(-EBUSY);
>> +
>> +       map->reused = true;
>> +       return 0;
>> +}
>> +
>
>Can you please give a small example on how this is going to be used?
>E.g., who calls this API and at which point?

This is our package builder creating signed package for loading on
remote systems. Here different packages want to share an arena.
I'll create a more complete example.

>
>Generally speaking, I'm not a fan of such specific narrow-purpose
>APIs. Why can't we just teach bpf_map__reuse_fd() to do this if
>gen_loader is set for the object?.. Sure, fd would be ignored and/or
>can be -1 or something, but that's a gen_loader situation, that's
>fine, right?

If -1 is good that will work then we have bpf_map__reuse_fd(map, -1);
We can just define REUSE_FD_SHARED_MAP -1.

I'll send a v2 using bpf_map__reuse_fd(map, REUSE_FD_SHARED_MAP) 
semantic.

Thanks.
