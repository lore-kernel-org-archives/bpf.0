Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913619;
	b=pSZcnKRYFg00Y2VB7nUwtgNeFyM0h4ZWPiQkKVL9aVtlVOwuvWeAjMsZLWGHAGMeS9pl
	 z02mCGIl6N9QzlYy2lAogzG/SgIbcJfmnSv38Gr6eBhJ5hCMxTC5D1ex8xL1NvsRgo9Xr
	 z3aPVrR1gUu1o23NOR0WSmJ+UCWSUiFuiIBIJDniSnS1ZSIQmWzuNwQDDVyGdynSIesvP
	 TIv+m3YQ292lK+SlByCcxYbQ8KGc+PkZd7yrXzyJBK3XQXwFldJkTn8JTvRgdqFvGHpEm
	 ZMNt+kX0UbTzsRIwEmsqpUa2VupVRCXfrOIytgnPfW8hXpOymNhaRRWCOcQVD/oWX3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UCYoCA0l50BOe6cq00vn96utGEICr0hjnvRC24q3j5Y=;
	b=tswKbh3g6D9EFS6Ltwy3kNHfQmrMWaHzDXPB8hDhXP72HcHKvdCHoKncXa3LYJFvTkra
	 EbN5owjasZtDyywu/1N+nrfdQXYnmt3hg7vK+feZVEEHN8cowIQc2wEbC/F+yRlzEOnbM
	 sDipazkIhfNGFVKEy0mrMwtsd/Ca2DQ35yPdyTo41LUYb5zHikAnKA3/1vci7eCWDdOfM
	 GPr4W16oHqw6uAcxC56vtmAXPfyQJm6as+nPuGWt+uSYGLZ/GwgoVKdjtrHWhFqsRuL3d
	 dP5O8cx00l3IMY459NfiOwUPe2Rz2I8XYKQMu8QuM4b9aoMBvvWmc0t3O5mAQthad+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERd9NLfR;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1F606A329
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E1F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERd9NLfR
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4671262f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913616; x=1795518416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCYoCA0l50BOe6cq00vn96utGEICr0hjnvRC24q3j5Y=;
        b=ERd9NLfR0pXJagwWvhCwABitOLBLt99KRZJyMnlbJx3QkPTEnz2OAOlvdRN5Y7Q33E
         5A8T4Ygqarhd+LytItApv5IflFvZt/PJCh7vEm9nknfttEqnFeDLgbI4h+zqep0PVwuS
         OyN+W+Kvgo/ZhljH4+JqJpUWlGF8yIXTF7ufZ7mkVAHLc5ryi9uESOR5reZfWBFDn691
         bO1SE2Z+zYR3deDigYXEW7m3TTRZ4x4SNQAK5a1RKuaa7i/bmZUsSHrJ3ylOCUtEfpdM
         G1+4WrfcdzpNwcPMjKaVoSdaLd6b2Ib2etqKWEJMo2SU0rVB/KFLS+7ozC7vSQkgf+0I
         +SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913616; x=1795518416;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCYoCA0l50BOe6cq00vn96utGEICr0hjnvRC24q3j5Y=;
        b=a/9CAvQRLbEf9Ec8Z3gQuC2e8etKhcVOzVCdUUdEorItcVsRieNr1RRIF2FyCEmxrl
         XYB0H6IY9V6l2/r5wjX6AiqYgvumr8BeLN2KY4jSERZWLxrKFka3ZOBlXIOut3fywT8N
         j6ZKSDLgs2KLbU/crtRW2wTX4+5L8y5/Kbge+7aZoQX0fqM/oiPIoAErtxS1YUpXmTey
         ry8s+meqBwsAH9xNt3QXOyxQhVLEQj4m5eYYzJg2k95hhkx4N018FBwxkEA9mMuu1B17
         ZV1WZFLADn/L0QEDLXYcvLPA7LVbuZoGEGlBSYxbogHh1RhP+rzTDDeMReQ3X4NWwctP
         lQUQ==
X-Forwarded-Encrypted: i=1; AL+hErFH36g2Wu0c6RGXePhkv5k+x1LJtb+fFVISJBcCtSPi4zOsZQKy9b8X4HSuGZCw76qX5K0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vpvQmK9VgaN5ceZtDFMZvTodXO63NVSUt3s/ZDWyehA94Wlp9
	FqmJBjP/0lry4HKFTDJkxOzCSUxMlT2lDFcbBsLdEWmk8n3D8Av/fm/K
X-Gm-Gg: AZFdTZfvo3bUxi3/njCYRQq4wkcBV7N6LiVuqnc8rjIfUKRaRQp3RstQKKXdHK+cDCE
	071eO1kLNNShAi24lpk7s19nveSKgMV8Jg21h8QC2hRhQlEf35DVdmbijH/dAiT/73DHFx5Mr7g
	55UELPXXCpswNht2KRUGNHavl8XRYj2mMnyziy2GEUGdU4TqSf1JfLBVdFXsP1RVwbNn+4k6yCQ
	Sxu6R2w56MNok37nB0Ky6anXi/JnShOcSZo92ylhBmIfpuuFfrDpntqmsumRPBZMg5q9GovTV1X
	xFRSjELEr0+REAzEOJay9IqYdwwKhAr8Zs9wDpiP18EhtClzevpcyUQp7l69Ps6PFvMtiH+Ryij
	Mk0aLJYzHy3H94hBFW0j0kwep+hecj19C8X0oSxZcxiM8thtsbBUE5M6vWX6GwJtTbTPqaqkp0v
	P7JOPSRPj20n6Di3zmPOF0Yb3pp4eHzs5/gOEObqSRF7JYeRwc4dZ8/FiskBrcRktFoBV02sLQU
	5okjL7mQVYB8L4sIc6/YTes0q3OT2S0dkFsHGhtPAnmux0RMRyCnPNep5xkGuO7b6EM5F+mNars
	FzDLveRhAg3u1OypMI+nPc+2raJYZjfWJ6jVf8EXzj40ElaIxGZNwdQt1GIMn35Nhg==
X-Received: by 2002:a5d:5d0a:0:b0:491:6b1b:7f25 with SMTP id ffacd0b85a97d-49c72e85578mr29909972f8f.45.1794913616294;
        Tue, 17 Nov 2026 03:06:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da0a03sm22300526f8f.53.2026.11.17.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:06:56 -0800 (PST)
Date: Tue, 17 Nov 2026 11:06:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 "Jim Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel Wu"
 <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v4 next 05/13] kallsyms: Fix selftest startup delay
Message-ID: <20261117110655.1294a95f@pumpkin>
In-Reply-To: <sashiko-outbox-218653@kernel.org>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
	<20261117103352.1244657-6-david.laight.linux@gmail.com>
	<sashiko-outbox-218653@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 10:40:36 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] kallsyms: missing Fixes trailer for schedule_timeout() bug in
>   test_entry()
> --
> 
> commit e7ea6257d7756e16690d0150d840ede1f6384772
> Author: David Laight <david.laight.linux@gmail.com>
> 
> > kallsyms: Fix selftest startup delay
> >
> > The kallsym_selftest code clearly intends to sleep until initialisation
> > is complete in order to get more reproducable timings.
> >
> > Replace the schedule_timeout() calls with schedule_timeout_idle()
> > so that the thread actually sleeps.
> > Poll every second (not every 5) for SYSTEM_RUNNING and then wait
> > another 10 seconds before starting the tests, otherwise the tests
> > start as soon an init is executed.
> >
> > This code is in the initial 2022 import of the tests.
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> [Severity: Low]
> Since this fixes test_entry() calling schedule_timeout() in TASK_RUNNING
> state and busy-looping instead of sleeping, should this include:
> 
>   Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> 

No, selftest, doesn't need back porting.

(Did I say that before?)

David
