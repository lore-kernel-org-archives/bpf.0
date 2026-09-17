Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557537F8CA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611477; cv=none; b=p+5+gH0qhM2XU3/yD2HDErOlct/eIzeabT+SDjBXaK+Zg6esDs+uzuj6W3/i931Mx1nI/VE9gWsSzsYcZwq7WNiqHwD13ZAmqZPtxs7DW3ZPJUezkpV6LbH7EituZJsYVoClbnVd5AYnq5fusq0vadmKjZjz5DaM+plgyO82t2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611477; c=relaxed/simple;
	bh=iNBfcS6MDvr00DcTaevT0gyCh2J7vLAarU2nyk/qJjQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=JCwhAzX2Qy5bZlykTY27Xq1bFLmrUEShAKgKSAfP+TJtxGTwBBtYbqYG4PxGhcyZC0lCKiOb4WRNHGeL1q4Zw+WU4Gniq5S75QV6AwWbkVOc82z07DzMb5eryrzoVM261ND4uUykw5BQnibZGFjm5/Y05DTqDgI+abCZNOGDT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8+FBuIJ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8+FBuIJ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e25187so192315b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789611476; x=1790216276; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15AYesmDPyE/Pkb7voFatC1kEWMKzHw4E6qOfih9IzY=;
        b=n8+FBuIJuDho1iO04wTcUOendOlL52ic7mHoFSFIjpk0GBHhB8hUEfJ9c3ksDzE+L4
         JHe8V4tQtqhhlqGxSrIi2LK2uvsQl5YlFIz9xPPhpohxeRltZvxCnW6JV5jLuXNhLj3v
         OtnH+nJthqoi9b2FWYLOP+60rzZ8vQHHfbA1XGzWNSXzC/d+nXjblV8bRR0jj+9GkAur
         b87Cdif8DMCVHL2muWCOk7pU6SNXmycKeZJlIMCStg9d4stDfgXbccQJN5b1jukq6Vaj
         PgHFDGZzPpUn302WaIjJTuKHDqI2umQTLJguyLcBzIwn1EVmGXqK2D7EWNZG7HO9Tvlg
         pLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789611476; x=1790216276;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15AYesmDPyE/Pkb7voFatC1kEWMKzHw4E6qOfih9IzY=;
        b=NrybtutcF56EX6xJnJfdcd0WGJjwDCwBPGtoerTwYmKvxjSHyylhU/KzwuRx/QJL+y
         HlJ4yBO8Fo7F9pJfA8WJexuUHfA+lG/XYhCNcTcpbnkPMapBJ+hTOV/JzvmvVs1hKXho
         zkN1WWnvCkBtvNEyTmu88p+XbxTSvwhhku8Snc/2gML0c+UBXmEFdvXwLf/8LwSMkPTk
         KVCe15isczSt72Y2H4eFgN5M7ucOhPgekXmRAWknUVnzd4lG3MlG2X1cHgOQ+GR2zCiU
         rukEkF6xhITVhdGkrPzfUrutx0m7QZK5l2y/uzbpRvgN9ZTvhRlsqgNUhIIN1P/4mBcM
         OEcQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3OL8uiw44I8iEp3FItYpU1sakPrOeNLTAtUFavCK77Iu1VemK4brEwHXNOdPDLrOGt4A=@vger.kernel.org
X-Gm-Message-State: AFuF++k1Va5QY2LbfQACTF8/o2e38re3GnFZTjdF99Q30uPUQ2yS6Isj
	n747qrZecRS73fTkFrP/01+EPLoiFkHJnnTUHuYLJFr8PuQERTGyvX4i
X-Gm-Gg: AYBFou3c8/NR4eu91GzUieMqXOIn1lvcTLD3xnA9HRUDa3BYC1JfJ1vF/ZtY7d6Hlsw
	+pZPb4MJrmH0RK0y1LjyOsNzVASinVeMXklMHxcnvlaPXqDL89kTJaCIsMHTE2NXKJnB/Q0OqPj
	o4CL/hVJ0pmCXo4opjT1dqpMkXW5WDAFuJHQHVDFnUDE/vNGv0+V45+kxy/HG2zCPT10fh36ahW
	uRFJeTFzapnRwUO8GfZ0FejAJU1Ye0leVJrWzXy75NqjTGTOZ4Z07gvDBtGUkrgX77o/Opz8v4R
	S8n4q/MheDCjIxhSXYDysLumz+AN6pviyxWcuwlu96HyKpek1wqxT9JiUqEkmb9usqc+2iuXyNI
	6t5o9bLQzIqCa+xRqKFHbtsK7Ta8VR/Z4AAjUQ2xQxAQyqzw92GUfozILZJ9s00lY8nCbH9l7+Y
	esl6xXVo8AJ4FQIPUEkOFPJkzMoe/FoWas742bd2+riYpp68CbyBCLDUEuKAAay4ISeePfIbHTB
	s15HltyqyYIljZF4qF5Q6d3c798T8pjD1oV3G1d862DvROpavNFWRbNE/NO7hevdVVWTimD0ZGt
	lhy2
X-Received: by 2002:a05:6a20:4308:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3dd5f466f35mr11180754637.10.1789611475781;
        Wed, 16 Sep 2026 19:17:55 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab8ae01sm2452008a12.18.2026.09.16.19.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 19:17:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 02:17:53 +0000
Message-Id: <DLH8BLA0ZCFY.3U2Q1BS1DBTYU@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Add a sleepable page allocator for
 map memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20260917015618.7488-2-jiayuan.chen@linux.dev>
References: <20260917015618.7488-1-jiayuan.chen@linux.dev> <20260917015618.7488-2-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 09:55 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e80963971f680..345fe4c2e6422 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2786,6 +2786,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
>
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **page_array);
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map);

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c7bc9ba9b331f..abd0f67c68d97 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[...]

> @@ -636,6 +635,27 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  	return ret;
>  }
>
> +/*
> + * Allocate a page for map memory with the blocking allocator so it can
> + * reclaim. __GFP_RETRY_MAYFAIL keeps it from invoking the OOM killer: the
> + * page is charged to
 the map's memcg, which need not be the caller's, so
> + * an OOM there could kill unrelated tasks in the map's cgroup while a
> + * foreign caller could never be its victim.
> + *
> + * bpf_map_alloc_pages() serves arbitrary BPF program context and stays
> + * reentrancy-safe by falling back to the non-blocking allocator. This
> + * helper always blocks, so a sleepable context alone is not enough: the
> + * caller must guarantee it is not already inside the page allocator or
> + * reclaim, where blocking here would reenter mm and deadlock. The only
> + * user is arena_vm_fault(), a userspace page fault in task context.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
> +{
> +	might_sleep();
> +	return alloc_pages_node(map->numa_node,
> +				BPF_PAGE_GFP | __GFP_RETRY_MAYFAIL, 0);
> +}

Don't see the point in #define BPF_PAGE_GFP

Just call
  alloc_pages_node(map->numa_node, GFP_KERNEL | __GFP_ZERO |
		   __GFP_ACCOUNT | __GFP_NOWARN 
| __GFP_RETRY_MAYFAIL, 0);

with a one line comment why RETRY_MAYFAIL, 
drop this patch and fold mayfail+comment into patch 2.

pw-bot: cr
