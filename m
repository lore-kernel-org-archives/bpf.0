Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1624963BA
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106184; cv=pass; b=Zis2kYpSFh8wrvOGqf7wQWHeNY7PAzt4Kfd/mPNcm8RvT+YcKk64+HvEa9XuE+fkA1qHhvSsTH/in+XFiKReO0t7jTqsne5ugPxJOW8ewUecbrA+5KxahWoXrNkJVZP01rmITaoy1ej+WWj1X/4ecHkBIlzf2QgaHTB/uk2swj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106184; c=relaxed/simple;
	bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYcQfO4Mow/D400228Zr/8OXeq2gqrG1WlSSUGeKSvbPzrYWKZbdHTN6iCb4bPAM7w7/SDzgm1/pwPFTuQ/9DhL510PcTGRRJt432OcgXAuzjQFkkk9+lhee3QGdxdlUm74ziMc1Rw90IfTqJdRf2luJU0MkUHfvmrYgtoBI2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBl8kK7v; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBl8kK7v"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c855599a77aso3515172a12.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106183; cv=none;
        d=google.com; s=arc-20240605;
        b=M7p/UlBJHMsZJLm7dzBPDDpe3iM31fezGFQi0qTIF63ttPEUBWXal3sytPVB2ufbBH
         rtUiBXvyAU6wqtOQpgxTgXbU1qFTPi6uNzPiCHlwH6ZRqE5ZkXDZBbk/fbabAcYMmHNZ
         E6MU1plpSiUYft6ytglOwkNNTLgrjFCws/OQznrWYUwWHyOhkTd5b5N1ONhJuiELP1Dx
         EAdMhvS9jS/KxuT+4FXQM03TiyLkzlbpuEVOOhTAn85QuQt1WPfvBd5GF+Zqybalm5zQ
         MS2Sn6525Xfpki4CLZG3BMTPNll30dx1tGlZ9KDTzy7EHnUcIT+AStdMyhaTYE2hKyJi
         NRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        fh=v39LYTR7pUbh0lZMs+95HXRzQ7N/3fhHKIyicQYQnpE=;
        b=GVb1eMBjTEmx63HlIjxpm4SVsiY0S+tM90IEoljv8GJm1FNKk7Wzd7ONbA0aDo4CeS
         MNrtCau/aqfzOAmO0HGHZRbQWQ8BRlv0QPJoDnR+aM2nAIHWbkijRVHKe1Viu3RbWvEh
         788Zrw0frWFOXgKfwiSUjXfwjCQx1sSB6mxNeNAQhtdqqg6uh0x2lzWhwL55M4ynNJeX
         +G9SB35JmSWa2T4bcZX5zUS+XkB8YQ54Nt8jSvKrJdjK6X5KZMdP1HTBc7X0CvzCJIJv
         9neveKlWc62wraaE4UYNxIt3V7raOWZ/apI/hZ7lS4ffCADmALhnGWM3ANardbx+yPRE
         zoOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106183; x=1781710983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        b=NBl8kK7vs7g1kEQ5+12/naidREVJAlqcPqMyWGf8YIpulQ3ZypWhDmcX/fZzmwt6qe
         pFHsjBSLCEaosl6xVuhj8tH6NN3N+VIOSdgo5GHB9DHjXvg7brs76F1/bw3RTv9UBwSL
         dbv2n4jVrgVZSPPP9MSWsOpyRRXEplPhQGLWG5r/EIvYuJdYLx1vdcYw/Xcws/eQgf4m
         2TGxi7JIhl0tXoO1oqNdG/+beVZpPMSas4zuYfAUZeV1i9FCVjwUUczlqqoHK63EKmUa
         nUgyAL5m7Fbsqvk7fs8PDda+TAsZ9S0LUhTHdXrNTQRVhNC89W5LDZz2aifDiM25ie/O
         6TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106183; x=1781710983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv7gE6iLI28Rayqre7JCuHoIrvBZAom9KVFcD8JyulU=;
        b=F4K3StOWsHqNcsxQOZHIQj6WpyIqHjLCIXfIh/KTHqoGbkHMeFqW8NhmE9CH5wmy8a
         Ex38M1cWZFOEgx4cN2ayJ3ajcVMHroTe0GI5dnU0HPTEwG5FaiOrG8djfUaYMvnwIzOV
         gfri+dEWDNaFibIV0xkm57iVAvjdx3ImbMF9RgvyABIVm0z/0NJVYJb7WWyPShaBWS3h
         nM0rYg9ErUNy64ZCZA/j9nyD2tVT3GCiwMBmY/GHXYxhshVVo9FfsXmQoOIel5Nko9d8
         n0OeIn2qu7GubdwuEzPOjKckDkzuYJt/Ze4i8xKDQqZ8Ik3hv4d120m50oDMGEKuddab
         NegQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MCgyHQAiNYR8jRqtiYwtxplCpwICeETmgl4+8XviKMWRlvYxbOzyoZuO0dIGzJNh6Y3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBDsB1koSeIVnW0CMRmTFsVUEH8ARE47p7VhHEBfm+QCOKUZy
	O3JPtEZaq3K5nbXf0uW3mzSVylsZJ3pIWLSW4AKY78w3S/ktSiYjpAG2BOeyqrQAkrgbyBSBAeD
	R0GZYCf+mj+wzpqjIqTPSe6kCfEAbW0Q=
X-Gm-Gg: Acq92OHUfvCcDAFfMdJNnId0HqvbQ8LZjUGVMTL9UqGLExFnT+4ATLc9+vFUvqxv5Zg
	ED+KFOI2AseVsJks486zlh0gEiUWnldfqAra5FtK7BPTNEXxhp2sQugkeHaKNyHljSW+ZdwvTof
	/RiZ0cyDIpWLqHfqexc8XKLC9fr875UDgtFGM2CnavBXjOSaqzGFMLBFsBn7r38HDQZLIf5EBM/
	SJnmzqk4azx3m6zE7IevgYOxy0dTrEfnn0mXW9q0r2MXOzSmSA35diXan/lgCuhQTeyy65UFVdc
	Q7PLoeCYKAPwXNYdVtIpzZhT6iYE65AUYIrrv7qfMHVPYOBTeGasJj+O3tWdRkYfBks79A1LBnG
	UTcNQQarrvNvX2Un+qM9C+6yRhJzUeH1CIx0=
X-Received: by 2002:a05:6a20:6a27:b0:3aa:f9cb:d43e with SMTP id
 adf61e73a8af0-3b4ccdbe063mr30315804637.18.1781106182666; Wed, 10 Jun 2026
 08:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603110554.29590-1-jolsa@kernel.org> <20260603110554.29590-4-jolsa@kernel.org>
 <20260609102922.3c489f76@fedora> <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com> <20260610113536.77172ad1@robin>
In-Reply-To: <20260610113536.77172ad1@robin>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jun 2026 08:42:51 -0700
X-Gm-Features: AVVi8CeN6QnCWHARnizI32fh6UpRcmeczia8YRAursoaXCH_D31y9WtnUreXmzM
Message-ID: <CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry function
To: Steven Rostedt <rostedt@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:35=E2=80=AFAM Steven Rostedt <rostedt@kernel.org>=
 wrote:
>
> On Tue, 09 Jun 2026 16:43:19 +0200
> "Kumar Kartikeya Dwivedi" <memxor@gmail.com> wrote:
>
> > Hi Steven,
> > Version 8 of this set was already applied to bpf-next.
> >
> > https://lore.kernel.org/bpf/178085644764.273544.8250000589480262551.git=
-patchwork-notify@kernel.org
>
> It should have waited for my review of the first three patches though.
> I like to run them through my tests before giving the OK. As they are
> generic changes to my code.
>
> They are trivial changes, but regardless, someone should have asked.

If my memory doesn't fail me you said it's fine during v1,v2 iterations.
The last v3 - v8 you were silent, so we assumed you're still fine.

While at it, please review Mykyta's set:
https://patchwork.kernel.org/user/todo/netdevbpf/?series=3D1096695

It's also been pending for almost a month now.
