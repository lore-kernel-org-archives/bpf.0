Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E31A9F82
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212610; cv=none; b=E7enEOwK3ktejkH88qWLQMMYBdcOFnQEvtABcpZnbpnuSezeZoWFFoEsY6U7sG5o9lY3quk6WerLni1VUQMP2tlSlajcc/fIUEgO5nImHiM9FVqlqyBfEkeW591iWahgOSfA0TqHUhwtRoKQ8xWDl+tbI6oKE/d2EIzhvSSTl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212610; c=relaxed/simple;
	bh=SePitDe/LdQ8/6ua/ysd/oLpn+3xWq6+LBulGvRZBzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFebCsMTq+zeIUbtb7VgRZthzqEl0WHVysM1lSCS6kfZwJ+FH3pshuHcXc+DQizWLk+uCrO2vcEqQHNYiG0IgBBiz3P5o3/nwYxUyqaMr4ZHLl0wBwpvEnQ2+MhcJQEBW0FigjVKK/nPRY1BJT+vqwjO1bHhyESyy30bfUmQO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c00GO1M6; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c00GO1M6"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c565476d7so4113179c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212608; x=1776817408; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMlHdqZhOdjt18HHnsNr5iEa6cLqIMS8OrSluPbBK5o=;
        b=c00GO1M6Ak30Anh98zf1C437AYAzEtv4LRdOiTLYU1L8WT0HmsJojA3NAuaE+seaxP
         TQ+VcYzJfl/V58TBxL3gSqPjP75MfsG6SADUdbNlGzQ0QItjXsA8PJkPUjqT65AhMYDu
         oa6psXcKVu0nsyRijpVfWbbdscJOhC5tX8vq5LzbJqaEVsXbmlRTACKiRV/xAevb8wUK
         TcCjYPx0qJkJOcf3Ruv0iaRmIdBct9iHBaP0bAbJEfffwebNKCXVy7CiumUzvITu76H7
         e9t34S7Sc4UD1Va0OWa53cOzkqWckNWehUyG9his7axA2ChDXcFmApk8h7l/ZcGWH012
         rm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212608; x=1776817408;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMlHdqZhOdjt18HHnsNr5iEa6cLqIMS8OrSluPbBK5o=;
        b=okKfdy6sVQJF/zCyaC5YsO2XrI3yhCY0rFrHFePT+JGrWrKi3EaXbo/1jcfNxX2eaC
         Td8OWjdboK5zbO7VT6j6R2ne0h5BRwvzATB4dqr2inhl0Xk5I00q5RMgB4yPu5pL5F6v
         Ff+UuP+GEikoJAzT+f9GCtfgdWRHy/Ha9zaPxy49K3GxdQ4U4VYSfiySv9A2k2TBNsBt
         VkyKSydsysb6q/CvZzHk3OzyIJWSpOxlnA+Q0Ns24L/8qqGC7kwWz+Ujm7UDPfCU48Ug
         +RJ0lHUp2jMoxO/nLyXIkVK2qQQztSg+bfvkJdVtijsqWYJFlS5KCiyzBfZ6KMM5nB+J
         /zpQ==
X-Gm-Message-State: AOJu0YwVhJuqPB7cW20z+tZX7SBZ1G0n+uA0Piwr1bE+K1Hpk6MQjkEb
	sjtBO4IbGtqpEmiKW0X/Wpph6POx12auJkgRGaF4TB7BC7wbAHQDxnpv
X-Gm-Gg: AeBDietm2cttUSze+s5pF6t/owVDAZj8OCP6Jpye5DCgJnoFRw4OHSD/ehvfSWwoxST
	zW7nyCOf1hP5qCj/KUfqi/e88YtFTIjVo5wUwFLJQu1dkmhDBMgp34njLdp/Ul3KETy2SPBIIZY
	kn0cqw8UXGmAZCfNfjn5Is4YylPx5C+8ZHCclYWEy/gsK4sj5MS//++7AJWmZvhY3z1Jc6WTL2O
	XVEK8KUcLDcOr44yWLRsQBF5+k6dSJ1+xssV74ULOv45c8WBBNJUoscarOwTINCqYm+cF+U3hwj
	k9GZSjeEmxYyeTAHPyjuKARdt/OBE6vK3SGY1rpx/MahRLlq2PJX6WJKo/K5scY8eqCvzePy8Cm
	3w0OLX24X31qqGcpcAQCK9IpR/6oDm9x7x1UitpLmfWk84/pToK4jEH2n92EU9hVkbnKHIxuo3h
	IYYhmkhEcD2CkH2KRssj5KrmBT1eTX48rJvECkaOAecuDcpnioeFqYPbGO4veBKy3xxYhTSLo/D
	fyO5w==
X-Received: by 2002:a05:7022:6982:b0:11a:51f9:db0 with SMTP id a92af1059eb24-12c34e65ce1mr12017878c88.11.1776212607854;
        Tue, 14 Apr 2026 17:23:27 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b98e:bd6b:f141:e7ab? ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e630143sm6739c88.6.2026.04.14.17.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:23:27 -0700 (PDT)
Message-ID: <13f4f4aabc1ceaf9d7197e0ebcbea2179931866f.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: copy BPF token from main program to
 subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, ctao@meta.com
Date: Tue, 14 Apr 2026 17:23:25 -0700
In-Reply-To: <CAADnVQJPf-jd8h67-OhuNNz5hQ6pYXV5nFGYWs+-ZGYZHUTR6Q@mail.gmail.com>
References: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
	 <20260414-subprog-token-fix-v1-1-5b1a38e01546@gmail.com>
	 <CAADnVQJPf-jd8h67-OhuNNz5hQ6pYXV5nFGYWs+-ZGYZHUTR6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-14 at 17:20 -0700, Alexei Starovoitov wrote:
> On Tue, Apr 14, 2026 at 5:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > bpf_jit_subprogs() copies various fields from the main program's aux to
> > each subprogram's aux, but omits the BPF token. This causes
> > bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
> > as bpf_token_capable() falls back to capable() in init_user_ns when
> > token is NULL.
> >=20
> > Copy prog->aux->token to func[i]->aux->token so that subprograms
> > inherit the same capability delegation as the main program.
> >=20
> > Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF ve=
rifier logic")
> > Signed-off-by: Tao Chen <ctao@meta.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e3814152b52f..17d605cef749 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22956,6 +22956,7 @@ static int jit_subprogs(struct bpf_verifier_env=
 *env)
> >                 func[i]->aux->exception_cb =3D env->subprog_info[i].is_=
exception_cb;
> >                 func[i]->aux->changes_pkt_data =3D env->subprog_info[i]=
.changes_pkt_data;
> >                 func[i]->aux->might_sleep =3D env->subprog_info[i].migh=
t_sleep;
> > +               func[i]->aux->token =3D env->prog->aux->token;
>=20
> The code was moved in bpf-next.
> Pls respin the patch when the whole thing gets propagated into bpf tree
> or resubmit against bpf-next. I'll apply to bpf tree in few days.

Ack, I'll send the version targeting bpf-next.
