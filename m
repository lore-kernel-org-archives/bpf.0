Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652922759C
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799997; cv=none; b=HJoyD6DhTrH7Hi7oBcxLz3URQp+mUvOEEvLinTaMghCo0bH++tGUjwMA4N5iZL5bsSR7/i0/Dnd7+jSBoXbcW0CRPqRaApwhVX74RHelUizpuwiuxDeEjBhuyUVBDXKL8srNIdS9bqueC6/LdN7Ei55SjDnkbEU36XhHeAIg/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799997; c=relaxed/simple;
	bh=p5VYCtQABaye7ZTXmgb10xbVYOlsG/RSYIaiWaqPOZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t74GuG6LEyjOnPrqAEw4QDtbCKI3q83Dcdts5KwYU9VzuR2wUS3JRzachu1rxdQF7MZBxxOA6JpZSVIP8FPP0sg+e51gdKgfDc/AinUTLSinHZDRBlVk7WBeGvAaAOrSXumTDwf+ORqAmQyCGZu7vZZgxUdMO4C65qO8EveDMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqKNTr12; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqKNTr12"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49050bfe053so7660625e9.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779799994; x=1780404794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaBoPQelgNAd6dOiWsl15VrUYMlD+JFafNFxD3COcXc=;
        b=DqKNTr12Cd9wQmuzWrP7RG1SvyzdVBgWii67QpyJ65KZ/0q98cekHnEAWHPV9h/zUQ
         5r42ya/JuI3mB3m0dTZJdT3Lofgj5KuCeQ0DYVGuYq0xIxgOPWexsn+NLfUFplgfjyga
         54jhIm6ZwUNZ0f/+xjp/stxzDHgvFZnN5rG1BUp3URC9PGqfrmFOh8v9Lk8yyF3ikadi
         DVBe9JkroD0taFtvaZ+h57KaJ/XJyf17yWQBNpbI/glzVtq1ymmqA0kjwzbDaEqBEXht
         BKsemi1RwsrNR3nyDeWjTZkRSAyvnbacMCVSOQL5Gm73V9I7BDxFQ9W8OG90oCPYk1cB
         J5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799994; x=1780404794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaBoPQelgNAd6dOiWsl15VrUYMlD+JFafNFxD3COcXc=;
        b=qMEHgYSAqljISLun9JZ5uxoOZvxWY9BBBkgxezDmB1ecbToZLiNiTutEL02mvXj+fj
         OSm5FJbIjiFYXf/8a5qV7GgqjhPdyg6yYFxkflVj31YkAZAsdIuqs9XWqfqmfTZr2YdN
         4+iMX73CvcgeO5Dq+LErOqULM+uWENXMbsrUoaYaZSBELwbJYMVIdf4gdQzZw1hdmcsl
         yH6Fqg4TRZtyz+7xx/yLVr1euSI8udkOodXYG3g5xfLLY87M5SCr6Kj2GFE8lDxLikbq
         zhgjvLKF3KotBDiHYMYS05Q0NHcnBGpEFHCTaNccT9qBp90UazVam7v3x5f3yjTtpX5E
         BbxA==
X-Gm-Message-State: AOJu0Yz08FuAR1GHi7tnbhVawueW4/zHrCb30OgKLcfCZfPJmZsPZIwe
	N5Hp2m7QT3AokKKb6GaUYA2AF/aEWaI1847oH0ProeC0qjsSTAydBrvSWqRK3g==
X-Gm-Gg: Acq92OGriUMCB9T/1Z6jY36Jg19ZuwNx6HCOoUUQSAMIeffTClYt4GST0xMDlF1ZQCb
	PMHtYTrJGIVCb347VxzClUeGF2DNjIww8eDRex6R5GVTbW6CwAwBETmsho0E5grqDNLXbHfCcpy
	Qr+Iuqf7L4ldJXZ7580apsUL1dS5iHFi9NVYY8v1qwxvCJaQEof3PzPSgxGxKsQdHlUWaEnq6bG
	LiJXqz0WQAdt1k9vwkqpH0RoZktmWR4HvhZ0CMw99oSY3iHzDf3BSKP8b6ck3QlFRC69qeHMDVv
	LZE6F4nFEYPfhC012tbWJaUsSSsSfml5IVIuKeWH5xHp/wau6RmVSx2hKjTKT/42c7hAxxjrP2Y
	HPRNva2wRgqIuyWSBMZAPkYq95CF4Mqcto0vzMzFIG59a82GACIqic6Cwo0u4IydssmnJR0okyW
	8Wdm7veeLNayUtSbA/gn0CwinAhwdAK7aMAlR+kROHBZyFcL8XPlQpN6EVUF5pc3wJLaTrATyw4
	aUcExXYcL2WQ6xHc8docraTcVr7ipjz
X-Received: by 2002:a05:600c:4688:b0:490:4224:e0a2 with SMTP id 5b1f17b1804b1-49042ae265bmr320367255e9.33.1779799994320;
        Tue, 26 May 2026 05:53:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm574348775e9.1.2026.05.26.05.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 05:53:13 -0700 (PDT)
Message-ID: <478d3795-ce7b-454d-a4df-84d1f9ed5a39@gmail.com>
Date: Tue, 26 May 2026 13:53:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: add rcu_read_lock_trace to bpf_timer_cb
To: Zhenghang Xiao <kipreyyy@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org
References: <20260526104357.35779-1-kipreyyy@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260526104357.35779-1-kipreyyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 11:43 AM, Zhenghang Xiao wrote:
> bpf_timer_cb() invokes the BPF callback without holding
> rcu_read_lock_trace(), unlike bpf_wq_work() which correctly wraps its
> callback in a trace RCU reader section. The free path in
> bpf_async_cb_rcu_tasks_trace_free() uses call_rcu_tasks_trace() to wait
> for running callbacks before freeing bpf_async_cb, but this
> synchronization is ineffective for timers since they never enter a trace
> RCU reader section.
> 
> Add rcu_read_lock_trace()/rcu_read_unlock_trace() around callback_fn() in
> bpf_timer_cb() to match the bpf_wq_work() pattern. migrate_disable() is
> not needed because the timer callback already runs in softirq context
> which prevents migration.
> 
> Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---

Is there any concrete issue you are running into?

If I remember correctly, there is no explicit rcu read lock, because 
the timer callback bpf_timer_cb() assumes RCU lock already (see rcu_read_lock_bh_held()).
similarly to migrate_disable(), as you mention in the commit message.

>  kernel/bpf/helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..5056aae41c77 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1204,7 +1204,9 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  
>  	key = map_key_from_value(map, value, &idx);
>  
> +	rcu_read_lock_trace();
>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	rcu_read_unlock_trace();
>  	/* The verifier checked that return value is zero. */
>  
>  	this_cpu_write(hrtimer_running, NULL);

