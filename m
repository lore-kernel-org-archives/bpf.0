Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CF2D7DFE
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970800; cv=pass; b=htfK/pc/nS1hiSOIy/5sYglFpGd4dhgVBXafpPdPt3zPfTK7d56Gt7aQzRAT0Qv4vHHCNJrKUZrOgbKDQymGP4boY1xi9DT6iMuWk8AXlzmkMtrWKWM9p5szUcqS1zt/txLuWFPNqe9zmPSqgM7xoRbocFzV4nXnA3oZUSSPWf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970800; c=relaxed/simple;
	bh=20T2+qqNxO7bztJvGCo2aK/0NUDLwuryRW7TvhVJsKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HW+Q0C1gNOjGo5oeRT8YEL/4acv+eNwtnHpDRNUTadDErLkdgynu3XnG1Nm4/7h+HS9IPbJZJMDpMcVzI6E+yzwjQMcIYiBbttRpN70HaKntbmiOjYC7M7Ehglj9Jt/Q+Oou1e+GEa5mgVd4Fv+AwwqXTRZZajF3dQrA8SxbtGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMt3W1lO; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMt3W1lO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3676489f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:46:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768970793; cv=none;
        d=google.com; s=arc-20240605;
        b=VOeDICR/NBIDOuDPrOli+pwbWfo9uwcjsY9qhRE8IKoglpyMEBe5NjPXpbc1fNAhWb
         kInW1H61aeAbyqBnXUQRoocwaeH/nHLN+qtCZm8dwSGsnZB6orSaJ781m8oDEwZqpUOE
         S0TNZRGgc32kkcNEYBx0jFHiVL11rds1rrd/duW9fb4VnHPn48QglW0z3/LGb9PmedHR
         rej8Wnt9NMJJeS8zSbbfZJJGu6pxnlW7h0Ldg/MFkopquvv19IM8WRlx0Iv+HcsafsTi
         FeKMunL70Uff4si/piHU7/xLDb2Bcce3HzbBx0ozRSWs3asP1PQLKNW7/Ngy2hd/3wuB
         GZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        fh=YP22Fm7xR8uo40vL/NkpBBROfNLAQjlYWonh4zHumE0=;
        b=O2ezy9PpRRwByIBksSsVx+8Rp5kIaaF28POXcpcfy3DnnM8hDhLbiYv5uWyeH04GLf
         RM30Vj7skgywfPd68+MdagEqbYRdjfp8cNuw43dsAsU7gzxlODQ3t+37Cov4cNZKGJt+
         2isfK0E3tOP9tVcxZpN76C9CtIJVPXoYkRSsJNFrVt12kOBuXd7THcdn0KUZ7N/WGRAu
         QawLmk/9/axKfkLN8YKECX7pzEg7NAEcGOimPwtwhMjr2tnUeiHEpBB0RWdyklvrohWD
         cEvClnNSCMoy1EJq4pIVDH5b6p+TqfF+y8Z5n4TcjBMqq71dlgV8oY7QFOKfprHy0ZBH
         2Y8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970793; x=1769575593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        b=GMt3W1lOuvJTI4LHa2MQvjQO4d/UvqjHmgmGTEuvseq2QplbT4UU8ONAcCPws5RFNv
         2OqMnM7kyDZqKr2gi3HTUF7qKo8476u79UTVlrmFExxZgPL8AC9E42C0+YuQK81FPb6j
         5qeUzTKLJPc9fIWqsnj8mFabcPbeNeZ8/PZsUV+JuSPqo/2PKMh+utINkNpliuYbEZ/W
         GoyJl/+pJG7X00rMioZPFm4AzJrCXTFEZA+gH1jrI5B3XgaKof57v0NkzJu2YerAl1lv
         dn8OfGbR3jo6XRQOobEY4lH+J355OaaTh1wHOq6w4XTsHimDvrfl0DhRK4Q12kGk9zlP
         FP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970793; x=1769575593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        b=kUDwW7Zyb6w0JAtHX9VPc2ItV1ZHhFmtIZvhlQ0VQlva4YRl1BvvfzB+lLe4ZdUcRe
         2X7bSF+EN6TG9eHsIr0c/ZClSJSreQPUsA2geYydF5XtfCEZZ/dWmUaNfMVDBSDuQCnV
         rEfE+cYwdgyAI7RLsEeEv1MJ2G4pA3yVXMAO5IG2gPrLGHMQkrf8oA0LnlJHoxobnrVU
         u3fJC3X0fokX969vwO6vAFE4P1orEbLpKLITqKAs5whPKpd0ij63dmIbgIx9SKYEOv9U
         /WWdjzI30zZCsZxXELPdRYvmsOCGkBNgGFn0OwFrzMKCGaf1WvB+p3t48Bvx1aEmSyjA
         ey8A==
X-Forwarded-Encrypted: i=1; AJvYcCWEfOEhI+r6oydmhKbxyCuwX3ey47L4n5EHYJOZw/47rqCfLusuzPyfGINhZlEfeyRDkUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yjsg/kxugQncevIAwKf8dtLZvI2+enKdMnmU6AYF2AnnCy+w
	Bp3BTSMQLPwHgRTv61zmYwOujKrzNqR19TgEysyFcK0oXVVssyPEJkF5v2zM++tDNGKcRKikx23
	Etje9f68qnNbpVaFdykWV3UfCHjFF3ns=
X-Gm-Gg: AZuq6aInzqWMHn0PyqsiQrTKmept9wIYpbq+vXo1PakaxpdNCkf7BS9mUeNSjEqtGKQ
	8Om9ld9BqJ8kucij9M2Gbj/r7mgaf6m83yGcNsdA6uVFDs9MFSb4uIczovsGdn0NAx4o3SdtRXV
	rlRTaL+5MRga7Ks+NRwyNjij7MzCX1KCaVrDpUZ+bmGHj3HrZ0VQ0iX8yR73MbZEoLDcD725vs+
	VbTpa8262QJUso9IsM5t807f5a3t3ri7ka+GZXLbuTojvNvWT5GVycA6ZSuKvgGaFyibjP8rt9V
	/v3PPEWyWgza/TW+kU61ANYArzjLV1MfXCgFnPYcyP/BIg+XE3xSUxK1QoXavxmBG9owww1c7Za
	prlyhHJY0U9ytDA==
X-Received: by 2002:a05:6000:4383:b0:431:a33:d87c with SMTP id
 ffacd0b85a97d-43569972bb6mr24731703f8f.11.1768970792593; Tue, 20 Jan 2026
 20:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
 <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 20:46:21 -0800
X-Gm-Features: AZwV_QgiJiSGEmmfS6mahHDTcP2ic6kmGCVJweZ0Bopz5JQHXckd_wzAtG8jFNw
Message-ID: <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > Looking at the patch again. I think it's fine as-is.
> > fastcall can be a follow up.
>
> Yeah, it's fine as is. But it still seems like

Thanks!

> verifier_inlines_helper_call() is an unnecessary extra hop we can
> remove (even if it has to stay arch-specific).

I'm not sure that we can, since it's used in two places:
get_call_summary():
                cs->fastcall =3D fn->allow_fastcall &&
                               (verifier_inlines_helper_call(env, call->imm=
) ||
                                bpf_jit_inlines_helper_call(call->imm));
