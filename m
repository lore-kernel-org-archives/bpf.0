Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63F4014A5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353848; cv=none; b=iKIq7uN6iPBmmY+9sYY0UAgtrZwPTvDlPYj25eS6lXqvhP/8DnwWiBe2n1eNMO5V7yEqEjrJFK/0beVk3XAVJO888IQQvsqZLXhkiadNeLuXf6LBj7X2G+VploHZVEpuG2GDyeJrIPZ7TfMF2sKSLtliXfTA+sK+uIu5Z7Zg5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353848; c=relaxed/simple;
	bh=gOErEcGC2rddUTWqAroj+qxDUTEbmHwrlR+WdCfcYSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IB/rD0lMlweWYg4zo3wk7bHV4S0y/Ro2uWGPNrgOQuaF5C8azanX07ow+x05R2uPy1z9MIByu4ItQpZ7/Mrzq039vBwL1tpbvYchesNzAJ/MUN6xPR8DNOvkni3shRICQMZiy+Pd9bfA3hZ4RJxrBbXdhI+P2Hpyhikg4mxnwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZJ56icEv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZJ56icEv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so29339165ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783353846; x=1783958646; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0bU/6iPyibPDENzeGgAeBM6ROU1FMgoMSU+p7ppEeK0=;
        b=ZJ56icEvgfj6dCOkrtWi3m4RhXBLSWnqmUl+zHPuwLDmAnXuyiNIFdUuwGNrsEnEo3
         S4bv88IUJTuKRzzEX/fy6WppLvHIMsiR54md+ngEsdkeLLkcvL0d8YNodye6B1CAUxoz
         rqzZTmHMivfylDybWUW7pPIzp0wB8Dia2aqeF9pY4bLJ+4bZ0xcEd4vdlGKpY2/L5wjZ
         Za3okHXUayxaggqbvnEYA2PlYfrl5AUxuEzVeBLggkSREdW45fR4VdUOsvYdl4orXRK8
         Y7RHm19hzKhX9JxWquulQkN1dTmvcwHuDuhme8DDriwjGNKWO19CyIf14I36iqS7/JvO
         JV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353846; x=1783958646;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bU/6iPyibPDENzeGgAeBM6ROU1FMgoMSU+p7ppEeK0=;
        b=g+hMZMRknLlvY/r54gSZE6MwCoIQxVL9poh3RhaboddcHdEonymyaw8fsOyGzaaWiC
         saHt0oLAkILYjK0L9XxJw02wck5+4NrXwpT42I3BmaTWr2m3V7gRVRQvRZTjmTt7Kyzf
         x+JeoOJ7U/WBMRAGV9PyvmioleQJp0coUMYKXuyg+d4v8Ak/BIUmHvD3PixoxWVXPbZ8
         ZZ6aD8NLBkCVy7UrALRzcsItBlZWafRTw8dXCBVC4YwvkKHf/2GZaX/bi/oqUvE+YXjJ
         VB9PXfMGVlNaI5UpeInzSeEXXmZkASd3e+pqSfgWYQIX76cudZCXGn7bz0klYurVNEg0
         Rkpg==
X-Forwarded-Encrypted: i=1; AHgh+RoAfzMoDN2Yi14rOSmkOUrwiiTG2dx6/W+1N3UMCZY1HKLmymP8RBalos2hXUX67dy0imk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpMWdoODuKfQJjO0VCQcVJGW4lHzo1ZXUx1Wj3qAV2cLUajjt
	b7hKTldpjnB3VUkVZnYiI9GEPo0V12VjkZXf45mIrYVBJkPTmUkp9jqtpcYxF+sw7/A=
X-Gm-Gg: AfdE7cmYi6AmGA/YAXa8wSk9PG0y5RPEdHBhR153x/phrOP8qxied4PCsAOFib+TmgR
	fkDNxiNYiXO5blM2ZQMf5v7jW8GITMJLqUdaa48yhcjJw0KPhMA5PP5tV3jVFUqgD/0e7jVGZuy
	GluwJChMVsZ5ONJzcWQGQsBbBXf07OO4PLbsafoA7ZRa+el5QBet5lX3dUVoqP0WF97PbOvBNLe
	JVg4Jh2vn5GrkTXNtSjYCPjSlaXtQFwOOxblZO0DKCFYbkp6SWgjQ/jSpo3wehA1VVxZlNxqLCf
	mx0GnedQkq1tmvBe+tAxS/9Ll2YMXPNn9X/plNpufkj/KBJV1nYs2W4W89ok64BbpJEtU8g0qlt
	uVYjO3m/DBvA2RysL/LTDPrtDTRqmLeLJAuXlrgSw/DqisBuERlsWjFTEhG/klEMFFra8ScHWIn
	E9ovhDfY8M3obNYg==
X-Received: by 2002:a17:903:19cf:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2ccbe611af8mr13889635ad.16.1783353846456;
        Mon, 06 Jul 2026 09:04:06 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:4f71:1131:e194:34df:ee9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad77651c2sm53854365ad.49.2026.07.06.09.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 12:04:04 -0400
Message-Id: <DJRM6DY3TW3X.1OJSVM8VW21B4@etsalapatis.com>
To: "Malaya Kumar Rout" <malayarout91@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah
 Khan" <shuah@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/bpf: Fix memory leak in msg_alloc_iov
 error path
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <7f3e0f9992a32264f6c7cf00f2ef3ce87a0a6fbd6703084aff3de68cda77dc9c@mail.kernel.org> <20260704122936.102394-1-malayarout91@gmail.com>
In-Reply-To: <20260704122936.102394-1-malayarout91@gmail.com>

On Sat Jul 4, 2026 at 8:29 AM EDT, Malaya Kumar Rout wrote:
> In msg_alloc_iov(), when calloc() fails for an individual iov_base
> allocation, the error path frees all previously allocated iov_base
> entries but fails to free the iov array itself that was allocated
> with calloc() at the beginning of the function. This results in a
> memory leak of the iov array.
>
> Add free(iov) in the unwind_iov error path to ensure proper cleanup
> of all allocated memory.
>
> Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/s=
elftests/bpf/test_sockmap.c
> index ac814eb63edb..3e6be455d158 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -436,6 +436,7 @@ static int msg_alloc_iov(struct msghdr *msg,
>  unwind_iov:
>  	for (i--; i >=3D 0 ; i--)
>  		free(msg->msg_iov[i].iov_base);
> +	free(iov);
>  	return -ENOMEM;
>  }
> =20

