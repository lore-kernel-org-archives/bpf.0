Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2938E8A7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533707; cv=none; b=kwZRQxmK4mkMChUE0zVHrG8SXG3m1XvqiO0XhUYu1sSWPYeuLfFrGKF8FYFcPoyrN0pcZv1jgSBZhkEK3JGvLYgAT5b1eSXHsWRl/lwaK1ljBd+ffoGubSeT3cITO4PrqwarmKgpY9s44oY2haeNdVfoZUJ3gmg0S2klmEZuE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533707; c=relaxed/simple;
	bh=IYCHIRkcU0Y26Lh+LLhttLcA6GVmm9WCqKr3QlsZawg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mcr0Vjg134LtgmvAbsJqa5BUZspWKRkjOPPuP4XCmokmA6/xecS9+9pUxvJbe7SDQEfhLBAdrYsn1rXpPCUHzQa6NW401xtWWH8MNRt9d8te/Nte/AEHVPvyPt+5t3qbK82VDHSHzbvfLWG9raMnEeICQJr+qmmu6v/3uBc1x1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hli5wZpD; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hli5wZpD"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fa996e65bso2085344d50.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533704; x=1789138504; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OmKNC+xz46c7sTpK++7HxSk0J2ccEwkpwZib7Yoy60o=;
        b=hli5wZpD52So5JYP7494YC1zOfZzcgclWgO3j0h9SS7RsIHVovT+AAEpXi3XPJBoWV
         dqvqUDC0d9lMkpWm2y+16QXVbDxN2mqbQDFGmL24oarGQ7H1TTx6JcamQ9TfIoMdx67O
         LqlhGFSTXs3kcex+6XfAOZuo7i85TcAViLeWILPCESeGkzqbM+nSgGjJRI5zjqDJKHTt
         yw7nwkwUTFpk5+GOJO0ljRs3rqk/Km2HKTLHWgncpTR1XhefjTpoU6PHD5VfR32p6g4t
         Y5ZroNeALKw+PFbLta3wpZhObjqlOGDEOZR/mkgUutqrj0f2NAgmN3v78zD/3BaBdMRf
         Qhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533704; x=1789138504;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmKNC+xz46c7sTpK++7HxSk0J2ccEwkpwZib7Yoy60o=;
        b=VRxIwiN3JZ2ImovXOZ36K4WwxgCDXQ3F3JCoYg/DUxDe7nm24kl12Hg3maEe50akpI
         YNEPR6KMV9kszIUletZvkfwIOj8DI3cN3jZ/LoHLbgVSvKYOwB9U+v0xhd53jAM2c3ew
         A+4J4PLMhZWk3R/0xd9VCcaxM1LwH0NWuChtmiHHyBetgUnZd5eI2I8sHOtNFoqY39+z
         jOv/0IDjGvQ1TgCjgH8iApJJXCf2UTFQ5fjDi0WyyejCAWyG4NG8uMhG0IUEsqr9KzLJ
         037HGc6xuw7DjqSj0WYB4u35Dnz9q/9eNNPSIwzTLQLDZMLRNBz/sWhouU/rQAXeHJ1h
         i8dA==
X-Forwarded-Encrypted: i=1; AKwUvBwUZGZJdkK66UxVKm23IQsGjb65/H7pnNcUOla/Bk5PLOURpU8rLw3q4Mu8uYdNcixjXeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Sy5Zqe4qIeKb9RTF74JXdW1jX41wAabAzgVbRqhT3pKRB4B3
	wxzMvvHpZUHh1sGsZuJvaFtOdBfL1IRW17gR58l3ezExmQ0LWls0vyie
X-Gm-Gg: AYBFou1inPHNgTzTdt8rKpK89Z5Om8lD1oT/pbCDZ3jR8TWfSQWgVU6qIJomLuF/DMS
	MWOSS5njbsRlw8nFO1XdcDwIj7NXsMcjq/8uGKxOQQt1Y5YtpHcHeWfWTwuvdInPEDfx9lGcnTk
	K1gNdYaNKjMC3q5PRj4GjGZnFMXXu5N8+ehgy8Qc1Aj8EJ0V54WDTWoLrL6VTx9MIhE+q4FcV+p
	lRch/sQpLFOqBuDhIjuWPN1/S8ceImO/++ZYw/Qrcf8q+NAxy65o3GT7AyyM4reOhrwdANASu2q
	pY2xrZYIWElCclCp3tBEy9rdeb/YA3exe36TVuBnENm/ZYLoh53LsxN6iq5VYbB1LB7VONfuV3J
	p2Thzld9BCdX5Ye93Fbmw7LBxIk+rjcV9Way4riOrOf1oeLxCao4p+MyfZgDKWgD5P7pyzc0sH9
	NeVgHs1rN/Kv2QgL5LMh0VBOj+C3vHrmRUp+2k/nt+Vg/1kmKefzWF3UacVRCXZCMqPBLwB3Nk9
	hqACiRJ63Qz2t+UwjVd3NBY+VebzhMVIdaGDwPTrrG/z9nEhkziISY=
X-Received: by 2002:a05:690c:a785:b0:855:f387:98c0 with SMTP id 00721157ae682-87127d27776mr32660467b3.29.1788533703978;
        Fri, 04 Sep 2026 07:55:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab73f23sm19428697b3.33.2026.09.04.07.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 07:55:02 -0700
Message-Id: <DL6MA7Z7QSI9.1DOEM4TWTJN5B@gmail.com>
To: "Jiri Olsa" <olsajiri@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Mike Rapoport" <rppt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/3] bpf, x86: Add support for jit dry run
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260903092039.477827-1-jolsa@kernel.org>
 <20260903092039.477827-4-jolsa@kernel.org>
 <DL697WN5AOBE.C8WRI12FLOG2@gmail.com> <app3IQUwVF97Tfq1@krava>
In-Reply-To: <app3IQUwVF97Tfq1@krava>

On Fri Sep 4, 2026 at 12:45 AM PDT, Jiri Olsa wrote:
> On Thu, Sep 03, 2026 at 09:40:46PM -0700, Alexei Starovoitov wrote:
>> On Thu Sep 3, 2026 at 2:20 AM PDT, Jiri Olsa wrote:
>> > Adding support to run jit code generation in dry_run mode that won't
>> > store any code and only returns the jir code size.
>> >
>> > The dry_run is enabled when __arch_prepare_bpf_trampoline is called
>> > with rw_image argument as NULL.
>> >
>> > It's used in arch_bpf_trampoline_size where it allows to skip the
>> > image allocation, that gives speed up for tracing_multi attachment.
>> >
>> > With current code:
>> >
>> >   # ./test_progs -t tracing_multi_bench_attach -v
>> >   ...
>> >   serial_test_tracing_multi_bench_attach: found 55227 functions
>> >   serial_test_tracing_multi_bench_attach: attached in   1.563s
>> >   serial_test_tracing_multi_bench_attach: detached in   0.256s
>> >
>> > With the fix:
>> >
>> >   # ./test_progs -t tracing_multi_bench_attach -v
>> >   ...
>> >   serial_test_tracing_multi_bench_attach: found 55235 functions
>> >   serial_test_tracing_multi_bench_attach: attached in   0.798s
>> >   serial_test_tracing_multi_bench_attach: detached in   0.258s
>> >
>> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> > ---
>> >  arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++------------------=
-
>> >  1 file changed, 20 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> > index ee2ddeba3de1..d1af7dc5c5ce 100644
>> > --- a/arch/x86/net/bpf_jit_comp.c
>> > +++ b/arch/x86/net/bpf_jit_comp.c
>> > @@ -25,6 +25,7 @@ static bool all_callee_regs_used[4] =3D {true, true,=
 true, true};
>> > =20
>> >  struct jit_emit_context {
>> >  	u8 *prog;
>> > +	bool dry_run;
>> >  };
>> > =20
>> >  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
>> > @@ -42,7 +43,10 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned i=
nt len)
>> > =20
>> >  static void emit_code_jit(struct jit_emit_context *jit, u32 bytes, un=
signed int len)
>> >  {
>> > -	jit->prog =3D emit_code(jit->prog, bytes, len);
>> > +	if (jit->dry_run)
>> > +		jit->prog +=3D len;
>> > +	else
>> > +		jit->prog =3D emit_code(jit->prog, bytes, len);
>>=20
>> Sorry, I don't believe that skipping emit makes that much
>> of runtime difference.
>> I suspect jit_alloc + jit_free are costly.
>> In such case the earlier patches are not needed.
>> Point emit logic to some scratch area and discard it.
>> Same effect with half of the changes.
>>=20
>> pw-bot: cr
>>=20
>
> yes, I got same speed up with the change below

Great :)

> jirka
>
>
> ---
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 48429fae0641..1bba19a9a17f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -9,6 +9,7 @@
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
>  #include <linux/bitfield.h>
> +#include <linux/init.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/memory.h>
> @@ -23,6 +24,19 @@
> =20
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> =20
> +/*
> + * Reuse a writable image in the BPF execmem range for size calculation.
> + * Its contents do not affect size calculation.
> + */
> +static void *trampoline_size_image;
> +
> +static int __init init_trampoline_size_image(void)
> +{
> +	trampoline_size_image =3D bpf_jit_alloc_exec_rw(PAGE_SIZE);

I think you could have kvmalloc()-ed that memory instead.

> +	return trampoline_size_image ? 0 : -ENOMEM;
> +}
> +late_initcall(init_trampoline_size_image);
> +
>  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
>  {
>  	if (len =3D=3D 1)
> @@ -3819,23 +3833,14 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
>  			     struct bpf_tramp_nodes *tnodes, void *func_addr)
>  {
>  	struct bpf_tramp_image im;
> -	void *image;
> -	int ret;
> =20
> -	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 *
> -	 * We cannot use kvmalloc here, because we need image to be in
> -	 * module memory range.
> -	 * Since it must be writable use bpf_jit_alloc_exec_rw().
> -	 */
> -	image =3D bpf_jit_alloc_exec_rw(PAGE_SIZE);
> -	if (!image)
> +	if (!trampoline_size_image)
>  		return -ENOMEM;
> =20
> -	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
> -					    m, flags, tnodes, func_addr);
> -	bpf_jit_free_exec(image);
> -	return ret;
> +	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> +					     trampoline_size_image + PAGE_SIZE,
> +					     trampoline_size_image, m, flags,
> +					     tnodes, func_addr);
>  }
> =20
>  static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 =
*image, u8 *buf)

