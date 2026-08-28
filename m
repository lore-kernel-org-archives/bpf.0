Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07598175A5
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875490; cv=pass; b=NuahMqRmj1zvP6bsKF8sjyt4PERZXSX2WtIgCxctRS0hqj7Ie5taRNgv8rVaCK4IXWBkFzuRsmoEzXYtdULnGdddmXpNGBZrSeSa99TtsRgiXqYeSIFonzCCGGGuxU4wSFkRGpK73181AMH7kzLCubOxLSG6cjLd7UfDODNqsNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875490; c=relaxed/simple;
	bh=bzipX67fJ84DTdoVwOKdz7Hr0iHuQvnEtW+0XQAHVjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECL66Ge/k9xXaEELe9vHGvni4FJarcggBt3IukQVfgQtiV7VNHRYX3TRMwS1FNprn8FcwP7PFFR50gW93uv8DbP1u+hj0nFq3ngiJSQFdt7Fl5y6uK+WwxqArAj/r2K/HXM/sBJYaRnIUncgdzMl1ZwtHzm0kdHxjHdkNW50yb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k03SBE/E; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k03SBE/E"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so256661a12.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787875488; cv=none;
        d=google.com; s=arc-20260327;
        b=CTtEOxH6i8B/OYhzRvcg/NQZCF1sYMrYKAdX/bAY50hOCGvxap7ycvULTAsjK+WC/F
         qzkZd6dAEpxnmcPNPhnYMZ6frtdpQhd/p4pJgqfOAqApJUmlQtMjvsadq3IfIkrwWUoB
         tnILJAVfE67EvVgc758zUhQ71c/xTH1BiFWSDS0F1nAA6YJ5fD4ypVXApGs8p14LDw3W
         TAWjo3Ea/KBA5Yqy933L6iUS8FRq9NrAc/sAzZtf5S+lj5wjzwOPgU0leRk5ewdLc9a+
         u5msulgTIzNBqsDPWjKsh88N00gFb8bOnlNKnWJ183P7VTxqR7ybCOOx7v+cQKEFgjkb
         FY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X71AR5dmuuWsD42arTP/PSRuVVtqP6VTIfpXyq7Omq4=;
        fh=ZWcdOu/+/k5/Up2ZDSXaUrpCDd0vT3q7tWFuSOd0ZRY=;
        b=LpykwUGA+F/kUveUKEufQJEy61+7HXpWWHEnKYNNZSih1fekwSxogUU7e0qokdLu3r
         +dM2uPhxWlXn5TVUOuLP9yZE7HdLpbQNHbN+lg17Bw/iBFm/KfB7sR+122teHLXal6KI
         fOobtYPQ7S2b8aV+YR+WI+9zwvEB/8zpEVY5R2tS0tXFvKvptFDXs49S2l0kAxoam1LS
         8QSx8LCrHpBVFqqYjlIfIhhnBsWwlNvrcVoihrwE6fTl8YRSrb/z5Bct4KXIxC2ltdr6
         mrZCyE1uKqt/eYzMXcjWKj5ETB5QRQhgmniwBvgosZ/93SPRGUBkT43U4sXNOZv5535A
         IQTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787875488; x=1788480288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X71AR5dmuuWsD42arTP/PSRuVVtqP6VTIfpXyq7Omq4=;
        b=k03SBE/EEcpNFJgQ0kGKZFN5NMYi/hAY33DB2W0uc64B/feaVjCdiOjebED9vUyklV
         J369s/ITyPyhfn3/Pfy5gML/7FhZwiep4U3laCYsGqbyVD6f8fG1POYLRDOj6NzqWUJV
         oFId+ftiLS2gJT1vl/HBycnFrdCQUG8YOpLNXw/gcr7HOsNOP6rimMRoI1Ihpe8502lS
         gr7+9YXikfFxsL9gLq1zqhBN+1Qk6PAjVvEaghdm1rXzDvh72thgHUuZneVAPJH1ZuIT
         AWbv5CCz0zN8EgqHpWp7qqIZtzAMFS6SFwgnPiMs6vKVrQ4xcupTRosAJxuhFfWg/Y/T
         qF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787875488; x=1788480288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X71AR5dmuuWsD42arTP/PSRuVVtqP6VTIfpXyq7Omq4=;
        b=Pgqca51qq7md+iBBgr4yzuLQg+qChj3Fn+qgJTvDVBwQuEQksWarkvqj6zZDh0VAeJ
         urXZyLWEnbvSemqwPTq7A/tfnoMWLdnNW3xHP2g3+wsrwyKqw8PrycmpaXJ7Aj/QKuVG
         Y0k6fWXUJpTxGg8Tz+27KbKjJ7f6csg+ng5cS34FZ/ezLzHfg1vpyecKiCc2oUbjO1it
         guonrQ1nslFNtuQ0sTstbMp2PA4RvhxEFhkeQ6pshwfGVoEaElrSBWIz/t+QTOPCFvN5
         kAMGZ/W2xSVnqMijLUiywM2yKbKKdqS/Nn/pDh9kyDxSaXaDxkw2tv6LPZSN1fBbM3r+
         hySg==
X-Gm-Message-State: AFuF++le11+vEczmN70KaDe4fHLKiML8zoyRAuqDAhfi9Btf2WY3O363
	616g7bTLn0YFwXbYX8/vs/iEbvgeXod0XC+mB507Fessb5mnSO2LATArp7kIxgNiHkEyTd0Hg7H
	wg0xfifwvKfs5lxxqhBIE1SsoHktTS5M=
X-Gm-Gg: AR+sD12z2LPCcwvfaXxpRxSV+bEFWYLRFpzVZKDwtagJ9fD7txVS5jjT5Q1tyGO96j9
	22ypnYasKzzWgYvxiWRK2dzD6vl/Stt+6FkVu8jNpbCq3FFNS8yuY5t0htTHk3ex8it6QIrRwc5
	f3Y+yb/TeDvzVK7TcJISb7xFfA1g2K7uQ+E8V7LKRpJ57wIoXbRVVw8dccz1rljFt6PWNWt4af6
	oBnyMupmAEaesKCGfZn0a2509wN/8Ai6DHtlXCyk9ii1GV5Ev7SzJaX4ArFk3ORLM16EoVi7Mwm
	cHVVkv61XJAZUtFwnWYbfYZ+dEgTs/zqdDILWiX+vvVsvRqychJ+3vMQfhJahYzfEJ46d5OtrkX
	Hq+bEGpF0wD88RzrJmT16OknhZAE=
X-Received: by 2002:a05:6a21:6e88:b0:3c4:46ca:334b with SMTP id
 adf61e73a8af0-3d267b60e7emr5691463637.9.1787875488249; Thu, 27 Aug 2026
 17:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com> <20260824083327.1708560-3-chenyuan_fl@163.com>
In-Reply-To: <20260824083327.1708560-3-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:04:34 -0700
X-Gm-Features: AcwNN1UHlr9qM8-A_KgPclu9Bjrf2-uNKr01amYnw76kWGXvr0QthSKmn2BEdEI
Message-ID: <CAEf4Bzbu6gktFDc+zJHrEmGE3dXoMGHCFsXZpsfg5ZhGcgZLrA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for
 queue/stack map size limit
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:34=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Verify that queue/stack maps whose element storage would overflow the
> u32 head/tail index multiplication are rejected at creation time, and
> that max_entries =3D=3D U32_MAX (which would wrap the u32 capacity counte=
r
> to 0) is rejected as well.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
> v4: check the bpf_map_create() return value directly instead of errno
>     as suggested by Andrii Nakryiko
>
>  .../selftests/bpf/prog_tests/queue_stack_map.c     | 37 ++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..efe808eedd9a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -2,6 +2,8 @@
>  #include <test_progs.h>
>  #include <network_helpers.h>
>
> +#define U32_MAX ((u32)UINT_MAX)
> +
>  enum {
>         QUEUE,
>         STACK,
> @@ -101,8 +103,43 @@ static void test_queue_stack_map_by_type(int type)
>         bpf_object__close(obj);
>  }
>
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +       LIBBPF_OPTS(bpf_map_create_opts, opts);

this is not used for anything useful, drop it and pass NULL for opts

> +       const __u32 big_value =3D 1 << 20; /* 1MB */

inline 1000000 in 2 places

> +       int fd;
> +
> +       /*
> +        * Regression test for the u32 index overflow in queue/stack maps=
:
> +        * a map whose element storage (max_entries * value_size) exceeds
> +        * U32_MAX bytes must be rejected at creation time, otherwise the
> +        * u32 head/tail index multiplication wraps and push/peek/pop
> +        * address the wrong element. 8192 * 1MB =3D 8GB > U32_MAX.
> +        */

drop this verbosity, this doesn't deserve more than one line comment, if at=
 all

> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 819=
2, &opts);
> +       ASSERT_EQ(fd, -E2BIG, "queue_oversize");

leaking fd, if test fails, not a big deal (as per me), but we'll be
pestered by follow up AI-generated fixes, so let's close fd if we got
a valid FD

pw-bot: cr

> +
> +       /*
> +        * max_entries =3D=3D U32_MAX would make the u32 capacity counter
> +        * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +        * map, so it must be rejected as well.
> +        */

same, drop

> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &o=
pts);
> +       ASSERT_EQ(fd, -E2BIG, "queue_u32max");
> +
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 819=
2, &opts);
> +       ASSERT_EQ(fd, -E2BIG, "stack_oversize");
> +
> +       /* A normal-sized map must still be created successfully. */
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts=
);
> +       ASSERT_GE(fd, 0, "queue_normal");
> +       if (fd >=3D 0)
> +               close(fd);
> +}
> +
>  void test_queue_stack_map(void)
>  {
>         test_queue_stack_map_by_type(QUEUE);
>         test_queue_stack_map_by_type(STACK);
> +       test_queue_stack_map_alloc_check();
>  }
> --
> 2.43.0
>
