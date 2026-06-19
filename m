Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B281E4AF
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844653; cv=pass; b=DO93n5YfvULdogY8nEIDCjyhJ+N5erpi0fK5/4/bhAzZdJspofMbqM/Wi/PtFd2oeV8he96MZEdPh70jTCEboxSCf+J3r63yTS1BF/4vpon4ZNlpoKfzARUggja9vKS2fTXL602DMCkQ/v48awwplYMrBwu7BHew6/gG4+msmpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844653; c=relaxed/simple;
	bh=hB9u4DRdQqn052bt6peJU7HSp23Mv+TCxzIKFIk6juA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOUYlDw/l9mht/IOq2nGEfSRH58vWZQvc4Ls8uPmlRUatNZx6Mt+Uy7VdAHA82W3OvHp38yaLBFcvbYhOFlkRKOwWYXYpI3SkJpXjaUp61UkAeYhSpNWAPuoGhDGpA6Va3O77z55DNKtGNX9IAR2E4AXrwZyKIh7mI6t6w+rOBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQlIlatx; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQlIlatx"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66077e90382so1814171d50.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 21:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781844650; cv=none;
        d=google.com; s=arc-20240605;
        b=jpo4nQKzKlzsbtcDs4UoDtbaLyh1qx3wuv/FGdOAKaJgG2XWWYYwvTD3PfvwyOtRhG
         tVCrYE15QTW5vWz8mXRTCdsYSQwSLaQeGMLasdEAkc0NAGFnss52q+aZij4OfYejw9N1
         V3EmKTfXI5Y4nsCYj73DFq68W+zlCw0aZ/v9dJ/AsTp2wEv6Wpmr52kAOtzJ0yxzxvMU
         128tBgKr6MDWcTnhu8gzkxmLWT47Gf2pKKXK/LsToDuI0VDdmvFmiI7JJKSR+RABQZ9V
         tOGW/sOD8u3atSuf5wJCN1qm0hBhmM95+UYxCCKUgT9Vtg7grTTtolh0IYdWCG5BWTil
         WiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d+k3Ml8dy+ZiyZRYJ1dHv36rs8wSqODj2cIfkPfKU5U=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Pwxb2cA0neapKyPGi2g34QgzUNG5mddvPqiiTCLDtpq/jp1d6Hjw5vPYNBknXKPwSr
         u3pKbIy6gSfiUfQ2pEzWRzkwy9+f5w0JsRjs4UZYrYvpva3hwUZ8x6fFi8r39R5lZGpZ
         GmKrzIn2AwAZ68zTH383n5T4I0iWAvS5tHf5YVtkgsWfWBN5wWNbk8cEIBOudD/NqwKq
         oxPdP0CMvH5ctXzP/i4BFOYNqjF6CWeUnOc0jgxNtRrxRjk+FYz3QUNn7rLd1NUdODdP
         6uWTSlYDQF5D451GFjqiEi8RFYXe1bJA+GHEdSQ5lTcX8VReD2smqu6/EZ6ljkf0x/ZE
         PxAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844650; x=1782449450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+k3Ml8dy+ZiyZRYJ1dHv36rs8wSqODj2cIfkPfKU5U=;
        b=lQlIlatxS11OHq4CIQx9n1pNqKxcZvwXedlI9gKoR3B2GYZMaTEJwcbUGH5h8DM/Mi
         nkixPTQVQHuK01Ebj706Oqnf0ZMoTLCvlq79wC/wCqgiiKzPKXEVqZGFqgHb5X4omt/T
         I/WXpeT33QeGUgVlVZyt0lGdjOjHjaavKLChCjUnyaYYwQ1aExFkZOIUzjsxxV5MAKRp
         79rhaRqm5MsmhTXEGo271oM8V+BWrRlFT3figkVwCIrIi5A/00iyekkmUBeAztivUrMO
         cwT4mjGsoGbTqZOUKpTIQJQF0p6HaP137wXfFgs1j+Xd7k10DUT38L6Qna6QcXiQocxX
         vOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844650; x=1782449450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+k3Ml8dy+ZiyZRYJ1dHv36rs8wSqODj2cIfkPfKU5U=;
        b=mUJwMwy5ZrfctWyhgM8xzXvtrVfpbZ12bZz4aWFT6U2e6yAN0a3HT7V3SLZEv1torO
         kP3y/ap5VKRhe3QwcdEtFDaThld7QtvZuThbmxudN4Lyf6cu+KUtsfFYvckcKOfair70
         Nzt69j2LbgMXyh3YVbMkzbGvN5ma4Ug8zbZMPdGCJt28InXSRKV2coK5tk10/g+Tztj7
         Nn2ed79Rv4V9U6Ee5thAA14npDNVRVW72uv4nIhrxFcVmz5HXzQ7v+a6Uku84wGGZjt8
         lDFx4zVGVCBQpXFXYC13FfQQDwp9HBQdIEeU69yRwyHA2uQGRfUP2aQfQk0E/6EZPhIb
         F4sQ==
X-Gm-Message-State: AOJu0Yx9VOsast1axXvyrYNzknB3SEVCaZ6Zm3ztZ3Qs8bnFY++RCNUi
	VTjs4IEHNIbSO/QM+LefMtVgwwpjxA6ckuVXhYKDbsKi2mfPpQRiuKhAWh3qR8kwMCvPG9mC6cw
	KKTrWSv9GsCZA1/kEdTycpRGKjjI+qjbuKQ==
X-Gm-Gg: AfdE7clfO2Q99quOQ1reXvlslzoOmdK71qaCwkluMOCVFy1D41eezOPUSLDq3haQ4RJ
	DIoVxfFGWw+dKTT9lU4NrHrOeDJ/qZ9vUbdhUrx3j5xEQvywK3E0w0bxPX3IAm1hQeOJtcoAOd9
	S5CN4lWjBgnS8jT65fByUHC1VCPZRv+Fzvxs6aRforHtExZ774yUH6VwpNR97Ck24S+yIKINcTQ
	5PlRWgOGqRVMX4/GFBHjZVtgikYTGKyhpZVZjHvvqgaB/f1ft9ie20IgutdSanBRDM0Uuyq
X-Received: by 2002:a05:690e:439a:b0:662:d8cc:6b2e with SMTP id
 956f58d0204a3-662fc7b38f5mr1923340d50.13.1781844650545; Thu, 18 Jun 2026
 21:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618221919.2919512-1-ameryhung@gmail.com> <20260618221919.2919512-2-ameryhung@gmail.com>
 <20260618222630.755041F000E9@smtp.kernel.org>
In-Reply-To: <20260618222630.755041F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Jun 2026 21:50:39 -0700
X-Gm-Features: AVVi8CerEGxHtpg1VD1XQFUvmiV4L4zG6EXOJKqow8re4F7R7uFQtG0K1PS22Ss
Message-ID: <CAMB2axNic+A2QzV8e7B6o9frcMm50nq1QDzU+ME_FnuBvGdy=w@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test cgroup link replace with BPF_F_PREORDER
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing error code propagation on `bpf_link_create` failures c=
auses the test function to incorrectly return success.
> --
>
> commit 5273c7a6df31aa862a2601f91f12e4d696020f49
> Author: Amery Hung <ameryhung@gmail.com>
>
> selftests/bpf: Test cgroup link replace with BPF_F_PREORDER
>
> This commit adds a cgroup_preorder test case that attaches both a normal
> and a BPF_F_PREORDER program to a cgroup. It then replaces the normal
> link's program via bpf_link_update() to verify the effective order change=
s
> correctly without array corruption.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
> > index d4d583872fa26..80a17203c4fd5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
>
> [ ... ]
>
> > @@ -102,6 +102,75 @@ static int run_getsockopt_test(int cg_parent, int =
cg_child, int sock_fd, bool al
> > +static int run_link_replace_test(int cgroup_fd, int sock_fd)
> > +{
> > +     LIBBPF_OPTS(bpf_link_create_opts, create_opts);
> > +     struct cgroup_preorder *skel =3D NULL;
> > +     int normal_link =3D -1, preorder_link =3D -1;
> > +     int atype, err =3D 0;
> > +     __u8 *result, buf =3D 0x00;
> > +     socklen_t optlen =3D 1;
> > +
> > +     skel =3D cgroup_preorder__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "cgroup_preorder__open_and_load"))
> > +             return -1;
> > +
> > +     err =3D setsockopt(sock_fd, SOL_IP, IP_TOS, &buf, 1);
> > +     if (!ASSERT_OK(err, "setsockopt"))
> > +             goto close_skel;
> > +
> > +     atype =3D bpf_program__expected_attach_type(skel->progs.child);
> > +
> > +     create_opts.flags =3D 0;
> > +     normal_link =3D bpf_link_create(bpf_program__fd(skel->progs.child=
),
> > +                                   cgroup_fd, atype, &create_opts);
> > +     if (!ASSERT_GE(normal_link, 0, "create_normal_link"))
> > +             goto close_skel;
>
> [Severity: Medium]
> Will run_link_replace_test() incorrectly return success if this first
> bpf_link_create() fails?
>
> The err variable is 0 here from the previously successful setsockopt() ca=
ll.
> If normal_link fails, we jump to close_skel and return err, causing the
> caller's ASSERT_OK() check to see a successful test run despite the failu=
re.
>
> > +
> > +     create_opts.flags =3D BPF_F_PREORDER;
> > +     preorder_link =3D bpf_link_create(bpf_program__fd(skel->progs.chi=
ld_2),
> > +                                     cgroup_fd, atype, &create_opts);
> > +     if (!ASSERT_GE(preorder_link, 0, "create_preorder_link"))
> > +             goto close_links;
>
> [Severity: Medium]
> Similarly, should err be set to a negative value before jumping to
> close_links if this second bpf_link_create() fails?

Right. Both error propagation are missing. Will fix.

>
> > +
> > +     result =3D skel->bss->result;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618221919.29=
19512-1-ameryhung@gmail.com?part=3D2
