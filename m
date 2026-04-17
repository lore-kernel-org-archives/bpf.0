Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BA1EB5C2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435405; cv=pass; b=KR6tHyPBSPux/19r6HBOFVV9XJI6Y4/h/YiYnEqcxQTK/X0RDURA0DGD246vGwfFUmH/Sgb17Gi5qhCVzRNraOBRMO2Tp2YTfIC0FL59uH2THVta+AA+yBF3nb53692W4L3kKyvu3PMTrbu3VdzMgkWFGYI3IG5eWLVmXHVn52g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435405; c=relaxed/simple;
	bh=mgPffNhZyv7Z3l2lmLM4G1m+pGVDz1/KYm7DsTD03jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnbXLThJ78D6o14yjxL8yQPmcHyhztiq0QMvD4Nc0Svy09foRFFg9M/E4KeSKxONykdEbM0fYADTxHh2EbTLlQf6MXnnVdCgmLLwm7DyBrm1bAe3dBYjS54h/YZRb+FRJIIqMwqUDsf4OSlfLWu66+t7u4+oi+qqhkz49twd5Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exAyUcgj; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exAyUcgj"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-672a2179749so1391049a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 07:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776435402; cv=none;
        d=google.com; s=arc-20240605;
        b=WrnYbRAY48fVzMWCCzwo1T8f/g+hci4f6Pk/C3ArAMZ/H79yajw2rRI2XiHfPYdlxu
         2puTnposzJnGASP9MHgtDQ5P59JGiV0a+z2Ht1zKDusr4C2Zx4G+PNT0tZ/yxEouCUVj
         suOkBm9y8Ea3BeL+TQeaTdodDLGxYAk/zfolfXExsInQINX+htAngtDrth2GKexmw0rd
         PUuIl9w+zRFAazSNL1Y7DaQewJ/L+8BEa9wVhBnpA/pSzBdZFTL2bMzIQsziuvR3TD+K
         qde05T3QX0YGdIZO535cHf7gEd7Jl7as6mCiwRsf6Fq1GUCZkb1uQ6i3U5yZpWLiZv9U
         6sMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UGzzQs2uZZdZYND8MnY8Zz4KYy2T9nTawA/A8pPTQ04=;
        fh=ZQA9B80x3qarM8bLbpl1sGCXUQ6EOJNJyiv9mfemg4s=;
        b=TuobjExIre2eAiivMGSCPIxyYvTbh0j1NT9c1xbwBLJo/EFu1N6KruPU7TNWgQgi6f
         K1yZDhxA3hztPdqzWLYd4foGYbnsNQbCj2d4Fm1Rw+mFzZHv+zh81Ml6rD3POcM/vYiw
         fGa0IimeXnSa5erYl9OYcw7TfQPtY4Zwf2Mk0Y3Z9mi4XCk0NgtE+l2oMXipYIhVYrEm
         lF7cXm8sHDCDPHEox9Md6dLrE7xtXdzAolw6KzY2jncX7F3RtT6Z0gyDBIkvoOWgEnKU
         Y7TGcu9gOPtr7xy7EikiJV/SEAsJ5+fQ9oCoog+lftZ/wEBnK6ZAd5vLM+gdQFMFXjjE
         QoqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435402; x=1777040202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGzzQs2uZZdZYND8MnY8Zz4KYy2T9nTawA/A8pPTQ04=;
        b=exAyUcgjVmqWRT7IyDLbDiiyYVCQd3Do7LBizGI2jn/COiUM4SgsHx+ODDWHfbRXye
         xqFV+AFMSYrexGq/53DrTPPR2NoZ2p3fkVgfyrnhkY+NBwHfiwoIdY/qCI+ZBMZaAnzn
         keO7cVFEbmuU58JzNpDAzlKxb2mn5TpGf0w/shlIBjpTh9AaSnI27khINolK/A+a0qjj
         E2l0VFrUdl0ykSm5KiS8s2awXNPPk7DaxUJz/+Pr6SA+iFwg1/lzokEG9WjgnPyFVHjv
         0BqHlBJfRFP56djJp/FzK48fOLZXQOiHmKcyO6TSQ7Sm27GB9XrqeV+j5FOAXdusD9AX
         p7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435402; x=1777040202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UGzzQs2uZZdZYND8MnY8Zz4KYy2T9nTawA/A8pPTQ04=;
        b=djBSA80GapuQitZidKMD5BZPk3Qwss0JXPeuDcLSxP8YD5kApIvfkpr+eRMTfnR6d2
         zz8M0HRI8IBB1SyrmqWM/xmjBDzyvFcbAj6puv5qxxJeDAjl9mYexsJcnDg6vhrfxdMK
         s3NpRZAf+BvNbAEZ6CQHbZ0EHz/l7hpj6wbwclyP8uJKuQr2EScM8TzE0gbWJndk79Uj
         iimyr3wMt1zpveaxv7myjQSQ4hqSafiH3XySh/0Ixe3QrnkPJx6c9nenEwjzdzTs9c/m
         T1JISkn2MvWxZx8twzEE9XeT7/o86ezdWQGLMMVBm+BDmI4pKAsQSvkFOWlZ9p5q4qPl
         Ljvg==
X-Gm-Message-State: AOJu0YwBRjTsE7lvIWqlPU71lOYTAdEeIo4iPY4SnCwdMzM1v2QP/P8K
	wZo4gthB1aPK6oMf7635T5QHXsoiaOPti7I+Zhm3bFfxDi/EEhWZeMm64y2QhAbhGL3NWNGKA5w
	1wW5m/CYGKAxlXyu9pO6shqBkHrxXhsM=
X-Gm-Gg: AeBDiev+O66grpnM6lYxXuaywPUSEA8kziQOqCIFKPH5+2KVN8EogtnvpvbXVqbY4LP
	K+tdGQh29eqHC/GUPL9B/O3MKdq1iFNPivCDrmRUMP7j6dgbRoA9nodaLEtcWOra5N9iQOkU9RW
	qaeK4+5PittCNvVKuSEZjw3vYGS5RS4hY5Vq365uJVPhYtXEctOPIgWnQ784xS9eFDh+wo48L03
	5jcj5yJRtNGs5lIZ/J7RSPdngJmUoIWJYliiLirwWde8O3ej95rIcBO8aeT7SVSPKrPFqIFnE92
	N/buFk769Io/pQyGu7OGqFtTyg6/tq8+oQ==
X-Received: by 2002:a05:6402:35c6:b0:66f:9480:c1e6 with SMTP id
 4fb4d7f45d1cf-672bfed996dmr1742162a12.26.1776435401576; Fri, 17 Apr 2026
 07:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417103004.3552500-1-puranjay@kernel.org> <0e7bf7fc588d9c45349a7b5b7b7a86504bf39069d9b7a043b53138604547f267@mail.kernel.org>
In-Reply-To: <0e7bf7fc588d9c45349a7b5b7b7a86504bf39069d9b7a043b53138604547f267@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Apr 2026 15:16:27 +0100
X-Gm-Features: AQROBzAEa93FzLfWVDmPW8ghL64r6d2f8zAAX9cm4hvIEfOffFG3de6w0DRmHAA
Message-ID: <CANk7y0g9V2uK=162OMN3gwDZ1161nd+pRXZWDEt=2VOybO2M6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jre@pengutronix.de, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	linux@armlinux.org.uk, kernel@pengutronix.de, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 12:17=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function prog=
rams")
>
> Is this the correct Fixes tag? That commit only modified x64 JIT code
> and BPF core infrastructure for BPF-to-BPF calls - it never touched
> arch/arm/net/bpf_jit_32.c.
>
> The actual bug was introduced by commit 39c13c204bb1 ("arm: eBPF JIT
> compiler") from August 2017, which added the ARM32 eBPF JIT with
> BPF_CALL handling but failed to reject BPF_PSEUDO_CALL. The code has
> been incorrectly computing function addresses as 'func =3D __bpf_call_bas=
e
> + imm' for BPF_PSEUDO_CALL since the ARM32 JIT was first introduced.
>
> Suggested: Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")

I knew Claude would say this!

39c13c204bb1 ("arm: eBPF JIT compiler")  came before BPF_PSEUDO_CALL
was introduced, so the bug was introduced when jit_subprogs() was
added.
The fixes tag in the patch is correct!
