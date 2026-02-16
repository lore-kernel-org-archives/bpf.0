Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2983191BF
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256960; cv=none; b=HToRPIBNFjjCaPLdcsC+jNmkkq/sLIcThZGcgn3HpFbl3rt0YEm5f7EBLuE+rJSEBrdvl1g/8ozFdVGhGdOSvdt24TjDRk/wMW4f1ZQK2Unp6JeEhbGatHKZjdjCzGsW/pWILKly/cDhjZWXLrKUSpwsxyhZ98Y4tMYMppWvEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256960; c=relaxed/simple;
	bh=S7FCPDNRTuTokYbVmtUw1wt5LCxHACHp92odx4zAsRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPP1MkREAoG9T0LPuHsFZ4h/vPerpnRXPIOaxntWk7h5sQrsBJIGwEn255Gj36Ru8num4l1/R5C9VvrsXH9Hzxm5JF0N2HdtXfl7xq0uEn/Das7JCzcvHMmLbMZiNA0n78oazEseqBI7cM6MnIXX6iLlmxSyV1wiS9pe3VrZ+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YMqmGNgc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YMqmGNgc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-662fe3ff6f6so1532052eaf.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771256956; x=1771861756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYsmHXReoW9BrXI3fnboPaB0P/FfcginaDYlFc3JCAU=;
        b=YMqmGNgcw/q09739d6onWHvYU3GFDWr+k8OeoGJj1xp9j3W/DtBRQCs/O0qM4tqoQu
         lHpoLaIpujaGOoZ3Qrtuf35F305O1UoVvO+f3SS+iNXiAOY0l5SqsiMP9uVY2F+KPzqq
         bzX/nxhwZD2wGuQGyTaMArujccpCYLezrEwu0utbko4/tb8nORiF4f479zPQwlmTluH0
         3OoKRk4TLHWh96f0bQgkr/aaGVQItZxaJWIuLvpC55BbhNVfaSGq0cvl+s9p53Yn2QpY
         LZJ5L/2/gQPlU+QSUyngy5X4N0bI0jWYuHqUCsq3i20RHrfjpLJvyBjLZYTzebFIBq2A
         pUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771256956; x=1771861756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYsmHXReoW9BrXI3fnboPaB0P/FfcginaDYlFc3JCAU=;
        b=qbg93sqThDNAhqAZ6Uq+m76aSseTHnZLgAsDQhmKFnh3ZjzTl9J/gapHbJSxEFO+nl
         CbL7e4WWoShwUwKL0eLViTvMffjxLU3gh+gI6rNXNN2RM+RvVIRCkM8mKNEzlohTMUGx
         IsmlRveu3OZQ3UolQ0rg7EpPsKxAl9xaQ9Nyk1c5IcXAuc0YnipUkq8fvF7ZUcMp46Je
         Ze0B9U69DwCJ8z9xSetZk1WhxJWG1M4AnVeq2ZVHjY7H3dBKBChyxlW/9KeHwThK6LUN
         l28Xq5YjpfoGDTwmuuhkpdkS7YtcwHP39h53Xq7tiNFmbxgauSJ8VWb7jVS2rKk4JypY
         VIaA==
X-Gm-Message-State: AOJu0YyLzTw39e1AxkvhSGx2hmBqZ5J76EyhqVYF3Qr/DqB5oplEAPt9
	cKRcjBj9KPC2Lznin/7chzmiLj4VH9ryzgiJOHtTJeT56MGb0quAyBAKgPlzU9MQzwc=
X-Gm-Gg: AZuq6aKHHkraiQP9Fka14G9D6Qm/FCahWqm+U1Rn+Of8y/zi+rxLhVoVBn0XFxZLA0h
	R0J5B9gyAD2ZwGWUl3LHWRqJTcq+g9U491sWMhswgGqmO313BNF3rZgs5uMaW4aDzf34ZK05ajz
	PL27wWTtPvl4jWmQk3b4jgjj4WfhwrVDnVDBwFPkEWnKGhK9DjvEEOokpklfsP3LpBC7sWfcu29
	mFn25z74a7/8Df3dCh/woUfhjNKbclwgwhYOM0z/LtqkGQrpAgkcfonB+CNIREClxQmnla7l0f7
	5aI6TDqKe1Qmibta1Wo2ipb0wKgsT9TPpi9BgpjSDtNMuz/SqoGS4Q0Nq+GDVTdyRI6cyMEdWsx
	V3R3WVhgOiOS76pHl1IOkdgGsjVnPqdP16nanEHql13d3aJrnAKezBrq+MkHHd+0nr7RNGC/Gj4
	GGDolgd4GQL1U/6qo8bD1fz3zL1DybM7p1DYWRWEkd1cH7+aZePCcvag5ezWitCgGtWbxJYWrUF
	LXjrJ8BSQ==
X-Received: by 2002:a05:6820:1b08:b0:679:1eef:96f with SMTP id 006d021491bc7-6791eef0fefmr3551041eaf.29.1771256956100;
        Mon, 16 Feb 2026 07:49:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeb42708sm15529092fac.0.2026.02.16.07.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:49:15 -0800 (PST)
Message-ID: <0b2d5fa2-77b8-4b0d-b90f-d073ea671fbe@kernel.dk>
Date: Mon, 16 Feb 2026 08:49:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] io_uring: introduce callback driven main loop
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
 <efa65f15822f686bc2a8abda7ba799d3cf46f6c3.1770836401.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <efa65f15822f686bc2a8abda7ba799d3cf46f6c3.1770836401.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 12:04 PM, Pavel Begunkov wrote:
> +static int __io_run_loop(struct io_ring_ctx *ctx)
> +{
> +	struct iou_loop_state ls = {};
> +
> +	while (true) {
> +		unsigned nr_wait;
> +		int step_res;
> +
> +		if (unlikely(!ctx->loop_step))
> +			return -EFAULT;
> +
> +		step_res = ctx->loop_step(ctx, &ls.p);
> +		if (step_res == IOU_LOOP_STOP)
> +			break;
> +		if (step_res != IOU_LOOP_CONTINUE)
> +			return -EINVAL;
> +
> +		nr_wait = io_loop_nr_cqes(ctx, &ls);
> +		if (nr_wait > 0)
> +			io_loop_wait(ctx, &ls, nr_wait);
> +
> +		if (task_work_pending(current)) {
> +			mutex_unlock(&ctx->uring_lock);
> +			io_run_task_work();
> +			mutex_lock(&ctx->uring_lock);
> +		}
> +		if (unlikely(task_sigpending(current)))
> +			return -EINTR;
> +
> +		nr_wait = max(nr_wait, 0);
> +		io_run_local_work_locked(ctx, nr_wait);
> +
> +		if (READ_ONCE(ctx->check_cq) & BIT(IO_CHECK_CQ_OVERFLOW_BIT))
> +			io_cqring_do_overflow_flush(ctx);

We need a __io_cqring_do_overflow_flush() or similar here that already
has ->uring_lock held. Or The same dropping/regetting of the lock as is
done for io_run_task_work().

-- 
Jens Axboe
