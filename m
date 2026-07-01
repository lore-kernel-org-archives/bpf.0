Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050323CB2C7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946713; cv=pass; b=TgWeVgXTP3SQV/B2qZ7wN9Sh0pZIAKRWVWCkDj1X+cu+r/QyLperQcsfUrPgqAzgEwC1oNoLoHGcJN3QAxfiGAT+Ofg/eml9dUncxxoyQuOPUOtEDR+w5bmbrUIznMa4lVsFZECcTjg0zohIUfTrE3wCU12p+unT/ROeeVBdMDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946713; c=relaxed/simple;
	bh=v333IQ17seFPobRriFVv9irQiGfOh08ZeyJ80kHbi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ2zR0BF+tgk2xd1eKsFwKHEqiwP4exMcBHSiLn2WZYpeCdO56VtIPRdKxZrx5QRT3hvpdPQ9tlBADb+qp+LMrMCzGhwLh/RdCwEvR7GLfzTsbjIzqNQTSYuVYVqdXT9S3m9mi2Eha8v9Uo6vc9xtzQHiAONkSzml1L0K0s1PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMFLejt; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMFLejt"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so8921136d6.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946711; cv=none;
        d=google.com; s=arc-20260327;
        b=A9w/95uNn5OEhI60exRUYJVZfk07QfvWr6wgRt5+iY5JdT5V4NXaXWYjkp6c1HZ244
         a/hfPHmvEtAvDarOFJ4UoAWzECtjLdUYGzMchkTjWo5UsjCdguDbeOXD1AyRr5QQ9BIR
         Rm/LUMW8k6pUQ27NWCeEurVfk4lPWsJfc7yREJMKjh14dl5nbXQrMb4x5H1/kG/YXmSb
         JrZOWc6eEieL62vidMQwmwJZNXuHImzWntAwG2CYHrI1rP35dWHHW6FGzLYf9j7s62g2
         EONN75hPRWOFwMS/q7Y7CzzHk6mPdPhBu3JroholUZaLOFKKOnMB/yRJzjy2h54Q2SaI
         FLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        fh=/gLyX5FTVES/olPGDuKSDKVhfVTxky4wlA7QKnBzuDo=;
        b=suXAz3nvFryoa2bFQCu8WP6ymA23D0bC6TYzEtoEWf4q7cvWsOXNS47WHssfItbzPA
         6W6WOP08AmmQRXKMi8b+uzqqm2apm8NVBxEde0UR/QekRyb2hLEClfgUKaIO/hj2eZ0d
         q4P913DHBrzn7iSFPjw/WpOxo60XbEy6fDP9HeC0/44GKCXIclXkBTLeJ6gC2ZUt+Lgk
         iPWH5pbopomX07T86/xTPOsygRgVapmDji53UnVJY88JUHP3Sgs432VBMxhqCukcKONI
         kpYa6f4ZRh8jZFzt1MWViiv9hSY6xLqWB49ovJPSlxZc3r3DQClD25+hTOkDbRO7jvGj
         dhNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946711; x=1783551511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=FFMFLejt7D9ehe+p004hrq2XpYh/HnFijFKVfrm8olTlbQQ7Q7yb6sS8daedUAOGKB
         6ppRzKfwcFgKnNWKKZCE6lRbSrfVChgXrJ2eDvBGCtvSvvffEJgsf/boiPb+ZDxXdvM3
         jEmUVryajCTjqPWMW4oqmFlumVnrN9HEaI5FyMjkJl2TwZxGCHXsx/IhjQjvDSRsdW8y
         ci4HYwBhSnUhNKlgPp2+jbNcb7bE9UE9b8PV15OB0S0VWPHeifUM23eKuQT5ZR2Jwm4+
         guR9YrxXCt6E+5bP4RccjNaIhWPN5J4t5uV62EOTkayWIG7vRIM5AgvE/c5wYCTy8lnT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946711; x=1783551511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=dFNeNLkebfhnmpf796f7m5Q0K3xTIqCPXJBF5QhKMpYUN9kS5+ahzBTwgAEImhY/hv
         Ob9yq2CdI1wDfE+XCf64NNaG+JVSZz7cKPtbelt3YZXWQDLhS1VdMx6GBDEcf0UYCOdg
         xGuy/V4qPvhSS2bb8XxZIx9Thv5kM6Ucj71MeJI40DcqgywgetDBelmlzIkCaTLrAGCa
         U3NMPUcOQiCftEyJHczEJ5I/Krr4r01DuQMzgj9MhAD+xroc7kIbUq1lG7rG5MJ76IaK
         md7YiZ17mmdXOqU+29Q4I1rknIcpEjIAr9VkrafwyZ2dwqL1LYjthcEaNpPD+hg3Ry0R
         plfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpa15gXsexTZC4b/w49TIcxMhQbGHWbzZztE26tDJdoh47gqBjseUkodMmkiwW9vIHEsjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEbff2MUWr14DHeG1WxBb8MWGDPlIIkSLIHqUNhXkS4XpzKIt
	5ysTfKD+eaDYqDRbP7GnzbDT4mil/M723nvN6K7a6AXaG56kslyPiZmXsjV4OOrV8dLykW50Ipp
	vVkj/fd4lbroaB8lySN8lb+Mu0+21kCI=
X-Gm-Gg: AfdE7cnqFw8/ev2OL30aF5bFLBzhukPVjLXsexOqGg+2QQ617WNG0L6GNLAHd5Id5Bz
	iYlQ+kV1oF+kaTGv08cjid/I5XEXNS2LfeD034TAH7FuVQFaHXQBIQTVPSw9t1BX1CWEOZHYh40
	w7Y3vl35GxJIpPW+2gnsg+I0gk/ECk3ZoG7q4nZMOIbcHldH7b37isrmlRErYMdtPfI/5GhxA1i
	5U01QrfPn+xB4atJ88zIjH57E0Ea341xs/9/e+rFP9SQMU+LNgtMhuJovr8s/XlPbwVC4xpa1nk
	S6ILiX5FiZdlcviFiil5zDyDiq0=
X-Received: by 2002:a05:6214:55c1:b0:8e0:c0f3:a2cb with SMTP id
 6a1803df08f44-8f24ead200amr108961456d6.0.1782946711091; Wed, 01 Jul 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:58:19 -0400
X-Gm-Features: AVVi8Cd--WxIEfBHVAG_4saw_HtYaBPqRNY7ATulZIzQtiR23TCVwYiJaDu_5Wg
Message-ID: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
[...]
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)
>

Makes sense, I can do it while I'm fixing the remaining issue flagged
by sashiko.

I'll route the LSM preparation patch containing struct lsm_xattrs and
security_lsmxattr_add() through security and the kfunc and selftest
through bpf. Does that work for you?

Thanks,
David
