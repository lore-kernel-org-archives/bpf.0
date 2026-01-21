Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A129CB24
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955451; cv=pass; b=S4NRTbYgvYdHjajbGUMmDdwMBrhw7QY5AE1UQTJeeM1DDVR6Tash50nQeYGqV9EVYp3E06WlNZ2PEnHNqDnXcRali4umxcz3yRAyXucAKfvkom9BG37xJ1VrkRMf2mSM43Q2Vm58UR1nMIt352/3SepmR0nmRZ2P6R9frHyLg6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955451; c=relaxed/simple;
	bh=ox9rn+Fein4vN11Cw6S/+4g1ZOCYi+K1UH6STeUGkEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnbg919MNOTxSYFM56gABE45m92OqLSKZjfoE1vABRNrtdg9ofHKVnkIiU4ey23//ePHHAhFROZeoEKEsagWtQMkcnrcsjdaC2Fln99Luu1anYlgi7bKcYVjoBowjec/5yMZ/ljNejaD3liUkaS/AkDNFKa9mXjzSUvFf6bYpKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6WMzuO; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6WMzuO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso42636495e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955448; cv=none;
        d=google.com; s=arc-20240605;
        b=e657PD1rpZ8VEQuC5KM6tcSt/P76tooNjw3JnM4HgYtxxBG+D1HipiWEcxxkVR4cN5
         m2cpQMkF1XewZ+DoRPH5swXewewGLd/Pjho/1Wc0vAI33XLl4OTZ+D8rsk1CBAHvFMvj
         GY4Uu6BReb6bgOkv4Zrsz2jPTjvod37YUapb2DilJh6pz61QVS57GQj/ab9eEco7+DBt
         bMslPnIc2riwCH+uzS1LXYwKnEVx8XlYBX+B9KcJVUTA1pOw7pwnmeNjEJx1K8ir3/1X
         5Ooi0UqPdeyUFRSH+wmcylbzKW1gPyP+FiGu5d3KLzA3+YRKR53AqpAGqrAS0TSNCaTr
         AV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        fh=rztSmgX4n4YCdGmtgi/hOtphlRgJu5Jr6YcbaukrTuw=;
        b=lbg5BbuCQKU3p2MjARFKh6aWmhRMecWLu/9Kn2nOjwazdO80LsV+w1ALgG0m1Ei1gJ
         NbXv1jBAwr0Em/OgPLVp3Dxfe56ASsc3zGlEYMNajDIJQC8ZkCLP6nea0GmNljqYElHP
         mxHBxwXM+JlQcLkxaMeMTBxK55fpxdP3E12drgaDPuKp8mrJAfjcDXMOlQgb+ru0a3br
         q8exFT50CBHXq+fVTRGwxI4xFAN3pIuqJi2gehKFOqsXs5tWLWPmgS2ET/qgSVElPhyj
         7e0jZu8Br5n36hcM9ajZk3iOm4KIbCEnF2lE6bhnx0ZS8qMsxAFWvex7W9U8fNvrzWHv
         EFmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955448; x=1769560248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=d+6WMzuOVGM/bLQLxmw2aFAMjvWqlrBg6RUn5Qoa2J94ldIROf8HgZ/Z56oqfuMnag
         jyeo+Cq/QA539DAixUPDHVoaMBwiwrrIUVaCE0ZCg99wyZEWC9iGC9LQFo91lAAY25v3
         Orb0jC70NAcfxeE0BPCRoX5xEUotrknu3btTffJ94iIxq7V9MFaZmb9vf1Ros2G6EiMA
         4JPimRtFVjK5fXQqLFsQwRfKNXFBGeXIjl4cvHshUMX4etYqpg0K1ngaW2HAxLSRuTpj
         jAJDyKJBRN6RyDEgIEXWmmZ/um9qo2oG0nB3td3gBxffSelaGxf5102Y2O91XbB5Ob45
         SbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955448; x=1769560248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=ZusDvXwIulJEc3I3eHjNlxAqbjwdPwJ/AwqUz6YGunZBAqlijtQ1AVn+lYAk2lNZNk
         3LtEh/16VRD6vJurF6H+X0UPCi6Z82/5lJtArofgPRhRGf3qxVtqco/nMXQa+moYfoWn
         JtS5eEHWgV1yXj+v+sjeGQVE5xVAZyuP4TAX4mnFAbFSp+zDa8IBqbVjyGXms/3nF5g7
         YQFVpgfHvQt1mLwTzthRsODHkaNMIZOnAm+5lZV2PjhILrS2k++DZWimj5p3jFrov6Qg
         g+UMRxGRXB/HnT8O4DfsCwBhKF5iYUW5kn3g4J/XLHbZ+6F0vXDSxtmvwA7Ze6zmL8va
         S0hA==
X-Forwarded-Encrypted: i=1; AJvYcCWjkOl+2j3nncaolpuBjL8wKBcVH3pz/BFM0gCQAIaoRkL4k04CqR0YdqvuBLYbTFOSKTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikoXZ5rBXc9P3QCYGjIgnHVn9kR3eB1BUJxaHkO4kMXkMMfW2
	u+uFrmbfNiUtwdZQHtZy7e9VXmHi8XY7ZyBnKRNnPUsrhwIFcQU/5in89kt/ZTDytkep3TgpJ7U
	7VwqqJaYLRfnYXWcJG73A+ozTAAf/qQg=
X-Gm-Gg: AZuq6aIzaNL2Etl4wqEcp9P2szSi9YUq+d5BwZEjo9TTIinIN1mvi860HV5RQIiwdZg
	4/PUTFl4CZWXf08PQyGyG50dlXwGxqP2U8qbUu8CZYumV96B18KBtQZznA0d0feURhgYfi6kbYF
	0FHjz3wDE9coVsiSHhYdD3yTgXMcwEV1Y+/uW5bUDh2cRqmxnMf7VR4eTGqPsoMXa+d/W+5SJA+
	823lI40DEdyUBHn4lSxDxdS5DIwQe7SYRsLEt3thCuoPvfwpDJUorfWR3uFRV8abBRw6fv8vt70
	F3FnWed4a/XPIf6n4dHFMwTAPfq720j0PYFNiKp4UnPA3dkxNecTm5LO4P8pPKP0YAhbc9JQUTW
	HLcncb2Ard+u3OQ==
X-Received: by 2002:a05:6000:25c6:b0:42f:bb9b:9a82 with SMTP id
 ffacd0b85a97d-43569bd2f46mr20748477f8f.60.1768955447569; Tue, 20 Jan 2026
 16:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:30:36 -0800
X-Gm-Features: AZwV_QigpAt1OwMvxetFLr7YXAAGHgfEc4qQJaCqYbPeCOGL2VSp9FOGATNFtrM
Message-ID: <CAADnVQKtN9HS7sWE_fZex4hT=ZEGDQX+C7tS6jc2+8ixC+Jexw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
> tracking, because an explicit rX =3D 0 in place of the verifier-supplied
> argument is now absent if the arg is implicit (the BPF prog doesn't
> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
> all caller saved registers in check_kfunc_call() [1].
>
> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.=
camel@gmail.com/

...

> -       for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -               mark_reg_not_init(env, regs, caller_saved[i]);
> +       for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +               u32 regno =3D caller_saved[i];
> +
> +               mark_reg_not_init(env, regs, regno);
> +               regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +       }

I'm reading that no follow up is necessary anymore and
the new selftests cover this part automatically.
