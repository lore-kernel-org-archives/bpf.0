Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6366256C6C;
	Tue, 31 Mar 2026 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934376; cv=none; b=fHVkhH0xXVrVx3ZPI/ZtAvzL03CKJL9osB6LpUMPr67OMho1InIBGDb5fWZw398+S1aO1Yse7LUUxBZafmZ3Bp39d/Z7eUpEk7NErjGN2t3c1xD20+wPafrEiK89TdCkQ2FRBDBpCuizkF+XKmFdunbvT3NTziMtmsEbfhfYZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934376; c=relaxed/simple;
	bh=Lk3bBqMMA1mM2im7XInQbvhmL5xrBdfgSDU9gawjNJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBUSlhdmDBwFVyWsdqs54nJJ+geDYH5Y0iA0Vnkvgnce4H0xrJ1dnbJSoN0d/HjBZO50ZBQZelUkGV/TpAlXkAPuN+wTS8aM32KUGDqdknQQrabE5IRuHGIcaIJoUZGsvnwt+UDEVYaGoEB34dBaN81DppTgf/0Cjr9eV7ZJO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbSHEORU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbSHEORU"
Message-ID: <56b3dd26-4110-43c9-8bdb-abc3b7a78435@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774934371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZ8pQPYmh3QcfDK9mi4zV9oHvq360nxTDNP3s1umwsI=;
	b=nbSHEORUS3EiIlPkW1vHGe22fgXHRDzfxji3GrxBlZqVUfwOSLADENFzlvBBpTeSrjoRqI
	bJtOD4reKlJT8dTrXSJgK1nMHa5tFZaFetz/M7M2F/mr0QcCdG0mv19WfWPwDBtiT3rTUH
	JjSeMeGPaq7CD7uH/6A1gJDK0m/Ym5Q=
Date: Tue, 31 Mar 2026 13:19:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Content-Language: en-US
To: Sechang Lim <rhkrqnwk98@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 sun.jian.kdev@gmail.com, linux-kernel@vger.kernel.org
References: <20260331023056.484354-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260331023056.484354-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/3/26 10:30, Sechang Lim wrote:
[...]
> Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
> Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array maps")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---

After looking at v2, there's no functional change for v2 -> v3.

I think, you should send a PING in v2 after some days instead of sending
v3. If v2 will be applied, the tag will be picked up btw.

Besides, change logs are missing here.

v2 -> v3:
* ...
v2: [its lore link]

v1 -> v2:
* ...
v1: [its lore link]

Also, you should check sashiko's review [1].

[1]
https://sashiko.dev/#/patchset/20260331023056.484354-1-rhkrqnwk98%40gmail.com

>  kernel/bpf/arraymap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 33de68c95..5e25e0353 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1015,8 +1015,10 @@ static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	int i;
>  
> -	for (i = 0; i < array->map.max_entries; i++)
> +	for (i = 0; i < array->map.max_entries; i++) {
>  		__fd_array_map_delete_elem(map, &i, need_defer);
> +		cond_resched();

Since bpf_fd_array_map_clear() is used across prog_array,
perf_event_array, cgroup_array, and array_of_map, and this patch aims to
avoid RCU stalls for prog_array, does this cond_resched() punish
perf_event_array, cgroup_array, and array_of_map?

Thanks,
Leon

> +	}
>  }
>  
>  static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,

