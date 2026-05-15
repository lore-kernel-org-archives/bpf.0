Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC303FF1DA
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859976; cv=none; b=N6sRC60okSfMmCx8JSU7McNb+KWsL2QPV6tDiawE6/HayA3+nV+/Su3bAqGdjkTP0SsQZiJJt19nO4tBC/8jVXozk0vFHXVSHQ/TvG/l25o0hFIotjuNEgEippBMa2tAWM3IdQbNDOExWeKBXU863cy5UQZRVwIzXDUHr+qesGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859976; c=relaxed/simple;
	bh=LeaHE+gC1mCUrXQASoxg5zg1wnUSLSEeoi/7LPe9A1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaNXRSySsb4PFvZ9ItqTqicoiE3KD8WxA++VsUaKvom0T/fjLV/SI6t6OhpNz1IJDq9GV9EfRBOz0vzkxTixxmo8nGqzrcQU/Hbq1YJ1JN2McUPq4ue75LJNXeYwxX963SzNq/hogBjS72kSn0zRtaehv14SN3TxiNvdxzJzwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NEjzoJAr; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NEjzoJAr"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-439712b3416so2013490fac.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778859973; x=1779464773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id222wMSLjsZO63ZhosNw0OVQDl4XEooys+lgVTccZk=;
        b=NEjzoJAr/iM4kw46VXvO3bAQSQiWIR5WHVsCiXv9ala/2/OmV0i65sTEJup4KCYIdy
         rffHnH/vKwLgr8mnr8+T8bByISM1WHDlJpyR2M7H2i3VntD1zA5rBimFSkV7aw70aYHd
         B6WMS0DlZpDKnfWppxU3OkOCrnI44nAMRpaTLOBnMGmbmPd5ED0wg+Hug19HVH3Y8X3y
         /qRobKFLv/v/PGpmPPIKiIdh4Ifn9lSdO4aWgfmOc3LM4JxcKFClKZ637Tm8umo8l2NN
         2sLjJWMf9DR03MQCUJlDR57z/96PGQcJN46qt1/7H/yFLev1Jbrn4VfxLrAPAcNO8LWk
         IVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859973; x=1779464773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id222wMSLjsZO63ZhosNw0OVQDl4XEooys+lgVTccZk=;
        b=njVC3aXY/b1lK+Ha/vLPcD/RSJgdsYiuWBa0nYPPGULH4MdwTH0972EmFkjoeCqZHL
         cR7sHLXdOUvnKLu7guTTitk5hznOzf872yqPYv4Zx8XYUP3gT3KHOLeNjuk/y/C1c0Lp
         +A/xZxhXSX0Xc36A66UbiQExEFCK73FhOEXQkLTxOOSL4N/9PtjFNtzXEEoYmdZgYozw
         pl3z6VfWyBhkQ4esuu4c+tyKVAGBZTw2yVlZFuH5IUSsoAdlPW1ICQ8unnIppG6acU4K
         we+uMxUV63oi+qTts1GUzFu+O/s8ERQY24uZ1Jjh/Sp1xeuG9llVVYIBmTUESAZ4h0F5
         J1MQ==
X-Forwarded-Encrypted: i=1; AFNElJ/beJmzFtN45jwmgq5JiQCaipkxVLwBYCYKAM7imc366MeucKhvtwgUHFiVjlJnf5R/uqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcJ555DILplJeTvtRkT1rkf/65bsFVD9g89acw9xJ+w6sPyKf
	c13COnCPgj7GNEDC45VXK8qpMrQjIM7z45mEBQqUf3o+rPKX+30sKBrk6t2r2uoawTM=
X-Gm-Gg: Acq92OG7I6l5+X9RlxEKtVbjKwIFbkz9UHYPD41vEZLsAqgNHkr6jYXj6d6bQCnC/Zg
	w9zKwHE9jL57Y6CmSy4L1tGG04q3GIQi5TMFGxcne6LkAuuzikbBgxGQGWnwkpG0iJsyoZqh1fT
	LK9+mYfiVWGb3DM0hqauVTIWYjlwEg4UgaIwtaI1EOBr/vkOookXkRTYxYxGos28Ee9WwhL5NsK
	37vjCpTK+s05H9VaYOqf0Lx1kooosmdtAdxvxxkTcqJ8cjNKLDrmJcE9ZtdCsB7wB9QkmcsRszq
	TCIWoPZQlUQZF/x+jx2QrCQxttfuZgTjlB5NzTCrQPcHDSgGzdIGhqSuCahsALk2iJQsJoKdd9U
	uj8Lx0I0OazASXxBTUdpLDyOQpD6Z+sYctFbKQIUl6T+guH1ewRkUcdfF+vr6tFeNzoJ1FDUjOU
	opBVlqDYVTyZ6qNKjgpISqXANJgh5swbKdWdDLgFnPk/C12WyrNZVGk/Uux4txd33HfIyTswEqJ
	a5abNLU
X-Received: by 2002:a05:6871:ea0e:b0:42c:2c15:3769 with SMTP id 586e51a60fabf-43a2d913986mr3109010fac.3.1778859973279;
        Fri, 15 May 2026 08:46:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4468762fac.14.2026.05.15.08.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:46:12 -0700 (PDT)
Message-ID: <0f7e9184-f317-40f1-b366-d8582cb97ac4@kernel.dk>
Date: Fri, 15 May 2026 09:46:11 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: propagate array_index_nospec opcode into
 req->opcode
To: Michael Bommarito <michael.bommarito@gmail.com>, io-uring@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Li Zetao <lizetao1@huawei.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515145812.1241925-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260515145812.1241925-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 8:58 AM, Michael Bommarito wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 4ed998d60c09c..7b257a03ef84c 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1739,6 +1739,7 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  		return io_init_fail_req(req, -EINVAL);
>  	}
>  	opcode = array_index_nospec(opcode, IORING_OP_LAST);
> +	req->opcode = opcode;
>  
>  	def = &io_issue_defs[opcode];
>  	if (def->is_128 && !(ctx->flags & IORING_SETUP_SQE128)) {

We could just kill 'opcode' while at it, and just use req->opcode for
this. I think that'd end up generating the same code, and avoid having
two versions of opcode.

-- 
Jens Axboe
