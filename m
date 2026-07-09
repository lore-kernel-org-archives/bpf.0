Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F361D5160
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636062; cv=none; b=odXiev89ko43w1bi0goykYPpJ1bl+ZiZv98hlvvXkuITyzZ09jlUrpHuu7tCm02D6GQCPmFyEASqGfZjyeDhxu1vBfXcDkGZE0DgBUDHq4T8HIdiBaKlXZCm5vBzkJguiK/PyxSRQD18hX+EhKMZ9vZXQiKmFUnilTeSEPhEGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636062; c=relaxed/simple;
	bh=jQgpQTUHCQ9bQ3cOZgehCFwrBFnXHAKQ0fxmSz3qPLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/vvwYgLnILHLyhu9OT19tblLx+LTy6rbl74TbmYfHew9JMnkfZ9tXGyU6NRkFr5pl9fACfi5ElZtLsaY+qvZKxExbyJCuNciWoULa4EX/1ST+FlAHz520miQZfBSrW0HDSE2isOuPukDgkuReLauez0onZzFbqUGn77IbkSPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/uqS2e5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/uqS2e5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so4217455ad.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783636061; x=1784240861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wKxXdOTpiYi7Cf8pfKD1AsF9D9BGTQXH06cCCSpGd7E=;
        b=T/uqS2e5KtsAV2V3jn0/AN32qPRgfVBZd0+CON7ipXlYLZGk+kJxakNrWzrdw8q9VE
         ZNP7BDaEKMboTqUEbm5Gj7VyJvuGTRb6oKROTBsbPQNc0hYfisFzGvMhGVL5M+sIV0ol
         gukyT3NDPke3CFeDRAl8GfWS/PTy0TDLSa4avkgz/eQrW34eV4zEl1BZBzrd4iCqrZbJ
         bdTVfc2/BJWRVhwLu/oFLkKhU2KEUbGHBJJ8FKSQJ2jAoMw6REh6aXpuTFvzLhxeT/U4
         8VrDqvBDCeU09XGMdAZurDx/q0tT5jRHtSlOO9ZH62IraYj8q4XEy3fIMWo9dkQ9iXqM
         AiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636061; x=1784240861;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKxXdOTpiYi7Cf8pfKD1AsF9D9BGTQXH06cCCSpGd7E=;
        b=FTeFdlCc3YZ6dy1/Uu0diV1uNVAsNpiaJ7/VNx4bLs18jpGBqdJefOTKE8AtwyRoGh
         aOWSuBjOG23hElqU2FwOIEgRwOjsZEutwDPxbiBkmjfAk/T8i3UnC2BpwoRIsH0FLYVq
         y2T6UmaJNZOi1chkxBW2EYqdAt+PMp+i0o/aVBBGLFJvUMJaqcFuahKEX2noMoK8TDym
         Izlph5KomxG4dPKwHXbyuulsH1SF0+Ayk1z6FjEebTEj1Ey+sNIG6XCV7U1LRRoTNrVn
         jHZQPbXTyM3UsvyJnHC9v3iSMZm4q0T8bhDv2IXaWTlJ2aubUSz5iqm03YAJo7UOwOxh
         gHGA==
X-Forwarded-Encrypted: i=1; AHgh+RrFp3zoDf5xiRoV6RK3WYV9akDJebLYrtZY4sxS+tqUjAczAII9i+3HHMpBiXEWWKyRqSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09lfM2FTC5D5pP33LAVRUJTmRKoJwpz5RUBljunCXlAGCNlyF
	3hsGse9cioklej68hMcg7znK0OsNIymTU5lHLhYE7ibD5xysvuFLQ1pR3GXOFQ==
X-Gm-Gg: AfdE7cljwQSHtjnxb0gCdECWUhKrc0iesOsISYer72wOBJvrBdss6qosPHSmTbm0agI
	8rQsLCkvqD//yfXrMkHLK0R+NbI37HHCFxlfWiptg0U+url3Fk9Z0/wgBYyZY6gypn9nq6w+JGU
	2oRcyhhe1OZ7maU1TTQYAuHKt6xqzUtISyInLs5OG4xqr2qHBmdY1aaRr0V8FA5yZi0llQp5aSl
	/4WL2dGjlEiBRRfAHbzO/Cz5Xo24M1hgKzQ9solNtAgEUpNmijkpdgnXfxMK9f5q/l5so1siGnJ
	AdWz3NEb/ULgAuMvMnRtzW5+jWopSCu+d3tT2vwlg5Bmw3AXWrhlRz7hToBvW3XiwCnhk9P6LBk
	XLOjxQKFVYsOmuyKTBOY2HHTfXAoxfWCUhPEtfKtdTOkGYu1MgULOYnFUcaHrJ2m84OwWJoLOJE
	pI4TKc+9UTsg0c6sNAtuvFXZ0yuxplxG1AhD+F/myH
X-Received: by 2002:a17:903:1ad0:b0:2cc:307c:51f2 with SMTP id d9443c01a7336-2ccea444eaamr105267135ad.22.1783636061022;
        Thu, 09 Jul 2026 15:27:41 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm49868005ad.19.2026.07.09.15.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:27:40 -0700 (PDT)
Message-ID: <cdff0944003193d4224a1fec5f1fb9fa8bd76801.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the
 R0:R2 register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 15:27:37 -0700
In-Reply-To: <20260708201010.2158718-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201010.2158718-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:

[...]

> @@ -9877,7 +9886,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
> =C2=A0	} else {
> =C2=A0		/* return to the caller whatever r0 had in the callee */
> =C2=A0		caller->regs[BPF_REG_0] =3D *r0;
> -		if (bpf_ret_reg_pair(env, callee->subprogno)) {
> +		if (bpf_ret_reg_pair_mark(env, callee->subprogno)) {

Also, doing this while processing exit is a bit strange.
I think this should be done in do_check_common().

> =C2=A0			if (callee->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK) {
> =C2=A0				verbose(env, "cannot return stack pointer to the caller\n");
> =C2=A0				return -EINVAL;

[...]
