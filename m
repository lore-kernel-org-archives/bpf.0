Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E71331EAB
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299260; cv=none; b=YQpyvjdcp35rADg/CgeWj6Bqo9jk9mP4GVx9q7B17gnxVEshCHiAKOT16ZX3NTD/9cryWxVkV0SANLwiLn8emjbuJE+v2z9QAhhR/q/hpQo1byc8WaEUAJdI0tO+zRzPPxu3pAdYfXSnSgnKTSz7AOkNETWLkiaavnL1UOIkeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299260; c=relaxed/simple;
	bh=J29XuTYhGK77NbEKueg++Q6iodM5kAR5QyG/HgtcrJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KD77+N+VjSOR28yBjHQX31xCmJczzVvFZ1aEtQrlzlLcZbh7GLiAjnXJfPGCVmSnfv5Zb/CM0m4yNnT9FBAGL15BEfNSYquEWJMf1P/TwpymAcl1ng80DAQmKf4DahVzbO+KQTe6jMPhCwrWx4JfVZHF8JMIOcinzgykir+kpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0kM0bby; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0kM0bby"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304e83724bfso2255254eec.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299258; x=1781904058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4JIeTkWRWtaXksR2mWeVU4D36rgJvVf++XT2XuBXzEQ=;
        b=C0kM0bbyR+i0Vz29VcnUid96XCGYqkYUv1kQtLaleg3Ip1cPjqJggBTO7k0eL0q48N
         bH6B4oCGOaWxPP7NohxB9FE+e0aR70QQNs0cMfDCkcXDGmIuMJHBGA629YEhjOGS2aEC
         zjcp3W0mg+4JSv2W05Hm0Wvy0P5ZUstKYrJUi6tyYKP2xQ7TfPhYucDXTkCvwfyU3TGV
         aF5JEUFqU0uMbV8Py3aF3bZtbp5+NIzksk18ftT6vFUZPX1VQ5GguTk1bx3YMSlX3Edf
         z4ILLU2lFueXn9y2sYTM/dIyH7w74h0svV1cxlbSGXJHIYSNvz4v6Z7hMj9Pr1DYBUeY
         w9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299258; x=1781904058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JIeTkWRWtaXksR2mWeVU4D36rgJvVf++XT2XuBXzEQ=;
        b=QF4f6DXyiO2B9TSnpe1CGyqkittbB7ELi23FlN3+m2h0BCUAIaim9YdWrqRJz5rZ2x
         3lt48/o8KTuJFFHMcf8q5dq6sXu/JoLVxWmo2VD9XrQkRyycaWSCvnrGo08zP1ThNvns
         Vi/OF4YdHpFiVubi5s5eVV3Z+tp7XufgWm3UpyrT3D48ywRjjHxVkxlRLeVDLGD8iq6l
         eT0BDxy+V4rIgNWGquBD+7Or4bTGyLqlkPTFoh70SU+/pAr2q6ke5EjoIxKV/E5e+DWF
         nLGqhiWPS4122/6m50uKxLbXR43UbniVxcs9dvVbiuQdxW/WQXitxEDwGEmQCgwHRdqm
         F92A==
X-Forwarded-Encrypted: i=1; AFNElJ/cTkutu4O5y4cryYtUmcSX6rxcH5el4BEyS+FpSo/Hj7Ulgjfw1HcH7pgsxf+jUZ9XvCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSbcVB5uqsD+gex4s/x5VS5E0avhKZZFaj1eLPOjh69X1j+UJ
	5AwiOwCjfn2NPpF66yJU4svb1mjLVfh0SVTxtcxxSO4UkwVDQOnqGtYS
X-Gm-Gg: Acq92OEm0k5IuNDuyFbJ7B7nbXC1gl00a3ICQR96DZmatnK42uVrmuOo2o6SlIrCgnC
	w+Sw75r43f/UGx96+UgLI9zkryQHhJMRYM8XO269X/aBZhm80fshPZR7q4gdG+AoT+1ZHnMGm3j
	j364vnkTMQVyhyFoD54JUIiN58G48bDzUTIfR/JfXKGUG8kAQpmVWf/oq47ZRBa8BaL6med9PhZ
	BQmizcYONN4wIeNo/yV01r6updfHfJ9n5H124KJw2qWsEGjjCOHrI5lH/6XW11BbapJlQocJHte
	GirCQXYF1PAadRYjemezrQEVx8S3LGXThzE9H4B+FQlQpcda+PmLLizJS/zysp18puu/5K15WQm
	FakoIfucsTpHqkErf2W2aiCb8urF29IbT4XrVzoEY7K7mXRBdtILZoYstTANGlUspD/j0BfYS39
	apX5ej6GSBqvM1Ux/untwG7HuOqriiAjxdkeHb570IqxVGBwTwbkxnJC2yoqMJGi86NxpGuesrN
	UU4pcn4
X-Received: by 2002:a05:7300:b905:b0:307:d4e7:b18b with SMTP id 5a478bee46e88-3082004bd24mr2800345eec.20.1781299257770;
        Fri, 12 Jun 2026 14:20:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9497:cf9d:9fc8:debe? ([2620:10d:c090:500::1:af9e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm5492951eec.4.2026.06.12.14.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:20:57 -0700 (PDT)
Message-ID: <af16208d6852d06344235b20cc642cc6132de149.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tianci Cao
	 <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Fri, 12 Jun 2026 14:20:55 -0700
In-Reply-To: <DJ7793EEL4P5.1HFCXFENJM2VT@gmail.com>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
	 <20260612093818.18609-2-ziye@zju.edu.cn>
	 <DJ7793EEL4P5.1HFCXFENJM2VT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 09:09 -0700, Alexei Starovoitov wrote:
> On Fri Jun 12, 2026 at 2:38 AM PDT, Tianci Cao wrote:
> > Currently, the BPF verifier only allows shift operations when the shift
> > amount is a known constant. This is overly restrictive for cases where
> > the shift amount is bounded but not fully determined at verification ti=
me.
> > For example, the following code is rejected by the verifier even though
> > the shift amount is bounded to [1, 4]:
> >=20
> >     u32 shift =3D bpf_get_prandom_u32();
> >     shift &=3D 3;    // shift is in range [0, 3]
> >     shift +=3D 1;    // shift is in range [1, 4]
> >     r1 <<=3D shift;  // non-const but bounded shift amount
>=20
> Rejected? I don't believe so. The verifier accepts it, but falls
> back to conservative.

Yes, the verifier would resort to making dst register unbound.

>=20
> > Modify the shift helper functions (scalar_min_max_lsh,
> > scalar32_min_max_lsh, scalar_min_max_rsh, scalar32_min_max_rsh,
> > scalar_min_max_arsh, scalar32_min_max_arsh) to handle non-const
> > but bounded shift amounts.
> >=20
> > Update is_safe_to_compute_dst_reg_range() to remove the src_is_const
> > check for shift operations. This approach ensures the verifier
> > remains sound while allowing more programs to pass verification.
> >=20
> > Also modify the comment on is_safe_to_compute_dst_reg_range.
> > Shifts by more than insn bitness are legal in the BPF ISA; they are
> > currently implementation-defined behaviour of the underlying architectu=
re,
> > rather than UB, and have been made legal for performance reasons.
> > See: https://lore.kernel.org/bpf/20210706112502.2064236-47-sashal@kerne=
l.org
>=20
> What this is for?
> Do you see such code generated by compiler in real programs?
> Does it cause issues with accepting such _real_ programs ?
>=20
> If not, sorry, we should not complicate the verifier for theoretical case=
.

LSH/RSH code paths modifications are absolutely minimal,
I think there is no reason not to land those.
ARSH code path has more changes, but the logic is simple.
