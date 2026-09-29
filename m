Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE379519E0C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683708; cv=none; b=EfZ9f4yLwGcbTM+oceV3IpxOU/qUggpzIdGdYohFYPj5klkAav5KA3M8FCCHk2VXxnyaHtqIbmbjR7q2J7BbvjA+IKjlLzOwoFhRkmc3gHs0KtTiqyvh6rADDfKzln83kGbp7fmcn9/URknHtJfk0+T42IGEVuXDBTHkxoOH5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683708; c=relaxed/simple;
	bh=QUUrAmQgZ0jIM3+2g14XGoQu1q/tC6nhLzshruGZqyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3UMTiqMluK0OguW42rrGr7Echbzg1P25Oxz3SRZDYqS1V4gMWb6bY9NNSW1J2Le34AnPOPBGEgSETt3i7ArWuy3TrxrGKmeVqJASUHCRrpXYCEJBzIiRQ2FG07flpjaOLg0wk2kV65Dx1F5LCE9fyackwn9hzd6gxmFyI9tlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gazKcSCi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gazKcSCi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so11710895e9.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790683705; x=1791288505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dz8/exrfMqkUxfF+LKzpfkVXvHUn4Wq6vR1Sr0EbrhI=;
        b=gazKcSCiWelMJ3MpZKR/MyQw2qZSieg6gm2ld5NeZTG/k0h44TzfxLcLNdmfjF9rKg
         hPJVY+mm7rdiV+qX7AmcInkso/BdTHiWaaFdQ5355mC/szlJzfBgOyfYx63WovX5gYQp
         Nqg+wLl9YUPj9a4DmjxGED+mszhnoxurQGfgVNxGmCVfdOYveSlFybA2vEtPbx80jd8p
         lNEEGb9NQ0qgsuTm+JPwexN/hehI4EJUuSINUPvHFG78QCj2CY2Wgt5UOSYFTDdnlN1N
         AYFGr3+EcQwawUB02ThGqtagtibWXu+HL6VTF0XPV5Ti+hEwO/I6j0wLyKQzQEwM3bQB
         YJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683705; x=1791288505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz8/exrfMqkUxfF+LKzpfkVXvHUn4Wq6vR1Sr0EbrhI=;
        b=FJoPNC+wGFc9ERU4e8sVm48DIHic7w3EE1DGZ9lEfMFH+MWnXGIk8winBUi229lGYs
         3FFEQEY42cFfL+Byhq2NIAglRi7FsQU3OKCVBDYkEfw5O5fvXW9M0cHoU1yeLAay5iKn
         UqBONTGIpDO5eh5Zy3Hm22JUJhAVyubmrnU68k/bbzBCj+msObXok6z5DNeTJDTac2ZA
         ZG03dJTx0y/dbra8qIjl7/vVkNQndcWeN4NU7bn1RLF2ouj2vmEXDLoKiCMzt5UGqcfL
         YztkV09V8DmNVrbN0p7gvs9YNzS5k4iIf4C+TD6RTlbg1pABTXSu71EsEXb9ozvMibT0
         tylw==
X-Forwarded-Encrypted: i=1; AKwUvBwb/gznlk88FmyJdUyrjsLBKQEiRGSISVGAvEiop/ttG4W5APaQEZI+nFCz1sAQ9Ok2Tic=@vger.kernel.org
X-Gm-Message-State: AFuF++l18Ujc18LJR9LOsLWNLsIR8Bh7r2FaFhzy9RCqkrjjJhBcZunT
	6WSjIU56kSjU8AwOqgEHHLPjqA5fdGNTRrwryB95c7+nnAOav0LOg8gA
X-Gm-Gg: AYBFou0LWRm/1+IGgMztu4/F9rdwgzQg3UNnmRJBfFf7BL5w4Z17ggBGYWzOHCgg1pf
	EqB1gMxZl+Qkd4f5BjD/su9ox/ArBtLMSj0t9/nEXJAumXckY0vzeo+DPQsEWuuE1sHYcNDUFD7
	XSPO4jjZ0oxwsAqqN+/1GWis5v+b9T2Cg9DcXwOlPxqkSUaEUQzyLOH7KD7ReKUleUEEXUJLG3V
	BKaXCElcIfZqUgUa1B5gjRgiaeFDzkkZoAbiQN4p3gQxhL0MpXJXmdsaZoZvqIFJEj+JJMiIExC
	6/2Ck7Pn6tqaVfaiMMDFnt4yd1ZNUKVZLUv7PChpKFTr5P+ImDQXr1MR9GkzZhiJe+ObWt2I5jn
	Y/CQ+LGd2XHC3b42M7w8b5zFhTLuqocdzEyP6HXlhJIZt6Ikw+FBaEhpQaCpZzBs/0GaIJId3Gd
	ok2xr+nERh9k0m8QBBIUI55VRUHIiQf5+Ueb7Psoa6sMKmOASFKQxwsfxHRw6Bobyaxx3bwqxdA
	MmozXeKYQDPHpRr+GmoH1DjYE6IGEUv8TfvqWkDbxGe3o0=
X-Received: by 2002:a05:600c:348e:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49ff06b2ef6mr221635255e9.5.1790683705081;
        Tue, 29 Sep 2026 05:08:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:bbf9:6e62:677e:7b50? ([2620:10d:c092:500::5:e8fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfae123sm80415185e9.13.2026.09.29.05.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:08:24 -0700 (PDT)
Message-ID: <3fff6732-025c-46e8-b3d5-320bd74a87a4@gmail.com>
Date: Tue, 29 Sep 2026 13:08:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix missing migration protection in
 __rhtab_map_lookup_and_delete_batch()
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>,
 ast@kernel.org, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
References: <20260929081609.557899-1-omermetekaya0@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260929081609.557899-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/29/26 9:10 AM, Ömer Mete Kaya wrote:
> bpf_mem_cache_free_rcu() uses this_cpu_ptr() which requires migration
> to be disabled. All callers of rhtab_delete_elem() disable migration
> except __rhtab_map_lookup_and_delete_batch(), which calls it under
> rcu_read_lock() only.
> 
> On CONFIG_PREEMPT_RCU, rcu_read_lock() does not disable preemption or
> migration, so the task can migrate between CPUs during the delete loop,
> causing this_cpu_ptr() to trigger:
> 
>   BUG: using smp_processor_id() in preemptible [00000000] code
> 
> Fix by wrapping the delete loop in migrate_disable()/migrate_enable()
> in __rhtab_map_lookup_and_delete_batch(), matching the migration
> protection that the other callers already provide.
> 
> Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
> Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

> Changes in v2:
>   - Fix root cause in __rhtab_map_lookup_and_delete_batch() with
>     migrate_disable()/migrate_enable() instead of stretching
>     bpf_disable_instrumentation() in rhtab_delete_elem().
>   - Fix Fixes: tag to 818e00848227.
>   - Fix commit message: migration disabled, not preemption.
> 
> Tested with syzkaller:
>   - Before the fix: the reported warning was reproduced reliably.
>   - After the fix: the warning was no longer reproducible.
> 
>  kernel/bpf/hashtab.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index f744a42bb813..2bb9ac7fc73e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3369,8 +3369,10 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	}
> 
>  	if (do_delete) {
> +		migrate_disable();
>  		for (i = 0; i < total; i++)
>  			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +		migrate_enable();
>  	}
> 
>  	rcu_read_unlock();
> --
> 2.55.0
> 
> 

