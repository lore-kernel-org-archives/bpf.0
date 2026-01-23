Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1838A28F
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141589; cv=pass; b=A2cVFGqE9guCBJXsVblJ/O5G2rp7csc3Zy4KE3TfX9LaclKNxhUk09If+MeQgjulunisL8rkfcC/95+dkiGkQ7RlrAQ9ptZGQOquDIHgU4Ler8O/QlO/q4IfkRehCYcG9I9j/dfH9DpcSx2QrpE2bu3gimq71tKyFQToN71lPhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141589; c=relaxed/simple;
	bh=F1TX6MY+wTluL5db6qCSz1RHUc0piPNRg5C3FLD1mS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDjINi9xFCfdnXKb/hZ+UeB2G1F9abEZj0aQyC7C73io+vzV2Jqjm0Gjyg7x6Tg7XptROiwXA3QLdHNXIW5ont4d4WGWZ9V+S0Rv5Tc3MaT4hmKxRSyKI0AwPu0H+g+Pxz8zy2hnhSkJH4p5dXNnDmMIlfQSuq35iTG/B3Y9V/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Ptf89i; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Ptf89i"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359108fd24so1036806f8f.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 20:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769141573; cv=none;
        d=google.com; s=arc-20240605;
        b=LlyCfXg/168iCY24sShQJufyJw3F2iQyswBDWP8e+/TxYEWTM05SBBkzJ8TjlZGKKk
         N3Z8atDpipPOmHvXahyCcsz52/rZ4J9Lc9z84H5sofAvRulA/zySFAtJwSHnaad2dOzI
         Oj+EANUcSfu/Esh5lPeScIoQHQF/4GZMjukJoiL4gpWJ6fOHDDI+/q00XtXHD70Uods9
         HEEWATg+OUFIyUI+VHwF+aUyzWdsO6gxzGvZg11meQLo1yy1zV/DC7WYotLHr0ugQSfu
         dxfYRBiMqnYEmBkmNkEOxT7w0W/zYfIc3QGJ0VLuPRpX84/JYkBINovcl3Im304s4D2d
         /yHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=PasxwnQMaUiTMJmJF33YQoI2dkD0XvDgDZGNFOmOMNr8oQ3gWpKdpbtsn+1bgME5HW
         tiLrwFX36G2cdZFafkt0pbkBdQf3Vby5qNSYTrPE0P9sCUN/MaEzhdBWTONE9H0Iiy5Q
         JUnM+jvgN1oRk8WOaX9f2yi8YMf6mqVGYh1yRYEjUIhWnAfcWw36i7j8BPooNXyUzLLw
         D01/A/mAENAxmWDwbiH92cpcpNWt7zbE7qZxqPIRKXV5zBaARvcHF2ZToji4DZ4Tgqjg
         pV8Q1ny1EwR+roNhMhkhoM1objsfpGVJ9LrllK16//Q41P+h46wp9lErENzOAJrYsIS/
         y8gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769141573; x=1769746373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        b=g0Ptf89ih8EdRKHS2frx3Thnt7GrkTjC/G81050h5xOoLuwZ/vSpsGaBW7bz6Hw/C0
         AtqBI48SXcG/GF582vfXjMBTq+W0bnnW+3ynP3dDPhfTYr5Yw7KUtWlwZMW8j91dHGxT
         dCvCA7BFd2UMOePhVHlXTfjbblYs/AtdPPE+5CaIbYj4Xv2q9FFsKCmonulGsUtcJd0H
         UA/OYH0zIHBR5egjTIqWszj5VRWXw7YfQu1JQlflw7Va84tnp/I8wObwXzIRuECAg0It
         nrjeoW+hb9EDi8yqXyZkxmexPkYobt0LI6t/JFuoXYLG1FfYlxU97Y30E850IhiG1AH1
         IpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769141573; x=1769746373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        b=br+ScfjWCs0j5rD05MhkYNYsdnoDxN1qltcAyz/IEPb5k7VThjBh8H3b9tpTJhM7A5
         0DKHcfIhEEg5AvhQMa9J4Y9+1o9Gt8jNbpkg1O4RRoQkZIKph78wI6ryRepDRxcaq88S
         XsOzDlxW7VphlVSUAdM19eR/QlpVIWUgyN/IZQyJk0FJEF5FCl4YzbYFuJ2FAmE0+dsd
         VM4R7FJxPQszLUnZ3SS15+gLQaUROwwKx5BXdI20Yjrek2QSH07Fw/t/HscmSUaprm7r
         /j95T7a9w34sn5cjfUmIpd4BQuzyPtOTI02UQJ67kkaKf/0oDT0e14OQrQP5BGezhRsI
         9IeQ==
X-Gm-Message-State: AOJu0YwyXmn/X1JZqLE2iBSqHvDZf0SElsA0CqLutwN44z8+DZJLdCBB
	HaXTAhLpFbLaG9kLlv+DoPZDkC9GOA3k6H/Z3YwWnb6nvy4v+94L4lbJscv04+ZieGHPCgUHouu
	xQ51OYB5faINY60FvHciuiHmBnJ03+2U=
X-Gm-Gg: AZuq6aIy09ILP0DcIPqzuFYpapmga2VvKyN8Cwi2gWv16A7+m2RLzRnJKWmNdEW/f5I
	NlQPvpYrS13kxaLiBNF+SezTIA5WtytI1zxV4wIKC2xC3LhddNI7GuzkuxBN1cI72x8NHeMCEtr
	jt0JLyl9ImyHCf5VQxb04r6g4ThgLaP5aiy/Mma4+l1Etn5PHXc+SaAbw4nX5hV0tfQ+exz8NI2
	UKdHUA1qsqbzvwN+11CzEpsMATKwF7vcKtCOOxN/YA5XW2lEwPZ9Kozlecezj8nmW2PYoAwum35
	gXi1rIEKvRh/3yPKBLUfhBVw2WztHSmPP+K3yZp3D5RZKLRfEeKHBOovoESdYiH6aVfLh4hmIOJ
	p5ZUnQtS26Gdflw==
X-Received: by 2002:a05:6000:2905:b0:435:8d02:b9cd with SMTP id
 ffacd0b85a97d-435b1593f87mr2908255f8f.26.1769141573302; Thu, 22 Jan 2026
 20:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
 <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com> <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
In-Reply-To: <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 20:12:42 -0800
X-Gm-Features: AZwV_QiycYEsEgz0rnExs9Y8sYcjMwRBUzV5iEDcMfCB8mlQerPKQopRDo1b7WM
Message-ID: <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 11:55, Alexei Starovoitov wrote:
> > On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >> +static int probe_bpf_syscall_common_attrs(int token_fd)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D probe_sys_bpf_ext();
> >> +       return ret > 0;
> >> +}
> >
> > When you look at the above, what thoughts come to mind?
> >
> > ... and please don't use ai for answers.
>
> My initial thought was whether probe_fd() is needed here to handle and
> close a returned fd, since the return value of probe_sys_bpf_ext() isn=E2=
=80=99t
> obvious from the call site.

Fair enough, but then collapse it into one helper if FD is a concern.
My question was about stylistic/taste preferences.
