Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754396;
	b=lZSPU0S2aURpKvTb9kWVdXbMv3hZEG8srHyPi22spZzPgcvyH7LEx8YhjaKgcnaq/v3e
	 v0mFDVFGFhPZ3Z2oYNzDxfNwpF/QM7xOdNxC6xzP5LkDKJzxz5OXgB+5gG8W7LGsxMS2a
	 SOytuVGt0G6snS6ofQs6Ju1SgnUkuEVLH83SUky1sNVoB1NSa1UkTev1awgf09Hp+uGpR
	 wmJVohOPzFlRA6KdcOJdl54GuBSzsf6Y9Fo7aRVtQiXfqRBWreG2Ci6iDVF4BrL68XuYK
	 rZ+oDdrdya1viLPhQVdspDCWfaZd4ENzd3hPvIC2d3UgiURdoZX9CzUVCFlrveh40Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J5sKs/Ne8g0Y/hsc5MX94/eXwYnEUUUICc3qiP04Drs=;
	b=f/jiifMa0+DIIcQgk7a73QER6sHOyDeCIh///RAzpzBlCx4r0V9UCR+phWarvc8jojL8
	 Mk9YQ0dXelKvLqcL8EgUW2PH7GGWBLs2PpB768Gea1bMBwrrNEMdOJCzWTnjJakloOzSM
	 Qb3jmFP9tfaWsvOULnSje8B6NeeaWlaS39HAz8JS0ZSL5mDGaVupkZ+SBrOi3VTSP6G8H
	 MIx/W1mGsCRQ7oNZAn3WJdxvELMGssJgMejwi2iD7Oav/bQKzV8Ri2DFpCFVUMcE+Weqq
	 B8i6DbaOqwiRgdUShqANikhrpBVMD78lb4r3QO5UItMymnaMLaYHEL1JnP19/NWuO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdZd+3kH;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D876606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D876606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LdZd+3kH
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc758830601so126039a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754395; x=1794359195; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5sKs/Ne8g0Y/hsc5MX94/eXwYnEUUUICc3qiP04Drs=;
        b=LdZd+3kHX36Z7HSPqxCcfgMKLxtuZ0lHI/U2pl+xX3Xf6eqlLta7BJ/UeZckwktaS9
         2RC9Ss63PukSbiqRKupoZMzAn0Jz7kJarESy8/W+1dbaAByjuxSSk6cke6koZBbTkp/o
         QjMzaDgrrKUxCWXy/mP6T1CQv7iNJHE9CQndcM2XfbQSAYpkOcaU6djDKhlkGkqpJ2gT
         Qu5d86V0oz+ZwvdEDWjf3PeCl/FFvYiJi8M2WW3emshOxDzxyraXkEDKLDgoH8/mfFsf
         rSyxok3mTQHyoBcy0Ur+4N20kYphhLLiZGjpSGMyt88q/xipUwPYesnaWyat5R2l74xV
         3L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754395; x=1794359195;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5sKs/Ne8g0Y/hsc5MX94/eXwYnEUUUICc3qiP04Drs=;
        b=T8nz3i9hKukIDkttePFinx4B5AM43K26aTjzqRw8UEG6lZmyG7rOBLmOo1ePSyEWXr
         uHYEYnSQCz/+Satdu6f2gsqlANB4VjEISLDtTeENtVVMFYXqNVRpbq1T+0QnYMqneW9Q
         J7zll78r5Eu9S+p7dwvnpdns3ZBUkIMmA6P9PlY2Yv5Leey8uXJS8NhLNvEn4iFODwwX
         bYAoGQ+nBKP1+04YdsI69HwkAHBhwB4N7wYB8oE9Z2DcwnMRRn4sLk5O9a9Raav5rgTi
         2uYG8/f2sLTYI+6xbSCnQz9GWoyn8+GMG80WXaOIvhlGMPoGpJ0QMWOOMXhYmD5sN1+J
         0c0Q==
X-Forwarded-Encrypted: i=1; AKwUvBz/5nX4RrganAeF7jYxpLch593h3Xy5pUFFGRSsAufZrVq/DIGGIjSyETIo5U7EUz9f6MU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R/Ow27cDWk2FOmVRjzT65J3wn7RR5iC7epVwJMRIIh6JCBb6o
	Dmr0tRzIcrXI1w73hjXP3B/OWh4xNZME2A6Kr2Bxj7fw5CpkroNm72h6EKLJWg==
X-Gm-Gg: AYBFou21zwzsF5mOpRYismX5eP0zhlCW5R4gnMmte7qH0trSHs2Ov4VeewiQXQMZ7Es
	mgJYMS8dOH3iMsvLMM00AitCwRJadmvUhRaMUHmeHWfcWpxJe0t+agqhbzv6xShxk0plJQnWBlE
	SLAMtCIFYoAWAvU/RwUcYzavW68EQSQGz8//OQfGrXdxJNTQGpnwgqQVuLfYCapB5dRGf9bcl6S
	frY/EX9DcgqCf8Q9wXQrRyWxSiY/GaTtSTD2t6JJ9aPuC2Kz9qFfpFKzL7Fs2FpsXR4c5tmwnI0
	ouVdOjISjBf8pv9+8r4nO+k3dvwFQWq80DB9WIWxdOYW6KutcM+PDih4GNU9I7gVn5IbThE2bzU
	w6oGWxNqPCaFcyTVhXJ2OG4wmE7/UFR/+Lg6ObvxhtDcL5uJbpI6NJsIbB5UJoFB7IQXfbJXk+b
	dYdcmCX5O1VrR5SDP9WT9aaBlnPXDj14qT8zoagGSe+GnTVriVS+/SS+AQ5nKDBqug1+ahhN+Am
	oGB0MABiDhE1jy8BGlO5Pcupn36fGdrEcDrB+Xp66/g+NC88UfEDiNJK6MIGEeEEmQsDBy/gdMr
	V6Ch9HIOrxPQEcT5sMn9u5bBU/7UxGVyqbw97MsjxgcXkvqmFstyCGk3zV9KQLKXIx7qTEgSODe
	eB0oOMjwAzE2MSlbI7G1HsMJoCNRwj0gdLA==
X-Received: by 2002:a17:90b:3b47:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3ae8980dccamr13161246a91.33.1793754395383;
        Tue, 03 Nov 2026 17:06:35 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b095314e85sm1052582a91.15.2026.11.03.17.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:06:35 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 01:06:34 +0000
Message-Id: <DMM0V4WNNCZC.1A8N6EFFFOE1D@gmail.com>
Subject: Re: [PATCH bpf-next 32/37] bpf: Allow BPF_MAX_SUBPROGS targets of a
 read from a table of functions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-196291@kernel.org>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com> <20261103234104.208239-33-alexei.starovoitov@gmail.com> <sashiko-outbox-196291@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 04:12 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> - [Low] bpf: __free(kfree) variable declared as NULL at top of check_func_ptr_read()

Not worth a respin.
The overlap label prints the message and returns. It frees nothing.
targets is the only __free() variable there, so there is no order to break.
