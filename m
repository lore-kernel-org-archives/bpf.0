Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CD33F8B1
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744093; cv=none; b=n0Ic9TCxuAngSplHW6c8t270NNWAtJWLgxwOT+1zGDDq426xSPMmneilKiaT5KIQrx258x3J6LvHwC92p1VQNxln7tOYiCJIA4P5IybanRPGdENRZoqZr5IRc6tjbGhD4ZZQlry+l2C57IyJ6yt1IzTs5MVX3U+960CJEX1zFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744093; c=relaxed/simple;
	bh=zHzEWvVVUK0/atuWyJxStUEbBTisvKjQ12HWEKd3EkE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NGFZRi/ZzWOgq8dySGmFe8B+GnYTRA/rL9bEL/AgB/x/KQLmSTl1N/h+2fTnVPYEJ50/g0c52nzE6+DDAmuvNe2JZ75w/HzlFqeYOJLk/o5YXzgqyDcu+mbvsitSRN7NejwDNaB7mXJ5zDQevfyF4IGmyP9Fa3ZKPEScNCR5rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fSSs57Vs; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fSSs57Vs"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a133cdd4aso37203786d6.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772744091; x=1773348891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kib/7zHAO5+r1lmTTwpxPfUsZvrEMGIOGbASL0EVpw=;
        b=fSSs57VsUvZr9eLVl0+dvVxkvYL5Sg5uuj+dP11i8C0uO+6WI5q6W9sWCWjXhJ/EYF
         1aCWzo8tmi/HLkUxpOsDse65duBLJvF3IP8g77r3sYYo9T3Ki9GIYQ0/MpEJCOSbOtI1
         Naus9GiuieSG0PPCE4YH/CwDdcE91vQfGaJ700kKkzS3Bpku6I3pMaymlHeXfKQb+5rj
         zj8UxLpngVhpHhlEWetHqzk1iDZn2kyTW9m8HKT02TmJeI4QE88F9RpckerZr3kJg3Ve
         L8gZSnstmzAN0+XyZ5lwK2DzXfV6S46M+v4OiTYvt1pZ2BPq/FZwf4o7sKUexA0VPZDZ
         uMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772744091; x=1773348891;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kib/7zHAO5+r1lmTTwpxPfUsZvrEMGIOGbASL0EVpw=;
        b=ciDEaqFl1j7+DSLjJCWwhf1fIJz/bIyk9JCNVvaHFRVGFOcs9KzbVtfoe6sq28R8rx
         opqweT5Z9GiJEnZjqBNfASfr0LwV3z2QT0MfuNtFjwK89fYG0hoatP7iui9Iu5hlHYz7
         EPADxaaMjzlV7XArPSkEi2eXVU1Qh1LvdbWGUVZF4xNcy2pWftFGALQu5v5oiWHqkGIZ
         pWHLdaXB/mLy+/7WN5X1a4uXpnzecLVNLblPNJh85UQK2e+1AKJXNtiqO6JpX3C51H0u
         kD0/noWRw64c95M2Qn3OcLh0aRkMYJmptSQGr3OtHYHuGI/ojgsUM8fd6y4lTp5CQRc5
         /vHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdIQ2uvRZQh2rpw0SBW8WLp6OUHv7s6ShE4a+02hFP8z9qwpAVn+VjAKqcO1KyRa2snhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPW1S/B6QYDp/n59koDgbwZ7lJjNzm5LQyUSZP+Yb8xhsuFFx
	gPfD18QITz6tToSu6L9DbAIN3AuOQkp9Zu1j3jNPeoJmcFrlKysHPYs7LkdUj8nXO9E=
X-Gm-Gg: ATEYQzzwDiV5i6EwJOV9s+t1Eycm4Sc+O4mMunUDbhGndm1VyjCYZ/+7yteo2NmVuj+
	aIgcUhgspfNzbw21i+JuX26K0SItdasZczlGCpRQTDTJoZCMWVWqSm1LoT0BqqlfZRNmeGvBn9b
	RlgKqhVZGEoHr/9vu/dco/Xyq940ccz9jpMnYKLMako0G5Y+oN6ncjtgUhMxuiCscPLQe2CFQsu
	T777MEsjhGgxDgNE1AUA8grYwo5HDF6EMNZl+MLHB6HNl52aA9LyhlN17r3okS7ZaC/9imCePcn
	pJBgdHdWEd3qOXcovUGuOHONX5/0goFE1AQk0bZPc7k9LB57eIZilojjorIv5YqJtwKI0OwJ6qP
	tCMx5BJkXZGhFvq2M+99Ry7vn0/XDwIXRIzmUuGm0ZcrBo48ZvpbcKOcUzw2802vuxy4JFdREZv
	i0NwIRtCMG5jBtDchAaxfdh/0=
X-Received: by 2002:a05:6214:d87:b0:89a:870:2e9c with SMTP id 6a1803df08f44-89a1998c283mr105301936d6.6.1772744090762;
        Thu, 05 Mar 2026 12:54:50 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ef69b089sm120684706d6.46.2026.03.05.12.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:54:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 15:54:48 -0500
Message-Id: <DGV5BZQ0RW52.110TQROC2BV5U@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <arighi@nvidia.com>, <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
X-Mailer: aerc 0.20.1
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
 <110810cc8533bf8569d0226ab5f5735851d1fad9.camel@gmail.com>
In-Reply-To: <110810cc8533bf8569d0226ab5f5735851d1fad9.camel@gmail.com>

On Thu Mar 5, 2026 at 2:54 PM EST, Eduard Zingerman wrote:
> On Thu, 2026-03-05 at 11:48 -0800, Eduard Zingerman wrote:
>> Two test cases for signed/unsigned 32-bit bounds refinement
>> when s32 range crosses the sign boundary:
>> - s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
>>   s32 range tail before sign boundary overlaps with u32 range.
>> - s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
>>   s32 range head after the sign boundary overlaps with u32 range.
>>=20
>> This covers both branches added in the __reg32_deduce_bounds().
>>=20
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>
> I did not copy the reviewed-by tag from Emil from v1:
>
> "Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>"
>
> Sorry...

No worries :) I can add it again on the v2.
