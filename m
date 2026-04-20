Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C23C455C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713677; cv=none; b=MKUdWtf2dfeY2V9VcWTBZdk0Vozlf/+fg/wZ92A0YjuoZY8EjnXWSlphg3wGoOF4J+meTqO8hnLo+9QBgIBNO/E/POlday7wj9bH3Pj0OBUE0hbODDgh/YV9duA/x3+Mzz3nIevalgJRaGbp7Ocowku9OQLqerAXfnylwyaQ21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713677; c=relaxed/simple;
	bh=4AcxTXrP07xw5t1hnLLLV3ffxLb6Xd2Pby+ubT65AL0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=gVTPsnyyowjQroFIXgssHyoUjBhfDT7VwTP4vAbIj+Q/Gy1T7j3xGhqGnFVkuJRYfLH1kXH7wGI9cDYALsc3JS2TYRv8CM3TtCtKr1yJGlCQEtEae7AIk8qPjaHmjPKh84JOaHRON3mw9KnrjZXzGTfeC2ICqwPczk61M3wfsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXBYKr80; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXBYKr80"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2065682fac.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713675; x=1777318475; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vr6bqKSRSVsDkD+G7UTApJEY1Dv37sU6YEle/+qubhw=;
        b=GXBYKr80AmJU+6iBnr31r6oQFVSE8X+fHwDuxQQTZOf74hSZRGR5uoGCFBYuImckSx
         9WRet7ciI9u+ifJq48RXbfT2oruCChMM89XWt3QkBtluby7MCexp+XWjLmaCFhKeug7M
         yN2GQ3ZYStI4hO6iHFdbEzNaMRCfsLho1MWgOO9CTVn1hGLFlFtaop2CxszxrznNMX7m
         vbwXRgGVI3t2ylfWGcBztzoXi6/X8cgi3L5GHinRghxOiPIh4mYatCME+XhiS2YSpOcD
         0v+/wmjeN4uhj08jZDUEVFpAtvZRAOd7CY6ppDCigCv9wHwFElVi2zhn/yRCC/rG/bz5
         WJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713675; x=1777318475;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr6bqKSRSVsDkD+G7UTApJEY1Dv37sU6YEle/+qubhw=;
        b=XIyZEpI84YWxUPn0rVLJPXaVxi5DcEatPbbQ7U3qgrgDlfXDUPzxWuMWDTzm+e+xlw
         j+l5ulleQ41Xk3uthaXYB4LBMkr8vJzzmkuwjJyODEZMKY+hJlsP4/OUmLn0m+xNZF0J
         tzSX2/QL9dwSc6+WYSyG6NDh9ZS6wL6jvLp2MTrApLxAcRmS8v6lBjnT1UuWbwlIk9TB
         Ur/jFDMoYIG3pezzbtM4bswBlcWUxDBEo33hdgA+8mENBYvs8GByZDmQmvuq/qjgA16a
         XQygzbdfxRscbU+H6+8QDhtQ5aLLsa15jNmv9tQM/pMY6Cnga7UFwSGrIj4nDpV9tt2j
         4dLQ==
X-Gm-Message-State: AOJu0Yx+Lf2TjeIy3qTJ91CV1ZDba3+dYsByIXCBPXGe0ZnoPamiLexn
	wwrj95+DJLxKYZU151EJXowVnlGH6CuUhb85o+pn79VXz7ph1VqHkO4b
X-Gm-Gg: AeBDieuNSb2zQUn1Kz6dwv4Rip0P78kKHaMKFsgnt/dBy6W+PywDep3PomnFYIHwh4y
	rOiQGG7mjNkefh1OnTfLqpsk7fpzQq9CImRPgr1PCAm9vsXG30B+337vmsquqzVZadXyFLuCCGw
	8ip2IqF7XKNU9QdrRFEGlEZzyx/TmWx9egzg3+wfYCyo1lM39/7DdF77LZLENUTlsqDU8J/vr/o
	0ysGUqutY29aSq/OLtxrYN8Qj1cYFG2S0w8BPJuW4gMTU8ZqGIBKCCkuolLQ5huo3KJrQHl+TAa
	iLEMFDmSsCEx0gYphblb58w2WPgaf3+UwyHmvymaBCotFIcqFH9V60y0ox474RSD7Ofbc638zff
	DLy4em/xRwgfzVsdalyR61N8qhUZTQx9JqkYuovU5lWbwNn98PLvcynOSulwiJ3STbq5u5PoH9Q
	Va/kWfDjenK4O1qbw4SuQx8k4je2jZ
X-Received: by 2002:a05:6870:b10:b0:409:95c6:f2d2 with SMTP id 586e51a60fabf-42aded59e24mr8798401fac.30.1776713675325;
        Mon, 20 Apr 2026 12:34:35 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c16b64a83sm1389898fac.18.2026.04.20.12.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:34 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:34 -0700
Message-ID: <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> Once xsk_skb_init_misc() has been called on an skb, its destructor is
> set to xsk_destruct_skb(), which submits the descriptor address(es) to
> the completion queue and advances the CQ producer. If such an skb is
> subsequently freed via kfree_skb() along an error path - before the
> skb has ever been handed to the driver - the destructor still runs and
> submits a bogus, half-initialized address to the CQ.
> 
> Introduce a new common helper to fix the issue. That function will be
> used by the subsequent patches soon.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
> Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 4fdd1a45a9bd..614e7bd1252b 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  	return 0;
>  }
>  
> +static void xsk_drop_untrans_skb(struct sk_buff *skb)
> +{
> +	skb->destructor = sock_wfree;
> +	kfree_skb(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  					      struct xdp_desc *desc)
>  {
> @@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  free_err:
>  	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> -		kfree_skb(skb);
> +		xsk_drop_untrans_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
>  		if (xs->skb) {
> -- 
> 2.41.3
>

Have you considered the alternative where we postpone `skb->destructor =
xsk_destruct_skb` to a later point? Will this be less messy than
undoing that descriptor in a few curated places?
