Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AC345CAB
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185517; cv=none; b=WdnbYTr8P5xFAZMdshMBVrBxKroWokof8nKeOWZqWzG1EPnj5ITfwSeqb6wz3+9HQy4JKda2RLuT/PgGxh1+XFa08VUKHiA5YTXJgBmena6pYMtekhpWICIh6rzcK4uvb8IogfR10rseWVCu2v0DW3WxZsaYcqUSO0zgB+/bRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185517; c=relaxed/simple;
	bh=YxccSpgf8IF423Eee49SMwPPIzp2Yen9MNop+t1YlkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGVfUILWsSVTHXixPT59XVp3BtqKfJrCKQjEFL0MiJKs1oXEeD02zc+LIfwgmT/LM5dNa+ZHjk0m66Kkj31OwWQaX9x1C83x0HUFV8Ci/jtD5Wz9wRfDLsXzAaGMYL8fHszJHvZLgkZHFQAbhhOfPPXq9Wm4DLhYAApBnjoRI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkIT1aoK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkIT1aoK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b4066so6455074b3a.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784185515; x=1784790315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vybbN5RdqN1tS305lTp8ea8Ywj+fkk0pkafz6xkv/OE=;
        b=XkIT1aoKA6hIDTQApSuCXe772rrGjQ9sp7RFS6CClQ4eR62wiEtf7Gc17+RWBbQ7qs
         TEtTBh2xHrIPakZod2gpqCbDGNEWWu8s0W8j6VxOidGwwOxhnWwr9FVolSK+bYbbJDps
         oPBeY+KrI+FKrdSyUvhqJOeF3jA4fLBeS00zTqfT+0yDa5oHrNM3YwSg6EuggPeDwta+
         gXF+ZsqJsR3nV3v2s1RgISRETx2GgccEWPiMWuEtbs92ahMjRK7ZCzM2m0UVv9UaM5KN
         dEIISmA1qLW5713JtmIWFIsLaBZdDpYcvD3l1qKXmg3PL3/i9qzBVroU7rZA67/I3IbC
         tC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185515; x=1784790315;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vybbN5RdqN1tS305lTp8ea8Ywj+fkk0pkafz6xkv/OE=;
        b=PI1Brq0MF2lUlU4kTE6HcSAGktFNHKBAkQ1TGX8TJkSRhjHZ8fJAaXEiXr2B6gOquz
         dZwged82IB/Cana8vteSS3f6TcxjxQTBl5myYCXh2CYKv9saGb3FI0nmdrmGtcfzBVZ+
         /eiWSYy2K0cLDlZrf7+hU0j2jXYyzFZWTacCkBzEfaoyJO0fI/D99qa8XLR96G2fNtvl
         s7me0LZGbggXkAvVGfr0LymhptZY98ilXbCIX9F+SwJJ0fMvJIf0kylxigEgLPIrNzFK
         ymXLD3yK4VHQgvZVtLjpod9yMz7E/IlFKSpSCs2rVHJZprLnrewp7mRpyPyjvcYOBwkv
         TA/w==
X-Forwarded-Encrypted: i=1; AHgh+RqUNtQZPoXUlvyxITl4tyCFkFpG47HYX5P4Fx+qQo2PxqAaTETzigdbWvycXM1XH76Fqvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWwPDuYmAP6R1b/o37S1qNdJZwn2fzoldjjgOvf9sRW9JoeEn
	jN6KZBeVDMgrz8Eo/J6yZLCTPV3GVfHPwukF5T4r131ETz7Tbcd6eTag
X-Gm-Gg: AfdE7cmq2YTnjupVABUMlrUwIDc5ryOyfbCoOyUzYJLzsqOe1dthXxAUZ2cpwPiZsZm
	aXL9H63Q38GL2caRCSQ2+g45Dof624u1iwb4hqgl2HolfSUWdiaM9onuKF2ranWniS4g3qrjrD0
	mSB6vNbWu+vPwdTasjs3AhAJIl/y2bcK2PH7dO9AczCYBgMo83bRHepL6mUO+OX1sZ83lkw12F7
	8FHrJv7AcB8wcDu+B5eRTcIu9vKJnb0Ts4kGpazWvJPPw/gcMVbUpXLz6aSZ97yClBrnwMsqThC
	fVEv3lStpPFBqntfUeO5RYww0NOn0I/EUxPfVtLD88oQJDUNROObRxXdYZ3t8ze2Zvsc8sImH65
	gYkF+OsczRgsE2xIKpFTTs8Z5Z+FCbamb6NfIxnZo+TCeaANnl5L6adR7H27YK7iXRPljCnri59
	MZbsHjHxdGJX2nh6Y+nXqIOExlpH8P5f75EC93d9L15g==
X-Received: by 2002:aa7:8891:0:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-84a671da62amr5266688b3a.8.1784185515408;
        Thu, 16 Jul 2026 00:05:15 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7ea31csm4449320b3a.51.2026.07.16.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:05:15 -0700 (PDT)
Message-ID: <a1c91da1139d4954638013a0577bfcbaef25be03.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event log
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 16 Jul 2026 00:05:12 -0700
In-Reply-To: <f7655f0cc9181ea102fa9405ceba96a3ae0faa01.camel@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
		 <20260713153910.2556007-4-memxor@gmail.com>
	 <f7655f0cc9181ea102fa9405ceba96a3ae0faa01.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 14:22 -0700, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> > +static void diag_print_history(struct bpf_verifier_env *env)
> > +{
> > +	const struct bpf_diag_history_event *event;
> > +	const struct bpf_diag_log *log;
> > +	bool printed =3D false;
> > +	u32 i;
> > +
> > +	diag_report_section(env, "Causal path");
> > +
> > +	if (!env->diag) {
> > +		diag_write(env, "=C2=A0 no recorded diagnostic events on this path\n=
");
> > +		return;
> > +	}
> > +	log =3D &env->diag->log;
> > +
> > +	for (i =3D 0; i < log->cnt; i++) {
>              ^^^^^
> As far as I understand, when the complete patch-set is applied
> the start index for branch history events is zero as well.
> Do we want to cap the amount of printed events by e.g. 10/50/100
> or some reasonable amount?

So, I was curious how performant the current version is, so I added
[1] as a stress test and used 'veristat -vl7 pyperf600.bpf.o' as
guinea pig. Conclusion is that printing all accumulated events is very
slow, 6s to collect level 2 log on master vs ~5m with this patch-set.
Perf report is obvious in a hindsight:

  -   35.50%  veristat  [kernel.kallsyms]     [k] strrchr
     - strrchr
        - 35.49% bpf_get_linfo_source
           - bpf_diag_report_source
              + 35.49% diag_print_history
  -   20.77%  veristat  [kernel.kallsyms]     [k] bpf_get_linfo_source
       bpf_get_linfo_source
     - bpf_diag_report_source
        + 20.77% diag_print_history
  -   17.80%  veristat  [kernel.kallsyms]     [k] bpf_diag_report_source
     - bpf_diag_report_source
        + 17.80% diag_print_history
  +    5.58%  veristat  [kernel.kallsyms]     [k] btf_name_by_offset
  +    2.75%  veristat  [kernel.kallsyms]     [k] x86_pmu_enable_event

So we either need to limit the amount of events printed or work on
more efficient algorithm for source line search (build a whole index
in one go?) / cashing.

[1] https://github.com/kernel-patches/bpf/commit/99c06ed1d51826dbfdba115c71=
fc691696bfcbac

> > +		event =3D diag_history_event(log, i);
> > +
> > +		switch (event->kind) {
> > +		case BPF_DIAG_HISTORY_BRANCH:
> > +			if (printed)
> > +				diag_write(env, "\n");
> > +			bpf_diag_report_source(env, event->insn_idx, "branch",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "took the %s branch of this =
conditional, goto %s",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event->branch.cond_true ? "t=
rue" : "false",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event->branch.cond_true ? "f=
ollowed" : "not followed");
> > +			printed =3D true;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!printed)
> > +		diag_write(env, "=C2=A0 no retained diagnostic events on this path\n=
");
> > +}

...
