Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6973D88EB
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794647; cv=none; b=LC3MsKr558Tw4oMXZC2N2Na4p1ExJDk4JVrJVSqsbkTQniA1RdSYn8N4w+6wrfYynG5k2y7Dko+Z6Dea/uUWMTH9APcCBNqXSzabjyIO53t0hhAVgPI9+NdpMIFm3QiXZnXfKUA1ysfNtzh9fHfnA1UbB0MrIkVt9FahvV9hcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794647; c=relaxed/simple;
	bh=LJm7kzA1F7xgQuVpe4RPKARq2eDiYAq3Tx/+jQxWBdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0ihoeSvALnHOBYmsL63EH9UbBMRy5CnKbB0zDZt/tUpZ46pMk33x3+9mvgbbRf3WUAaxi9WrwthR+7YwAIlCqy1iTLva1ek3M2FIIqPITOAIBy2/czKPJz6fDk3fR8oJHGO3W4Px2qLA/mL2GzauS1gYlH+1Uc2ipiFdqowMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVGOVDsd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVGOVDsd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4371725b3a.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779794646; x=1780399446; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4BbwmD+u95B2BK/F9aWaJoeLcyKNoyc8YLZsStYq2mA=;
        b=cVGOVDsd6GRugwMeJzeqOfzIkEtcTsVN4dRdoIJXqRmLZ9lWthEhKfNkyICmIpI5Lt
         fqo+9+N/f9I0mYk0fURSKJWji52Gl83L2cGvoc3oHxk4IpLtfW8MncTCzAXNDx6vah0t
         H/dL7vD01clcno7rZ9/i+yfu/Rv+/EsVyS5Q2YDCcF4v5Wh+uS9zxuT5PAud77syZfUt
         Xtl6B14Fx7QIonEhunBxcexlwLhIF6a+4RJmFWxqwdCwlGd/Giwo4CPuXQL3WZizsa/j
         eOZhfs0Al/+MSKXgwg9eo6xGw2Lc16FQJPiaPssXVKGAI/PYerpidphzdbqGK3TqzqHq
         72iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794646; x=1780399446;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BbwmD+u95B2BK/F9aWaJoeLcyKNoyc8YLZsStYq2mA=;
        b=i+bn5AzwuGzflS2uDAPE7jN4iO7PO9boUK3wfLmBLbqO5n8PhDszJSqlz0B2teCt3J
         zmsG3pZ7KSzWwL5L7zjtZD2SJvT2fwXiSzxDLFU22yNcP4sNuCPKQtzXNmNDDLSC2bHf
         DmARa0VRnRGxMApC3TgKNl3kd10rg4e7fK8IP5NkFJz5qt827yDGlSHspKKMyRXOlXj6
         LDuK3tW7g2acY4wrtw/8c1tnpWXI7NtZBOsR8JKZ8rIAMYkubu+2tkw7zf0QPHj5yZgW
         4hQjSNFcSqG8O3h2+xriqFlebIxrntabE0qa+0prv/2eFc3duHK6RvW/+7Nun7ye8NFn
         2huw==
X-Forwarded-Encrypted: i=1; AFNElJ87PltV7l0Ovccam0jzM7Yc5yaeO0sQ1udYm99PbQxmAiSVwmbdplYNStHjs118mc05fU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyni0UZcs2sFgasfIT1d7anDx0kie/itDFWV33JXJ8LBHuAgc4U
	SzokqeeJUHnZWdSev63vVZerg+l+MNLeTimz/mxxcsAklPdrDVAvr8+L
X-Gm-Gg: Acq92OHrMAGbjmB12cS0r7GJfooCJr6P5j8H93A+GFF1sZxVpy/PePyM0dFYSPzxnqy
	2mRcn1USgVkaNUSvGRp2E0p7Tg0L1WjAEojBq1q9ivEYSZbrwRsDtxUcnttU9Hx2XoGrFVGj4Hv
	TFyofsxFY+vQ0GhiV5HwXzoTAKFS0Y9AQAkJiu2chR9TLSx6WUNMXPaXkcoPN/J05LBj1yu84g6
	NYGdBqk4fjVdQj8UR3Td5u9wZ09xiAlk38hi6ilYUeO+NRJtXGZKUdvsAtVeI1O1iJSCiiIVgus
	By9Pe9UBYfWkxgubIPMilkLHHZpYO3xF9p7VjpKqOCGmBmuItWdylNkVVer3NgLFoc0IPCAKGTj
	MWYKKTMQYvVzK1bDC/668ay/P88pJpeXZOOO4gDBN9LWzocOq8fmV/ICWbK+2oz9WPAIpEQzP9q
	WC1K8mI/UX03XD1P3/jve6Ns8SO8K9nnMbn2Q1Bh+UD8NwRmVpwiMK0U6/dkahYw==
X-Received: by 2002:a05:6a20:7289:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b328cfdaacmr18130153637.14.1779794645837;
        Tue, 26 May 2026 04:24:05 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852054c8absm10348107a12.16.2026.05.26.04.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:24:05 -0700 (PDT)
Message-ID: <26773f781a5d10d85de16c42333a55bfb38b03aa.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/6] bpf: report hot simulated callchains
 when 1M instructions limit is met
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 04:24:02 -0700
In-Reply-To: <f2a61e399ccf5c0974341ec757dbb88c69f61840907aa0bd162564589ad2279b@mail.kernel.org>
References: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
	 <f2a61e399ccf5c0974341ec757dbb88c69f61840907aa0bd162564589ad2279b@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 10:05 +0000, bot+bpf-ci@kernel.org wrote:

[...]

> > +static int update_callchain_profile(struct bpf_verifier_env *env, stru=
ct bpf_verifier_state *st)
> > +{
> > +	struct bpf_callchain_entry *entry;
> > +	struct bpf_callchain cc;
> > +	u32 hash;
> > +
> > +	compute_callchain(st, &cc);
> > +	hash =3D jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
> > +	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
> > +		if (entry->cc.curframe =3D=3D cc.curframe &&
> > +		=C2=A0=C2=A0=C2=A0 !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curf=
rame + 1) * sizeof(u32))) {
> > +			entry->count++;
> > +			return 0;
> > +		}
> > +	}
> > +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
>=20
> Should this allocation use GFP_KERNEL_ACCOUNT instead?=C2=A0 Looking acro=
ss
> kernel/bpf/verifier.c, every other transient verifier allocation uses
> GFP_KERNEL_ACCOUNT (see kzalloc_obj, kvzalloc_obj, krealloc, and
> kvcalloc throughout the file).

It should.
