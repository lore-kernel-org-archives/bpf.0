Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FB3B4404
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772377; cv=none; b=XeBNitG+CXFNeaAcMLrZIuxeEoC0E8secaLCVArkKzkEIgHcIL/fd7m5VlwLsC3auiEgfmlajU5+Z3mfkQXPrlOhCTXVb13TULx0mKhju6ysenO4YQiVdaTRnyvGuyCcAyGIClDsBBSeyFhygNR3WzdLYY5ajPYx5OtrdyHZnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772377; c=relaxed/simple;
	bh=ZkO6pGqCkfZqy3u/oU51uk/j3lT62505mW0fThy9hk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNajTvYoiTd598n8DY2AEE2Hm00tioF0UgOX+O2Eq/QTSHxhvqtuwkBKaP4eMVnCXBkS8mY5bTGrDOc7Xwu2ti+pePgMwvTTpNeEeezAt2Kjl82D6CVs/WhSP2QGsFOOXsmh0n6Fjay6y0zHoI+WYwEJW/gEnpeY6Ikd7b2CkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPQhdo49; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPQhdo49"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4629d80fa08so684407f8f.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781772374; x=1782377174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PGCTCQszIeeChHhQclIvtZO9APdlhqX7ENI5kXXs3o=;
        b=kPQhdo49O+yBje7dRhYtDtHt4mCyMKrFOBAd15Qovc/SviFiJm4TKN+LmQiRyh4JqN
         hyuCSZBO2MEUlMYVnLqBOOYzjuph6m50697h0zjDRx+qgFZB+HEp1jRfKsB+Gz9poVs9
         pzioYQiWuLcIVIHrLu6PqaUu8P3/Vk5ZYlGQOEbPqDFxQdGqV0p/vxClW3OZmZYsDQpW
         HQ49OyS9Eku0Z92Fot9TDvBC6KAy9skjsFuZx8y+eVHpF7krlHoNuc1kLNUyjVde21cc
         qXt5wzsKWTaabaEvJUjIR46xsAMvtyFJPHAjzvdq67c/s1EeqzXiucNBaTqFsrjAxU48
         9niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772374; x=1782377174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PGCTCQszIeeChHhQclIvtZO9APdlhqX7ENI5kXXs3o=;
        b=Q19Q4TVuxAqoO9lViawivvf/pGS+fEGK63rmvtHrOn8p+vRL0dcQeuUE3FCD2NUnXJ
         Nnpj9cB6I0uO5GLWF7aYro5jtpmMJIhj5hDNM71bQ/2FunxLAaB3PSxEtYa0m3py86dB
         /RjV4pC1KPiI9+8pOMPoCeUOaBIZKqdYqKFTGB/m2HTJC2H0aDrvamFbp+qh76rDyTQh
         U6ywUYCGNV45Z0uJ3nQk/aMRPgXlXQKxaPumljIxZUdAWECJRKXJS4PAVeCROE/1ki1w
         uaAnz+KQ+QW6FvbwLREQVuiJlksz+dSs+wTGsPqeMbvd65JEtA4BRsugARIf/T9fY1ps
         EdzQ==
X-Gm-Message-State: AOJu0YwL2w5O0DBcKBmtTCq2gZxNURJVxmuPnm95ZawJAQ+zXDyqlBJL
	9EsvHtkv1E7zcqmh9sIIk3Ne3AyFs5OE+ZIo50En3inPI3Fm1hSeGgVz
X-Gm-Gg: Acq92OE906DySOrP0wujnpvWxwQSZQx1cu4+RmiN48dY2JmqYrRgouQUIO4BTfhcO9L
	+nPibyiFqYlEBJFzPLC4zWP9nL6qV6g/9apFbKwJprp2nhgJfS399msTmiUAuOaKoCtHp+nlk3R
	TNiToNXEp6Adx8UUXza+qSP4ImnS7Lm5slsS3cLCPEvgb/MzdgWQR48/FczXNe5PTQycoj573PU
	AVFdqiyk/stUaCdZzGoF33au0ofqxXhS7p5D6+8hxrkudqG5V5KSWarHK08lbDY09c/T9v1Dln3
	tM2zLE6YTrCVKAeJp0DdwL6I6RNl5+y9sX0AIhOPDL7MwwKVvleyfIF5NOfwGE3kBapDKfhPYju
	TfXTAd9n4PDAIBFnUnRoASX+jbmrTyoUQqZ+2N7PVwML46AIE35E8QjTM7h5+EhfmMxn+E35am+
	WVhz0lCy1B2AZ/YAtuJI6laoGz9zuyCAXAIf6M36742i9LzBHQnY50YC1eN3aQo1cse82kqjSOk
	rnndn1xsUxb6Uu+6Rp4i+tbub0zWAhcWejh9cCUIjGOPCpvUnSzg/j8Qs6XUmcTi68Wqz4FxXc6
	sD9KQt9pc1BY0ua58n5699CaalxIg0mHPxfFGM2FbYE=
X-Received: by 2002:a05:600c:8189:b0:492:32a0:7f92 with SMTP id 5b1f17b1804b1-492333aabe8mr126392015e9.12.1781772374045;
        Thu, 18 Jun 2026 01:46:14 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006e99796483dfbc0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6e99:7964:83df:bc0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm255435305e9.12.2026.06.18.01.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:46:13 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:46:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix partial copy of non-linear test_run
 output
Message-ID: <ajOwU4ak1qWlAaYu@mail.gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
 <20260617093557.63880-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617093557.63880-2-sun.jian.kdev@gmail.com>

On Wed, Jun 17, 2026 at 05:35:56PM +0800, Sun Jian wrote:
> For non-linear test_run output, bpf_test_finish() derives the linear
> data copy length from copy_size - frag_size. This only matches the
> linear data length when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.
> 
> Compute the linear data length from the packet layout instead, and clamp
> the linear copy length to copy_size. This preserves the expected
> partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
> in data_out, and report the full packet length through data_size_out.
> 
> Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..f15c613aaa4e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,12 +453,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
>  	}
>  
>  	if (data_out) {
> -		int len = sinfo ? copy_size - frag_size : copy_size;
> -
> -		if (len < 0) {
> -			err = -ENOSPC;
> -			goto out;
> -		}
> +		u32 head_len = size - frag_size;
> +		u32 len = min(copy_size, head_len);
>  
>  		if (copy_to_user(data_out, data, len))
>  			goto out;

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

