Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289249738E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558493; cv=pass; b=F7jikxPOW+XzC9+qgtmDF9cQzxv7AMAt2/Z2ZkSWrtQA9k2YeFqsty/VPw8+sA3Db5cusMhAny3ZdbJbBCCFbFoug/F39VQpjQeiolx0TD7K3mMASTyDK6nGZnITt30Dd8N+sBoFz2g73r9AVewxWtEgdbzFayZBR5KpBzolEtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558493; c=relaxed/simple;
	bh=8lQEuf+S9Yr+praW+GOTCf9ZwY8pq+0gPcT80hqP2nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axVIM+IvAJ0nDEBhrQqtAtScWs7IVcvHxrGumuwWcdP13VJTopTubCJIOmu3LTMpfWAEr7Vbc898nVpNHnkgtq0wlXk3/nHVVihKXvkR7qQHjg8ktvbU8qDNRr2l0piARJ+wE+xSmNjjTMRCHF0YpwTdoV1muA2gaXpTsrIaOc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WcVFVPI1; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcVFVPI1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a18617ae90so68715e9.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 08:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791558484; cv=none;
        d=google.com; s=arc-20260327;
        b=r2UPd1BTimBAj02UA+KG5GCBsAibXgCSejwaSU1LP12VPe1nQnqdUftUeKLlww3ohO
         KP7Xs8skeN+aWfSEululUJAibk5AvwOLXMcO1RG4a++ZUqKGEOrXFTLEmjR+d3uDZsuU
         pcrUsPE/QR5Qxlgb327zEbkrRZkTyGaDI15T7lspWKdFNORPuA6XOkXytOUnnpBLpTYH
         yPqFP/hNf1GqqIH8+KxA6OPJ+cdw8Orxg4vEdVQH3sSMvtze0Z+Q/H7CKOmxaeEHsPqQ
         R/NCMO5XtoyHYnFL2/358rkZImS+EgN96PNXpqrWkTEazS9iiUYgwG5uaiD6zuwarvYr
         oY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5B9NDWTDoWCGkjiGw08sTP7KBdaeckYZ1pF6N1eVNno=;
        fh=q/J9MbydCPq1P3U/GKUDYV8k7y1d+ZLv939l/BFcn/g=;
        b=UBlQg1wFYFVMYI2c9sugzbjHXvMsEpP5VhmirMUgqZs/2C4OR1NvIBhphMwCowP8hw
         7b0wRQBeTJ6kUupL/lSMeB7YpGXDdoO8F+1lgPA8gUn5IC/NjxCnR5kPWIwLg3F0JGc+
         gWFT+PaZpG+/WrZAGQWnD7r6W0QgnUVhXPrr2988G0d3fNsjCSEyy2Gs4ulc7rYXSKO/
         MIB1GD19NHaGo8xiPyr53/3diFZdH+7wQywyy7oKNn3qNg83NISw15LOeMvSssQ1/VPg
         r1uUW62O8jUDrw0uYf+VWy59FCVasgnVBtWxeQWy1d/18CM3RrruUvRaanvUPQfrVpe0
         k75A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791558484; x=1792163284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5B9NDWTDoWCGkjiGw08sTP7KBdaeckYZ1pF6N1eVNno=;
        b=WcVFVPI1Ayshs9wj3KuSa/05azM4soITeqpu/5ZCCcPHlky5DDySK1zQvvzUzKpgY0
         MsLzeqyB7RIzslmgI1QrGNDlLSePCIN7rDLkjF8TweFE2dxFGjWnHUxzOSRvAhKrVNZ8
         C37gRjS/h6b5u6elJ+TNdiGBC/CIlKqdiTjZWLPlN9WojoLRHucwSIyezgz71rQUbMIq
         vWB83RZDQRewI1AQAyt1TK4CJmdpkdBV2383nePv89DVxVJOfiyi0p7au9hgUc/7M9r4
         fiy5AThWArosba9zL2plML5WYrhWiyq/kz2qo+GYzau9TV07FEV8fslLxjJrwAgIO6MF
         aXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558484; x=1792163284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5B9NDWTDoWCGkjiGw08sTP7KBdaeckYZ1pF6N1eVNno=;
        b=UHitjaLKsZm6tpqQ3ebPq9Rtfr53ZstvXjfB5evvN81WJFb++uMudSWeyBhZpKE4x7
         IMXSzA4amkVuA3rrJiZyLSaJ4IB9A3GoO2NcQFPXLz34JZpnXXaMJFbGA3Za2DoS+okk
         HPq7LPboHaKHffTTImK22ZL0aEdhorrDWC+JcfI5b/Szm0vt4xsLfq40vxhw/6Wrm4oE
         b4UCcUGzXy/TBQtuvTeAFKto1S8bzQ1gLeUOMc0UvnYCrIln5kszAT1Fb14ZgH2/3P3y
         VF2yL0NPLb0bWKVRa3hYYk4LkwdhphaNjhsk6gArFRtYB5cggsx2XEuRPT5ymaOZKwn8
         VsNg==
X-Forwarded-Encrypted: i=1; AKwUvBzVHRP69po6ZBVT4dQsVDUTxezqd32eMC8melDn68fJEJRhBsVxsQy/OEaHrSa6TaBlqY4=@vger.kernel.org
X-Gm-Message-State: AFuF++ldwNX39X2IV/llYd3OonYfCSeAjwjvbJA6vXfdQqnov3SV3U0o
	2cBGRnt0Vdzc3ED5pbvFsQJ4Y9lJvEL5xGKj9iflszlirNmTFTdtK7r/qgzBC3IRe8Oo15sxdOl
	RLKgRGv0wNOTNSFrtG6esaPWCL6YwJ/QIEFOxMLCS
X-Gm-Gg: AYBFou3xrtf+dfb/aSczJjUjtErUBHh+6Ji4rDKQKbQH/rToVtt3gOd4UYj0GFEJBeT
	uKizIMDaXYSh47YFdQJzSkZniwPsho/JsrG/A2GWerfotUM2bwb3hbYMIoXKY+m1efxcylQqrwC
	OgWfB9Qg7PtYJ7iIfx9Qv3xchuMK6vz/+wTpj9buTvatXRBjh4HBiJLdMKqVP/YTLlXkaH5TQFE
	0cMecfQAh+3S3Z9HRHskHSQyxSPeU8z96Y60K9bX1QgP0oQHbf3RAnrvG0Lhv12fl9Qsk1niD9z
	9VYITxbewn8BonMvW41nYAWmIA/MYJA45ClZnFGoxcPic36hrs7pa0VVtMhsKe/bbckFnOgf/fF
	xFSqP2nV9faVOsvOyUbWKxA==
X-Received: by 2002:a05:600c:2151:b0:4a1:9034:e9ac with SMTP id
 5b1f17b1804b1-4a19034ee9fmr272115e9.14.1791558483022; Fri, 09 Oct 2026
 08:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com>
In-Reply-To: <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 Oct 2026 17:07:51 +0200
X-Gm-Features: AclHuK_t9iEbDfrbBV_kHItKsjIiOteX4n4AKqToDkA1GKSU32A56GHZ4NbXcEk
Message-ID: <CABdmKX2VHqWrPb2O3Uqdccx=nP66gECU0kVc=4tZdGqSEZvuGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Accept unnamed dma-bufs in the
 dmabuf_iter default test
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:49=E2=80=AFAM Qiliang Yuan <odys.yuan@gmail.com> w=
rote:
>
> The dmabuf_collector iterator prints the inode, size, name and exporter
> of every dma-buf in the system on separate lines, with an empty name for
> the buffers that have none. The default_iter subtest parses that output
> and looks for the two buffers it created.
>
> It requires a name for every buffer, and sscanf() finds none on the
> empty line of an unnamed one. On a system that has such a buffer, like
> one exported by udmabuf without a name, the subtest fails before it gets
> to its own buffers.

Hi Qiliang, are you running this locally instead of with:
tools/testing/selftests/bpf/vmtest.sh -- ./test_progs?

> Take an empty name for a buffer without one.
>
> Fixes: ae5d2c59ecd7 ("selftests/bpf: Add test for dmabuf_iter")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index fb2cea710db3e..1a5dc1adae735 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -188,8 +188,9 @@ static void subtest_dmabuf_iter_check_default_iter(st=
ruct dmabuf_iter *skel)
>                         ASSERT_EQ(sscanf(line, "%ld", &bufinfo.size), 1,
>                                   "read size");
>                 } else if (f % FIELD_COUNT =3D=3D NAME) {
> -                       ASSERT_EQ(sscanf(line, "%s", bufinfo.name), 1,
> -                                 "read name");
> +                       /* Keep an empty name for a buffer without one */
> +                       if (sscanf(line, "%s", bufinfo.name) !=3D 1)
> +                               bufinfo.name[0] =3D '\0';
>                 } else if (f % FIELD_COUNT =3D=3D EXPORTER) {
>                         ASSERT_EQ(sscanf(line, "%31s", bufinfo.exporter),=
 1,
>                                   "read exporter");
>
> ---
> base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
> change-id: 20261009-selftests-bpf-dmabuf-iter-unnamed-217561e20d84
>
> Best regards,
> --
> Qiliang Yuan <odys.yuan@gmail.com>
>
