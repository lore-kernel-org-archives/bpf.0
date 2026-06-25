Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861243446CA
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782414956; cv=none; b=AB4wtIGnjb1t10JQdewThnRYG4XZhTwa+cZTQ4YCNFwkIc2kzdMCYKqs6H/+gBlzEVXPLNAZFutr5V+aFqpdmQEwiWBeqCGUU8OTJZ4hsxE4Cfw5f+krSC+WtdJrvFhtgaXTmDalL2bnEM4dovQpBA4YOLn8pimBcNr1tYFhxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782414956; c=relaxed/simple;
	bh=rXl1mT4uj7SK8qenD0vLrTZs/CQ0Ua50ArQkmKCzBMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qe0HUYAt1VPCM8OSYYhigbMisOfZ0cHFm6YylxTl6TPgsUDTyU9Me+nmQbHiztMJsLVMDjo758RCdyXScwQcybowGiMr4Ks1mUxT04aw9l8YRyw1BNqZb/TYMMsXCn7t8VtWTUEEDJ2hEew8lGuccoBMHocZr+T6askx+Uyfazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao/7mdc8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao/7mdc8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so63988b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782414955; x=1783019755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/n08+H8Tpjvupjxeo/7io0Vp1HXJGNBPMxNmTxvkgU0=;
        b=ao/7mdc8sbo3BHAGDhaDoFgs9yW8eMUzC9HJ2ixLMsL4mqvXRs9rfo6elZr2mKK4E5
         7wakguSJnJ20pV06PVZxRKPPTgcKLNNL2B0xHhe5wTfw67vJ5mPzwlh4/bQVOnlPtDOg
         Sg4GUl8Z0G7fKhKlDMuwVN+LcmxHlsSldkXxmjs1E5vIsD9L1Lx7AL0QUvBwsCCeObL0
         /huCrqjXn03vnMlxHrC5G+EQfCx9TH9rZce2zw+7WFz7HFG37CrfCgvQZUvC0+tN6ZQI
         9jyJ1MeiFivUZhl0ekC30lYWj5EvMmL0eTXKMhIAEbo6yALGzBL8ngPUYEE6JGi0M5AR
         bcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782414955; x=1783019755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/n08+H8Tpjvupjxeo/7io0Vp1HXJGNBPMxNmTxvkgU0=;
        b=QBCgr8KCHxWQ9DKQtNlR/Chq/G0ZIcBOOEVeiu76gBNnIED6pH2JtIVXWksOTIRsFy
         D+SOmVKc2C2lFiBqGmEYJViE4b8gWWkZrY/1Xz86Hknknw1vl0Zwwi/LrIthABu8QS0f
         clIWKPV2Ajg0RyBnVz2cpUE4ft7u8MCBGQBd2MjwrgD2EpGZBxOaSerHr5KDIrKdyVd2
         ixFyDRy43W3KsR5QTkG3u2bIyhyHrWyDj8YJq4KtrlT7VOR5+Zmivvze5GcyEvtFNQuc
         HDiiXCjrtGaI0bgOUWgLjpDWfjP4tyohLvUCURG9g+Ah6LscRPjH/KvHfHz2aRp/R53i
         XCAw==
X-Forwarded-Encrypted: i=1; AHgh+RopdNhThM+MrEIU/mJlYUAZiKVAijMd1WalTgFhu/OgXHeuR+95YoGbobaf2JcahuKLUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM4XOdhVYiacYBVk5FNlIWSD+H/+OpzhwiIJ5fRXuxan+FYrQ
	eTDj456U3CZwqc7sRkyIHqio8OpbDENQmUMdtWxaQhsiMjw3yDpZev/g
X-Gm-Gg: AfdE7clU77ZKwVndo2SQm8td3RdmNZODz0LjOUBXOKZHEN+atOuy/tG0UxOy5pgPLhz
	laVRMXMWM98ISqZK0Sx3mw2FJASBYpUPl2Ts0HUxQHRYf6RFLS4aqD4DOsh4Hi7ZIineAgVKlyk
	ZJs0Dy3k3WJrcVTmhQdWvIzP03KSlGmR0tj0REdaYVmdKZk75MaG2wDc6NLEQ354yf84+mFvcGv
	dH3hoSJstbXVKtE3EJne/pc0L2DTsTtzOGwtJY5zIv01M3mwqtDYCkkVvVHfzR6RHTafBtqwCxZ
	sS+V7X5lL2xLCNruxrqtFU17njDXSgKolc31tIl7sXKNXB3Af01LdMYqWRTC7OfM2yPTMNYBDvf
	XXTZri1Osox7QmQm8aiXQDLJ1Bnn1v2jB36IVBMYYWfxZUZJsH+HxybLGurKjE1Ti6cer9Lxkvk
	lztLaYrgImDyhTU0AYPmltytOZ6sNitZLBLjqJHX+mqA==
X-Received: by 2002:a05:6a00:804:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-845b382ec89mr5091236b3a.0.1782414954654;
        Thu, 25 Jun 2026 12:15:54 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845c104113esm665045b3a.57.2026.06.25.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:15:54 -0700 (PDT)
Message-ID: <9e952ca4993577f5e45b5c17f5c80e42724063c8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: libarena: Fix can-loop zero
 variable definition
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	mattbobrowski@google.com, song@kernel.org
Date: Thu, 25 Jun 2026 12:15:43 -0700
In-Reply-To: <20260618085626.19633-3-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
	 <20260618085626.19633-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-18 at 04:56 -0400, Emil Tsalapatis wrote:
> BPF can_loop based loops require the index variable to stay imprecise.
> This means we must initialize them from a currently imprecise variable
> instead of directly assigning 0 to them, like so:
>=20
> static volatile u32 zero =3D 0;
>=20
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	/* loop body */
> }
>=20
> The libarena implementation of this technique is currently faulty. For
> the technique to work, the variable must not be in a map. This includes
> the .rodata DATASEC map used for const variables. However, libarena
> still defines the zero variable as constant.
>=20
> Modify the zero variable definition into a volatile variable. This
> change adds a complication caused by the compiler optimizing array
> derefences from
>=20
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	val =3D *(ptr + i);
> }
>=20
> into
>=20
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	val =3D *ptr++;
> }
>=20
> and causing verification failures. Use the barrier_var() clobber macro
> to prevent this optimization from taking place. After that, remove the
> bpf_for() invocations introduced in libarena for parallel spmc testing.
>=20
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
