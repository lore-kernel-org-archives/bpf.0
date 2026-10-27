Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124420;
	b=yH9V/yNsk/izRIU8ap40QrWuUqXxdPwtI7+helB0N3c7B6rIVYHY2IWJmv7IaBVlb8H2
	 1gva6uruHeSOXoH5cGg6aA0WB8CavpWaYmMVkNsIZBbwK5RlZtnAQC7R2E3qVFbNXbSWg
	 +xmuxHypUDAlTx22kXaosn1tDVnh2aWoKRU7Xq/sMjezmh55coGZTdlni/zLeRhVRy+Fj
	 bR1AFg/R94M7s45ByC8Vicu1GkC2401NN6Og1z/PoRb2JmTYYbonJY3n/aTpmAXzrI+EO
	 YcaVHwNywggQGf50Pi/G5Dym5xultB4rAivOPZXp4xoM7P+bjUXIGybVn/k92l/lKew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cgvoZHxmDAwcZLK/IRbOE8Lx3gZSLGaygFwpeLqIp74=;
	b=DzKE0MPDyx062zaZXYJjJ21obQJGmC4+3T1MXKXiZpKirMqYhQu8JTdQ3SgxVYdlrwAh
	 iZHcdt9fh7vv35ds4urYH/YLbiudz83V/YZyWTpYbC1D021coXUiTJne++IuC0EtnMIQx
	 A37y7OR+KTjd9RIMdrt5VBrFB+dbgSYeKQvJekK1shM5mEekgMffzIB59zSKYGEewnDGd
	 QPyONRZ2E3R2/mziIIh3Jg0kg22YRw0c5BgBgseH6nTeAxYCSolxbgk0O/HiSEgvukZfn
	 7TI9qiQlaavyG2ObXAr85A4yRCMBHWOlKvR1e92XSgHoJD6fLCeTIF+ZWpqxjTC+nCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+zvcfY9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F062606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F062606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+zvcfY9
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so103923a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124419; cv=none;
        d=google.com; s=arc-20260327;
        b=mmU16v+UKEsD0RrnQ89SGNHreFtgzNwJU/QiifCLhjuQ2T/bEPFw/H4cxh/v7kPaBT
         Zy0iDLxAMW84hafwAN+UDvCUSduhyydRUS993p/NEE5cXZPig5ep3Dvb9sBr1qnTagD2
         Tb8bNX0/ydcQ6BMIGgO0omrJ8IXX/6cT7IWv43ssjDGYNRgWHhWs0GiE/rdij/s0wPXu
         qBLh6QuBbeWV93VWFhcOHnSO4/gcMhyzq+N5LVawZgo8ICvNa6Ags8LxftddvGK1IInD
         VLFb4QsQYfRJw+hnQhOUGd4yGEtISU0wy4XzCy72kAutRiXoGZj+v/C3Us1mehejJ+iK
         +Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cgvoZHxmDAwcZLK/IRbOE8Lx3gZSLGaygFwpeLqIp74=;
        fh=s7UNMfMddnppQFQ+UT1yhPpaK/3zREQF3d5I5C2xKxk=;
        b=dJ+peAcQPeXlClXgg0pPTGlpOW/OdDuPVPcro7bb+YnMlXM+ofxLZ+KJRy9lGcifBv
         3vT6D+9Hzd87ymgkiEpW5Aua6dSDojPaisOAoxpFa82+tDNTRcbZsfc0xKLt1Zu2FS7/
         hVHDuw3QOaPw4ZEtlMaYClMOUkOdwty7ywcpdLB1WTXEtGkPgQ7vQUS6dwJ2yOh/DX45
         YiwCRkTTOend8hmcaZnWQGfPFkAiVXiSb3/vAvUNNkS1bkBLmcwkrPTKgcHt4jlVRGpf
         bB+Fj90N2qwYyaMo2kciYpC6scoOLHIkE+IkfERVQYP8/QnOusQL9AZU8WHTZ7Bx6Jfx
         FfaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124419; x=1793729219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cgvoZHxmDAwcZLK/IRbOE8Lx3gZSLGaygFwpeLqIp74=;
        b=K+zvcfY9UH6XYHSKIpLFs510e0l46PRpJfIT2KiyEAk8m3rImXbgNuF9bI4FBl2YT1
         B6s3zq7BWTrQRC1c4WPPm/YjjZI7DJNEWmfw4fydC6MPGgfr2cgpSKxkQ5th32uI2/Es
         bHF7Ugjx6b4k1/z/4h9+E9erFUMLW+JS4eFAx/exVAkIigCP22us+Xms8an0d9mPhfYV
         7sa2nUKj2w4NA4usZ/7r9gXBGsS/LdMmMMf5Kg73KPBBG5EPvLUs8KwSnVx2mvOAmUW5
         ygHqWq/8p7WzJkvKuRKSeJZdqxDHSjfpHigmlXIGnvZP+Yw3gxNKepQ+Ye5heGmHEh6l
         5Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124419; x=1793729219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgvoZHxmDAwcZLK/IRbOE8Lx3gZSLGaygFwpeLqIp74=;
        b=KaCQMbR0cp+zzCc+dppSmUCP63IhQtoAsVxEklrF1krVzEt0uJIw3fZjKC5GRzQqbq
         2ZvdFXYqckNPUGLOS74XEO6UcUoWNC5hNeaQD4lchJX1J4lefOOzmSPTnT22LJLNvomh
         lMOBcM2Ba35G+trh0wTGzR0drcvhLX+MFH3AjFLkFMZDaU44MvcHd5haZO3bsKSShWig
         CIi5vlyzAJg19pd/3j2wr8NiqNmUVFvBs54b+0y3OhhT4auiq7sZyktaNzansnxPyhvE
         t3GmredGICzjxa5QUx+06lK6lyvJmPrdzupkuTO3ESsRW1MPAibf3eaCZY2pEYWLiJa7
         p6UQ==
X-Forwarded-Encrypted: i=1; AKwUvByJNdmlmnfL55MgRaAnSa1vjX/4ynS8mghSLazRVppuvWTU4zncAMZzceUfcZOGRxAocB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVfnO9O/uBg9eo3tS+gOOzATKwjuWCoVifCHnxH/7O3CMR5cr9
	QsCdmV4tm2uErwFAGnWZo//z0/xAxBghimOOYjAcCsdhF8M9B5Llzad/il8xZuTVATnwZpmdl+C
	sdZCBT7YYHwqnUJvs9nIQCqt1yLLoqSo=
X-Gm-Gg: AYBFou0O7qzcR4NfH3qXBSZq16nUwCnak+8UrF1eFodEoX8t5xcZMKHzH5YAl1+NjER
	VHtULDVVC7jHixHDkn1PiUT+w9RJr5QU329h2m97Uksa67Dqu/CK2DBRryeExmyaedDwPTXyKap
	9NlPeF+Ganx5yYjUqsDEVOgJuybVlKIIuR4h4GNb2YUz6GVhDGjrcoh0sLKOhDER3UDENlQaR7P
	U9+KwUnPCcSTmidwNWB+8t8YnalKJBV/Q0VoUYAzwAZkoQrs+/pN+m7tkcQKE4amMIucukS+W1F
	mKOAMOpqXTNge28eoCOwX77oEtAvOaEatjKlh3BceDwPW0Y4SOeoUwXuiLB3u8nWYLhrNK5uSXr
	vqvLLnbwUz42rSBBqSpFUJLRBsDy7kzRPSLLyOXrJ1iVPhpFwGyQF30go2Kbec54iR27IuRkKSU
	jvoEkRinQsNY99109WnB5wi6jxoxRpww73Mw==
X-Received: by 2002:a17:90b:4b82:b0:3ac:2788:cab1 with SMTP id
 98e67ed59e1d1-3adeafaeb96mr8356810a91.30.1793124419530; Tue, 27 Oct 2026
 11:06:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev> <20261023222652.3927736-5-ihor.solodrai@linux.dev>
In-Reply-To: <20261023222652.3927736-5-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 11:06:46 -0700
X-Gm-Features: AclHuK_i9FeluNEtVqkwCdJ8FLw9J5FG7IzRfSnG2qgqhkUUq38wVT90hB6FlpY
Message-ID: <CAEf4Bza2KV8ZbV2eeGyNabErZ43gY+md4WP6N7XPVL0_dw-mAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpftool: Skip __bpf_relocatable on
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
> The verifier translates accesses to UAPI context and socket types,
> such as __sk_buff and bpf_sock, into accesses to kernel structures.
> It picks the kernel field by the instruction's offset and keeps the
> base register. For example, in bpf_convert_ctx_access() [1]:
>
>         switch (si->off) {
>         ...
>         case offsetof(struct __sk_buff, mark):
>                 ...
>                 *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>                                       bpf_target_off(struct sk_buff, mark=
,
>                                                      4, target_size));
>
> So these accesses require a load or store with an immediate offset
> from an unmodified pointer. Their UAPI field offsets are fixed, so
> CO-RE relocation is unnecessary. With preserve_access_index, the
> compiler can instead emit pointer arithmetic, for example
> for ((u8 *)&skb->mark)[1].  The verifier then rejects an otherwise
> valid program.
>
> Omit the attribute from the 13 such types when dumping C. Also omit it
> from their nested anonymous records: keeping it there can root
> relocations at an unnamed type, which libbpf cannot resolve.
>
> The last addition to this set was bpf_sk_lookup, introduced in 2020 by
> commit e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a
> dedicated attach point"). Keep the set hardcoded in bpftool so the
> exclusion also works with older kernels.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/net/core/filter.c?h=3Dv7.2#n9939
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/bpftool/btf.c | 84 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 5a2c5341b736..5c88f665e6b9 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -6,6 +6,7 @@
>  #endif
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <linux/bitmap.h>
>  #include <linux/err.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> @@ -1092,22 +1093,101 @@ static struct sort_datum *sort_btf_c(const struc=
t btf *btf)
>         return datums;
>  }
>
> +/*
> + * The verifier translates field accesses of some types into accesses
> + * to kernel structures, see bpf_convert_ctx_accesses().
> + * The translation keys on the immediate offset of each load or store,
> + * so offsets into these types must stay immediates.
> + */
> +static const char * const btf_c_static_offset_types[] =3D {
> +       "__sk_buff",
> +       "bpf_perf_event_data",
> +       "bpf_sk_lookup",
> +       "bpf_sock",
> +       "bpf_sock_addr",
> +       "bpf_sock_ops",
> +       "bpf_sockopt",
> +       "bpf_sysctl",
> +       "bpf_tcp_sock",
> +       "bpf_xdp_sock",
> +       "sk_msg_md",
> +       "sk_reuseport_md",
> +       "xdp_md",
> +};
> +
> +static bool btf_c_needs_static_offset(const struct btf *btf, const struc=
t btf_type *t)
> +{
> +       const char *name;
> +       size_t i;
> +
> +       if (!btf_is_struct(t))
> +               return false;
> +
> +       name =3D btf__name_by_offset(btf, t->name_off);
> +       for (i =3D 0; i < ARRAY_SIZE(btf_c_static_offset_types); i++) {
> +               if (!strcmp(name, btf_c_static_offset_types[i]))
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/*
> + * Anonymous records within types that need static offsets must not star=
t
> + * CO-RE access chains. Named records, typedefs and pointer targets are
> + * separate types.
> + */
> +static void btf_c_mark_no_pai(const struct btf *btf, __u32 id, unsigned =
long *no_pai)

mark_static_offset to keep terminology consistent?

> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, id);
> +       const struct btf_member *m =3D btf_members(t);
> +       __u32 i;
> +
> +       __set_bit(id, no_pai);
> +       for (i =3D 0; i < btf_vlen(t); i++, m++) {
> +               const struct btf_type *mt;
> +               __u32 mid =3D m->type;
> +
> +               mt =3D btf__type_by_id(btf, mid);
> +               while (btf_is_array(mt) || btf_is_mod(mt)) {
> +                       mid =3D btf_is_array(mt) ? btf_array(mt)->type : =
mt->type;
> +                       mt =3D btf__type_by_id(btf, mid);
> +               }
> +               if (btf_is_composite(mt) && !mt->name_off && !test_bit(mi=
d, no_pai))
> +                       btf_c_mark_no_pai(btf, mid, no_pai);
> +       }
> +}
> +
>  static int btf_c_annotate_records(struct btf *btf)
>  {
>         __u32 i, cnt =3D btf__type_cnt(btf);
> +       unsigned long *no_pai;
>         int err;
>
> +       no_pai =3D bitmap_zalloc(cnt);

this will cause problems for github mirror that won't have access to
linux-internal include/linux/bitmap.h, I'd just open-code a simple
bitmap or use bool array for simplicity, memory usage increase doesn't
really matter here

> +       if (!no_pai)
> +               return -ENOMEM;
> +
> +       for (i =3D 1; i < cnt; i++) {
> +               if (btf_c_needs_static_offset(btf, btf__type_by_id(btf, i=
)))
> +                       btf_c_mark_no_pai(btf, i, no_pai);
> +       }
> +
>         for (i =3D 1; i < cnt; i++) {
>                 const struct btf_type *t =3D btf__type_by_id(btf, i);
>
>                 if (!btf_is_composite(t))
>                         continue;
> +               if (test_bit(i, no_pai))
> +                       continue;
>                 err =3D btf__add_decl_attr(btf, "__bpf_relocatable", i, -=
1);
>                 if (err < 0)
> -                       return err;
> +                       goto out;
>         }
>
> -       return 0;
> +       err =3D 0;
> +out:
> +       bitmap_free(no_pai);
> +       return err;
>  }
>
>  static int dump_btf_c(struct btf *btf,
> --
> 2.56.0
>
