Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833B3F485C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530774; cv=none; b=XFR63OBPQ9eZuNi6qRiaAS9M+lGpmKo/1326Dty+MCFh9VwwPyta9n0U6ga97NC1cuH4oSDXB8+6nkrUFFiVU46w309UwTlLFfQ/iHOVcHrgOJ6+Qg+I8h0QJ9D62O3MujKwgJxGyCHcM+iS2chGNyp8WiHE9yLO9++aAUcK19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530774; c=relaxed/simple;
	bh=Uken4tM4LxzRAW3DPWFxQEaIbrL9f7E0s+GyqkDZQbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyVDFayI6PsCqgCx6XcmXaIYjdpM0YDl8Ygg+91k0RlSA1Jc0C58irWPEQ70BxIISBlBGasmMYxp7aLKaVszX1BC+s8ncPFQzq4TyLj1YrX02aX3CpA7hLEqfn3KfXtxeyDzOZ3UD8Z1J1cwEQV0Dt52+XAAo0SRtjI1rjcFMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdt3nHF5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdt3nHF5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1885900f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781530771; x=1782135571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crU/YWEeXaonCN7cJRF0MeFCZ4XnzfssYJGTp4fDCnc=;
        b=Bdt3nHF5hGSg8d0r7B0cj2jqsYQBSlO+7FeZSaKD4H0o3EaOuzFqDclquYq18IBYbY
         VUoAE+YdasM9jcPJTvIDc5Iy5VWYV2nMeNR7FjQfqDHnruNZBr2Ya48ojvyBgX9s124a
         BgHIGRQjgc8ZwVkQ7+j7Hfmb6cD5aCaenutKjBOXigMVdpwoyzrgMsBE2NV5lHCcIzki
         1/H7d1u2WBGx7UomjC/6hKaH/cCJ33Avsg0sIWcyqyd6KhuOShJJijcv9f+eUoU+x9VI
         eNlAqLHFaoPwsyOXb4JQgqrmPB1Kxia38QoNreaep5IK3JptMrdroDJqJQorkyIxk97h
         vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781530771; x=1782135571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crU/YWEeXaonCN7cJRF0MeFCZ4XnzfssYJGTp4fDCnc=;
        b=DhdGvENrBAu4CddkbPS1h+CI9LYf4/i7h+BmZkolD8H3PzEb6ezymgJ7hG8dh4kFbY
         UEBhRVuQtivFM93roH80kqNYT7Iko1zOK4Xtl51pQG0cFpSZ0OHKJBk3tB36eRxRzFji
         GP71EO1P5l178xDVWU0Ge4OFHauf977uBWLWxL5j5rUw5zuMlLTH7/zpz4+YwITroQoD
         ybbHY2SOi9fubtmOTQjnryEmUzqhKloMsMi8HF4wV6dK5RxVDtE0NzNLTsUp0YMos2SH
         JCjWH+j3XBAmsT6A1304XEf+5k9JIA/IsCN88RPEANq1cW+WOtOXHgVk/VBpqbT2uQzI
         9xtQ==
X-Gm-Message-State: AOJu0YzEfIlpItJI4SGrpQzwBRUgs7NZjqBV8SnYmBCD3eBfpSnKqpG5
	4ANf3x04PD4J/xctZYpenSqkVXbu0SDaXIJm3Tcu4Z/7/QuB3BtIgH0H
X-Gm-Gg: Acq92OEH0Re13lPJD3LAXi/wn0P65M7gUISoCTNvYNgnUXobxLlLWA59e333gcC1zv8
	9EqCymyR9yBpWYJL3n7hE4EJxuXWxml4TStnz0ym8uL8LPRpfF8oY6ro7zYlK8Q3tFgBy5VT0nK
	PUsY2TEc11Tgpgow4JJ8gUaw8+U0/7UESHEKfCGkBq5nXGzU8VX3pUTVc27mrlECYb0ORuGGJA9
	fdQjgmhISCh3VoquN0UkbGeBJemxnGsOTm1i34OEITm+EjXzW2ezNUl9etibE2ELpIcyXLdV6dU
	/BJJXubN4VWs38QrjIQZHwoWZtG8JKolW3BOY2oEccO8P45AXx11t4wH+i83OcAbS33R12p0hj2
	CregWdZFp3rh2MaLLH9gP929jlZ5Ua3AQstm1BaDlrzmj57vd+SzMCR//ad1kRXbPYzr6pUp8my
	iEkq0257458gqIQ9/HNdl9S9PPuhHNZLTKC5OO3vVpFfSHL/ybImSLiHDkCBZBtVJLuV+6j9E6V
	ZiPAe6LVrQEqnU8B9lIbV1poq6aPfIDHt5pZe7i8Xt5wROjl3HAkBB67qAXFrRugjK9OqLyBHdu
	YYxW+JAJ9MrG2PPXtVkXts8Ow3iiqwYC3wYeRFNwy+U=
X-Received: by 2002:a5d:5d81:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4606da622ffmr21403888f8f.18.1781530771203;
        Mon, 15 Jun 2026 06:39:31 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm35148433f8f.8.2026.06.15.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 06:39:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:39:28 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run
 output
Message-ID: <ajAAkIv0R3ztfc5g@mail.gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615073856.152479-2-sun.jian.kdev@gmail.com>

On Mon, Jun 15, 2026 at 03:38:55PM +0800, Sun Jian wrote:
> For non-linear skbs, bpf_test_finish() derives the linear head copy
> length from copy_size - frag_size. This only matches the skb head length
> when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.

Thanks for fixing this!

> 
> Compute the linear head length from the skb layout instead, and clamp the
> head copy length to copy_size. This preserves the expected partial-copy
> semantics: return -ENOSPC, copy the packet prefix that fits in data_out,
> and report the full packet length through data_size_out.
> 
> Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")

Wouldn't this bug actually go back to 7855e0db150ad ("bpf: test_run:
add xdp_shared_info pointer in bpf_test_finish signature") and also
affect the XDP bpf_prog_test_run_xdp()? If so, could you also add a
selftest that covers it for XDP?

> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..976e8fa31bc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
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
>  
>  		if (sinfo) {
> -			int i, offset = len;
> +			u32 offset = len;
>  			u32 data_len;
> +			int i;
>  
>  			for (i = 0; i < sinfo->nr_frags; i++) {
>  				skb_frag_t *frag = &sinfo->frags[i];
> -- 
> 2.43.0
> 
