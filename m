Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E234E761
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732872; cv=none; b=S6GItrtxmDpswToK+GH2y/fa36YsRE0Y82Osqh2lhZQI1J/NNRpLDxqGMv23qxk1tK2kZbWRTh/hExhGiH624uRTykWyKuc0NPqSAGvZ6k4f6BYNqKHHgDT329xTUskNVVe2Ny90K8bnrVynBY49DtDfgTS0Z72UzAhp5bh6oFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732872; c=relaxed/simple;
	bh=BpnA4XhIs5UtiDPdG52EaxYTy5pKl/uv/3Nd4jsFLsg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=m9U7/LbzVsly/O4kNtPOOznQQxcQvKNa/TemCWQmWmHZdeLfLc68ER5WB/CDqhntj9XM9gMt/Km7RpZzr/Twhe8YtalG+kgrgTK0Zq9BoF7Fp9YpgTXTZBQV6B54caRXeaLwrVkAjwrpuFl7ItxhuH78gv38C7uStjpSAplqnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Wucafnwi; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Wucafnwi"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-303dbfbec77so11376502eec.0
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779732870; x=1780337670; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvdS4aX6gI9MEHBOaVRe7PnOJQUK7bdoDGLJ+oujsnM=;
        b=WucafnwiipiBAy5KX0BdL2AdnNPnISex7+VEW33G3dXeGfJA2DsHD1MVyTcYK6qqLw
         iavzrrch2ugkzgMzqDSrjIq8RskX43kbi7OUF/4grLXNtdDkiiU4Crjk7y2hWtESP6Og
         8+gGISm7s75Pq76puDwTa8vUBsBPuT26/OGdU4dvRqq98Z3DZqZdAuD9z1p+xtFRnWho
         KcjFK6gLsCa7uc1TFD15g52RgEeTsSIeHdTkoZSal5s4gppWAaoGWJqKu/9YcZbrHQEl
         rHC5S/+CF6HP2C5giuNVPCijYsMjIWPa/2EC2R4JEiq0sLt9hjdHl4N/s7biSKODDKGq
         FcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779732870; x=1780337670;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvdS4aX6gI9MEHBOaVRe7PnOJQUK7bdoDGLJ+oujsnM=;
        b=dYt0fvOczvT0/+BvgEciT2dF4IgoTdg0Iuv8xiikLswH0G7vhKOpPQd1Lor0kg+5Co
         G2c9krS5Ao0JDz6ldQ7LNE4b4YGXvmI2Ip8HwNA+B9XpiEpgFOY3lX1kdIrQTVnLfWIY
         EXptKSrVSAHCrG9a9anSNohy0oixqE+9tmUnN6w5fFgPOikAfS3WJUcOjlifotGztex5
         6OBTSpFwMsK+4aKCZw9pilF39hw5QTgLzALUs9/DtC0NegTK3Kqkne9md+UqW1GPkSBX
         2QOTq/mBlIOxTil/z1gYtTeBU4m7B0u7MpzM8c5JPqnNPEOJ7B1KyieP5MstB6iuYTa6
         UjVg==
X-Forwarded-Encrypted: i=1; AFNElJ8cNKOkfVv1f5trVHVFXlSxGMQ5fCYQ1cPQZS0oOEMsckXckp/kBr40jHZy15kekRT7FZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymvww8IU91gpLk8o49iuaBI5ewmSjBeqWY9IXSPHWB2Nt1mYNK
	YvrZnbU+3D/yS7NUtedjbTwf1vLqAH5GwxW9ZtFgCKiFbGNZ3q2OsclkjdMcudTjPg0=
X-Gm-Gg: Acq92OGVRPJC6fewHCz0ex5oE+vcSXSQJ55kH6PJ5uOO3oPHZCk2wgpnnSyWLMPjB88
	34pcuv3XMVMg0DPyqdL6Ejs4LDkE0vMTKC7pJP0TPC0ySFOdhfsYx27p0gPTIEx/BlgoiZdgBdv
	frci4M8hxsI4L3hr+AcOeWBslUUkm772szk7LSMdmPrQ/bYEYVvwrlZD/cmTweBE9+n6cXLkOSj
	kTEOtY7F3FWfAFVHbGbGoA/4a5RJvc3pDD/pZMa4VbfKsW62JsFhbbUOyJIkRmTLumnj4KAJ5wS
	scV2+1KGz2nhXHL1qPpd8YnshCDOcd3DtHtsi2HpgiTpobQOOcIiZWqH2vCUd8B35rEOx4RtE4o
	hQsxbWjz78c1AKD+BAF+Ws8rleUcmhimqT+e0bLn3zn1y6w9T2wRBHIV16NX/2Ne2mb/C2tEHQr
	oJfsDWMuHhvOzeJA==
X-Received: by 2002:a05:7300:8b14:b0:304:8361:a87e with SMTP id 5a478bee46e88-3048361afcdmr2512662eec.33.1779732869747;
        Mon, 25 May 2026 11:14:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cc2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef470dsm8466985eec.4.2026.05.25.11.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 11:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:14:27 -0400
Message-Id: <DIRYNC29TMEZ.2YIXO06OYS53W@etsalapatis.com>
Subject: Re: [PATCH v2] bpf: replace pop/push emptiness check with
 bpf_list_empty()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@linux.dev>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260524025853.13786-1-suchitkarunakaran@gmail.com>

On Sat May 23, 2026 at 10:58 PM EDT, Suchit Karunakaran wrote:
> Simplify fq_flows_is_empty() by replacing the pop/push based emptiness
> check with a direct call to bpf_list_empty().
> This avoids unnecessary list mutation and simplifies the code while
> preserving correctness.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> Changes since v1:
> - Removed unused variable node

Saw v1 before v2:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/tes=
ting/selftests/bpf/progs/bpf_qdisc_fq.c
> index 1a3233a275c7..8107f5934d2d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -196,18 +196,13 @@ fq_flows_remove_front(struct bpf_list_head *head, s=
truct bpf_spin_lock *lock,
>  static bool
>  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock=
)
>  {
> -	struct bpf_list_node *node;
> +	bool empty;
> =20
>  	bpf_spin_lock(lock);
> -	node =3D bpf_list_pop_front(head);
> -	if (node) {
> -		bpf_list_push_front(head, node);
> -		bpf_spin_unlock(lock);
> -		return false;
> -	}
> +	empty =3D bpf_list_empty(head);
>  	bpf_spin_unlock(lock);
> =20
> -	return true;
> +	return empty;
>  }
> =20
>  /* flow->age is used to denote the state of the flow (not-detached, deta=
ched, throttled)

