Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DF34F461
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129637; cv=pass; b=hISxqvpKoI/gFRHSZCNiw2aDwiGUigS5qX5jFhcFCKcQXFtlv/5E3AqOacL3XsQoyE6fbMObHZPjkLdEixafHYSAaPgkL6uIGljrvcRteouW/00EGJZRxw3o+JirW6uB/EqOfqTg7l7T+cvn98BzYSQ+uK7HX4FWOKB/EMGrU9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129637; c=relaxed/simple;
	bh=yBMXOwcpjCZoufdlj1pFQsMJaO1vK6MgX5cAbS0lKxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjq0yhouSF4wECt3YuehnetOnw9JbUF1cFdvrK+ujra86aYBxfrJZE6iOO5EHN94Or64h6Yckbt3Mbiw0OR3okWo8YdSmAtXQRYK3Z5kw5YUowjCfb3+CvYlaOR5K70wbAzTR6VcVPCP9RQGEBfCgSzuaDmyVm3paXXpZnvKyx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn0kQ2YS; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn0kQ2YS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09d981507so10849795ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769129628; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1LIiRG/8anVmx6bWum4mLf4ku0MQdThnvCxG595IYtbv+ZNHajw/foGWZcdruX+XM
         P8MjWOb7JGTp57tut2SyI0l2wJIjmm8Tth67MHpWk4HzCu7BaYooOzKOoNTh84IRpK/W
         TGCqoLffhq/PZNF2erQ5u3ArL7fzqq8ZFiQglMBIpC6r3VpZBG6zg73LaS/W7yanSBz1
         +6T9Crqejqv1s1o2RP6kMJcAgQ0qxGXDSwo4rC9SiIxy056fyl2/TctwpBVO9KUz8I8z
         zZ98YQm9rB7sGiQl/Wgjyg3iSiIrGkgESFI7vpVp0+TuYq6ghCxfHMLVkXwsLK4esZTy
         KCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        fh=iyIh3tiaN/pTCZHwzDN2Emw2Zfr0RZtTUCw7DgIPD2U=;
        b=OhWoJx4kJdi5YATLyUahjorW+oQFrZQDKYLHYCMpJ7utml6WHS94JaHJZWaFiAs8L7
         iy4c5OeXW1B0Q4BaC2l/J9paN1vmzLtMVzB3IQSVii8GbidPHHp7gNl1fQD0GoWAZLKG
         1L0Cny310t6Ok26VSsVwLjzHZ9zYwD9frgZ4OQsToVL/809PDRJK5SED4sEkYsgfozXS
         VU62N7XBF0/GJ+FwPrHho2aKfJ4fzfkZSsMp09+YoQHVRihhxZJNLl0PDvdjFwd1InhB
         hcvBNYdfcChllVsG0SsO96gqzQKuy4vkqgWNhnrH6sc4a3A2FqRwxqIY61wozP3sfUCw
         nWiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769129628; x=1769734428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        b=Mn0kQ2YSe+Cnxf4NF5MddlWv1GorlD3WUAVEN2eT8o9DjsAFWLEMladCbDtKpMkKjE
         aXe2OOaOlK6H3G/vdqmWwevrjzgZmsYyUQXIamHW+xtMFt5R14gBOdOOokd4OTL0gbL4
         pDf2/+tKC8LDVU8IlVPRf/IWMAx+HMqLPn5QkUXXwtOYn0PWh4MRL2P8wzINscIwjweK
         SZg8cOBhXa2UTCkXgsgzZEtKy8H9EZF4oGUaTxlrsguWlMyscc8U8lzuybAKr6weNLiK
         WaufEs8h9KlAlopbrv/wGvltSd/MwK4ICnIw96tP3NQeEAzfkQKI5KC3aHk9qDAu4K//
         QNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129628; x=1769734428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        b=T4ZFZ5C2zvQYn+OPgiX1+WN04Vn79ToIMYNtteBw2h/lwHVFUXPtciEnN89DiTrW2j
         aemCuPOd2+Bzg9AUJmQLhYU22/kx/sWyUqUazFzXWPYTm6l4sXv5V7CNRnE3HchLX8Os
         m7zScKlWiGaoyLbg9oHSG9dqppSxAxzcFRiIcwk/RIOtZ0lV4KCxByZVGGOrvEB4vIyM
         ++Nif5ACcq6+RvsSHKGVZ9K4fx7BGmpkRSDhymsxUq6eFvmG5PI+UZRhmqBIr69UUH7g
         YmEkr6yBG7pA0+yv2JeUP5QLPgGQOnD2R/3tRCSGQyoRbboLOPY2b7iupqJIQZ93jMdO
         MxHA==
X-Gm-Message-State: AOJu0YwnrfhxygHM6EjOda9izAs1sqso9A6eMoE1YWKjOM1+GugPKrw2
	4D8eyJXiGpxYSvq+3R1DTba0Ugk5piPL4FQE5naN3J4JzRXSC1k9PwvteU07bCNcXe3iB4i2UI/
	s2Np69atSbz/E2jTr78SaibCd4XZUcBU=
X-Gm-Gg: AZuq6aIFroy+W/8c8OW5YzYlT8XIr2E7S3u7xYATP7yINkIKXFxO9fsn7ITMx2NLy5i
	krpHITgD4KVI0PKnGE1wl+Usz6yaiYwWw1ptuRTBVVuXf29PQR81mlOU/dnREduv30i6eUzab9h
	MKZ1zc0TVVgem9b/yoZBmzl1wpPfuESrpyX7hzAaLf7xQmcaEnu38O8c8KHdO/2u8LgjxkgscUD
	w9ymbJDWMD90XIHNWXYY9fbQ86Li/eo5ROo3x3dk+6YkiUX20KX9qsiGqQhB4KsHo7kSJXkHRm1
	Bz161SbI9ZM=
X-Received: by 2002:a17:903:f8e:b0:2a7:9163:8e60 with SMTP id
 d9443c01a7336-2a7fe80fddfmr9079865ad.23.1769129627880; Thu, 22 Jan 2026
 16:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152424.40766-1-leon.hwang@linux.dev> <20260120152424.40766-3-leon.hwang@linux.dev>
In-Reply-To: <20260120152424.40766-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 16:53:34 -0800
X-Gm-Features: AZwV_QhVQ3_tmlZbyi2JgIuf-ozS36BC6ziWbq4VPwpzBkySzzimkp-0gd_aROE
Message-ID: <CAEf4BzYuZsFC-DPhhzLcyFTahucHP59+6kAc0sooY2g+SqgrEA@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v6 2/9] libbpf: Add support for extended
 bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
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
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> To support the extended BPF syscall introduced in the previous commit,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the BPF syscall common attributes=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 32 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 43 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 21b57a629916..ed9c6eaeb656 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,38 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> +                             unsigned int size,
> +                             struct bpf_common_attr *attr_common,
> +                             unsigned int size_common)
> +{
> +       cmd =3D attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMM=
ON_ATTRS);
> +       return syscall(__NR_bpf, cmd, attr, size, attr_common, size_commo=
n);
> +}
> +
> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> +                                unsigned int size,
> +                                struct bpf_common_attr *attr_common,
> +                                unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_ext(cmd, attr, size, attr_common, size_common);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_ext(void)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_sz);
> +       /* This syscall() will return error always. */

I'll cite myself from the last review:

> But fd should really not be >=3D 0, and if it is -- it's some problem,
> so I'd return an error in that case to keep us aware, which is why I'm
> saying I'd just return inside if (fd >=3D 0) { }

I didn't say let's just ignore syscall return with (void) cast and
happily check errno no matter what, did I? Drop the comment, and
handle fd >=3D 0 case explicitly, please.

pw-bot: cr

> +       (void) syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr,=
 attr_sz, NULL,
> +                      sizeof(struct bpf_common_attr));
> +       return errno =3D=3D EFAULT;
> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..e0d646a9e233 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_bpf_syscall_common_attrs(int token_fd)
> +{
> +       return probe_sys_bpf_ext();
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +586,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_BPF_SYSCALL_COMMON_ATTRS] =3D {
> +               "BPF syscall common attributes support", probe_bpf_syscal=
l_common_attrs,
> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..aa16be869c4f 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports BPF syscall common attributes */
> +       FEAT_BPF_SYSCALL_COMMON_ATTRS,
>         __FEAT_CNT,
>  };
>
> @@ -757,4 +759,5 @@ int probe_fd(int fd);
>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>
>  void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_=
LENGTH]);
> +int probe_sys_bpf_ext(void);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.52.0
>
