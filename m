Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501483B388F
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919070; cv=none; b=Dlb9U0K0l+dPrhkIRMLr//fn0xMmJ9e1aG6ifedafm4QZ5ArzKnwiSichPRBA2SOcqje33SaOCNU6GnfNWWfLlxIXjXJjXVX0wmdrnQQHO/rtgrIxWNWNJqyxQ713GJnJSPb0f486zAc3vX4JIIz5MOpiDw4rAnt0h1nValq7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919070; c=relaxed/simple;
	bh=eDLogBUvFwYbaRby1lnxNHS/ZocfM++nYg1/wMJwv2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5sgJicVOdqih0yqvwRYoQQMtFJ3FkDeiIpuIFDEVSfqxX25tv7kNIj9o3eEDZssDlcqQxzoIVQvqPvvFkEkpjJ+7xTbKgBHECc+/Tq6N59Zwni+rba27XMgzySjkbwtV2PG7XDR/VVyu1IV0y9TmbyNBM5sj9z4Nab16DjlRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAJSXmKp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAJSXmKp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1435989a12.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786919069; x=1787523869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eDLogBUvFwYbaRby1lnxNHS/ZocfM++nYg1/wMJwv2k=;
        b=XAJSXmKpRNNGdZvjHaOqUL1E0s09TKjVtEypGPwURqT7CUp2dlpEJU45kW/FqSwSs0
         IeouU+xalztbPzVEDuiMF0M1UP24rtuBpj5Q0VGk1UO38gW0PhrdcTkwE/G0+TvaEzEU
         T/w+dKYUkASTLKvTEfNC2KN+YMP/w+4WqVkAmGfSTGBzYPZ30/SCtV/8+h8/xUZIdofF
         bKeoYKFpz02j6KUC/zdv993zUR44jaKTnHsZVM9CrfD7zGeTGspWDTOpM2aA2CREfHf1
         YKfExJmjVIdk4HE9VvbqssMK45gT8/AxZVcEE+wi9zOGfjVb3cDsnNydS0aTKTuNAu7K
         NqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786919069; x=1787523869;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDLogBUvFwYbaRby1lnxNHS/ZocfM++nYg1/wMJwv2k=;
        b=RWXYLM686RTHOWK4lHfjAGKCcIWyKGFehhEwCl926YjtSTfIfiWQoFc5ESUXuNxG7L
         yBfP1kWwY1orOaxzxpsnhsRrIpYvLLbM+Wi2Bg7Sb4vWtM33xjl9v+eD7CW0XwHwt1LS
         TM5Mus7rUpm9/twh0nH0gorIP2RjQaSmQAy7bx2JBC67gT54XL2txLhlBw8NvOxA3Yxq
         +gxq8oPw71HTIdb1NawMhDZ52HTJ48tZufgBHPfM43CBHdlnFBsK+pstmfCID/K3Hr0m
         dHyIWk0irB228mTwvMq1bGz5nHiBkJZg2Bd+qbNnWOZYX2RkmzBxbfn5xpmS+PTk2vGb
         GoYA==
X-Forwarded-Encrypted: i=1; AHgh+RqPx6EC20si2e40Xpi+NWCAUtLq4szzmHKGsSLm868mh+uns6f8ClMsFRCMrPlb+a7+FMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWaYzZOFZayBbSWfWkyghGwmDEfkOOwAO+lT3Cz1tHh03iD55
	Yr6+Tt2gyc1J9rkDLLIYaX1IQx9hivVgR8N8qSePCFYKI3X9+3Wlyo058xVyRw==
X-Gm-Gg: AR+sD127IW3RbJtocG32DiKQLFZJoaAGZcPxDXGRTV2BY7ZQQAR/4Ut1RpY/iVTUiiN
	wj1X722ct7GkR4sqkMZW3a5t15AFIjJQfM5zQvpw3sBvvqHH2YM+fJKSKYpCbH7GsoVoOqqx2NN
	aL4srF6B7bbslY64jTZFLT2EBQnlEw8034WhMkjQ27jRwY7aDt3syG3cWyaLeAstHCtHKlWmc1O
	fJMHWJGozhwGNTereUpZIKNjgDxsI2sX77kotjkffodIcZPPDPWzLIZ9B89otrzv67MdbjtM/GV
	cgy/eKyK5lkF1IRffTPyIa5dIK1t2kRktOxwCto43vWlHwZ1DNhpBQY3UWND9XBtd92G3XRwoZi
	mCV3kbtaRDlllscgmsXhrk/sSO3wK5trvd1hbal3O3Cn9zzXl2u28xyAARgemc5nK+qjw9s+SjO
	nbJB6pKzFqv1EYvZHZxNnXk2/GH8bxxVn3j/FZZ4MtJvStFs4LwVym0WT/edvc42c4OC+B25qNZ
	6rsUxOPNmBuCSny
X-Received: by 2002:a05:6a00:8c2:b0:842:6a3b:60d8 with SMTP id d2e1a72fcca58-84fde78af05mr19400740b3a.30.1786919068441;
        Sun, 16 Aug 2026 15:24:28 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2487e1sm1959380b3a.41.2026.08.16.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:24:27 -0700 (PDT)
Message-ID: <99df26bd743e221a9b2d260546d30d73e5b80405.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer
 type merge at a shared load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 15:24:24 -0700
In-Reply-To: <20260814215301.709827-5-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-5-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> Cover the ways in which the type recorded for a shared load used to lose
> the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
> handled properly.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t mem_rdonly_untrusted
> =C2=A0 [...]
> =C2=A0 #238/1=C2=A0=C2=A0 mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
> =C2=A0 #238/2=C2=A0=C2=A0 mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
> =C2=A0 #238/3=C2=A0=C2=A0 mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
> =C2=A0 #238/4=C2=A0=C2=A0 mem_rdonly_untrusted/offset_not_tracked:OK
> =C2=A0 #238/5=C2=A0=C2=A0 mem_rdonly_untrusted/stx_not_ok:OK
> =C2=A0 #238/6=C2=A0=C2=A0 mem_rdonly_untrusted/atomic_not_ok:OK
> =C2=A0 #238/7=C2=A0=C2=A0 mem_rdonly_untrusted/atomic_rmw_not_ok:OK
> =C2=A0 #238/8=C2=A0=C2=A0 mem_rdonly_untrusted/kfunc_param_not_ok:OK
> =C2=A0 #238/9=C2=A0=C2=A0 mem_rdonly_untrusted/mixed_mem_type:OK
> =C2=A0 #238/10=C2=A0 mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type=
:OK
> =C2=A0 #238/11=C2=A0 mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
> =C2=A0 #238/12=C2=A0 mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
> =C2=A0 #238/13=C2=A0 mem_rdonly_untrusted/mixed_mem_mem_type:OK
> =C2=A0 #238/14=C2=A0 mem_rdonly_untrusted/mixed_map_value_mem_type:OK
> =C2=A0 #238/15=C2=A0 mem_rdonly_untrusted/mixed_stack_mem_type:OK
> =C2=A0 #238/16=C2=A0 mem_rdonly_untrusted/diff_size_access:OK
> =C2=A0 #238/17=C2=A0 mem_rdonly_untrusted/misaligned_access:OK
> =C2=A0 #238/18=C2=A0 mem_rdonly_untrusted/null_check:OK
> =C2=A0 #238/19=C2=A0 mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
> =C2=A0 #238/20=C2=A0 mem_rdonly_untrusted/helper_param_not_ok:OK
> =C2=A0 #238=C2=A0=C2=A0=C2=A0=C2=A0 mem_rdonly_untrusted:OK
> =C2=A0 Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
