Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDC547065
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790411217; cv=none; b=I1CkwxQ3PD2DX6UVX6ONgrZP1LBVy1dyW0IJK2Ppd3wT+YvDrmo8IpKOwR1RYaoKrHHeCGGqP+v8fhagC2ayfCXh2IAtPhnJXQhuUDcOUOXH/5Afzvvj6m4COHThAA595n2snrcQWCC6ZFRd/1oqDGvoIYcaFu7BgczxDFF7fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790411217; c=relaxed/simple;
	bh=2tnKbYyZTIkI65hMsVeO8XZnhw6cgLrA0JnfbWvGs/E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=nhyL8nWVjJ8lGVlWVbLO4X9GkIAEOpQ/zPLGeoO19jEt/5bRsucJmIHZeLbKUl9nDZX4hZGvL/TfvXncvg/f+eUAz2vXX0/x5QYT/9qCsVBjsaAyhu40R4qTd2rLOYgeYnSujdswPA+VY/0MsUxUd6+qFHHLY9786B7Cm7GenRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/MXVEvB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/MXVEvB"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso994821a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790411215; x=1791016015; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kl5c3EV3m/3egQZRktK1TEd319cfO9itDW8TGp8Nv0=;
        b=L/MXVEvBOoS1d7FhDsYQIDqfmqxfPIfiP//UzPPsl/3oigvHfNfxYy8YwsbDEjAAgk
         HIQ0Uvrfgls82/7wxIMMh6MPvRQQcBSdBjU7B31/W2SrRmvvePAHhldbfhSX8M+dxvTn
         qtdXrjdZtQZJHOhUG8G85iZU+q0WudBfKvwDi8XtkZGL70AquFxXrGRt1q331pE6r3Su
         GaT1KxxFqRg8sYW2EHXYFg7+nwIpkHXM8FSAqirePPMaH5WolEGzlAsw/V8uMjAvZPFc
         eLYH8TZPcryLjKSAgR1o9i4sVir4PDSP3ASXJhDVusmpEAyb6B+PHKKkaYXomrTuC5fH
         mC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790411215; x=1791016015;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kl5c3EV3m/3egQZRktK1TEd319cfO9itDW8TGp8Nv0=;
        b=QWgG+B/ATGXjcE5bFkB1Xsem3yfoWMbKjak6ppTzrZXvaEOBAIy/YKEpQq1OdoaOJ3
         q5oUagLxgSrwNaORjmV134omPFYr1KFu+mOnUV2L52aj+PJv3v7ip+sXyDdutwzmWLXW
         CkWJhlsjhcnvL4OfPnm0/QK5ExTNDwNX0xniXi7WbPB3M1Rw2CT3yEUBl0EEafWGFRQY
         7mgMAFtbFWKVrbO7dHRPpftC3IstFTJXp/RpiQJjRk0/y2YQI3C4uiUSbp9yPLpOCp92
         Mek3aNCKCt26+sTZF7XF/VXl/1L4Ffiw78Lr86aFv6MVmvZ4K2Z8Omotc4bFUv9lRT0c
         EHuw==
X-Forwarded-Encrypted: i=1; AKwUvBw6qiZzx7X6eDO35WRsLU0/S7nS/IJdl0UHYHtYpPdmCatAgRnF+4R6mIUl2CuuI3cyp7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7dmSDJbElXhy2on7GCFUH4R4/bOPzbZN1B6jo4ooLzvSrLdw+
	IBboqdi4xzjSG5fFRTebhgd/9+xlyfo5vwcIh24hCbBkN8M7UJtgT4fS
X-Gm-Gg: AYBFou3OlSIEohL+Rv1jLcneR2/YIEWaCZPNUDpaydGsjJyhHKvUof9bqP8ceEDPUeg
	AnCd/6+hlbtK6ifSKKT2+oXDnP7aMu11vcxEgBOzyeVFmCSgHyQ4h/UrmjqL5UkiynqPqzKqKyj
	qQOWp76kLaXODdXkHrFo7NDiyp5DZjAvisl+XV/DTyzdy1cSKgc7g3qZ8WcjK+RgOMMgyBFS6ah
	7U2sfDjTef/uNL9qhpgekz58kXc1ByakGxBJT7CDYbBPSoORWb+OIcxJMsy+NAvIIK28LskP8Ys
	ep7cuLDhpm9v2huQPuJYDaWwq///a9zxgXTVjai92Snn8QCeyByWDnI86GpVLgmt/E97q8ytIgw
	paYT96geNJuv8MnCn5SFK8JGv8Dn1g84PebgM3f1SS//qNq73m5FghLL6KGEP9mDhllIuvbbxJF
	7P5fMQBox4zYjpD0XLhkRz6X0vuddq3IJuHhHbuLxxYsy/hgVP0BSgCvLGSHymDUSMSMvUSI2FX
	FJ/awyt1dZkWcFyz0b4Dea6RWFBCFcNSU1OOnMrxMUlV0re4SwFa/RtLVsi2ciAMviDYKLb1AVX
	uVOM
X-Received: by 2002:a17:90b:384c:b0:39e:5acb:2849 with SMTP id 98e67ed59e1d1-3a0bb576e5cmr4009103a91.17.1790411215417;
        Sat, 26 Sep 2026 01:26:55 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91409040sm20430045ad.41.2026.09.26.01.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:26:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:26:53 +0000
Message-Id: <DLP3T0UY2CTZ.1MF50P0C32UU2@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 6/7] bpf: Support call-site kfunc
 specialization for far calls
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260925233538.5708-7-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com> <20260925233538.5708-7-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 11:35 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> -	ret = sort_kfunc_descs_by_imm_off(env);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Do not change kfunc desc position into the table for far JIT.
> +	 * because we use the indices in the instructions.
> +	 */
> +	if (bpf_jit_supports_far_kfunc_call())
> +		return 0;
>
> -	return 0;
> +	return sort_kfunc_descs_by_imm_off(env);

can we store the index in insn->off for near calls too ?
Near call JITs take the address from insn->imm and need only
func_model from the desc.
Then all JITs do the same lookup in bpf_jit_find_kfunc_model()
and no need for sort_kfunc_descs_by_imm_off(), desc->imm and bsearch.

as you mentioned in the other thread pls target bpf-next.
We're too far into -rc to do such large changes in bpf tree.

pw-bot: cr

