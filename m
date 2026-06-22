Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2A346E60
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164635; cv=pass; b=Tf4Q3OTUzIJl5IbtXhLe5QDfMY6fh2xg7T/LzgTKucDd6KbptFzWG1aQf51JAiXz11FxbeUdMurKpcXRw0u5351Su4E4wgLecSNgCsJPECzuOKIVvKOdcMcR7zhd63fZuv+cvaKCzjzS9YE8cZ+TTXChMg86b24b9AJP+33ozvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164635; c=relaxed/simple;
	bh=wf84bPY7I1+ImnhrSvbM0tdlcZ3ffRCzi0z00dHXq2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFEZV0an3H5DydxpW615UXrbezmw18Ze12+623rD2jLBy5qxVgrGTjruU+wiyuBYalUf6bLXEBMseBsuZrRJHjqetPZZxFrxx02dfOYDo8QA9YgJaIKGaWDshqeRUsqGaiyDyMnUdZwx2T20lQpaSH1R33d8WKJ64V45WbF9OFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOlYHAsl; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOlYHAsl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c892935bcdeso1927735a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782164633; cv=none;
        d=google.com; s=arc-20240605;
        b=PBYRnUMaTXK1qQUJ3eSkR4T76kztMgJ2q8joTukOvxq/Xs2iGVqRn3u2saejy69+FG
         Cbccy3vc4/gwcDrnacE+mtedXwChrZRMSytJ2EpQJyKE5A3XibocFasZNOBfx7b5SzJL
         I0qKX1yDr4wRVeNRCmrlehPmprWRgJC3wGj0Mw1dvcfcEsdQ1XNubrqnyBIkud0fpbRC
         dLstVWgI+nN8L19SA+rHApopOJijUW1UulJ3LizdKTB5fczeK/u5qvwMpunrdoD8/Zjg
         L7aWvFfmX56aRCnrx9tAS6wDX4pFibLTy2vhobW8yhwXfzXIxDq0VyHTTsPUB6vyjkId
         fOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBL+cTr6RyMgkLyRYl63IsYVsAB6dBdpm8WHhEM/Z8Y=;
        fh=nlqc8vJShjwcotQJH6LCCtNT8MpYrzAdW79WCv+HvZY=;
        b=iuQJe8ZUod70xQAW/sB13yNokvXreKQ1F9XvTy/KOK6E+Epq9lQ21pQHpO/KCuJ6cH
         4yQJRJ8Ox4wRu1DCUdTDBc4V2fCDO9gTcQwsIBsFyU7cDd42kNsDSQV6n44Yb0vmYaBW
         9ypcm9Ud7EsZzYv+yVz1HGuJ78baU0MMkWJ+M3rfmQCoi2xvcefOPai05OoP/OuWqtgF
         cpSDUo3EYWbin/FJu2fo7J5EI0Dlgm6U4o/z0OGHeidkLP/LCD0GpqUkL7WHxTBkwvc6
         e4PvcYqvLhs06/H+c9fDM8mJuZrS24x83SmFOQaB61NGXwUUkgHweRZjj0vSZXGZt64F
         F2Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782164633; x=1782769433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBL+cTr6RyMgkLyRYl63IsYVsAB6dBdpm8WHhEM/Z8Y=;
        b=rOlYHAslJAKtp7tMGmw0qM9xaGYPQW2DLpCSta+zaOStk1QU8cZVaelTXyMYFpTC5z
         136eVxkPiV5z2zk/6HwUfWz3QwNNF/zZYGmzetLVPq8pSTHhpYTpIUwwl4u+jnlxedmn
         i4KH3YJF7afn1C7g6ZoJZIaXKczX/yApUGj3ZtBXDUkdiWv4cORcwGUskd2W8BwevHX/
         BBDvq+3Rc1mLqflzR+3j1DqKYFGWIcWdEbTlKfQ1YTsAyKozTh3AS0h5+sDSEnF5nVEf
         oZVXodjkeeJA6DNgjQ0MpMyCLlLovpZJ2J0fVWqWjA5yC/4Y0KlTNE0CGJqWWhXVApGy
         nmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782164633; x=1782769433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBL+cTr6RyMgkLyRYl63IsYVsAB6dBdpm8WHhEM/Z8Y=;
        b=N97FjKCz8BKCcMoUXXpHUG+qMmvwdgAK0r7RxrK4FdUqi7ktiHrjGZ3k4sbr02V+PA
         p1KC0velOP1xnorFzze9Ahf1ebmJGHr9SVwexgYA0OyRnahMx6v746nb1G12YTObM2Ta
         bGF9qLmJYL07CPad0j/ijrFugWlgaSzCTgCp/HYss1OgObmzzzh6zeVEO75J5Z1S/jKb
         1HdzLhOsZ/eCrJ2ppE3DPg19KkWc9bH0FTWkKdID6EL36kY2i2b89qtqSTstobCtEETf
         1fRXM8MD72QtIkTCpve8JfedOG27sPhdt1XeApgwqDXBuU0SzvkqLNRDs5KopfUYWpH/
         BKpg==
X-Forwarded-Encrypted: i=1; AFNElJ9/yO8xq8OGjeLvnGBxR0y4226asX510pIgvDMdPQy2S/Meu7wIRE3Kq8gzyCMKPegtNcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoCKbffGQ1cpYFiffTDmT/AgVdkt+zAjZun+EcnaWDAXyp41z
	2ZDaorr0i3/RAD6hR1CT7dlxn8bwOb0IiW11em1GN+wvI10mVpTyqsDPdkPdHhY/kGzBOXqr/Lz
	azXImVHq541whVRmyT799YqYvkGfWvE0=
X-Gm-Gg: AfdE7cligswrkknALDT5hTDW1EfyTOhmpRfo20FHrQCEWIA2MVQgMor9qWi2G9tZiQP
	k9NG2pOENWu0T5oQ3l0nZOrNM2yMbj/ddERHCJihti/m3mg5GuxBk0hZpMWNghX1VVHfEZPQhin
	LJjmu1r40p9HMmEY1Yg7Fh0+wuHvlKn9RxpPuS7dE2KPZiwY1nPbaNapocCPJHoPCnrEyAOcao5
	gejLscC5aiizOVq3sv5sWV37nTtYNLXXq8wQlBaZFUgLKrLINpAqt2CX34QypNQbt7BQfu3j8Ca
	cNkHzZTbWauyuc857VhiN9ORadV7lZ5JRJsjhzDBe6AvdHlIy99ZmxYpAO9aERsOD3oQv+GV/mM
	nrylt5ZwQQ6pcNA==
X-Received: by 2002:a05:6a21:6e88:b0:3b4:9168:d9e6 with SMTP id
 adf61e73a8af0-3bb35b6b968mr16851568637.37.1782164633345; Mon, 22 Jun 2026
 14:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com> <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 14:43:41 -0700
X-Gm-Features: AVVi8Cdz3tMh9NzejKFvKITuc2AJTPEzadbZTaXrUGp8E_33Bi-gM3Rly2cmQaE
Message-ID: <CAADnVQKTMkHwnZb-VjCErqmoe4O4=aT1vjMU8XcZiWpNG-LhVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
To: Woojin Ji <random6.xyz@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 4:16=E2=80=AFAM Woojin Ji <random6.xyz@gmail.com> w=
rote:
>
>
> Keep fixed-offset stack reads out of this eager precision marking path,
> as the new behaviour is only needed when filling a register from a
> variable-offset stack byte range.

...

> +static int mark_reg_stack_read(struct bpf_verifier_env *env,
> +                              /* func where src register points to */
> +                              struct bpf_func_state *ptr_state,
> +                              int min_off, int max_off, int dst_regno,
> +                              bool mark_zero_spills)

why differentiate fixed vs var-off with this flag?

It seems the fixed offset reads would benefit as well?
