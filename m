Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C9156677
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316660; cv=pass; b=mAwWG5WUMHAhslkq3ffL7DnKo2JOn2/rGJzliaV+lPkU+oDTVydm36wdmv3EnsXEPmDyPvgWi/873UYQvNYdjQ3OA/5gvBS8ZxI3WxXmr3JH723MoacKnjLCEgCheix9q2XTWs6Cta6dbsTEoRVAnw2f0PefQWzP/RJaNA9dZVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316660; c=relaxed/simple;
	bh=eN9OIG5xOOm08psjunbqUmZwhSjm3/YrUhUY73RH+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyY6h5S/zAOOdKIEly5+WjTe5zjtxVemV2aPFWx6dBr4XA+HtA5gCu6t2Zaz3/cbrONOWrnvOTvT/vKvyp4gUnK73Z4pXKRmob3EXQzZMMlvVVhOjpJ8704UIQBH9tGU5s798WIFQS4Yx6lDSxGF3os6drg9CB/0vbDLplRfE18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPb4eVII; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPb4eVII"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-486fb14227cso6893105e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316658; cv=none;
        d=google.com; s=arc-20240605;
        b=OEcyzYD6Pg66PVKrwBTggL/OUL06uqebIiCFpdfZKJtnsxBRVI1hFXDHgq165A9XV8
         XQJUY+H242n1OoInvD7YKLaLeS+o2TwFV49Q5T+J6h4fqVFb7r0+dcY7DGr8UCUHUFPj
         kMJX1Du00FO7KEH+I3iERdmq8EmNOgTqqM8e/aqv9xLK+cKdfl0v/7zFLnmkOeatbG1n
         wRuVSgkQhH4fe1+ob65KUCfR8UfHN4dC3lUo1HW/qcOU5jaYV1l5umlI/B6FLTp7jFwN
         4/X9GCfi8fNh7+Zc3xz405RNWOzvkiArLeN5p+v36GIBAzOFhuFacIIh9pM+4OOC3OUE
         +3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        fh=pxJILhuw7TlKR8v2p4AeVXsDLtnNbwuge3SG6KduBhs=;
        b=devMCIPod0gAZM9lkbKPCC2vH1IMS+x+ti6Y3DaVXNXBg/y3uF6dBmiqmBprMoELE/
         Zu8NyEUpVoKVJP4tkh4OFaUmCwUyg66wZakdFVVE7xvzUm31MoQuvBkGDcXDY3aDGiRi
         5LtFy6/PQjQvHjjDCziZKokhaZ36vZ/F4x28/pWnjItsGozAHa7NpTry71MODR1BNj89
         ww1y72RNQdG9HB5SoHU/fE+56janbwl4vHxGTeUOrUAjn8r8STgQoCiyW3Fbs5n3NmPU
         VTIyZV6ljKampNdEcd5bqLKPbqMcdxWk0nQ72e26qtn6nctc8YyEUtb+xxd3in6+jNw8
         +rKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316658; x=1774921458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=jPb4eVIIHRjE9jzQDGBueykIWAA9HXpF4HGgKP2q1MMiPx7xyajGSko3S+C8DucWls
         RqW3SYLm0yE3Gyrzx9Qw3ert3hXL6JE7KpWpFmxONN5ojo/46Dpg4aGbRGHDZpgxk00C
         YutgLpox23Nxm9XuRP/cmF9PIt7sBekAEuX6IbgBOsZX4sO2em8TX6bhKkivkg+evviR
         m2lKnrJm+7d6GXvn3Ry4bs6pF3NjxYNg1JXaKIZiwTE9Jdaz4ayQKMhOck2dO+40Bwei
         bZ+0iqW/mNgXU0sBKOI4Gqc4dy69+pOORiWiaoTg+PB5yVX56r097PjAdoI64zMquA9E
         aXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316658; x=1774921458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=okZeNjE3n6uwfx15V2uL5of7NVIK8P5uRdWJls4jR/cHC8jXioBvWPCCwh+9DZ8Aqi
         WbUbZRpk5OAqdq+DlRjE6c9PXRanLQd3/yNwXEtb0q/Cgdaiqa1wTwJQOhN8EU9M6JyP
         rpbgrwanu59QMpjwE3ZFnnnY6E4z5J7lNEby8tu0W5ZlAUR3OKWHqV2T7q8T43QWjayY
         5Ga+DQC1dxhdaa77lFSNyDfSmFMu3tzbQAT3ujPp9UvXTGFTDXU1euDkmFOdctKG2rnu
         VwN1+uUbzX2h9yDSzLuEMKX58cuJtr671R+erbqdnFlFxrXYjmoEJbv5QYkprq+d1k0s
         8XfA==
X-Forwarded-Encrypted: i=1; AJvYcCUxiU29g1tcYLv5jwWwuFoAKJvEx4uwUfjBHFqBtgowAgcAQA/0h7bRMQg59Vt2jJCs5Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VUECVFd5O2T2w9LQT8N5enBBztPjUJQRzl5v04V6qM3zVBBT
	y82T/fT1/mJtU2xitZW+6EpGDW19UOFclh9Eoj+Y2nOwoxNHvELrQV8y/ArGsMfgk/mIEXDBQaH
	BWI83uUQw90AiAkldz1ko5aHJjHnHVKE=
X-Gm-Gg: ATEYQzzfNYQGZqnONvhXJoks1/6Osj36kynQUeLHQOeAykLt8acPKtNLpy5/EnyURaf
	/Rz85SLLY1+4oDwiqRFljduVfkmB/TlmQ5Fmzlv40am29Cyl3/hnVSsAvZR90395XJ363guNJgk
	TqDLuY2MTd9OBVynuNSla15ExOaVmkw68yD6cNGRCzI8722u819vVSDOhVOZJEMKlCGfre/RXuj
	lvijKjgv59dfwxG4lbvVQOXvIaXeSJU5q95xmLphiMPLC6iswZ/5EvuQiYu07TjqkotktauJ+vS
	6sQu2QWp0l2VNUBThS9OBvsZzlCTOOhkZCBkqJc5UKDSV51q+NY9GlWGRzU=
X-Received: by 2002:a05:600c:3554:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-486ff01cc5bmr205204065e9.27.1774316657635; Mon, 23 Mar 2026
 18:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-10-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-10-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:43:41 +0100
X-Gm-Features: AQROBzB_vyabm8gMFgwrt-FFA5yFnsEMVMsPubU3mf_XijBG48EgQr58mCqMhFo
Message-ID: <CAP01T76iJAtfovOAhm+9-QwtbVJRbiQgUPWLBZZXYFozLFK=uw@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] bpf/rqspinlock: switch check_timeout() to a
 clock interface
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> check_timeout() gets the current time value and depending on how
> much time has passed, checks for deadlock or times out, returning 0
> or -errno on deadlock or timeout.
>
> Switch this out to a clock style interface, where it functions as a
> clock in the "lock-domain", returning the current time until a
> deadlock or timeout occurs. Once a deadlock or timeout has occurred,
> it stops functioning as a clock and returns error.
>
> Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
> when updating the explicit return status.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> --

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
