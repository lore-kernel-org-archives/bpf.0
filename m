Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250432;
	b=0u2IgGth1liHqioOgbuVUSWiDqs9JV4RuwIbragI3FmGHtGLjqjxvx5BFu6QRqAumr+5
	 jPWLiZNDy6HJ+eRwiNZMHoSIenUva0sBmbPMF6w9PfweOkfMrBYBQQ6R1SfSW4s7WOfg8
	 +BGqGHA8U9taMVNmPZsZu23AQtOZxNFyYg6e1/Cltn5zwhjggEHb70H4yrFyCaCJthFKw
	 xFcbOo19hDtnWMLMnKVutW5AObfYv9mKoC/MKvlrqapNXWatbVwuJJgfm9vYgvcz+WCqX
	 YSZfGCO8i3wSMj0kT2phdgThHc+VMQVf1FBZNBBWf7c00mMk0aEcbCo50gtlj+8HMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=80cmEy5EJnrhtr5kg0iasxnfCalwVR0GuYGpWzI/iqI=;
	b=4YbIwQTr2Hky01Exw6D3QobW9QobUamTcMOBU6j7Ky3bnjQ4WweG5BRYWPDcPQmEGRFy
	 9o+8p4Pgzyl0QwZIfO2PMVZs0P7kTSGFhym5IPL+92MdqL4uKpnkOyrMmjzHfn6JkAf3h
	 8Z2DJtN7RIlk4nEhkCdxYhKQbS+sU01u6OMHhEO+kfX4RZIinkxmTiZI0FUTRhQeUowjZ
	 YRe8yFp8NFwzpfMn5LpeHE42WMFYAAu7STZaCx64BHUUnpz0QkN203PTSNRfcO1ChMufy
	 w49RPgn+ZOAfJ6Ue/GV/gCLjt6ZEEKZqfiOqNYHWUPdG4uxB4CpbZ3/i07nDzl3i1/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRCYdPNS;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4298606A326
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4298606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRCYdPNS
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2403861eec.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794250431; x=1794855231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80cmEy5EJnrhtr5kg0iasxnfCalwVR0GuYGpWzI/iqI=;
        b=yRCYdPNS+IvYOA7gTO54RmPLdE/OaAVWHZo5ZJ0g4dpEQ+Tu1Ancuv56seUgIci3yX
         NnKYJcySnueyMpgY9OQhAPfqg2KTGKr9rp4O6EXDDi0zcowdymDTwn35hVWivgOauUN/
         rMI3eXManK5wV+CaS9Kx1g4T0e/xObB2htmJJT1iDJXq/VcZ5y+Az0Wunq2/e+tnNrVr
         QUCBC+VzQFusc21SK3+8T+5hLo3l1IY2zPOsVwvs1zka4f3f7gQapMFpsIGJuIlgBzaH
         Flhk41E7aQv0M85qV/t7ZsWmcNiVWslGJjK6RYUdt7jG2bituqChbXq12LQJo1wzqiu4
         +IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250431; x=1794855231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80cmEy5EJnrhtr5kg0iasxnfCalwVR0GuYGpWzI/iqI=;
        b=rx0cLiKUFlJVFczjVynSrgUabZU/pWHDd12hmhe8lYtBOFUhhejq5JZW3IeFTYUuI4
         1I7lnFgOnRTYTtD/dMKiXhsFNdzyz/X2FTZ3o31o08isJZbGNZtvpIJLyUBskeO1rsF5
         G+DikWgMbjB4iqBfYNTMaTvyzJWhf7mrJ//xJ5ry4l6ZmnBCB85f8eqCeZTm3iOSMqIy
         KAW7GZw3U1RgEG1ABboVeGrG4H+C9WOf0qS97NNi41mLprjsgGjiqy11vYCut83mWTBf
         wvMCiaQFcURJgVHVLZ0eeXrG2Qgx9qFeNijdsuZKmak8H4yh/ay1c+NAzmbSMPnfav72
         JVeA==
X-Forwarded-Encrypted: i=1; AL+hErGZ0STa2+OEWlLEE9PfWaJTGATkID+Bim+J5jzrf4WvyPBiRsq1l0hC9LKqyqW2UWT+IGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TTkCE5YHM0Va7jYHzkemoUa46+YI/3RyX1fcI1wJlG+e/9Yi/
	pTjV4+9Cgjbs0QPq7EKQPvKuOH8Bz0d1HSO3rUMGjMJF0pbbVhmjrlHJ
X-Gm-Gg: AYBFou0Of9yyZ9Yg+E0PSh70Zb8cJvFzp/H4kF+Igj+lcQ5Y601qSZqMLZUiSugLmJo
	44WFkG2Ow1kLvbAzgWEyoYWozH0a2gt2jfHFvlpyWAMai3OuGShp3+7fkmEqR1MS5mEUqwyxYLB
	VawVj0lQCgynUqQtM0Z4r24H5PQGjIZ+XQR+jISfAaRuuDNvfa/7U1dDP/GDvgJSFRkjN9qg32N
	x2wS5mm+6ascW79xTFeaTryVeOBOTxAwj78OEgUXpeo2XUo4EhpudguYuaboMgQ/T5T+hO26kYV
	65fPalHekUgHUN5O3Pkjll4kb5xSiuYrW+N/hZPJ6WaVpGZ/3ea6+4dLAKUgo11jLWj+J9QwI6y
	IC5VrpmlhHkRr6crNDghHIs1jU88dIuIlROB12/DMmVpes+XG88Fq5XSgStQGA7weNY25Hg3N1p
	/x1YnLcKft/I3GmTY5hCwbNhtcSaLdLD9/AlIZJuzCiVzi3EBbJicUWn+lXzgmFLvM/A3SWqe4B
	jgaR5v1kZUHCX4HPZDJiC5D9q80WbEvBm5jEusmP+UYWTcuFI0fyJDst3EQcmme40//6kseR3Ul
	ERsLPsi2R4/6dhzBVOSr4FyT7449wPocz7TevMfTBoAN35yR5dwGwugeL3rtPFBUTRHLnEI4RYp
	TBxy97zVR31Q=
X-Received: by 2002:a05:7300:7f21:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-3751f55f6f7mr163325eec.22.1794250430709;
        Mon, 09 Nov 2026 10:53:50 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:b155:8c68:f317:3997? ([2620:10d:c093:600::1:93d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe07dsm215259eec.20.2026.11.09.10.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:53:50 -0800 (PST)
Message-ID: <85e164aa-7aa7-40ed-bfaf-883b8f51f7b2@gmail.com>
Date: Mon, 9 Nov 2026 18:53:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Report lost RHASH batch traversal keys as
 EAGAIN
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1794056839.git.hi@tychen.cc>
 <4c32437eee7649fbd822108278a3f582bb795329.1794056839.git.hi@tychen.cc>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <4c32437eee7649fbd822108278a3f582bb795329.1794056839.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/26 1:11 PM, Tianyi Chen wrote:
> If a key is deleted after a batch copies it, rhashtable_next_key()
> returns ERR_PTR(-ENOENT). The batch code treats the missing next cursor
> as end-of-iteration and returns -ENOENT with a partial batch, so callers
> can silently stop before reading keys that are still present.
> 
> Translate a lost traversal key to -EAGAIN, as for a missing input cursor,
> and preserve other iterator errors. Still copy the collected entries and
> update the count, including for lookup-and-delete batches.
> 
> Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
> Link: https://github.com/kernel-patches/bpf/pull/14700#issuecomment-6641291019
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
Looks correct: transform -ENOENT returned from rhashtable_next_key() to
-EAGAIN indicating loss of cursor.
rhashtable_next_key() returns NULL when iteration is exhausted, that
is transformed to -ENOENT in if (!has_next_cursor)

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/hashtab.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6e2115477cb9..346a2afb4ad3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3556,14 +3556,15 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>  
>  	rcu_read_unlock();
>  
> -	if (total == 0) {
> +	if (IS_ERR(elem)) {
> +		ret = PTR_ERR(elem);
> +		if (ret == -ENOENT)
> +			ret = -EAGAIN;
> +	} else if (!has_next_cursor) {
>  		ret = -ENOENT;
> -		goto free;
>  	}
> -
> -	/* No more elements after this batch. */
> -	if (!has_next_cursor)
> -		ret = -ENOENT;
> +	if (!total)
> +		goto free;
>  
>  	if (copy_to_user(ukeys, keys, (size_t)total * key_size) ||
>  	    copy_to_user(uvalues, values, (size_t)total * value_size) ||

