Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10D2EDD50
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370888; cv=none; b=P704AEUiCBb/WEyrModVQwjItUrs8D8m7PVqSGXyYQ7HYISM7h5QtA0yy6TH814pCm8En8LKKx9wQUop+d8XiCgm7C3qXd8visJ3uWi7CzpTXZatQjr8BoghB2WphQGhzoCmQdpjYLTFd46Gvo3szsXtzw9f+sUGXo+fQ/0NUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370888; c=relaxed/simple;
	bh=Dn5ZMVN2m7Xv0kBeqjJWHzDcNTO+5r7O645fooOQ1RQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbH+lDbEuLwlt4dVDi3lVzoRln7dvXcvb8NEFQynk2DTtZUrZVntPsbUtRvjyNZ4oYcKVOqyX8/v8Adqhglc/LXBybL8R5qXHG+hAX+K1d4+6qYtvS+UJhveoZQSbbt+StG4yjhP28a0Bw9mZFZykYLFMVooFAjKLNBH9rntxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF4x68GA; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF4x68GA"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-127380532eeso11859652c88.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 15:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771370887; x=1771975687; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwIV4WkGKhMjgCj5N1IJGLGYMBOb6c8vJ/cO4wSvJa4=;
        b=EF4x68GAuyaRhS9lsqJcHXL8DtOzum9I7+HJt9Ci/O6lkza9p4uKlG8BiLLW247OSK
         1BbdCPyOXX+oxaL3j41dSKq1FGO0gtztq44gN+zbStyMnF5xl2ncPOzwDRmqPIbfUaH6
         cUAMQ3IEwXJ3N8u3tCTZJxTrduHicmaB5kdCxn9jzKPGZtz5Rqi7oDpxnVBpxwy0bjyI
         UTrxvouM5l9eJZziKBXe3e5ywoP1914Shzsg3WFnup4RG14XkdikX57pF+tbDrzXlH0S
         NJ2+BfjdVPWfrdqCAq/bMW4PKwStXjgFSYv/YsQhXa28qtFpWPxl2ZsMYWAlY3mTTGZz
         KFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771370887; x=1771975687;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwIV4WkGKhMjgCj5N1IJGLGYMBOb6c8vJ/cO4wSvJa4=;
        b=mrYlnCqyBw44hBXx2xIhvFuBNLvuxuSLED0qMW2cX3W2aarvQMJHDaM8ByDrNPH/GE
         XZ9cceb/lbbIkrhtdnUDIHLgbj21PXy4RI/qu+OvzIFdb5jYQFzszfXgIS2QOAaU6ZGd
         2nx+m68pOURqtdXinGaIiTf9JDUUNhGN9390atHsVjSTNjLlAUSj78BRVaZk2AoOtFvg
         eXwkn8AjXOmGBOM8GCFxcxaOqN6JNRUmbpA7sOeSU0RJVdHZOO6TApEsiZ3r6hBCG/x+
         AsmN2TAEUL2v5nXytE7jEpu9KGtrercIu2v3heMc/AS9hA0fiDgXpMobb3zVnyZxfV2S
         wPdw==
X-Forwarded-Encrypted: i=1; AJvYcCXAJGI22Gy52XHbEukP4j2o9uNKHfC4tHuCRHsRiz3QF1uSU4MSRw3t4Gkuc58mEtF0nzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzF7MhMlhO3VRywrJgIk/pTvjNLOA9wt2CNcxuVc0XkKz+8mEN
	fzDITiApXL/L4YutWHF5TmiS4s1Yj4lGCq0fOktpK958V+330iatTh1l
X-Gm-Gg: AZuq6aKWn5UqZw0CxOPVg71qfxQ7jlcsgDNASr5oiI0z5YVuqJIyhSjfm5HtGBaNbJ7
	1gjzfDzf5pABAGmy54kUi3yKEgkW2pXHvXFmeGgjqz6ChHUJPLnVi280sZ3Qjrz7/H9Rc13jLqz
	w995zYIkFbbF/K1L8U8Lz4jfKA9mUmnQAcnlEa9mLOTvqEACCxSBxwWDviy2+2DzPRL7hjSqJ+P
	LIyr+8P1IRmFk4BcpL5cM3E5xbg5QwcNhQ6mlwehPwRKoWpVP7iO6RamhazKtOFniYFzoOWQZ5Z
	ICmXe9cHv+bMEg8Sw2F9LU/3sX0vzrJhTA0TApAB5ErySzdY3zhEEUCo5LFeyItzaeOwHGtc9SN
	B2xnxa1Gw9WXpWFcF9Vts6avu452l/hHXTcPdrhiWwB4Oiu0Sz7poIOq4V5uTLNFV4r8whYXXvb
	WQMuqhqAVpe7AYbk1+QhLHTJrV+I6BaqZ1mvXIdGrTVcDb/GbMCFf4Gqn9fGH61SPep0N49BHuS
	MR6nkk=
X-Received: by 2002:a05:7022:6090:b0:119:e56b:c73e with SMTP id a92af1059eb24-12759a10252mr14417c88.3.1771370886693;
        Tue, 17 Feb 2026 15:28:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ea8a:2651:c8f:99eb? ([2620:10d:c090:500::3:3a6d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6430asm17519980c88.6.2026.02.17.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 15:28:06 -0800 (PST)
Message-ID: <7296fd49e2505e9695781cb8eab726a36ddcc3c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Bump maximum runtime call stack depth
 to 16
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Tue, 17 Feb 2026 15:28:04 -0800
In-Reply-To: <20260210213606.475415-1-emil@etsalapatis.com>
References: <20260210213606.475415-1-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 16:36 -0500, Emil Tsalapatis wrote:

[...]

> @@ -6786,7 +6786,17 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable =3D true;
> =20
> -		frame++;
> +		if (!subprog_is_global(env, sidx))
> +			frame++;

I think that the call to a global subprogram should reset the frame
counter if you want to allow 8 stack frames for each global subprogram.
Meaning that 'frame' has to be tracked in some ret_frame array.

Also, maybe add some test cases?

> +		calldepth++;
> +		/* Total call depth including globals */
> +		if (calldepth >=3D MAX_CALL_DEPTH) {
> +			verbose(env, "total call depth is %d frames, too deep\n",
> +				calldepth);
> +			return -E2BIG;
> +		}
> +
> +		/* Total stack frames in use (globals not included). */
>  		if (frame >=3D MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);

[...]
