Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6F3F823E
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197494; cv=none; b=CFHwi+cpDhiRjuAgToZpT013Y/TxEPSIIygdQ8ZIjIh71ha52t//62UVWtVpksNUfmJaN8n5gIhWFjMwGRkK1phmNbYPb60ILBmU11nJrKsnVd2Astr7rsVu9MZawPCIlEJnh3oDhL/rqT107P4EG+nBrrRpbBOtSHmMcwR+d+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197494; c=relaxed/simple;
	bh=YQ2tL8/3Hf5qXAULGtO+Ag9ODHc16ddEpEO7Jjp5ZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8CbfteV7BN0crqxACXdqRoj9ac+8H5QismcxM1T8/BdCEBhzWKrGZtcKCOnapO7Q54jzFbiBv8sHgQ4oxhh4VKGBMYL3pTqIDnvN+l4Iuzwpos689aG+O6F+lHbCRW9n26lEJsjmOe2PcbXk1Tfgs6eW/xqk7XhcOClBG0pvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0SL0jeL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0SL0jeL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so2355000a12.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784197492; x=1784802292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bJ+4p9deZ+LD4EAdCpLpzHGmysHFbTARhOqZpB3AIhw=;
        b=K0SL0jeLgVjcGWXcoK77/0ks5aHvU5ZH1acedaIsyF8WGG8sq602Or+RFkeP8JwULw
         CbSHMJUUINHj0d7Q+snequWFuNTqNGgqAqvVZWhr+VwuUYImsGrL8k9+jBGGoZToNDO1
         40Q0BjTO8GXZRlUQukdRMd+YT3VQ86U46/zGTgI7P0Wa6wigfwslg+qaJtn4qcLfQJ5m
         7I1hqFNfl3BhEiJx4h9nM4LR3N97uKvtvRw0/47FPpA3rzkiCn1+3VjgMokFRUlSIjsg
         rIlwJnM9VU/NYZ0vot0BlFrPZ9wMNArHWrP0SD0092F/TMPNBrkXLGoRtqG6bcLtkW8S
         USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197492; x=1784802292;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJ+4p9deZ+LD4EAdCpLpzHGmysHFbTARhOqZpB3AIhw=;
        b=AATfy8ANbNAUeTsfxEPDQX81eHFGsZNm+e9+7P9ntctAOwl4HtPdrXEEdX6owSjlI7
         V4IzB6WULJsr2NwfzHR+CpbpbBpvLAZnS3elzTGdG+x8xUlBKWJrKpH+VehIYAGIaFL0
         P2ZRKt9E+Ut+7QgoQpoKvdZkKhEKmcf2JSrY7kynPWEN+BEZbft4OE4ZjeQRoxbi0wwu
         d74g+asNXEesTvXjv8YAAtONAsWH0xe7Draqdl93+lsq9X2ZfV8leWwgjKKYxooGRz/L
         YiUhGMznuv8RjY3LcC5jdUk3f9NhrGHhUS+1kQgLT65YfTKYaDvdOib1+tZMqJquQ61i
         b4kA==
X-Gm-Message-State: AOJu0YzSem6hvr5ZPgfrfMx36Df4KKuStBehX1zICaH5Yjo3ji13wG+h
	IeoJ94Dan6qf48K6SZKoyGYa0Qhgzo3mELRIn52BPz1Xn7S1rLdfSZGi
X-Gm-Gg: AfdE7cnMnWRtGH83VCamrYYfC7wGxzdSXBAMSbSb2ub8joKeeQlD7JJWQcSfNknFUBz
	rSlE7B/HsrVNqbzJS5yNh7NzIMSbOO7g9ZQ6mQJnnYFRiSU3N7/H2uPll9rMrjBknHAefrliCGQ
	CX/WyRgQZ8RBnkVepdmRpBdFcQ363MQfK3iIRR1Tmx69LMNR+BK1rMfMcgWjXvvelnl3tHQ82IZ
	qzKerWtexoctW5ws+ajnh7panLomy8rQ/jW2wkwjMCti4Iz7CTj+vgTjQdSGYhKtGCnpp6ML3QY
	MVlUsGyj/1YRxbjVYVZXxr0vICgi0rO2Kt6RZJfzsmF/rItFx/XkjgHtcdQoVN4hOcFxATq63NU
	Rz4GmkI3nyXiiBr8bh6ZChYyyZiawnOqQNaHYLrNaahi3Ahfoez8teIVdR4WwLV4fb6T5UZzSPP
	e8tZazcImqbkMORkHiFW7OSFnpXZBIEYxL2P9L1fLvJ+gNhK3GSiyYzcZ40t+IXTRERw==
X-Received: by 2002:a05:6402:510e:b0:698:4992:77e7 with SMTP id 4fb4d7f45d1cf-69e198a6b52mr3660369a12.7.1784197491403;
        Thu, 16 Jul 2026 03:24:51 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd289ee36sm4359432a12.11.2026.07.16.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:24:50 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:24:48 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <aliwTlOayzvvlN10@localhost.localdomain>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
 <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>

On Thu, Jul 16, 2026 at 09:30:30AM +0800, Jiayuan Chen wrote:
> 
> Please do not send a patch by replying to an old thread.
> 
> ...
> 
> Please use a commit subject like "selftests/bpf: add selftest xxx" for the
> selftest patch.
> 

Sorry, I'll resubmit with these changes.
 
> 
> Please use existing test frameworks such as sockmap_basic.c or
> sockmap_strp.c.
> 

Just to clarify, do you mean I should add the new tests to one of these
existing files? Or that I should add a new file, but write the test in the
same way as sockmap_basic.c implements them?

Thanks! 
