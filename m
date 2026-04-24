Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940452030A
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992119; cv=none; b=GgF5nxQm4V+WGKJaFYS/xNt3t0JN6vZ2+jt/gZ3ukHm8ue9dnpqQ4YvxMYdJp7k5OnScNAhQ0Tmut6EH1kugl3j38xivk25Gz7B8/hCx+O0jqC9nlkGckoJJZyA+TjRRxkd7/CsPPmddTWluGhEtYBvlQcfovK6Cjgz+/7gCB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992119; c=relaxed/simple;
	bh=tsNf7Q4xUJvKzvuCYiNrQ69+xti15CioD1p4JUZoUbU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pLVu2Ex2SToNkuZ39daArcDBT0I4fQVGhs0wsQijaSkuk+KZ8m4hcDoYnGLdf21qO7Oo2aEHE8ybQOWXYRVoFN6Iz8qKngVzwWhJKpRqvI793vPf4AY5ACkdN76OyjCcBvnqWVdKplFDYicQy4pcXEoKznmW1McVKuxyPSJ0iHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K52iS+Ah; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K52iS+Ah"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479aa2dbea2so2646955b6e.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776992117; x=1777596917; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daUKMSC47II9MVuGQH8hcn1P3eQ2BwvljBL8L7L5CYs=;
        b=K52iS+AhNYyMP3Po3l0zCJd7pJFbOuLqmwqsTwpBVndczBQH3bkI3uW1tqQLLKRtQv
         K9kL8XpqApV9dJogHt1pqAXlApw1BNAsFiSxY9lL0vopTnjBpoUnk1lmbr6R9UyIZXUM
         EvydesIa8l0cSoSHC38QGK1XbAvkNKEUqZVhRKGaSO4RDchScUFhcZm+3xPqp/eEvPDf
         JIuE6XsH+6FvHjWHiKF7yc+VwjlfFmOJUQYtOtB1Uy9rmoQYjG7+Mz657mPz7V52VpbD
         cZ7nkT4QpF1kpWzQRoyYfJWxAFq7VLK8jKZKoCR3YL1BPqOU4Atmx/x0NLKHkao5mFyD
         Kchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776992117; x=1777596917;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daUKMSC47II9MVuGQH8hcn1P3eQ2BwvljBL8L7L5CYs=;
        b=J4nZjuH3VmUJv2wpQmT5ZPKTuFTFMg4M96dxcqsJT7TWN5ifiC8iCGG6qgLju3I8cu
         kczpuXf5GWJVjkHPEQ1PzXoTY73HbGAUbD/J2Nz+at4e9svScUM6NaGvTHLk2jmLrAE7
         JuzAMXUpgVEr5Kn53iG6epZszVctQhBmkW/ayPdEz/n5WvOQmHqnCqhwr1io3Eu8TU7E
         O7AMM6w0dp6MMHqjQmtTupYbKC8gTJf5/8rkt3qMo+l9DTN3qDReLg6bbMJFjwM6pME1
         pHfLvWRjCCUvktGiIqPGqgdbCN0EcqDCzeuR+kgFNiJMVM3O/U8qU8HuHIU5TW6mfbZs
         OD5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Iv6rkkzDJuKoGlYI+TEIKHi4XVWJv0pN8kYThW44pzMK1ja74EZ0F/d7BvhVui0o+jAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZTA6iK+iY6rnNiixyG+dHQcP5/JNBwsioYWkToBfOZcqTmlA
	xkA9sLk75NIJK4ISJ3F4/Sx2x3WSzCvvvVEZZuLZUJQ7tp6hxpuLSClX
X-Gm-Gg: AeBDietf1xeu5xyOX0BfeSue7jp+rr3B7mPWjDFx2S3tQPlOu8G90UcxPzNLZp/3MB7
	pAN45Bpl+NA+EwWSD7ySbx1OG14/wTa+Wb06vOo0QYQUORqxJ/S/TPbNuJCqp1iNQd6qaPnVFxt
	SCphGsRoBzFZQNBV53AohOkPhNjCtSqjOcdWtqn3Q8T74XbI2MyMpqx9RDds9wluW0CcyXecDEh
	75kXToqAUL0cVnQDVjxK3IvMUK9qnBPh1FSV2Cy/+WxYlZOv9tcYbgNr0kkdtlwJz3RCxMJ8ELo
	T0X7DkGZEmSYgfnHgq4+WOLq+sXu2tj4RYVtH85IY8kgP9gcNqrgMVF1QxAaca/puZkspYOfBFz
	m3SOkke2QF/wOJhiwSSumwrrZECl4NYLiE4bUYmlIEwacDL8o9/Mgl7RpUDgYqakKzqQxFPdjaD
	HMdIHfkrRdPBUQbW8n4aHPsVesr5M5edznHSZ/fsnAzUKI6N8OKGj/XbXkBXLDDd5IrXf/SKznm
	FnxmmyopSE1qQByhyMwKLPsSj4=
X-Received: by 2002:a05:6808:181b:b0:467:462b:ab0 with SMTP id 5614622812f47-4799c91783bmr16986548b6e.2.1776992117516;
        Thu, 23 Apr 2026 17:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm14515077b6e.14.2026.04.23.17.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 17:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 17:55:16 -0700
Message-Id: <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@kernel.org>,
 <mykyta.yatsenko5@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship
 tracking
X-Mailer: aerc
References: <20260421221016.2967924-1-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>

On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
>
> (3) Referenced dynptr with referenced parent:
>
>                      file (1,1,0)
>                            ^ ^
>      bpf_dynptr_from_file  | +-------------------------------+
>                            |       bpf_dynptr_clone(A, C)    |
>              dynptr A (2,3,1)                  dynptr C (4,3,1)
>                          ^                                 ^
>                          |                                 |
>                          dynptr A and C have the same lifetime

If I understand the proposal correctly above should be:

                     file (1,0,0)
                           ^
     bpf_dynptr_from_file  +-------------------------------+

ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
but original file->ref_obj_id will be zero.

?
