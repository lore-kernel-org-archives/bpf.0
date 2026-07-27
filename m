Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B763C457A
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187069; cv=none; b=qdBZXR3v6dVzIJaTbcYOAD3UXet8urFlGwmCsTO9hx2K0+ujmnRCL36QApmsjY19GYGGVZ32dWjyYkZjzsL9r/uX7GwW5yGxUXdRaN8PLR3+Ozmpv8fp3l37akQbU0aWw99KxJ+4zdyXEhpz6a8wS9RJzp2t2kvWIDrY22zc2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187069; c=relaxed/simple;
	bh=yQboYwIUzUTJoWchqFU1Un/OZxnTkghgKq2x67H7NnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0l0qk/vDhTHYYoI8WgUq+cAGJ+AXZoRxmThoh9MqEyjs5u+Dpd9OJ4xzdJr4Bo5YOQUHLXc+jn6MpyhnabZnEtgnQForSjW9rm0zi/tGNPDQI25MAnK83GkqLI5GWzh7T323dlOr32ahjzc9KU31J4dL+O8Ao3CCAGwowTLel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYeXjXGC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYeXjXGC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2558833a91.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187067; x=1785791867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eo4mmaPGoZa8sV+pzSrFNAYjgF8kB/NGQfvxfnLW4Iw=;
        b=dYeXjXGCTnox5WKms2Pxb3lFOvum9lDBjsO/tno0zwDP/3OzXv5iJYOKTCrHC5kqJQ
         pUJlohiC9vF1E1Sa5PvJKn1/i1EajesNFrIwR83Y5X3iZsGvfZ48cqwy/rkP25uagrDK
         Zb1MMPpFXsiJ/QQbSeFxDlyw/VS9xqLudlsJJWDigbj6b42jCxeZ3PQZhffnF2erXiRR
         usXVTxUaA/+xGVIz431AZpQrtgZ/sgrWlZlGLfqnHqclMh4ZdW4ynOiBFFSylL/NZZy3
         7aL0Ge5UwKAxrVetf8fxUqJO6/u/PNl7gh3VbpUhYDzNUd8abiCJc6nZKpGTPDKn04Gm
         AONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187067; x=1785791867;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eo4mmaPGoZa8sV+pzSrFNAYjgF8kB/NGQfvxfnLW4Iw=;
        b=IgnlukP0CoQ+PDjUwdFUidMUNhDGQ397VG+BsZFCG0SvxylyvwSSo0k1LfUiX3qKAi
         E7fb5m7O97dNVHwhk/vC305NrqKXNpn8hMaWcJ3Q2tOvxnr1VIZJPxcZsZYfMVXahz7P
         2K0N2IDHOt19zOwEWxvgP/JdOphl9nKl4Fr6hfzY/Uk8xB3dsZqKR92NMvEwOpkikDFC
         wmF6STxMuRNinWvyKtJfBfHisaeqUEHrX52w8NoeRL3Ad3iLfCtnZoOcHi2Pb2Bac1lp
         tVEF3gtN8+Ujo6CQGBzXbuTdEKEpO0pt3i9p8Mm69w/NjRmxsp0OGShPNKguCpy0H+X6
         QPqA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9noq0arvwGQCYbT2u0H0E+MHZk+vcQx8XvyDBqmgM7J2hR1YOf04E+IlmLyqV194qB6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwTAzNvQ9GV3uC/tboFj7zCRkvYXcGNny7TSLe1od7OkXCYab
	4Yo88E9q5qAhElfJYivjcOpWaIjW55j7oItIQ9J/9Kaw+XQmJzx9xGj4
X-Gm-Gg: AR+sD11GWgbNBakyNz6IfnwOdjBy9TMRD3vqTUB0RDonkNjxCef0jTOPXkDI7ySJUQb
	AY+Ww4aJDoFXHqkGOYhqGwOXVs1blG3+XLE+uBsB7sGabgrueqrE/NfB3zl4pJhO/93dub2viUT
	TSG95gjJgUCn6gmO1M9ZWdxzv0ckSCzdJYd84YFwI6qcdsGzYGoIs64MMae7wCuDjj2dKFRX6HS
	git8HM8wsvsnyLS2fvnfNOkm6+wHEkLx7fDQIYy1QvUR/a+HnUEAvE3lOt/5+IkAFGy3cyQLexe
	hPHwJ7nf2r+v5xBj3c0nEvhmRnYCxBAYkG+FVOG2HF4XQek7hvSrjCf4lwPC/U4JkkivheaEcy1
	tuYAx2i00TDyLpidPhT6TyFUG5rA9JeO2dJnLh1NvxWViWsCaU6OZsLXrUXaVW3KkUKJIizHdwh
	yGcZ6aGKaRffEj/rYEPOQj4UCzgaREng==
X-Received: by 2002:a17:90a:d00f:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-38f293cf348mr8344259a91.5.1785187067544;
        Mon, 27 Jul 2026 14:17:47 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64130e0dsm344276a91.8.2026.07.27.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:17:46 -0700 (PDT)
Message-ID: <4b93853207b6b02761af2fc75222ab8b349d7157.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 14:17:44 -0700
In-Reply-To: <20260724190813.1458271-8-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-8-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:

...

> @@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
> =C2=A0		mark_ptr_not_null_reg(reg);
> =C2=A0	}
> =C2=A0
> -	int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem_size =
: mem_size;
> +	size =3D (!helper && base_type(reg->type) =3D=3D PTR_TO_STACK) ? -(int)=
mem_size : mem_size;
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^
When is this negation necessary?
Is there a way to get rid of it?

> =C2=A0
> -	err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, true, =
meta);
> -	err =3D err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE=
, true, meta);
> +	if (access_type & BPF_READ)
> +		err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, true,=
 meta);
> +	if (!err && (access_type & BPF_WRITE))
> +		err =3D check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true=
, meta);
> =C2=A0
> =C2=A0	if (may_be_null)
> =C2=A0		*reg =3D saved_reg;

...
