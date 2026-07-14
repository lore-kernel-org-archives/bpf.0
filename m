Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C7331ECD
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053183; cv=none; b=hvyfeO+GtN2JylBL2mey0nwI9Ar5mMwVItwZ8qvXTQ5939EwsoKEsiXBOktAfCQSGhdXCHmBgCSljswM/Ej1fTHuLCPawqu/leQgeX+dxc8uj91/k4WAU3vS9MfamDfSwFdnFEnYdfNO2ucPP9pNe9t8psJxGN/t5t6JBGYq8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053183; c=relaxed/simple;
	bh=C1sFBtxE69ioRh1QGckxAsEgc8urMOayeNMSZKFqcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWhVRa5vUvCSxJ+CiexjX9mF/16DmMEJU+PLz8Sg1uzqZOoCfP279Ylh9LnfUXQ9jS9X4c0MOB/PDCXgPNmlXcKRmAHMZwVrXmeLEErPJpfuHf6HIBLXlAzTWfcFt+3y7u6Gz2gxNCxqcbvnR/J+T/9BfDCEoTTFLVe56AT1wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycp1XjOQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycp1XjOQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8484f229529so1056353b3a.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053181; x=1784657981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZW9BZhR1bEUCTQBEiW6Qsx2NvsQORDmw5UKJ5XbZAA=;
        b=Ycp1XjOQ1hBCjFMRXhM3wQA/gGT5rC1cW5pOfdgoktPOnn/aNVJBYn/HagGmLtwpTj
         zqStZyFbTbBuPj8MXhmFMXSCJdvWu8GPwMsPcxa8Ex1tFyVPuwgG1waE6XlKSvr4pc8u
         n7tWW0LdAEnII7n9y7v5RaQeHNDv2dplMBN5cWMMMTpojrTmiABzt+2O53iAGHazjMVR
         35L1IC9BrSFJHbwcsVYhVWb8J3eGpEkw+eaSVvRUTc7cWQXi69RCzLXCe6+kOgLB/PhA
         +QRyRwP/E4GQp7XVo95ZYqD1K7BgNLcnJ2SQN+Ku6i5Fvizuwhx2N5Su86rddfvpjYcb
         BUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053181; x=1784657981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aZW9BZhR1bEUCTQBEiW6Qsx2NvsQORDmw5UKJ5XbZAA=;
        b=hhROyOgDRuZj3G33fzH0z/qrtBC/TFcQbZNyEl+b5w7HyvUbOquReSlFG/4Of5LGxW
         AWraTHrGxjVQ8rgQ4NbEPA1hIFRXtEAz9h/H1GFRSFDJpihqGY30RJn/1PHXjpaOMU7s
         z8SBhsFJNAT9La+FUcub/hDeSxo3Aga1Fuz3FWdxOPMHyXdJkUFr2NySz/fNW5J9Jta3
         izCHDPWKdSkvHq81PgcJl4xm66bxiUc855Fs+nqwrAa9l1bELPjxIpSDHrSveG3yHWVb
         +fb2xn2qTPVo/a1iTz/XPBtoXuTN2PlamPjBVhpWnmq7R1/OerRQoWMVlevTiP1fi/59
         YhHg==
X-Forwarded-Encrypted: i=1; AHgh+RpKO9ByMiH5OTeGnDttFPbKjiE+bWOptWNQYyHMFla4EAjOjRBy85HkhABTgOtoWYV57Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUblzwGTIMQ1wogWUFZ8DgooZ67ymqiV00N0E8uilRgvyNeTy
	vm/kaJs0OaLGrqYk8No79nMgLYxJdilmZitiIf/UezYrl5Y6Zqu1sIXN
X-Gm-Gg: AfdE7cn3qIVA5urY43rxcp7yq98l88y41Knenn++XA6zPHwm+D0lWlP8q2DY+EQkNDR
	ZQq8HIjg7NsOMY5uHsucCXsTrSiOx3QOL2JWhd7nLVaSWzby3AgEmGjDQx7rJy07J7WR7Rh1A7Z
	ruA0IVuhXosCl5is+tfba/PbH9vgCtGcsuylL2wgHG+qDIi/0ay76OgJafS6U02S+uqJIcbeumn
	U2Mbq7nTSyW/iUAOwZOf3vFu6mCbJPpxAGDmZzO7XwDMdkRBHLvuDisVKd6PPxmRgfZHcAmhtWv
	3sg7UkTrDkU1xSfWt5kd+OCiNRDGWbRQEMDO9tNvD59Az6gS9dL5O7dJFyLdY1/r5b5Y8inKXUS
	LEvL4O7HlAul2d7olf1IcmRDiUXsFohZcGkChHKribU/dnQDRIrwcAW1/Jcwx15sjJjgZUmFaSf
	Kqkj/d2WrB2nCMOGJmoctz
X-Received: by 2002:a05:6a00:228e:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-848896c39e2mr12654855b3a.9.1784053181128;
        Tue, 14 Jul 2026 11:19:41 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7da667sm1855269b3a.41.2026.07.14.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:19:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:19:38 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Nnamdi Onyeyiri <nnamdio@gmail.com>, sashiko-reviews@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, jakub@cloudflare.com, 
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alZ9ZUWbUbVJuBmZ@john-p8>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
 <20260709185526.E4DAB1F000E9@smtp.kernel.org>
 <alFRK66z45eDNZA7@localhost.localdomain>
 <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>

On Mon, Jul 13, 2026 at 12:14:07PM +0800, Jiayuan Chen wrote:
>
>On 7/11/26 4:17 AM, Nnamdi Onyeyiri wrote:
>>Hi,
>>
>>The updated patch below addresses the issues raised by sashiko-bot.  The closed
>>socket and signal handling code was added to tcp_bpf_recvmsg(), and the fix was
>>updated to work for sockets with SO_RCVTIMEO set.
>>
>>Please let me know if any more changes are required, or if the patch would need
>>to be submitted some other way, I'm happy to adjust as necessary.
>>
>>Thanks!
>
>
>Thanks for the report.
>
>
>What's your use case here? With a verdict prog attached, we'd normally
>
>expect the data to be redirected in kernel rather than read back via
>
> recvmsg(). Are you using SK_PASS? If so, please state that in the
>
>commit message instead of the email body.

For our use case we never do redirect or packet operations (push, pop)
we merely use it as a mechanism to read data and possibly drop data
if it violates some policy.
