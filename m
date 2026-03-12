Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177B40DFD6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316310; cv=none; b=ERXinEvUSaOjDX9KFUBmfsqLUmlWaiOt0nIQFCkO1xQi8ZqqgFJnEbdF2HP3vmw9oKjoSdXF0HT52fnq5FeID7ju255kmhLf9k3fNLKObR5oPb4mDDFNqwYiJN9hb/lhaeCfPURMgtoCBi1UG1Jj9g9vaRK//pUVmYllRWXNQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316310; c=relaxed/simple;
	bh=Z4Ws8mKCaJUX5OBeGlpIpwTVttxNk+a47sF/NaiBeZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QofYVzCAPzfqppuiWorVNfZinGp4tlHgqWXf/EkhtbWexT4ek71tZtvT2lOrZHazTpDf1feZKZB4NYGWF5NY+dRv6c5fUh2wCa7yAoUdsm159ahLv12scJkaSleFKk6iDYmfczS6CyMTo2hRpoHr6NPK+1pkhf1an84ywHcSZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAvIqQhp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAvIqQhp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534e9076fso7726425e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773316307; x=1773921107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nj2fNYw6BYUD7p+9nV81GYzh43IyNKQmwWVqvC/ypP8=;
        b=OAvIqQhphz8ZZkPT76Odp13sxSfF5yR9OMaes8M89F2pnwjLsJT7eKNjdPJKd2mgle
         GiewifYf5y+W9IoKybuin3i1aWn8zGGrOKM6YYYOuKldlLigKX/feAfJ+AmepzqrrQk0
         lNmjoTkTvrz0+/SeVQLRzyfo3QPNzL+a9HwYPArhwYyyZkjdqchz+GujL1I7pq1FgeC+
         gxOqArapWoQOP4rS15+1/P1ILSEcb2neD+ec9TA01zQJ74dHSJxe3RYJ4t6weoGYlvC1
         3M6k+mIMCfdMrMTMzfd8BPu3WHVMeiAxiV8Ms9liTl27IFy30zbI987xMjuKl6wrEzTh
         zutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316307; x=1773921107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj2fNYw6BYUD7p+9nV81GYzh43IyNKQmwWVqvC/ypP8=;
        b=pckU+5zKIfUFB2pgM7UckFWfImxtHq8EwPKjVTD0LK1ECzvBL5l8xxw0BuoXsyGkj8
         YHiffZWRYpZ3zbaDXWXgHoKwmSjI7ZpymLskmEis/nPzkgmKdW0bpevt1/baDfjK4WSP
         cpOuEsms7Qmbfu8WLsBXKDp2HS6Gkpn/VkZPWRbTGW9Tej7Xz6c3/uKF+G2deiEj73OX
         vEBL8HndIXo3nbAG14C/dvFwZoFpVPT29JMG6VKlOpZWBRlBElrdpPBZwjj3FoLPD4NF
         Mvs8bk5CUM6tkE+yReClXkjPvG+RoTLmEO1ZCvIGxWMQJLAbWoRS4flrXuzZRsT9zvYj
         kUEA==
X-Gm-Message-State: AOJu0Yxz1xxnvQ3ZMu7scBlGtwJwGbvcRnPyaWVDb+FvpT5BTdf8rWbP
	sF201wRwNI8wRZqlSFcTmAXSjtdBzfqCRSo199eVd2r2jiYs5aBnfxWO
X-Gm-Gg: ATEYQzzpLMInXZzWv9VyBdORlyn1F6vA2jqizmKc7OksA5nkkgCe/Zaow+f6PB/jJuo
	2DELf3zoP0ZTkxH04k32uVUBFn9WTSMIviebomaPGcLmzUtgOdUvj9WH7iE/y3+Ld/xU3OGKW5L
	J2X1DzqppwgqsWmB9XoWj+OBNApJztIqo9Xq6fD4Oqr8fsZjrVnOPmXXCn4HFbf/jCWFdho3pTy
	RkVI7FTCoUdbooqPmHTev2RTuA3RoWJ6krAQp2m+qWmjejfmhZ91vYcd0dRXDtV9gF8wITPtcMN
	B3NjLAZbG4q8LosD5CW40zf5DREhkVt5CBLv7YNEAj5qqs8XuLEGRWfcLaLl2osWA/FqxpaOqQh
	ziWWUphsURD4tyARKKz8iI3s5KnnOjvzQ4iYcmSV8TC63kW9ieY/KYEXSeE5YvAykPWcHKd0TaW
	lr88sQ1jrT1OcCOFTHfXaNlq4PvmckV63JSvJZCtMpuiS9wfjRZwIFfKeaGHPA57+6K/Dn5IAVD
	iUGMFvHmetZqT/jleaMYLqLfJXtVwRBUAZ5f3e60H+pHQ+HCHTId/vu3B3F6TjtF7YhQRtDn3Rn
	Tf3D0vHY7DVXWTDZf5OyMA==
X-Received: by 2002:a05:600c:8b8b:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4854b0a5370mr92896185e9.6.1773316307141;
        Thu, 12 Mar 2026 04:51:47 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e621310b96d0fd4d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e621:310b:96d0:fd4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0cc00asm68758265e9.7.2026.03.12.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:51:46 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:51:44 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: xulang <xulang@uniontech.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, kaiyanm@hust.edu.cn, huyinhao@hust.edu.cn,
	dzm91@hust.edu.cn, kernel@uniontech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Message-ID: <abKo0HZ3R_oY1BUa@mail.gmail.com>
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>

On Thu, Mar 12, 2026 at 01:25:25PM +0800, xulang wrote:
> From: Lang Xu <xulang@uniontech.com>
> 
> An out-of-bounds read occurs when copying element from a
> BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
> value_size that is not 8-byte aligned.
> 
> The issue happens when:
> 1. A CGROUP_STORAGE map is created with value_size not aligned to
>    8 bytes (e.g., 4 bytes)
> 2. A HASH map is created with the same value_size (e.g., 4 bytes)
> 3. Update element in 2 with data in 1
> 
> In the kernel, map elements are typically aligned to 8 bytes. However,
> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
> value_size without alignment. When copy_map_value_long() is called, it
> assumes all map values are 8-byte aligned and rounds up the copy size,
> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
> 
> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
> aligned buffers, matching the assumptions in copy_map_value_long().

I don't think this bug is specific to the CGROUP_STORAGE maps. Wouldn't
it affect any copy from a non-percpu map into a percpu hashmap? The
reproducer in [1] copies from a BPF_MAP_TYPE_CGROUP_STORAGE map to a
BPF_MAP_TYPE_LRU_PERCPU_HASH map, but I suspect you'd hit the same bug
if copying from BPF_MAP_TYPE_HASH into BPF_MAP_TYPE_PERCPU_HASH because
for BPF_MAP_TYPE_HASH the value size is also not rounded up to a
multiple of 8.

1 - https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/

> 
> Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
> Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
> Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Lang Xu <xulang@uniontech.com>
> ---
>  kernel/bpf/local_storage.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 8fca0c64f7b1..54b32ba19194 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -487,14 +487,13 @@ static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
>  {
>  	size_t size;
>  
> +	size = round_up(map->value_size, 8);
>  	if (cgroup_storage_type(map) == BPF_CGROUP_STORAGE_SHARED) {
> -		size = sizeof(struct bpf_storage_buffer) + map->value_size;
> +		size += sizeof(struct bpf_storage_buffer);
>  		*pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
>  				  PAGE_SIZE) >> PAGE_SHIFT;
>  	} else {
> -		size = map->value_size;
> -		*pages = round_up(round_up(size, 8) * num_possible_cpus(),
> -				  PAGE_SIZE) >> PAGE_SHIFT;
> +		*pages = round_up(size * num_possible_cpus(), PAGE_SIZE) >> PAGE_SHIFT;
>  	}
>  
>  	return size;
> -- 
> 2.51.0
> 
> 
