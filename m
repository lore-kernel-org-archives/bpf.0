Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815325;
	b=fcZT958hM8HVd37yjqXqtO2tRby5ZeXzQ2zfmq/T1ynPQNc2twQT3VA4WNqjSqmbKlKe
	 fktT66AWZTgZbmgMnx1JE7G0uUOxHjHGE/e3YwR9OXXLfk61RPWFyDVJvO5TDNeMGKBBk
	 v2JEjGxPCoGGKBJu7uJWDyA09QOL3VxHsr65K2LgksCqgQTRBytd1IwrVKJlOix5/s4XI
	 q6bMlK51ExO3yiWTPKdjEJDcX9m8T/hCX2R/bc+x9AstFzjn4QyxQf8l3jM7xz9/axIz6
	 CKf6xRJuConjwv2yq2YRb2cbG0hSBjRczR6373m5nEJafqCHJU0PrwIgfJeeyZe2YbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gU7bwdY72Yv09gphDpfGMchXiFum+5+mX5PyuHUZG00=;
	b=46Dy9LdQK4eII1wbUOFGpdpYl8nIodhF5LECq6Rwy6IQsasK+WvRtpUoVmRwy3AtWZ+k
	 JOdQY2GMgsKDDXSRe/aR63AlUKUUy5sLbwyybGkNVj7NVzThVgCca0MO89rk4O4nZwYLg
	 K9mp1ylYY/9GHtTzgtcKa0ZWA1Wo9BStL2WFBQxotunNHthD46Olx5+5q2SIqP+RzQr7c
	 Ph4BhdjE1XUtoLaMtjmQJUuaS8v83f5KQdOBVHKnjzTFXd7vpz4bVwggrirfw8ElDAn0V
	 edSc8sWxUamMthdNAJDZvRRCBNjBgd+5+BY9t7xPeWj0pgCb/kD0KGA8siYTgUhEWlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxf2QRTF;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B8606B206
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2B8606B206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxf2QRTF
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso262773b3a.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815325; x=1794420125; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gU7bwdY72Yv09gphDpfGMchXiFum+5+mX5PyuHUZG00=;
        b=xxf2QRTFd0fTLwa7DShrNBSQkQrrznSasz22/ejPMNTWqJSNSBLws9A/Om1fo+VVLS
         HakI+q8pzC7y6aCDcFuwakDfGOLhyO/DhwnYyK35tze32CzF/BwZqABDCM9iSvI8IIsi
         Fuqi/+Zx1VT0rrSPTILlc2ixcItlukb4t4qQArDZcXzdv9ARIDbVDGmQqfIdmJtxjOTj
         69HVbB5xWkvJOrdcJ3UmApJ+zZMTT5Ox/hi5JVQqvqZ1WTwGuvpyE3Kg85VJ24dxVdv0
         lv4IOiFN33EAd6iiOlgQ4zVcEwEpk2rX2SUoQTUuY86yKE1HzaFDx3+oWc4Y6FJt6S52
         PGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815325; x=1794420125;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gU7bwdY72Yv09gphDpfGMchXiFum+5+mX5PyuHUZG00=;
        b=z+yLXY/nzlBPfb7R0kbrYMLVs7IYZYuUjlO90sj9dbMqww1uDUMfL3JiEikIHgXK3J
         HdOtwiynWGk0ghygCVWBtwUqr69h7ahzVc7K6cbC/+f+lqbe9da+pnbUW7OQpDO7Pbcw
         JgqtR9RPvN+vdbINUj22G8n0u8E4W1qLnmBDAyzMov2SeWPzbHyoWqqeOIlSPSsh4r4R
         6m8yHpcgwo0SuSLxB9ZpGyIIHILbEg5FZdWLr5DOivw7TiPVS0klY0zxQv1qPdPqddNC
         mN9rYVBkm2IQWyneZv0r7sYNTDWBwPJ4AKr4YR2EfLu/9IETylSRLTe9d3uq8Do996wR
         ePzg==
X-Forwarded-Encrypted: i=1; AKwUvBzAkBtvkXo0tX2g5AL1WXwfyCexd8OPg0/NuKGAzzeU6y/TnbMEC721QZD9N33hXFd2S5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zStu52qGq+nbSQoX9UFk6Xy+GV08ZQc7gWzLpCmyYmM1KLIf6
	5KWfS44ylG4ywSFiGE5f6BQyvRVxId/f4uy+JioJL4Gni802v0FdCh2t
X-Gm-Gg: AYBFou2y2+I9POlw/hsw4VxhQKQ1XxSCdPgcBHuoaHFQrJgMlTezQR6Qw/Gr9IcY7Es
	inN92jNl29fsFbQls/s2FIYzXo7YVH/zAG21XTO7+sRNRsYCzxI6iq2V0d7ObUDVlPsDUKiOtH6
	lIRC7r0asaci6qlscIutOArPfgQsamr8+sgTiuL6dTpHZAv3FJS3595AMLydNRyqEDbyCZTyEKl
	/15u3A2jkjM/8cNd+0nkGfn/ZToe+fR8SZBluqAUEaj7llFsq9H4TouERpYCFC/2y7dev6UTvYG
	c+YpX91RgZ5rgE5QgH/bdVdrisrTeH7oh2OvaFszvdfmob2vzIwFxz/7uc1XTByvft7ml84D887
	+rNWSSi3NfFVR+88uuAt4w4e9ITYW3SpAA1wnFpPIyjr0DbrOCM2jH7Ik6KDduxw3Z2QxLa8cRW
	xqdlr8tL9aF64SP40e93XzJEgXI81cszAjgzkUVaSbI3RdByq7N3wonZAWEpG3TmBJbVS2Zkwbk
	NforumznB8NLa+lL3d3q6sm0I4EGfZ8GlM5vPUlKsj80XgQ4tBRkIWHZbw5HvAJvsK41lYN62+A
	yEaSTMoASIvY46z38WX1RTo8yV7ZRKT0O9y50JAlfkQo5ThFONBmt5u9Ukyq+Pyjl4FwuEEM0c7
	+k0237t63BDHxDzoj9rHs6wMYyS8ZpMQTzPE=
X-Received: by 2002:a05:6a00:b81:b0:89f:e248:5727 with SMTP id d2e1a72fcca58-8a9ba9f7b81mr13693775b3a.6.1793815324356;
        Wed, 04 Nov 2026 10:02:04 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1d9403d9esm98837b3a.52.2026.11.04.10.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:02:02 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:02:02 +0000
Message-Id: <DMMMGML15GX5.3GT3JKTNCB748@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/14] bpf: A stack in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <DMM94NDU83WN.337PKDJT31SOE@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com> <DMM3XWQJWG41.38YIBYIE2576N@gmail.com> <DMM94NDU83WN.337PKDJT31SOE@gmail.com>
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

On Tue, Nov 03, 2026 at 11:35 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> The price against libarena with __arena: two times more casts, JITed code
>> +18%, arena_malloc() +7%.
>
> Could you elaborate on this? Are the extra casts due to the fact that globals,
> heaps, and locals on the stack are moving to arena memory? 

exactly.

> My understanding is
> that 1-1, the compiler approach is still more efficient in terms of the casts
> emitted (and 32-bit narrowing) vs BPF_F_ARENA_SCALAR.

Right. llvm adding casts is a clear win over BPF_F_ARENA_SCALAR.
