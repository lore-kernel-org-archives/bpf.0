Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9344F569
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075960; cv=pass; b=uA+BfgbAxMMDiT68LKDmCI/k8+nE8wbQIZNJHoRwpo1Qbl3Aaw/tcJ020fUxcnW9QR3UEZWABM/UbSyYbR0CbQVrBx9VgYaytqKdXrGHmuPXSSPOv5kQX5jwk1VFQTyCWfy6UMTNg2dvF2i4KmamC/eazOZa1k3UuOU7gPbVUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075960; c=relaxed/simple;
	bh=OsHU0hAtgiII1FvOuUyzG4u7xiaBznFhOFQueKmuTUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR2mTdEbZsJg7/nUBuLfMPZhlapykM8kvn0aXtdCZzXOF+GkcWBJNmZjoockCnnUod8pjqw8U8G8bAUD0IzomxZY50QF427elolJf1p8Zd/yVlPkjyIpqsN+q2kKb8rKU80vQu06ItaTFmY6SnB91+bh3MkW/XUTOhhH/trf0RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDna0hNh; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDna0hNh"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae716890so200060eaf.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789075957; cv=none;
        d=google.com; s=arc-20260327;
        b=C2qVGyjyi309qeoF9mc7IxPlQ0XtgpPtzHpQIzGK83Kaiu9RMObPtvqGWiM6V3DkiD
         9U3l1iBtIwQcJhBe0ehx9MTOdA0bRFU1hw8h/+59IawEm56A/Sd8hVMSQSSn0YL1/2eO
         hvClRsE7pGPeNRy5idmv7vJz0UmSVmHFu/bd/h3/VSYK9xbwHQn5y/H4ZscgG83RVaHK
         WKfFrchkZyPPX5dNFyA9dP8qaeZFVdigmgUNWFdM0MeQayNiMdbdpeb31D8ls4R+WMVF
         xg/HXMTC7Be9sxeh6/lgvVElxLEGBqj2uquOMMeNlvkZLYdfdTzb4hrcy4ii6YPI31KY
         7fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qZuNPr9tXvYK4VNFS8XPPNGwPcjjBoJcI4Om6ZA4JU=;
        fh=L5a8hW2rJ3TD3RWX+sxaMhP4LGSECOebOywJgBtIaSg=;
        b=QIJIxXKCmtoX6hEEPdg5c4rRoJLR+2huBKSwNd5rtXZ/7Z9LuH4j9agLBnYeSdRx1d
         ZRwLwtQXdqZfkXLGBWzd5Lc9aWuAguSxHUotatGNk+K742bDqL8c1R9EhRX75u/rPJvF
         St7IjK4FAWG4ido6pwal4GsZVDpdiJ2UV/Idn/JXW01VUAhb/gL7rgvF6y531FN4KJmE
         9/u0GoJgBpGmoBK3SH0vQsUkAHTLeiVd32YFSgCGxc8WNZ5UiMSFLNchZVp3GO8QtFCn
         oKZ730q/qAfJNvNtB6CPiBB9MJNT2DcRRPodV3XuWGZdfqglgY/KHH54Kw3xGlJHQEr6
         hQ7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789075957; x=1789680757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6qZuNPr9tXvYK4VNFS8XPPNGwPcjjBoJcI4Om6ZA4JU=;
        b=TDna0hNhtt61hHnPzoin87PMadi7C/MgQDk6PPEZ84b2JdFiBeC0IvV5vVfHW3PubQ
         3awpzF1r5Nq8nKTu3TfQcmDZbXJMUwtAKCOugQlyhHedVvqA8Hmb/cZ5MaLoFNyJd/8B
         4WvPAu8sNIloy5Ao9L/rtcGuxtbELkqvgJ9+oh3QjOWRI28x49IlBX4aohbOkgUKMXff
         9l6ZKeiAoYN1gNdFaitnyNTE4Ox38BPoJfYA2C/wFHuaedKX78IZo4RKqm8BogNHoXA0
         JNZ6RRP6gTh2393SEqGq3GyPebhecMIa4a7Iy2nj9+KLfqwJt7i/a+v8/kiAqVul79ec
         JVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789075957; x=1789680757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qZuNPr9tXvYK4VNFS8XPPNGwPcjjBoJcI4Om6ZA4JU=;
        b=cWpVtFd8a1jyIiOcHuSBoiy6GbDjr2HzCVlMdw9Xf86QAcr9jw7XSkST4xpUPdeNmq
         sxfAQtYRi2jLxeBDEOSFdUWXhaVjYtEx0bszLW42Plpur+f51cWxau3eTs3JfD7kHNqG
         M+mPON4ogXmm94/ZTY/S7WRs2Zu5v7IegfaW4cp6oi3PNt2JdHWl5+JbaNirbZhpedZ2
         0ikoYSVHksISgEFpiTdj9VYrpH5NHQkEDLjRRLb129pQOYUoh6XA2BiBIDXyxC/lTt5/
         JmWOCsq+LLfRsAs8HcGL5cmbj87nKbnW6+8jr9UT/ZgEDD7kCobNdlI0apeVyy6lWRlb
         bFjw==
X-Gm-Message-State: AFuF++kQ59leR7KTBmPmf5WTZtFoz03qOhC86z6NEeS05QHQ+lWNZLZH
	0QxW3TrKylNYy52LxWf9ucuL8IySl6OIY59hkKMpGNXYNOCY0g5vxH9kSQ+KtO63YpYXPrvRTV4
	BOL6BBxWgDvwy+xjAkSR0kteazvEe2Jec16qK
X-Gm-Gg: AYBFou1CRdlbJqgitrguKaOz9Guz7aLWCTnU6J+BvqXu5XS/cpcZHjJcOL/lnL+E11y
	KZu/A2wRsUkWgWzmXc6T6monkUTyPq5amDifOOmw5cSyunhaJ8mbaCFvYSG3CIHJLpt7oA1BMXh
	qg0Nx3rdkdAW6FqezFNqHd3BoUjf/WWIRALPFf7w3NabpOEVR9aCvRfDxZGyOTZ16dCVgQ/mnN4
	V/JufiV5OfaNUclBVnLQ6nubYoJeTKAMfzCmTkDp2+uSNpbZTxJVuQswhNglhTdTTANCLujqMqo
	dt8KQ6M+yEnSHRCC0a14Ngh8BpBkifMFyfQMOVkDOWbtq3geh3x2Dw+7IIwP6s3adg==
X-Received: by 2002:a05:6820:83d2:10b0:6b9:7d9e:5708 with SMTP id
 006d021491bc7-6c0b9e5081cmr965247eaf.3.1789075957536; Thu, 10 Sep 2026
 14:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910172340.1467764-1-caomingpei@gmail.com> <20260910172340.1467764-2-caomingpei@gmail.com>
In-Reply-To: <20260910172340.1467764-2-caomingpei@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Sep 2026 14:32:25 -0700
X-Gm-Features: AcwNN1VQvKiKA69hSJ8Ixmu4fIFlROLv-_PFNuJiV9588u2exUY7n95xGZag6Mc
Message-ID: <CAMB2axPL9+b-WWh4QK+w7Q+nTSbDwcDk0oVRx9Od7gSJT_6eaw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Reject struct_ops bitfields before
 accessing data
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:51=E2=80=AFAM Mingpei CAO <caomingpei@gmail.com>=
 wrote:
>
> A Clang-generated struct_ops mirror with an all-zero private bitfield can
> crash libbpf. With kind_flag set, the BTF member offset also encodes the
> bitfield width.

I find the commit message harder to understand than the code because
it emphasizes seemingly incidental configuration details and uses
undefined terminology.

The segmentation fault can happen when "using a local struct_ops with
bitfield absent from the kernel BTF type", so none of the detail such
as clang, all-zero, JIT vs interpreter seem to matter...

I assume =E2=80=9Cmirror=E2=80=9D means the local struct_ops type in the BP=
F object,
and =E2=80=9Cprivate bitfield=E2=80=9D means an extra local member absent f=
rom the
corresponding kernel BTF type. Can you state that directly instead of
inventing new terminology?

The bound-check issue raised by CI bot seems to be valid.

>
> bpf_map__init_kern_struct_ops() divided this encoded value by eight
> before rejecting bitfields. A 31-bit field therefore selects
> data + 0x3e00000, where libbpf_is_mem_zeroed() triggers an ASan SEGV.
>
> The issue was found by comparing the same ELF in JIT and interpreter
> configurations. JIT+BTF reached the faulty struct_ops path, while the
> interpreter configuration rejected the object before this code.
>
> Reject local bitfields before calculating the data pointer. Preserve the
> existing all-zero compatibility path for ordinary private fields.
>
> Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in =
the kernel type.")
> Assisted-by: LLM
> Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..1738a42220f0c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1223,6 +1223,12 @@ static int bpf_map__init_kern_struct_ops(struct bp=
f_map *map)
>                 const char *mname;
>
>                 mname =3D btf__name_by_offset(btf, member->name_off);
> +               if (btf_member_bitfield_size(type, i)) {
> +                       pr_warn("struct_ops init_kern %s: bitfield %s is =
not supported\n",
> +                               map->name, mname);
> +                       return -ENOTSUP;
> +               }
> +
>                 moff =3D member->offset / 8;
>                 mdata =3D data + moff;
>                 msize =3D btf__resolve_size(btf, member->type);
> @@ -1259,8 +1265,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>                 }
>
>                 kern_member_idx =3D kern_member - btf_members(kern_type);
> -               if (btf_member_bitfield_size(type, i) ||
> -                   btf_member_bitfield_size(kern_type, kern_member_idx))=
 {
> +               if (btf_member_bitfield_size(kern_type, kern_member_idx))=
 {
>                         pr_warn("struct_ops init_kern %s: bitfield %s is =
not supported\n",
>                                 map->name, mname);
>                         return -ENOTSUP;
> --
> 2.43.0
>
>
