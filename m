Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26233C3795
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603036; cv=none; b=fOVUuAAdqckZexBPQVfMYAL7x2iORnBD8xyDUAeO/ctyDe99zQkP++JqEWX7Mv594rjrL0F2Hiqb6hkvwfNKZWuAqcdVorE3ilf0takAKXwUOgaZyc+d1/DYOg7Gc1EhoLg50/JdphP+sSN15QM8Byx9qo/RM/dcta7G9cCSo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603036; c=relaxed/simple;
	bh=DpZ2xiYBZM8RQJtYeEHnH+ATTOKfUkIwDCHe3yO+TEg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qEhgRRyhLq7lL/mJsVOsIJmOP5jIWOJamq59ZOkBHmVOWq53Q9YhtbCKVcCsjXvk8jm46OtsdOITAyvIBCwZGuchKhDRer1/MVq0PVv9WEZBdx/bH6f6ochmxWOmlKBZJGLlOmqdjmhOjXmaSVpM3Se15txtH4p4rnm21TM3NXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJwYR0/S; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJwYR0/S"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-42c0b0ffac1so3207408fac.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778603033; x=1779207833; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK365V6RM40TQNol8n1QSn0zSR1IluIGF/pVznNt7N4=;
        b=sJwYR0/S6l9qWRtmHyqV44PTksuccf/LrGfnnwAuTtSyLLlMb+8t+y6TlMRy03QBYr
         3nfPzvTEb+RSISWUBOa0nHlkajhmhQFQiyCNGODrEynYA5HJf//AZHxuftScYGyRswdD
         PMHLsS500yfqD+a/gaOAtU+TubmiGyOtK6zxvQiWg9WEaGGDO+MwDfTp0Ce5Ok1D8Fhl
         iRZWSHGmJf0ZrM/E3KliefT2xOTGmZ+QnQ4/PULNjrcfqE7RGFT7gKS7HxcdCQA87yic
         WrA2Zy4fxT1nT8tAOOSiaDMOsISj/lJb8IrU/LQKIuCQGs+PqQDD6oqjEVm1J4+oV/9f
         f6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603033; x=1779207833;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YK365V6RM40TQNol8n1QSn0zSR1IluIGF/pVznNt7N4=;
        b=LpQGPkOsbWldUM0NY8m1fmXuExswnhf36D4NzIVXGtcq/jXODbJVszdfm1tjWwTLZW
         T9A/4dskE4PgqDrF06HxCnsoMUczyhF7NCKRg3EvUEDOU0/Ii0HT7cgOwQ98LgjiiSuw
         sbMUDa7xs/7A24EHmVSCmSEK5OpCEnXHwLXssYEbqYGTfeLhvqgUlWzTFBRi0nsRd4nJ
         YqDC9UwTkBxu+R0BEKtSu8yqHGVbL4Sx8XxdCc9Rcg9/KFfhH/YEMN68C8Kb1oRCHLNC
         OYnfH6GtQK/dC9OEioT6NyZflEITyVAZyLHOmDzlbAnpblE86NUzKGIDKsNt/KU12dhs
         9OiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AKl8ThllNtPLM+ep9tfXG70FMDVR7eeEk4GKNiyzZVxEiPq1cSQh2b79kPV6zM4olR8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6xUkOlUVdMQs1POm6BHcnUMOplkfB47TLSkoYDt1k4UcHUHy
	ThMXzQBRxfjAGcixkmKJFA++zohUxnrhe69/z1hW4dHCJ4BuTOSKNA8Z
X-Gm-Gg: Acq92OGL+EoOZhoaC88wfm7SaDBAMUpsrq+84NPApxqKcV5Wunv7C6rPxtKCQhloIpn
	cinDPuOD1FLTzoYKkG/utpe/XyD2HaXJtN0o7yjGC3RU2fmn2DHvvTSDpmNIYUK4WXicRQjQeMr
	8kp971NmRoraa81oDlZt6Y05KDAnh31HY1dVNileYvknTV1+U5ejo4Ebs7Ie/ypkYLtMzg+lN1Q
	jz5sokvopiFCkLABGK4F73JtTkBRe74aKvoqRHYi00zenp5K3rxfNWZhlvcssSawtfsvnBeVvJ/
	p5IjWyMpwCPwR1bhKaXD4uk1v6EscJifNQKjcRSiS2mpVFtgrvlbZCC58x8BFJxtF8G6Ki9mhZ5
	6hRP3pRZhJPAFpw4mFKKtyYw2FIXo27AOQHfiwRS/KuLbLLaYsISN4yLtf+c8M/wN/c1ltqAM8f
	zO7HYMuiRFYsfP+ehxerZuQK3tls6KPMXB/b72VFJ8uxxw4fRW6yVcF3p9Z/UCSzAy2rMPjhy1S
	Ta82EY2qNy8Ro5YatzGPBSmwEFN
X-Received: by 2002:a05:6871:8116:b0:42c:d8b:5aad with SMTP id 586e51a60fabf-435892023b9mr8467968fac.33.1778603033383;
        Tue, 12 May 2026 09:23:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355710cfccsm13562494fac.8.2026.05.12.09.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 09:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 09:23:51 -0700
Message-Id: <DIGU5KQPXPZN.12PNWDRIDDG9L@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <jose.marchesi@oracle.com>, <kernel-team@fb.com>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf
 functions
X-Mailer: aerc
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
 <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org> <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev> <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com> <5a0b1bdf-951f-4a0c-909a-8c7b0ed8cdc7@linux.dev>
In-Reply-To: <5a0b1bdf-951f-4a0c-909a-8c7b0ed8cdc7@linux.dev>

On Mon May 11, 2026 at 9:17 PM PDT, Yonghong Song wrote:
>
>
> The insn 12 (r0 =3D *(u64 *)(r11 +8)) is considered safe
> and the verification succeeded.
>
> But this is not correct. The verification should fail due to insn 11.

makes sense.

> If we add the following in states.c:
>
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 45d86bfe3b68..877338136009 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -941,6 +941,9 @@ static bool func_states_equal(struct bpf_verifier_env=
 *env, struct bpf_func_stat
>          if (old->callback_depth > cur->callback_depth)
>                  return false;
>  =20
> +       if (!old->no_stack_arg_load && cur->no_stack_arg_load)
> +               return false;
> +

...

> With the above states.c change, old no_stack_arg_load is false and
> cur no_stack_arg_load is true, func_states_equal returns false to
> allow further for cur verification, which enters insn 12 which will
> fail the verification.
>
> What do you think about the above states.c change?

also makes sense to me.

