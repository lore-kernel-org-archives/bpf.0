Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F63672A8
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379141; cv=pass; b=B0OeOjEE7ecOO9aimCzEZbVPWUXJUjsClCFf2LNwNVNBITfPQsma8SzzrjSfaFlyou5zsjaas3UMCAn9OFZJQJGkgJlVdCc4je+AwIX3s+O63TG8rh2dPIeVsdXqWdaWr8j8jy2bH6PYgWLHPEH6sqbfdjJsNXnqpPQmGhn2uz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379141; c=relaxed/simple;
	bh=j+18zH4z+m0k1FZ0dd1cO98bGHWJwxwzLIK0UXvDr7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuGuTjrAXF4IaAnnToXQeHOMsjtEuYD2SaWj0nS0DLm7+VOe7EtIMk4HRJf692THD0R2zFZZqt3KFB1JPLXM4PrGf4/Az1NJj3/KT4l3+0dIP9SUiSsoIsE1IHj6CpkkZXknarCrxqnDTfL9c8KGrQYN+f0NLWa+PKNE9rGyj4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNBDRm7B; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNBDRm7B"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so6618665ad.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790379139; cv=none;
        d=google.com; s=arc-20260327;
        b=I8U4/WEgRk8HX5PDei9pIhora60NcBL+EKnnx1gQyYepR91zGdF937grU0eFRfhqJM
         5Q8wd9m10uc9BZeErUvROCPSI2wV691II4N1AAHIuIp5GLM2zYkGnIxfe+1UQaLArUeU
         EnLeliLk2gGgd8EtJU34nZAiJguJuF5c9oxuEg18LXxPFJPGCKtOca13k3Hm/FsDeNkS
         qZw2J6oJdf3MlKah8K42YrvijV3vkhtqlGixSI1weOuyi+xPGJr54CWxhNFTn1DL2V/V
         CkFNkBQ3mSGcnEh5n4oDmGV37paeao8J9VW0dxRSHgWhQ+3RpuqmwV20+dW+bVapHu2m
         eiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uojy6J6IqOesK9tCRrbsVJpUEHxbUlzpNFdYyzAnwaQ=;
        fh=D+z+sTvAMBreHAxhZBjm44bSIwYWtuLvPvLgJb5bpxk=;
        b=r8Dd+zSKwkwCuyMdoDhlGR6XEtdcHM8IyAW6y3LmJ4yYQfAPD3KNLdM74oPOYS4T4L
         XlEzLIuwyYeBsPKFfPcBQFXDakrJe6iU2D3Lv3PQsv9Bo+WpKvl5qbqzCbVpxURalwIU
         3TJz/8xkzCpyvQhdDBq/+ZKxI9zemlQxT24LlHMu6KqsA4iAS+7SKUxV2w6w8busIN0I
         MWv/LEqN6Bo9CQJMTdwigthDLQ5NCi57tCleYvOBt5s+DKv0yF91MLY5egSh+9LvgPj2
         ub3UfX31UsFSOL2S+msULc3Y0ZV62yhCYnAvHb5rFOI7RGWTPFG7RzOzvdwd12pCYyze
         y3zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790379139; x=1790983939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uojy6J6IqOesK9tCRrbsVJpUEHxbUlzpNFdYyzAnwaQ=;
        b=BNBDRm7BFSM2xkSy7NejenYL0Kqap+bX8/r5FFs1VggPYSBXBMmTK48rmFpegzWC4w
         /FhsI4kxKHF35qRpPubkrmP7zX2yGAw9J8ariRlkeJFqkQyGeajTrryZs6ibs4vEgXel
         btTKjvnRNvu9TrziLckX3kA1BWLqmyCty4vo80A5Sz27iKONDYz1TctUmodYsRbihbpX
         NHalODKcWIzHL7ori4QbT8KZlQ1V/bqPqcSlWjpA+8oHzUEDDoPCP5ik7GrBLV/h/NtM
         DQxumfdVSksTvbqKXAki4L92/CmIKNOPnte5MuJTBcRrT9f7kRSBrbmeNvSH8Z1uMY60
         PIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379139; x=1790983939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uojy6J6IqOesK9tCRrbsVJpUEHxbUlzpNFdYyzAnwaQ=;
        b=W3ohhYDzcmRICwzO+mJlQ1BEGiMRkhTAYhomWOROhIycl26jwzJ3E6bAezUDPOvz61
         fLnwOQld8SEiFM9kSB579mrVQG8eZEXyQGUwYg2auk1/+pzIBCnymPj8PysumT/wanh2
         7bk7l8sEtqoX4SPTYLe4A4bHZ4n0Mxh/kGKyE/SL46Kb7ubLpiFp1athXD6HF7H4iRTd
         x3ycEkbEkOCetgWHKtBzLoYrMJy4bHY08zyEpKTyp3byuvz/eGy8FpE8yVZkzHTAoPLO
         gqTjv4sTfz0K0zA2aRQQfAGDzS/EmVGmQo7eqQpK4PSSLbCRlwVx56lcCzLbO8ULXzGm
         bFYw==
X-Forwarded-Encrypted: i=1; AKwUvByG8TfDm1Ps+a/OdFavEWB3U6l6QjUGDLG/CZirrYXTwDxPKUoHF71sGoHfUNqlcbziOfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7ZcM5qLCy566NQBsA2e2ZOL+Gc4HV6teUSWdNJiuzon1ENyJe
	n6vpJKyYt6WB63gJsjwX17qMQzkMyFkvqHNF4+6jdApDppwQogv4qGx+JU5zWj7h/5tgD354orV
	0n0ktngZ73R8VT/j37gkZXb53D5E/EfY=
X-Gm-Gg: AYBFou3ac6n7p5GioyP7PwjrR99OyjtSuFPiQgEyFoTjG77K1z00K8//8VH4zVhDrqS
	1MvNFVggB+bEBAgwQO3IsLtg3khn6pXug6Gdfs2fRrKHCoWjkRRtVzPvIC9WDOswCO7/kBa0A/l
	oP66JM/896yhCtT17Y2C5HJT7/AjWfEL+dtXplvuON9by9K7rJEF2tslPuwSIZsfbjUL5txxBxM
	hinzlnJ2teWQRf5ardQjZb+opUl3I3GXZTIFXbFaJivQ+rTuMh7P6zk/35tlPWVWir00xgw4Gos
	1xTWYz2JlLAkuP/QwgygBQ3L1c7IR+MUNvJnz1rq7bXTBWaHV0k47tQQlwfyX5rBlBHrm/gTnhs
	fyqZhxIPkk3r0Tynk1WhazcWa9qROiY3ekLXk
X-Received: by 2002:a17:903:37cd:b0:2dd:c053:c208 with SMTP id
 d9443c01a7336-2df7dc1ee10mr53227255ad.36.1790379139383; Fri, 25 Sep 2026
 16:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925224631.1490488-1-andrii@kernel.org> <20260925224631.1490488-2-andrii@kernel.org>
 <20260925225809.B4AE01F000FF@smtp.kernel.org>
In-Reply-To: <20260925225809.B4AE01F000FF@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Sep 2026 16:32:06 -0700
X-Gm-Features: AclHuK892OGHXlxagHR-gVN-qbZR0IEC17qQX162odU9MC5MDHyosbHdN2Jnj-0
Message-ID: <CAEf4Bzb1vDcu1NWs79uOwrmXUz-J4XetWQiUYUAaTuAu=su99A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add linked_externs test for
 externs in allocated sections
To: sashiko-reviews@lists.linux.dev
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] bpf: TOCTOU and missing error check for mkstemp in test_relink=
()
> - [Medium] bpf: Missing NULL check for bpf_object__btf() in test_relink()
> --
>
> commit 2e7da3dcbd552604f0f6c052dc8cda7a3628ffb8
> Author: Andrii Nakryiko <andrii@kernel.org>
>
> selftests/bpf: Add linked_externs test for externs in allocated sections
>
> This commit adds two objects that define an arena global each and declare=
 the
> other one's as extern, linking them into a single skeleton. It also intro=
duces
> a test to drive the libbpf linker directly to verify the relinking proces=
s.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/=
tools/testing/selftests/bpf/prog_tests/linked_externs.c
> > new file mode 100644
> > index 0000000000000..29358c82dc356
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> [ ... ]
> > +/* link in1 on its own first, then link the result with in2 */
> > +static void test_relink(const char *in1, const char *in2, const char *=
sec_name)
> > +{
> > +     char out1[] =3D "/tmp/linked_externs.XXXXXX", out2[] =3D "/tmp/li=
nked_externs.XXXXXX";
> > +     const struct btf_var_secinfo *vi;
> > +     struct bpf_object *obj =3D NULL;
> > +     const struct btf_type *t;
> > +     struct btf *btf;
> > +     int i, id, n;
> > +
> > +     close(mkstemp(out1));
> > +     close(mkstemp(out2));
>
> [Severity: Medium]
> Could this result in a Time-Of-Check to Time-Of-Use (TOCTOU) race conditi=
on
> and silently ignore failures?
>
> mkstemp() can fail, returning -1 and leaving the template unchanged. Beca=
use
> the return value is discarded, could concurrent test runs end up using th=
e
> identical fallback filename "/tmp/linked_externs.XXXXXX" and corrupt each
> other's output?
>
> Additionally, even on success, does immediately closing the temporary fil=
e and
> reopening it by name in a world-writable directory (/tmp) introduce a cla=
ssic
> TOCTOU race condition?

classic no less, but I think we can survive that possibility just fine.

>
> > +
> > +     if (!ASSERT_OK(link_objs(out1, in1, NULL), "link_stage1") ||
> > +         !ASSERT_OK(link_objs(out2, out1, in2), "link_stage2"))
> > +             goto cleanup;
> > +
> > +     obj =3D bpf_object__open_file(out2, NULL);
> > +     if (!ASSERT_OK_PTR(obj, "obj_open"))
> > +             goto cleanup;
> > +
> > +     btf =3D bpf_object__btf(obj);
> > +     id =3D btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
>
> [Severity: Medium]
> Does this code dereference a potentially NULL pointer?
>
> bpf_object__btf(obj) can return NULL if the loaded BPF object lacks BTF

except it won't lack BTF, so yes it's fine

> information. The returned btf pointer is then passed to
> btf__find_by_name_kind(), which dereferences it internally (btf->start_id=
).
>
> Could this lead to a segmentation fault on malformed objects instead of a
> graceful test failure (e.g., via ASSERT_OK_PTR())?
>
> > +     if (!ASSERT_GT(id, 0, "find_datasec"))
> > +             goto cleanup;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925224631.14=
90488-1-andrii@kernel.org?part=3D2
