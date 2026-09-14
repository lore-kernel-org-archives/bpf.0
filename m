Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3490356778
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419938; cv=pass; b=K4vCOHCEIeqMlyrTQRYAiCX9JXK77BJRUXjf5LOvfL/mmOTh8c54r+8pVraPniuII2T0yBMRBsWHHWr+mvCYq+UL4JuKoZbSSk7IxrNTu6INPdVGxm/AyeN6T1IAYX3VYb+aFknHGsB31UaLt2xvJyFKkJOxCmZah8t9W+x8uMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419938; c=relaxed/simple;
	bh=KX35YWpBTvVeuDkFkxyw+6grtpng31Lm5+PSvM7Uv1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrJS/kbzqOOSCb/saNxDG0HkCeRcIYvLgvAileoE/ZLjBnFPOKxy2X1U+xizSIbnXM3hKTcoh5GZvXtYHqBPp5Du30hsumTBJiZ3ksmH53qTIcRmZln1VwZ3DgGoTihjO+jXpl7pUhd7n/cFERNMfNuiyVCCFAT6MhIJTnN3uQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPqNyCAM; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPqNyCAM"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-805010cbdebso178537a34.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789419935; cv=none;
        d=google.com; s=arc-20260327;
        b=aCc3sZeZm+sIbZe44QrFyzRfnMWwbLcapGbw3/TLTDSbUFeprtABaDboQZg0t5ztfH
         Y5IOL9d2Afaoj53Ghc7qEoxz7WR0zfYrO4F8iiWaihvCWJsZC6SRSghtq0dyP2hfEFvv
         zzlc8a0tBNsQm8hUZ2YxOMy+owZP7RrnioMbaS+VxU94+Y92b6/INdP1f01ItuZpQZXP
         nD/Onz0LxlmnY0f/NPcMpJMuLoZcWiWumkGvQWmJCFjRBTZ6xyPCDr9vCgBn2447smDx
         PewRj5OxuTefH4SSvMUhzkzbfOlW8bruL5rEHRdErJ53vVn1ihx4mryeOsRCCnNluqmC
         TjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DlfFfkeeODQPtjGb0+ChAiryAvD/2KqG/LpFcF6aqIA=;
        fh=sdkKHmTayIKuQSsa4g/4XWSwbFU0QUPSpFRWUcse69c=;
        b=A+QSq06bagJT1ihTyjV8G8lwDUaj41Vb2uCdMowNrzjrLjH8ZDAKVXGZMkg4Q7xWev
         VGihUnTb43CjXp0CBUwUVEu+3f3mthe+dF9amUIblPhSHjWW7DeyH1RPnh313hxCtm81
         OlZdRAfvETFtZv2dVw+Mikp7EXIS1lB783ktpBC4qvAb1MTf7fBvB9CbQcAlyxK9tdBs
         ckx8D6lz8ICmtU3CpurayQk+/FJ18C7uECVKg04kziWCqL9UknPs0X3//W7MoCk9mj/V
         2A2OqnbsI4V5YP8vuxfIoDdwRvkhV1GWPdK8EM+ysE8sIP0gMpc//wVgLhJ73RQB3iB3
         8oRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789419935; x=1790024735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DlfFfkeeODQPtjGb0+ChAiryAvD/2KqG/LpFcF6aqIA=;
        b=mPqNyCAMLQhpOPbIi3AGBgG/Ci2hI80+tQl9dKqMHhZZ8Re8YZG0PVNKPgrjGljIAM
         Abd9d9CodVe6KnJafazLlHOWVb2dvHf2v0ATP3Lo41w8BrugQXn1sVHaPrsHW/SqUqJA
         lsnYMDV3SeBkqFzBj1inl+ojWymPQnVU0CdX5tA9wMZoAl0dDhLF1v63rvR2ECsv+UQH
         H++3LXvt9SGNBdDWTKKfP0OpHR/5olXVO+afx8QA2b7GBm5jwsbXDxfJDKmTDtm8ZgSy
         1zygyH/qdFuJXdpI3lgbFO+eLbPA3npxpkZhEvQjrOk/ZWfQR4sco2Wk8ngUpRya7zMK
         gDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789419935; x=1790024735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlfFfkeeODQPtjGb0+ChAiryAvD/2KqG/LpFcF6aqIA=;
        b=C8uRdQD3og5j1DhefjGnZ98LCm7x+ZzlEkJMhx9r6cxrINA+sFD4x1+6yJs7cTE90G
         M0EWlCUxkf+ycB0ayyWNvjLXHQp9VoY8vH2HPq/ydjOsrQN6LNPyQ1ZEKPQ4YCkgkKmO
         lTUGoX51G4bUFfXICvZ5/CCwYUvtji3d3Ju5s/DRtdcZhvXk5TswT3azml8uJflWgFK9
         PjvB3iU18OsrQxcWI3KDxN8mQ5agqbe16BO5/f7PZW1Pu43h58h3FY7VAovDKtDmu834
         R77oGj+BMzSS8cMo8a8M2/9R5NnI8Wt78j9C2LECzFIasvIogkdGgbBeu+TftjT3fsPL
         S6uw==
X-Gm-Message-State: AFuF++mZhF+9wbJBw5mA7NdYfndSjw7DpOuIksS4ej7ikybcYgEMzp5Z
	CIfAHSnAvPBFlHYtLZDU8oW0iF5U03hvFTBS7REzv31BrbxcSkWnEO4KITpzl5pWmsQ0f8RKLN0
	0KS2fJ+yKEAFo+F9uFdQ9orup2EOlWF4=
X-Gm-Gg: AYBFou291CrsqHIksvWcrbIudXuzThs/EliZzkA80j4bkLxt/TJpGK6zqLPGJeb70Kt
	rlOyt0eQzfnQu4x7Pnu6PwBUaINph8PThpan1LcsBQfzY8gul4BwALUkOLbAG9U0lvv7NvdUT3U
	Xz/WqaGZDf5I9K3NTpEPZ8Yb7JFw9ynT3ov6JfDtr4SghvGY4C6WAAIgPUU9NvaVXWRZPZ07d+O
	K9E4kAGQUYquVTNgo0BuhXIC2sXhCwPplv3IYgbdg6Ei6gNGRyyEH0coyfco6nmTLilnOE0cvZY
	9STOo75JR/O6FuLlsTrZgXm6jIx5vvXQqoj6a/P/0feB+FDgwgOkg/Y+Yn6cPbkDuw==
X-Received: by 2002:a05:6820:f007:b0:6b1:7e2b:dc01 with SMTP id
 006d021491bc7-6c6379f9195mr639484eaf.11.1789419935523; Mon, 14 Sep 2026
 14:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145233.1446643-1-caomingpei@gmail.com> <20260913145233.1446643-2-caomingpei@gmail.com>
In-Reply-To: <20260913145233.1446643-2-caomingpei@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Sep 2026 14:05:24 -0700
X-Gm-Features: AcwNN1UrskVbucw3h-ZrobudScDt4KaLlErxyEVMH3yz8rzphUiJ3hzW-AX3-F4
Message-ID: <CAMB2axMvBBXSfv_TC0F0i0hy4cUt4SVCcUq_POGeiaYOochw=w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] libbpf: Validate struct_ops member offsets
 before data access
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 7:52=E2=80=AFAM Mingpei CAO <caomingpei@gmail.com> =
wrote:
>
> A local struct_ops type can contain a bitfield absent from the
> corresponding kernel BTF type. libbpf checks whether data for an absent
> local member is zero.
>
> For a bitfield, member->offset contains the bit position and field width.
> bpf_map__init_kern_struct_ops() used the full value to create a data
> pointer before checking the member range. libbpf_is_mem_zeroed() could
> then read outside the local struct_ops data.
> bpf_map__init_kern_struct_ops() also failed to check offsets for
> non-bitfield members.
>
> Reject local and kernel bitfields before reading member data. Check every
> local and kernel member range before creating a data pointer.
>
> Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in =
the kernel type.")
> Assisted-by: LLM
> Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 80 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..2791b48585939 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1175,6 +1175,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>         const struct btf_member *member, *kern_member, *kern_data_member;
>         const struct btf_type *type, *kern_type, *kern_vtype;
>         __u32 i, kern_type_id, kern_vtype_id, kern_data_off;
> +       __u32 kern_data_bit_off, kern_data_member_idx;
>         struct bpf_object *obj =3D map->obj;
>         const struct btf *btf =3D obj->btf;
>         struct bpf_struct_ops *st_ops;
> @@ -1195,6 +1196,25 @@ static int bpf_map__init_kern_struct_ops(struct bp=
f_map *map)
>                 return err;
>
>         kern_btf =3D mod_btf ? mod_btf->btf : obj->btf_vmlinux;
> +       kern_data_member_idx =3D kern_data_member - btf_members(kern_vtyp=
e);
> +       if (btf_member_bitfield_size(kern_vtype, kern_data_member_idx)) {
> +               pr_warn("struct_ops init_kern %s: kernel data member is a=
 bitfield\n",
> +                       map->name);
> +               return -ENOTSUP;
> +       }
> +       kern_data_bit_off =3D btf_member_bit_offset(kern_vtype, kern_data=
_member_idx);
> +       if (kern_data_bit_off % 8) {
> +               pr_warn("struct_ops init_kern %s: kernel data member has =
a non-byte-aligned offset\n",
> +                       map->name);
> +               return -EINVAL;
> +       }
> +       kern_data_off =3D kern_data_bit_off / 8;
> +       if (kern_data_off > kern_vtype->size ||
> +           kern_type->size > kern_vtype->size - kern_data_off) {
> +               pr_warn("struct_ops init_kern %s: kernel data member is o=
utside the %u-byte kernel value type\n",
> +                       map->name, kern_vtype->size);
> +               return -EINVAL;
> +       }
>
>         pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u ker=
n_vtype_id:%u\n",
>                  map->name, st_ops->type_id, kern_type_id, kern_vtype_id)=
;
> @@ -1208,29 +1228,50 @@ static int bpf_map__init_kern_struct_ops(struct b=
pf_map *map)
>                 return -ENOMEM;
>
>         data =3D st_ops->data;
> -       kern_data_off =3D kern_data_member->offset / 8;
>         kern_data =3D st_ops->kern_vdata + kern_data_off;
>
>         member =3D btf_members(type);
>         for (i =3D 0; i < btf_vlen(type); i++, member++) {
>                 const struct btf_type *mtype, *kern_mtype;
> -               __u32 mtype_id, kern_mtype_id;
> +               __u32 bit_offset, mtype_id, kern_mtype_id;
>                 void *mdata, *kern_mdata;
>                 struct bpf_program *prog;
>                 __s64 msize, kern_msize;
> +               __u64 maccess_size;
>                 __u32 moff, kern_moff;
>                 __u32 kern_member_idx;
>                 const char *mname;
>
>                 mname =3D btf__name_by_offset(btf, member->name_off);
> -               moff =3D member->offset / 8;
> -               mdata =3D data + moff;
> +               if (btf_member_bitfield_size(type, i)) {
> +                       pr_warn("struct_ops init_kern %s: local bitfield =
%s is not supported\n",
> +                               map->name, mname);
> +                       return -ENOTSUP;
> +               }
> +
>                 msize =3D btf__resolve_size(btf, member->type);
>                 if (msize < 0) {
>                         pr_warn("struct_ops init_kern %s: failed to resol=
ve the size of member %s\n",
>                                 map->name, mname);
>                         return msize;
>                 }
> +               mtype =3D skip_mods_and_typedefs(btf, member->type, &mtyp=
e_id);
> +               maccess_size =3D msize;
> +               if (btf_is_ptr(mtype) && maccess_size < sizeof(prog))
> +                       maccess_size =3D sizeof(prog);
> +               bit_offset =3D btf_member_bit_offset(type, i);
> +               if (bit_offset % 8) {
> +                       pr_warn("struct_ops init_kern %s: member %s has a=
 non-byte-aligned offset\n",
> +                               map->name, mname);
> +                       return -EINVAL;
> +               }
> +               moff =3D bit_offset / 8;
> +               if (moff > type->size || maccess_size > type->size - moff=
) {
> +                       pr_warn("struct_ops init_kern %s: member %s is ou=
tside the %u-byte local struct_ops type\n",
> +                               map->name, mname, type->size);
> +                       return -EINVAL;
> +               }
> +               mdata =3D data + moff;

Sorry for misleading you to add this check. I just realized the issue
flagged by the CI bot can only happen if the BTF is malformed. It
doesn't make sense to be so defensive against malformed BTF if it is
only going to crash the user space. The user space program with root
should only load BTF from a trusted source in the first place.

Can you resend v1 with a clarified commit message? It is a good enough
check for this specific corner case. The v1 selftest also serves as a
negative test verifying that bitfields are rejected.

>
>                 kern_member =3D find_member_by_name(kern_btf, kern_type, =
mname);
>                 if (!kern_member) {
> @@ -1259,17 +1300,33 @@ static int bpf_map__init_kern_struct_ops(struct b=
pf_map *map)
>                 }
>
>                 kern_member_idx =3D kern_member - btf_members(kern_type);
> -               if (btf_member_bitfield_size(type, i) ||
> -                   btf_member_bitfield_size(kern_type, kern_member_idx))=
 {
> -                       pr_warn("struct_ops init_kern %s: bitfield %s is =
not supported\n",
> +               if (btf_member_bitfield_size(kern_type, kern_member_idx))=
 {
> +                       pr_warn("struct_ops init_kern %s: kernel bitfield=
 %s is not supported\n",
>                                 map->name, mname);
>                         return -ENOTSUP;
>                 }
>
> -               kern_moff =3D kern_member->offset / 8;
> +               kern_msize =3D btf__resolve_size(kern_btf, kern_member->t=
ype);
> +               if (kern_msize < 0) {
> +                       pr_warn("struct_ops init_kern %s: failed to resol=
ve the kernel size of member %s\n",
> +                               map->name, mname);
> +                       return kern_msize;
> +               }
> +               bit_offset =3D btf_member_bit_offset(kern_type, kern_memb=
er_idx);
> +               if (bit_offset % 8) {
> +                       pr_warn("struct_ops init_kern %s: kernel member %=
s has a non-byte-aligned offset\n",
> +                               map->name, mname);
> +                       return -EINVAL;
> +               }
> +               kern_moff =3D bit_offset / 8;
> +               if (kern_moff > kern_type->size ||
> +                   (__u64)kern_msize > kern_type->size - kern_moff) {
> +                       pr_warn("struct_ops init_kern %s: kernel member %=
s is outside the %u-byte kernel struct_ops type\n",
> +                               map->name, mname, kern_type->size);
> +                       return -EINVAL;
> +               }
>                 kern_mdata =3D kern_data + kern_moff;
>
> -               mtype =3D skip_mods_and_typedefs(btf, member->type, &mtyp=
e_id);
>                 kern_mtype =3D skip_mods_and_typedefs(kern_btf, kern_memb=
er->type,
>                                                     &kern_mtype_id);
>                 if (BTF_INFO_KIND(mtype->info) !=3D
> @@ -1281,7 +1338,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>                 }
>
>                 if (btf_is_ptr(mtype)) {
> -                       prog =3D *(void **)mdata;
> +                       memcpy(&prog, mdata, sizeof(prog));
>                         /* just like for !kern_member case above, reset d=
eclaratively
>                          * set (at compile time) program's autload to fal=
se,
>                          * if user replaced it with another program or NU=
LL
> @@ -1352,8 +1409,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>                         continue;
>                 }
>
> -               kern_msize =3D btf__resolve_size(kern_btf, kern_mtype_id)=
;
> -               if (kern_msize < 0 || msize !=3D kern_msize) {
> +               if (msize !=3D kern_msize) {
>                         pr_warn("struct_ops init_kern %s: Error in size o=
f member %s: %zd !=3D %zd(kernel)\n",
>                                 map->name, mname, (ssize_t)msize,
>                                 (ssize_t)kern_msize);
> --
> 2.43.0
