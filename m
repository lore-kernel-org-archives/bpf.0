Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D659763EA
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449964; cv=none; b=LhQ8nt5Ifz/+yDFoes0KnDAPgAfmfHc+oji/7gYLfQoXA4FOl1qjxvxDfkfz63yp9vgerbEXrPukbfV9JDq686OlxahlulssX8SNgjZofg6iGRl2c7cqg1cmwsdcElw3fvR/3m+tJnchvc2cbUFZqxfdvhE48SgwyGCeLh81V3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449964; c=relaxed/simple;
	bh=O8WIHTGHVyJ0G5L+wHJ0KkAEBikFULZvUAiheIJbUIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEtbJOk2r2sYkTQDbutKqqSViN6SQkGaaJBOUHH4N060ePF7sUG9Ff7z4gpkpwB50yDOeh7+AFjFR761ynDhJmv/sMTu3AkyMhnQwodxCvoJbMkSEN4/bIUE/XkUretRJ3nEaPt2zYIKcgm1gFzB5zwo7dF11MfvJhTW5mDvrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNjVoWPt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNjVoWPt"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso973362a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710449963; x=1711054763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UnDk7Lj+LRDoh9gP3rGxpytkvD8lKen1v5LMpKEHyw=;
        b=QNjVoWPtjN7jUERT54a4Wu2yiKfE0IDSN3XCvDXYm6Td4qU57dkNT653Sh0qk6ltNp
         VZscOBpLW8ck8LAz0sBDh6ndGHylyOFj3/wM29natfGfAEwMSi6RXWzuKxjNCUAnlcN/
         CdEAZXLr39Jsx7V9pmMBKoOa/vyXu0UN1rDuob/7w7SM3hYkUWZIDeuW7RBx3jCTWReP
         l9hfFYvSZBc7+6pan/gDvUdYjchbvl2R/p00k2NCiCeV2xSWLAFfXqpC943gmekWWuTz
         PMgENuZJLcvXKYoDRl27HJiJF6DxYD9Ui3CBdlNQ1m2QQsEFBoVR3llT3fb5z3VefkNZ
         ZFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449963; x=1711054763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UnDk7Lj+LRDoh9gP3rGxpytkvD8lKen1v5LMpKEHyw=;
        b=DID9Vz0UMsN3FZDUFJgnnJGPYCXUrpTgQkhzVmAyjB0a8VAT2dWUXZ2WFHS2W+0Dtv
         Bq97OnM580OU4Ow+sFj9K0uU7ZDifxywvL2HFP8JFlFl80D5ACen5+bdItC9ROIh8jRD
         u/Wg3Q0SvAprCPxfX0xhVMtaM9knkMc0JyR43MhS21xGfa40RLFVx42dxzI7NneVllBZ
         F7yp0peKRm/NQV0w0Sll1LmFt2l9NYQ/xGfoBKj2J/vYfmhlnKTkFejYx9DoAfKwDUYE
         zwUB3YbQrWRQqh2VMWTtdPBPIzwObBloXVGNB1iPeMthcN+qyA58x7lbH97kdbbjnH2U
         GfHg==
X-Gm-Message-State: AOJu0YwuAwsE18vQZbuxgr6s+UZaOsb5r0hcYgl+/8gJFo5BMQ7dYc9Z
	gdOtcc/L8Mu+9fpmhljhA6sSvM39nIb0ZN0nHrON4wNkzx59+22mxrl4tPBq7+zwBJYX91Jvy0V
	oLlwIx7rCHXjgUX6LDhtiN0KoXQJX+kyk6Ic=
X-Google-Smtp-Source: AGHT+IGRA+cFsHepiW7KWsGzugZzXZSGEhcJASIB4xQeuhmp3oGAxevos8mAjQ/79gVhhhB4h7qUuPk6Fw+qOa0yRrs=
X-Received: by 2002:a17:90a:6bc5:b0:29c:762a:3fde with SMTP id
 w63-20020a17090a6bc500b0029c762a3fdemr3007626pjj.14.1710449962672; Thu, 14
 Mar 2024 13:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313214139.685112-1-thinker.li@gmail.com>
In-Reply-To: <20240313214139.685112-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 13:59:10 -0700
Message-ID: <CAEf4BzYXe8xbB5BH97ggYzokdFjqAv5Zuz_MRV9fyzCt+yJJvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] Ignore additional fields in the
 struct_ops maps in an updated version.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:41=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> According to an offline discussion, it would be beneficial to
> implement a backward-compatible method for struct_ops types with
> additional fields that are not present in older kernels.
>
> This patchset accepts additional fields of a struct_ops map with all
> zero values even if these fields are not in the corresponding type in
> the kernel. This provides a way to be backward compatible. User space
> programs can use the same map on a machine running an old kernel by
> clearing fields that do not exist in the kernel.
>
> For example, in a test case, it adds an additional field "zeroed" that
> doesn't exist in struct bpf_testmod_ops of the kernel.
>
>     struct bpf_testmod_ops___zeroed {
>         int (*test_1)(void);
>         void (*test_2)(int a, int b);
>         int (*test_maybe_null)(int dummy, struct task_struct *task);
>         int zeroed;
>     };
>
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
>         .test_1 =3D (void *)test_1,
>         .test_2 =3D (void *)test_2_v2,
>     };
>
> Here, it doesn't assign a value to "zeroed" of testmod_zeroed, and by
> default the value of this field will be zero. So, the map will be
> accepted by libbpf, but libbpf will skip the "zeroed" field. However,
> if the "zeroed" field is assigned to any value other than "0", libbpf
> will reject to load this map.
>
> ---
> Changes from v1:
>
>  - Fix the issue about function pointer fields.
>
>  - Change a warning message, and add an info message for skipping
>    fields.
>
>  - Add a small demo of additional arguments that are not in the
>    function pointer prototype in the kernel.
>
> v1: https://lore.kernel.org/all/20240312183245.341141-1-thinker.li@gmail.=
com/
>
> Kui-Feng Lee (3):
>   libbpf: Skip zeroed or null fields if not found in the kernel type.
>   selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
>   selftests/bpf: Accept extra arguments if they are not used.

I applied the first two patches and dropped the third one, as I don't
think it's actually testing any new condition. What I actually had in
mind is more along the following lines:

$ git diff
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.=
c
b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 098776d00ab4..9585504ce6b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -103,6 +103,8 @@ static void test_struct_ops_not_zeroed(void)
        if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
                return;

+       skel->struct_ops.testmod_fn_proto->test_2 =3D skel->progs.test_2;
+
        err =3D struct_ops_module__load(skel);
        ASSERT_OK(err, "struct_ops_module_load");

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c
b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 86e1e50c5531..d3e0f941c16c 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -68,3 +68,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
        .test_1 =3D (void *)test_1,
        .test_2 =3D (void *)test_2_v2,
 };
+
+struct bpf_testmod_ops___diff_fn_proto {
+       /* differs from expected void (*test_2)(int a, int b) */
+       void (*test_2)(int a);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___zeroed testmod_fn_proto =3D {
+       .test_2 =3D (void *)test_2_v2,
+};


see how bpf_testmod_ops___diff_fn_proto defines test_2 callback with
an incompatible signature, but at runtime we are switching the program
to the one that the kernel actually expects. This is the scenario
(incompatible struct ops type definition) that I wanted to test and
make sure it works.

I quickly checked that it does work because libbpf doesn't enforce any
type signature (which is both good and bad, but it is what it is). It
would still be nice to have a selftest added with an incompatible
struct_ops type which is "fixed up" by setting thhe correct program
instance. Consider for a follow up.


>
>  tools/lib/bpf/libbpf.c                        |  24 +++-
>  .../bpf/prog_tests/test_struct_ops_module.c   | 103 ++++++++++++++++++
>  .../bpf/progs/struct_ops_extra_arg.c          |  49 +++++++++
>  .../selftests/bpf/progs/struct_ops_module.c   |  16 ++-
>  4 files changed, 186 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extra_ar=
g.c
>
> --
> 2.34.1
>
