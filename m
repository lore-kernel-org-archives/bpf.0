Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547042BC3E
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062047; cv=none; b=aw0nha+4NiTQcvxKDStsLThds7UNwKcS+8AMG5ytwzz30ihunJmVwftoxGM/Oe6RtK2Aeg8o0jmjauommOn/CKLO4/A3YMsUyCs2aAE/M1NIe9hcVDOTMSVjHA2ghHlF6xIFt58VIX/6cctjDGnF9rFIzOagiquiwYfJg7sbb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062047; c=relaxed/simple;
	bh=R+jTlT4LqHhotX5y7J5XPJgOed1yaeJP6xSoWJaVrDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU7gM5eBQjVZyL0hhixm13jCs10GcE/DDNNVRl9qClq7BTBK5nZf98xhlTaKW5opzNqLpdcaKvdRydWz/cJ72RV3P7yEyRETntiydGBU7J16Mo6U8PO9q+6mcbnNjX8riD3x3bLgNU5QftuBA6otSrevRYNBhTP14cirUE3R2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3F4bZUp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3F4bZUp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1083727f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784062044; x=1784666844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hho5cuoYYqoAbpHZtumhdas0W9C+aay0+7FiUWUPqOY=;
        b=i3F4bZUp9yM7fnvvq10DcHiePn2j4djtdVu915RJQJGH4DaT2Jqp+06VAVJZ+3Tp7X
         gEjHiZ7wDVnFujPSaYNSFRuudOgW10F1bbinf+kf41fo9nDXFy/vNtptVoujcRkIZ6X3
         xizCUCz8PTKOQ8nLMUJjqvb2hXsRIjOtUuIQci4mqfBQVk05r/Bw3wkx0xBun6we4IpT
         C3DfUaK+ADDaqvEQ/i/JkwQLEPXWdvfEOPeaCPkSm5EVJAwWwnOVi5uaBqpfGfTH+VJc
         GdgjYyeMmmNxKZquooKqCeKgzMCNccaUtSUAslFDYOootJsHa4zvRHk8vUC4YCp5fwKq
         Dj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062044; x=1784666844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hho5cuoYYqoAbpHZtumhdas0W9C+aay0+7FiUWUPqOY=;
        b=n19ivJgPvfexNIT1+Lf1yAZZOB0mGQQ/ExK3jk7n9SaXJOzOfIx2D2/+bTidRPWU7F
         IPJLUxBUgx2SqvHTMZ4nen/AMJYFK573DHSAwvydtw8d5SFe+xTustSynQTG+TfBRU1g
         WUj9IkgXsuCZzXsMDZy72cn7KKyu72rcpLDL2GXmWb2B9kVSdPAZS+MawDDyHjWWjLEl
         sk96Pa9u9x//+tpbeB5c2aPQBOjEXorRvu+iLuOHB00x2hnNeT1UKAC4l2+dnLLx7XGq
         9aIlxnZLs/elJexxTo8hSnf9QabzBi5Pf04C3Ol37GzthNglSXel7JI9F3Ax/5Iqw/NQ
         PraQ==
X-Gm-Message-State: AOJu0YzzQV7O0Np73yDoDowgheNrI6aq71Mf9UMltam7jVZdQxnqMWzA
	72xqA0nD/oVCXyBwEEVm1bvTIlVK5ZKemH3B34Ke5d3aTKQlr3YPYH87W/oJkp4xDkA=
X-Gm-Gg: AfdE7cn9KTTUuWWBTGvjvRXO58ltoV29gSPcJWlaK3cbFgflpSP6eAjzsxS6+OBALDL
	ODmU2uru/kr3McsuEJQemmigXh74M5rzRc0cWtESmrdnt9aJzHw5MMLwFBYHskuRnI7K9rMEjD4
	HRhIwmWBKR72BLtnPnkrzRbtsuSrennz/S4M70b79fk9epRexjYfR2cfrKaGa9y9G434PEBemBA
	rF5ewmoZra4OO51ACooV0e9nztvAXCW8T5om3oNeofX8u5LNI7js2RHJoVE3EATeQHBJDVKW4HH
	n6HvieXpQ4l5ccNlPfVS4SWnoP3bh3MG/uK3/22/OL1i/v93k/GmrAhIYmaogInn7vxolsLH/v4
	+sg795ySwK4D9t8xX/3RAZK4pas/tRTzKVph9MhE7K86XI+4JFpc4u0iwncdeBAGbBUR8rkjaZj
	/l9lsykB9cf6xLBo4lln+igT3eLkT5VgPo0q9vJIJWtBEiUm0uDXGIKeuGcCXLDrNEuV34UcOSr
	jBM
X-Received: by 2002:a05:6000:25c6:b0:473:f047:4f with SMTP id ffacd0b85a97d-47ef695b7f6mr23734819f8f.8.1784062044425;
        Tue, 14 Jul 2026 13:47:24 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c7c96sm10856668f8f.33.2026.07.14.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:47:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:47:22 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alafJdu0y1IdYg_w@localhost.localdomain>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
 <alZ8nmJlkhguOG5v@john-p8>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZ8nmJlkhguOG5v@john-p8>

On Tue, Jul 14, 2026 at 11:16:27AM -0700, John Fastabend wrote:
> If its breaking/changing applications I think its a bug. Can you submit
> the patch below? We had something similar with ioctl FIONREAD behavior
> as well that was recently fixed.
> 
> Thanks,
> John

Yes, this was first discovered by a python application breaking (an
EAGAIN error causes a BlockingIOError exception).  I have submitted the change
as a patchset here: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com

This is my first time submitting a patch, so I wasn't sure if the selftest belongs
in bpf or net.  I've put it in net.  Please let me know if this should be moved.

Thanks,
Nnamdi.
