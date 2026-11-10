Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794316382;
	b=bMZsW+4MDvuuQY+HOhKumAGAiLRqwhU9horViC1Bv8KdNWdzSb40Z6KZj3WQAUOj3GfZ
	 2Rd/6+f+Xp763lldCZ6NLAflIGoAyUet6cgZ0fSF/zQHu4oDnaVnnt/3uGTGyo8RZ7XFo
	 JWQzRmj/fqL6ptkFlHcqptzb0WWjGG9Zvm5sQ4IRawSoiNhgg0HIb9NGc7/7RR+eCPweE
	 UJqb0xLZBib4blRzsHHlIgqt5wzYf95DCT/qo5UchxDExsSJo9Yl6TsFpgB43mhHJF6g6
	 Y7yxLreyXEKPAc1QVnQ72dWFa5uejABaU+fRUIt7D8+/xSYpf3kRm+T3Uw7V1Tt2XGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j9MOCzNF55rZGGpluezeQ+vnoNPiPbJ5pnRhrnmo5Bc=;
	b=sgAIH/3ItU/LRsCMoNrJacTwUxOXxZ6MmCN+51FJJDXh359HYfqayrr4CZWaPeLT5KvN
	 ApCgUnb7pytPET/Eiyz6DVlENzColucEqvn1bp2AQnHWGX7JvI126yY9rvC+eevLNo5ne
	 JjM6NxY4D/R0PsJVPw94h1Fi3uhjQI4ErrpCi5AvL7GYvcUhBhpxG25rEa0WE0OA8ilgY
	 g2apUayteafAKDZTNDh6QLVT21Rj103xMb9nqnyRgPMZ02k+IcdnpqNqok9UXY2KFEjWL
	 N9HrDG1glVXUVAWGj9uv5C2Djj9HDO4VOY1vYUySJuXh/wL2ZXfxsLcaGahLb9TlP/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sdwbhu2K;
	arc=fail smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA08606BFE6
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA08606BFE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sdwbhu2K
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c24619b19so1926233d50.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316381; cv=none;
        d=google.com; s=arc-20260327;
        b=OCZUpXVRsJNypdp3kyfO0OrYMOU/kBXpMTDouNSsQHx+DGVS0RLQrsVFLoKqcSefDI
         i4penF/0A6ypzv2wUbwAoZ5JDEdtoDKFNMTaUPwnJD0LC9QH1jjtRX2gcLP8qFFmUTVd
         YqQOUmiLxdQSkQwGccwjaG8LUDTOn6Of52vuoTUPg6KANG6X8pD7yWXaiBDdfjjV55VV
         2jp2dlHi/2LKc+42bh/hFl+7mky4l4CsPJJkqFOQUYY/8rEaT2zu9VH5ossdfSKX0qsH
         Bm8zHubx02ff6JT7SQj1ybxLCIUpImFgprrmcyaUpQp9xHfjpEs+lAmXWun4PtxzPRY9
         YQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j9MOCzNF55rZGGpluezeQ+vnoNPiPbJ5pnRhrnmo5Bc=;
        fh=Vttt0VuXceuTNbiBPi7gZ4JJgwpvn2bXAcJsp78mboI=;
        b=gJ3N3rgXS1GIm5QgQFmMi8x+9LROcFboThU7UbSIEaueYChkjKeJU1GicQjDiRMVS8
         9l13X+RsO7RJc8ny8V9o4TXd/9ehSq32Ose+oSHnWWY1ZNy/iJ3KuAQ+BlZBwdiVU8Yz
         BuGx+EY7za222SCsDRNNYI1lo9FbLnzLI6yk3uZ8SogM7pk0kobuGjL3sHw4Ay20EXga
         FbmWRm5JicEVoASzj8rLvRag3n94mBXQ+iNko9UTrUeVT//8FWp+BqAxnJSvP9pWewmo
         nMq6ve43K6I3Iy1a89p8ut+S55Co9XedoWDEePT3omktaS94DdGKHqh78EPpzkdG5uji
         R4lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316381; x=1794921181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j9MOCzNF55rZGGpluezeQ+vnoNPiPbJ5pnRhrnmo5Bc=;
        b=Sdwbhu2KpgwFLfVlfH6iDlq+dRJGSCxir2demi1cxoaqTT17leKdGKQlndYEKtYU5c
         4CmjBWzYktFmk9hfzFAmZ1VoHanX2QcIdUGdKqTV5oC+C8BP+g4INWFSWYNKyCfLqt3X
         tUcd3BGcEHlP5W4vaDqhhHjHeb5wnrSczCmCQGbzZ3ZHU/IySdOzvic3w8LMH7sL+mwn
         V7+6WUxXTfMZH0o1cPClzyFGoiTHwiQWRleDmjIiztc8DYMf568wzkX3CAUQAh57tOPJ
         tWrRaurKK4islFO7DwFl7kfIUnB1VXryOTOUJvrOa0eEUhqKjP4XdCoLIjoqDcDxUazt
         dS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316381; x=1794921181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9MOCzNF55rZGGpluezeQ+vnoNPiPbJ5pnRhrnmo5Bc=;
        b=lOhFPCHDoLeSCHpQKViNz+dbo7bwTvEke5VRrq50HtoWUQh+32vxXrWKAqDYToKv1v
         SkAfZ62EYO8ZSCxtmgQvyc7hIgIO3iEduU+PoCgFH54t9dyRhAJNcH42DkKXFcibyVEr
         5Fus2SqvO3z74f1ISrs1jtMGLwo8S9eNCRnIeTVmzlm7XaVhjBenzeB3d6H/jTTVmSpQ
         9KytriNHuY3b044C9mcwJBJy8Jz+qzIm2oYCmfqKFqkSQ44ijrQU3b0f4P90ZscBrBMB
         448SyvGwPqTyhAN4LQ3GFnSEx9kM0+KbKsp8ufnRv/eIac/nd0kzriVGRjcLGcmD2pAU
         c8Fw==
X-Forwarded-Encrypted: i=1; AL+hErH/LP2CWLNcnqkVN1GRNV3uDazkko1ZdpN+6lBKsCi4kqxaopSLOdjlbtlV6mjHgJVqGyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tgIKNK1ta1ouBb1TqwAsCEwaYOgyqe0oCz9SvnXkvso72UKMx
	otLA5hpt6GwkQ6Zk5mnKxiqlTfHdEnb4yuS6EGyv+TjyjrCIMka2Fr66fwD6AfYBB8HN9HLqzzJ
	npcNEzDjkuggLbShQad8h491uAlXCuDs=
X-Gm-Gg: AYBFou3f3BzshVisj4HQ231XwkeFEmBJBIVY08UknJnYoudawwDDpOGtGKrCl/IsoC9
	Ev+aHlils6R+pOd84Yy4Dg+anrrjEocnWw2rCOSZVKJfcDLq2oooEmQYjKglesj7YtMmLXUqqQc
	hBaNOnWFwnUD1KgQniyo5TRwsK5astsAQK9xLjqeDofm9tEEx9AemHFuAD0t8FtWeYPhgw/zhqU
	QT91bk7IImfzBvkFrQYkJ8ZlpdLQTz0e6R0kxvSEtLBsxQ+UBsJDy8DWd0cDnLMDa68hXhxL/kk
	tMeVMRHaC0k9a9tkQakDn8QNi8hU1+p0iq5stpAgydtPV+rRqw4mWi93mu4UioiloakR4MikM1u
	2p/mbwM6awuU3ccFFBNPdcJyvq3+cH3COlxZ6gQ==
X-Received: by 2002:a05:690e:1386:b0:67b:eb7a:e62a with SMTP id
 956f58d0204a3-67c56265785mr1829765d50.0.1794316380667; Tue, 10 Nov 2026
 05:13:00 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <f5a22a46-0fd8-4739-bf11-a20e0b3a443b@linux.dev> <DMR088J2OR6L.9TOD4IDBHTZ8@gmail.com>
In-Reply-To: <DMR088J2OR6L.9TOD4IDBHTZ8@gmail.com>
From: Anton Protopopov <aspsk2@gmail.com>
Date: Tue, 10 Nov 2026 14:12:50 +0100
X-Gm-Features: AclHuK-z3hLVWTJeTumw2Ph2v5vhN9G_65U0kCrk8Fj0jgmTxAiCTqvVd4CkNag
Message-ID: <CAGn_ityW5Z+JEcTL9wKnQOgLXhjXxC357Q=h95AgR9xP+pcmjA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/7] bpf: Support struct_ops in light skeletons
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Siddharth Nayyar <sidnayyar@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 11:46 AM Ihor Solodrai <ihor.solodrai@linux.dev> =
wrote:
>
> > Andrii, Alexei, wdyt? Any other ideas?
>
> The loader asks the kernel for ids, sizes and offsets only to pass them
> back in the next three commands:
>
>   the loader asks                   and passes it back in
>   --------------------------------  ------------------------------------
>   id, size of bpf_struct_ops_<t>    BPF_MAP_CREATE
>   id of <t>, index of the member    BPF_PROG_LOAD
>   offset of data, of every member   BPF_MAP_UPDATE_ELEM
>
> the kernel can match by name instead.
>
> The kernel has both BTFs. BPF_MAP_CREATE of a struct_ops map demands
> btf_fd of the object already, and bpf_struct_ops.c doesn't use it.
> The kernel can find its struct_ops and the members by name,
> like btf_parse_kptr() finds the type of a kptr.
> Then the loader passes what bpftool knows when it generates
> the skeleton:
>
>   command              the loader passes
>   -------------------  --------------------------------------------------=
-
>   BPF_MAP_CREATE       btf_fd, btf_value_type_id and value_size of the
>                        struct in the BTF of the object
>   BPF_PROG_LOAD        attach_btf_obj_fd =3D btf_fd, attach_btf_id =3D th=
at
>                        struct, expected_attach_type =3D index of its memb=
er
>   BPF_MAP_UPDATE_ELEM  that struct with the prog fds in it
>
> The kernel rejects such BPF_MAP_CREATE and BPF_PROG_LOAD today.
> Nothing changes for existing users.
> The BTF of the object is in the blob, so the signature covers the names.
>
> Then no need for a helper or a kfunc. The 4k buffer, the fds of module
> BTF and the offsets at run time go away.
> map->def.value_size, prog->attach_btf_id and prog->expected_attach_type
> don't hold offsets into the blob.
>
> The diff below replaces patches 1-5. Patches 6 and 7 stay.

I like Alexei's approach here, it fits with shirudo. I also have tested it.
(Patches 6,7 weren't tested, shirudo uses libbpf without bpftool.)

>
> [...]
>
