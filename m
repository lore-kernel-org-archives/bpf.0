Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8B3A0B05
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476261; cv=none; b=dIVA3J/i/IXzek2p15BnFFOXD8b+I3uWhSqgyrgxT8amAheRDrcT/7uJsVLKuvfroycRNJUy9fQwgkArKpHiWL+UvF68uZ8A5rO7a9TGRnJPH3U4V8KoIpX/GLmal22IxPi3OpJ1TTihiW+E0QQwnApQondS0+OG096jfct/og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476261; c=relaxed/simple;
	bh=M42+QN7g06FnCWI24XlVFuqTmluNJh0Hjbo/TmkFubk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YSMPSdcqxiLBzEGYQU2qhIQPg5ZfqrB2LBuGmOsjDar27xQwqOogpJms+XWjJ0jSLvJL2S4ZQbCcRqPPjgRUuZYvRJtFQCagtr1KxmSe2r1P5RyvcrigQYGVTmHi46HvllFtkqL8KnYfUDzO1P8RxJ8IU3ooR/qCVhMnqbm4SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHZ5a301; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHZ5a301"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-473ba029526so991867f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784476258; x=1785081058; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PXkXoZcPYatQN5jk0nmNsirA5Eu/FVrdYn879C+3tX8=;
        b=PHZ5a301hruHVWrtRJqZyr+0GcJ57qFaBwyhlXClivaRQPon1XIXyeWADs9z28w7z4
         M0CszHe6vSj7rRamJRezoTqtyiJ+z1aMZSZlbVwy4Yp9IsqYkN7Bv4P1I1Zr/TaSRPqK
         E2PIMh3X0Cl4LbeDUMz2JJb15hVTkAvvWJW8u3J3d9RmvJA0tuSQfw3tXJ1N+DCD4DUM
         NkZYNO79PGcXgin8rdOdGdNoDe4pe26PTRHOk0MOeIO8mxbX4lrl6eZwrtOgEAp3T+Iq
         9jhU3GlM6moTcSrVCGYdEQs0MYv7gUp4jl0bjUTdzTzFFYrY9fLc0Rk2qk0q0K5yOazS
         XDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784476258; x=1785081058;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXkXoZcPYatQN5jk0nmNsirA5Eu/FVrdYn879C+3tX8=;
        b=HfVJ0pc6jDUfBB5WuBVI6xsW2lgqfA3iOlKP40vqq2IEJ7rnbHAexROkpPTampXyJB
         h20F7h04N6dffyvS/bi1vFCkJF5iF0siBHvFBcTi0r6N0HXpFP3x2zUYsMnCgqDXHwyK
         +HfFVetCdtXufm8EF4QWcAweNvfPYExEIHOqKYbzAX5YLKG7dFnBYuXQLuCy4SdpoEAy
         HEQvI2v2I6cPdIJCzDqrja9rizpEmKHyKLIi8j5L4k6mUslvzqk8p4oHrb74HOO+/rKS
         zFKXMBSxFkYL0UvrkigWexYYVoDkj3Nt2oTJKrqzP7yJv/A/MZlFTBXiHRUtRrtA8LvN
         xv9A==
X-Gm-Message-State: AOJu0Ywb3AdHsDVf9rPxl0qQa9pQjDWpgyVTKLgz0uozdoQekLmcmqqc
	TmU1MLtupfOXE1PeNTSt8vbqb7m3+DaeeM0hXUyGINMqRw8hgHtaIkAsLXlEsDhB
X-Gm-Gg: AfdE7cl5a0sU7AapMrk2KGsXyYEIUpt0SDslwMvGb63sdJycNmSSEt24WgfUY8tX32Z
	rzx3ZMUglIM/fuL+0gTK/Ov0pwqkUITmEsb0ReY0NnWny96FBtuyH/GE46Fn9Y+dpfJbJyRAuPE
	V8WCdIueG4xGBalH908JW+QKDbsrnF3SN/dfBJ7/78+NFyp082iRPHkZC2r4oEXOHECO7mx2a+T
	4WmQiS3RzpvmjbuvV7+aJyoQ2kbrrlJuLSxVR3VUTyPiGoxGdRJ9+qfMJJZs/09Jrz/Afm+rigF
	mE2HDOqPxfBM0I7J39NS/BFe8d3+qvZuMNvoO2bkao9zw3DppkfPWpoFZC5h2SGFiMmxjrt8P8z
	hdIRmEaWtEYXlJYVR0m4RcXwMz23yy6lnNHvyaQiTVy5vhcbfvN6t4Zs5C3sXYjp2g2MBLLEmsB
	Ith4YgrxVYxb5OcK2oKYi6yTPBiOmIMngdIHbp1o64FC6iHHhpa9fcnMv6KLNUSxUJ28Gs7l3eN
	OTEZELG2zTHGIvkoPiletu/DV3kUy+wmVy/14yOzonx
X-Received: by 2002:a5d:6f05:0:b0:47f:7045:dab8 with SMTP id ffacd0b85a97d-47f7045db28mr4801609f8f.7.1784476257907;
        Sun, 19 Jul 2026 08:50:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6b85970esm15744545f8f.15.2026.07.19.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 17:50:56 +0200
Message-Id: <DK2O1FA85Q5Y.20IOU7GKJ6O6G@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for
 bpf_res_spin_lock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260719153634.2908692-1-memxor@gmail.com>
 <20260719153634.2908692-2-memxor@gmail.com>
 <20260719154827.54DA51F000E9@smtp.kernel.org>
In-Reply-To: <20260719154827.54DA51F000E9@smtp.kernel.org>

On Sun Jul 19, 2026 at 5:48 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Userspace-triggerable kernel warning (WARN_ON_ONCE) due to neste=
d struct bypassing `seen_mask` uniqueness check, potentially leading to ker=
nel panic.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for bpf=
_res_spin_lock ---
> commit f617fbd9a79f403f8e8be07c38922dcd0eedd840
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Fix offset warn check for bpf_res_spin_lock
>
> This commit fixes an incorrect offset check for BPF_RES_SPIN_LOCK in
> btf_parse_fields(). It now correctly checks res_spin_lock_off instead of
> spin_lock_off.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index cbb1e49b9bcbf..e7d4e9ba24e26 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -4168,7 +4168,7 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
>>  			rec->spin_lock_off =3D rec->fields[i].offset;
>>  			break;
>>  		case BPF_RES_SPIN_LOCK:
>> -			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
>> +			WARN_ON_ONCE(rec->res_spin_lock_off >=3D 0);
>
> [Severity: High]
> This is a pre-existing issue, but could this WARN_ON_ONCE() be triggered
> from userspace and cause a kernel panic on systems with panic_on_warn
> enabled?
>
> If a crafted BTF with multiple identical unique fields (like
> BPF_RES_SPIN_LOCK) is provided in different nested structures, it appears
> btf_find_struct_field() resets seen_mask to 0 for each nested level:
>
> kernel/bpf/btf.c:btf_find_struct_field() {
> 	u32 i, off, seen_mask =3D 0;
> 	...
> }
>
> This could allow duplicate unique fields to bypass the seen_mask check an=
d
> be returned to btf_parse_fields(). When iterating over these duplicates
> here, would it hit this WARN_ON_ONCE() and panic the system? Should we
> return an error instead of warning, or pass seen_mask down during the
> recursive struct traversal to prevent this?
>
>>  			/* Cache offset for faster lookup at runtime */
>>  			rec->res_spin_lock_off =3D rec->fields[i].offset;
>>  			break;

Fixed by next commit.
