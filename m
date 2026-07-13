Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0373B813E
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986071; cv=none; b=ncRrt91Ee0NrdgiasRzt0lb8iPc85ln646feC1C/J3S+sJEc6Zhk12ktA4FrRa44TKG0e7i3onwaCob5SC6B+VAD1MVAmY41gSoXFc7jGoa/9XOB0GkVDmTLqkJif31w1X6Unj13ZlkeWnMCB808BJDRzkDLm6/m0StoTAq+bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986071; c=relaxed/simple;
	bh=0I+0kyq1AZx87We7gwa3pEx3g44cHLWPHGBxtBuMkuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwgP/jcB5YkoSR05I/6yrt5bBdHvpfncqd1C2vach5HR7RZsCbDz2zQKzo+avKGBHyZ2BFgOzIEciW+CQgtZr0orsC3uPn4usHukcbhbjGNmtM0L7sbFPHC9tzJaoj/A0EzFmqyiV3rUXp+2SyIFQiIo+r0KRpNEJmGfnfWBZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo6ROaUk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo6ROaUk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so208760a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783986069; x=1784590869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0I+0kyq1AZx87We7gwa3pEx3g44cHLWPHGBxtBuMkuI=;
        b=Oo6ROaUkIevehklkbz51i2tBzPoUeFSjnypdSkl4QCCR1UA6IPEWECN07OvlPLfPVf
         KrPdz0RoIqJLsET9k2tDY04gDhwK14E2lNXTHduUeUOHZz0bWTDjuUN9/BP7IBfdmr+I
         Zf7I0osJw6GRo9yr5HAEZbK6UolD24ZOA3lFtIBwhy80uELm2EWp6ZIvKToJZ69jLdY9
         vZAdRzlut3byHasXyfni5lQOu91wbmHe+eURYY8mfGHX56bL0Qt5we9Wsb6YRDPlqgrZ
         6INsT0/jDiGA4nSWa8seszSPOowGMZPDG7IZMb62BWOMiAQy31GY6ViWJWXe5SbowwvI
         EQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783986069; x=1784590869;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0I+0kyq1AZx87We7gwa3pEx3g44cHLWPHGBxtBuMkuI=;
        b=GhufGzOBbOfEN0kNjFCvdcq2C3ymul2sBNFSfOQfcQ1WV7q6raePtUkZvLaCIrzl50
         jW4TUV79Y54xSBO3sji1KnBRiFKWHsdBPXbu8DJFMEcMDR/Da0Fa2vx2IVldbcSLjc72
         1pF+g2/o90Z8+mKOsbHGWA8Gh+vxKCKOkSHe1TXEoqepDqBVlzTv9GIn8nZt3CGGLrfG
         mcJKTJFuVJItyTIFvKmFF+M7e0cPYJSYQdDtjStEvsEXAqf/dDtsnRDxj9rMUSMDajNj
         vMBkJnJ3unYbGArBjNcjosefbzK092KJQoEAB9vsVz++ixx8Ad+V16tw1Yp0FJM4JaJC
         4iZw==
X-Forwarded-Encrypted: i=1; AHgh+RoBUfIozb5njM1UMNi7zE0XwqLkUt2digEv7W59cfPXwWawckqJz5MgHevLTCK4myg6MjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BmeiP1TX8NDWCwL909b9NU+0IhV961tFrHjTEDfCvBrpjJAo
	W6rqqgfhUpFigmFYkjlmooQy+CYRJ9ifzU6WjUQw5YF/vss9D82kbTN9
X-Gm-Gg: AfdE7clmDEO01PS9jp70ktIW4myGaa8BkpZk0TlAYKwhT+EKRZGwY+MeEQGSMEAQt2J
	X7/AQodlWAtnwanlwQegwICx6V8vaTzI5+CplIK9m+PI6dzgQyoNO+d+6KRwEFNKuC3Q3M7mblI
	ug37LxVBojWkaGyFqeoVwNsnty+Zc7U2XjTSdKrJgGXXXodbeJ/yp6tkCKLPrzwzwsLTcy5b+xQ
	VVoW4JCpNuI5+AxzH9i8U+awYBzspJ5hmvyfwkvowFy5I3GeO+h0eZ74wMsRfggrDiFrEdGD8j1
	eSPpU6dc8gzxxdD4OGLxLQFVenhzwbX4jCJhncl0mE7NYKAow0iA+DL+fvl0XMt+AW6Cxij42sO
	nB3CgwZmvxCg1kWxzx76nGv1xyGYMD2pIlEz97J9cNoPX5109Oc3UhgB7TDATf3k863WAmmnNEg
	UciziT4bg1iiaxkq2SRBef/akdIUB2C1fFjGiXhvvY
X-Received: by 2002:a05:6a21:6803:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c110776462mr12023952637.6.1783986069154;
        Mon, 13 Jul 2026 16:41:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5946sm8814949a12.7.2026.07.13.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:41:08 -0700 (PDT)
Message-ID: <5e3112af00cc1a6ae4788fa8cbe7ee368f21d661.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Remove dynptr check in
 check_stack_range_initialized()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 13 Jul 2026 16:41:06 -0700
In-Reply-To: <20260709230242.2003459-2-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
	 <20260709230242.2003459-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> For a MEM_UNINIT ("raw mode") helper argument,
> check_stack_range_initialized() open-coded a scan that rejected any
> STACK_DYNPTR slot in the range with "potential write to dynptr". This
> duplicated, and was stricter than, the handling that runs when the
> buffer is actually marked initialized. check_helper_call() later replays
> the write byte by byte via check_mem_access(), which goes through
> destroy_if_dynptr_stack_slot(), which rejects overwritting a referenced
> dynptr. Therefore drop the redundant scan and rely on check_mem_access().
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
