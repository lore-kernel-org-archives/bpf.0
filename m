Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD93BADAC;
	Wed,  8 Apr 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645605; cv=none; b=AcwwhBuQF1N7bu1VEHRhI+c3WGDsSn8bvrZQ7N9bTY74a0g8lJgfzei6TiMlS9WJVsaR4WmXh8rzwNJ26fu36T/YQhDUPEkTC0PbQj8yNaNkc4zh8gOq1rIrcWPRpF/QHVyVxfUqHKzLogz4LTwxSak98Po4qRRNw8T5g6aLURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645605; c=relaxed/simple;
	bh=Q6Azqz2VX8lOgQckS3qE2M1Ck0ae5sU+2OC2UzPRZuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txju/WA5YvZ1qoltbNqCW2PUXOUutjWdG7DgGdUPIkTUl0D0BmIhcjJdwPCuIbRGRaUqOkOWq7tDHaF3YSFRdSSqUrLZI/EvdNqUpyv+0rP0Em6fAWL6M23dT6Qmw5I0zq4BYmP1wM5i0+5R1fgTmBVWXo+pYpICk9zmPvrwjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X70mUwaa; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X70mUwaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yAzbb+chCzH7MCrnMusgK+Sb1LYSjjPZi4aEUOJCX2I=;
	b=X70mUwaaTUuKcHRYA2mkDmkjWciyI9wMBowypB+Przjwr0C1xu7qgI6RFax5mi
	CB3ZiZr7sOjzVxNnCt1FPyoSegG8cfpnQ+mfDyLk8p5hmglwLYalXzLDLSuEtX/m
	Jg9VyaXp9qDrldzbDh4a1FlNLpTEv4GUieT5lTHM81DV0=
Received: from [10.54.24.32] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3H11wM9ZpGW+_Dg--.59018S2;
	Wed, 08 Apr 2026 18:52:34 +0800 (CST)
Message-ID: <ec2c00fd-3e27-440f-ab01-16eeb80c66fd@163.com>
Date: Wed, 8 Apr 2026 18:52:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix out-of-bounds read in bpf_obj_memcpy
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>,
 David Verbeiren <david.verbeiren@tessares.net>, linux-kernel@vger.kernel.org
References: <20260408100455.190561-1-jiayuan.chen@linux.dev>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260408100455.190561-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H11wM9ZpGW+_Dg--.59018S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWUtF4xXr1rJr47Ww47twb_yoW8Kw43pF
	Z0qr1Skay8XFyxJa9rKw4SvFW5X3Z7KFyUCay3Aw1vyrs2qF1kX34UKrW7u398uws7Kr4x
	Arn3KrZIkrZrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFD73UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbCwxL4oGnWM3LrgAAA3c


On 4/8/26 6:04 PM, Jiayuan Chen wrote:
> When copying map value between two maps in BPF program, an out-of-bounds
> read can occur in bpf_obj_memcpy(). Consider the following scenario:
>      // map1: BPF_MAP_TYPE_CGROUP_STORAGE, value_size = 4
>      // map2: BPF_MAP_TYPE_LRU_PERCPU_HASH, value_size = 4
>      void *src = bpf_get_local_storage(&map1, 0);  // 4-byte buffer
>      bpf_map_update_elem(&map2, &key, src, 0);     // copy src to map2
>
> The verifier validates that source buffer size >= destination map's
> value_size through check_helper_mem_access(). Since both maps have
> value_size=4, verification passes.
>
> However, at runtime bpf_obj_memcpy() rounds up the copy size to 8 bytes
> for long-aligned atomic copy:
>      bpf_long_memcpy(dst, src, round_up(size, 8));  // reads 8 bytes
>
> This causes a 4-byte over-read from the source buffer. Fix this by using
> round_down() to only copy complete 8-byte chunks with bpf_long_memcpy(),
> then copy any remaining bytes with regular memcpy().
>
> This ensures we never read beyond the validated buffer size while still
> maintaining atomic operations where possible.
>
> Fixes: d3bec0138bfbe ("bpf: Zero-fill re-used per-cpu map element")
> Closes: https://lore.kernel.org/bpf/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   include/linux/bpf.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b03..1b789f9f8a095 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -535,10 +535,15 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
>   	int i;
>   
>   	if (IS_ERR_OR_NULL(rec)) {
> -		if (long_memcpy)
> -			bpf_long_memcpy(dst, src, round_up(size, 8));
> -		else
> +		u32 aligned = round_down(size, 8);
> +
> +		if (long_memcpy && aligned) {
> +			bpf_long_memcpy(dst, src, aligned);
> +			if (size > aligned)
> +				memcpy(dst + aligned, src + aligned, size - aligned);
> +		} else {
>   			memcpy(dst, src, size);
> +		}
>   		return;
>   	}
>   

This seems to already exist....

https://lore.kernel.org/bpf/7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com/

pw-bot: cr


