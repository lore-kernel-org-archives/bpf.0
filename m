Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFA3AB480
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737899; cv=none; b=mOHrfiLgbn3nsc8Kt1Mz4dSu6e0JygxhsndAyzMN1Q9xectf9VOcWs5Fq8ysoboiHur7houlzswVELFGJ4s7L3V54RoEUE/eC8Xg9H0Rzg1+hleArHVSN3s1UnH+jLAKa3bSslsGoxYhiwobJnd62phw9g4WrnU6ZmhcoWKqQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737899; c=relaxed/simple;
	bh=j08kLBr3xPzFQpY9Bk6dEOdcrNQAdaJGEtq6MIlmTlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPxw3EV3825xNeca9EFPyWCNyzKa2FxGPuWeNFbAncwTW4uCXIQO157Hs2PNIfhZi5gvd5KUiANpMnXx5BJCfYl54Ge7W40oL4Apa4q/Zg6lbYJTdTqTAeCTekpzYibqOTP3lPIEbs3ZGWwwVVIGsXbqFNpGkzQmLrJ0yshnq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1WclP6f; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1WclP6f"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so5275085e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737896; x=1790342696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9kf+10HssNT87nsY4bKZ9lpCEYsQF18ZFvlEmQbVyKw=;
        b=n1WclP6fgkEwf886GX4hbs6TkqSg/P/3zu5gzYSdDe5cO5V6t49QITBlTVw1qZBBcH
         q84ljTHhknmLZUhZEoAVoYw4M6SSpuW3XXOBv6vZySYQMo8dzTobCBmw8sfLClS4QmIh
         NbRUA9hdeygNILJwjAFtXrh0FF9tMuCMKNac71/Q/U9115vvdJcP5/piktPsjhx6g/hB
         KYNDAqXrNR961sMlaaUNiD1JPer4oFPjL04z9df4tsLfB6ExK9qkq1azK8LNJx/ct9bM
         W5vsqA3XSJ52gaHwh0JE3GzcLjuRJ+8ldAcwGzsaqL4F6OUB4JjpieAW6PtdEt1BI9WJ
         opzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737896; x=1790342696;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9kf+10HssNT87nsY4bKZ9lpCEYsQF18ZFvlEmQbVyKw=;
        b=oTz3eUhT5NV9SxWim/44pdGGeir10gWwRrH9L/oaDU8t8YsIjbKzuyMcQ4ijJkXqP8
         HRkz/x47b2dn4QUBLTQkTwNNKUBHWZeIaYTTJyQjnGu570ROXVZk6S/Eir0rzO+augKn
         V0bq8/DHCr3tU+ljyRPruOBaN0lcyzdN63Vo7dpmP1AbT7ierq7LQpy+RW8EKM3u0PBI
         x8yGoqBwYB1Q7t7hTaWgda+Lc68br/rBHFmh6SjIpLLI0+HulKeBh3q66VVql3Crb4kO
         JxCY4WS0XzbJrnExpt6rsgWYWQuP739N3ovGGZ5jxslivnrj2RhhJJLq2V0TkbIZUlGK
         qd9g==
X-Gm-Message-State: AFuF++lk0s6rsFA08akatl6M39/p7mrs2xQHoCBfWE9PmZ+/tD9npdBS
	U8L3yJLvb3XKWsmwLiqyuqmXwb/5hrkALG7Rpw4eltEequYAfO3MnTP9
X-Gm-Gg: AYBFou280gAih4Uq/CpN5p+A84V1Ke8EyFWgX++cX0uQu0EhkqxyvJDDY3aeDyrQyAh
	PX1XOGodN/RmF9Fmhf3+qvXnlyySj0U904LgC+SWG2Vrs560/92dWBEEnviRVY01JOtdSYac39j
	V8trxgXLE4HavJFyey5Ex1Zo3+T/Y0qCLnIBCiPJa8uvVgk77ZfZAKCGIwAgyEkV74O9rVqNBO+
	TaCwmzDXwzrEnO9EL3VDwlvGN2FtnM3U+0fxi0baly0PIN4ldCw/qj8cQN19UcXpZ494UEfJ2I7
	w4HCn29KoWo5oYTO2HSevAmu5VdFJBIwWHFhVka5YPXCqfsnZ9JxUYknApfjpOhZeiYuExEncRY
	I2Ih8CJzxUOfkNgX5cjjYPVUMK+OdHKwMdRL80UEDOS7e+90pPClX5XbOhs1XG2DFzZsDGh4ZQy
	xmWnJtzsOnNfQucpsmF0wG9WCuZGMohmzaDtoNXmjtpgUn7PC0lBG29OYSOrf+xKZrzFgFtMumK
	Rrbrk0q0sOuGYn10igLops0JtQuPq+MltNO
X-Received: by 2002:a05:600c:1f8f:b0:49e:8354:26fb with SMTP id 5b1f17b1804b1-49fc574c729mr35243835e9.32.1789737895611;
        Fri, 18 Sep 2026 06:24:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a888:e521:9904:1dbd? ([2620:10d:c092:500::6:24b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm183969415e9.3.2026.09.18.06.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 06:24:55 -0700 (PDT)
Message-ID: <9c134c8d-6d50-451c-8336-4c7077b2cf44@gmail.com>
Date: Fri, 18 Sep 2026 14:24:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Clean up child when
 task_work__open() fails
To: Yun Lu <luyun_611@163.com>, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260918024300.18321-1-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260918024300.18321-1-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 3:43 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> task_work_run() forks a child that blocks reading a pipe until the
> parent wakes it. If task_work__open() fails afterwards, the parent
> returns without closing either pipe fd or waiting for the child.
> Because the parent retains the write end, the child remains blocked in
> read() until test_progs exits.
> 
> Route this failure through the common cleanup path. At this point
> cleanup is safe: pe_fd is -1, link is NULL, task_work__destroy() accepts
> NULL, and the pid > 0 branch closes the read end, wakes the child,
> closes the write end and waits for it.
> 
> This is the last early return after a successful fork. The fork failure
> path already closes both pipe fds after commit 5730dacb3f17
> ("selftests/bpf: Task_work selftest cleanup fixes").
> 
> Fixes: 39fd74dfd5d2 ("selftests/bpf: BPF task work scheduling tests")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> ---

Looks correct, thanks for the patch.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

> Resent as a standalone patch against bpf-next as requested during
> review; the content is unchanged from patch 2/2 of the previous
> series.
> 
>  tools/testing/selftests/bpf/prog_tests/test_task_work.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> index 774b31a5f6ca..fe0cb1702eaa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> @@ -85,7 +85,7 @@ static void task_work_run(const char *prog_name, const char *map_name)
>  
>  	skel = task_work__open();
>  	if (!ASSERT_OK_PTR(skel, "task_work__open"))
> -		return;
> +		goto cleanup;
>  
>  	bpf_object__for_each_program(prog, skel->obj) {
>  		bpf_program__set_autoload(prog, false);

