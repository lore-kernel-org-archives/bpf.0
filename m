Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978B4ACC6A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147808; cv=pass; b=nSODc4MTDP4SXgkMhTZ1gR6yLhFaoC98gGl5yDBqktYpTRDT151+NZ0d+5PlYT5alyydYjNckYsX6voV0Z/BQ+ARsyXimyg5VKdrBVf7sPxs5dvMuRgjHW/d2yG7iHaJe6+yZdf8AIZhJPEWgZT5WtEDzuZef4WN9nb3C4SuaQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147808; c=relaxed/simple;
	bh=5gGgsI8GcZxHT9usDxNoRaPkDvtayTcX43/EEKCySws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AERqsBspzyOE6z/UtElxzfW5Kk0CDP+gOVVp/0bAPapVmUbQGbDvD57Z+USwnACMiYkDiwLThceSssCFFTi+CtzG8MDZrPAZJq5Jd6iSUlsJze9jIq7QNXCMNtRG6NtLrXsYym+LGqb9xBpbfZ3vg8RZ7n6Ddt33gsGKx1XgHWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdlBg6Zn; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdlBg6Zn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1168906a91.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789147804; cv=none;
        d=google.com; s=arc-20260327;
        b=O8o1o7gpLk/A1Ccq+mwOEVQQFkQJXHTvreLar4Ew0cLgIDQvAr9ibhOElUUJr0i+gu
         CLyPgwkiYpBt5ZM1tRciTWzYSb4RloqXfB+dYMcBDdmsNwujJHPJKTjCOQBKOVn97Z78
         Ws8jb3KbDgLelIgb0NZ4M77MMwtNxeAYDq9QdVr/U5diH7NMyvZPLfCyRHm6fA4TDXLx
         K7ikGNf/K13LnLis2ZJxsMNuxla+q7sI06dY5ys+q1fIiwT55kFVi/Qt0cc7NirNoat/
         7SOA4Q6nSIYGsGKvDCahebD01r8Uprpb94SPiJctSfNUdZLF3PiFgA1wSXJ+udt31TdN
         JLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3NF3c9m2fPvi3tB99v7eLP1rvK9UDMOvXE6ZSXik2dU=;
        fh=Tfr3Fqdr37ue24Cnfvyx1LoIoHRadvkEVNi2dxwIfrY=;
        b=kePCUMe5+SWCmXBzQsyXKEpWO7y6QqK3Lu3pOnpq6nL5gxgUC0/Ih9EotpF9/uC3Q3
         ULlJSb8jvQA7ugwsz/3pad1hH8NrPGiRFOE6mE86nFuOWJCRMsM4oLc9WdN4RfEGW2dZ
         KWz16J0UC/CN80hpL6dF4FSf+tHP13ehZivM8O6BYs41MxxOJ6/C1Ra00d7hkXCvfd65
         XTcCqmhk6llI7q7/xbr12ZVMSJSCsFF9OyfQU67Im/oleEeRAtRq1priYGK7R7FwfQMT
         sDJ8hziUMUkRQKsDCmSHXGj7CWMO5Rt6TGOpjVd2VfM5UJZp7OLIwYXgB9TMZfnCMl69
         CoEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789147804; x=1789752604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3NF3c9m2fPvi3tB99v7eLP1rvK9UDMOvXE6ZSXik2dU=;
        b=rdlBg6ZnxG25/TBSGPJZ8kJCaUYkZtyxZhaOVvu3p28GHdzTch4t7gdwoGevqlnhsf
         MHh+jP/KAUO6RgQS2WqwQdlDuOYTraPjeTTCOv52+hCIs0i7RGSpLmHzP76hFYg3iM/n
         24pk+woCyjemKvEeZCkM2H7khINugREZCOOTRnYTZicfHwh/KSlDonbGtBGFUnoJQ3Yo
         A6KWlx+lTvBQ5+X3Cm9OHiGUNqr+KDZ0pSsAKaSXTiUtgzibfQ2r1Zq2W+ok39UYSdRi
         gr40jw+KtIlsQFDHJgRtD+JQwG1sF/8s88iucl7NrJrR31EcTbqk1oSEzMIbgGd5VE2b
         aFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147804; x=1789752604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NF3c9m2fPvi3tB99v7eLP1rvK9UDMOvXE6ZSXik2dU=;
        b=A03zqxZ8aSkR30wBer45DZkZ9nZ8BsHeUv7o5MULBF7dgcGyT2Cf2KuZGwE/f+QkIP
         sZtukfF/20GRqQCVFriwxwYpceSbqrqw7e/S28YyhCz9OCJhsiZsDzieOdyNMj8yeiL6
         48ixiBzOk6b9SHj4zZOHET4OSP57jW9rc/VfeD4tsXDQdBPdhUQZb8eqySvpSAoWyNez
         47VMgDFaOZAE96fLPi5RaJD2axOsbmFS/QmhVmDwU5irKDvVWpeBTxN8FjM9sciXnRXG
         hbb225wCk/+dLUsqq7n5i2eQblrTmCMN0WL7vy36m3IxOuj37xhSM8J1DmR/DsrCpc+w
         8zUw==
X-Forwarded-Encrypted: i=1; AKwUvBxb5f08iBkNoBtnJsrntq3gSAALfAI+Lw2gWtsPbJr5UuxfzO98o/HHpMgPRFeml0za3AA=@vger.kernel.org
X-Gm-Message-State: AFuF++lIbJ8UrcGhBbRWTkJbSxJlTQKjHLOtM7ngmoT7CjvLD4zTBINh
	HGKinbKukdLWihpTv9crzKprfTGC2UYBLkuMczS43wgK6/RJr46I9RHm7u5HNe1hTXtNn7qbuMB
	QxLV1vrdA+6IiN0gMRshQZyRLiS9OtHk=
X-Gm-Gg: AYBFou2cAzfZQnrKoJEHtE+oQrk9xrcusfFYqF2cZPuSVhEzN8g3qIVo/Kb9Ad7MGKT
	/mlptrfvxRtUbRgR1g4gHTwZCg5+ELVyn5jgl3W0D7x+VDUVRLATCkdnb5MUtUbfSsnO+ZFg2m5
	k3rqOQfCSpVeqcVskKMb75jbDcBSDDIDF83yxQYa2O/PHFNG3mVNM/BoNljxbWXsRAQtcw1enSy
	6yDgObkuvQKoV4xJY63p8P/oMoH3k/qooNQCHPpgH5nFVT6CzoEw2J/K23kcWbru5vYpG88f4qa
	oZgo0CjSm2Z6HETErWeOC19utFNKZ6gYNZbsio08tlZRSIcG+gwM/zfkL9RIp12l1SRcCDsG8nj
	S6XbmYvmNS4r59SO8btZMnFlglEeL3hD3NOfM
X-Received: by 2002:a17:90a:da8f:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39d9bc1007dmr7733663a91.5.1789147803693; Fri, 11 Sep 2026
 10:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 10:29:51 -0700
X-Gm-Features: AcwNN1Wa7DKAysUMgK6DMEftF-wB06LhJaFnpZXE780rtwUke49YbR0GE29az_o
Message-ID: <CAEf4Bza+4YgmWSVvpW8=Pcf2HFNkW_eFSHAaU16ei9mrf8Tt2g@mail.gmail.com>
Subject: Re: [PATCH] tools libbpf: Fix signed shift UB in btf_type_info()
To: liujing <liujing@cmss.chinamobile.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 1:26=E2=80=AFAM liujing <liujing@cmss.chinamobile.co=
m> wrote:
>
> From: Liu Jing <liujing@cmss.chinamobile.com>
>
> In btf_type_info(), the expression `kflag << 31` performs a signed
> integer shift. When kflag is 1, this sets the sign bit of a 32-bit
> signed integer, which is undefined behavior in C.
>
> Fix it by casting kflag to unsigned int before the shift.
>
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -259,7 +259,7 @@
>
>  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
>  {
> -       return (kflag << 31) | (kind << 24) | vlen;
> +       return (((unsigned int)kflag << 31)) | (kind << 24) | vlen;

this was recently fixed as part of slightly bigger set of fixes of the
similar kind

pw-bot: cr

>  }
>
>  enum map_def_parts {
>
>
>
>
