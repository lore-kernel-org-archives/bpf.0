Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B7346AED
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341221; cv=none; b=owGIu+VWBmJNlbDAipZdro7vag5QhRm7tzBFw+IrDsmFC5v1MyDxMnj3WT0qPeKvDcXuhpGhQf6srzDFKdfLTmBDIdZ88ojiqb4zKDidXXKFVx7sj9uLbH5qdC1ecTeBtGQOuDfet3jrlNCUzO0wjdF7FjvxWakQez6iSi1Zj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341221; c=relaxed/simple;
	bh=b/oQFc9cen+QD9tnn9AzxoZw4AWU1nKnvUVYrJenlxQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Fq9LHp7Bivi8HVwh04jon0R+X8KKhhesZutK3XQjS52BAfK2wXWcgt2NBgH+A/N82NHUdOLd5xUlGOSNfeHOxowmjik6e+d5UcYzYtOweBF0o8fv7NBtXLf31M7PCXZKgfsQUiUhlLUvDsZdGOUE9tPS1r5742x3bgPwP+xRvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bYW480zi; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bYW480zi"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304df7ff4c2so2622279eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780341219; x=1780946019; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM7fHPr6ak0xbayPzafp3WlCnB6iQgavoFEmzG1myJ4=;
        b=bYW480zi2HLHxqPJyI8B4DVKuK8vbhCv/dG8T8J5VnKVP27ZAkHIJdBA7an/1ikOAG
         dSyHwB0nhGrO2CzXVx+gqGLEzDMmbG5p8ea1TwwatbZPipnLj5ynGnyLPtrAva6c3xIr
         Tiaf2PnCF5QoICTtE3psYd7B7PR3oVi4Wkc4cBDeJYZC5D80ZZHiQBSrkqIjsrPiJ0qc
         Ao1hxm78D2Co0IB/j+jGTX/1Jbd8XGxELMlCe5iEtdopZ9BsEGt3k11D4PAPNqNhPoWX
         MKs0tbY+PY1FXyBwVvQYmCGovojyXlcx2k1UMzNYndOEhIQpcl0ZN+a+FlZ5+vv52YC+
         ECIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341219; x=1780946019;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xM7fHPr6ak0xbayPzafp3WlCnB6iQgavoFEmzG1myJ4=;
        b=bjf+xD9m3IOTQfQ4bwfasHCMPttOIgMstQ6rHy+t+qbAoKCriuDxkKoyEfZZ5vu9EL
         leLGoMJ1NvPiRUXFTdTJ5kG348hC3bVA3jUHgUiqxXZws75O59dQTOJQwUL7Fefa2llN
         CfhAy+DtZGDo/UqM+XF0s+16c3SZUXKxHFOoMzCULGIRa5jn052VZdgOs/O1gPXdMRJb
         8bpJAHx4riETSGJgDeZh/xH1lNcbX7CkSnwSjD6uP1oZul/UqQg1PavUiGQSTh8l21zV
         Pe8/gtsyysaSl6QwKAjUThQLNdZBcBG5dzBbKffOVKyjUF3uT+WEFiUvZZKyr46V/D4h
         L6PA==
X-Forwarded-Encrypted: i=1; AFNElJ9E9dGJAy45FSCdpTt50OZ+zB/oxzAmYPAI68ALf86wEaQ7bzZVeu6xLlwEJQnLPpn5XeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazhYxoSJ3lY1gCGNeM/Zw/KluROMtgQMGV9JAgDxPW2uGre4C
	d8WLoXxt7m1PmUUUDDQQtEdW4d+bLBSlA92V13RLkOAN3KQoj/v6MQ3utdcQxstDaqw=
X-Gm-Gg: Acq92OHLm9/SI+QS5vClgqC538Z9T3IfdoM2wcm78CPTBxU4o7cwgVecJMMyoz1yXge
	F8dCAfGgrLaVJqB2WNEuuTprrowpagxhPDzT3FuS/aEew2uuuLXM+w8yNopcVUy5SuOY2vmRW8p
	9eJxV6Y4y9unJfYoCAFMueWTNB+VS4TkztQEzz9dOePJ1Xb49oQrWMv+1zgPHmnpoEtXBiJMw09
	yjZ9+w7+FUBQP7KoKLL+qxWcnxDnWnIlbNPshqrZ+ImFQ+AVK4TMqLYv9LauPtcgTG2yk4/+px+
	HGZzgfI4/tmn2AFf9fIP3bcjlWXFfBhbfd087SLUAfQQBHvsD2hEKl3g2HN4PORU7Odx+VrzYFl
	ljME3ejZBZlkTXxtDhR1w+nxIjqlSce5m+vJbSsoB/oW8wFjyn27g3ge7CJu+n1pv/iUmrPOd1W
	wKAjNlcg4/B0i6zLA=
X-Received: by 2002:a05:693c:23c5:b0:304:56fc:775 with SMTP id 5a478bee46e88-30734c8e1e9mr410028eec.21.1780341219194;
        Mon, 01 Jun 2026 12:13:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::649e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm9512928eec.28.2026.06.01.12.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:13:35 -0400
Message-Id: <DIXYAFJ6YV2V.UD8C8J22GA5O@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <song@kernel.org>, <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for
 function arguments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530002259.4505-1-emil@etsalapatis.com>
 <20260530002259.4505-3-emil@etsalapatis.com>
 <e1a40461fa792dc7687b0029f3ede546eeeacbc9.camel@gmail.com>
In-Reply-To: <e1a40461fa792dc7687b0029f3ede546eeeacbc9.camel@gmail.com>

On Mon Jun 1, 2026 at 2:37 PM EDT, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
>> The BTF parsing logic for function arguments goes through
>> the arguments' decl tags, but does not go into their type
>> tags. Add type tag parsing for function arguments.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> +static int btf_scan_type_tags(struct bpf_verifier_env *env,
>> +			      const struct btf *btf, u32 type_id,
>> +			      u32 *tags)
>> +{
>> +	const struct btf_type *t;
>> +
>> +	/* Find the first pointer type in the chain. */
>> +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
>> +	if (!t || !btf_type_is_ptr(t))
>> +		return 0;
>
> Nit: do we want to report -EOPNOTSUPP if type tag is attached to a non-po=
inter type?
>

Let's do that. Since compilers can't really produce that yet that would
only be the case for handcrafted BTF, right?

>> +
>> +	/* We got a pointer, get all associated type tags. */
>> +	t =3D btf_type_by_id(btf, t->type);
>> +	while (t && btf_type_is_type_tag(t)) {
>> +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
>> +
>> +		if (strcmp(tag, "arena") =3D=3D 0) {
>> +			*tags |=3D ARG_TAG_ARENA;
>> +		} else {
>> +			bpf_log(&env->log, "function signature member has unsupported type t=
ag '%s'\n",
>> +				tag);
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		t =3D btf_type_by_id(btf, t->type);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
> [...]

