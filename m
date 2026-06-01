Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9932ED27
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290756; cv=none; b=MXrX13h73TNy54OoOQF8bbx8lNzuVQydoIxQNJwwi/N8bGllk4WIxhurbDAf09FibJytAB72BUvshbBK6BoHuvWAmxR3M5WgeA2yv8/RrZ/vqmCeKVFzolq2SN1gnyq11IOML0fjS7l/K3fQ1KQfvVwZTnzJTO2MwnY9c7GgkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290756; c=relaxed/simple;
	bh=XmhDK51YRFElty/rO3pIPdGXO+f8DTlNcu/OqQ7qtfM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bgI6Jhkn0g8QiYIUA0h907KFU9FNj9/sZk5LALBrTX5v7s+9oX1j0OIpRyaBT25T68unDsmZ9qyto4SG/87Sr+GmqfS7VmZrSvQzwIZ2EPGSu7YTMTcOkiy8ctmLRMm6bpXlJNis68eIaz4m/TJRrj7GUVLCR9/SPpMbsKe0ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SFTQ+qDR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SFTQ+qDR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1581427a91.3
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780290754; x=1780895554; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1zbtsLwxCk4NWx2zYKtuqmwSI4YMlF09y9CSbk+dJ0=;
        b=SFTQ+qDRTivJkR5vC8STSJNhXj0GezNpFBGYhuIA2eWJKDVWm0E/CtkczyLB57oyo/
         1pHSXJHLCPLm6HjDOACKEnOyDdK1rl+/dt0ThteNGcsIrtHXLuQ3JtqmwDp1DKrUXI88
         5T7/cpolefd+bzauX6LSEoFjTA1qnLZZfxcJ33Q2I3xdtkcE7433tAwBSlQLmYQcJEMX
         jHhXUH/f4XfTicgDp1uEgsqnPZy2n9P8jy+AtHtiacD2jHpcy6+91XPSw8XuJriY/eYI
         LE70PoL/WfiVAdiMGeFOSO0hu4wYSNp2jYYZyXhF+NEY7BQ0p4qrnC8MciUxxVc531Kq
         dLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780290754; x=1780895554;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1zbtsLwxCk4NWx2zYKtuqmwSI4YMlF09y9CSbk+dJ0=;
        b=PNH+JmMuATS7bGDRorfoWpTkcSSo5dzX1giC59XNegRlSYx+Dr1lJx4SnZUKd7bW+z
         gvh2q1ZyexWejy2HUgi9T0TsnnTrDtr1I5gCnhHvvPkkwuRB05pqgv/cuD27afveM68b
         JbpGNqZMo1In1fbHRlOb0EG/DqX8Zcxta4hcTa352K07Ku3O1DkOV+Iscgl+7kWODCdm
         rYscmNBKVOBGooQgOfIiUs+gTC2ofiL2ika60z1WQbl1ZKHTds5cru+RbTDxqaMSJpfs
         JbmmflWrDxCHhgiu8QHYVad+uyLczYmOpPfLOWtVuUeAfy9e5Ls37Hsog3j5MqHuy0mG
         25Mw==
X-Gm-Message-State: AOJu0YwHVa/UFOR34R+/YFhTFdqX4hr46zlMUpKk3ONyzfR+k7CrX16S
	5ZNY0OsqchcICrEAPh4rdMVc0Tg3cndl/rl7RW1ULmpplbC302kQBP7HJ/B2ST1jX80=
X-Gm-Gg: Acq92OHIGgM/PTL43MpVP+uBSk5NiEIrCU5ly1brdUDPlSnj2MTT+w4mUWRXGtfGCk9
	kO1nSiOspo+b9TZTFOJDsOmrfTR52vqH6C7EG6xobcd2XtuluXuUBq92xND2zBC1cW9y3K2EVqX
	FxniJjXtDhC4Phexf93E74Y608HtYRnaqG2AmFiogIA7i03URWDvdHy0z75G8aai5SPf7GTwrxH
	fIGLWuvnsPobNOQxXAjs2NXlMwUrcAk+k9kzZSMrUNhd2At7I4YA6h7Dr5fIIZUAmA+96xGt2LE
	D/HFn8rkZKTgysa2ywVp+FY+O8++8kk8lz8eG7u42n2z43S0yW0SG4HKn1by77AjWEs4VgVf3zs
	dWdeRyoOhKAXz/j6v7MnURodRQavZg437oj3PvvSdlyT6lwlaFlFmZDcy8Jt8cW1B9UGwnPqp/K
	c60Ea9Cltri5r2Ge5EwC7oXZsG7MPlDnXVQlk=
X-Received: by 2002:a17:90b:2ec3:b0:369:223a:cb60 with SMTP id 98e67ed59e1d1-36c4ff277femr8565583a91.8.1780290753925;
        Sun, 31 May 2026 22:12:33 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc971c8sm9240159a91.3.2026.05.31.22.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:12:32 -0400
Message-Id: <DIXGEH7ZJMH5.1QKUUBCNKPVID@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for
 function arguments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530002259.4505-3-emil@etsalapatis.com>
 <20260530005922.90CEE1F00893@smtp.kernel.org>
In-Reply-To: <20260530005922.90CEE1F00893@smtp.kernel.org>

On Fri May 29, 2026 at 8:59 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] btf_scan_type_tags incorrectly rejects valid BPF programs contai=
ning unrecognized type tags (e.g., __user, __rcu) by returning -EOPNOTSUPP.
> - [High] btf_scan_type_tags fails to discover valid type tags if they are=
 separated from the pointer by other BTF modifiers (like CONST, VOLATILE, o=
r TYPEDEF).
> --
>
> commit c938604636d812339744a9ba91c4659c3d79392c
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> verifier: parse BTF type tags for function arguments
>
> This patch extracts BTF decl tag parsing into a new function and
> introduces type tag parsing for function arguments, specifically
> looking for the arena type tag on pointers.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 17d4ab0a82068..c6a930aca67ec 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>
> [ ... ]
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
>> +
>> +	/* We got a pointer, get all associated type tags. */
>> +	t =3D btf_type_by_id(btf, t->type);
>> +	while (t && btf_type_is_type_tag(t)) {
>
> [Severity: High]
> Does this loop terminate prematurely if the type tag is preceded by other
> modifiers like CONST, VOLATILE, or TYPEDEF?
>
> If the target type of the pointer is structured as:
> PTR -> CONST -> TYPE_TAG("arena") -> INT
>
> It appears btf_type_is_type_tag(t) would evaluate to false at the CONST
> modifier, causing the loop to exit and valid arena tags to be missed
> entirely.
>

Fair point, we can make the loop continue until it finds either a base
type or a pointer type.

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
>
> [Severity: High]
> Will this unconditionally reject valid BPF programs that contain
> unrecognized type tags like __user or __rcu?
>
> Prior to this change, standard kernel type tags on pointer arguments were
> naturally skipped by the verifier. Returning -EOPNOTSUPP here for anythin=
g
> other than arena seems like it might cause a backward compatibility
> regression for existing global subprograms that accept standard tagged
> pointers.
>

Right now imo we don't want global BPF subprogs to be able to return those
variable types in the first place. We can expand this if we ever do.

>> +
>> +		t =3D btf_type_by_id(btf, t->type);
>> +	}
>> +
>> +	return 0;
>> +}

