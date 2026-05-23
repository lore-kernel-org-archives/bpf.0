Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201638332D
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540045; cv=none; b=kuhJMFZePo/3iUgy+ZN2ZF03zcmK3uEDaL/a1kTj3LZfPodu3Vp+dY9E+193xP/JH3n/ei/yD1AAWO6eNxh1sG78GO5H8oHbR0bf/uzVB9ErWfzIe4TWPcu/ioCCwG2ZM8yoFxwYztohUGEAziT4gPfp1lG1Tu1xatSJEY3V1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540045; c=relaxed/simple;
	bh=Ehxr5ZZxvn0wUwMUfOy9afLMd5ZU5eM6FSLjW6I3Nes=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iDATEYH0Ia7ejJXjdlZJuB98aNVUyH8GXAlIINmVLtXanx6PwGWS0NTSmeR39uTu+URD0jIwCV60YHJYlQqnskzo/Ely95kICwXwQ0q2U7RiYj5+o38QWGhIp+T3OModIlvWCxLXjMbfLpQOcO4KD2wVWEFapzxfE0uZwclGF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WCNu32yC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WCNu32yC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516d78df76aso17723151cf.3
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779540043; x=1780144843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r58xVPNF+m0WFGkWYL2Am/X2Rl0rlWvrIW8LmGz9DRE=;
        b=WCNu32yCiv1YXVEhFOy7w0t7hQ2sPcbAV920Q3qZ8dqZiFAtNx2rrt9J4QKM4yD23v
         fgv/EFoKou1dpN7ixN8a34mWlnord6foMhh2b7v428twmP+whydYWUmXCm4H0//KDHo7
         4Ha+f2c2y0P9lcW6NUeyCI5KgBarVZw/KgXNyhuKIqMAcQlcq2BViK84fDrISUoE3gZg
         uiEZU/JDUfcuib5xj708E/jWNiSusfWLF9Dpu+1DggUvSLq8UcoyqASP/g7yvxynUej5
         ifuJ05Sl8ZMJtl15doEpjTxeyWMrWg0gNfFnhcA0jM4CrSPeUtRysvqSDwXFZyq0YcEo
         ao1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779540043; x=1780144843;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r58xVPNF+m0WFGkWYL2Am/X2Rl0rlWvrIW8LmGz9DRE=;
        b=FOMEQwvpb6wiPxIyjtCAvylPdoxb7i5nhRG2xYv7XDy3JeasaZhAbulpyQSMifwe9g
         AmQfGw+CfP+5lfpTT54oS6GYOadIVh848FwHrtDoqmO1+OvLjcId4lGpoUw+iEhAQJ5T
         OCK/HEomIMDXJ7FKR0g/0TgqIvjR/j8v6b9S7scZdP7rnbBPMJKMAIrQkTNObkoUnbKl
         YJbICUIkX6nw2bneBaJwNALErg8kUWIw/KE0uS9JoCP+85u+Qf66ubrhRyofv8CM4Slf
         WnBzB5Iis7GongXuD+mhwQB/9QeND6voKfZfwvWhYEPaVjABfHjZQHUbITO5PaWX55Jk
         3o7A==
X-Forwarded-Encrypted: i=1; AFNElJ+CELxT5/yLUBhCUJ65VfcI/Cuhi37Ppoa3M/XfxDIXybtsDU0R9+1d+0vq6htYXLYemb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDLrXiXkI/35D4xI+IFrsOmjqXKOngp01foaAUu7pdGb9QNGN
	S8yIoByANXpE8yvHaHUpouQjDJMGmQGLLeqiP2VY6gJOFA1j+BPPCI8QHT/w+lWFHg==
X-Gm-Gg: Acq92OGtq6VK/i1GlOpTUL+p7gx+M4JznSGLstUPEu5mC6lN86IWRUfsP/6xiUtJqqg
	L5Wadq0x5UoVtfyXqlHMKZd96KdOWlPNl469bNaZ/WEyiP9vtjWtTkwLGVpVT7amLjdOuRZd105
	aKUgfzWP8aAlgJFHbgZKIKyjI/x8lf1pqPwz5JC3v4y/5gJ+ApNUgcDp/MN5SJ2YZFTh+FJj9R8
	a05DrhvfXCSGETqiTkMcZ2YKRSzykxRrZ/Z+MgGO/fDe2r/AALgS0OngSgrL65qTBUgamSpaOHF
	jvcfxKxOCaUdKBOLVgXGaE639KItcWA1B4gSjVMQm3MHkYM45suKQJ6AvkkIJPrprbuBwQ6uojy
	eZ5mlga4PC20zjF9BBD/WXSAoKDsm/JVNK5MFw06OTjFJIuaE1S2MB+BD0/S2Lk9vKtxOHsmYKh
	n2S99TfK3yzAXcu2jK6i4R2+M=
X-Received: by 2002:a05:622a:190d:b0:516:d955:ea2 with SMTP id d75a77b69052e-516d955144fmr78384601cf.0.1779540043159;
        Sat, 23 May 2026 05:40:43 -0700 (PDT)
Received: from [10.234.26.20] ([108.147.98.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c91c42sm39025591cf.14.2026.05.23.05.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 05:40:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Date: Sat, 23 May 2026 07:40:41 -0500
Message-ID: <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
 <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 23, 2026 3:40:46 AM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Fri, May 22, 2026 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
>> the TOCTOU that Alexei identified.
>
> It wasn't addressed. You simply ignored my feedback.

Blaise most certainly did update his patches based on your feedback. 
Perhaps there were multiple issues that weren't communicated well?

> sashiko spotted it too.
> All other sashiko bugs were ignored as well.

Link? I didn't see any feedback from sashiko feedback on list and to the 
best of my knowledge it hasn't been enabled for LSM patches.

--
paul-moore.com



