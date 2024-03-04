Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6017C8
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584457; cv=none; b=PNwduaadhIWtCKkINE9jCuFSKsZbq9czKyeOwc/nf5I/cS0CzXJamkwgxb1kPAE/43MqZ3iiiQ8Gj1ngX41pXIkqdarAuQdMFgJ1eaz5dCk6EuT6tWxr/fw2/S31yUup/VQyNXfnQjlkS4UdI2X/GLIK998Xkaxwc/LAnbUVQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584457; c=relaxed/simple;
	bh=2RYU6ZAtdqf8ycLsR8an+JYzuxi9iLteNXT+phtyBBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFXGU0ivLsG2sjLLH98cGyRj5DCZnYfzWwFCv4IJMP99bibdV2owC+i1WoaWDdoFHTZ74vP3yR9IzOcUBRmy/Pvf5ZlBOS6LHDXU/sHq73E72jKcJBMzBubbOYagMB0UqeanWrZjgO4kBAQKoXLmMqPOn/Hhb2O7kGKmKscX8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLgnQrI7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLgnQrI7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbd32cff0bso41515185ad.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584456; x=1710189256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXMDJ5R0LLXTMJzDa2rCEnF7h40MpmHoo+5cXd4xsoE=;
        b=iLgnQrI73vjjqTq82paWuEOdLL1V50la0UF7MuNu4iY9uyOqH1T5irvw6DeYkIUhnX
         kHkYXRrKHBszuaz36C59Zb/LpjFbYEx9ASZMIeLaoHGE4Os5HxtqJcPg9xJq5mPyXVhs
         5VAH7C1f6A3/r7LqPvVZHQAPKHmKuSb5goRqQPI0VxzMIc8uyEl3/aTlw/9PTfv6VM72
         1YXBEeQ/EdWlQupYEmvXHg+BjxhGvOoFN0j+UWx85eCiCqnywSv4tovLIcEcWSg55uby
         sQt/XUG4E+iI29w1PTNWZGFvMJKNrI/rR/6byc64mnEFknxFbfEt6e1K83vAQLF7bQo9
         zrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584456; x=1710189256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXMDJ5R0LLXTMJzDa2rCEnF7h40MpmHoo+5cXd4xsoE=;
        b=abrNiJPZn5xVvRYAjvZZO4Ig8FqhuQneRe5naYX7QcXE2dzgKKyN5jAkJqxBpfNJyE
         mkhDkpqvpEsUBziee1nFe+1HqvoOrvvs63VmeWn4ytR1dvMj4w+dXM/lE9iMn+sZ6qot
         7xQl5cfQiwHZ5rQSrmwgthnQlgmwA/ahv9uRs4F3San6fhT16Qn/IAWOqBOUlvd+aXTP
         N4nGAo50Q9qCvpYyLxDYmPARxV69nvh+Ae4IjzarOPc1HlIQwA20ToPt6v2RqkaHPbUF
         Y+YTMgnmsyRT7ugTBQ6PhKRMoSsk4rQ0fuwYKTCLSXwVHl4uJaR4CRTzih9hBEgS4LK4
         hsuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqGfmfSyUgn5Hn9itNLfBxVKNsfgI93QDUlAlFW4DNITfo63QqAbL1sDl73pAppR4LF+qX9r2hf9oHlWCOSl9IqJok
X-Gm-Message-State: AOJu0YxI+vcER5zbtCALbg3WH6wJ59PiigDumlTHHB9Q7M9DqDZjSrDh
	Quv8rDSYvcWXt8ZuV29UJTc04U8gWkOhKwaKacnWu/NAqhvjWmlY
X-Google-Smtp-Source: AGHT+IFtOUS+Xy7ZKUBBYMzRxqh4VOaSj2M4cTgGYkb2tl+Iae471lLCbxIfZcar06H9dW0vgRKlog==
X-Received: by 2002:a17:902:aa84:b0:1db:509a:5a31 with SMTP id d4-20020a170902aa8400b001db509a5a31mr9334977plr.26.1709584455652;
        Mon, 04 Mar 2024 12:34:15 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.81.114])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001dc96c5fa13sm8931414plb.295.2024.03.04.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:34:15 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of parent
 dir
Date: Tue, 05 Mar 2024 02:04:08 +0530
Message-ID: <2347452.ElGaqSPkdT@valdaarhun>
In-Reply-To: <2aeecee4-3499-4036-8c26-59ccffc2c6ab@isovalent.com>
References:
 <20240229130543.17491-1-icegambit91@gmail.com>
 <3290360.44csPzL39Z@valdaarhun>
 <2aeecee4-3499-4036-8c26-59ccffc2c6ab@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Thank you for the reply.

On Monday, March 4, 2024 7:20:40 PM IST Quentin Monnet wrote:
> [...]
> Splitting the function was a suggestion, but you don't *have to* do it.
> What matters is the clarity of the resulting code, we want the function
> to be easy to follow and to not mix the file vs. directory paths too
> much (or then it's very easy to introduce bugs such as the existing one,
> or the missing --nomount check in your v1). Don't focus too much on
> malloc()/dirname() here, just make the logics easy to understand.

Understood, I'll refactor it accordingly.

> [...]
> If I understand correctly what you're asking, for files, "is_dir" would
> always evaluate to false so this check would be useless, wouldn't it? So
> yes we'd remove it.

This is the first part of my query.

> > If "is_bpffs(name)" returns false, then that could imply that the file
> > exists and its parent dir is not bpffs, or that the file does not exist
> > and no comment can be made on the parent dir. In either case the malloc
> > and dirname will have to be done.
> > 
> > On the other hand if the file exists
> 
> Note: We handle the case where a directory exists, not when the file
> itself already exists. If the file exists we get an error when trying to
> pin the program.

Right. And this is related to the second part of my query. If the file already
exists, an error should be thrown. But if it does not exist and the dir is not
bpffs, we'll end up doing:

    is_bpffs(name) // in the condition mentioned above
    [...]
    dir_name = dirname(name); // get parent dir name
    is_bpffs(dir_name) // call is_bpffs again
    [...]

So, in the "if" statement below:

    if (is_dir && is_bpffs(name))

will it be better to remove the second condition as well, and in lieu of that
we could simply run dirname() and is_bpffs(dir_name) if the function gets
a file as an argument?

Thanks,
Sahil



