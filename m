Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124636;
	b=1Bx4v6imFYIQmOAXzI/QoajBepAQTgfO8v26V4r4103G2sP+Ys0rZa+1w00lVZouHz7W
	 swcgn0ArPAXsk3tvPztwDeJlj0y3FY17c3uYeU7NyMKXIx3Sd4hMCApYlbMRHgOryoADd
	 U8KWoGdRUIeCgUHtjr0f114cx4HWMOSBGESEF5uQ5HLy3tsHhNTzFHnskl5LBt5OlV+OF
	 M1wXsrF+q5Ch8S3gJcEvuSZCke4pF+PiOWUjx6AjGExeMnGPaAE2SXcl+F6g/zxts2de5
	 yOPXQZqZWi1t0Bt9jJjSr06gQktyruNBmM9PPPn4gE7m+2mWIrqjmob3QEjuuFJ8LvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yXQqTdIF02aP0sTve1E8AXpNd4qmvIXhwDjM1R+/7u0=;
	b=hvrmWx2kK/aRUfN4V/sFVspqKEgxdEBF7cTP0TZfzYON7t6l+n6W4kz8lsloYZ11D1DD
	 0qY3KK1P4WgRuxiSMQMN9gb36v7GOztNT7PIWc6gT64TQFddEDQXaPKOyL/Zr/OUalcm/
	 7xeK3TVZzdR8hdTF8RWdWCdAzywAsAjCxLRF1IRrQidliWoqWi83B0vuZwW4/vAowQQP6
	 tanRtYBK0637P+eMLUrXQOfn5x0cuyc4exaTSiABSYXVUahGafJ1qd9xvLRiOuicmRdCX
	 tKhzifODgSLlTbDtj6oxjAjPfSC9haVFaFGkYaMiVDKsdCP0MdFt4tz/bBiNfL3e2/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w79kXqx8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA5606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAA5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w79kXqx8
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so101597a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124635; cv=none;
        d=google.com; s=arc-20260327;
        b=ceTT5RZPsdKtuHSToyb+VlNmwD+mYSfD9zh5f2Yaj+6UGHPVXIz7kFRdkr96Dz5gMy
         mkvTwU4sziPPHe7/OolZKP9XYiVfJ8sbH1o6tyjTSXlDC/TaEtBKqRVnSrmaP5ItBbma
         0rA+/SxKDLN6HcnbQntEmaAn/3yUazINR3Oa+gVq7uNCYWSENAXGwo9/Kvv/DXE+iOdc
         Ckshpf1wG4VUEbj7ZFNZjyNjLSbGcC4UbTAVeKWhr1gn7cBOxX/Fu1PkTogqwXYFHk9+
         8NyXXSKNfw9KjM2i8B9GTPc6lG6Bj3g1SsRuXnvgMC0I7OBkWMloQA3SUs7q9dJAgqs9
         fdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yXQqTdIF02aP0sTve1E8AXpNd4qmvIXhwDjM1R+/7u0=;
        fh=vTLYg1rLsRmTILMqW0WiQq16YJj+YgXTG8NaXBOLijQ=;
        b=OI1CFXni7O2hBBXmleV+2ZoIJ9zx1Qxrt0/jyx2/eN9vQdJag8cC6TmlWhEE+8iwqz
         kYSKg6vA4J1/7xDF/ew9YCBv61KzVHqBsdwWgdNDgYsbGX7U8OWhK71z1F+TZcc51mcx
         qBsXm43LE+xH4G+5XOEZsqIP1/zCWH+CnNSFQV+458WQ53EODCnV/OI9/VzdJgZ1Ar/n
         WUgaip/d3ry7WdltSzKM5F1eJDoI8ndQc1w2Ifzr7mM91Rhorz67DIl5ad+L8tXfitjZ
         v9zYm0dVevTs6ylNdVi6xJanUcW4Kjje1EcaOTlm5XiWufhjUoMa+XhaLdjydFVWXDWn
         FbPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124635; x=1793729435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXQqTdIF02aP0sTve1E8AXpNd4qmvIXhwDjM1R+/7u0=;
        b=w79kXqx8VpRLArVzBcZHsJ1+BrTJajnxRGNOiM8D9s1YR/a1LOd4Ffsn+ZInDL0Z/h
         wObW8latOxsrzqPrTPf+Usa5Po/U+K23ecyENh/XZVVBpnWzeDOEhUYFITwTs0q7YYpc
         l35dbMMhVTVxjmgAL8F6eqYgg91hzSXCPL7C31FuNmDjksF5MwbmbVHWVCeGcnDNyLZN
         2qBehDd+4IGbv+a+8olDbC18rrZNq41400ptbD8LEmCB3a5I4me/Wr3HV7LbhoIwJ51I
         WaBwyrmi2aOveR16v+jTyQMfzyw4RB8dh2AMvgwii7TnpSaoSovujP9TjgrXl7NEdjNz
         a5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124635; x=1793729435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXQqTdIF02aP0sTve1E8AXpNd4qmvIXhwDjM1R+/7u0=;
        b=1mZ+5b4pIWIpD0omvgSl24jKgHtqkILmtnOZhHOSfO6Us2iOAy/sbEk1oFFJ+izNyg
         RPXITt0twRx9wqB/+AO8MczT+1IS/yBFQ27xkeBdkX3XA6YztInWJLUxaNXfdoU69zfO
         19xFLSSoQW4nL3ciXtV1zoVRJ3eN0U3+uXamvuFtR+kTqk18PGWWr0xtHmP25Fs69CuQ
         eAXJ/b/g24ahF05V0bgKEfS1cCSthRN5Luie0xeAPyWr4uaAViZFFaHMk8q4QUENCfqU
         0XV4yp5F5ZTgEfNRGUEMwepAEwAaR91I61fyWqnjL511JBeB/74FS/QKhJo/rm45ZW1G
         ZJxg==
X-Forwarded-Encrypted: i=1; AKwUvBzXjPPN/PQG90NuPZfQ2/Y15TBsIUAeO4Rh/J/WDAt1Y2IoG5G5VLbtiWdDKc6+VS8S4VE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKD9Xb6v2iN8sk+JTL45OZqGwdWbeKXtwPprw7JXzxAGmRiTt8
	Kp4j7PX8AC8/SB35aQ1/utyt2hSNstcRLCZ2bDSAef+fmhsyEFD21IzHypudYfOG5cK/Ywe7/ct
	DQT3Dlj10OLA6iUlgKWFdo/CYaQP7rgY=
X-Gm-Gg: AYBFou2vwiHgvAX+KMtJ52Xx8QEngye0WtTumlymoclrHaSptT7ZBLId2Izwpmu/+yy
	bnHzrruR5ImBIHpJKO4PkILnHy+VqG7QH9PNrMkvsAgRn5HiRDIXdBDW8yi/rcA1OERvnKwo8NR
	RzDN1Cjue3vFSAx9pZJWfrNmNKJ1fa+nzTimc5JtwV3bMaqaffxJHAJzwlRL9P07TPqB1CuV3v6
	5/BBRY97i7vk9JQs/gIJxu6IgXnTZDkV4RHvnmaN0n+hPqdGTuiBZT/jthDqFnxNa4ESSV68MXA
	5Bve/tykVVf9bWcr1LUgRZFfhVCA9+LwwaWzIZp/5MYxy7RBb7soIHE9BeM1RwyATdCler5RNmb
	CcjNPCh1WW5e645R09Ht9Bg5lyU5uYCWrtyJSUrGLaLGe4O3T7dCMAFJKiSZmKJPyCk5dkFEswx
	XPXj/vBIxN0N7uloMt24aeeRXUqpcpjcApAQ==
X-Received: by 2002:a17:90b:4a51:b0:3ab:2737:3396 with SMTP id
 98e67ed59e1d1-3adeafc9d9cmr9040558a91.65.1793124635043; Tue, 27 Oct 2026
 11:10:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev> <20261023222652.3927736-6-ihor.solodrai@linux.dev>
In-Reply-To: <20261023222652.3927736-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 11:10:21 -0700
X-Gm-Features: AclHuK8DId3Pl6_1U6_nRuwnxuRr1FR-Z3mntq1Abw-xJALIu_lse46bc5GE4ZU
Message-ID: <CAEf4BzZW9kaP-C_xPk7X1GBWjzrTdNGfZ7NTv19oYWP9Bwvr+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] bpftool: Emit __bpf_static_offset on
 verifier-rewritten context types
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The verifier translates accesses to some UAPI context and socket types
> into accesses to kernel structures. These accesses require an
> unmodified base and an immediate field offset.
>
> Leaving preserve_access_index (PAI) off does not stop the compiler
> from merging loads at different field offsets into one load through an
> adjusted pointer. The verifier rejects the resulting program.
>
> preserve_static_offset (PSO), available since Clang 18, preserves
> static field offsets in load and store instruction immediates. Apply
> it to the 13 types that need static offsets in vmlinux.h through
> __bpf_static_offset.
>
> Eduard introduced PSO in Clang and proposed annotating BPF context
> types in 2023 [1]. His v3 RFC [2] left pt_regs annotations in
> architecture headers unresolved. However, since commit
> de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"), program
> types without convert_ctx_access() accept fixed offsets from modified
> context pointers. pt_regs can now keep PAI, while PSO on
> bpf_perf_event_data covers its regs member.
>
> PSO creates no CO-RE relocations, so BPF_NO_PRESERVE_ACCESS_INDEX does
> not disable it.
>
> Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
> record, including bpf_core_field_*() and the CO-RE bitfield helpers.
> -D__bpf_static_offset=3D can disable PSO for affected programs. The
> crash has already been forward fixed in LLVM [3].
>
> [1]: https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com=
/
> [2]: https://lore.kernel.org/bpf/20231220133411.22978-1-eddyz87@gmail.com=
/
> [3]: https://github.com/llvm/llvm-project/pull/234280
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/bpftool/btf.c                          | 16 ++++++++++++++--
>  .../bpf/bpftool_btf_dump_sorted.expected         |  8 ++++++++
>  .../bpf/bpftool_btf_dump_unsorted.expected       |  8 ++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 5c88f665e6b9..c7f446ab6afe 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -1174,12 +1174,17 @@ static int btf_c_annotate_records(struct btf *btf=
)
>
>         for (i =3D 1; i < cnt; i++) {
>                 const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               const char *attr;
>
>                 if (!btf_is_composite(t))
>                         continue;
> -               if (test_bit(i, no_pai))
> +               if (!test_bit(i, no_pai))
> +                       attr =3D "__bpf_relocatable";
> +               else if (btf_c_needs_static_offset(btf, t))
> +                       attr =3D "__bpf_static_offset";
> +               else
>                         continue;
> -               err =3D btf__add_decl_attr(btf, "__bpf_relocatable", i, -=
1);
> +               err =3D btf__add_decl_attr(btf, attr, i, -1);
>                 if (err < 0)
>                         goto out;
>         }

[...]

> +#ifndef __bpf_static_offset
> +#if __has_attribute(preserve_static_offset)
> +#define __bpf_static_offset preserve_static_offset
> +#else
> +#define __bpf_static_offset
> +#endif
> +#endif
> +
>  #ifndef __ksym
>  #define __ksym __attribute__((section(".ksyms")))
>  #endif
> diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expect=
ed b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
> index edc8c5b708d7..ef01a8a4e6ad 100644
> --- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
> +++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
> @@ -9,6 +9,14 @@
>  #endif
>  #endif
>
> +#ifndef __bpf_static_offset
> +#if __has_attribute(preserve_static_offset)
> +#define __bpf_static_offset preserve_static_offset

same as with __bpf_relocatable, I think this should be full attribute defin=
ition


> +#else
> +#define __bpf_static_offset
> +#endif
> +#endif
> +
>  #ifndef __ksym
>  #define __ksym __attribute__((section(".ksyms")))
>  #endif
> --
> 2.56.0
>
