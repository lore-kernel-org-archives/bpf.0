Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523332C9D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773377666; cv=none; b=NsI6fXnUdKal7ueDPwwPx34hYRf7Hr7TSS4o3wSlEUSoY2DTSLjFI+tgTze7l+i3xRbx1YRZ1vudTLtSXnBB5k00s68XwyHOq9Ul/LyVwqG++WPrDBcKn85EzWxrQA4xuQmR9nTnnHXxOXbnusf8fW11uZM8btXtwd/IOjBZDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773377666; c=relaxed/simple;
	bh=Rd61+gg5SIsTRXJYGxFqSm1EoXOUORSuepP9DHIYZm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gq5qmkT34SVND8uujf3bH+F8QcVPv/NaR/psh2UjXKDViIK38tARnEmyZ/Tj+7BEJYydu6pN24WERMHX3vmov5kCWcbESpV6HPHVQyxHpm3S+gLCuaIlQ51Xsk7e3v1JQBGuFG5M4MXvjiRh6AU6sCWIl1NB0LDUQe7taKjG34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOeWkqjX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOeWkqjX"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3bae8d3eso176544285a.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 21:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773377664; x=1773982464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBRQ6yUlNeJn340VTOcKAb0z+T3QhXF7oVEXYlpX3GY=;
        b=cOeWkqjXSQ9+DBANDY6LW9od8EU6U429Om/3m3FSmkz02dtm1a9hsgJCMrLgkbG+C9
         gdgxXdmeYXnZvG+czYNkrEymrV1fR2+q7fUxnov0GR+cQwde0a9ht15HdV5PB6eGU11a
         7TOlz+p/pbuiTkCcXO9yDQk4oJ2F9GLx2drfexmjDJczSWAy3RxuZ1q1JPfTrt/9lcwA
         IXoJeMzA5gnoPUvAA6BUg/8Zx8X9USjGh7CpjnNi6CMEE0Q2JVJvzR230lUNPS7cuuZB
         j4OhHDyOk9nZVmMZC0CA43wCZIJsuv1aMN8liN8buzjjgUO9O6U++h38mv8xtAFl7o6/
         XIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773377664; x=1773982464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBRQ6yUlNeJn340VTOcKAb0z+T3QhXF7oVEXYlpX3GY=;
        b=YTm7gbBZjk7uKlfTFSgJFbgnBxIsWXVYV4qu7zOGJTaUZViiav0/dWOZKMvXUa04Oz
         X9JNX+bNKF/Dmnz66HVZ9rgb3YCqxXBArfbPYKsDP3qUvSq7x8+80nQV6Ak/ztLhZJ7p
         sYuJkAn2vJMKwkZb/hW39V6eY0di4KBRTEUtuOtVOl0qHBMssXnRgyj5YumLd5N7U6bI
         CPbBujyPVfEdenEv/tc2O9TsjqykPf1KYc5BVYrgCNZ2vTfmhrJbk724YvSV5cYgtpuI
         W6a2/pU7jUgnU6gEuDW3bKERnnPZrqX1P/6traBluoaLoHL4ndvNrgYoMGP8K5Z28aVn
         fQuw==
X-Gm-Message-State: AOJu0YxPGUmBDpDrfB8Ik58ISpeM/OSPnN9IBAKTBLHAyouolt+WgN7d
	ht8T8vVnb0lct+dhlYACTM4w2ZrTY+jLE8VWhiAdCi4dklJqlXBUnm4/iY/s5g==
X-Gm-Gg: ATEYQzwGibLXkyb0+XCGPPzHaaKL+JplSFiYESCNsRigo/IouXu9SQXgfCg0Kl8TM2T
	li2n11/9ypc5vXFKt+Sdg3lPeYyOWivwrST+6W+M8Lwu7Ppm/6ulWy+oQoJNFyQPO921Yc9GkYa
	oj1GKOSUKJHUxC1sKjFid+E5+tL8zipqX7EGL/t4u70meK/u3jmH1g3rMPB3isTE/WOL+3QnQRQ
	dM1e0iC+FK20wUlT42v1pKxbJbO+/B4yRAefc5YyDXhdhcW9sT8ScjXhBGFj0R5RINDOCb7Kr/u
	C5MPFuVPCH6isgMafcLy3SY7e0e98iN+FdUNR1ns+2PwCOQsed/rUsWerHwJzLJDvp2H0Hh88HJ
	zuasNAFXite5nlvp9H0dJ/n1VRBhfAEskzv4pziYUevN6JYbbeckP3GzoB6wQ4pd4vyY2ipzdFs
	+QVNYxHyo4l/uoJnA+4b8ShxDW94Sb8q9LzWre9aX5NjvtrBRih38=
X-Received: by 2002:a05:620a:2990:b0:8cd:9665:9ef4 with SMTP id af79cd13be357-8cdb5a9d3b2mr277126785a.30.1773377664123;
        Thu, 12 Mar 2026 21:54:24 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fda2c6sm471482685a.13.2026.03.12.21.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 21:54:23 -0700 (PDT)
Message-ID: <72d8c8ab082d67c75bfd3d47f3a57f4b25a837db.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Paul Chaignon
	 <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 12 Mar 2026 21:54:19 -0700
In-Reply-To: <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
References: 
	<5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
	 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
	 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
	 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
	 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
	 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
	 <abMHY2sCSe6xEKR3@mail.gmail.com>
	 <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 10:17 +0800, Shung-Hsi Yu wrote:

[...]

> The problem is that I'm operating on a simplified assumption of "not
> being able to converage to a fix-point is bad because it could lead to
> bound invariant violation". So taking this chance to ask, does that all
> ties back to is_scalar_branch_taken and reg_set_min_max (or was it
> regs_refine_cond_op) difference?
>=20
> Also, when we fail to reach a fix-point, it does not become a problem
> immediately, but only becomes a invariant violation some where down the
> line when we again do bound deduction?
>=20
> I haven't actually look into an invariant violation myself, so details
> are rather hazy.=20

I don't think failing to reach fixed point causes invariant violation.
The root cause for invariant violation is that decisions in
is_scalar_branch_taken() for e.g. >=3D, <=3D are taken based on ranges,
but additional information in tnum is not taken into account.
Later reg_set_min_max() will call reg_bounds_sync() and it might turn
out that updated ranges do not intersect with tnums.
The inverse might happen for tnum based decisions in
is_scalar_branch_taken().

So, if we don't reach fixed point in reg_bounds_sync() we just leave
some precision on the table w/o other negative consequences,
as far as I understand.

One solution for invariants violation looks as follows:
- Adjust is_scalar_branch_taken():
  - Do not make predictions directly, instead apply range and tnum
    changes corresponding to the operation (e.g. for true branch of
    the `rX <=3D 0` operation intersect `rX` range with [-=E2=88=9E, 0]).
  - Call reg_set_min_max() and check if resulting registers are in a
    valid state. If they are for some branch but not another a
    prediction can be made.
- Adjust check_cond_jmp_op() to use registers computed by
  is_scalar_branch_taken() for true and false verifier states.
- Adjust reg_bounds_sync() to consistently bail out if invariants
  violation is encountered. I think it has a few places with implicit
  assumption that ranges/tnums must overlap.

I have a stale branch with these changes, need to pull my act together
and finish with those changes.
