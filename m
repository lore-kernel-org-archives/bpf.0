Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EEF472F61
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758922; cv=none; b=thtNX/2mvxsj3lYTw9MsqGLP4xG6n5D3bd8GZlTVPdkRIqq09ewVE6XNWiFOKo32SX1zb4WbEQq6Fxtgof68IqKPsX/tFG+tRaqkQwoAsn9pLztZJLVZKn0XBid/3NGNs23zKBsnXq5IuA+bYtb455vxhd7g20/B8GgwjFdTD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758922; c=relaxed/simple;
	bh=vUgSmNgYb3xPR6GE41yrOSkOkZp4hMoyauJEOX0p9L8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Nx2xtJQAMdjPWl+7cUzYFi/FrMgNLxWUkBuvUlNgY1x+TbdV+F9d24EJq12VPr34DKZYG3yhJg6COYvNIBz7NU5cT9CCFFwyycCKzTlm/rWjPl+Rd5kxWT/vq9dl0yqC/7V6oYxXVoDwL18tf1PxKLmdkkyJh2jMRliA7In1LMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzZiQMh7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzZiQMh7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so1842414a91.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758920; x=1791363720; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=valg39DdEk8sl2YI17Dx/FsaQPmRarO/oHzT/4W/5sE=;
        b=qzZiQMh7DnKSeCHllSc/0Ox7SWd4gI7lAxYbJUEhIoq2XE7B0onLSFx/hPaemWbn+9
         wm/I1t9l3ab3+zLXygBf40YYlJBLjlpPyLnuHc0TGup3ElwuGCqWfTX++9cw0oiWaWPy
         BmoR7oIs+2hmS9pXmKZoexTAtVCYHc/akWHe30m9aHvCHuMgUCP36RjbwcYjZIP1bWp2
         LrKckrmyElI2KKcmIKa9PUE8p16uOppwxoxptDoB/1KZbGbnNra53O1DZk+D+moOdgtd
         DUf/DhJoGdp+ctuuwnPDZpj69AQiKIaOrtLhuzJqp7rs7/RqESVcCF7bGsABGnA4JuIB
         lPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758920; x=1791363720;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=valg39DdEk8sl2YI17Dx/FsaQPmRarO/oHzT/4W/5sE=;
        b=Oo8+kCKRj84G57R0RfxC4KjlAQYb6HEwbj8G7iE2ZWGIbbEoYHIkU0tgFhcpBbPdkL
         Smwx0Z+QibhLElOF+ZKTqESaiTYXD19txaqU882qk6FiKakTnO8vb3E3i36iDuOLFI0K
         DiP4/PiE+HpL0NuCqkUUcVsAV2phodZrTQ2gdo2XuBWbD/GAfWKc8PZ2Ca0C6exdbK7Q
         PrjNVmfssCOLyjNbUi4ZKmGgDJ55rSf5+o/eSj3hUn/g3KuLKMqJ0ITmDLzzglN9NI/B
         5nRoHOT8bflT1p+GeF3nuaHP1J0cMp/MWf4OQ8Fp3YfNx976SM+ts/4L4eye24YDv8So
         BWjw==
X-Forwarded-Encrypted: i=1; AKwUvBz42BJcyDoqxH+3kbU9n5C7s/r2QtvbrEsN/M9ok1mhpQJ4gX4cxTR7koN4Rsh4JOzGxDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLh/+XylwMh6qHfyM5Ds6aFmZfxr++jN8ok+i9c6DC0DoSQqE0T
	mdHaKvH2cFTDgdeD3779nVBejiPIA2btbk7/gGg/6DYH9H1CHLrmT/sx
X-Gm-Gg: AYBFou1WoX5BehxIdhrQlPc9a9bZdJB5EFGRqQTKWNp4W8fKKobDKtWKeIMZtAlOdRE
	tR9s7nAG15mTlcwFa0KU54Ny0k/CMHScoAgk8G1aSqeIiw+rijKH6NS0hD3kRWrDFfywf1pICoe
	0jmvxlr3wJdxOlkgXm37tNYCmrJqjdJdw5w7Z87YumrxwX17MdjBPFZzitHBwWe0QJ6EKeUU/G2
	L33ds/xzMlbLVBk+QuV09SpmQ5XXtby/rS2opVa1bVMbxq9hwMW11sv97WDAnfwMFuoOqSZzRjI
	o66Qqwy5rddoUR+CFyAPa1fi64llIyskRspkxPIZzTt7fR5ImUNPPsqa9xZStYHFheySItkeTyg
	V+XZWZ+YyH3MKEwvdZvt5dm6vwGwUCMmYolWNcOrfklCKPE/m4RgEii34XWWOel0o2Ew62okZ1N
	5GcKDQ7iLwwkOhi/11eIsfb++4hNfPOFP97C4mfSUab5GPdRjG0w5kankzlRkJURwpTSXSNUSeG
	OZR06rJSnAcMPfCeBAU+lijD7vzMGHjTl59gkdA4/lyCmwauaVxZftXfPqRefVdfZ2xuTNvGBmS
	GVlAVHaUrN0AljE=
X-Received: by 2002:a17:90b:2888:b0:3a0:f4ee:d2b2 with SMTP id 98e67ed59e1d1-3a4d2895ae0mr550843a91.32.1790758920501;
        Wed, 30 Sep 2026 02:02:00 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c9938fe0sm2567574a91.0.2026.09.30.02.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 02:02:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 09:01:59 +0000
Message-Id: <DLSJ22P7T6BZ.FCF3J1JWCOET@gmail.com>
Cc: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <daniel@iogearbox.net>,
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf, sockmap: Fix udp_bpf_recvmsg()
 spinning on backlog-only ingress
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260929083447.558818-2-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com> <20260929083447.558818-2-chenyuan_fl@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 04:34 PM chenyuan_fl@163.com <chenyuan_fl@163.com> wrote:
> @@ -91,7 +91,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>  		data = udp_msg_wait_data(sk, psock, timeo);
>  		if (data) {
> -			if (psock_has_data(psock))
> +			if (!sk_psock_queue_empty(psock))
>  				goto msg_bytes_ready;
>
>  			release_sock(sk);

sashiko is right. This replaces a spin with a hang.

pw-bot: cr
