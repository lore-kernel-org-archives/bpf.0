Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386012;
	b=zLjTZyPD4k7JAi1AyOdaiLdzsWOfYVVev9+mhMeo1CDMde+05J9lIsoVSkcSpbwhx/n3
	 gZ87n/jyLUdys4yoZjgKkYezhUZR3I/IGffyH3EShqH9QAfWN+H6kEIvgjwMDqDS2q91t
	 NNA7sjASl9hQXAvK0SMNj0pRGAsDBHvhsJxqI3LkJ6yNykOV0QJe5sylZpb+gel6SQT02
	 9smbkZG1W66+nQWOI4riZpxpQlSxLs7/el+tPWpfrXKC5ytUrMQlWphnl/JuNlJP9lyml
	 w6P6R6IAu4rZYaZoPQymSQaWrGA/ifVUN5MLremniOe4C4wPmUh3LPAso95deSC6m/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
	b=hOM8ZgiOm7yef56NCXK9QXJUpsxu9bJGB4cajl1erKiL5mcqLjLGegKOC2i7W/b5BqM+
	 98nDbr56cVYkN0I2iCZsio/HiwJfHJwHKNq53+c1tAZEx4CnEzUd8EbNhN9dGMIfKxVPK
	 HkIjJs24fR6MdQCP2m4TbtJm0ZJW4b33wteVAiHvqqkqf/OJCzVJ1WDxHNH9NlEl75XnP
	 vzvcrbyneLbDaaEuu77x2TYpJYAxx+ZT1ZW2UaaiqAUpYllrmdi8Eu+O3c05WVeBsB3cI
	 V+1uyIn0G7ejQ9oDM3Lxai3MNmoHwS+MRsxhcgH+c79H0BoAcBNcboxxFB6IFuvaF8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpG9nWi+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E0606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 123E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpG9nWi+
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so905791a91.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793386011; cv=none;
        d=google.com; s=arc-20260327;
        b=LQOlGo1poFu2HESSX9KQYbxLNQoSG7gg/7gNCPn2/CUmMHxPhRKSfb2suxc487tOpS
         MAqXCC4BM0JmZPKy4kPTBPxnub6JM3ozk0ZU/cN9hPC1SoaVOVH+tBJ1tCx8rdH3G21M
         0cP56cxdXK6TpP5uqyS79F9NTfkiANPe+GqZD2WuQfWAs44TL/xLJJgRX/A9Frg+43jf
         cZHDAGunAHYvRNuWDYie36plJ+Mr5EumBLllwGdBqKe4M3H1kLJAh0orlYFTLojd/+85
         Bs3Z0UaDUtcDy010wW60QiYfsv1O+IikBCee3k3MVc4ggwXd993d2j/ag0plTvng35/G
         lYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        fh=Afy2XiopY8lSrbL2hBY8NxgFfFuZa2uGweoSFVLi0Jo=;
        b=CD1Z5kUTo9UFjWYioFxKCkJCG6SpL0xYyHvSZsyvv7Xo8Z37aEhQnCiOuLy0YQ8z/H
         YkkdX+Bd+qa30M3TKc7R4HOG63KhrdrgnSP1gUP4N9r6oGwFKAWkj5aKzIARY1QHSLhg
         3lalQoxgCawmPDfr/iD9a6lunp7LUoOPla7TxFx1wsMqRkIkPAPlv9TNfhCp9hLCMitc
         pI8BvJJw3qzHgxI/6MlyEaw/C/Dauemq3ip0RGF40lNmzVNkOyRpDNbg22Gj3CrR6Kv8
         1Xaj6kX+HEKVe2mcakITf1h18oCL30Tg81N22IaVIyVkkmAd/AHsLQV08oEYUxPffdLD
         h6yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793386011; x=1793990811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        b=RpG9nWi+ZKZZWc/DkNMA83Z9UtRpSslN4KqWD6J5EXh+HiXKD2gHraxT5ud7euPIBF
         cZe/CRChoqxgWOsLvo1/dZceKUHRRMfv1PNbN5fCPEonX8k+7y4Fo6QQKdoesI69izGD
         R7wcqjNUTF40M+owIN41gjfFh2MaOUIikO2wxjlDsv1n9TwXBPcEDRcdrKiWXhKU/yAE
         gasrhk1UJOT32b34GxEzm1jygwYHNf8R/0ZC6KwwHz6i8zBf0NWrX9VSoyo8Dzx2Nz3Q
         an6SUyaW9AasJAe7rIckyBn/crcOLhcLkVx6htT8C/dHctAMsYKTLBzZiYOnM1NLIyWZ
         XlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386011; x=1793990811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        b=YE+enO2F0mKIFC0UidsU5HDyVRsyM702at5gIMvugJ8hmymHAeKsfjYkig6aFRydg9
         QNDalN+oDxc53DRq7d59Qd2qJA5EEvnVehUl86Qi8clnr00uHuqVK9u2dXE2jlD8Nxqx
         iclPJ+YdJP945dfalaRQDpZRZqMQi2Pz3t+E8WayOJuRkiy8/UqDdDBJnzUd6k4qKmEu
         P5TXsk1Pyf4z5AT8UYZp4HB9gWiJHcRn7UvEkYxeeEf5R0zbS6+F6UuUEXxNF9kR4+SG
         zjuFfrLz9dyc/gvaqDLN5aNzahEDdizUxVM45MlxUZrj5umfu74iyHn6PXy+eIfQ0tAP
         Pu6w==
X-Forwarded-Encrypted: i=1; AKwUvByn+nVOQD8ewIMkzlRn3qZ2wMx5x+gXZKPqg/941lhFKhwvRMzD6bxKvVLmWGyNWf4MpeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/ijRdyvM4uyb+PKpWBepp3AwTMMqSXmSaPifS0IBfcNAUkYGC
	pd55TKdDkb3TA7WMN+vS1h7ntfmTMpMcfEw+UZt+XScNhKAfJChb/OMvbYg9KZD9Ez5x8nKJ+kY
	8KiCknOG+t1GkIStAB8DPeLdfCpamDpI=
X-Gm-Gg: AYBFou3LalzkcLAZbRikNoGaZEBlzcXflxd1LZC4x8uAQs5n+b9TFQbpBHE0khj9hDX
	m4F2Hcs42j7Ej+pxmGBMf06WXCR0/LciXJXT0gh3h8RMJVAPiJ71hDj711NEQ/8htx1R+wpVNnv
	9Y9uMdGP0aZxf4yOcfxpCEoSnkoC6f/ckXEYIBP81IVJxkyfle7FKmEjFiqoRDMkWLCp5fiwlBf
	MZAWeFjOuJ6x2FIr9yO8zgegdqZnrzqG7XPc7jgvbpHUr9eeByQ+G/L0K6h5g0InOjvCgbbPMRv
	zIF4c/CtDeAEVQ3etFm0c4m5cKrygRVT9iZr2pqsW7Oq5ntQf2ZK3Z/Q7Bwowu+WCx9VeNl0Ks0
	7605zdLdtydMj+GTlgXqIwTwTc9fSe44RvUqW2CUVXF5oNj9wcJ2p3yPPgA9nJtEL87gKvoOq7C
	qJIlrr1osx2+wpWVSqHRxuCo2OADig+0Paxw==
X-Received: by 2002:a17:90b:2803:b0:3a4:bd4e:6d15 with SMTP id
 98e67ed59e1d1-3ae89763070mr2620334a91.34.1793386011367; Fri, 30 Oct 2026
 11:46:51 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028125148.1348-1-yangsongsen@insta360.com> <20261029073344.729148-1-yangfeng59949@163.com>
In-Reply-To: <20261029073344.729148-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:46:37 -0700
X-Gm-Features: AclHuK9JgZQ0yY9pjUZS0J7oNwln-ZzXOo3HkJmw0fssJ8tLcUosj90ClGtkpxo
Message-ID: <CAEf4BzbRh4sof8aD4kj1y27kE3-VfAR3SOr8QMcH5n8rkUB-bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
To: Feng Yang <yangfeng59949@163.com>
Cc: yangsongsen@insta360.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, matt@bobrowski.net, memxor@gmail.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:34=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> On Wed, 28 Oct 2026 20:51:47 +0800, Songsen Yang wrote:
> > Hi Feng,
> >
> > I hit the same root cause independently via syzbot and sent a fix a
> > few hours after yours, without having seen this patch -- sorry for the
> > overlap:
> >
> >  https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.=
com/
>
> Hi Songsen,
>
> Please don't worry about the overlap.
>
> I hadn't noticed the issue Sashiko raised when I prepared my fix;
> It looks like a pt_regs on the stack can fix this.:
>
>         BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepo=
int_args *, args,
>                    void *, buf, u32, size, u64, flags)
>         {
>                 struct pt_regs regs;
>
>                 perf_fetch_caller_regs(&regs);
>                 return bpf_get_stack_sleepable((unsigned long) &regs, (un=
signed long) buf,
>                                                (unsigned long) size, flag=
s, 0);

using sleepable variant of bpf_get_stacks is a better approach,
because stack traces might request build id, and in sleepable mode
that works reliably instead of bailing early if memory is not paged
in, so I think having specialized sleepable version is better.


>         }
>
> That said, I think your approach is the simpler one and the better fit
> for the fix itself.  So if the maintainers prefer your version, feel
> free to ignore my patch.
>
> Thanks,
> Feng
>
