Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA23FB055
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451476; cv=pass; b=dxsQ4Gj01MkWr1Zw7Mw6FO8x5wnf0Ew3p2uYlEPOuz1fj7FnnSoR5xqIxRmS3rcwmRXtUU+otzVOfq/8ovS2wt0ZVw789k0/1e4S9YSggw4YhxMi43M9OdyVsWcgGVPoQ8oNIQ3+IFCf6MqAwjI5TtsZ2iu1gHVE/GYgB/jinIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451476; c=relaxed/simple;
	bh=tEmJpwuP8Bx2EyfWOZFEr5jKjcfFXY3n8OTV2ATLxuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naF82dP2F2EdTTEc5fPDr6lh5Z7y/pPvipzJKEsesyAOOVaem/QmwAWzphGBsZBhGWWeJcqWAMULoE1QGCIfAzTPfeCPzWTSZJPqlRemG/9s3RpygPT/5rP8zSEmGJVylx9jo+LSfmkfyEgAMf4c+8wxpGl8UqbZlVaDANybBfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPxdLatd; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPxdLatd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b4915161fso4979320f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 08:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451473; cv=none;
        d=google.com; s=arc-20240605;
        b=hwGK0Gxh6CLP/f4PUIdTC4XPlH26KrOkmLPIK9lZTwrxZ0HrLfWDp0fQeBUFyh5a6x
         cHXeIC/VQLymqSEQyFem9gaYJrUTmuMAA3uDCVyx6b/QGtt8Qx+sRFfBJ+VdPjuPToIU
         39aTPTAJkroGsDN0qsKpPN1/rFAjCzgBiSA2dkiE9A4navHrpz7mdKGiferOwHDIYii3
         MaUgnBSodBdBsphUqUoPafbhR6JY20rziHTVsTjRQwYDYQ7sNoKnX8iAMDDETW+uSlpe
         4/eblLOjdW88gESQbV+uUTpptpIY9+qapTSwSUBE3vw5AGntsP48kqf70vJ+/kvjyGZC
         woDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        fh=6Ka4dRoNwLjWO08oQwtV4g9XRAHU074KZ+oC0S2FD50=;
        b=h2obsz+hbGwl1gx8v0bZN5yByV6TmFDPCmme2va9n95gwcd1VJHsPOXN40fjMQ8/nm
         uJeGthB14qnq3iJ/p9VBFRMh7xQEMN/K3JhvebYQ2/vSZd/zbQlQgX+0JGwJBrlgY8ez
         9YvwxQKBBetdRJILUqIl8T2RUiBwd5uggUZAf/nshZ3h0YA/dfo76/Bgk/g2nNRIh092
         CD1VJwv4AAyKlfGfytHa7XFRQb5YZqm7TTZ/o6KHLV2x0GZagF58wZntqNxtne8KNnBp
         uVHBjCQ3u6lo13enhVdvin4ECsKm82BIygAUpZWhZd6G4j+yeaXUMfVATKRmd00wjZLX
         m2rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774451473; x=1775056273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        b=JPxdLatdT8i9BQaos2+4O9ahU7LAvsvFHGJ3Clopjk8ZEPDc6ONak1UyshIMaCXzmn
         p9YPZ85VmzY+bTczA9BPjk7VLzX/lRxv/RQ5MrzauHCU1+YX9a490/7z+4hVhWDXsLT6
         A3wbNC+7sjurwikAcGnsYPpTot0LGdqpEZz1gIudC/S/bqCm8TzY9Wx2E6KVW0pjmuLG
         E70Vy2HowEK9CHqN49x/OpC3zUdcByd9hSFe4z+YND9RY0CxUiCAE2UETN0zCqPkFLC8
         ZBINszU98/CTFQ5K6KeqFK6EQfPtL6RbAk1oeXRKmICck2p+B/JhBMkm8mVhicDCme6F
         ei9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451473; x=1775056273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3iMCoDWAAEuK9jwULonU/Ttd/NY07moV9+aq4YSP2o=;
        b=irCZZDrNlL5l8WXb7uajsCmwQEyUpN3HyyaNsSrlenvo1kghgSL3nM1pt8Wds+QhUs
         RZQh4rTwhbUX3cEiIkcLfNw6srqzuOmUwUXqIluK7nh5VnACN6gTkeHtQFD5ofoVXJUt
         A+XAYftFnIlqfC1S6P40MK/h023MGUzOQ7nT9jd/PZ3vGLWtK+yaj9QrDzqxx/C0MXRb
         OCL0CbS1PwBMxAts9kPT9VJKxbUqKE/0nx+dOr29qA6m1yXqEO1GtbulOOgbZwAPJ51Q
         qtzGvqMviLTw9sr9oqtuPf7ULUXNxBdDspA09gZitpR85MkKkqg/hDg/IoLGMNRL33om
         txRA==
X-Forwarded-Encrypted: i=1; AJvYcCXKDHXbtkdE7wrqBLa96nBlnr9W1LH431sc5rMIMs9iXNoPh2v8f40YZgwG2olfht/r20s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLXPnst5W/lD0PCFp4IRgkgaqk1NZJtP74vSB5G8VeEP7EKNO
	AiSjc8Jo3AEnDZdlZAK97UZkhVIqjwAhMylUtGQyDWXDWG0UbRvGhW7brmu6te1CpyGceba1Nln
	CimktJ+CC6RIWSVeV4pjaaL496SnyNds=
X-Gm-Gg: ATEYQzycbFYmLOssf45p9Y6WMLdVuelwNSZiMxHJ9/9TLqn2FfWl/OcF7Bp7B5jQ5UH
	9hbpSoBW2E2sY64KFZuPXTTDZzjPhEwxWlMOZjzq0qmSMyVBz7BrTea+tdmAEOB8x4SUSJo5tdN
	0dvd2bxdn1gfbdpHYQbMrwow66mc/jtozcbEYqwFkwC1OZhnc4HTeGRDn6+/Qg+BFpLPqqqSOIY
	+2jo9J6VTNwCFPUkOlpq7OlJy3gDnv8rJFO/4UqK/jlfQQDjNZAGnF2VWYnzUWUzPKMglSKsh3X
	PgC1uXtplwyPXXX2rdaXJoKdBLpZQUabsiD06T5pNmKDef5Z1Skdwyq6cNSx+XoVPMhDYWKD0WK
	xqfnGhAktrDRTWhUBnmu689MaOw==
X-Received: by 2002:a05:6000:40e0:b0:439:af81:1b23 with SMTP id
 ffacd0b85a97d-43b889aaf9fmr5597133f8f.21.1774451472938; Wed, 25 Mar 2026
 08:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324081846.2334094-1-jolsa@kernel.org> <20260324081846.2334094-25-jolsa@kernel.org>
 <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
In-Reply-To: <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 08:11:00 -0700
X-Gm-Features: AQROBzAUBDSr70gmyhrufj8u8FMSWnPty6h_7SeMpMvBeesJou7M0cJ3OLUDeOE
Message-ID: <CAADnVQL3gO=kuvDHQNa8VfL_NWUMvBv6=vrXkOd=8Fe9-dcU3A@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 24/25] selftests/bpf: Add tracing multi attach
 benchmark test
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:45=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> > +
> > +     btf =3D btf__load_vmlinux_btf();
> > +     if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +             return;> +
> > +     skel =3D tracing_multi_bench__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
> > +             goto cleanup;
> > +
> > +     if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> > +             goto cleanup;
> > +
> > +     /* Get all ftrace 'safe' symbols.. */
> > +     for (i =3D 0; i < ksyms->filtered_cnt; i++) {
> > +             if (is_unsafe_function(ksyms->filtered_syms[i]))
> > +                     continue;
> > +             tsearch(&ksyms->filtered_syms[i], &root, compare);
> > +     }
> > +
> > +     /* ..and filter them through BTF and btf_type_is_traceable_func. =
*/
> > +     nr =3D btf__type_cnt(btf);
> > +     for (type_id =3D 1; type_id < nr; type_id++) {
> > +             const struct btf_type *type;
> > +             const char *str;
> > +
> > +             type =3D btf__type_by_id(btf, type_id);
> > +             if (!type)
> > +                     break;
> > +
> > +             if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)
> > +                     continue;
> > +
> > +             str =3D btf__name_by_offset(btf, type->name_off);
> > +             if (!str)
> > +                     break;
> > +
> > +             if (!tfind(&str, &root, compare))
> > +                     continue;
> > +
> > +             if (!btf_type_is_traceable_func(btf, type))
> > +                     continue;
> > +
> > +             err =3D libbpf_ensure_mem((void **) &ids, &cap, sizeof(*i=
ds), cnt + 1);
> > +             if (err)
> > +                     goto cleanup;
> > +
> > +             ids[cnt++] =3D type_id;
> > +     }
> > +
> > +     opts.ids =3D ids;
> > +     opts.cnt =3D cnt;
> > +
> > +     attach_start_ns =3D get_time_ns();
> > +     link =3D bpf_program__attach_tracing_multi(skel->progs.bench, NUL=
L, &opts);
> > +     attach_end_ns =3D get_time_ns();
> > +
> > +     if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
> > +             goto cleanup;
> > +
> > +     detach_start_ns =3D get_time_ns();
> > +     bpf_link__destroy(link);
> > +     detach_end_ns =3D get_time_ns();
> > +
> > +     attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0=
;
> > +     detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0=
;
> > +
> > +     printf("%s: found %lu functions\n", __func__, cnt);
> > +     printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +     printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > +
> > +cleanup:
> > +     tracing_multi_bench__destroy(skel);
> > +     tdestroy(root, tdestroy_free_nop);
> > +     free_kallsyms_local(ksyms);
> > +     free(ids);
>
> Is btf__free(btf) missing here? Since 'btf' was calloc inner
> btf__load_vmlinux_btf().

Good point.
Leon, please trim your replies. No need to quote the whole patch.

btw sashiko caught it too:
https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
and many other bugs beyond what bpf CI could find.

Jiri, please address them all.
