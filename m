Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BF36921E
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215883; cv=pass; b=DGb9IQVGFhIzaBsQfw9sqcvJG+yZXy+Sn4s5odvDKzK5wL1CO3P0srtSbbyj3ETh9FLChRd9jy9phEVcJoq0zgsXmIM+XRhAcpjqeYmIXE1juSPrLwFD1G4Hia03cFQPHxBo3Ak9tEvCUvv3IlHRs0wnto4+GsePFpbfoS5ESnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215883; c=relaxed/simple;
	bh=wdakXhTE/ogi8ijyaLkYysyGo71cf8GUPfVOPD2oObY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX4kjomFwrVs40NabSWxRDD1F4wW8+tPcDxNHpncBbuijmr6fqWhJBSAZNIZTXPdmFUZ9KJLBaSHyd3m3uIXTq42/Twatgp55m3npPsEGw9jRDDfTrtYlHJSmwROEPM4mZjjzTzZy+BLTIvPchyBrpKDRgefSPcZz3IY3c7DVoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLDCRdeO; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLDCRdeO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-480706554beso27608785e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 10:11:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772215881; cv=none;
        d=google.com; s=arc-20240605;
        b=C/9rSNjO0abQ6jv0cEi6zK8lWk6sz9KzMWemdvuNkO/1n6f5JVtEADXPLZ2LozcOtz
         cBN/4/IvMLLafyGkqHORdTIhXFYJnMeo68pk+9uDL9Vt9YV9xhvO+hxCdpXlUZBU0cfg
         YeAeEF6JKzyDr2jXAsP5GAyNysFud4sSK1ry/gyFHgWxGpYdFPdz5Kxw84bv6s/oFskz
         G8uivBxIUfWpdG+rhg2SKBbB2Eb1xGm6r76NkHBB1BJ2OvJXqBB/U08FlE1qnPPld3wq
         l7SRW78SGc/uuq8ecJlWrTAAr85t9syKOMNKw5Tw9tUQi58y4zRS3k/FyPKCU9VyoIOp
         Nijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        fh=hlun4mhRvFGHq2VHme7ynEwruDfzcGC0/+ATiiv7rZ0=;
        b=MtcAm/Gyvs0i+gU9PfTDxuIuADDCeVrQyLOExH3m9bQFTYr/hMb2uKnbzfqqXjQw8T
         1sZHjTn2koLHeu2QUqHDIJmHCmsgU4iAi+8U4WWrcV3o4XBkifv+R9cIhet2j1yWp8U5
         Fko6WKchR/M5df+5tUiOYUz7SayapoZVX9aftEwFfzkI3EIMbEPFwfz9Iyg7gdZn/+F4
         LkT7rFs03OBTk4L0xoqn8Va5mi/IKycp5HO0gD69WrZtimyewZK0ZAkp2XrJRUpzupGq
         w++bA5LWTzWdx2L9bjQgaIifTy9ReTrFICnDImK54BGgRy93z3Puyizchd+uZbRNfQZz
         QXug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772215881; x=1772820681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        b=GLDCRdeO0BU91N/ffiDf5zbrQq8sMUVGDy9vRHPr0QZsT42SXPF4+RjCcFgdahSxsy
         P6Utqmp7P4inKINWft9xagM5rXjcI0P+4aQDJ+ZDTZ52NQEW7MaK+cdkLmdOLXfXQhlj
         03UIgTeNAztprfbfjXQA0g+rxSWyX6TriB5lL5FoJhg5GU3xwOoNySSY65Kop1rensy3
         3CFQi5B5Jq0cQ4pHU5K+dXL+WXRprSDNL79oXsTtZqFjzfBPOmu7x1u1c9WE0WdQwGN6
         87VA2VZ6APdwYgMqFbgR1XJSr/HjDt8BcPyJoQevEmH7dqydVCBRGCW4Qp6x+UZk6Ht1
         E4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772215881; x=1772820681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        b=sR9bzCUKnklY3psZ0WAjNw4UTJ4pveYY9OIlii7N1ScxV1mNCCmNhNm8wUU7w3VZwx
         RLZQj1Q4hEbA40GA9L3qpiSmLsqqGMBXhnmT+FPxB29dsld5lbbvQGT5PSaadQtlYw1B
         xkoN7Yb44AJt8qZz1cB+Y3Wk0byfcAkOjdawVohilVSrrGY4VhBs72bnFqVwWHBSKFQL
         wzXexz/Hqa5Ig+27wrh3JCRkxKL2uIyFBl9c9CqcS96Ci4bH/J9FDjlrz7rHV3LaXHW5
         zAG1oGj2NrrUgtzXi8EIlb2xDzAOs0MVtVjxF9KMF/7xiyEy7awWLr4x607Pb712aTVZ
         NCwg==
X-Forwarded-Encrypted: i=1; AJvYcCUr2MqmOvpF6EqRhQ4SQMkDpcC+66FKlNjt9jnGPP3Gb6hq7UNx6LrsKS0qf1lepaISb34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi41tpKpO0fccOCQBomzrw8MTDOv8xwPZtQPn+ig2yFe37Xjx9
	a80rfIfQ0QBp86vuUhIO0mnSTbq9uqqlPlWcLHw37cGLzTtjkIKnqOFkFYBR+L9JUqnKMJ5I9aR
	xcVTnYqDRKMsSPllZ+/Kk2Zu7WsLQxTE=
X-Gm-Gg: ATEYQzxjy+IaO/Fj3xQN1LF7FOePnLruZg24Y/+OupYjugKiKibZcDtOKu9Kkm+shNQ
	O2N+JAOjg3p0dOlnz6o28R5ysvuOI65HmmCMcZ7E9++aX/CW/r1FcJOYVycsGmvx4IXWtf+vNjJ
	d2IgYaZIiGOIcXFDq5bBLFX1Li41GYpcSZlTGOyYw5G81RJt5LlTJfv6ywCRrVgbro3/jv06H33
	Ig0k7b1Tp8RFUub0l/j8sFMHcqv3kb8Tx9ccSyGjRaxV6ymXTpvNvy9r5In8RIfQkUyYaRw7Geq
	Zaf17tgkzt7qqdnxceuv0k8CO46jQ8KfEkfKCOueSpI9KZZL+dQdrl5JW1qtrtaaPyXjp4Zu2oJ
	He72m4r2K9j5Da2xZzPMGV9sFhghTzZB1L+EG
X-Received: by 2002:a05:600c:154b:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483c9b9ebd0mr61439745e9.12.1772215880344; Fri, 27 Feb 2026
 10:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-2-alan.maguire@oracle.com>
 <df00956ee63256fa4f1cd7d847797e49362aee2963cfc771a05e9c4ef640e781@mail.kernel.org>
 <a83ddc02-d601-4a0f-b5bc-9dd359d7a2b8@oracle.com>
In-Reply-To: <a83ddc02-d601-4a0f-b5bc-9dd359d7a2b8@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 10:11:09 -0800
X-Gm-Features: AaiRm53KFYJJkK96psoiXrRYKDLay40iG1pxMCZZGfqkqIO28QFRXcK6z2zB_D8
Message-ID: <CAADnVQ+2hrYuZoG-s-Luscoza99tR29jgqh138LT=JbHmPwnOQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 01/10] btf: add BTF kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 27/02/2026 10:52, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux=
/btf.h
> >> index 266d4ffa6c07..638615ebddc2 100644
> >> --- a/tools/include/uapi/linux/btf.h
> >> +++ b/tools/include/uapi/linux/btf.h
> >
> > [ ... ]
> >
> >> @@ -19,6 +29,8 @@ struct btf_header {
> >>      __u32   type_len;       /* length of type section       */
> >>      __u32   str_off;        /* offset of string section     */
> >>      __u32   str_len;        /* length of string section     */
> >> +    __u32   layout_off;     /* offset of layout section     */
> >> +    __u32   layout_len;     /* length of layout section     */
> >>  };
> >
> > Adding these two fields changes sizeof(struct btf_header) from 24
> > to 32 bytes. In libbpf's btf_parse_hdr(), the non-native endian
> > path has a strict equality check:
> >
> > tools/lib/bpf/btf.c:btf_parse_hdr() {
> >     if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> >         btf->swapped_endian =3D true;
> >         if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)) {
> >             pr_warn("Can't load BTF with non-native endianness "
> >                     "due to unsupported header length %u\n",
> >                     bswap_32(hdr->hdr_len));
> >             return -ENOTSUP;
> >         }
> >     ...
> > }
> >
> > All existing cross-endian BTF has hdr_len=3D24. After this UAPI
> > change, sizeof(struct btf_header) becomes 32, so bswap_32(24)
> > !=3D 32 and the check rejects them.
> >
> > Would it make sense to update this check in the same patch as
> > the header change? As-is, recompiling libbpf with the new
> > header breaks loading of any pre-existing non-native-endian
> > BTF data.
> >
> > This appears to be addressed in the next patch in the series,
> > aa01655822a6 ("libbpf: Support layout section handling in BTF"),
> > which relaxes the check to a minimum size comparison.
> >
>
> In order to handle all the fallout of the header size change
> in a 100% bisect-friendly way it would be necessary to squash patches
> 1,2 and 6 in this series into a single patch dealing with the UAPI,
> libbpf and kernel handling of same. I'm open to doing this,
> but am conscious of the fact the larger patch might make it harder to
> review (for a human at least). We used to explicitly separate UAPI from
> other changes for BPF, not sure if that's as much of a concern any more..

Yeah. Ignore the bot. No need to squash things.
