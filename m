Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB042EEA3
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080286; cv=none; b=Y+MSYbBuUy+WxdSMieIhSysP61y4TtPZUdqneFex6LcRmw/WO6F5/PdcvSqEWQvVfpReFm+cEwO/eVZO5TkX1gh4HS3UDxMapnzVG337sYMBLIBR8TurlQ/ZeJ1EMTYpLeRcxLXqlbGKmHvqCCe+VDeptPdFvrfwHT+wtH4u7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080286; c=relaxed/simple;
	bh=k9J37GNtOk5KY/uqraI4usFytMzq3028a3geGxyRND8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZGqwDCFjRZvMVeRdAWwjzrOwXb6gIrud8NFVX1rwh32Vq/wCOnlFOa2T7yz8khXJFVyuAmzA2sVMQGso5zPjC6R9niJbeNXc6/FKqPSTlkVFC009nuHZJK5zZQSGPQIBCmI/s6xmNQZecy03GritqrnALDfuVj1Npef8YUuto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFkCKrKW; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFkCKrKW"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso1144975eec.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780080282; x=1780685082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGAWshjzxBvlYHwjvaREB7ZOR/iq635ZCqS9GRTgl4c=;
        b=OFkCKrKWcmIvH86Q3H+q3K6TT7ekqU8BnXy5+O2aOoMI9le+dcTgxwKi+h9yM5GYKb
         L2vw8vDpmQFG9yCJGwj112j0S+WC3Q0r6mQbViwCOrN64qJ2o/zkhaFSQCGr1mV16erP
         KVV7iyHS/vdhzcnrF9VY9eZMrk8wl/ZklNafNi4ivwMeLftwZumDI/ZrOjrwlBnk24UC
         qm8B61UpNStTBCh/d+wzuOHoCfY5u9PYijUEkbbhUK1S58JGNSflENa7Vk6rhxoVXlMk
         0JpeIlRGDchDM623hCymuWPD7p7UUoEoKWKPMBYBiIBP3qRQFH0dP3lGNCv7k8PIAsmC
         ewmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080282; x=1780685082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGAWshjzxBvlYHwjvaREB7ZOR/iq635ZCqS9GRTgl4c=;
        b=kJyuqwQ3gOHvd3j52AxRMfzoxx/KdFD0Ljiu39rHZek5ks/jAIKkZAJDDlbupVUBpd
         ohfUhfcsH/Vm1gAe8D4lY2jyPx2SOUJj42S2hhiRAX5jaKf+O2Iufhfj689054GiwG7x
         7DkZHSwLOpb+DvDHdlAAWucpKiVkBKUflnKH0uOKqiSVBtMUcCQvfLBE6LKP395weiLX
         kGQAfe6lLybnHayaq2fXjk+pUUlAMCSND75vSf8R7FqSMYdd4wv0ujKRxctzaZwCn5Kt
         JCzT2yvgVEZpERDnPGLlNxS0sKb6nM8rxT2evOgycgdKBWsYPbLhM8mD/TELXrPqi8MQ
         j52Q==
X-Gm-Message-State: AOJu0Yyaq0tYXP04xF4gpAugkNviGp3ovrEySTdp83YCtn9wQJqJbsoB
	bm+yX0SrB61hgU22wR6WaXK1h/fnm4HzFA9zsFnOwATGBrFaOoQ2pcIhnujjc9zX
X-Gm-Gg: Acq92OEgD8fR2EaXgOkf1z8B1PMZ/47Q9wAYaRkmBLWwD9UP/VK4w4BAOswruBH/MyL
	C0QYngJ4c0/eUcMlJKn/dZ1Pe70TwEtvRdNrb8SNgVSka0aBkIJ8BRGsGNpVycNEYArWjiHeg/G
	Q+zvQn3ibZeB1+3YWoI3T650OZDYqQv2GIfHjj/3tLD9tYZOASfvBixvvSrrcZZOpklSD4H7OWu
	LTnpZMcIZy49Kqb38e3f88XOb5Xuqz5gRPujCxgcs6Wb2nNblpq6AG5RzBH+7cj65oT44hwYSx3
	sky5ruRcT83Li4W/CIXO+VWUO2GlwaRBHJ059JJEdUo0IRQfmX6YXVi3lC107zq3XnhHWEGtNGc
	hsBlxV8OoWFWUUM54Arwc2WR8k1L+UibXX8GGaaDSLb8DKJtEhbO7jiT7NTyevV0MH6xkawSbCL
	l5W3isxJ2ZBIMG/QBYmHVx4oXzq5twzs3zYYJBN1axFCKyHqT6DqbDnKdm3DlARWuWWnvVHDed9
	FYsh2bQ7A+WyBEfLxo=
X-Received: by 2002:a05:7300:2313:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-304fa5c3061mr581673eec.14.1780080281751;
        Fri, 29 May 2026 11:44:41 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cc2c:f0b5:a02d:c0fb? ([2620:10d:c090:500::2:a9e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c3121sm2091918eec.5.2026.05.29.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:44:41 -0700 (PDT)
Message-ID: <17304ac9808245282aa2f03f26665cccd6fc185f.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated
 callchains when 1M instructions limit is met
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 29 May 2026 11:44:39 -0700
In-Reply-To: <ahlpI7sRJt1FQdYg@krava>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
	 <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
	 <ahlpI7sRJt1FQdYg@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 12:23 +0200, Jiri Olsa wrote:
> On Wed, May 27, 2026 at 12:29:52AM -0700, Eduard Zingerman wrote:
>=20
> SNIP
>=20
> > +
> >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_=
state)
> >  {
> >  	int err;
> > @@ -17381,6 +17527,7 @@ static int do_check(struct bpf_verifier_env *en=
v)
> >  		insn_aux =3D &env->insn_aux_data[env->insn_idx];
> > =20
> >  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> > +			print_hotspots(env);
>=20
> hi,
> this is really cool feature, I've already used it to fix issues :)

Hi Jiri, thank you for the feedback!
Anything you find lacking?

After discussion with Alexei (who is somewhat skeptical of the whole idea),
I plan to add:
- samples for values residing in the diverging registers
- walk back from iter_next call using jump history and
  print 5-10 instructions modifying the register in question
  (in a manner similar to backtracking done for mark chain precision).

> Would it be possible to make this configurable? like to be able
> to get this output for program that passed and display more than
> 3 hottest callchains?

For sure, there are several options for a way to toggle this print out:
- unconditionally make it a part of v1 log;
- add it as a bit in bpf_attr->log_level.

I'd say that v1 log is a better option here.

As for number of callchains printed, I'd like to avoid tweaking
bpf_attr. So this leaves several options:
- make it top 5-7-10, just hardcode a bigger number.
- add a threshold value specifying how many times a callchain should
  be visited to get printed. E.g. only print callchains visited more
  than 1000 times, if such don't exist then put threshold to 100,
  if such don't exist, print top 3.

Wdyt?
