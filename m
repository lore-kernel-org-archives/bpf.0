Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORe1fpXr"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B1E6
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 17:41:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3316bd84749so1521479f8f.2
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 17:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700444511; x=1701049311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e7xE8G1iPQD+0h5Jy6XP/fVBbcVi/pxjOtnRd7PNiI=;
        b=ORe1fpXrcikzmkjHc7N5i46fn2VQ+6PiUMd5BVaO5x2jLnBXwqq0WyWkzAl5DLDVHR
         6gTtZYynGatxKxJ56q3LzjAyvWNIXCGQmpTVm+/VE5dy9MCTYkDfpNUM0wg2H0UTQ42B
         +Umvuc7yR0azAFcH23eKNqZuwAq3jTDMnoquzE+Jb7u0gMSlTPErTPF7LV5kxl49ZF8X
         iXW4kVjkaOcYyupef1zd/ALZOGTuKE6SZfyXpkLglfSI+ZPB1eHREpABP5Ppj+GZR9lt
         6ayZsghrojkTRUyVQ5huHp5sVaVtMVnBhNAQJ20/T6hU40xRaetowsQqscFUWDQJj8S2
         4upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700444511; x=1701049311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e7xE8G1iPQD+0h5Jy6XP/fVBbcVi/pxjOtnRd7PNiI=;
        b=SUiEosWmOBZ/tfmZNgkqtQCUcNcjpFiWYgRNv3xa9eIXq19vjPYZq8ImPwRKGAOgWd
         V8JfxQmpbkP+TUDArOoOZss06OL0gbHRa6lp6l4lOWoAYf4MfQwDRhZ2NdgbbGdf9kS3
         6oAGz7T6n1f1DE+VCyLQKDJBySkXpx8yFU6zzzUtEOrTp0V8Kn8De1ibebgI9XxK9mx8
         PYdF7dPs6pzTL4kM4njtD+8JZ9n5Mo+LVphV/+0InDVpnR3RqgHWEv1Q+1T6mKoN8D+t
         rwfrr/B/IEKryl5YvgEbxIHiMtPv+mDoPcAbI4bkEnuhEfgnXPE2mIwL/P9U4FLd9N0Q
         rgVQ==
X-Gm-Message-State: AOJu0YwKWVK1tdw/7/mOCxn3wXLy53VqypPSZ8w1HPrXalG43BTo+zDf
	UGN0WQgir8NC2Dcu4/oMwccCQA3E8yDi1c4XOXU=
X-Google-Smtp-Source: AGHT+IHa+Bfu3aFFX20Uw0MSdR7JkwISoaJRUctUz7gwvLPgLGT1kagRWpoRRaJKUtYbVwlJXrm5ovF29FM4axrAv4o=
X-Received: by 2002:a5d:584c:0:b0:32f:aaaf:dad8 with SMTP id
 i12-20020a5d584c000000b0032faaafdad8mr4278100wrf.47.1700444511457; Sun, 19
 Nov 2023 17:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118013355.7943-1-eddyz87@gmail.com> <20231118013355.7943-7-eddyz87@gmail.com>
In-Reply-To: <20231118013355.7943-7-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 17:41:40 -0800
Message-ID: <CAADnVQ+Yq6hque4krdP0fkQ1bnFx=5bamiM0ym0aa=0sa=GkHQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 06/11] bpf: verify callbacks as if they are called
 unknown number of times
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 5:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> - as calls to bpf_*_iter_next(), calls to callback invoking functions
>   are marked as checkpoints;
...
> +static void mark_callback_iter_next(struct bpf_verifier_env *env, int id=
x)
> +{
> +       env->insn_aux_data[idx].callback_iter =3D true;
> +}
> +
> +static bool is_callback_iter_next(struct bpf_verifier_env *env, int insn=
_idx)
> +{
> +       return env->insn_aux_data[insn_idx].callback_iter;
> +}

I think you're trying to make it similar to is_iter_next_kfunc(),
but in this context the _iter_next is confusing. Especially _next suffix.
Maybe
s/bool callback_iter/bool calls_callback/ ?
s/is_callback_iter_next/calls_callback/ ?
s/mark_callback_iter_next/mark_calls_callback/ ?

callback_iter_depth isn't quite accurate either.
Maybe callback_nest_level ?
