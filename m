Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386439D6E6
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547440; cv=none; b=Fs+knVB7VSbilH8kEYdP8js1pg1AKcdgNMXMnNHJodc3hVrjDA7ZC0ka8Z/bKRM+ltOl+NmV9/12vHC3aNkYfjk4gZshL6P+uS897yzdezVfC5pvkeuZQTxbwgy/Lk8UfpgtxAocbrWMtbatYrAKtSL6nEtS/WkHCQVREn1GKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547440; c=relaxed/simple;
	bh=I+0fePEzc3bnUfym57MR2ztNzvaeE4chK7MaaNgInW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oid3CYI/826lDzqihbmcTTsCeqy0rcZWVes3fTNn9lv1JI4Xbh7dHMJ4E7t1baIk+AybzR6/q2kVsimHPEGpLRCXfScbs4xUPAXluOGgqF0Ly6Rz7371Pw7XPTZFo//KVWCFCGFr3VBzp4hORKhCRNYOvAiSOqC0E25awdLI3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYYRv/Vd; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYYRv/Vd"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so3045469c88.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774547433; x=1775152233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pl42/Gd9/Pw+WzRCOUav9ogA/QWeynETYrCnr2DkgpA=;
        b=pYYRv/Vdk+0vs0tbV21tzsWOsqZ85aRGFulCRi2z0awpjtpr/klDCncnJhF317btUF
         DxJmKB15sXzSQAd2xBG5NDmAtf2LbS3QC4I5qXZHyhkiK3Q/zEwGpcr1QFzprGtCef6r
         prl5aZWiRuL0vmjF6e2gSh0eXpg25wuh8qjTaVdhbnxO5YijqY7WVtNSEjICMK5RlhsD
         nm1D9bUy2nTEZph+CqVoSeahHLw45u6ie15PYYSBs0EUqvd1EA9WNagt0wHlbLAUEhZU
         lJVABjffQ7iUYWxCz5nwMYa+a4DFZ7lHrJ0hqc2Y0eG4dInN2SlsN0s+72DDSTSBv2Ms
         wbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547433; x=1775152233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl42/Gd9/Pw+WzRCOUav9ogA/QWeynETYrCnr2DkgpA=;
        b=LByBTTMt3Rhf2/u25q276ISAejgP7tfIXxRIHljQxi60GKQb7K1UlaQ1hjgp9pnjYf
         5U2cPX4Em0Hwd0XYS7RFj329vkqI1IsC9D7Q+jY6axICipKiFsgWtoQ5jqNt25CbRY5G
         dJ01A1QnOdT+Hf8/TUGRQTlWh9n0HE4wyAq6yDSEICz1rvrAIobR+jFiXRGbJD3DnPtw
         Wqz6CoPFjqAuZ3aw0dJELQac92mfijCb4nfe9l7cy0yi35cVwQYQ+AmyUPecgaWz5J8F
         sX2327rc2jdqkwZ8n1YpKeZ5FmoQZ3BeRvpcLeDI02KgZOk48tere+C66MtGGVqDkLPn
         lSCA==
X-Gm-Message-State: AOJu0YyEAYF4eXrUudT1b7LHU2gFpABx3Tg5nAZqN46zrpfNseTUrOC1
	VJ1+M9vL+W9vRfCxxDP7yRvik2jQ+Btwkbsd3BEkMTq52q13Q/07oM77
X-Gm-Gg: ATEYQzzbmpxL79/L2yJh612NTbhA3hU57E9mSdEiqOV/r84kj/Jx/IY+kIEaugr8Bis
	1eweRQoLUxbmOVr4EnRob7RIrg8qzBcfQDj8Ki4hmvyHdUhwJVL2Ad56522zDg/LVD/8R4Bt3Vp
	i3q1HhHKKcrcAgO0aNpkHuLdrONuRhkWlCMTeLyHzPn67UEdaueGsyDbpaUPq/zgrPwIADV0Wij
	w7uO53GZYr/Y14/G8ILq9EgjdplZFpkkSNXH8E4hxGmCYXd24zifS48zZosKD8x6WAfWZbCt3DW
	VztwAciGUWF9bL1vA5cmzGJqkpfPqDOduUKbveHVwTHBGMUu1iUWqkaKS786Z7FjNbzJEfG9qkA
	nJUgPkbBQj2UppTiIOCUll+1qh4SFA7knzDR8vdKZ25gPsr/uR0WJ87/yXkNZYQApFmSOKnjFZQ
	qYaZwrbepOfKEoPV7/AsNmAIcIPNhDnolp6q43BpeiLcoNZGejC3wlgZdh0mfEA6ptDX5vsCxbD
	BHDlmzLTB3NM2PK8s0=
X-Received: by 2002:a05:7022:e09:b0:12a:6fb7:87e3 with SMTP id a92af1059eb24-12a96eeb13cmr5180727c88.31.1774547433291;
        Thu, 26 Mar 2026 10:50:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4a82:c020:f551:481c? ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7827e02sm4926684c88.12.2026.03.26.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:50:32 -0700 (PDT)
Message-ID: <69e94f86bf1d620b92b4128c0205ec0e29327d8e.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: implement __reg_deduce_bounds()
 using wrapped intervals
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com
Date: Thu, 26 Mar 2026 10:50:31 -0700
In-Reply-To: <qfwof7nyxz2amrzbjxolhc7m2nvzzqpnwglafk4tuetdyuiixu@tlbntm5jgswg>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
	 <qfwof7nyxz2amrzbjxolhc7m2nvzzqpnwglafk4tuetdyuiixu@tlbntm5jgswg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 12:25 +0800, Shung-Hsi Yu wrote:
> On Wed, Mar 18, 2026 at 09:28:57AM -0700, Eduard Zingerman wrote:
> > Use wrapped intervals representation [1] to express range-based
> > deductions. Such representation allows to express these deductions in
> > a more mathematically rigorous way:
> > - {32,64}-bit signed -> unsigned, unsigned -> signed deduction infers
> >   improved bounds from an intersection of signed and unsigned arcs.
> > - 32-bit -> 64-bit and 32-bit -> 64 bit deduction infer improved
> >   bounds from projections of 32-bit arcs onto 64-bit space and
> >   vice-versa.
> >=20
> > Reformulating 32-bit -> 64-bit deduction in such terms allowed to find
> > two cases currently not handled by deduce_bounds_64_from_32().
> > See patch #3 for details.
> >=20
> > This RFC argues that wrapped interval based implementation for
> > __reg_deduce_bounds() is easier to understand and maintain.
> > An alternative to this RFC would be to update
> > deduce_bounds_64_from_32() in a same way patch #3 modifies
> > reg_bounds.c selftest, in order to handle newly identified cases.
>=20
> I think introducing wrapper interval for purpose of improving &
> simplification of __reg_deduce_bounds() alone might not be enough. That
> said, I still want to push wrapper interval integration forward, but
> that will be addressed in a separate follow-up email.
>=20
> If I understand it right, the newly identified case in patch #4 is not
> something we encounter from compiler-generated BPF program (yet), and
> thus not something that is needed currently, either this or the
> alternative to update deduce_bounds_64_from_32() in a same way patch #3.
>=20
> On the other hand, I do like the much cleaner code as well as better
> modularity for reuse, and being more mistake-proof.
>=20
> For a more objective metric, I gauged at the difference in terms of
> cognitive complexity (which penalize nested conditional more compared to
> cyclomatic complexity) through clang-tidy, and do find supporting
> evidence:
>=20
>   Before this patchset, congitive complexity is 88
>=20
>     'deduce_bounds_32_from_64' has cognitive complexity of 42
>     'deduce_bounds_32_from_32' has cognitive complexity of 20
>     'deduce_bounds_64_from_64' has cognitive complexity of 20
>     'deduce_bounds_64_from_32' has cognitive complexity of 6
>=20
>   After this patchset, cognitive complexity is 49
>=20
>     'cnum32_from_cnum64' has cognitive complexity of 2
>     'cnum64_cnum32_intersect' has cognitive complexity of 13
>     'cnumT_umin' has cognitive complexity of 1
>     'cnumT_srange_overflow' has cognitive complexity of 1
>     'cnumT_intersect' has cognitive complexity of 17
>     'cnum_update_reg32_bounds' has cognitive complexity of 4
>     'cnum_update_reg64_bounds' has cognitive complexity of 4
>     'deduce_bounds_32_from_64' has cognitive complexity of 1
>     'deduce_bounds_32_from_32' has cognitive complexity of 1
>     'deduce_bounds_64_from_64' has cognitive complexity of 1
>     'deduce_bounds_64_from_32' has cognitive complexity of 4
>=20
> So there is indeed a net reduction of 41 (~46%) in terms of complexity
> score. Supporting the easier to maintain claim, too.
>=20
> That said, we do pay some price as cnum is more mind bending and not as
> straightforward to grasp. Cognitive complexity cannot factor in the
> background knowledge required.
>=20
> I do think there are more reason to push cnum/wrapped interval forward
> beyond using it __reg_deduce_bounds though. Will try to write a
> follow-up to this email.

Hi Shung-Hsi,

Thank you for taking a look.  I have a work-in-progress branch [1]
which implements union and multiplication operators for wrapped intervals d=
omain.
I'll plug it into the verifier and share the results in this thread.

Thanks,
Eduard

[1] https://github.com/eddyz87/cnum-verif/tree/arithm-ops
