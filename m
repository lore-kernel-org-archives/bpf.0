Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA61F418F
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286553; cv=none; b=GPAJnNQvKLtBwk91/UydtTmNFQx1lXL2ATLJHSq+SArQ1ZsL6pCAyF93QjGWIUMj/kOzDX7uQzt9QpdKlF4j+p+06CEZkPMRuiwg4jvPNBeODXJCTBVs/cBN1kyu/GQuASOe0dyNXlV8qPkRB4gltVarXPpfcRb8ilxNfbMWcmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286553; c=relaxed/simple;
	bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuDC9IBf9jAYHpeysAUfhvFjG8+21eKhRruH/DK/mMJePU/HfsOXrcXaWVgIqR/Ychtc3HwLAkiZ3JgJxaSLCk7UiThAOjJOXfFhJeeb1wU63YwIBSFJ1BnlUDP0cYABv7P50fqvsI/YY5DUNTU05nokxT9hJCEuvJXbIVIm5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdNwPieU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdNwPieU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so215361a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286551; x=1785891351; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
        b=QdNwPieUiv4lmAYiQSjTNAWXQ8qPiCkpVSnrlVOYNk5n8dAK7+p17cMFdXdE9p7u1P
         3mWe50L+Adga4zZhOF9yqTrtN0Ee0Vs8ezhcqBa5uDMXlJdPCbGaSYjNEShKGxE/gThy
         Sg9zIj9bbnuekA/RbAa8/hU0JHwYMP3AyeD11nWI2A3/s4SOsRiPNiAlCWR5GHMOW9lS
         2LN6/u4FNCQ1P2u84rwfiGnw48UWauYDZQJMId1xvBkMnoXal7YR6+p67zsln2J7WMjE
         nfWacolv79ER1+qTjSS9y2vAmrYe7EpspXUP1NssglRgJQJdkI8hhz2uvTBGzIVsdUz7
         BoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286551; x=1785891351;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
        b=LO7kjKdBPLeYNw0SoR4/P3ytvmBQ1ugZUDTUzeoPxxa83d+JBQkRv7upuNwhXuArng
         6iGhgnASzsZtvleXxvyrWaaW3WQeYUmGSSU2reN9lxXat8O1cEGu+azu0IaTz5MmAkS3
         3XgQhsMZ7VaITP1YksDQD+gNyLXmiBqxKVeZbFav3ffJvTtDIPtXe1yz2BuARHOkWh+3
         61KhRkCgcFDOe8vGufYSk+WYDbLCGb4TKCqMfZbT0LEPI7QGuKXFSAQ2m4p69YzV0Dt5
         cs5z2MUHvlNlIaod3UiSam19A9uYqnhBZq49cURCDuWFCIIV4z+VlAlxRug+oYlHHq2U
         rZxg==
X-Forwarded-Encrypted: i=1; AHgh+Rpqw7mwBJhee6338EdmRO/aCRRpmF7yWAahqcfL/ac4vllYeHzxltsp3I+U2sWv0oLrlYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgN11HW/GSKKJyzSfaHSLADvE59k7wP4HSbtBG9CzgfmgubHb
	VpLukq+0Z2MStNaLvo0WuAr+06sD75vfQfiMd817WeYPuJtl8APX4Oet
X-Gm-Gg: AR+sD13Z9DUEbVQTTgZrlykgvVK6iJQe5wkWZKXUi3XHIKkZojLRFnNQa2eGy0MDTPO
	aQJiNZOwNT2ZcJ+ylK4PvVAY/0bt6SmXz8XRtPN8lBhp47AKeVwTgZgT+EsVrf2CjGG+2eUmNwW
	D672Y+1xwa+9UtiHi+DLW96cwbCHTR025P15xZdv+KSlt8wBZJWK0BQw3OgJmM6efi/d+9Gdb10
	qEpHu0ENk1SBEL7VAkJvdBtyrSVh44foTIi+DXfNe4JdEyHeM9Q/tdfazhNna05c+zfdm4HEF8j
	+K5KlhJEX93dYIiNI5rvuRlRMSJZyppDVCzp9giINjRgpQKB+Bl3+w6iuYT69sf3WIeSV0/6ijI
	cqqqDoKzAPO+bv7hs9OoUpc49gM+CnnL16badt0CkYu3ZL2cmb13q16S4fqlN0f7OwJgjFOrEzS
	jhKonQ5o6sydWSaW6yygTSvBu1h3/tZT1EMtonxQ1Mg/DWcSmAjpJKsG0BNSB5e4w3W0gVWBMvA
	19MxLnSawAk/NxGyOuGmtKPaUAR9zYFTke2x0A9IkR/sg==
X-Received: by 2002:a05:6a21:6e91:b0:3bf:6c07:b2f0 with SMTP id adf61e73a8af0-3c8ba6132f8mr5806787637.51.1785286551493;
        Tue, 28 Jul 2026 17:55:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm5610706eec.22.2026.07.28.17.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:55:51 -0700 (PDT)
Message-ID: <b4a41c7b549bb96af669bf56a89da6f4a7e6e7d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] resolve_btfids: Fix the _impl lookup
 for module BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:55:49 -0700
In-Reply-To: <20260722233518.778854-6-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> process_kfunc_with_implicit_args() skips generating <name>_impl
> function when one already exists for backwards compatibility.
>=20
> It uses btf__find_by_name_kind(), which searches the base BTF before
> the split BTF. When resolve_btfids processes a module, a same-named
> _impl in vmlinux would be found and the module's own counterpart would
> not be created.
>=20
> Fix by using btf__find_by_name_kind_own() for the lookup.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
