Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375293ACEF0
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273136; cv=none; b=h8JU0i1TgM8fD0YGWhiegQabvhb3D4rHYGX5tOGtYYaSyj9wIIG52kbtR2rC45rUPMyu0WkxUoLtBTXXzcjE+Y/9b6SWUHN+XKpj3Rnudqx3Tu6putlXocWwLbz4iOLquPEo6syTHPfrG1yJ79WA6sXvmbGm8pJquwH1vgzeuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273136; c=relaxed/simple;
	bh=RtGdyxz9KesPN0h/Of/nGln3tyT9YfaKIch2p59wNcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLFxQ3BCcc0hGZzSjJxYK21tHTqyAGhxaPDI1ap60XvJN1MFtu/DZMrbIjJrBNC63fc9+6wfLiIG7q5nCLxik6K7eaFfUde1WnOSAi/OAdZuwmtvsCUBe+qtmE9xz+t+azb88CCZhQWuEXpct9F2at90BfLEiuw1zYe/K/MHwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e59BvWz9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e59BvWz9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so2018450a91.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774273134; x=1774877934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtGdyxz9KesPN0h/Of/nGln3tyT9YfaKIch2p59wNcI=;
        b=e59BvWz9iqpWEby3U9KeRb+7+ddgq02Sn8xL7JQjecclRDF1TM6LkWzt8fM//sJUj0
         9Z1ZJAVN1YguNyWBa3vA/oL1EYw+93y+R/g4t+XTCQO4FifQpb8fejGykLzp+4UwGC0H
         4l/p2GW10o05qbhUyEPxpOHZK+6H9YSNZf/I35+cBf0zdqel45b1mg6weubbVJk3yb2U
         ngxQ3JOq9MeYUeoFxq6Qfd0GOIQr9r4UNR1KoLm4dbHi+Mq9tJAKTTBQyC6XZ+lAuKK0
         99KI8m6ZQwIFPpa76T+L0qJfwTHJbceBDftcg3a6HFRjnScYoFuaaHsqjvJFY0O7urb7
         x3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774273134; x=1774877934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtGdyxz9KesPN0h/Of/nGln3tyT9YfaKIch2p59wNcI=;
        b=pGz7CAjlpH4RVYhmZjnqJE1+O1KpgMBY9ZVuEEY2+NBuOFrHi51zA2gRuOWBGysjq5
         zUsrifoH6jCt9mgHEHuI5cINYgueEeSIRwzpv2mlXYcbD7MuM4aFf+zCuVmhxD0O+IsM
         6i5yPYqohbrZzn3dppi0yeSjXQrV+BvAs32J1T+mQNDUuPirBxUT2vpPOleg5//22yA/
         9kx1t/zSxsLfWndIjdhbDGmU/lwfvpXVkNrrmAtu0HU1vXE9PFE5g1C7pFpAoBeHuIng
         Jzdmao3/MacLjB+Ts3Eqs/GOX0yPYbq29L2uX6g4n5CBWMsVzhEruayIG+j7isWH1jl8
         P5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXs47glp/WxKD9uOU2Dko3qrjGSgvtwcGnSTRssGVgsopnaSr7iBu4G3xHjPPqabwG8OVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFRfx9+SxzEAzqPAPz3izLe00TklsW/cK5uyGqzHlwEBM0PYl
	wPe5du4EzD4/6Dh5LCVFou9aeTKCeD9ZDp/gMxjQKAC5ntX8yf+zIy+E
X-Gm-Gg: ATEYQzwn5SZvoqd5Q0rWzU1vV28aYU61NFwwfXRs3Njb+aExFUBxb1sXmm2+oYYSS7s
	zoQwTgy4GpixW/kReUnqzMDTiUsQTtQlZcIqdwc/P9ROTNH55K5ieLYH3yERxguaTZhusgIIT1i
	bSe0k45E3cVpU2d0QTqX4SnlpZoTtqy95EEWzBXsGcZNwJI+ErnU6hMwxxyy9h/Cbu9uf/B9qg3
	Y/iTOpKpXiwmP6TT7nDI1xb2Lpy9DNWQtyz9Dx44ShpwWJDTRfx9M8+Ldj1UcbhWjAtDSyNq0sf
	Vyg4axCJ2teS3Q0WKcZe193eeBNeTceO9w5ceG0Gg+JGUGlepJKOUIljaZpmkEexbVH+W/0Q+sB
	HhRa1szj8oan7+KXI/2yYCb40rN2kCjRL5+SgI252Qh5j51KD0r73p/RM3PbYk6i68VjmFPrNQi
	d54LpBRqpQKK1QDEygU7201igaNQJB97tOQ+EcmIk+5Q==
X-Received: by 2002:a17:90b:530d:b0:35b:e4f8:a0b9 with SMTP id 98e67ed59e1d1-35be4f98f17mr5587671a91.7.1774273134405;
        Mon, 23 Mar 2026 06:38:54 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:277d::3ef:5a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4130765sm9543544a91.16.2026.03.23.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:38:54 -0700 (PDT)
Date: Mon, 23 Mar 2026 19:08:42 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, sun.jian.kdev@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Improve connect_force_port
 test reliability
Message-ID: <acFCYrInXMUfffyp@computer>
References: <20260323081131.65604-1-varunrmallya@gmail.com>
 <a97a0392-bf2a-4b8d-8e0a-10388de6d408@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97a0392-bf2a-4b8d-8e0a-10388de6d408@linux.dev>

On Mon, Mar 23, 2026 at 06:40:08PM +0800, Jiayuan Chen wrote:
> Thanks for picking this up.
You're welcome :) Would love to pick up any other thing put on the backburner
as well.
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
