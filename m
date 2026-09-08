Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F430BB8D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843492; cv=pass; b=gu5bYqTxETLE5O7qWlwNa618EbisPMyRt7+R8RPdxOzDuFZ3f+hiGjZvHUCqVzu343lB5fGfuWpdeXjAtD7BsZQfi13deVB2LOyNZvM/kQ5HKDV9XUPd3F4TEOjVPv2VtgocRGgoXpSo2u9nI2GucO+0t3bUvBktjI31YeCifHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843492; c=relaxed/simple;
	bh=RgLJezrTBUs5CG3LnOFPDG4AOpylPG1JRVWLEgIQPGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CisqAiFasKzCzGSgKAKw2zNXL6rgDeXKNnLg6uqKhSNX4ikVUcpqJjqF3WV5agxj0z8QzySv81qmMrg2dBavszJq7aAYCzM0cq72I61dFoazKA/txW4z4Nhix8MFfACNW3yvP9708welox65aKHDJcIPSDXuoJ/+t6SD9vWiHCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ja7ANi/Q; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja7ANi/Q"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so422121cf.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 21:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843488; cv=none;
        d=google.com; s=arc-20260327;
        b=QGq9mf7JPfa5sWgj1zK61evFjo6ctJ0Ry/UCzZPqswSyhDg9MV1d5kYnwRHLRkgqyu
         hCPRt4EdosrG6IHbVJ6X+xBMhwXRajPGjfRIGWaZquz031NfQVnpnqRFS9FwllXJpn4+
         gj3MIbKtMytVOVSEnVhefdUPqLFEzKxXA8Dks0wbNVxqmSkPlMrkN3CykGAe+dqSPopj
         s0GJH4smcQ1C7o3LNcirYHOQOhVpc2pE0ECpXZpLt0yfr2SOJqqScT957cNbJjJ0AOBK
         SkmckHlgpquNq+TjGfuM7p0CYIpdgVpAXxiHr9mTCqgSm7gbSfiaxlkuOR2EHEnK0C9I
         I1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72ehCLFMyNfTgkqst2/aW85nSHtZnpsBG16QZCxLCCU=;
        fh=5sohCSigZ9EYRS9gPPqRjv2/ddK+Pp6d5ROSR66umxs=;
        b=UWW9rQCVMqKLee2k8WReJeQtO1dvaaS4hrOpiYFzmdUp69viwhPsYVq+K3H/cycAV4
         fU9Q092chLF7jsO9EzfYbNFTtsgXhGapP6Xgu4ycEEYEdsjdnfl+sWd1K1NWudwvwpqo
         b1IwvZCFBNOTuGbdkLs8C6vgAO4f1qpDDff2QpBqvo1nF17lylzeQmVx62o2VKVWalOk
         VBn9O7ZGiUVmm482NmpiJfa0qbyoQ6Agim+/VnHLqtl/T94nfBicXRZ55oZLQ0mxvocE
         5WpBTtXc1lwtTssSKTr2D2vLle3dGd7RxgfwYvnRze/8L94OKVwQgUGddiAt+qnHZm3w
         3Wvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788843488; x=1789448288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=72ehCLFMyNfTgkqst2/aW85nSHtZnpsBG16QZCxLCCU=;
        b=Ja7ANi/QfO8JQ96r+R+Te0+n1ZblgTrtam3QeDRQoc2mlfZbO2qw12qyvq1k+NhzeA
         VtZfNwia0lgLaQkMAEmhFYbMwLyZgTuYOA02zenVz9kU6nWbdso93EN3fqzu7qdkiOh8
         D6Vn/53mMVxM9CKzLq5qgylWFhJTkvbAfi2G6J6q7o6ussrF8lEDwGDdpSTCi0E1QyjK
         LYr3JxJtllVst9y+QSuRqmfDofJWZjIIXYXJliIPpkZBQ3b6kUw8R1Qg/JVLxh5Rn7MK
         zq9c1ijWZQxC417heZG/OC4Y+vBP4JGZpAyETOuJcIOAc3QyIPTNPYe/9Oiu+FOgBf6b
         WTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843488; x=1789448288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72ehCLFMyNfTgkqst2/aW85nSHtZnpsBG16QZCxLCCU=;
        b=Rd836AbeovyR0WfUBiziz21JS1HFrsfhO5yWPs2C9vMiBWku2fEjxyBnWRm5IOnkZP
         2qikEH9Nhvu6jo6Dsh/a9BiyrnjHv1iM2vqAT4T7q9FODjH7AADbjPN0upQ5CNG0qobM
         KpAwaWZKb99SZoVFyhSbQ6oXQIn/L/HMwKVrRA4x7sNigOtMVT6B+HfdrQXmJLYAvIdz
         J1dnHzQq2qlKhouvmCe+pFK1w8hxRcDeex1LwyPJEjuzQBQCWQE2/WFYXNk/bF8DOOJA
         CrFQasefB6Wz62usc4cgWZIZN4u8dEbL01xMu0JatFDdvIlYo1A/dKp4OYtlBiOWD774
         4rJg==
X-Forwarded-Encrypted: i=1; AKwUvBwmnz/wpLF1Fnb9+CO2BdaBVwzhMFc7grlNNeyWZ7PPac842+j+T7wIrqpTtEVO97Ryfg8=@vger.kernel.org
X-Gm-Message-State: AFuF++mfABzDAPSHNtRRUi4DI2HRVxEJ/HLx0r1CrI8PTcB0S2xf7hac
	9FMVwYgZ+MfjClT2QnwI4zWxH/oxOkspYYxe2qK8LlXlinwIJTy/lml0rJmq1w+1su5iXAmhcEC
	rRK5CIUHbWA6SE+ZUbz2jlwfS1bnOMGLIdww5WJ3E
X-Gm-Gg: AYBFou2rqpgiGIvz6MV9L2LvUK5lf6Kf9v5kWymvz7vUGziXx/LxpF8rY/NCjfXxdvv
	rhqh/A0Czn/PYeN2XoYohVjliOaD5I4jBsnKaapa9lzRdNTEQzkQJsgt0bB000cNV4y6daBKMch
	VgDeMBm6FKL8LO957V1Dgo96fsrxMk6gn2usZ+kBwaYe+a6co5eV7zh7+FsCnTWTKWSnMYzdNx6
	lVjAhYanPMtj8KO3cEzTr3lNQt+U5vXhqYO97wfvcweOlhPyjKQK3kqBdnH3N1SFHzbirRtBwqj
	zG0mTOT7bFAtsIKjFXVM6/1QYDorT6715ms6ajVrKdFZWQbQeG/gBmFJTpIeA7KAYiaS840oXg1
	8EL53yvkNIkHS+GaK5yhQpuSyAJ6NSE+/6BJLqDM=
X-Received: by 2002:a05:622a:2b0b:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-53082b07b6dmr24762111cf.9.1788843488057; Mon, 07 Sep 2026
 21:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904031912.2133476-1-tweek@google.com> <20260904031912.2133476-2-tweek@google.com>
 <4468d220-9d7f-47d0-8e5c-c01070ab2d47@kernel.org>
In-Reply-To: <4468d220-9d7f-47d0-8e5c-c01070ab2d47@kernel.org>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 8 Sep 2026 14:57:50 +1000
X-Gm-Features: AcwNN1Vv3IgsdJ48TcwQ9T2zgBF6SbU0dMzFnoZRARrkmuhvOX0r_mwDFwUWnFQ
Message-ID: <CA+zpnLdPu+os2SFU1UxR9ha0NqYwO52Hr9ogk2zaEUHLLcv1XQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Reject non-autoload programs for
 light skeletons
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:24=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> On 04/09/2026 04:19, Thi=C3=A9baud Weksteen wrote:
> > When generating a light skeleton (bpftool gen skeleton -L), there is no
> > libbpf runtime object or bpf_program__set_autoload() API available to
> > enable/disable the autoloading of programs. If a BPF program in the
> > object has autoload disabled (e.g. via SEC("?...")), bpf_object__load()
> > silently skips loading it. bpftool still generates struct bpf_prog_desc
> > fields and attach functions in the light skeleton header, leaving
> > skel->progs.<name>.prog_fd uninitialized (0).
> >
> > Explicitly reject non-autoloaded programs when use_loader is true with
> > an error message, preventing the generation of broken light skeleton
> > headers.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  tools/bpf/bpftool/gen.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index a50540ef6521..1583150241c8 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1340,6 +1340,12 @@ static int do_skeleton(int argc, char **argv)
> >       }
> >       bpf_object__for_each_program(prog, obj) {
> >               prog_cnt++;
> > +
> > +             if (use_loader && !bpf_program__autoload(prog)) {
> > +                     p_err("program '%s' is marked as non-autoload, wh=
ich is not supported for light skeletons",
> > +                           bpf_program__name(prog));
> > +                     return -1;
>
>
> Sashiko is correct, at this stage of the function, rather than returning
> directly, you'd need to "goto out".

Thanks for the review. I agree, I'm not sure how I missed that one.

>
>
> > +             }
>
>
> Thank you. Maybe consider adding a word about autoload/non-autoload in
> "bpftool gen" man page? My concern is that users who are not familiar
> with the notion will struggle to understand the error message.

Ack. I'll send a new patch to skip over these programs instead, as
suggested by Leon in the other patch ("selftests/bpf: Move verifier
failure tests out of test_global_percpu_data"). Thanks.
