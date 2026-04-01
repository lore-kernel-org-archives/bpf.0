Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A21F3B8A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009775; cv=pass; b=jAK2RWUmo5Ua2F9cA4QBK1VDudSKnefZUfnQdGPwOX6MvbTLNn2v/q6ygFtT1Kt6ja6Wq/AMnnUdZy8d4OwN7X/61XsoosKypezjY7GHltNlUnf7k5g+Gz7kqOt9w5nZh/RToQH33HRV+pUJ+LMzuWl9dQAST+MaSwg8383PE7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009775; c=relaxed/simple;
	bh=BU1RL5F23wyVh+enLSpDdlRfp8D4irTR9/cZKaegia8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFUel3MGZJ5UhVRo88ra2zAExvQIcxtr3Vrtl74+IOdzAEJ+kQpgeYZsywGaXWPz4SF8Rj0mymDjjJMrggcRzis9CA53RGMhhRyUmvZhkIcFWl8+bp7bBQbBnwBB/iLPIxf8G8sMKEawdEPHR1yHAuyI//S+xq4RGqce+4yatUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neWMN+gS; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neWMN+gS"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ee5037d44so5502877b3.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775009773; cv=none;
        d=google.com; s=arc-20240605;
        b=K33sPMDYFY471AUEBVgw1bM0W8c8Z1LoCfL/kOk7jJsPNhT2xVzlds7gqGEBfhlb7/
         eviVuo2G4njqTeeCYKym/WsK9S7GWvNXjToVdZmkFUkzJPMAOjckpSEgJao3j6j5gk1Z
         Ib6vogus0gZTJkRkIFxMGtxCG8W8ea/OITXD86WC9jNP6m5McRNjzIhncviUVCSy91aC
         KLfQVS+dnAE8KH2pD22+6AIcm+gcXQ7TYN7zohUNwnbKBQkX3eW4LD+axW4UGM2ESGmb
         l7CqGXjkpHlNKBz6j5rNCnd4CC38ijnHSo4PD6mvm0bx+5imzlYJlo7pFXlC/xTV30xL
         woNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5rI53f8SyeuhRXg2C9FEQRhaD4VvqH6jVFUBF2+CmQ=;
        fh=jLrlXpAN1N+6I2c7BxDrN4VK5iGiuQSN/y4zidXjizY=;
        b=MJN+bIP7J1D4WX+Bevda7C9dbRYRUYtS5bIeOQzZeI0DRNI1IgOGkzSUsm1FwjSLy/
         jMo32i0TyLNbWVQx1SLCX1nxL7NJ0mrkzG/opHF/CvdYqR5eSnEaH3ET6dsBejPTwjuw
         nrvOLDSe91Ea9V9Ejh+OsCyb6KCUQUI+ZdLCH2xREuSeYd4Z5K/Fi+YQ6Igp68bmB3Jd
         1bae2BojaLLgCX8rw3IWpCL1mbzmeJLZgOsdQD2FcnM9/z5cHB4gJqTRjvyMTPbfRfkc
         qY0AFSko89M/wQTqhumEj03Zkrv90lu2sXvDXKqdRoYcQgDVCZrmpthYBbpLMEnP2ryM
         tqOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009773; x=1775614573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5rI53f8SyeuhRXg2C9FEQRhaD4VvqH6jVFUBF2+CmQ=;
        b=neWMN+gSP7cgwDe2O3H2MhetRFApFAyu0intjLjBLsfEdt/MNLIU8eD5wW3VkIXQJP
         Kb2NyOvDdH/CVgW0P3exnCZv7h+x5Geman5GSKu4c/5u38Vi+DXWFAI19RQTp8xPw6bn
         0HzzT2Nws//clGDVAmxKsQM5HgjXIio3wSvY8F6shUs/96lLZAvreLoHYww5LMH7QxuQ
         AoNpDi2Xc6eEgTz2fFivRaawYLVLylFU2aBkkYZ37I6/IBNup3U06kUB8S5wWJVVO5W/
         EBpKyvm1qLlkqezWuPYvENO/BZiaB5fvS43QCqijbXggr1EzjD1yHO4PZ7197UHo0NB4
         eQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009773; x=1775614573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5rI53f8SyeuhRXg2C9FEQRhaD4VvqH6jVFUBF2+CmQ=;
        b=ro3piVBPIy0Xu2P7gScWurfzEEbN5F2gVYjr11SLuWuYAzLkB3i89weVXeWuFXAIQD
         VOm2baAf9W9UmHM7FPKI3n8bXPZOnY5kdpw1XpYEaXKspQ7WIteYuWKjXCO5WoL8fMqe
         vYRlqYfrUcNVmBn2TKgH9KiwjYGrrNXSYXuuuj4eyKZiVhZEkLBbmtph92Yi7/Ph6yb+
         9afTdBdyWXsaTAd6QLpmfrxHOYuY/UV+wLrY3u3l5OmFGvWJ+GzetnD9JY91VJjquVKC
         lAGUvsK5kAxJtTycHevl7uxnY2IFzfC9G+1k40KG6DfajcD07KcI6sC8pXcuVmbZBE5c
         uepw==
X-Gm-Message-State: AOJu0YzGbRzD1npTVEGrRS708lp0OJrSPZfH424yA+VnFB0e2biphmEv
	fDL9pC3QW1VMuetTmXkYEGJWIePj5qY8V9O31m9DRE7Z5Y2Pm8Lzn9XwCw0usGvvkxmRr6R0ula
	r02XarntWheCUm3yfCM8+Pegb37ojhl21WxoZPCXAx9NNVTc=
X-Gm-Gg: ATEYQzyh7GBal+i+PQqM5go/OV1K37GnJOKD/E94irhri0q4v/KSaVxpGQ2jd1MJaFf
	pdJRg1EWlgPLSjPa7I5EDRwtEjw603ixghWFHJOVo7B27yYpUJXYd8tPDPr2R8oU03/fgxenSlz
	+yX3kqYcRsfihkPk7lUI7Nm2hgiDV4VaMdX8AEJCvm6Dr6lftNyFHME007Gk8RWEwexv2aFb0Nq
	Z8p05C8Xa3aXLuSFz021RCXb0bNhI2xb/HU1djAD29KVjSeSZMQL+TKxXKvsVyxu5TyUvONdZkk
	gdSOg9jhkomzIxyk3YigiZDpWXty9aFbSWcPX/qTbA/Q6cBcxOomombKSqR6+w==
X-Received: by 2002:a05:690c:dc2:b0:79a:b8d6:110a with SMTP id
 00721157ae682-7a20f2f9dc8mr19652897b3.5.1775009773562; Tue, 31 Mar 2026
 19:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331213555.1993883-1-ameryhung@gmail.com> <20260331213555.1993883-4-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-4-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 1 Apr 2026 10:16:00 +0800
X-Gm-Features: AQROBzDMsjT_FSpW1jxsMDkCsYcHuw26GF4zoUWN0JyXZDtvSSZGlBNtoQ6NiLs
Message-ID: <CABFUUZGdwtqZNX7q5KsTgxUcX2SBtm0xgCo7GT1BeDQcYKFaBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: Make sure TLD_DEFINE_KEY
 runs first
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:43=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Without specifying constructor priority of the hidden constructor
> function defined by TLD_DEFINE_KEY, __tld_create_key(..., dyn_data =3D
> false) may run after tld_get_data() called from other constructors.
> Threads calling tld_get_data() before __tld_create_key(..., dyn_data
> =3D false) will not allocate enough memory for all TLDs and later result
> in OOB access. Therefore, set it to the lowest value available to
> users. Note that lower means higher priority and 0-100 is reserved to
> the compiler.
>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 366a6739c086..e242c455ddae 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -278,7 +278,7 @@ static tld_key_t __tld_create_key(const char *name, s=
ize_t size, bool dyn_data)
>  #define TLD_DEFINE_KEY(key, name, size)                        \
>  tld_key_t key;                                         \
>                                                         \
> -__attribute__((constructor))                           \
> +__attribute__((constructor(101)))                      \
>  void __tld_define_key_##key(void)                      \
>  {                                                      \
>         key =3D __tld_create_key(name, size, false);      \
> --
> 2.52.0
>
>
Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
