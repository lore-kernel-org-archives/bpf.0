Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301D3BCD25
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316142; cv=none; b=BdCMn0udy37v9SGP0s2wcC6eE6jdG9zX0QcRuVtWclVm2X5udxUIDB79irx4OQ2687xQw14ArUxhJ8OygVGmApB2eBJZjd5ymoD3/IXx5ZCFRanfaqN4SH+/5yGS4KMHDnWAD5Bv/D97CiCiQ2B2A/NGkB+dsDeCL26nJFv7vqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316142; c=relaxed/simple;
	bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAufW8ySm1XVSjNM6w9QmiFI5IIokYMBdJzTqzth6dRf7EyYTyKvzF2fPtOF2kab6vhgT6aiC2l5dGU5KWvdZLtEXulX5UQQuBNYFOAhqGIhxOA2XGLMS7E5syMZ0yiDbLkwRDtSg2H3SuhvNCj3rK74B++hateyOW6BIDdu+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/rFfpOD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/rFfpOD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365eecc5885so4994314a91.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316140; x=1779920940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
        b=X/rFfpOD/Hdne94jgS821ojiAZdF3B9vqDVu1WFjcV5RySIMgk9VMFur6jbg6EdEx8
         idtgNVSSlK1qHMDCp5WBIyrUXktd6agCJ+ExpAkN0GLprvVXnPIV6/aniec14SiVcPZM
         7gsTSi5s/iUiAntEybp7UAr2TtkiNgmqhCuyHy7kGN91yYRQzisNVX/Mwb0FwpgA2Rch
         qwvkjKKLK/vgzfWR/mSiYcCUBY8uEa0adeIS2ExUfgnticA7dPngooqP07RNm3vUztka
         mXMyFnZQzQHacpWW0/Rb9XWEo/N8bN1JIiEIlrU/ZssCjFB8xTe3bpx4asr2WTsieU7y
         vsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316140; x=1779920940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
        b=qEvA8asTqEJ94n1dHFU2Kni+55+k1p2xGc1AD1+NPjo/vnaeCMOAQbR2ew96Xl2rbW
         rFj738S+xAdY618ezTnEpxo24DnwAT/0NlhsG6QWvg13u0kOMAHbwXqoY72vKyid14Gk
         9+fnOosA+EDGdGehD5X7FT9uNSUDbIWlyrfoF3kLGRNCBGTu45n8dTHCtaQgt1F0tK6P
         Dc5RU54zd+ucwch4o2UkSd49ABI644Q+efFQEKzmzE8DhDsv4qdTWvVQEW9BzbDUE85p
         j6NfaAvKxE7IbPjTcumLqfuS+APf1VISkJxDxS5UJIghwYAN1NNVqQ+ze14sbGaF7dVw
         +SHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3Ksj0/iIcKdjfihWiTiJ8mt66wJwlnM3aYGUDMqwy8vmCZIPdUbCk7+NIvH9Dn8axp0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywexb+F7dqJa1qVZpHjUDGI7Q40g2AYtmCtW1p1+jMCocnaHF9k
	Ue1XbQCKdcXGarflHT2dwe1jGAPxtewZktnd6KIa/KpUzIggL7vVrK7P
X-Gm-Gg: Acq92OEXfF7uq/B2zsFmQDHq0KZt8rSGEklrYROBH9xNcbMeG3K3olkw13lLFNammSY
	7wwgyv1d9g7SlxRzMOOlFhdQkCvyIQr8VITwwdpOUFbUfgdfPTGSxolyZvwpT9dUFyX+XMSy57c
	DC4J+YS+ZqykJJLACZEZvlKQ+GgNt6bpSFOpwOmudEQ2TKGWqGBP1CbxKIqdMoSrl6NjJe0BdyU
	c3VMVKPUAhmt5uC/IKcDf9om7Z9BBiJlkJlEk+D6QbsCffFQV1Eh7p7ApZncYRY8uWckA5rTktk
	QWTnvw8ULAxChNyiwmLdwSPKq4DWX5AfbjibdKT1di3UzgqQ6J9SLWmIKSMhhmXgyOetir3sg7j
	N7VVQ0RDZFKR2w+SebH4qgpqej3xN0BCVtwuZe5Dep2p7whGnccuUEnKlHNXdb/AKo9XHGMGvLQ
	ZHseHYflz0GLQk4mBUCVYtAPbOPeOMzrGsCiTzHhNWJSQOqM4FoBhi
X-Received: by 2002:a17:90b:2583:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-36a4388a6bemr455068a91.0.1779316139964;
        Wed, 20 May 2026 15:28:59 -0700 (PDT)
Received: from [192.168.0.161] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc88b29sm619124a91.11.2026.05.20.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:28:59 -0700 (PDT)
Message-ID: <94954f57c4130610ca740f04b49941d04ee498da.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/14] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 20 May 2026 15:28:56 -0700
In-Reply-To: <20260519181314.2731658-8-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-8-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> Helpers and kfuncs independently tracked referenced object metadata (id,
> ref_obj_id) using separate fields in their respective arg_meta structs.
> This led to duplicated logic and inconsistent error handling between the
> two paths.
>=20
> Introduce struct ref_obj_desc to consolidate these fields along with a
> count of how many arguments carry a reference. Add update_ref_obj() to
> populate it from a bpf_reg_state, replacing open-coded assignments in
> check_func_arg(), check_kfunc_args(), and process_iter_arg(). Add
> validate_ref_obj() to check for ambiguous ref_obj before using it.
>=20
> For ref_obj releasing helpers and kfuncs, keep checking it before
> calling update_ref_obj() for now. A later patch will make these
> functions not depending on ref_obj. For other users of ref_obj, move the
> checks to the use locations. For helper, this means moving the checks
> inside helper_multiple_ref_obj_use() to use locations.
> is_acquire_function() is dropped as ref_obj is never used.
>=20
> Pass ref_obj_desc into process_dynptr_func()/mark_stack_slots_dynptr()
> instead of a bare parent_id to make it less confusing.
>=20
> Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: Neg=
ative
> test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> complains about ambiguous ref_obj if it is not used.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
