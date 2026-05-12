Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12125B081
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610763; cv=none; b=QsCDG214tgi/yBvLGwJnJABVG58CAlKXfZZeumaCZgWIdChSITUSm3kjx1N3M9L6Y+RWMHSqO/sD6q3STNDspt5DYkOg1K+eESkbsqyO3gVlKxrhlhu7oSQ6E6zFJ127IEUxRhqFCNKuxSShvHxGPR5VetLui4hEhzY6seNR9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610763; c=relaxed/simple;
	bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3aaHgBrneePPENB8189epGzRm83Qhw1VkX0x0Av+RBFkm2W+H36/YTkKi+PUT+Zlcsv/VY2AblRRNUEUaj1EX5/8azgcSa/mL4MMcJemqOWG0yaJa0JST7iyj7twg18jdtw0dYIGndwNKd7qrlNcdot4nOJ7/bpW8zUEbJvNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfjPCIM5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfjPCIM5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8025500cc7so4266095a12.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610762; x=1779215562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
        b=SfjPCIM5cJ6+xHAu0booYkkcVzq6W+iocCZhZqhWtYyT+LVm9O0xRSdQ7TzlUn133l
         d8nlmfDsO8t0eq6/oT+7wt5fV4mrIRpfViVCoYWzsTMNlgYjpL2fblsNLmNVUGm20PlM
         qQuDLiq48mxo1ZTwIEZWDDccJzKs/ZIO2B3X3i9tOf+NZCEpVC39eeq7GO3MxAseMWtT
         lbYgAXMSeTgBZmW1Jt6XIVxm8HjXOMA0wKYklcG3F9mLjgFunpjSxW48SBAyX4IobRf2
         IyYpfePzTMx2qjpoLbT5mdgsNR0WPVaFt8bWvA9KTSv3v18wUMoimIJU2QOyJDLTxezG
         JQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610762; x=1779215562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
        b=T+CYm6FBfMXS2qoBKEU+nvh+r5sCIqY/t4IukqRdovqvjMt4hBBx7JRjMaIbWPuvwr
         0S6qsN0Hrr4dugytE2pdGkrf1m7omuEEesqJGiiWVYuHA+woyYMN29jUOxkKe64sWPLM
         yeXdh2V3RoIZA4EF7hfWh1eJI1xmdfSG9k3d2yiae1Y1BQqhITcrTnzuo3PynW313jOH
         3wjkietqquQfOBt6DZdaTO/yl64IKjvtz9dEzbmuKHhs9OLAB3qmp/lLzdIum7uhSt6F
         PwKs7es4kovuO7+bNUQ7pu5n2z0sbXLbge+6AeL2BtapweXdq0EH1iD5D1rav/vzY/yM
         8esw==
X-Forwarded-Encrypted: i=1; AFNElJ/lsZbfkTrTeY4zDSc7d7E8j9tTqq42G4H8E47F1Xs2mhJ3VHrV4HNWjXIKIppSKzUwwKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmNGdPnBK8T1K4fFvhTm3ue+cjV5P50LSziTp2Y2Nisp41WOH
	wBilqHoSCoJXDntaYLrf6KXYBjn3fadPqevIXlgIK9/9RNnYu2ekfOFz
X-Gm-Gg: Acq92OGHEy4HGPt7XWwxk8Em+snQvZRyDMLq9XatEEz3AO/4nZ5J4ESq9/EnqSFu0y6
	li0oQwRmvS76U/7nc9iAl0ZWKcFN917OoJxr5ztoC18GhM5Jd/1pzYBMzzFocPHQiqsJj6tlQ+r
	gYQtgtl0o0Fs5vQ40FvW9YybC8QlOUazLDRyplWIvdLir6VJKTaj8u3XK5z8mKO7FskL2v7lcTK
	ze/+f5m/BXAydWrhP4tE3RMV3cRbK4KT1bVyCzrSUnOfCIXksEP3VyzgF+jyu1ihCqn25URXDWT
	x5c0zlLHDheEyMr/0RXAm2Cph2fkrR/3oefU5FyTQ3prqiGKP1pkCfXC2/XEbcdMWPhuheCtvZD
	Zfw+O1bFTrofR2yIcB+ubejY1VoB2EygKR9x1fBIqFA6H2g5Q94jU8pEYC7tqfYXrV0BC+/Zp/U
	nHjhvt4GEpHMelgYdP7iTFu2FMn3cN0kiE1JlK5Q6sIRnkMnGVn1vZ
X-Received: by 2002:a17:902:c405:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2bd271283bbmr2687245ad.5.1778610761632;
        Tue, 12 May 2026 11:32:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec232esm148513515ad.81.2026.05.12.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:32:41 -0700 (PDT)
Message-ID: <f89db2ee4911db2d8bb1da5b44e318d98bece0e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: Remove redundant dynptr arg
 check for helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Tue, 12 May 2026 11:32:06 -0700
In-Reply-To: <20260506142709.2298255-7-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-7-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
> cannot be released. process_dynptr_func() also prevents passing
> uninitialized dynptr to helpers expecting initialized dynptr. Now that
> unmark_stack_slots_dynptr() also error returned from
> release_reference(), there should be no reason to keep these redundant
> checks.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
