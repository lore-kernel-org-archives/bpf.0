Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D932ED40
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293865; cv=pass; b=taeT3RE+a6NyTsu6RGF7b/H/l8b6n/ltlmV4Pw5U4i0yBDDRsCISWVCrUPKQuzaRj8vbFs/+XUMHc0gbxvOUrX76Vk0Sy0/0LEvbAaHqyyAmaxV5lsXSyJcEpOnn0DVeelNBNdYqWRw4CLY/tslInXrRE6+d6Ds44i9uWKe6PF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293865; c=relaxed/simple;
	bh=loicyaSIKacT3UFMUJ19/QYRzlY6aMDV2pQS+mvBMAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqkBZiwyED3MKDSXDjJYfUreB+dYM37FlEndJUW+uEKQzSYkP1a+UqChNXdvCUi4nD2a6M7GvwyPvEZl2VrBml6hX1yk3KcO1+PtHXSTg4ml1SEsEqRXGgK3mkCbA6NGtYVBNeX9FICKqJCvV3sOvp/He8KMQZeWQLbxi0Su+NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnikqe7Q; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnikqe7Q"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so1421428a12.1
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 23:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780293863; cv=none;
        d=google.com; s=arc-20240605;
        b=BdrrE73mzwlIbrqDoND/ZOB7GV4JPpiSxQHdtM05IIegiM1Gml8MwihL4vf+JZ/7/6
         jX83naVOlJGVKoI5Hz4jr6NPoWz7+748v63bugetUU/87jxWYYyJWHZJNsEqV7wyseVm
         Ctq3W8RZD98TufUwPp0jAe2+u6dZX/ofu6jkcsqiK4LOPNm/DcW4NvqAndAoJs3fZpgk
         7v5LfrFtKLvRMPuAK8OAd7/GflfxJdXydwhRljrDpo0eXwuvfPDruSbI6oYMIGAvrKib
         2vGXki3oiy/ykNHrVvegLJXahrQdne28Wx7cLClVLRMaoNz0uor1q/DpVD8svwXyqycK
         x2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k5U4blnuS29gnJMSouEBsqgnyTt51NshtQjYFcOoY6o=;
        fh=5unDkGLaZI/i0EiRVomuHngjm1I2nKaYbKd+h8AhTL0=;
        b=bDU+zBtfPoK85P4X2vVkDXC/d2f3ZTmLGL9YzhJCk2B+R1s5a6ebup/Ai5JnTuTMIT
         Ir8bWbgJ9ypF+gpcLt/o8y9o9gS8yxK1h8xXAfJl3UoyZwq+Qo/CSkyHaTy+cKWBTc2O
         iC2rGqOmzPGKcbPEPnW0E3T+QQq2zdNZ/atD74GU1nOeRreIeRTOxMdtt6WMn5REPLsq
         HR1s6yFW3lOJbktEQuXQFRx3FtZnlVzqd06ohxslt0sxpU95guA6U6h275CWcxL09nWB
         ACLj1xwWBhjDk+mgRwWU0olMsRgnPrbGgkBQ9Fv1y6fmVoOk/c5DcohqCUTQ/4G6x+Zp
         pzcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780293863; x=1780898663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5U4blnuS29gnJMSouEBsqgnyTt51NshtQjYFcOoY6o=;
        b=pnikqe7Qq91TAn4cU9343o72h7PtT9Atxd73kFP8xjC3Ck9tZqtIrxux0NsiqQ2n9w
         45+RGhG7vyf0yQ5mBXpZNCFPlyOtKZBBBxQTz+P6jdNYWDjMgmpUNG8OJt6HVeCC9IT4
         RhstF/lC2D6tmw3qKZE6XyU/CWu71Z/0sZZvtfedz1PMWfT6OtDbQAqZp6+x9seWPqJ/
         bKJreUMSp8TZ3tMUF/T5bO6Y1zpx8nDSLIgRHUUa0HQP8DpPN3zHiOj2eaQPsj4OZRs5
         JyXLbSiT3s5RsIddCNQmrbhFcgVvbyjmvySG4zCKVRwio2mBYk7saHnY0NNnZ4xfITzQ
         3QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293863; x=1780898663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5U4blnuS29gnJMSouEBsqgnyTt51NshtQjYFcOoY6o=;
        b=lz7JYVex6MZVmaDtivl8+KeXhp4BZMh7MtM21wUd+Ht0LpHqD7rh+9hFKLCPIBL6yr
         Ed7gxEDGLjqswdfBhLW+NZboqqEOBhVuhn59pArO49+HobxPPDp/qvw9hc5IskCN+CUZ
         vvxLFfIOaB1/3JOj51sVTH5jKMN2Vxrl75RW8YOUbJcehEShstmpfBsNqx9pAzNyS4b8
         rp6ux7TzjRsDyaYb48gYqFla9gaxAvcE87SN2vmBrvNXR+0FJs//x7lYntUNOOPGtwIG
         fnsYZSD3TgqL+SxJF6x4QnKeAY3jPE7WpFXsEFooJeHlv19I7DWyQ/bvGnk24zZTkRIO
         LklA==
X-Forwarded-Encrypted: i=1; AFNElJ+gXNK+hwgyVyoFjQr8wYuAzhJ6i25KOV8l7iYWuuRZTG/4cWz0+LKjZC6jgWNTWnUD/mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyduCIk4hxC37ShAGXp2YfrQcpVVcSPEBVjDfSIzP9yvDxRE85U
	Tvn4pkx84v9dZiK2X7zWPuWhHM8ZXN2RHc60tPMOr5SxR98TKhdfNpHu+UyCVowq3V1UW/Y6nBk
	FMjJn39FUIcaCC0XbdmF1VcOyWKF69gA=
X-Gm-Gg: Acq92OGpRQmitjHWZsRPsvdkcq08MfoQPj6rrYaUlGwGbPcfApzW2lW8CpDpmTHWtDG
	2PjzE2e6+asUOOB451npHo+c+YZ4jJIyXE/eenjzZdHgljc0YlF3yHuqD30mQuM6pxFkYXFSuww
	xofq0r0kZOlBq49oXTV23cBHkmsK8YUEx8VG7kwh9DPLJXa6L278p7d3lDbX4gtlVJStJWb1MH9
	mCId0vvDgo0mdsp3I5WuvSaZaTL6PJ20lwdszuL3CYAilHLy/dw4pAlqQVtuc9Ck7E/PFUoIam5
	HMLRWdIDsZSQpow5i+c=
X-Received: by 2002:a05:6402:4510:b0:687:74de:985b with SMTP id
 4fb4d7f45d1cf-68c8c561c0fmr4537725a12.14.1780293863001; Sun, 31 May 2026
 23:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528062155.3988156-1-hataegu0826@gmail.com> <178027560516.3443781.11705215616764330591.git-patchwork-notify@kernel.org>
In-Reply-To: <178027560516.3443781.11705215616764330591.git-patchwork-notify@kernel.org>
From: =?UTF-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Date: Mon, 1 Jun 2026 15:04:09 +0900
X-Gm-Features: AVHnY4LCt-nmaivQzYgUXJGt-M1rknYJfRCxdAzPDptWZgfPUztbYR3IA_6FPwE
Message-ID: <CAPa51z=boV2KH3Xkh8y0jrcENA+ZeS+5HsO=Pxdb7V2HFCVbeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: reject overlarge global subprog argument sizes
To: patchwork-bot+netdevbpf@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	shuah@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, 
	yatsenko@meta.com, song@kernel.org, puranjay@kernel.org, emil@etsalapatis.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Pavan, that answers my question.

I will drop this as a security issue and will not pursue the defensive
data-path checks for bnxt_en.
Thanks for clarifying the HW completion contract.

Regards,
Taegu

2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:00, <=
patchwork-bot+netdevbpf@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Thu, 28 May 2026 15:21:55 +0900 you wrote:
> > Global subprogram argument checking derives generic pointer sizes from =
BTF
> > and passes the resolved size to check_mem_reg() as a u32. The access-si=
ze
> > validation path then uses a signed int, and stack pointers negate the v=
alue
> > before calling check_helper_mem_access().
> >
> > This creates a wrap when BTF describes a pointee size larger than S32_M=
AX.
> > For example, a global subprogram argument of type:
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v3] bpf: reject overlarge global subprog argument sizes
>     https://git.kernel.org/bpf/bpf-next/c/de36adca6346
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
