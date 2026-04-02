Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE12C0F84
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148275; cv=pass; b=mX2ziIG3OUd3L9kLHki++r/slZyjw1eq2HI1HO2wI69tlHfivdZwunwZCtPyNaKwv48yKuIDUSmXLndIAQz4U9m9mG9CjHm+G69baaP9bRdYr8Sto4niyoIqQdcJ35EAYEAN/jZxZ+TmwfxKYuo+y7QyPGpPGGQ7aoJySRnnESo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148275; c=relaxed/simple;
	bh=0qDAXOPuKlagzhQThI3YWp8+49MVE2nh9JKYzzIJ2iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXKE1BVt5eQHxF+lcNRc9Ea/uInkZvcSQUTtQ4lTk/EW2YdU/fo2XMlaAQOgxNa8CL60SYsYt+R0lxlfyeP7G9Ql1+NWiGufxw8AQvJ2vYcTRYKx+F0OCa3XrLyvbVjFTbKUFxc5x4o1IBXXlh2MU4w99NHw7mKDiAHxK1lDNwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fld2sD2W; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fld2sD2W"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so10251435e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 09:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775148265; cv=none;
        d=google.com; s=arc-20240605;
        b=Yr7ha21dp/ufkMTpJ0OtL0uK1Fe3/H1eBY0c/heIVFYp7kFvOl7Y5iihF2Eu7sFzgr
         /JURghNJgOQ1kmJT2ly6YEjLgkOdooGVTnM/9meGmo0ZNA91dB1oSoGqEHEiAAa0UI3V
         27piG86HGcA14lD95AWdlp7IrKDgVJ3tSexp6x6XnA6mqF0m7yuH8jb1hOT30ZBOvhPv
         V0tBymM3SoDUy/Z+9dK26h4ATmjebXBEK/jnF+EEyCai5eO8nxY664lzsf/dwuCAuf/a
         TZ2BEXsR5JWcSDxBjSSWxO0RDqbhms3YrKzq2BOxEeO100bIkPh0eTHU5cJvUlWq1Nsn
         4y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yGEZzrMCYydhjmFJPVVU3kn/IF7zng4Afj5c/TdPR60=;
        fh=G0lInrSaVTPEfI/Fmhunj8mG1TPC7b3eLfEmMwlEhRg=;
        b=SyjVq/YfxcEuiS1OssTraNe77iVLqRDDBqLdVWKE2PmWreXVtZJbxpDxSP8nMuc7It
         3E34lp66cufuI6e6FL/TafrdRKxFB8MsyU4VpgXSw9K0DpsNoDb8ySQvFcV+3oJw6WQI
         HM4f9LdlKDnPfnppGv/hHM3HzdVa2I23p0J2qsQfgEufRyAgAGX8S0iB+9vieU81PISF
         uxmstoSWAaE17loKtf1N4Gd06ldLjsN+GI8BJYqr/SSN5NmBrtVVeKpU1Sy5MqnjBA1/
         Y+eX8npgSVXSgV6lzs35jrKuntywM8GQ+tuaSXNScv8T4LWqDEHJAudryodM7pNi7Guv
         lqRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775148265; x=1775753065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGEZzrMCYydhjmFJPVVU3kn/IF7zng4Afj5c/TdPR60=;
        b=Fld2sD2W7n1qVDidqt/adzJ/CBhxIlp9dOYEa3pNIP5zzx4cJ6TK50Mo5UisUWDlnc
         Dtua0IDbwmDI732fPxfu0eYYjOWdRhLCZxlE4RrA3hts3uPFCKmwFDIlu+4qp1jPzBNT
         4srvr4UjjBr6ei5hLKQ4zMENwcj/T5oZuejfD5nOHi3IDgGoSfjsJeAkY/LRaGuyDzCa
         vvcHJftg1R83s4v4oBZsZE/ZeTbUQvARJkM+v54lb8xaifPerWgZQz+ubsMbvkCbpybk
         YJ02915dD2JWVsUltPQX75lh0fAvl3EKAYXWJm3I0UQfLkGfJVnkb7rOkWmnuq0eMuao
         /oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775148265; x=1775753065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGEZzrMCYydhjmFJPVVU3kn/IF7zng4Afj5c/TdPR60=;
        b=R4wqfQrKW1bP+KMAgXwBoI778fjp+pfUwMzu3NjkAZTzoBITPaJ+8LOUBVPvAQ7mlW
         s70U3zpmIOrgB0pimr90GdTmd/BLoYcu6+cdqinaJ5+HQYwK9qt+GyCVhkOtwuI2Idxb
         m81LmzSo0+ioMRwx6+OGACSQwehKiWXWfTVtzYkmwAwBaMEW92sEt6RDvqrCQGDLax3C
         /wdJqNRkZngu97W/YgmcvsbWroWOsWBZkY5K3sxJ8y4YqBKsSYFk7UDWCARXLS7UX6+J
         qi2Hqn4tAmH6/6k+P0ks7XCA8M/BjjfDlmWgZzKjProze8Am7xkR3n6WfAHeNAWwyZnn
         p/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVQnz/InhfQ9mnHTGodznXSDyxt4fxRlTyUYA+A0in0mKMWxZrJQLcJY8RfmCdVjl8OoVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4xU8/u5PIcpA5QjWki9w/EEGUgSZ0XUXYOYN+ln17BifvitM
	wv9RqNUiHSTOmSFa6xEeZraujV5Whq3ehIl8FTNuqLSpIJY03RL1f00h2+ZkQzQOabe3p7jE7S9
	IGeyHlOB+/Zagv/PT0/9cDDMy6wnDdng47h7QLeo=
X-Gm-Gg: ATEYQzz5NcW9niX14dNnalpLM8haw9TjPNCA0GdCCb2qV8LxZ2gTuQP/9p5gQy5eWsX
	aHPs2tucIZTDbOynqOuKI1Pc8gupCz+QHd2S0U1D09PdXbyXds3ANODN5AnaoBfnPRnvLVib50l
	+/81DPdS3ROuUgj7e15XwrJJjbnWxn8r5L3UGwoYSgNr2aJtWV3PB916v70yl2A2FggXalpkq9r
	TXItihnp2Nz4X3QSaPsFOZz0runGZT8NBXmw2kC9QsJOWtnavlDIbirdi10CYskvRCfXdHk7kUy
	oYOi0o13FDBujDS5MDz7beAE8ir3BBZvDWIfwYi4VRRZby5krywYrmjvr7DlAWpPkE+D3A==
X-Received: by 2002:a05:600c:1f89:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4888b7bc787mr58134005e9.29.1775148264582; Thu, 02 Apr 2026
 09:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092923.38357-1-tpluszz77@gmail.com> <20260402092923.38357-3-tpluszz77@gmail.com>
In-Reply-To: <20260402092923.38357-3-tpluszz77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 18:43:47 +0200
X-Gm-Features: AQROBzDJp5rm1Vk2t4FImHBgkSdjK73spDSAI2Ie851DzgPlkcHhjjhn9mgsnvM
Message-ID: <CAP01T74YRa1QyLfp=gP_Ascndcwn2wxtxv9+2JBA5Hjkfw+U-w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add test for nullable
 PTR_TO_BUF access
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 11:44, Qi Tang <tpluszz77@gmail.com> wrote:
>
> Add iter_buf_null_fail.c with two tests:
>   - iter_buf_null_deref: verifier must reject direct dereference of
>     ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
>   - iter_buf_null_check_ok: verifier must accept dereference after
>     an explicit null check
>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---

Test looks correct but you forgot to actually invoke it, so it never
actually runs. I verified it manually by including the skeleton and
adding RUN_TESTS(iter_buf_null_fail) in prog_tests/iters.c

pw-bot: cr
