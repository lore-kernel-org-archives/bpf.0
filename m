Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E265446C00
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615886; cv=none; b=V5rBrDgCxuLMUn/cBhVlumKIjrhgSEjqHnttFSmIolC9Wl1yujDm2ODRW2yvVns85QmpyQjTBmkWhlbziAdVhvmaKNOPn6BrWRMVk90qRRr4khJWNT5fCBq44IoNKbYzJquJbnOKaIi9O0yDPpyUsHi8lb7YR8yKzWqnB0B1Mog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615886; c=relaxed/simple;
	bh=YgsUbLje683fmKSLiuc4F1nLOAKszh60ozLryAlB608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa4WArnOj6Z8gUXslPCHaQi5D2kuC62WI/IP4QdbulhSDSNSzhyokvBRP2EuLzl7pPFI3B9uJsAwF35aOcWpswzAwR8aM7TDtGqzsQ/G3TKp0/o7GhlfXB0HA10d55wzBuaby3lesQZM/4E7MjiqC8ExDjsxkMC6rHcRZNjlD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ris++Adz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ris++Adz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1527362f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615883; x=1787220683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vsc/t9j+f4tMpv+gJvijHu1ikwVWEPFOE/I17iet5V0=;
        b=Ris++AdzYgTx1ErH+WXMNOophrhFN5gn7MYlc/ERrrFDb8xJbd64j8GPxkvqIIugos
         ysNu95ddF5Fzt82HmfJpMACX8h6oq9loEOaCHUQZOXXcsZLJHG/H7rGTTWH1yObi84Qq
         4/VHegPEgrDRcdL8u9OCo4z7S6GVjzZ6Q8cug6zd1lr53t/7sXAdFcN8zHmxM1qp44TP
         TRhMW6JxtmednSFvMsIxiyNCNMiBfHgz2RUWSel0DgZ5xI/fgjPLEOIAR9+weLC9jFZo
         b6JJnpGn5h2ynlhiynlEbxTZOq99Gb/mhKT9kFsQHQRlukBnpueavq7zPeUGgikszpeC
         ygVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615883; x=1787220683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vsc/t9j+f4tMpv+gJvijHu1ikwVWEPFOE/I17iet5V0=;
        b=YI2BJKlj2/JyNA+4boVZGClyJzitjirVHrrcTjh/FeLWay1PypgyGC7OIOQc59rYgz
         5C9ue1cN7HhLO3wTmUdCm/hVu5+uFkExf96AZ6lXMXa6K+wc21Q4yv6Hdktb8VKS6lRm
         j+etS86VDcpig9VE9nl93x4yd0Um3vD+XIkEmzn27RrXw+jM73lMtULiL1BQTtBu8bwU
         faotWRJXgLJzuX8YoZllb7NISkzXeurTMBrsuaAulTZ1IupWH0VmBhSqLwIV+GQUifiM
         DW4DyKq8c6N/r+hk3bQCl9J/TZGoJZqSCmCnyBTdaN+W+nTSQW5CE5W51kGBkPbVuBPr
         kJPg==
X-Gm-Message-State: AOJu0Yybo0MIKHFCg07gl4ibF9putAAnIMZzMYxWFPGPf1p9awOxXf75
	fk9RuWT2vDVf20ZfjbhXKKqqVuZoee+G5WSrWk9Vyj2n70mhn8lMKtvnYL8Aj6a3uO7szA==
X-Gm-Gg: AR+sD10nJ67OC2JVX9h11VcpwE3stD51SoUddIufBOqYYs1yYuMAMf86678e4NMMPsY
	oHReXmWRKgIEPFwQzkHlR3HwI5vqtibhLHw1zohA7gQkeZEiV3pxHOiGB8+w4XDR+FsCbUzaPcC
	5Uc44nRbhrSFvA9idgSo87OVx+ICW8JeCXIlOU4Cu3nSU+QQ411attkHnK+Wo1v69R/Io8yfBzv
	O0Z5pp3B15GB7TpyyxO8YWxETxdHzTCAbokvqXUOO3mzyyGiXwahm5pKbQ+kRAlLko+BKMyLL3U
	68tHeosoKd9kdR4zP3hHy+I3vEsH5vpfSuvedO9Py+86UTwOCYYiHfJOBrMihCh7FEcqxL7gS6h
	FJD8+br4m5cZ9bFEgoZy2CAeD5gwFl332Svhq31DWgdT+/+6mAsdX/NcK3VhT96eFDdcSKiNfs7
	b2Nmp5zT4nKPCvYZO5rJ+VsIzjfndwCivbJn0kY3WzoTG/wBbq5Tlsi/YXtw03NAJeahL6mAzfR
	B+R2pGy9mRK19AJgJiI
X-Received: by 2002:a05:6000:184a:b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-48159cbe26emr7265764f8f.4.1786615883005;
        Thu, 13 Aug 2026 03:11:23 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56123asm5759067f8f.8.2026.08.13.03.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:11:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:11:19 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 1/5] net: Add connect_socket() helper
Message-ID: <an2YR6g_9SPEaemw@gmail.com>
References: <20260812154328.72834-2-mahe.tardy@gmail.com>
 <4a025fcdd177da13b51aa8042d59fa5d8e3a7c022bde50d5cf79c92ed3ad516a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a025fcdd177da13b51aa8042d59fa5d8e3a7c022bde50d5cf79c92ed3ad516a@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> 
> This isn't a bug, but could the changelog note which follow-up user needs
> connect_socket() to be global (rather than static in net/socket.c), so the
> new header declaration is justified within this patch?
> 
> The changelog motivates the helper only by the in-file reuse, but on its own
> that would not require a new global symbol: connect_socket() is declared in
> include/linux/socket.h while its single caller is 26 lines below it in
> net/socket.c. The actual consumer is the bpf_ksock_connect() kfunc added later
> in the series, which the message does not mention, so a reader of this patch
> alone cannot tell why the helper is not static.

Indeed if needed, this could be made more explicit. Currently it's
implied that one helper was missing "for the next patches".

> > Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

